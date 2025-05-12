Return-Path: <netdev+bounces-189891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95E6AB45B4
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 22:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 690AC7AB0D3
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 20:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FCF029712E;
	Mon, 12 May 2025 20:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b="TwyxneBZ"
X-Original-To: netdev@vger.kernel.org
Received: from mx03lb.world4you.com (mx03lb.world4you.com [81.19.149.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C725925A32E
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.19.149.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747083232; cv=none; b=afXRH0xU64y7ytqTSNTr9tqf1n8L+PMjNS9gWn/WRgRCueOMmZ84z7zIW/jSPWuaXWxNIYtAMCviTA+qEagvPMLLvmEBhQE0bPTTMIE932viM/Y4X8w/1/GDH2rs5OKJqlXj8RZ/4mseQDzT3LLh/i2BkSSKFlW3QTK4QKrCR/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747083232; c=relaxed/simple;
	bh=vovCGTq6R+vQkGKhs9tmL4B0Sb7d3s10R3rAR4EgGiM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndOmh/BzlmtEf1EjPHZj4j4qbLayrNK4c9vP7JGnue1FbVhnjMlxcf6ytSjRbmEoLWf0gTKL5aiTp6q1i3xYp7TKUaVp4f2ud1seWJ9F0kS27UBRbLRT7tk9cP66D8tX5jrH3HRwZKzGPOS89YokdGZG7fC/wdnGJzzcJudlnGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com; spf=pass smtp.mailfrom=engleder-embedded.com; dkim=pass (1024-bit key) header.d=engleder-embedded.com header.i=@engleder-embedded.com header.b=TwyxneBZ; arc=none smtp.client-ip=81.19.149.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=engleder-embedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=engleder-embedded.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=2rUrvGmCsV+X/cd9otVFUHga5m9gLerIDJghrZ3b39w=; b=TwyxneBZma3gBuA1BRZ1a/14IZ
	hX9U+tyZwuvYI3Ui9Tm0xlyeGo4BU0zbnTFiVVCJBfOdwitatmdkv/hr+x2tskly/GYYRElbvpdRR
	ksP7rB/t6H7LThAKE+/VpHpiVVj7bZmIgjK0dUm06Y4iEOKv295l4emla1WUMlH+512s=;
Received: from [188.22.4.212] (helo=[10.0.0.160])
	by mx03lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.97.1)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1uEZRJ-0000000009F-3WiM;
	Mon, 12 May 2025 22:07:54 +0200
Message-ID: <532276c5-0c5f-41dd-add9-487f39ec1b3a@engleder-embedded.com>
Date: Mon, 12 May 2025 22:07:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: tsnep: fix timestamping with a stacked DSA
 driver
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Richard Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org
References: <20250512132430.344473-1-vladimir.oltean@nxp.com>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20250512132430.344473-1-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes

On 12.05.25 15:24, Vladimir Oltean wrote:
> This driver seems susceptible to a form of the bug explained in commit
> c26a2c2ddc01 ("gianfar: Fix TX timestamping with a stacked DSA driver")
> and in Documentation/networking/timestamping.rst section "Other caveats
> for MAC drivers", specifically it timestamps any skb which has
> SKBTX_HW_TSTAMP, and does not consider adapter->hwtstamp_config.tx_type.

Is it necessary in general to check adapter->hwtstamp_config.tx_type for
HWTSTAMP_TX_ON or only to fix this bug? In 
Documentation/networking/timestamping.rst
section "Hardware Timestamping Implementation: Device Drivers" only the
check of (skb_shinfo(skb)->tx_flags & SKBTX_HW_TSTAMP) is mentioned.

> Evaluate the proper TX timestamping condition only once on the TX
> path (in tsnep_netdev_xmit_frame()) and pass it down to
> tsnep_xmit_frame_ring() and tsnep_tx_activate() through a bool variable.

What about also storing the TX timestamping condition in TX entry and
evaluating it in tsnep_tx_poll() instead of checking
adapter->hwtstamp_config.tx_type again? This way the timestamping
decision is only done in tsnep_netdev_xmit_frame() and tsnep_tx_poll()
cannot decide differently e.g. if hardware timestamping was deactivated
in between. Also this means that SKBTX_IN_PROGRESS is only set but
never evaluated by tsnep, which should fix this bug AFAIU.

> Also evaluate it again in the TX confirmation path, in tsnep_tx_poll(),
> since I don't know whether TSNEP_DESC_EXTENDED_WRITEBACK_FLAG is a
> confounding condition and may be set for other reasons than hardware
> timestamping too.

Yes, there is also some DMA statistic included besides timestamping so
it can be set for other reasons too in the future.

I can take over this patch and test it when I understand more clearly
what needs to be done.

Gerhard

