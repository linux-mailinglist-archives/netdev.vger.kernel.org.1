Return-Path: <netdev+bounces-158529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC19A1262F
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EA38188B7EC
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 770DE8635E;
	Wed, 15 Jan 2025 14:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="kDh3mYQS"
X-Original-To: netdev@vger.kernel.org
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [217.70.183.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D36D286342;
	Wed, 15 Jan 2025 14:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736951979; cv=none; b=sen7hJiZISM1jrFmQVd0qbDbtbRlAKDBH3JVQN0DwO/42pSaPkK1NKrmmharaKpEOVlwFQQhCUfoM7e/BZivlrhI6Anpd3nZ17K045uPM2Kd9e1HDtm+DrkMXbXqNF6Op1p17ngsSDJ+xEvPYxRmfhLkpDzeVF0bA4N3Gst1YS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736951979; c=relaxed/simple;
	bh=rixGOJ6YrE+/EENzfZ//699mom0P2MHHyVoZP8NVuYU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fvcDFQYLqJTrOjCnOnymU2/+6Luabn6liZNyyEPx0SBB3Ns5Qct1ndSoS17umMlmxhzxT0BH30k3U5bZYQrOtxXwGFI9VkDXVj9NWjSamo8Tyu4Imqg8uq5VIuRPa2DQ+DBiUj+WswP0G73f2YXwLFk/vsTY6GyYv8GrQhS7B+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=kDh3mYQS; arc=none smtp.client-ip=217.70.183.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3FE4140005;
	Wed, 15 Jan 2025 14:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1736951974;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3l1SzQlaxUU8morL4iXGbvQchTHCsIZRuGatmftSp+U=;
	b=kDh3mYQSVqa4h3ZeYE1TBXgYzohYuzdhpti8zB06/fea/r8PWDFkBEcquMpI9zAepBmkqk
	0F1m6WtbZDYrerFJXL9/DZ6Hkd/jiiUc4JVOkI7FCV5NBo3mJkB55T1Xws+R4RVpTdXW6V
	N7K/dHB2eCgIXX3+sIDzBfp3UMI6pSvp/eKHesYnN8DaElAgqu1pzK39ck0lTeb43bcNC+
	n3qKro9P2aQWMKdoojbB/zJeb2lxGJ8xtDCq5hVHFoKyHGMRQu+Kpfe7W5wjYYnePbxJpf
	oHjVV1tSqeMIGgZPCLjsXqch1sBzzUEoYdcCqbFg/Ne9q+DfXrgaUgV3sCWp0A==
Date: Wed, 15 Jan 2025 15:39:32 +0100
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
Subject: Re: [PATCH net 2/2] net: pcs: xpcs: actively unset
 DW_VR_MII_DIG_CTRL1_2G5_EN for 1G SGMII
Message-ID: <20250115153932.79d181eb@fedora.home>
In-Reply-To: <20250114164721.2879380-2-vladimir.oltean@nxp.com>
References: <20250114164721.2879380-1-vladimir.oltean@nxp.com>
	<20250114164721.2879380-2-vladimir.oltean@nxp.com>
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

On Tue, 14 Jan 2025 18:47:21 +0200
Vladimir Oltean <vladimir.oltean@nxp.com> wrote:

> xpcs_config_2500basex() sets DW_VR_MII_DIG_CTRL1_2G5_EN, but
> xpcs_config_aneg_c37_sgmii() never unsets it. So, on a protocol change
> from 2500base-x to sgmii, the DW_VR_MII_DIG_CTRL1_2G5_EN bit will remain
> set.
> 
> Fixes: f27abde3042a ("net: pcs: add 2500BASEX support for Intel mGbE controller")
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime

