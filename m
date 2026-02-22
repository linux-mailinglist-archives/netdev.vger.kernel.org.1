Return-Path: <netdev+bounces-259862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id joA0Jmy+mmk/hwMAu9opvQ
	(envelope-from <netdev+bounces-259862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 09:29:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CEB2F16EA19
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 09:29:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2E7663015718
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 08:29:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3F381A256E;
	Sun, 22 Feb 2026 08:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="OLeDGBco"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835C110785;
	Sun, 22 Feb 2026 08:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771748967; cv=none; b=Bsx9lMOezxLmuUQunVVvZ2X3KNlAwHF03l/tM/Ye6qu9P6CQmOHX1tVhNkERu/0UxYMt+mcePxMQ9gz0H13pVnj4H28u9haR0K5URVjgIV1vPEXiY57M+c1yaQSA5u2cpnmIQ3+RPB8UTNtPbsN8CJLcDhkjacvsj0NrQT+6O/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771748967; c=relaxed/simple;
	bh=YnDIMYG5V/vUSs3jD3RsUaeAWHeGB24pDFfJMtMaZVI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHKQnno7hzLse3+NqIa1j4sQdx6DNGR1LTej+HY5lD9zZrgnNo3heFQU/bHoc2QKBIwdcV4B2ges8FORQulhGeh8EeXaTHD1M2TakcRNUUE5Usufdje9skRcf8TGq2Av9FGYi+u+QwaPsBCK2aaPpNhyShEDiciWaiPvMWk6vAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=OLeDGBco; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4OF8ORZxH77Xfd8xtjYllgKL8q52R28O7UOHUtNU2mQ=; b=OLeDGBcoozafzGNMsdeAdsg88u
	sFF64z9qnAmnGOLsezAUF67n/j+bYsxrT5Is8PLkIjvp5L6rHiJUDjejWZkO+DuI50Dtg+5XxbzQf
	2LLCEKtrMz57gQZ9XGTy1miYBr3W+ELvxxH2KRpX5YJOzxv2Ess3wkRnWDHd7F0/LWEVL7v/S7KbH
	8EY9bu5mHqGtoaIRsBFXIktJlTczTTnyTRcOIPU5E2ENmu+EBKI6kYP2scJDuDvZ+eNk+adUWrqjd
	Yo/0gSfmDKBPuowqu++yskbw/1zjDbx8wSsK6yf8yxVsWfUVilALxJ+onnRZ9ZzakQtTdlPOBnKQn
	pDWH1Ofw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:43756)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vu4pu-0000000032v-40xA;
	Sun, 22 Feb 2026 08:29:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vu4pl-000000006B1-43MY;
	Sun, 22 Feb 2026 08:28:57 +0000
Date: Sun, 22 Feb 2026 08:28:57 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub =?utf-8?B?VmFuxJtr?= <linuxtardis@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Frank <Frank.Sae@motor-comm.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sai Krishna <saikrishnag@marvell.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] net: phy: motorcomm: yt8821: disable MDIO
 broadcast address 0
Message-ID: <aZq-SbHC0eU9OenG@shell.armlinux.org.uk>
References: <d3bb9c36-5a0e-4339-901d-2dd21bdba395@gmail.com>
 <0308e736-c3e7-45d2-86f7-e729af9cb487@gmail.com>
 <3e64d8d1-87c1-45e0-9556-0ca844a90f73@lunn.ch>
 <740e8351-d8a5-4f4c-91e4-c278e4b7d248@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <740e8351-d8a5-4f4c-91e4-c278e4b7d248@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_REJECT(1.00)[armlinux.org.uk:s=pandora-2019];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[armlinux.org.uk : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[lunn.ch,makrotopia.org,gmail.com,mediatek.com,motor-comm.com,davemloft.net,google.com,kernel.org,redhat.com,marvell.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259862-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[armlinux.org.uk:-];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linux@armlinux.org.uk,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.978];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: CEB2F16EA19
X-Rspamd-Action: no action

On Sun, Feb 22, 2026 at 05:22:55AM +0100, Jakub Vaněk wrote:
> I had hoped this would not happen on the Cudy router. The MediaTek
> Ethernet subsystem driver uses of_mdiobus_register(), so PHY address 0
> should not be probed unless it is explicitly described in the device
> tree. That said, I agree that with mdiobus_register() this would still
> be an issue.
> 
> I was also hoping that moving the internal PHY would provide more
> flexibility in the device tree description of the YT8821. If the
> workaround were implemented in U-Boot by writing YT8821 MDIO registers
> at boot time, Linux would not be able to assert the YT8821 reset pin
> without losing that workaround.

Why would you want to assert the reset pin?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!

