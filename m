Return-Path: <netdev+bounces-185026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5C1AA983E5
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 10:42:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62ACF167C33
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 08:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 582E6277007;
	Wed, 23 Apr 2025 08:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="RlU4yuU5"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B845270ECE;
	Wed, 23 Apr 2025 08:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745397498; cv=none; b=lF31GAj1FfQHkMeztqtvGx395NHOrRRwfNh0Frr1UBw/SnVczX1BYJ8BnYcdxsvP2LDyrwVAKcbDHYF7pEu+HboJpYqMgNqro1mQaMkanPdQFvulIUddq5VIdyvqDBLKb6U62Tho50uMUg1hugzusu+SR3Czp3dLtEXyohGMAPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745397498; c=relaxed/simple;
	bh=4vAYBWn05WHv8FN2IRY8XLU9LfDhSejpktjy4UOXSn0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=eHKsmQyH25OvPC3oalqFy1b4XIRvNkHuM7JpN9KrCSF+n7ysN1WAJFCY4mvNcRWFsRibiXc0xihg07v3luOen1yVMR5Nv9iKncvGDuktWEG1J32j9i7ZeX+jOGZzDeihuWPMvnfwGyR5P1ZYGMtDcRKgN65+pk3wtf5E1wna9DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=RlU4yuU5; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4ZjCDM5KWTz9t61;
	Wed, 23 Apr 2025 10:38:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1745397491; h=from:from:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=29MUPuaXMT6Tqv+/lrZv/DGF2Pg/peh1bsAa5912u9w=;
	b=RlU4yuU56O0LRMnUN2PpwS/AKdPHjyzMyVQDVRnQcDtYtbdkvosmsd2k/sPqifJMPDAf12
	suz+7Z1/p8QsctvIHKlD6nio8UHxyuWCXt6h4+JF9F/IPG7ZE3RBOux98Fnm2+FRGRV3GI
	6/XUr+ibOMcIhOg0KpdsYgxnZyKJpKOyeWVCmYRZ/7fQQruE8EM3uPeabmN/33FAh5W7f/
	HIrLYVCo2Z2xxy9+54X1UQG8ZM/0O1MAeEJctkSakv9jw8T41u8QkM7wMbP7iej+SyCYNH
	9387k3vUd91bseLerDIFahzSCHBsesIbIGNE/V6dHpoZm6V/PaPLckyDh/KcCA==
Message-ID: <00189e0a036e1bc7af8f78cc9fa934f1ad23efba.camel@mailbox.org>
Subject: Re: [PATCH 2/8] net: octeontx2: Use pure PCI devres API
From: Philipp Stanner <phasta@mailbox.org>
Reply-To: phasta@kernel.org
To: phasta@kernel.org, Jakub Kicinski <kuba@kernel.org>
Cc: Sunil Goutham <sgoutham@marvell.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>,  "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Geetha
 sowjanya <gakula@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>,
 hariprasad <hkelam@marvell.com>, Bharat Bhushan <bbhushan2@marvell.com>,
 Taras Chornyi <taras.chornyi@plvision.eu>, Daniele Venzano
 <venza@brownhat.org>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, Thomas Gleixner <tglx@linutronix.de>, Helge Deller
 <deller@gmx.de>, Ingo Molnar <mingo@kernel.org>,  Simon Horman
 <horms@kernel.org>, Al Viro <viro@zeniv.linux.org.uk>, Sabrina Dubroca
 <sd@queasysnail.net>,  Jacob Keller <jacob.e.keller@intel.com>,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
Date: Wed, 23 Apr 2025 10:38:01 +0200
In-Reply-To: <5e20b320cbbe492769c87ed60b591b22d5e8e264.camel@mailbox.org>
References: <20250416164407.127261-2-phasta@kernel.org>
	 <20250416164407.127261-4-phasta@kernel.org>
	 <20250422174914.43329f7f@kernel.org>
	 <5e20b320cbbe492769c87ed60b591b22d5e8e264.camel@mailbox.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MBO-RS-ID: b70643c1cde3701dc6e
X-MBO-RS-META: fdbqh1cy43nu4nexnz7w4uphsy83ech3

On Wed, 2025-04-23 at 08:28 +0200, Philipp Stanner wrote:
> On Tue, 2025-04-22 at 17:49 -0700, Jakub Kicinski wrote:
> > On Wed, 16 Apr 2025 18:44:02 +0200 Philipp Stanner wrote:
> > > =C2=A0err_release_regions:
> > > =C2=A0	pci_set_drvdata(pdev, NULL);
> > > -	pci_release_regions(pdev);
> >=20
> > This error path should be renamed. Could you also apply your
> > conversion
> > to drivers/net/ethernet/marvell/octeontx2/af/ ?
>=20
> Hm, those must have slipped me for some reason. Will reiterate with
> them and the error path.

Wait, false alarm. I actually did look at them and those in af/ don't
seem to use the combination of pcim_enable_device() + pci_request_*

Only users of that combination have to be ported. Users of
pci_enable_device() + pcim_* functions and pcim_enable_device() +
pcim_* functions are fine.

Correct me if I missed the first mentioned combination up there.

P.

>=20
> P.
>=20


