Return-Path: <netdev+bounces-247647-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 293B8CFCB85
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 10:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB057301AE2C
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 09:05:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AE02F6574;
	Wed,  7 Jan 2026 09:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b="oaH/EDXE"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95C1917DFE7;
	Wed,  7 Jan 2026 09:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767776703; cv=none; b=lIdFZPxcq5mJjynTvTv/zBF9Bo4VELlZQYiViHiQXA35dlMRPmJ8WFOrbW8pE0iHTfhzKLXn3qnh1blB96XvuYWL+XHAKrD+SP1rJUdHiN5ngdBXRygHkLLVcfpv8kGcTxBDXCKRIo6j25JkieJGhQzf0Uh+dAgGyEyhw4KPLYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767776703; c=relaxed/simple;
	bh=MUyATR2T7b6JOBoy2qFXdG4PhDXJ4HKDD8JSoIRLJGg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyZevYanysFQpW2f+FL+XoPjNqVTbyjYGnvh+cKqU4xO+08Waw7GpPIai4CXOErsvUBueQbG5Gnl4m0lsp/G1zJ16lhgt9qTZpbwaBQYEfds/1HL3RdiFJFIiv/iAuIHXCJVKpibnHlZWb82Q4WcsNbtxiQAG14hr7+7j91Pi50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=oaH/EDXE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realsil.com.cn
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60794fGnA2687078, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1767776681;
	bh=CIWXxsvFJSmxQloPm7zwQJHIdvE5VeD9glCfjS1ohlo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=oaH/EDXEv//l3sFbx7BfLnq04hFj3eTeqfG9v2oAlN0oB0a3NdwzBPJAHWeNjapzg
	 WsluFNSG/hQvGfHDy3t1WrkMYlXzvMXbobVqbgU6JMqna663nzX9hdhnWiD9sVj+sL
	 UsGHydXtol2MjuGsC/HVEeUMvYuYLdOW4OO+gAKBcx36UlGESc/KoGmpqETrDWLT0C
	 iXAdwc76WM0WEMjnbeNtj4SeXyXPm9LhZRCx2TLATajUIhjctPi0H8x5SZoarJDeMC
	 grEPFdnbBr4H8rrqctAlCww75Mp5tFLf8g+jPDMg2ycLjuZnUbPq1/lj7xgSPyLDlU
	 K8clKWq2jqzag==
