Return-Path: <netdev+bounces-271356-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kCXxJhxYw2k2qQQAu9opvQ
	(envelope-from <netdev+bounces-271356-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:35:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C95031F2A7
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 04:35:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C5B5A3069E53
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 03:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4412DAFDE;
	Wed, 25 Mar 2026 03:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="rKWU2SJa"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A229ACFD;
	Wed, 25 Mar 2026 03:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774409750; cv=none; b=riNbzkUSF8akkJsKxZriD81wO26GW06+fy+5EAXU1m8BLkHxi6Hdhyo5QkOB6j4mHrXRBimhFArWpA9pwE6phaWoMmsN3Nrai2cTocz6aaukl+k1NKakTiYldM9Nj6XnUlv1tvaeH8TaLqjPksakGJpPNLFGcQ6hiOQ3GQbrlJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774409750; c=relaxed/simple;
	bh=QVIFwR/mwZqYthNaikzkc6MBA2j9Cwj3pb0Mr2CM02o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tRSBemYHbqKNObUAqehhFpCfRPvDLzgj1LW7iGgn2I25t5WX8V7ls3OUioGRS2Y7BqsNkujz4m5aet5KtJ/+tpt6q4j3a+QqeQP9OSV/LJkhB7u8NcyDiQ4j+r8bvKqByz3MNnemOV7AvpBVi4v+n5HdkLyNADG1BjbOaznSUEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=rKWU2SJa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 62P3ZOr242511677, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1774409724; bh=v04juolaJ/wsId2SeR2JQN0nCdrirBXuzFwAIhDcfsI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rKWU2SJarAyZAifs/tl9a6BOfSE12l0fHFY1y7Vg+JMw4gsj79epQfTuDccUQQsF/
	 bqodn94BuOlmN81X55YFL1mx/bCF//31bgMp51rdAqPg+YMKlczC1xS7+C/eQomlFX
	 ZcuO+Any+cJvYagb16juDhm5EWbz1vJ9a13LKv2r+K6xrhSaALmBKnm6sBvh+O9xqC
	 ne57/FwZwMl4OQV1Fx1ssD14VSt9eqj8BCLiY2pq+SOs4tq653cUSvMDbxpz8I0UyX
	 AIDG83ySsGeIgLbZnAWEIi9LRBBS2iDU84b2sG6z6yTuNtJydCXyd1fdjIvrihTMOG
	 4UsCzEMXHVpow==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 62P3ZOr242511677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 11:35:24 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Wed, 25 Mar 2026 11:35:24 +0800
Received: from RTKEXHMBS03.realtek.com.tw ([::1]) by
 RTKEXHMBS03.realtek.com.tw ([fe80::368f:61f6:1754:de7d%9]) with mapi id
 15.02.1748.010; Wed, 25 Mar 2026 11:35:24 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: Simon Horman <horms@kernel.org>
CC: nic_swsd <nic_swsd@realtek.com>,
        "edumazet@google.com"
	<edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "bjorn@mork.no" <bjorn@mork.no>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "davem@davemloft.net"
	<davem@davemloft.net>
Subject: RE: [PATCH net-next v3 1/2] r8152: add helper functions for PLA/USB
 OCP registers
Thread-Topic: [PATCH net-next v3 1/2] r8152: add helper functions for PLA/USB
 OCP registers
Thread-Index: AQHcup5ZqnjknxQNN0m9fKk+ygYNm7W9dkMAgAEb9QA=
Date: Wed, 25 Mar 2026 03:35:24 +0000
Message-ID: <9be8e74588604d9d9f5c10d33c6881e3@realtek.com>
References: <20260323082226.2601-451-nic_swsd@realtek.com>
 <20260324180532.261099-1-horms@kernel.org>
In-Reply-To: <20260324180532.261099-1-horms@kernel.org>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271356-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hsu.chih.kai@realtek.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,realtek.com:dkim,realtek.com:mid]
X-Rspamd-Queue-Id: 1C95031F2A7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 25/03/26 2:06 am, Simon Horman wrote:
>=20
> This is an AI-generated review of your patch. The human sending this emai=
l has
> considered the AI review valid, or at least plausible.
>=20
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-loca=
l.html
> ---
> r8152: add helper functions for PLA/USB OCP registers
>=20
> This commit introduces new helper functions (ocp_dword_w0w1,
> ocp_word_w0w1, ocp_byte_w0w1, and their _clr_bits/_set_bits variants) to
> simplify bitwise operations on PLA/USB OCP registers throughout the
> r8152 driver.
>=20
> > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c index
> > 3b6d4252d34c..ba6dc4dbfd80 100644
> > --- a/drivers/net/usb/r8152.c
> > +++ b/drivers/net/usb/r8152.c
>=20
> [ ... ]
>=20
> > @@ -3875,35 +3873,30 @@ static void r8153c_ups_en(struct r8152 *tp,
> > bool enable)
> >
> >  static void r8156_ups_en(struct r8152 *tp, bool enable)  {
> > -     u32 ocp_data =3D ocp_read_byte(tp, MCU_TYPE_USB,
> USB_POWER_CUT);
> > -
> >       if (enable) {
> >               r8156_ups_flags(tp);
> >
> > -             ocp_data |=3D UPS_EN | USP_PREWAKE | PHASE2_EN;
> > -             ocp_write_byte(tp, MCU_TYPE_USB, USB_POWER_CUT,
> ocp_data);
> > +             ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_POWER_CUT,
> > +                               UPS_EN | USP_PREWAKE |
> PHASE2_EN);
> >
> > -             ocp_data =3D ocp_read_byte(tp, MCU_TYPE_USB,
> USB_MISC_2);
> > -             ocp_data |=3D UPS_FORCE_PWR_DOWN;
> > -             ocp_write_byte(tp, MCU_TYPE_USB, USB_MISC_2,
> ocp_data);
> > +             ocp_byte_set_bits(tp, MCU_TYPE_USB, USB_MISC_2,
> > +                               UPS_FORCE_PWR_DOWN);
> >
> >               switch (tp->version) {
> >               case RTL_VER_13:
> >               case RTL_VER_15:
> > -                     ocp_data =3D ocp_read_word(tp, MCU_TYPE_USB,
> USB_UPHY_XTAL);
> > -                     ocp_data &=3D ~OOBS_POLLING;
> > -                     ocp_write_byte(tp, MCU_TYPE_USB,
> USB_UPHY_XTAL, ocp_data);
> > +                     ocp_word_clr_bits(tp, MCU_TYPE_USB,
> USB_UPHY_XTAL,
> > +                                       OOBS_POLLING);
>                               ^^^^
>=20
> Does this actually change the hardware behavior for RTL_VER_13 and
> RTL_VER_15?
>=20
> The old code read a 16-bit word with ocp_read_word() to get OOBS_POLLING
> (BIT(8)), then cleared BIT(8) in the local variable, but wrote it back us=
ing
> ocp_write_byte(). Since ocp_write_byte() masks the data with 0xff, the wr=
ite
> operation would only touch the low 8 bits and never actually clear BIT(8)=
 in
> the hardware register. This made the old code effectively a no-op for cle=
aring
> OOBS_POLLING.
>=20
> The new code uses ocp_word_clr_bits() which calls ocp_word_w0w1(), and
> that performs a proper 16-bit read-modify-write cycle with ocp_write_word=
().
> This means BIT(8) will now actually be cleared in the hardware.
>=20
The OOBS_POLLING (BIT(8)) must be cleared in the USB_UPHY_XTAL register.
The old code using ocp_write_byte() is wrong.

> While this looks like it fixes a latent bug where OOBS_POLLING was never
> being cleared, the commit message describes this as pure refactoring to
> simplify the code with no mention of a behavioral change.
>=20
I will mention this fix in the v4 commit message.

Thanks for your review.

Best Regards,
Chih-Kai

