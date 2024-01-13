"use strict";var b=Object.defineProperty;var z=Object.getOwnPropertyDescriptor;var O=Object.getOwnPropertyNames;var _=Object.prototype.hasOwnProperty;var G=(e,o)=>{for(var n in o)b(e,n,{get:o[n],enumerable:!0})},K=(e,o,n,t)=>{if(o&&typeof o=="object"||typeof o=="function")for(let s of O(o))!_.call(e,s)&&s!==n&&b(e,s,{get:()=>o[s],enumerable:!(t=z(o,s))||t.enumerable});return e};var M=e=>K(b({},"__esModule",{value:!0}),e);var q={};G(q,{default:()=>W});module.exports=M(q);var A=require("react"),l=require("@raycast/api");var i=require("@raycast/api"),v=require("@raycast/api"),h=require("react");var $=require("child_process");function P(e){let o=`${e}/Contents/Info.plist`,n=["CFBundleIconFile","CFBundleIconName"],t=null;for(let p of n)try{t=(0,$.execSync)(["plutil","-extract",p,"raw",'"'+o+'"'].join(" ")).toString().trim();break}catch{continue}if(!t)return"";t.endsWith(".icns")||(t=`${t}.icns`);let s=`${e}/Contents/Resources/${t}`;return console.log(s),s}var g=require("react/jsx-runtime"),V=["net.kovidgoyal.kitty","org.alacritty","com.googlecode.iterm2","com.apple.Terminal","dev.warp.Warp-Stable","com.github.wez.wezterm"],k=({setIsTerminalSetup:e})=>{let[o,n]=(0,h.useState)(),[t,s]=(0,h.useState)(!0),{pop:p}=(0,i.useNavigation)();return(0,h.useEffect)(()=>{(async()=>{s(!0);let r=(await(0,i.getApplications)()).filter(c=>V.includes(c.bundleId||""));n(r),s(!1)})()},[]),(0,g.jsxs)(i.Form,{enableDrafts:!0,isLoading:t,navigationTitle:"Select Terminal App",actions:(0,g.jsx)(i.ActionPanel,{children:(0,g.jsx)(i.Action.SubmitForm,{title:"Submit Terminal App Name",onSubmit:async r=>{v.LocalStorage.setItem("terminalAppBundleId",r.terminalAppBundleId);let c=await(0,i.showToast)({style:i.Toast.Style.Animated,title:"Setup Terminal"});c.style=i.Toast.Style.Success,c.message=`Terminal ${r.terminalAppBundleId} is setup successfully for tmux sessioner`,e&&e(!0),p()}})}),children:[(0,g.jsx)(i.Form.Description,{text:"Choose your default terminal App"}),(0,g.jsx)(i.Form.Description,{text:"When switch to session, it will open the session in the selected terminal app."}),(0,g.jsx)(i.Form.Dropdown,{id:"terminalAppBundleId",isLoading:t,children:o?.map((r,c)=>(0,g.jsx)(i.Form.Dropdown.Item,{value:r.bundleId||"",title:r.name,icon:P(r.path)},c))})]})};var a=require("@raycast/api"),F=require("react");var w=require("child_process");var x=Object.assign({},process.env,{PATH:"/usr/local/bin:/usr/bin:/opt/homebrew/bin"});var S=require("@raycast/api");var y=require("@raycast/api"),D=require("child_process");async function E(e){let o=await y.LocalStorage.getItem("terminalAppBundleId"),n=await(0,y.showToast)({style:y.Toast.Style.Animated,title:"Checking terminal App setup"});return o?(n.hide(),e(!0),!0):(n.style=y.Toast.Style.Failure,n.title="No default terminal setup for tmux sessioner",e(!1),!1)}async function C(){let e=await y.LocalStorage.getItem("terminalAppBundleId");(0,D.execSync)(`open -b ${e}`)}function I(e){return(0,w.exec)("tmux list-sessions | awk '{print $1}' | sed 's/://'",{env:x},e)}function N(e,o,n){return(0,w.exec)(`tmux rename-session -t ${e} ${o}`,{env:x},n)}async function L(e,o){let n=await(0,S.showToast)({style:S.Toast.Style.Animated,title:""});o(!0),(0,w.exec)(`tmux switch -t ${e}`,{env:x},async(t,s,p)=>{if(t||p){console.error(`exec error: ${t||p}`),n.style=S.Toast.Style.Failure,n.title="No tmux client found \u{1F622}",n.message=t?t.message:p,o(!1);return}try{await C(),n.style=S.Toast.Style.Success,n.title=`Switched to session ${e}`,await(0,S.showHUD)(`Switched to session ${e}`),o(!1)}catch{n.style=S.Toast.Style.Failure,n.title="Terminal not supported \u{1F622}",o(!1)}})}async function B(e,o,n){o(!0);let t=await(0,S.showToast)({style:S.Toast.Style.Animated,title:""});(0,w.exec)(`tmux kill-session -t ${e}`,{env:x},(s,p,r)=>{if(s||r){console.error(`exec error: ${s||r}`),t.style=S.Toast.Style.Failure,t.title="Something went wrong \u{1F622}",t.message=s?s.message:r,o(!1);return}t.style=S.Toast.Style.Success,t.title=`Deleted session ${e}`,n(),o(!1)})}var T=require("react/jsx-runtime"),R=({session:e,callback:o})=>{let[n,t]=(0,F.useState)(!1),[s,p]=(0,F.useState)(""),{pop:r}=(0,a.useNavigation)();return(0,T.jsx)(a.Form,{isLoading:n,navigationTitle:"Rename Tmux Session",actions:(0,T.jsx)(a.ActionPanel,{children:(0,T.jsx)(a.Action.SubmitForm,{title:"Rename Session",onSubmit:async c=>{let m=c.renamedSession;t(!0);let d=await(0,a.showToast)({style:a.Toast.Style.Animated,title:""});if(m===e){d.style=a.Toast.Style.Failure,d.message="Session name is not changed",t(!1);return}N(e,m,(f,H,U)=>{if(f||U){console.error(`exec error: ${f}`),t(!1),d.style=a.Toast.Style.Failure,d.message="Failed to rename session";return}d.style=a.Toast.Style.Success,d.style=a.Toast.Style.Success,d.message=`Session has been renamed to ${m}`,t(!1),o&&o(),r()})}})}),children:(0,T.jsx)(a.Form.TextField,{title:"Renamed Session",id:"renamedSession",error:s,defaultValue:e,onChange:c=>{!c||c.length===0||c===e||I((m,d,f)=>{(m||f)&&(console.error(`exec error: ${m}`),t(!1)),d.trim().split(`
`).includes(c)?p("Session name already exists, you can not rename to"):p("")})}})})};var u=require("react/jsx-runtime");function W(){let[e,o]=(0,A.useState)([]),[n,t]=(0,A.useState)(!0),[s,p]=(0,A.useState)(!1),{push:r}=(0,l.useNavigation)(),c=()=>{I((m,d)=>{if(m){console.error(`exec error: ${m}`),t(!1);return}let f=d.trim().split(`
`);f?.length>0&&o(f),t(!1)})};return(0,A.useEffect)(()=>{(async()=>{if(t(!0),!await E(p)){t(!1);return}})()},[]),(0,A.useEffect)(()=>{s&&(t(!0),c())},[s]),(0,u.jsxs)(u.Fragment,{children:[(0,u.jsx)(l.List,{isLoading:n,children:e.map((m,d)=>(0,u.jsx)(l.List.Item,{icon:l.Icon.Terminal,title:m,actions:(0,u.jsxs)(l.ActionPanel,{children:[(0,u.jsx)(l.Action,{title:"Switch to Selected Session",onAction:()=>L(m,t)}),(0,u.jsx)(l.Action,{title:"Delete This Session",onAction:()=>B(m,t,()=>o(e.filter(f=>f!==m))),shortcut:{modifiers:["cmd"],key:"d"}}),(0,u.jsx)(l.Action,{title:"Rename This Session",onAction:()=>{r((0,u.jsx)(R,{session:m,callback:()=>c()}))},shortcut:{modifiers:["cmd"],key:"r"}})]})},d))}),!s&&!n&&(0,u.jsx)(l.Detail,{markdown:"**Setup Default Terminal App Before Usage** `Go to Actions or using Cmd + k`",actions:(0,u.jsx)(l.ActionPanel,{children:(0,u.jsx)(l.Action.Push,{title:"Setup Here",target:(0,u.jsx)(k,{setIsTerminalSetup:p})})})})]})}