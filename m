Return-Path: <netdev+bounces-13826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 715FB73D1DE
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 17:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9854A1C20900
	for <lists+netdev@lfdr.de>; Sun, 25 Jun 2023 15:54:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D5D26AB5;
	Sun, 25 Jun 2023 15:54:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA75E6108
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 15:54:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32B13C433C0
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 15:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687708464;
	bh=POVG0/gK95VboMzm8jWtcYjvv3pOv85q25ok8+NXfrw=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=ctYnVvgwgF9kS9Z69ZMC2FVT42LVqLN0TlOfajVWUq3gawyfxKyrpaCo/xe5KCb/4
	 oEVnWXmIpnGSdemZ/otUdklm1UrRPSKMuWytxs83Zoy/s+jI0QQx3JPj6cAfTcZcbQ
	 QDanEGfJw2nhquN4CebN7dnAMdlvPh/BwPSN2G4dxXe0JA8ShFtpGmQ+EBPSaZVPEj
	 RWFlmfc0EbOAbxQBWLeEHobvaHiM7Yes5wN6ePi/6n1Izu0Yk6LAlatWfVVJ2DW3qR
	 7FvoqzV54VDoXNUrMsywlFPXcLma7K05D2c5a+FoM+Af0nZ1QzsNT8UxgVAGufCW1g
	 BXudviXtp4eZQ==
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-c1aad78d5b2so1006579276.0
        for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 08:54:24 -0700 (PDT)
X-Gm-Message-State: AC+VfDwqD0sxa3JohH4v3To7O4j5FBw6MuJFf5iC+7jt1tcm+Op2EUvl
	K3PS2fNbPpRyWtQEtXZFUrJe4cNORcONfD4Gqew=
X-Google-Smtp-Source: ACHHUZ55IDTQLwH3O2zBCaiQIvUCNjXtnSJbD76QsvPCpPm52HlT0fAq1ONMyA1dNXWl4+NrEmujter7QxM/3ApyB0U=
X-Received: by 2002:a25:4004:0:b0:bd4:e2ff:c83e with SMTP id
 n4-20020a254004000000b00bd4e2ffc83emr29702144yba.22.1687708463053; Sun, 25
 Jun 2023 08:54:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230620175731.4146007-1-anthony.l.nguyen@intel.com>
In-Reply-To: <20230620175731.4146007-1-anthony.l.nguyen@intel.com>
From: Josh Boyer <jwboyer@kernel.org>
Date: Sun, 25 Jun 2023 11:54:11 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7f4YiMzQ5Z6v8ratR38k10VgLo7ZNS7u8_3C6h5LmYyA@mail.gmail.com>
Message-ID: <CA+5PVA7f4YiMzQ5Z6v8ratR38k10VgLo7ZNS7u8_3C6h5LmYyA@mail.gmail.com>
Subject: Re: [linux-firmware v1][pull request] ice: update ice DDP
 wireless_edge package to 1.3.10.0
To: Tony Nguyen <anthony.l.nguyen@intel.com>
List-Id: <linux-firmware.lore.kernel.org>
Cc: linux-firmware@kernel.org, Shekhar Deb <shekhar.deb@intel.com>, 
	netdev@vger.kernel.org, 
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 20, 2023 at 2:02=E2=80=AFPM Tony Nguyen <anthony.l.nguyen@intel=
.com> wrote:
>
> From: Shekhar Deb <shekhar.deb@intel.com>
>
> Update ice DDP wireless_edge package file to the latest version: 1.3.10.0
>
> Highlight of changes since 1.3.7.0:
>
> - Provide Separate IP Fragment Packet Type Groups for Receive Side Scalin=
g (RSS)
> - Add support to allow Receive Side Scaling (RSS) and Flow Director (FD) =
on Multicast packets
>
> Signed-off-by: Shekhar Deb <shekhar.deb@intel.com>
> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A =
Contingent worker at Intel)
> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> ---
> The following are changes since commit 045b2136a61968e7984caeae857a326150=
bfe851:
>   amdgpu: update DMCUB to v0.0.172.0 for various AMDGPU ASICs
> and are available in the git repository at:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/firmware dev-queue
>
>  WHENCE                                        |   2 +-
>  ...7.0.pkg =3D> ice_wireless_edge-1.3.10.0.pkg} | Bin 717176 -> 725428 b=
ytes
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename intel/ice/ddp-wireless_edge/{ice_wireless_edge-1.3.7.0.pkg =3D> i=
ce_wireless_edge-1.3.10.0.pkg} (77%)

Applied and pushed out.

josh

