Return-Path: <netdev+bounces-285267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDIsNd11/GmdQQAAu9opvQ
	(envelope-from <netdev+bounces-285267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:22:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D9F04E7605
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 877EB3006B06
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02BA33806D4;
	Thu,  7 May 2026 11:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="p2LEdreK"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F9B2D0292;
	Thu,  7 May 2026 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152915; cv=none; b=bXjzjilILSLf9SH+dX5CLuU5m1MRwX4b3XlhidDLbDf50GMe36E6aWLRXCULyoKr/YbfUbMFWxpXuYYoKsn7YzBQThubm1jbvPwkb0aZQFz4hnn98OBswg+DkTM1vxYGSxxqm7HuJjr77M6+RZW00McyJx9PNnytD1LDWZNB/a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152915; c=relaxed/simple;
	bh=3Szgn/0DuLvW/n82i9gfRAo6eVjUS2gMuzayZpXSQTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aOSZbvEGnlZuEjmVDDQECdzSMnSqH56jmiM/iGv+8ICYDa9gNSCVFo8ueINJyYnpv3xHmjJNAbIafCGEqeR9VrDoFBuvUziYKPsPDyxnlTxSn5tEPB7DRvms+S336FepX+R9xtiyopQt/NM+EAGIdTwbfnGbzFtsTcKvMqPLivg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=p2LEdreK; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A4CAEC5DC60;
	Thu,  7 May 2026 11:22:40 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id E50F860495;
	Thu,  7 May 2026 11:21:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DC49A102F24D0;
	Thu,  7 May 2026 13:21:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778152911; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=FomEAYdAik4HwDQHklL8rlVv12AzA09UWLuUsHpy4Ts=;
	b=p2LEdreKQU9Whuz9NS1a6llAszhUVywcfElxsQhXyjSxrqKsBjxbAtFgzNMmfqBMzG2wZr
	BvS6WoISuifX3s2eZ6aXvN262FR8oQcSQ2PkS2T1bddy6fKB46af9iGx3uaDztsTwj9u6G
	U0Cc/uQv8Hv8xhVA/hpU5q7Tys/j8iPb/jH5EjQl9JZJG4b6Z8HKV5u7mHa22zWXEPiohv
	KlxXxNfUZmP7MT+nFc2Kiw5ooZtKj/fQNjXR4Jw0gxzwAEFLUVB5stoEnfSusJVeWM+VUW
	QdG6GRC5qTR6gdf5GwcqnFkub93PVMMKtJDOHeBeFqvmdv1Py2YvDa7MAmAdAg==
Message-ID: <92e8a3dd-a46a-499f-b5f6-99f7b99f45f5@bootlin.com>
Date: Thu, 7 May 2026 13:21:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1 2/2] net: stmmac: eic7700: fix delay step
 calculation and ensure safe register initialization
To: lizhi2@eswincomputing.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Cc: ningyu@eswincomputing.com, linmin@eswincomputing.com,
 pinkesh.vaghela@einfochips.com, pritesh.patel@einfochips.com,
 weishangjuan@eswincomputing.com
References: <20260507083037.152-1-lizhi2@eswincomputing.com>
 <20260507083214.192-1-lizhi2@eswincomputing.com>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260507083214.192-1-lizhi2@eswincomputing.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 7D9F04E7605
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[eswincomputing.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com,foss.st.com,armlinux.org.uk,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285267-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

On 07/05/2026 10:32, lizhi2@eswincomputing.com wrote:
> From: Zhi Li <lizhi2@eswincomputing.com>
> 
> Fix several issues in the EIC7700 DWMAC glue driver related to delay
> configuration and register initialization.
> 
> The hardware implements TX/RX delay with a granularity of 20 ps per
> step, but the driver previously assumed a 100 ps step. Update the
> definitions to match the actual hardware behaviour and align with
> the binding constraints.
> 
> Introduce explicit definitions for the maximum programmable delay
> range based on the hardware limits.
> 
> Move HSP CSR configuration into the initialization path after clocks
> are enabled. This ensures that all register accesses occur with the
> required clocks active, avoiding undefined behaviour.
> 
> Clear the TXD and RXD delay control registers during initialization
> to override any residual configuration left by the bootloader. This
> ensures deterministic RGMII timing and prevents unintended delay
> being applied.
> 
> The MAC RGMII delay programming is only required for 100Mbps and
> 1000Mbps modes, where precise clock-to-data alignment is necessary for
> reliable sampling.
> 
> For 10Mbps operation, timing margins are sufficiently relaxed and no
> additional delay compensation is required. In this case, the driver
> falls back to a safe default configuration with delay disabled.
> 
> For unsupported or unexpected link speeds, the driver avoids
> programming invalid delay values and falls back to a safe default
> state by explicitly clearing the delay configuration.
> 
> Explicitly programming zero ensures that no residual delay settings
> from previous configurations or bootloader state remain active.
> 
> These changes fix incorrect delay programming and initialization
> ordering for existing users.
> 
> This also aligns the driver implementation with the updated device
> tree binding.

There's a lot going on in this patch, can you split this into patches
that solves each of these individual issues ?

It's a mix of fixes (the reg access moved after clk config for example)
and non-fixes (the RGMII timings, you're improving the granularity of
the delays, is this required to fix existing setups, or is it a generic
improvement ?), splitting this would make it both easier to review, and
easier to bisect should problems arise in the future.

Thanks,

Maxime



