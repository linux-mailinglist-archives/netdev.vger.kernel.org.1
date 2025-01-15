Return-Path: <netdev+bounces-158528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CE32A12629
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43D39168D71
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD7D78F46;
	Wed, 15 Jan 2025 14:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Sx0rN2Tj"
X-Original-To: netdev@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DFCE78F39;
	Wed, 15 Jan 2025 14:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736951883; cv=none; b=eGZsGGZa9WQt2rl8FMRn4IL/MJURNMQya610nZEG8VMM04Pe1l80SN6kMeS0f96n23mu411rU0KmFfq0AZrjDmHJMmm7cRdkAM5NRVsL7PEI8fo43g0PPTOKve6y/htxvGycb1bfYkKBs+zJ+rIXo0Bnayj5gUmeXG+zCbX46SI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736951883; c=relaxed/simple;
	bh=BAolRM5b/6608HH9VWhpPP+/x6Dgkn994vGSheK6JBA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tg1HgNVRtffwspczU13hg8y54W3eQO1UwrB6fqGAH4iV0xOlayu24TaEbDnvvv3DV2VDaKrmKSHWwPOYy7mdK9SCfIEV7Vecv0PXsSvT/79GuicF69u6z5pTH5YaEa7Ud9B9obc8RsW8Yh1+5Qb9DyOC3V9yOfvVBN1X+MISjuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Sx0rN2Tj; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3BAC660003;
	Wed, 15 Jan 2025 14:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736951873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHZ7onjSnwFynJ8nKgFXjzHKr0loi0YNNTWs+eMgrpA=;
	b=Sx0rN2TjNmyRpxoxKKM43Kvb2Mv6D+wfnkD4kOeMFh//CJLtqgHJv+HZBlkr/qqxGUi3Ek
	TXPOuIoP6vqygp6KTBOvCv5RYL2t6NozyZh4F5oncz54X25HFzKGrbEKjbbFC6JapI4GNo
	BDK8qVJhuHyqfMYFOtWN31NPfA5XlmXUEZuns1ifZh4ERx/3KStE9BQTs5PVngCzS94GS2
	GghM+ugcDJWIZiRB7GswX1PViHpVJxbixRVOHcZITs+ZNps5gtMIhN25vWP8eEGN+W+PPb
	avI8ML6gddE9g1WApCb+fh//vHpIKum/Le4xkmE1UZwn15eCG9G56hUjZBLdPA==
Date: Wed, 15 Jan 2025 15:37:50 +0100
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, Jose Abreu <Jose.Abreu@synopsys.com>, Andrew
 Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "Russell King (Oracle)"
 <rmk+kernel@armlinux.org.uk>, Voon Weifeng <weifeng.voon@intel.com>,
 Michael Sit Wei Hong <michael.wei.hong.sit@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: pcs: xpcs: fix DW_VR_MII_DIG_CTRL1_2G5_EN
 bit being set for 1G SGMII w/o inband
Message-ID: <20250115153750.1aac00b7@fedora.home>
In-Reply-To: <20250114164721.2879380-1-vladimir.oltean@nxp.com>
References: <20250114164721.2879380-1-vladimir.oltean@nxp.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-GND-Sasl: maxime.chevallier@bootlin.com

Hello Vlad,

On Tue, 14 Jan 2025 18:47:20 +0200
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> On a port with SGMII fixed-link at SPEED_1000, DW_VR_MII_DIG_CTRL1 gets
> set to 0x2404. This is incorrect, because bit 2 (DW_VR_MII_DIG_CTRL1_2G5_EN)
> is set.
> 
> It comes from the previous write to DW_VR_MII_AN_CTRL, because the "val"
> variable is reused and is dirty. Actually, its value is 0x4, aka
> FIELD_PREP(DW_VR_MII_PCS_MODE_MASK, DW_VR_MII_PCS_MODE_C37_SGMII).
> 
> Resolve the issue by clearing "val" to 0 when writing to a new register.
> After the fix, the register value is 0x2400.
> 
> Prior to the blamed commit, when the read-modify-write was open-coded,
> the code saved the content of the DW_VR_MII_DIG_CTRL1 register in the
> "ret" variable.
> 
> Fixes: ce8d6081fcf4 ("net: pcs: xpcs: add _modify() accessors")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

