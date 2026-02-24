Return-Path: <netdev+bounces-260403-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YL9cH95hnWksPQQAu9opvQ
	(envelope-from <netdev+bounces-260403-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:31:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBE54183B65
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 09:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F6C630338B4
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 08:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C68A366831;
	Tue, 24 Feb 2026 08:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b="qTcBrvGs"
X-Original-To: netdev@vger.kernel.org
Received: from server.couthit.com (server.couthit.com [162.240.164.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D55313543;
	Tue, 24 Feb 2026 08:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.240.164.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771921806; cv=none; b=TRZqgls2T+Ot9LgkZGsg9cC1UITqVjksn6YCGeHWaI9ofNNTadkXCpzCAtbbbBGkhbbwO/dOtED/WSInkEM9SvisnEFqyt8FzOPVdHb7aRKyuC6uCeXUaeIHkQmgWHZnGO+FSOO1JHHdRcTG7Tk78Pxh5tq175y2xCCwiUgQGp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771921806; c=relaxed/simple;
	bh=ewIPAQX6sAszYh2BuSmqO4oiBjg87c9nS2a8K1A9wLs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DvG97h6RuSu9VoPCsxq4Ybm6aEEP5yi7JBq+TiZzJSLOpg0z/9QwEa52sA7eK6WPsGUePRcOM9s16S2AKBBXWkwYCbZ/lY2IQhrp1KI0Jcqk8my9hawqWUqUOsubZ2XuAcL31FhjHSQ0glI4W6IBcJ2b2lVDOMh4kOgmF7t124o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com; spf=pass smtp.mailfrom=couthit.com; dkim=pass (2048-bit key) header.d=couthit.com header.i=@couthit.com header.b=qTcBrvGs; arc=none smtp.client-ip=162.240.164.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=couthit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=couthit.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=couthit.com
	; s=default; h=Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:
	References:In-Reply-To:Message-ID:Cc:To:From:Date:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ewIPAQX6sAszYh2BuSmqO4oiBjg87c9nS2a8K1A9wLs=; b=qTcBrvGso3jmt65eAy6f6zTn/2
	senO/mPHbPEgWadhTZQRyHO4zk8sfyAUNZiW7Bf7CkC85eMCnxYDD1J06R4/FsputlZCWGR9QBUCo
	ia52SuDzs+gccpCbhGjVyEbIsHgPpfMcnKYLOAyhgi8aSObDWL1BxwtYf7fdgH4OtdKhOQzbo9T+E
	ofdGhNJAi53RcPTUbCQN00gmxiNjswkPGxVqhWMirs0XUdRbiNNStu+dJgQs7sEExhKZBGUvF+1G4
	k1qkrdsTrcnM4I63G1bSQkEAT7rmb7/OkaM2VW9NnjBac6as4VLdXjh7kAWiriWxzU1GyXNmgYHUb
	ITJFDrHQ==;
Received: from [122.175.9.182] (port=60068 helo=zimbra.couthit.local)
	by server.couthit.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.1)
	(envelope-from <parvathi@couthit.com>)
	id 1vunUS-00000007Vdz-2Uxl;
	Tue, 24 Feb 2026 03:09:56 -0500
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id 43A4F1B490F3;
	Tue, 24 Feb 2026 13:39:49 +0530 (IST)
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10032)
 with ESMTP id XoGCLww6HRli; Tue, 24 Feb 2026 13:39:45 +0530 (IST)
Received: from localhost (localhost [127.0.0.1])
	by zimbra.couthit.local (Postfix) with ESMTP id DC5BF1B4909D;
	Tue, 24 Feb 2026 13:39:45 +0530 (IST)
X-Virus-Scanned: amavis at couthit.local
Received: from zimbra.couthit.local ([127.0.0.1])
 by localhost (zimbra.couthit.local [127.0.0.1]) (amavis, port 10026)
 with ESMTP id P2RgEwv89MYe; Tue, 24 Feb 2026 13:39:45 +0530 (IST)
Received: from zimbra.couthit.local (zimbra.couthit.local [10.10.10.103])
	by zimbra.couthit.local (Postfix) with ESMTP id B23451B490F3;
	Tue, 24 Feb 2026 13:39:45 +0530 (IST)
Date: Tue, 24 Feb 2026 13:39:45 +0530 (IST)
From: Parvathi Pudi <parvathi@couthit.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Davis <afd@ti.com>, nm <nm@ti.com>, 
	Vignesh Raghavendra <vigneshr@ti.com>, 
	Kevin Hilman <khilman@baylibre.com>, rogerq <rogerq@kernel.org>, 
	tony <tony@atomide.com>, robh <robh@kernel.org>, 
	krzk+dt <krzk+dt@kernel.org>, conor+dt <conor+dt@kernel.org>, 
	richardcochran <richardcochran@gmail.com>, 
	aaro koskinen <aaro.koskinen@iki.fi>, andreas <andreas@kemnade.info>, 
	linux-omap <linux-omap@vger.kernel.org>, 
	devicetree <devicetree@vger.kernel.org>, 
	linux-kernel <linux-kernel@vger.kernel.org>, 
	netdev <netdev@vger.kernel.org>, danishanwar <danishanwar@ti.com>, 
	pratheesh <pratheesh@ti.com>, j-rameshbabu <j-rameshbabu@ti.com>, 
	praneeth <praneeth@ti.com>, srk <srk@ti.com>, rogerq <rogerq@ti.com>, 
	krishna <krishna@couthit.com>, mohan <mohan@couthit.com>, 
	pmohan <pmohan@couthit.com>, basharath <basharath@couthit.com>, 
	Murali Karicheri <m-karicheri2@ti.com>, 
	Parvathi Pudi <parvathi@couthit.com>
Message-ID: <760333566.501717.1771920585648.JavaMail.zimbra@couthit.local>
In-Reply-To: <2a977fd4-910a-4838-9ed6-97224d6ab775@lunn.ch>
References: <20260105162546.1809714-1-parvathi@couthit.com> <20260105162546.1809714-3-parvathi@couthit.com> <84b08398-5622-45c9-a8fa-54639c1cf0b3@ti.com> <2110802326.88645.1767873743162.JavaMail.zimbra@couthit.local> <180076068.145887.1768567659299.JavaMail.zimbra@couthit.local> <2a977fd4-910a-4838-9ed6-97224d6ab775@lunn.ch>
Subject: Re: [PATCH v4 2/2] arm: dts: ti: Adds support for AM335x and AM437x
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailer: Zimbra 9.0.0_ZEXTRAS_20240927 (ZimbraWebClient - GC138 (Linux)/9.0.0_ZEXTRAS_20240927)
Thread-Topic: Adds support for AM335x and AM437x
Thread-Index: ORYIHTaQ3Y3lblXZoUQVThEHXtOteQ==
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server.couthit.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - couthit.com
X-Get-Message-Sender-Via: server.couthit.com: authenticated_id: smtp@couthit.com
X-Authenticated-Sender: server.couthit.com: smtp@couthit.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	R_DKIM_REJECT(1.00)[couthit.com:s=default];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[couthit.com : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[ti.com,baylibre.com,kernel.org,atomide.com,gmail.com,iki.fi,kemnade.info,vger.kernel.org,couthit.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	HAS_X_GMSV(0.00)[smtp@couthit.com];
	MIME_TRACE(0.00)[0:+];
	HAS_X_AS(0.00)[smtp@couthit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260403-lists,netdev=lfdr.de];
	HAS_X_SOURCE(0.00)[];
	DKIM_TRACE(0.00)[couthit.com:-];
	FROM_NEQ_ENVFROM(0.00)[parvathi@couthit.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[29];
	NEURAL_HAM(-0.00)[-0.986];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	HAS_X_ANTIABUSE(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: CBE54183B65
X-Rspamd-Action: no action

Hi,

>> On the AM335x board, the CPSW MDIO and PRUSS MDIO signals are routed to =
the same
>> physical
>> pins (as shown in the schematic, see page 10 =E2=80=9CMII_MUX=E2=80=9D i=
n
>> tmdxice3359_sch_3h0013_v2_1a.pdf
>> from https://www.ti.com/lit/zip/TIDR336 ). Because of this shared routin=
g, the
>> pinmux
>> configuration applied by U-Boot for CPSW MDIO remains active even if the=
 CPSW
>> MDIO node is
>> later disabled in Linux, and Linux does not automatically revert the pin=
s to
>> their reset state.
>=20
> It is generally a bad idea to rely on the bootloader. I would make the
> CPSW MDIO configure the pins how it needs it. The PRUSS MDIO should
> also configure the pins how it needs them. However, it is not as
> simple as that...
>=20

On AM335x, the MDIO interface is selected by a hardware jumper before the
bootloader runs. The selection is latched in hardware, so only one MDIO
controller (CPSW or PRUSS) is active at a time.

Since the hardware choice is fixed prior to Linux boot, we decided to ensur=
e
in U-Boot that the pins are configured according to the selected hardware l=
atch.
Linux still configures the active MDIO controller as required via its DT an=
d
pinctrl settings. The U=E2=80=91Boot change ensures a clean initial state t=
hat matches
the hardware latched configuration, and we have this prepared as a patch th=
at
will be submitted to mainline U=E2=80=91Boot shortly.

> Looking at the schematic, what you have is ugly. You literally wire
> the outputs together, without a hardware mux. For MDC you assume one
> is Hi-Z, while the other drives the line. For MDIO it does not matter,
> both are inputs. so Hi-Z.
>=20

Although the schematic shows the signals tied together without an explicit =
mux,
the hardware jumper selects RMII (CPSW) or MII (PRUSS) before boot. Only th=
e
selected block is enabled, and the other remains inactive, so the lines are=
 never
driven concurrently.

> I actually think you might need to represent this in Linux, with
> something i would call a pinmux-mux. You give it two sets of pinmux
> configurations. The active device claims the mux and gets it to set
> the two sets of pinmux as needed. Also, just setting the pinmux to
> GPIO is not sufficient, you also need to ensure the GPIO is configured
> for input, so the lines go Hi-Z. Often pinmux and GPIO controllers are
> interconnected, so the pinmux subsystem might be able to do that for
> you.
>=20
> I don't know if a pinmux-mux already exists in Linux. You probably
> want to ask on the pinmux mailing list, or they might have a different
> idea how to cleanly do this.
>=20
>=09Andrew

In this case, the selection is static and determined by hardware via a jump=
er,
not switchable at runtime. Linux reflects this by choosing the Device Tree
configuration corresponding to the latched jumper, it enables the selected
MDIO controller and sets up its pinmux, while the other MDIO controller
remains disabled.

We will update the patches by removing the CPSW pin reset configuration in
ICSS context and post the next version shortly.

Thanks and Regards,
Parvathi

