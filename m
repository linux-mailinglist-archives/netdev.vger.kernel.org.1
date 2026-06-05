Return-Path: <netdev+bounces-295758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 65nZGpqdImr/awEAu9opvQ
	(envelope-from <netdev+bounces-295758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:57:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C556471BF
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 11:57:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=realsil.com.cn header.s=dkim header.b=ZN9FrNXz;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295758-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295758-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=realsil.com.cn;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D377230A7C01
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 09:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11B03B71D3;
	Fri,  5 Jun 2026 09:44:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015FD3B4E95;
	Fri,  5 Jun 2026 09:44:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780652673; cv=none; b=sB6j34AbMARl8Vd1TQVMLBdEP1KZD9wORexieBmQ/zRHU9RVzOcKlOTWCoKklEU6ll485Hepep6wiA3uKA/L7nGI99TJCGvtROkvAC03jjaQeWYX+OBQxljUHr0meJDH1wlJh5hZE5CR5XBy9yEmUh3jUVewy7qR5HU67HO3QJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780652673; c=relaxed/simple;
	bh=cGvDObAP4P1TiHE39uvL+EQac6KNJ3MwKLuJY4wnrvs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fok8ECbGe1HVCbnGbx7qZ+ngZisyhv/MUDJDAIxOVY6W0upa4gZRSrqwO7SptIvbILoLXyipT1563WxNUofrKrscgQa/eFDidJsDRLd8qynU2z++Hm1L1P8E8T98u6CInC4yh0rvKuXCLxsuXudECVcd6OXOm1muFp4oXH7U/EI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realsil.com.cn; spf=pass smtp.mailfrom=realsil.com.cn; dkim=pass (2048-bit key) header.d=realsil.com.cn header.i=@realsil.com.cn header.b=ZN9FrNXz; arc=none smtp.client-ip=211.75.126.72
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6559hsl671289396, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realsil.com.cn;
	s=dkim; t=1780652634;
	bh=AMwMhcr15Ang8zfVdQkUS0kraiuhJd0fnSuvIEPN3iY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZN9FrNXzWdUyrrTotlM4Gw02gKE1soSbnIrtN2fVyTqxA7+mzO1rnca4W3zJ7xoL+
	 oe8l1Wgv3YSJDzso9IiDZco/qKcrUI2mJR9LaV9UeYjURexNBq56W2fXYHzXTfMmeX
	 Nim0LgWpfNiEdTJ6vSJtn2k+C1rV3q3Uxqu3RZWDRfZGYcv8wCtn1kdWY6DP60reA8
	 X5sqR76VxB2d3y51yt6DVMvLVMFU+/6u2aLoOFfauk22L6BBset+p0zZifI75/n3Yr
	 tjQkUOKFFOmXkOCex9uoHEqL3UK5pO95GB7t4tdGLTaIamc7yq2So824M5SkKqM9j0
	 g3RW0Pb6EFcYg==
Received: from RS-EX-MBS4.realsil.com.cn ([172.29.17.104])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 6559hsl671289396
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 5 Jun 2026 17:43:54 +0800
Received: from RS-EX-MBS3.realsil.com.cn (172.29.17.103) by
 RS-EX-MBS4.realsil.com.cn (172.29.17.104) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Fri, 5 Jun 2026 17:43:54 +0800
Received: from RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) by
 RS-EX-MBS3.realsil.com.cn ([172.29.17.103]) with mapi id 15.02.2562.017; Fri,
 5 Jun 2026 17:43:54 +0800
From: Javen <javen_xu@realsil.com.cn>
To: Andrew Lunn <andrew@lunn.ch>
CC: Maxime Chevallier <maxime.chevallier@bootlin.com>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "nic_swsd@realtek.com" <nic_swsd@realtek.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v1 1/5] net: phy: realtek: add support for dummy
 phy
Thread-Topic: [PATCH net-next v1 1/5] net: phy: realtek: add support for dummy
 phy
Thread-Index: AQHc8yZ/Mp8SA5nBjkWeW0kSVYYOAbYr622AgACJVcD//4tpAIAAiC6A//+HfoCAAIdu8P//skuAAG3JDHA=
Date: Fri, 5 Jun 2026 09:43:54 +0000
Message-ID: <b98e02778a6742a1a831ef57c3da2070@realsil.com.cn>
References: <20260603065916.334-1-javen_xu@realsil.com.cn>
 <20260603065916.334-2-javen_xu@realsil.com.cn>
 <7496c873-fee7-4584-ad70-4315d7b94f8f@bootlin.com>
 <f614a60942e34bf39b1d49fb273221ab@realsil.com.cn>
 <0bc2ae0e-316c-447e-9098-f18f4b491328@bootlin.com>
 <7c35fa5bb5f24afdb42e2d45a4e559c3@realsil.com.cn>
 <bac05b34-9c16-4c18-9e6e-a8ccee86f0d3@bootlin.com>
 <c088522c19624f11beb179a71a11d9c1@realsil.com.cn>
 <bf3c29cb-334c-4d2c-b9d7-61bf04779fe2@lunn.ch>
In-Reply-To: <bf3c29cb-334c-4d2c-b9d7-61bf04779fe2@lunn.ch>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[bootlin.com,gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295758-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:hkallweit1@gmail.com,m:nic_swsd@realtek.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[realsil.com.cn:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[javen_xu@realsil.com.cn,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,realsil.com.cn:mid,realsil.com.cn:from_mime,realsil.com.cn:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C3C556471BF


Hi,

>> You are exactly right. The PHY doesn't actually exist; what we have is
>> an internal PCS.
>
>...
>
>> I actually tried to migrate it to
>> phylink before. However, the current driver codebase is deeply coupled
>> with tp->phydev in many places. Decoupling it may introduce bugs for
>> numerous existing devices. Therefore, I want to try to expose the
>> internal PCS as a dummy PHY device.
>
>Architecturally, you are going down a dead end. You really should be using
>phylink.
>
>I don't see anything too scary with tp->phydev in the driver. Are there pa=
rts
>you think are going to be a problem with phylink?
>
>      Andrew

Thanks for your suggestion.

 Since I am not very familiar with phylink,  so I may have been too conserv=
ative about the migration. I have prepared a version using phylink and will=
 submit it for review.

Any comments or suggestions would be very helpful.

Thanks,
BRs,
Javen

