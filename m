Return-Path: <netdev+bounces-231577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB79BFAD11
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 10:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8741899CFA
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 08:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 129F02FD694;
	Wed, 22 Oct 2025 08:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="0KfuQQMD"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F8301035
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 08:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761120605; cv=none; b=aqnlGJ0+j0iy8CyZBuNCFY7P9OYHmNqJnsIiT8I4G82pWicdwrzRrB+4+jlgo5tK7HGnWs40iugSCAcBTrSZeDkFMRPnQsuDaV2U0XynU9NzPXzv1be+EjrZTFCO/q2OgxZzX2h4j+THhPOe7t2TzmdDD7x5bqYX9Zlt14qNTbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761120605; c=relaxed/simple;
	bh=Ist7iXsFS/EtIeLfo+26/9ri6j+gatskDLyPArpudyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=awzU5xrwRNEHedmRmb662h5NPYalGiS3rlHel6oMBhHjeGQqtPINlLdnrfcSVQGfNdiftsOg7vMCXvpgVoIU8o5J1zoXDcUtcjx5yMElwWXfJXtDJlMgyAxgqMTFmkcN8BWnPEYMQvGU2gWXefwVrPohKMIpeBbtOXjjXdeTnvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=0KfuQQMD; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CEFF34E41273;
	Wed, 22 Oct 2025 08:09:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A53DE606DC;
	Wed, 22 Oct 2025 08:09:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2F51C102F2357;
	Wed, 22 Oct 2025 10:09:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761120595; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=eFCQ4jx45F1FYN8BqQ6y7HUaiF9XH7IuNi4lw4uwUHU=;
	b=0KfuQQMDRPIv7aFraJgEJgBaBQp4xDq6zkX4ez3L0k0oTa8lzTT3LExxbsvZo7zW7YoJeh
	xal0jqVWdMtlSuOJCWASzxDHrXsG+4obIOuGcY9GIqSoJ6fnoZraeUXfl0Ki185YKh1IYr
	s9EiapCGt/7WWh8FvEQoE555NnTwNPOQwmVSo/+RPY9xyFzL1eX1ltoZ5zCGdZ7R3wRpJ+
	exy1Hreb6QP9sBwCS7vEjR5pIN8+/cZGAY3U8cItUS4C+3FyCpp7BiVfKmbFxj1mohERxT
	AS6+M9Umc0+8noHgeC//ZAY5Rw5GrhTjUdQFjRSgQUFLLKU64GJYUTKZeRCVhg==
Message-ID: <ef92f3be-176d-4e83-8c96-7bd7f5af365f@bootlin.com>
Date: Wed, 22 Oct 2025 10:09:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 5/5] net: macb: Add "mobileye,eyeq5-gem"
 compatible
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, =?UTF-8?Q?Beno=C3=AEt_Monin?=
 <benoit.monin@bootlin.com>, =?UTF-8?Q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, Tawfik Bayouk <tawfik.bayouk@mobileye.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>
References: <20251022-macb-eyeq5-v2-0-7c140abb0581@bootlin.com>
 <20251022-macb-eyeq5-v2-5-7c140abb0581@bootlin.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20251022-macb-eyeq5-v2-5-7c140abb0581@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 22/10/2025 09:38, Théo Lebrun wrote:
> Add support for the two GEM instances inside Mobileye EyeQ5 SoCs, using
> compatible "mobileye,eyeq5-gem". With it, add a custom init sequence
> that must grab a generic PHY and initialise it.
> 
> We use bp->phy in both RGMII and SGMII cases. Tell our mode by adding a
> phy_set_mode_ext() during macb_open(), before phy_power_on(). We are
> the first users of bp->phy that use it in non-SGMII cases.
> 
> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>

This seems good to me. I was worried that introducing the unconditionnal
call to phy_set_mode_ext() could trigger spurious errors should the
generic PHY driver not support the requested interface, but AFAICT
there's only the zynqmp in-tree that use the 'phys' property with macb,
and the associated generic PHY driver (drivers/phy/phy-zynqmp.c) doesn't
implement a .set_mode, so that looks safe.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks !

Maxime


