Return-Path: <netdev+bounces-286164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iUVmBkgk/2kt2wAAu9opvQ
	(envelope-from <netdev+bounces-286164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 14:10:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 510224FF8A6
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 14:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B5F7300D96A
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 12:10:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BB837BE7D;
	Sat,  9 May 2026 12:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="SSKwPXlP"
X-Original-To: netdev@vger.kernel.org
Received: from sonic301-31.consmr.mail.ne1.yahoo.com (sonic301-31.consmr.mail.ne1.yahoo.com [66.163.184.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132E01A3165
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 12:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.184.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778328644; cv=none; b=UMJgqJSSBSh+8Y4rCQZB0hZIVfhdy+83M0tgfoRpGiPeLZEFJBSE+wCO5meIRz86/4R7stTa7TPcgb1mwVMYvScJasvWnNeS0v93/d7gNGsEBPbHrD7ew3nfzmfVPK/GYDqr/O4jk2uzH6IudlE79fSpcO9pNHHK9ktlLL1UZDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778328644; c=relaxed/simple;
	bh=2cGsUPdjFXYNl8pYQN8MyIPyDW2PB7dZ0bCVuK5B/7E=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Cc:Content-Type:
	 References; b=sASGUumG2w66CTtOoPD1ECG9Hcso801AmrDeY5IzdQ5/pU6uKSIOdGvh3WZkuXXA818u0pUrTEZ2HiYI0gLJLARIOoBDuU+/0TexMxjL9zfy49FdP+aeSrBbKVBDRIFVvRiGxQc++w8Gkg+sX+QQUW/xlzer14LHaf7M5CyV7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=SSKwPXlP; arc=none smtp.client-ip=66.163.184.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778328636; bh=PVaPG604sJyPeXwiG+400ARiklpQzlXb2VlIQVb6Sts=; h=Date:To:From:Subject:Cc:References:From:Subject:Reply-To; b=SSKwPXlPv8SQojI446P+tvTFvFWe9ybj8gcAx5rTSkQI+j28SLpurGfMd+cRvrgXTNOpaRo8U7/oWocDMzp8prxwYXIi7j0m2L9MdL2ZK6tQgxShk5JVXhsz8yxoAdEGOy+Q2kd9JIY/SB7dd+acywOhKr1emxkerVstrceaAOnBfp2A1U3YK5KrGPEVizxPuWDAPSa7DLj4ibUZ39RSwNcSF3HmSSsgw2Hdv3tShvxCPIlwW1P76PDLHSF8zHoZWJvpFLEMxG/06IJLxAj7qeVa0Yi8bVWhlXcU/flpxf1/5krSGDNAoJDn4Q2ByKGvy1U+eJsubgY8AzGpz04A+w==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1778328636; bh=j/Kn59h5JTjVC7Y4HtwcWsP2N9uLkqGVps1p+Ko6wDi=; h=X-Sonic-MF:Date:To:From:Subject:From:Subject; b=QpnAJdxpGXrCQpKUmTI/IWAsbZFd/hFryFFI4Vlt+5h4wK5hKccTKUNuuDiejMALuenoWSDyV/hA/FB/uIaHZxFKNPGYvZGuuIzNhXNdX2F0nI6Gzg/ys0Wpp+dnYezayQNJNwRlVvUS0n4sIe7rI0lwT5U1pC11scsfMLAxNVrlskckrkZxt9dQpigF+KVDSMEd8qqZrb+jMIqBKSuOBtF46V7EuieUrYetLF2I9Y4Lww2GLc0AuoLQQe3gmjNH+HptmbPMNiC7bs/6fW7aSMfXbKw8eQAeA5EUQkZvRxqLUdxLyxQEUbAX3yY/rSQAbJUEqJu8kdIKimKA4g8MUQ==
X-YMail-OSG: .cWCOo8VM1mlA3_h2doOZ8FnI9_gf_j8OSmEwfp8DPEHMq3U66Ou_KO0C0t8GUP
 PNVgP6LLV78iFMFlqwZu3dH4zGyGbMvochJGXZRSLUP7KqOjzXJYic9JM2on_bdeiTAen_C2o9Au
 hKoP5fFcmfGRKqf0EArfZeMxEvolIxzpIIpoJ9keUa.pBItKszglg9Ps5.XmKrZnpar281u.LAfx
 LbLS0Czd3Tm1dcHqEvRPLoOh360bM9ytxhp16l1JKLY3ERNnvakMD_4krCCkeiuCYWv4OObwkBxr
 0olYhZmpWAc6I858HhEtYdT1ihKj1XUsDmV4LNrMUnkQnkNp3FrqN0t0r2uCifuFjKrgoyc6187Y
 Wxf8KNbTUpNf7IO9K2YG3abjiUC.tHEeI_wzNWeeR5vy5DNK0u2fG9BGUMnvMQBVajVyVLiU_yqf
 BtqZiOOStxbpzzLQwbqiEnkbcOXR6YolAw4fXxdn9fS3Rpy1YJrKeoXhvB4SlwkISY7We.aTHiAf
 FT5irLAQZftbk20ug9pegxjfqh002VUpFWIYGXvUxw8YAqj8qp5WfVs6_0gpLWz8oVJPNZ7L_Ral
 ghcUmZTEGiPZOQSeDaK7EXg4ETWmm3XdXG4sUCptlrjMqAHrUQx_vCwxvK5_cAgMYKaIP.KmXgQe
 nC.05MHA1CmFQrLH5JaNtkn5nc0mPdsJ7u_KLfe0J2twOgOUdLsTJBszIHy2cghn7lC7ApMPRt4u
 Xv_cDnPVK9ZG61AagT78RvRTP4GOki4cbAAAY_56HzlhX4cln3hzKIyRdqXMrzc1tx5lGY5_A6Tx
 GxTcIlc2JgWnMYYSnnrxKzZxE9fDDOkBzlXRWRx._vHmU.WnO9Q0bx.ze0cwe8odFXW_9__rAV5L
 LpIzdvMvj.8HEoED9DWH0Q_SrcxdLlv8B_Jj3z8PKN4QcxwzMVU4PV44zElaMtiWCb.1rHhD917V
 5g5ZKrjXmO.iU4bpnLD2q4ZbwunF7u2TX1XbdKWsJKfr08Jn.f1u9RjGWp9jrDgZQJ0EPHpJyH0b
 wCyctclM0CUgtz6MXiyZ5yWWgWIZ3YTiKvpWQdT4kmPvSk_fbNEcIqFEV1aKpWZtOKYWbbBDTCOf
 4nCO5Oup6D2DkuVOYOfqGrJHD1vRGR6MW7IdKONolkSOJi0Tlcn13pv9BYEMCHZTswXNEpAGIOWf
 XeVFVJxaJC7X7NwNgkm6Jg1.gBtQ2bqd0cAdDTZ5aTOCRE18XvbQiDcABVqkfHbvvyFaMeR3Mlhb
 Qyt0BDZG20bM08_xF155SFi7jPX6y2KMPNC.omW7gncnbBWXDgU.FGa.RxuLhNrSW4Mrfd_cuKRc
 sqRsPikgQ5xIWjnslguCaHYpzhkP0RlJsTz_pwnENn87ihH.ZZs0MNpDmkJ3vkdYihW1UpMNQ6fc
 Q9N76WwL2i.As5c7189BzcefimypM_JVXuquYFK_n_ZvoIPrqMG8eyIpmStMcfIvICeGEkjiKQCk
 DFbraFXATjebfwyULZwCuPfzAU0nGHgGnqSCGGYSLwHFAouADQGc__495wkL07.3t9to0Jfik9gl
 ypmHPR6iOTK07_agLyq2r5c9pL1OatZiEjhBs0IsWx1zZzgGekofeZ.GRCsIct9SNJXbLVyzygPo
 8Greox_jIQQP7T_cIXefJPTzBiud6EHNaqmL5fz5zMUDcKAK1gF5zpoa8aB_gMSMxY6Vi_jfQA_j
 TwMmT26nua6vv4rwdtNtwW7FUcUajr37Vc3ZOaXrhTybVVVgtWvhKPCPy.hN4P5sGwM64QndI6pu
 gr.ZUgoDmfCpwvIYC5i3at2Zibyi7SJE574a2OEVgTm0565.UMcMY453auGJuB0UuEzKsU4P4irN
 tEIvAygAxI_PGunTwqN2QM5U3vxcBTYYp29PA.XhcnVn8fsIsI_6Qe9Eoci.wTqMYqSs0CC3bcV.
 wa74Nowq6OMFmJaB_IzfU1yY79NXytmd8gOj7MHI6fzvxnqtDoxSN1Tui1WjWi3YjlfrPHsYcfrW
 LtiCJ18oEF_.3NxWl.98_1Pne_ql0wCPVI1R1zdqfFmBt09IDK4D_6ZfzdNj62c6MHeF3c1Y.jWw
 2dHnkl8CTpUEWo0h4yvKO7WaUs8JaI6VHBLkP0zzAPCsCjJOmaPdHtjlSehj6Iwm8LPmej.LZVK4
 pGPZPnEa1uyCIH9AM1Pmqmja_g864GOa_9SclhX4qNqk8sGoRWXZ5DCDxbv34vuPDHWJCSaqcWVh
 _4yPGkqyE28cJjLj2pct2IWyU8qJTLOsRsxQ2AXSoCckjjyc_CIYjjj7M8r9YNC1YTMU8bMj3kYz
 FeO2AuzAcw.DKGJYxd9B.yyyfbdnjJMaYSvOSjfAz
X-Sonic-MF: <namiltd@yahoo.com>
X-Sonic-ID: 94eb9a70-4796-488a-87d6-ea0613db7f87
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ne1.yahoo.com with HTTP; Sat, 9 May 2026 12:10:36 +0000
Received: by hermes--production-ir2-89844b765-xcbjs (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 4c831a0076a167a8128a5219956ef2e9;
          Sat, 09 May 2026 12:10:32 +0000 (UTC)
Message-ID: <3c6d822b-0e85-4173-86ba-2badb140bbf1@yahoo.com>
Date: Sat, 9 May 2026 14:10:29 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: pl
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?=
 <alsi@bang-olufsen.dk>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org
From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: [PATCH v4] net: dsa: realtek: rtl8365mb: add support for RTL8367SB
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
References: <3c6d822b-0e85-4173-86ba-2badb140bbf1.ref@yahoo.com>
X-Mailer: WebService/1.1.25725 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Rspamd-Queue-Id: 510224FF8A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[yahoo.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[yahoo.com:s=s2048];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-286164-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[yahoo.com];
	FREEMAIL_CC(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[namiltd@yahoo.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[yahoo.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add chip info entry for the Realtek RTL8367SB switch. This device has
chip ID 0x6367 and version 0x0010. It exposes two external interfaces:
port 6 supports MII, TMII, RMII, RGMII, SGMII and HSGMII, while port 7
supports MII, TMII, RMII and RGMII. Use the existing 8365MB-VC jam table
for initialization.

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
---
v2:
- no changes over v1

v3:
- expand port 6 external interface capabilities to include
  MII, TMII, RMII and RGMII in addition to SGMII and HSGMII

v4:
- no code changes
- add revision changelog
- repost because v3 did not reach patchwork

 drivers/net/dsa/realtek/rtl8365mb.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 05412c4aa976..6451e8a31452 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -545,6 +545,20 @@ static const struct rtl8365mb_chip_info
 		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
 	},
 	{
+		.name = "RTL8367SB",
+		.chip_id = 0x6367,
+		.chip_ver = 0x0010,
+		.extints = {
+			{ 6, 1, PHY_INTF(MII) | PHY_INTF(TMII) |
+				PHY_INTF(RMII) | PHY_INTF(RGMII) |
+				PHY_INTF(SGMII) | PHY_INTF(HSGMII) },
+			{ 7, 2, PHY_INTF(MII) | PHY_INTF(TMII) |
+				PHY_INTF(RMII) | PHY_INTF(RGMII) },
+		},
+		.jam_table = rtl8365mb_init_jam_8365mb_vc,
+		.jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc),
+	},
+	{
 		.name = "RTL8367RB-VB",
 		.chip_id = 0x6367,
 		.chip_ver = 0x0020,
-- 
2.53.0