Received: from RS-EX-MBS1.realsil.com.cn ([172.29.17.101])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60794fGnA2687078
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 7 Jan 2026 17:04:41 +0800
Received: from RS-EX-MBS2.realsil.com.cn (172.29.17.102) by
 RS-EX-MBS1.realsil.com.cn (172.29.17.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.39; Wed, 7 Jan 2026 17:04:41 +0800
Received: from 172.29.37.154 (172.29.37.152) by RS-EX-MBS2.realsil.com.cn
 (172.29.17.102) with Microsoft SMTP Server id 15.2.1748.39 via Frontend
 Transport; Wed, 7 Jan 2026 17:04:41 +0800
From: javen <javen_xu@realsil.com.cn>
To: <hkallweit1@gmail.com>
CC: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <horms@kernel.org>, <javen_xu@realsil.com.cn>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <nic_swsd@realtek.com>, <pabeni@redhat.com>
Subject: RE: [PATCH net-next 2/2] r8169: enable LTR support
Date: Wed, 7 Jan 2026 17:04:41 +0800
Message-ID: <20260107090441.954-1-javen_xu@realsil.com.cn>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <847e626b-c103-4884-beca-f8b0e74e3613@gmail.com>
References: <847e626b-c103-4884-beca-f8b0e74e3613@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain

>  On 1/6/2026 9:30 AM, javen wrote:=0D
> > From: Javen Xu <javen_xu@realsil.com.cn>=0D
> >=0D
> > This patch will enable=0D
> > RTL8168FP/RTL8168EP/RTL8168H/RTL8125/RTL8126/RTL8127 LTR support.=0D
> >=0D
> Few questions:=0D
> - Is there a reason to ever disable LTR?=0D
> - Is there any known LTR-related problem with the existing code?=0D
>   IOW: Should your patch be treated as a fix?=0D
> - What is the chip default after a hw reset? Is LTR enabled or disabled?=
=0D
> - Can at least some register numbers (and bits in these registers) be rep=
laced with=0D
>   names according to the data sheet? I think of OCP reg 0xe032 and regist=
er 0xb6.=0D
=0D
We generally do not recommend disabling LTR. LTR works in concert=0D
with ASPM to reduce power consumption while maintaining performance.=0D
There is no LTR-related bug in the existing code. The issue observed=0D
on the customer's evaluation platform is that the link cannot enter=0D
L1.1/L1.2 without LTR support. This patch enables LTR to allow the=0D
device and platform to reach those low power states. Therefore, this=0D
patch should be considered as a new feature.=0D
After a hardware reset, LTR Enable defaults to 0 (disabled). Driver=0D
must program the related registers to enable LTR.=0D
We will replace some register numbers with names according to the=0D
datasheet in the next patch.=0D
=0D
> > Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>=0D
> > ---=0D
> >  drivers/net/ethernet/realtek/r8169_main.c | 98 =0D
> > +++++++++++++++++++++++=0D
> >  1 file changed, 98 insertions(+)=0D
> >=0D
> > diff --git a/drivers/net/ethernet/realtek/r8169_main.c =0D
> > b/drivers/net/ethernet/realtek/r8169_main.c=0D
> > index f9df6aadacce..97abf95502dc 100644=0D
> > --- a/drivers/net/ethernet/realtek/r8169_main.c=0D
> > +++ b/drivers/net/ethernet/realtek/r8169_main.c=0D
> > @@ -2919,6 +2919,101 @@ static void rtl_disable_exit_l1(struct rtl8169_=
private *tp)=0D
> >       }=0D
> >  }=0D
> >=0D
> > +static void rtl_enable_ltr(struct rtl8169_private *tp) {=0D
> > +     switch (tp->mac_version) {=0D
> > +     case RTL_GIGA_MAC_VER_80:=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);=0D
> > +             r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);=0D
> > +             r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd2, 0x8c09);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd4, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdda, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcddc, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcde8, 0x887a);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdea, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdec, 0x8c09);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdee, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdf0, 0x8a62);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdf4, 0x883e);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdf6, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdf8, 0x8849);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdfa, 0x9003);=0D
> > +             r8168_mac_ocp_modify(tp, 0xe032, 0x0000, BIT(14));=0D
> > +             break;=0D
> > +     case RTL_GIGA_MAC_VER_70:=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);=0D
> > +             r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);=0D
> > +             r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd2, 0x8c09);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd4, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdda, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcddc, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcde8, 0x887a);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdea, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdec, 0x8c09);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdee, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdf0, 0x8a62);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdf4, 0x883e);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdf6, 0x9003);=0D
> > +             r8168_mac_ocp_modify(tp, 0xe032, 0x0000, BIT(14));=0D
> > +             break;=0D
> > +     case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_66:=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);=0D
> > +             r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);=0D
> > +             r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd2, 0x889c);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd4, 0x8c30);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdda, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcddc, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcde8, 0x883e);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdea, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdec, 0x889c);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdee, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdf0, 0x8C09);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdf2, 0x9003);=0D
> > +             r8168_mac_ocp_modify(tp, 0xe032, 0x0000, BIT(14));=0D
> > +             break;=0D
> > +     case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_52:=0D
> > +             r8168_mac_ocp_modify(tp, 0xe034, 0x0000, 0xc000);=0D
> > +             r8168_mac_ocp_modify(tp, 0xe0a2, 0x0000, BIT(0));=0D
> > +             r8168_mac_ocp_write(tp, 0xe02c, 0x1880);=0D
> > +             r8168_mac_ocp_write(tp, 0xe02e, 0x4880);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd8, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdda, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcddc, 0x9003);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd2, 0x883c);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd4, 0x8c12);=0D
> > +             r8168_mac_ocp_write(tp, 0xcdd6, 0x9003);=0D
> > +             RTL_W8(tp, 0xb6, RTL_R8(tp, 0xb6) | BIT(0));=0D
> > +             break;=0D
> > +     default:=0D
> > +             return;=0D
> > +     }=0D
> > +     /* chip can trigger LTR */=0D
> > +     r8168_mac_ocp_modify(tp, 0xe032, 0x0003, BIT(0)); }=0D
> > +=0D
> > +static void rtl_disable_ltr(struct rtl8169_private *tp) {=0D
> > +     switch (tp->mac_version) {=0D
> > +     case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_80:=0D
> > +             r8168_mac_ocp_modify(tp, 0xe032, 0x0003, 0);=0D
> > +             break;=0D
> > +     default:=0D
> > +             break;=0D
> > +     }=0D
> > +}=0D
> > +=0D
> >  static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, =0D
> > bool enable)  {=0D
> >       u8 val8;=0D
> > @@ -2947,6 +3042,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8=
169_private *tp, bool enable)=0D
> >                       break;=0D
> >               }=0D
> >=0D
> > +             rtl_enable_ltr(tp);=0D
> >               switch (tp->mac_version) {=0D
> >               case RTL_GIGA_MAC_VER_46 ... RTL_GIGA_MAC_VER_48:=0D
> >               case RTL_GIGA_MAC_VER_61 ... RTL_GIGA_MAC_VER_LAST:=0D
> > @@ -2968,6 +3064,7 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8=
169_private *tp, bool enable)=0D
> >                       break;=0D
> >               }=0D
> >=0D
> > +             rtl_disable_ltr(tp);=0D
> >               switch (tp->mac_version) {=0D
> >               case RTL_GIGA_MAC_VER_70:=0D
> >               case RTL_GIGA_MAC_VER_80:=0D
> > @@ -4811,6 +4908,7 @@ static void rtl8169_down(struct rtl8169_private =
=0D
> > *tp)=0D
> >=0D
> >       rtl8169_cleanup(tp);=0D
> >       rtl_disable_exit_l1(tp);=0D
> > +     rtl_disable_ltr(tp);=0D
> >       rtl_prepare_power_down(tp);=0D
> >=0D
> >       if (tp->dash_type !=3D RTL_DASH_NONE && !tp->saved_wolopts)=0D

