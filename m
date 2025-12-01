Return-Path: <netdev+bounces-242889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 53BACC95B8E
	for <lists+netdev@lfdr.de>; Mon, 01 Dec 2025 06:43:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42FD14E0327
	for <lists+netdev@lfdr.de>; Mon,  1 Dec 2025 05:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB2421E9B3D;
	Mon,  1 Dec 2025 05:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b="OHXzIddx"
X-Original-To: netdev@vger.kernel.org
Received: from duck.ash.relay.mailchannels.net (duck.ash.relay.mailchannels.net [23.83.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496261E766E
	for <netdev@vger.kernel.org>; Mon,  1 Dec 2025 05:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=23.83.222.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764567824; cv=pass; b=s9nipdmt/z0o4bM1f+clAe4MswEAl9kPHppGdm8ApCnFeg+s4hdwB7MUooXbS69YVwmVuW11snXSe90WzEcFlRIm5gM3KBZp/11g2YeEESI4vidMnWdvAAQArpfH3mWTsdcEPUPgytktyJQB8GQ4isjcfz4gSttt4q+0eK0ZZa8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764567824; c=relaxed/simple;
	bh=8dOPAeTbiq2igiRHSNGUX30z/Tum0KvFCU8iH8lL5Sw=;
	h=Message-ID:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:Date; b=QUw8wolfE0Am6bzLT9ECOeRFYeMFzU+Kh6vMz193ZkKBAfiT2zIrW2NwhGiSQabgfPCSu8T4/4Q/b80FHQxB+h15GsGX6mUsRAgu2yyw1Wrg326IoACdx8gkN+JtSujz3a3iA0AMdhw+1gFTlNCUMbKaI/WS9nPj8Rx6gczkYno=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com; spf=pass smtp.mailfrom=arinc9.com; dkim=pass (2048-bit key) header.d=arinc9.com header.i=@arinc9.com header.b=OHXzIddx; arc=pass smtp.client-ip=23.83.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arinc9.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
Received: from relay.mailchannels.net (localhost [127.0.0.1])
	by relay.mailchannels.net (Postfix) with ESMTP id 2EEA0581496;
	Mon, 01 Dec 2025 05:43:35 +0000 (UTC)
Received: from de-fra-smtpout8.hostinger.io (trex-green-0.trex.outbound.svc.cluster.local [100.100.24.71])
	(Authenticated sender: hostingeremail)
	by relay.mailchannels.net (Postfix) with ESMTPA id 1A80E581A9F;
	Mon, 01 Dec 2025 05:43:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; d=mailchannels.net; s=arc-2022; cv=none;
	t=1764567814;
	b=PZHyCV1edhE+oHsa+49uMr/Y2BaeTiBVadjvwI1j6AUsMzsvBhXPsd28at68Cdp8sf8i5E
	718BR1ZmXoVC63PD8Ve240bxrgNVW1FQvhDAfzkF5yy+TB01V7ADqIh2O1FxvLH3w83o7Y
	N+ekWG56v3SkQV6nfRBCujhSxP/MHJvBx46j/SyKvJdKO/TQHlk/XkiEr4+2i4UcMMWjOs
	4MD/EjnM5KLNMwCOsr71J4lbvNrpZL1CW6WCzs7B6vLsefLVtf2ZttrOURe4YT4QIT/RoP
	B3xh3rFHq0FZ7dz+RWPWwP83kw9H8LuqmAXquRD5whVtsnmiNW9NhnVqEj+mQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
	s=arc-2022; t=1764567814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:dkim-signature;
	bh=RI1T/z4gATf1cofag4tNjlFCI3XLLUgeAdveHH2uT0w=;
	b=T7RHDajrEAmFvYGPtU2woYI4jmj1ebdDCXJzGbibaDcSb9CFarDeTmXb9dNtLjpFNaWLA1
	t3KLHzzWogy0T+dMro3AnIuMA4m6Bm+4ITiRxQXfqemuF3ZjlayscoL4fpCixSqovb78xy
	tmtWVl2xh6lCseFbphYtoxyrah/OZ4yiaiBBo8gK+lzb6sSTI0TlKzdfItcJDzfQ39FTOQ
	gErFocJHm2x8U7N4Iev7hfDdq6hP2w5HDhOBplDUprfjWKqdepdDzyyurbU2pafLJQORp7
	4wvGmn7qh/LtSfJIrvMbTIEU6xM1lOsorBYymg6UHU7dNEu6DUj26W5P4Jfsdw==
ARC-Authentication-Results: i=1;
	rspamd-65d9b4cff4-dn7d2;
	auth=pass smtp.auth=hostingeremail smtp.mailfrom=chester.a.unal@arinc9.com
X-Sender-Id: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MC-Relay: Neutral
X-MailChannels-SenderId: hostingeremail|x-authuser|chester.a.unal@arinc9.com
X-MailChannels-Auth-Id: hostingeremail
X-Cooing-Bubble: 1dca7e7b703a42d6_1764567815038_778101955
X-MC-Loop-Signature: 1764567815038:3632105617
X-MC-Ingress-Time: 1764567815038
Received: from de-fra-smtpout8.hostinger.io (de-fra-smtpout8.hostinger.io
 [148.222.55.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
	by 100.100.24.71 (trex/7.1.3);
	Mon, 01 Dec 2025 05:43:35 +0000
Received: from [192.168.65.172] (unknown [155.93.179.162])
	(Authenticated sender: chester.a.unal@arinc9.com)
	by smtp.hostinger.com (smtp.hostinger.com) with ESMTPSA id 4dKXrK5nN7z3wlY;
	Mon,  1 Dec 2025 05:43:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com;
	s=hostingermail-a; t=1764567811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RI1T/z4gATf1cofag4tNjlFCI3XLLUgeAdveHH2uT0w=;
	b=OHXzIddxe82Cd6uABjG+QirCrCj7gSLm22q9sxQhclXRP0mz4d16nbSu7nH3Mi1XjP0tou
	wRNrDl3SHp8O/OP8/mFE6NzTyIHxwNPygovTWcxsDnzmc80rypHT9U03fF6GrWFxURvB3d
	Ta3JguQ5xecXdg0VtUSdgtktp3+nxbsXS0DMNcY6XirC5qz2+KY4VGYNEUQ2es5d3hX5wp
	zDdSDNMaZQoPhy3QnlZcnOZYz6F12NSDSjGoWVLSPh7+QngBxnEzyAPLHuhOXpyZQdsWyM
	W9FoSu7vkTLTXw8JT8xJeHbqjB8hlF/LAOyJoTwoCkkcPnXzNPcY20wQUoDmCg==
Message-ID: <8f80b7c5-8440-4e6b-a3a9-4ce72d943a73@arinc9.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 01/15] net: dsa: mt7530: unexport
 mt7530_switch_ops
To: Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Daniel Golle
 <daniel@makrotopia.org>, DENG Qingfang <dqfext@gmail.com>,
 Sean Wang <sean.wang@mediatek.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
 <20251130131657.65080-2-vladimir.oltean@nxp.com>
Content-Language: en-US
From: "Chester A. Unal" <chester.a.unal@arinc9.com>
In-Reply-To: <20251130131657.65080-2-vladimir.oltean@nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Date: Mon,  1 Dec 2025 05:43:29 +0000 (UTC)
X-CM-Analysis: v=2.4 cv=etGNzZpX c=1 sm=1 tr=0 ts=692d2b03 a=M86+Nsf21j+Nx4MJSknohA==:117 a=M86+Nsf21j+Nx4MJSknohA==:17 a=IkcTkHD0fZMA:10 a=GvHEsTVZAAAA:8 a=VT4XjZGOAAAA:8 a=pGLkceISAAAA:8 a=mpaa-ttXAAAA:8 a=8AirrxEcAAAA:8 a=N24Blf2EF_22bh_IVDcA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10 a=aajZ2D0djhd3YR65f-bR:22 a=6CpsfURP9XNmmWg3j1mJ:22 a=ST-jHhOKWsTCqRlWije3:22
X-CM-Envelope: MS4xfGcP0UF+QKuba0Wt8172iFaucA9/tX5MtS0WWNs9408eLGc5Z+FasllzGZaoXBMw9FXEUywn1qEgd5X96UwOSVQ3Qz41dplQkPzVgstbks+lCcTo4B4V LXwINpi7BBLlKQfEo5hFpGvlqLZlO9rQ2hEpWKkvXYKxyMiUy2KQwffbLT0v7pae3nCGDx4vzCKl7qTot84+hs0JaDwICIadB2W2MVop3wqPqG7foFj31e7Y WxZam8mflkkvvkIhGfTQm/M7hpE7OHxB+TtqXUMWGrbXSxoqlUcAQ8bZY5Bu8Is33fLRXa/6Oz+joRthDm9YZ5g1yqSXs607xi3s7YmXGZ98YBDQJipkYKHg /70HX76p1Wu6FWXt3cnXRSDz3oxZeA==
X-AuthUser: chester.a.unal@arinc9.com

On 30/11/2025 13:16, Vladimir Oltean wrote:
> Commit cb675afcddbb ("net: dsa: mt7530: introduce separate MDIO driver")
> exported mt7530_switch_ops for use from mt7530-mmio.c. Later in the
> patch set, mt7530-mmio.c used mt7530_probe_common() to access the
> mt7530_switch_ops still from mt7530.c - see commit 110c18bfed41 ("net:
> dsa: mt7530: introduce driver for MT7988 built-in switch").
> 
> This proves that exporting mt7530_switch_ops was unnecessary, so
> unexport it back.
> 
> Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>
> Cc: Daniel Golle <daniel@makrotopia.org>
> Cc: DENG Qingfang <dqfext@gmail.com>
> Cc: Sean Wang <sean.wang@mediatek.com>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>

Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>

Cheers.
Chester A.