>
> diff --git a/WHENCE b/WHENCE
> index ed9ac486f7cb..877c2d6e8314 100644
> --- a/WHENCE
> +++ b/WHENCE
> @@ -5830,7 +5830,7 @@ Link: intel/ice/ddp/ice.pkg -> ice-1.3.30.0.pkg
>  License: Redistributable. See LICENSE.ice for details
>
>  File: intel/ice/ddp-comms/ice_comms-1.3.40.0.pkg
> -File: intel/ice/ddp-wireless_edge/ice_wireless_edge-1.3.7.0.pkg
> +File: intel/ice/ddp-wireless_edge/ice_wireless_edge-1.3.10.0.pkg
>
>  License: Redistributable. See LICENSE.ice_enhanced for details
>
> diff --git a/intel/ice/ddp-wireless_edge/ice_wireless_edge-1.3.7.0.pkg b/=
intel/ice/ddp-wireless_edge/ice_wireless_edge-1.3.10.0.pkg
> similarity index 77%
> rename from intel/ice/ddp-wireless_edge/ice_wireless_edge-1.3.7.0.pkg
> rename to intel/ice/ddp-wireless_edge/ice_wireless_edge-1.3.10.0.pkg
> index e65f491b69c42cd670e9bdc611952e02f755e670..535433ddab1d4c82f4ce87414=
1368030f5cc0509 100644
> GIT binary patch
> delta 29556
> zcmeHw2V4}__W!-Rv+T^$dl7IcBE2^e6%a)d5CkhhDT1P60TB_=3DU5Y4n1ieO$iVX|)
> zvKACfH0Jq?B~jy3RLDy)FR_rOqH+G`?y&oknCIv7^8WGne!sAO;GFOIo_p?@Gk50B
> zo!P-BpL!hH?AZ+?ge34|3qRA~=3DPLX}`yo`)E~~cm!LsU@awor_AQ|GZ5kk~^nlD1h
> z6UI-;D43C-El<uKKRJ6!LCt<YQ+>*cJAdYoYEQ8bk%x(yng}cx>q)*ixYlnnR&4z6
> ztL+EK-8R)5zNdFiZ}&bt(%NVLe*4R{0mo*pwXYtY8l8N~uw>`eDrJ7J_g$Z#-SJ}D
> znL9U*EZCv<w<9qdYIK!(N%?w#sV{;?29NMhubFsr=3DF)kkpY^!2zLl@peKII{!@Pii
> z%9OvS=3Dna3dci#`<xD{tjJPMvwNA+(W`q3A=3DKU56<&?jsC{4dQe=3D!o1pPObbbruqEc
> zDbL>Ad*-j{13Z5?I`3*w#-`6bFGSvTJDC#l^`!83E7RZFv~%p)qqZ*=3DdPd(Gbg8xc
> z+|tYg7Y<x4jGH?o<l3GGJHm9HY*RQrn|eOBHE8I9qwlQ_ZmAsi`Pj?(SLWY;V6vs7
> zuJORI2K$}E-U{Gn__ta^g?{nL-1vF6`EK*giaxD<dJniU<b&x~PgL65+(@54Iom#C
> z`8%|dxvJJP+-kiVB@<o~VQi$Zp0;SxLBsrx3zrO-ytEaY`u*hY7}v3D&>dfwQ1j_)
> z8cul{Z1{?QH}o$iOKJ^|8|Za>dhOgNYtEeOe{<Cc`)Zy0t9qTc+}5*Uk*qa|Jezhr
> z-gtaB*2LtH-Rc|Cb<Y17a450jLjR3}Q=3DglEe`rbWftwHC8@see!}swu9zzV4q&C+(
> zykUBIfBD1*E5puk!K<xwden|NU#rMEsOP=3D4hbTE@?1qkmkBm3sh<CmY(C68$AKTic
> zet*At?hm<R_Or)}blY~UXxVL$X}{U}qcum9YR(2sXvQ2Fv-tk!6Wj(E{UgtExx&!n
> z=3D&FN*Yc89%%1?BUPTc&ScR*D8l&^F04lQVD3A<I8H)BNV(Wp700S*UhE}ON=3D*ZFj`
> z_`X}UdD+{mjt|*%BqlaFFH*Pg>|Q&C&vb*?_j5L1HpdZjd}}u)-_Y6E(%<~Nm;DKs
> z!~3tFn(a{>S-1QB1#@qPZ@;~4rc>=3DBvq=3DkP=3DJaWN>|pKI_-Ur1ymCY9=3DuZ!uEu8a=
i
> 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
>
> delta 22153
> zcmeHv2~-r<w)Uy+qPwbT<_1KjW~P~EP(d3+1_cBqnmB_v#i)RaD2+6t2*wFfj~X=3D+
> z=3DNZJ<&R{eS(Ktj!jVNl2F$Pg%VvJM0eX8lY-n;J0`~UUdb^o{Cqt=3D46_x|?Td!JML
> z40Wnt?|Q$N_k3+Bgb)oso#5va__+u_>R?o5A4o~7`jpv)g~$-cA#;R?W^NEd{rboH
> zhxAca-La$0@w1-NK)g6mY+kLV+{F%(AL~C4o<NoCUVN+dRs5EL59qYD(J>b;8UIo>
> zT{`L7-qz+34$Xbq!jCUc&e&A4eW2=3D1`L3ziH@E#TaMa62tJk^Hw(V+sJ#<AElUiSw
> z)ze;oHE(6Zij2E29+iD5U1-0c^>NpT)md})jJ}b5>-dvhuU75%_gV2B`*wx-)d?9b
> z*)DI+?kKys1-rPE9G@2UYW2$CmfTKj(r)kXp7Y_vStoV3ryqLw*u3PYDdL_*yLau_
> zXP&sTB!As^0e<TboRP>1>-^p%j@xi`OH;b3`O96o>#~3UA|$iCNc)pt;V<q(Twm9j
> zPR?3=3Dqxt?sx0YS*XU5y@zFd91dH0{cKTIquU;XQvZbr+^u3xhr_S=3DJs$dI-<&{=3D<X
> zEnMR5Jy7>{`)5Y>{WlM>PBY63x??Xh+ES8YJ^sb=3DkNk0Ip!k#eT>8Ge#P!pHMhmB^
> zAr*U8?+JRhr+A3+v#!~StZ`Q-T=3DD&346}(oQ;<6EyVvENc8b<KlbiRhC^6nM_16vE
> zd-NZdJfhA0><YYX{>kdPswF>#E?qF?(=3DKH%-Gb+RdMU<iaNU?YUpAOr*%80|(c2Xb
> z>8ko;i-#>+y7bErhkX7{cHPaS`v%+d$u6rV7Vlo!<NEI=3DFE{*lqiymalc(Lg{qRv)
> z#vyd`ZRbx~`>n6{i(5yjf9tjS=3D5(v$ciYy~MchBduJ!7F>G4$iqNdJgYE7rzSbca)
> z{|y&^OT7GO=3Dc!}2JEv~Wo^W7M{guyEzxDBbw_Zwp`$x4r{*KZGEtU4N9^L!r=3DiA;6
> z|L9qM__(3Xk8V^36#aN!;g)BfRxR&!N2!ZVIrr$<#fu(g6m!mJ@#$O9O%{iDh8@mg
> z)PKm5lIZpF1WH{H)W0|9GcoMO4__b5sXaI9okh!>Jg*lXf!=3DMN-*?SSTN_vKh3nGP
> z3sFZJ=3DkEW0>|NT~^GMTyjd$ed9zLB|Haes_B~huKI^lt&Kyqr5yXS(R>D%YG^d0fo
> zdP35jnz!YjKU|P6s{3f^sa`eipUo*~ZV65}@?zQLFA9{}%hP?k4jCJm)E2p?dPkyC
> znY8}N>RF%Aaf^Q1YWW4X=3DxTQD4fnm4`<ES6th8xZwO3Q!3Z7Q4S$8%1<;Ptz_F8R_
> z-Z}ou>v^Y7#YisBDErvU)=3DH5fx2}His^#mmdz$9DMcw+YvFEtj@fVgQpU7A3dZ}Ku
> z(XFUDB}u9D%iWrqt{$^}?5$f})`$8IH+wYwam=3DXiqV8uD4qiKL^4{wCNlJD7*tsXh
> zs&8$bSlGE|U(cfwpP$&Jm#(DT*{bw!^RtWFbK!GEQLA#-^~1@9N8h>>cQ)<X_Djyq
> zIUmcW;_*dBPc5rkle8sYyKQbO+rNfW=3D38HWIoa;<iA~qH_uBq*SDTCodBV;gMB?3F
> zKKCv@6VaAaJ^SZ*76*>?we6-VUv=3DQFPsy}p2YWnl?RT@c>*R{Lo1ay<|9X9kpUC#G
> z>C1%Zn$*n?HYYpWY~B0hn#glPP1tnvsU9VL)@p`mM=3DpAFKH;}77T(%Ds80*^vbr@{
> zt4`W{KkjL1L#M4%FDPf8j!FE<J*InFQ0|rL1x<bMmy^>yzu!DN{b84(Yj4hZG1a8t
> zX>8oO&A!IW<rM>Tb&+pcO{;hGR;qvf+IYm0-6Lyq%lobN8W0*>wI(4oE9bK@UryO(
> z_FNlwB|UNz+BB}$n;kc8q<_Tde#;y_Z<nste(1qI7pQ!RZI5bsAEolg6E`0(QB1jG
> zQ@Q8mTE|6q6{jXuANh8HpRIKJBFA&d-&CjcQL5ifYzX-F(DQ<ULruh|4%q#y*t32A
> zogE8t;jsyfgYU?jJ5wd2BkPSDj(qjQ@&jn`MSq#6U;W5x>h|YPZeHy7YDx7D@YLt=3D
> zu8f+sLo+{$!JnNTu)gZ+zP^W+S0vak+I~Cx^_A#9s$0R+j<lIIHGTgqZ#s`tcWjtj
> z|68>Gh+j2ETOY+YADD6Q=3DdiUWe{7W22X0S%yr43s;?=3D^e@GmbvO&{5k5n}yBJv}k9
> zIweJ0a^(-r&Mr?xvunOt<NI=3DE-u1+cK6T^n_v_iiff>xiW}lq9$N%xVX%&OCnZG+F
> zoP0P{A<jL1dz4*ie*QNr!~-^toD@DhaL~%+2fr>Ecjx@j^j!~^XV^S(rB6g(TQO|(
> zjm*3Y{mttg*vn_v&&??MTr){FP5xcsmE=3DT=3D7aw?ie<|-Cb*w%mRZFS4-e37<dmLI+
> zeb2r~{M_m(>)BE{Z~ux9PMrMmm1x_AkovZ>Or~qgm<l?w_-iZYgnmyIYZu;c^~ws>
> zW_EQNmr*b8tEEOXZ?$keAsfs(Ot?}Pe`|8vp3;>C<0pRUc(RLg^~sIhAK|PXd-A5<
> znNpOvQnIW5P}YSLmCQ}YBgN5Yw8!EbrCFm_UG%p;!A}3I^Qas7lNW8ZdhHr8ntJzV
> zP{oBMV@%?1)wiZEF|SSt9?-Gqbu4-vi(bc~*RkkzEPDS77QGvmb|Ug%V}zs>(yBkK
> z&AvK1yvWAiSB+5h?U6Q}0jnKs+c^K9z@|AiP?u=3D^XGMK^jzT1oqN;R<`u(GuW%#Q$
> z)`}(WjA$e_!ZmJUCl6y|V;N$NjZIBWklfT1(DyHfks=3DAhkmo5!GlfE7g)9{c3k!2(
> zW?@lPYRv`&1_g(NhJ@0Xau!X%=3DB+G^&$Y2Ep1GKklSf&bp3X`KM;BKoCpUK|4-Zc-
> z4{vXkkGHR{pTF;Wj=3DDwbub8eq)cPy7d(U|N)hkYyRV>z0;$}I6>o&@)bh*W1Kha<P
> zZlla7<Sv$j2RZ5_R*3K8V@qUx^;Jk%tKi}Aio9A&Gu4_Zb9^sYyyvg%>AlUMpw>fC
> zy{4v|DS5}iMRA;ng(vzK9QT%EIZj3%?|&zZjN^=3Drf%%Ov#vCV?1M`?LmK<kp0!%Am
> ztT@iX6qsKKqu@A8Ghm(*M$U0I=3DD_?)7!!`OwE*TBVN5x$lVu5TPYGwnaduX~v=3DPRF
> z<Lni{JRyuZ$91+wZ%J?*3C_d@7zhr+<Tz7XU?4aMljF=3Df0RzE-e~z=3DV0|tTvisKZW
> zfq~$F;y7!2U?4bX4OhZBH~<IHfnknwbOZ*X1H&BW<OB=3D^2ZlM$*%=3Ds!2U^W>N+mE5
> zDYTm7TwEa1H-r&$9PJ9sYr@bRXXFOVE5aCYoWvcNKM5n@IH?CPFM%%Mq#Vb10`~`j
> z7-*pvFn0*!%pq5AV16Ks1BcvHz}zN`3y0i&fN3F&l0zQ8z}zE@BZoZwfVo8&R}Ojk
> zBd*~tVVpSR9RLVn8h}v+0@7SUAU6*A1Oe1cAYgoh0lG;LcMkc50794sVEjV?`JNyi
> z90~{ngfI=3Dj1cn20gCL$93W@-PFb%*2M*?!4AYL2_i2{T$4ZwtUK_y(nH3E5aD6A_$
> zglPaKyc<+%B8ZAZ5z&AUrU9797(lKP#D_ys-2ov?12A2B0CI&Oz8vbR281vTz;ufR
> z<T640I20WR2w@t4DT(O`(02s#=3DTP@}fC$q7Opji`Tp~;WhtvtcTqH~&hhh_fxj>j8
> z4#gz_bDl849O{`2%(sLI;ZS^UV9pUHltaDx0P{64TvrYyqyTe*FeTkMl$Z+Kal%D&
> zC@Bq?uLu*vq2#{693xD34)sn4rjal`IMgQtm<GbAIh4{5n4^S=3D<xpyWV2%(bjzejg
> zz#Jw_PY(6{0GLCBiRV!I0ALQ1EaiIDzuURsUI{Hil$d5&88Vi$CMKrH%-rO!+4m+s
> zLNbg58A%xn3rl3Bu&}naLAIT&|C)WzLe+d38xk589uXN4DZ;@X;^A0RMWyz%>um4f
> z=3D;Z9Iba8fdb#r(9+vNLR<$pHYCMM~x<ODMBcKgeT)-Vl|In`gMsiB^0{(JRDo{xC-
> zzp5)%Q#y@{=3DupxB+!l5dksG-ZZlox@oN^$`e!kA#Tm0CVQtIkzB>9wXcDQ&aO?7VP
> zHgpr;5>cIWv$~5vr?5qsxJ<V}E$(GO*^s(%xVBDgqzmpRzTOFxWaGt)?DUAM?(l4}
> zoeQ?uDjtaaHi_%7i&|VpoUhxrMQlOg;I87ix)oc+QzhWpv{t;m-RDtCSGZ4HOo6!<
> zI&mbW1E0o}F6y8-$W3?nuK20AI+u3WY3_=3DjS@-9c9WrjkaN^EioD_9NZ(4|qTw<j`
> z&LDgArhyj{x!NFSkpp^DBFMG4@ei@b-weA6hULfwHMbZP-2}rX$Q3m=3D2y(%&DRM*l
> zRfJ$}S{(IK?2#!%TqYQ{K;B5xVlYr97`8+zq-hZ3f?+G<gEZW`cAyMVxbCGmx<9|X
> z6QP?W(qEh{3PR1d3>Ms64f0MX7&RXe<Z%YM9ST9s#e#emR{seh3x>-C!wx7CX#~S%
> zf?-D#g*1ZUGQqGD>Vh<Hg^)!QKJX`m{IlT7#t?!l>Vca1)skRto(8!aQlsVrf_{QQ
> z?v7$n^K?O8j+0)AJxT<_WrATZlz=3DpX;WELnH%der!El*iScQ_1=3D1(DH33;Cb7w3bz
> zqBs0Th&UA+_S2j%ibl=3Dt@)C$#0Q^u4YUVc@q=3DK81-VWmYNlVEp%3p2)26+H!X`LWX
> zGspu;OY;QzLW4XA^+cL>#~fEi{FV@m3r6usBRDP-9EXse5FD2YjzdXL2#(7H$6=3D%=3D
> zo(Vl+YUqh@^bz8>o_tK?v4g+32sC^UdLbk_D<pa(8iHQ57+Sz84Hcr$Q1qffkgE;y
> zE@&7yFgRxUS89N9U2*Jdv295=3Dl!clEH!8tRG#ZJT1UD+B!CVZ=3DK}~`imD(Whjz*!T
> z5`%k{)*$bJ#-IX&n5%3TBTkLRqJk&fpmwNIa2$(1Mg=3DW~8kI_ep*S=3Di6*LHPwL#t!
> zULh6;?W+{p7mtJAK>K>3NvP?qp_)o$sFr|oQIjwzRl=3DZ5MER&m7?dhkgMJd4jGBZ&
> zsfshmlhG8^R4mw^Wsvtq1*qUHhflo`Ta@%c(@=3DrntWt26f~KPa!C9r?EEUZ_1%k6m
> z!C4wA0;7g|St&9kQD3A%Fa9(H!AcB4q@$Ur=3D}!(1d<#KjKt?wSV_GGQ>3*mbH3?%{
> zC5-9*XclS`#<WTp)0wCYHBC1-Q<WQ>eSqem0wIV>A&3E}92NWwk0Sc3QgA#FRiFaF
> zai!q+LsW?h1jm(v<B!lha3Hi^m`nzd)(c~oC1aOd++fmrL0+N~fFYzOgfXoW#`I9q
> z6T+BQ31fN~=3D?P&>tAsH<ob*JV&=3DU*wei1i<^n~EJQtvkhBFZ9NAvmrS9A}fB5FA$u
> zjz^N75FA$uj&n#)2$M;rFqw?PvG2sT$)iym((q4~B(^d$LtJA}H*{EttEWCL2x~0S
> ze`#n(nbe>^4(EY6yN^*Q((q59yg9J}9*=3D7X{0VYL8pB=3DT%Gz@haTD+*fYlSxhv<R9
> zHfPsf8F7=3D)Y*ZiwSt$gWi;B@cA;@IY>Y6YG)=3D;!17I9)5yL<u*S(Yqh*<>8dK`>L$
> zM6~a%!CkV*5bIQ&Mc@K79PKlpT(S_%G+agCLX<$kWZa<FfXP_RYjD%?F#^v(Ndztt
> zV67f5!p{h-LA?pwBEU*LT)fPMwk?^7QYd%=3DZl7x15c#|TF0KTnQq4~Uxw%2EMQK!X
> ziy&7T<fW)D1v?^x9j!q=3D3sq3f4T4;4ke8u!3Yxr3M_ZK4Mj2F-5Q9pHVGim?!6MLZ
> z6BdE?*ve6V3Kju_T!>*V%A{bjH^_w;Do`Z_i-SQf#88PopddwXA_YOrLjx#{5JZ^}
> z#HVN=3Dr4fRFon3nn^U;TtMhK!z2x0;H2<*ITcLqDScKwBD9;Fe2C=3D-HMga%Os5X5s5
> z#9}m<DiDHzWvRV#6&gapvea%AR;70N5;T;8RmmV1f~ZErz>XmZSbf^{m!eN8Sgj2D
> zLJ-T)Is`)rmx*W#yXB~cU;Fig2hvTycySo-6w$VJE6{o#)~7Rp`E=3D%1;#&k>g*Ni=3D
> zYd+ryOunf>+-KNC4Df2SnTP)nV1|d+;1~k0MO%4TA0esDN6vkYClGiY8c*?I@xS;n
> zO@47TcnyKSKoj&Z@0^E;b8bEUmcSd(Bt6Vq=3DV4-<+lb#1coWLg!wn=3Dh9##{0Gxnze
> z-hw9UVSZKTVbU?&Ry>rz+t5^spN;s?_}Pf)aNF?$0`EZ6^e`V95A&hz#779c3r*L<
> zd}ut(hqfC(CU7k((!+dcJj{nyhaHUo-h+zuFdrHZ^P$z_R08isC1eKR^xF~Asr((~
> zzQn}@-iJ!{FdrHZ^P%bRP6F>oWqOzojfeTr4&Yk^K8WV%VLmh-=3D0iJ#O(XyxMsxKr
> z@0^GE(2n33fORJr`uh*?i(zyeJX&@cP7kDPaTOGJ@o<=3D0bDzP9^t<5z+Tqv{AXSf`
> zZSbxUbR1qmC`lGT4%HbhHh6s&9gCB)=3Dt1}u5jye0!6U)QsBAirat7WSZ_5Tq$wT6i
> zbS&j!(2Av8d9og)c=3Dbry78~aP?#>HG64C=3D78w4H?0gX50(AL;u6y1~Z!XJ!+n7#2%
> zDDaL^G>c6}(|su)JajY&hKvTm5hCydOA72VhVF^wW1#kQLgf(ZKn|_IKaPPI13||M
> zYsb>@I>lIesc89l+K-Cjh3fGj^czp#rg3&I-J43nJ9CM{T-p>{=3D7FF$UXVu*tj=3D^%
> zVoe?$f+hKM1iqg~yW(L$QK|TGKJ9{c<<T<Sm{0rRrTGAvP6nti-^Rg{p<VHlp@n-U
> zLmy@ELgOjW@P0UT3N*1l-bji}{1yt`n<;dt5uQ7PPNhcSt1}>!D>G;-+@px@MUBC8
> zia>KLzD0_0q~8YW!Zh@4G5%N!cP>*4-FsXM{&r}gj%_JzL%qZSrE~yQh!>R7-lCVo
> zal<TVyQDgghW3=3Dwp7>QMZ3SAUvp{PGj+sTYO7NsI+D{}Y!pndM^e90!_%V;R5Y$&3
> zFD=3DHs${>)Lcug6p#o<8kfuEGoMpTKunX_q2sO>ZxYHRhkc_fHP7$tLvgHlkl#s_Ef
> zA)F^_vv`T+9NLP65m-*N%6QqwAOmAF=3DYZC1Uh);M)k3sLICFSm=3DW<>xpd8f7c}YG<
> zNOaD#4bja7xeY#B4mY8KS8<&Sx26(b8UnYeXfBB73A7B~noCFG!*d~-yesH<tf&A=3D
> z3ly~gmkxyrH!GmWPgFq01y@4mF5-=3DUS_#4_m9#CqOi|!JDrtYJN`J%L=3Dg|vNg+rw4
> z^#9c%(o^~$50OMh`a>jpqxTMx!i@gU50OR~{a1%b9~=3DGsAySo5#~~7#^g9lbIu4OK
> z4w2xM8o!f-y${!Mh(zXvjzc8U3*_oJMAG*I^n`Gh({YIOZ#zV)GwL`*BG06V>o`Qx
> zuTfmbAyUU761;#UgQDXQ>AyZi+Hdr)JVdgPbQ~gSTqOUq4v~T-9fwH&{zIg$l4TcY
> zb2AeQe1w(m;3?e%nRGKFCbCIZQWs-b@w683BM6iX(klNZP#IKR@ewPj)WEqI2g{L`
> zOpv7Fb1P|x-j7Nlb>?;YD5OGF7h^Ek=3DnX%htXr>;-Z&R6K`+gG;LSxCieh}B{DfiP
> z6c3>(az^A2rN*=3DZ1wcugRiG#+=3DbL?kg5X`nMO%b)Ri)A(Mwk1QR4EnZAiV8YX*j+E
> zzq%MU(nj#&g4FUut56)2r{Qw|Qif5hP(LUyQd9UcUUb-G2{d9N&dZlBgYOdGw`TM=3D
> z1U|C;1eczcPBz+W0<r2qTTJU}Go*W21%*;X#HJjnMZ~8P-k|DgGNe%=3Do!XO$Hm=3Dvw
> zg(98Cf)Oc=3DTjA4cq?Mx<v+=3DkxmYIp$dNNYV1gjGmYiu0P80!M#n2R*!zdVs~3^ly_
> zCfy8|KmRf&6et>rz!Cg0G<^IHpTEP`Q_e`Qtcy!z-~%sz+?e#A8Ho971EOT6iwF!v
> z_hB4k{%HiM?-`IH8F24M0IdG<#}#10{2xu=3DT_BaTNBd15xcO2SzF}E7HlDGTJ0s;-
> zXb{<nWxpqJ<|QNXh<L_HHz<v{EW+b67z;Q!rA;W53E%jWeoc@@W4{ch2W|{uB)Y}H
> z%q}xPKV(Uk%TaIEU00dGNLig?Ff&#Hb!YP^$^U<f>NI)euC0?Pc#Wkpm9DCWxhbLt
> zq{OD-x~WW8_)tG<DHAI;L8-WgmW5X>mWfS)KDLhuty(O{xf|gR03tSmqPZ?_BQsf|
> zOP|3EGs2o0MrOQJ246jBx5#{q{$K6pNwC^kO6wkOXFQGIBfbEvsbfsBX&n=3D%n^(sa
> znt?1zFB2UjvSWWQyTrta79m_aTNYilnAV-U#6+}LxeIabGJ-*;Jz-=3Dnv%%C|rl)Sn
> zUFKsW7!zK)w-1<844Xe{@~HfRQ8}SF_;)5!M?Ym43a8gGL0J2Ykzx5WCQjmwlG6u7
> z;5s?m1)q7wBnp+naPS9EDg9SwkEuRPij^6+nZW-6(9)(CsR&F_Ecm3@Z6@$ZJA8+L
> zOU+n?&NzZSVDMtW$|xz0jbs)0MkMP`F+8pN+=3D5LN<0ZXh-sI~@OL)gM&YF$IW35?p
> ze9)Q=3Dp*rEmM9^x@%5hg4HUbCOuoif#g7t@Pz_~W8G46kw0Y)ZuKyiKh_RqvS6>KDc
> zlp~I`g{l#@;B&q$8-NRKq3T&%HW(iyGV@L#dqZS>JAtfwC!nebr6ts5peT22WXHzB
> zXZd=3D|!8_S*IKd9k;hk9{?6j5f!xeU{4IV+LZwR$&B~bFtKs6I8jZjXjfLctb5rq1#
> zGi!;Pl`>BV8Y}F<TAxPnI>4Sa#hdKeFe(t=3Dw1>dIw+Fod2Q~;hH~^JPs9}WKL#TCx
> z`i)Tc2o>Q7l)EEPg@hVSsDnUJk@y!!F!sn1dNkUJ4Z(g+;78-chT(}$AZsMDS|U5<
> z$%e||L%z(kl;HzDgz>Z7i;WPW7(C4x3=3D}wn@@Z#K-tP>`j1mmIBC-@E$fA`Xn@?mj
> zl_0xFWQ|02$(s$Wo<w)S8VlBxipQV2u(4Dx{4EstoC~Nrxx!se#2Kz2NOy(KSnmp*
> zvBZ_N#=3DWmG{_x^1%N=3Df(uN&)+ZQMY*+YM?JyRnY=3DLpRm~HxO!-8&nK*hkNp?8|#Og
> z-Jq|-+<|g(2O!TKERJwzJK=3D-wtPlReowda~n`OT6>dwmp+<JOIXU*_{&dS8wiC~)t
> z)OzaywOTz`GaLgQg9AK4cCQ~3jB`CfMmmf72><R0%^8Fvy`WZv7id&^L9IeB&^Y4-
> zwGI-Qi8sjJ5Lqhp2JY@{u%z_{8R;P^3md7xQZ`P60w<_IW2FibFbAI{f^Sr;3AXcL
> z!?E0lW$*wWwkuBaVdZ$W4-ARLgo-O<BH(4BwJ)eEe4+jrU#LGGuOxyMzR<!}Ur3Da
> z2^HW6l!G5@g|jW$Ks=3D04^?pFDBh>GNy5|R-9_0@s#N8ic)BQm<nox&;qNd<q{2|<_
> z*gpWQ`vrh5bWH%B7y!}j4}j=3Du16Vn{6O9dI!{yWU!)JJ6zh1-fu>dx>YOxW#q?{HA
> zCW`O@DDeJ3XrMF*8u*G($%KjyA~_XAaw-TKcrFN<+DNFo!E89mDO(X@BxDj&AXgf`
> zP|`-x7vV#WQoKD2EYHG^p}?(KP@`)$nK`n-a&b0T&L!055TI6tfR9HZ;G;PN^n5}=3D
> z&nXldF*Xz$F(MQ?>)c4_tb-#VqZ-2?!FF4*Uii&ONW^YokdobVfGQ@GHV4w`Mh@$X
> zw}pYsZWPE`!@z(#91H}6gVDlpwj2Eq^J9H3{gTC+SQs50^W*>K`H^Hm$NbnaKmP0H
> z$3P=3Dg$dGx_59UW_DAVZ_N(tp^qj=3DcBBkdid6v~z0(v<)9^CrdV<fGYKV|XS|!>*sL
> z6X9u7*=3D~#p{MlS=3D;_&`BcM2OTO3uVt&zUZ`bqdVzx+yTj2TWz9`1usrxaATm9O~fi
> z2{Nhfz*P3QFFajnO+BCs<S5@X3df#glO;X-re*f)i;qoXBJjCd*kIb<U?XwcaiF{|
> zvMRDsHN`<EfW@cSlX(1kK$SOHmI}k~HnLIhSF-7uiNj$p9fsAL*eHDXYxs*{=3DXzK>
> z!ZyG{lb$W3@vt+j48Pg{Hh%g7OsaP?G+rmjDmQ}c_8C~3KqU+-zX1c&H^R1uS01rf
> z&vwB<w+z5ps6kocyp6C-8E;~JDJwml3N#*(10JVrgvEOiVRJ_Vdvp`q9UuM{0+4Qo
> z_}}QjQsQRV`K!;fOK{3PaQo&i1h9}$-S2_#6<c6Wr@aSym$!i4xeGw8+zN~4F9%r_
> z*^HZBG)PD{5lMQxqzhhr5Ij9Q%)%oVO{uW;HdvYE_d(yIndw6L;*~_O_&zB8xQ&g3
> zhg-+(AaFPgf^pj+zF~(!ck6cWyN<}F9|hU>KLT}#P$Mn_8hI7aVGlr7bQNT|S6K<3
> z@{o<j6CV=3D2hajtc2>Y$#oiN9|Y5=3DMMD5^U?)(Aawz6rKEGaJcc!8M>78)3J&a2M<r
> zyI%w9BB8X`z{{E4VC?BJP-#8}%IUj_@*{)th_8TJcb)Yk50P35p66IoUEE35iXyoZ
> zNwS8;*G`e{s{=3Ddsr$J_Z8mPg0fJ)y3l#otX^$oCoXV?HrhF!ja7$*WPWRo$jC9ENv
> z%<<EDU=3D4|6y8ISwIv|BCagq)wNFhtCnIQ8cw*?YNfg2~td<dh@p?%=3D0@hrH49NNcP
> zE#C*E6%IZJH$k60`ygF*oCPDyw_vV~P`wEibPlNbgv#9q)OkXwTcDMdkW5r(T)H2&
> zV)ppZCa}aO-pp@d6!JL-*#|jy4>|*~&lrDt54r%d&lrDp5EAb(8EV@7ptABHWMAMV
> zNN^XNaS`l5VuI3rgA!yXDBW*YA}QLAPC5i8AWv<v|96o0ke{}A5}_b3ZE^7tpdc?<
> zJnk~7`yD8M^8*0g2ms01uEHnR7?OH?a&0H+xb6W|n|2gh7>?_XLP&l`K|nGPp11O@
> zf*`sPqL@yS4w6cO_mM<|q=3DJ;(2^1t1$Or{VrO+oI<P)S<Blv-Q;wdwI20~IncU}Xa
> z;yNgk<bwyMV~?O?lW^8o;4D2KM)Zl@tQtewMZlakR_w*kX+y*&WKOHbGe*gR;BM=3D7
> z9A}q`V9U8e4qB(p;KUDRzQblQI?z&dBq{V|N0R=3D#lJvBhsw4e6=3DE(mqb7YtV-8b`r
> z^b3Q(6NP`(qAi5d56Z((`a_ARcoYC-Jd}Y@R#1aX$v=3DQOM}AdMpXhG2vU6zNyl3nc
> z77rNAIKg{^AyT3#N9oc?)O*<_nTt;Qntf#i2cxnON+*e8H!%EuGl<tB`^{37Y>uwC
> zSO%Yd*LulJv7bUF$73vI-nw%ZvU4m<)Uznq#n+mWDt>66BpAy3l5+S{Wu*N?8X|#r
> z4cc`k<?xaQX}wL$;m^OLa8+knXWYY4=3DB4}IUiPsOm4-`Q;anKj4PV_G7uiyVY);ZC
> zcN)!?heJJglqrgUvQU&MiiGkUeMcMx<qqbKShv_mwuRQ^hRcA4-<eXKCRTPzhUcWn
> zeDTB-nJqbf_0`p;$f{-X%n#Didcol#oE;9w7MuAqTAg;F?A>%Y$SS!cv!!x$_>$~L
> wDP^Inx+@z=3DLjzZftwm@)oeT~YD2M!A#iBx5f!Y=3DL|GA@!ejrnmjeq=3Dq0JM7`rvLx|
>
> --
> 2.38.1
>

