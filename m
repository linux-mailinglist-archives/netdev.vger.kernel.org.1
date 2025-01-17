Return-Path: <netdev+bounces-159218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9B7A14D6C
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 11:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA19F188BFCF
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 10:18:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1231F941F;
	Fri, 17 Jan 2025 10:18:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14F91F7093
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 10:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737109080; cv=none; b=Ox8IM+ndV2uzDsplLvmONODgBirMWWhuHNjvSy6Af4ze7SZ7TTrxzYktPJ+9/bWBeF7k1PWJtFu2ZwQ3nIpAbbtDF8+4Bdz3/QwDLqBRL4d+SMunf484xxPerLRJh+XRAxKVheHvkhCDovTTsL+mVBZFGpIgej76qjw3qW5jY7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737109080; c=relaxed/simple;
	bh=oRwRrEcKzYRf9wAB5P+BeTyWhtTM1Lubr/86QsaJdcc=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=ikuz+A7V50oAXxq0gYrF0Rwm1mNCX6VabM87JgJs4VVqsHT2qA12FRF47kbSieHmc63rOXwfyiVN3GbVZAY0mXa7PslRqNYyx1CCKsS6Lhay5M7na1HOSMEtvAL1XtEY/K4cZnaJsXMBWVIrVRPuvpREyHE3Dn99sgQrd481xWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.254.200.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid:Yeas8t1737109026t788t53021
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [36.24.187.167])
X-QQ-SSF:0000000000000000000000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 5973032802346409785
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: "'Andrew Lunn'" <andrew@lunn.ch>,
	"'Heiner Kallweit'" <hkallweit1@gmail.com>,
	<mengyuanlou@net-swift.com>,
	"'Alexandre Torgue'" <alexandre.torgue@foss.st.com>,
	"'Andrew Lunn'" <andrew+netdev@lunn.ch>,
	"'Bryan Whitehead'" <bryan.whitehead@microchip.com>,
	"'David S. Miller'" <davem@davemloft.net>,
	"'Eric Dumazet'" <edumazet@google.com>,
	"'Jakub Kicinski'" <kuba@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>,
	"'Marcin Wojtas'" <marcin.s.wojtas@gmail.com>,
	"'Maxime Coquelin'" <mcoquelin.stm32@gmail.com>,
	<netdev@vger.kernel.org>,
	"'Paolo Abeni'" <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>
References: <Z4gdtOaGsBhQCZXn@shell.armlinux.org.uk> <06d301db68bd$b59d3c90$20d7b5b0$@trustnetic.com> <Z4odUIWmYb8TelZS@shell.armlinux.org.uk>
In-Reply-To: <Z4odUIWmYb8TelZS@shell.armlinux.org.uk>
Subject: RE: [PATCH net-next 0/9] net: add phylink managed EEE support
Date: Fri, 17 Jan 2025 18:17:05 +0800
Message-ID: <06dc01db68c8$f5853fa0$e08fbee0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Content-Language: zh-cn
Thread-Index: AQJuuL6961zeRYLpn6fcQniPsxo8VAIOTZqlAVk2ssyx2OG8AA==
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: NEAuM+RWOySTVAAXhdhYDgg85MX23/jRqes6cMCw2E6Cd19TpARe48ex
	omcuSKj/eVPDx5/8ZN74AQfkEUPMN6JHTvX++X85CGytCNi0ZjFnB6YxCryKeDngVrLrNJZ
	qOLj/O0zDRl7z9JhbxesRX3VJbQfuBokz4UC8ag1yipON7L330yP8bDNJdesPcSShkyXpFx
	WdguuPPmlydhgy89SHTykCnqyN3KeQcjxWAAOR3pVlDCta/d07u4cTWATgv0Eutt4pBwHYb
	17I/ZlPI3wdPbv09iM6oTusc4r1eg79SygoBVpEsh3NYHtS0n3zzVlet42X5TQc/rgOrjbu
	fOhRGtrjYfie9F3S3KRpBsMrxPOpAC3mNsQwz/GRG4PyLVk8i8XZZvy65lWUfxJQv6An8lv
	R016fdo/hyEF1wDP9R/I39sYcwqMNcTMo7RYH8lK2fnN4LOyXWU/uSJo2h3zda9nkc0UgDH
	T836YnE6tD3Mc4hNIFZVzrgBiM5t4RDGMEGNLko0MBdS5hwmZzSDnvnV6WYY9DzWtXLCjFP
	grZkxxmxA+VQ68wvBCUPUrD8eqsrG3d2CoSOjjdPB5i+STWWrnu0FdEEAP233x9oC0NLVYl
	7VjBPNBm+vVxPh8zy7pJ378DhhYJ6mT9/rziauDsDJFUWOrn9EMmotz9BBxoJelZigLdBmS
	AqXu+p9Bw+Yz4aUFmKuhz2p4UxcBgny6N/ni4U5hMge0vWtg2kNCv2e6YuHp1ccuc9pJhMq
	OEdVNDfSaQ0aFEGiE3Esg4FtufOcXaJnXLSCF5hkJvT7Hc019gJw3WkL//+l7uekL8wfQhZ
	wStY6bFrh8led88rCkJPnaUTFbNHZ2QyF+QDfP5Hd0Hxm2XeVM5Z72We2MhspZBoblPdfdy
	wDDpSUCqXbmo9WgvgzvKBWMgPCpCW45lLYOrz5arVkwEkynZ+gxm0i5Eqy0Sxcb2UPOXe3U
	ucvJ0FZSvxCGoSijjqp4PgHezY/nrDBNrzw2DWDGya3maG21GW73ULQwxXH5dwy1+60FZro
	L/6J5TK/WJgesQO+2JpHXxUi70omD7XcnNAMI/EPKWoEHd/ziE
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

> > Since merging these patches, phylink_connect_phy() can no longer be
> > invoked correctly in ngbe_open(). The error is returned from the function
> > phy_eee_rx_clock_stop(). Since EEE is not supported on our NGBE hardware.
> 
> That would mean phy_modify_mmd() is failing, but the question is why
> that is. Please investigate. Thanks.

Yes, phy_modify_mmd() returns -EOPNOTSUPP. Since .read/write_mmd are
implemented in the PHY driver, but it's not supported to read/write the
register field (devnum=MDIO_MMD_PCS, regnum= MDIO_CTRL1).

So the error occurs on  __phy_read_mmd():
	if (phydev->drv && phydev->drv->read_mmd)
		return phydev->drv->read_mmd(phydev, devad, regnum);



