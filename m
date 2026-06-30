Return-Path: <netdev+bounces-302891-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6gQOJ6oiQ2ooRwoAu9opvQ
	(envelope-from <netdev+bounces-302891-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:58:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 781026DFAF0
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 03:58:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=j9OdEZjM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302891-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302891-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7D072302D4EE
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11099314A98;
	Tue, 30 Jun 2026 01:57:59 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865272264D9;
	Tue, 30 Jun 2026 01:57:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782784679; cv=none; b=TmNq9tZqR3GEu8FfLIaPlZxrszgFlTxi01PaKW5PLSZBJ4OB4vTBuiDtkNLNFCOMJzFXLkSIPnMeAs9cDS2XauYuK7yampaUGoxgPWbwGxgqzvKtthlC317qtRy78yKNyXLsKnzl+mdozAVPUD4aGcD+cDE1Tl5oy0igaROMkS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782784679; c=relaxed/simple;
	bh=nmr8k63PP/orGw7GwsTqNPnIntMbHAyiDMyosVayUU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YFF7td0WfNNNVViJncjGBRlcsRo4PEJUipo6FVenZMHAspbqclzXRqYKE7qs3s7CDkl/BD7OOiO5qZqduyzCpnYAKcI/d58BrZPHdAbzrJDaA+c/XBD6gcPtTVxWyZdS/uhK+TJlH704fRaGz31yEyHvbsgTJ+jCsfsAc5+EgQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=j9OdEZjM; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 65U1vR1x94080767, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1782784648;
	bh=nmr8k63PP/orGw7GwsTqNPnIntMbHAyiDMyosVayUU8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=j9OdEZjMHrjZnsQ6Ddt9wyyC2OJu5Kc+/jzrSur06t+YhgLIxzhWuavkklAo51a1m
	 hV8Q3aHSGek13XXp7ZQ2Q4UMuWHZFD8mw/bmh4Nnt5zLK6MHoMzYRwpETnzta1oM6y
	 iT5Q5w8dvWaavQhk+1OKGRNAYsSQeULrqccUYrXLmfPlZ21JUWAzkWf/MRVL7I+M76
	 Q9GaUOVTl4Hdwx2OKpLN7PCmKgKkMrLS5TMkk7C29GR5MDDGPGUwnqtkAaxvOE0ICb
	 mqt28Kk4B6l+UBQD89w9CN1K8tEY0jEohzbQrWlJsbNjOsVZrzy9N/q2pF1gxlfQai
	 /zyKj5M5WQZuA==
Received: from RS-EX-MBS2.realsil.com.cn ([172.29.17.102])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 65U1vR1x94080767
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 30 Jun 2026 09:57:28 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS2.realsil.com.cn (172.29.17.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 30 Jun 2026 09:57:27 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Tue,
 30 Jun 2026 09:57:27 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Jakub Kicinski <kuba@kernel.org>
CC: "hkallweit1@gmail.com" <hkallweit1@gmail.com>, "nic_swsd@realtek.com"
	<nic_swsd@realtek.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v9 0/7] r8169: add RSS support for RTL8127
Thread-Topic: [PATCH net-next v9 0/7] r8169: add RSS support for RTL8127
Thread-Index: AQHdB5bQTMnckxFSmUe/MPSXUjLLjLZVo3yAgAC0whA=
Date: Tue, 30 Jun 2026 01:57:27 +0000
Message-ID: <a86ff04248c74814b470c23c09c5fe37@realsil.com.cn>
References: <20260629071339.1605-1-javen_xu@realsil.com.cn>
 <20260629160951.4422d10c@kernel.org>
In-Reply-To: <20260629160951.4422d10c@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realsil.com.cn,none];
	R_DKIM_ALLOW(-0.20)[realsil.com.cn:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302891-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 781026DFAF0

>On Mon, 29 Jun 2026 15:13:32 +0800 javen wrote:
>> This patch series adds RSS (Receive Side Scaling) support for the
>> r8169 ethernet driver, specifically for RTL8127 (RTL_GIGA_MAC_VER_80).
>>
>> RSS enables packet distribution across multiple receive queues, which
>> can significantly improve network throughput on multi-core systems by
>> allowing parallel processing of incoming packets.
>
>On top of posting this too early you're also violating the limit of outsta=
nding
>patches. You must not have more than 15 outstanding patches.
>_Especially_ when you struggle with the quality and need 10+ reposts :/ Th=
e
>reviewer bandwidth is very limited.

Hi,

Sorry about that. I understand the concern, and I apologize for the trouble
caused by my frequent submissions. I will be more careful with the outstand=
ing
patch limit and avoid posting new versions too quickly in the future.

Yesterday I submitted three series. For the phylink series,

Link: https://lore.kernel.org/netdev/20260629060931.1006-4-javen_xu@realsil=
.com.cn/

I have received your email and I know I should resend it later.
Apart from that, I also submitted the following two series:

Link: https://lore.kernel.org/netdev/20260629064718.1349-1-javen_xu@realsil=
.com.cn/
Link: https://lore.kernel.org/netdev/20260629071339.1605-1-javen_xu@realsil=
.com.cn/

Could you please let me know the status of these two series? Should I keep
waiting for review comments, or should I withdraw or resend them as well?

Thanks for your time, and sorry again for the inconvenience.

Best regards,
Javen

