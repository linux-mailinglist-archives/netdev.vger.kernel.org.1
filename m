Return-Path: <netdev+bounces-85221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF95899CE9
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 14:30:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E96F01F23296
	for <lists+netdev@lfdr.de>; Fri,  5 Apr 2024 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAFD16C870;
	Fri,  5 Apr 2024 12:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="n0FukpXP"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4832416D316
	for <netdev@vger.kernel.org>; Fri,  5 Apr 2024 12:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712320218; cv=none; b=kyD+O6FyL8O6Hj2Z2IbZCp0ZP/bUI667b8624UL8bF/ebEkVBFAb+7Q22PPuz/KwfPkYdhN0EqIaJuQ/f/0uDTOsYOvnK2My+UGgMoHQ5MGP7Oj2mW5gnz1zuL9ENFKR05+at02CF2DPfFWrzY6NIhFlrouakTDcJEnwZ6ZUvmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712320218; c=relaxed/simple;
	bh=4EFdwC3/yJcVQT1XxtuoYXWA/IUhTvwHmufGMIAK6YU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GflaHRFYqC6qpljhgzQPXrQ0xFovV5KXp+rj9LWo43dTCzFcg9J8rQ1BSaxqpfI3MxlSMd8hWEKE6Xln8GoKeLu1JAxBBuox7Z7vZA1dTcigX8OZ1wpYftjTNNx1oIg3PVwz4cNiZ11aI55zKTNgG2LusPmnoX4STWRrMxJ1lVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=n0FukpXP; arc=none smtp.client-ip=195.121.94.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 11f9d644-f348-11ee-89f5-005056abbe64
Received: from smtp.kpnmail.nl (unknown [10.31.155.39])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 11f9d644-f348-11ee-89f5-005056abbe64;
	Fri, 05 Apr 2024 14:28:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=fcZgaeql8XEvkKSCG3WvZsuChCGznFWV5JXzBPVIjk8=;
	b=n0FukpXPYtP3oaPdvZ0ocNQ6xP1qliLQ+KCqDEKL7vXTlf0JS9ykBryo1BWs4gi2z1xpuKwR8bUlE
	 7MTF3qOiSmJ1Zzimjhb7qW1IIqKs6+WCuihLJe2B18DOhq33Cjq9eMqyaXnYBGOpDkJyDccdUwuFlB
	 NBYhioTFQ9rZ249A=
X-KPN-MID: 33|Ia5qfgslkTKINLPchizHPSur7azAP1ec/fil4blp3sAM4J7X1iuamK/TGxBYhqe
 b7t43aXAgEsjwCzqkH3vwVJ15NS3r8CD+tEf2F40MqV0=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|YtjJtQC1Sp8mMSnUR3Ntx7mqkj1CmHzyAeU+OWdeCDkUh6ruC67YOffkfK6SwB0
 2dUgoePFUu1HdQL5Ix5BwkQ==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 16d3909d-f348-11ee-8d4f-005056ab7447;
	Fri, 05 Apr 2024 14:29:05 +0200 (CEST)
Date: Fri, 5 Apr 2024 14:29:04 +0200
From: Antony Antony <antony@phenome.org>
To: nicolas.dichtel@6wind.com
Cc: antony.antony@secunet.com, Herbert Xu <herbert@gondor.apana.org.au>,
	devel@linux-ipsec.org, netdev@vger.kernel.org,
	Eyal Birger <eyal.birger@gmail.com>,
	Leon Romanovsky <leon@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>
Subject: Re: [PATCH ipsec-next v5] xfrm: Add Direction to the SA in or out
Message-ID: <Zg_ukNvNpr6ANyvw@Antony2201.local>
References: <0baa206a7e9c6257826504e1f57103a84ce17b41.1712219452.git.antony.antony@secunet.com>
 <13307e0d-11c8-4530-8182-37ecb2f8b8a3@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13307e0d-11c8-4530-8182-37ecb2f8b8a3@6wind.com>

On Thu, Apr 04, 2024 at 04:08:42PM +0200, Nicolas Dichtel via Devel wrote:
> Le 04/04/2024 à 10:32, Antony Antony a écrit :
> > This patch introduces the 'dir' attribute, 'in' or 'out', to the
> > xfrm_state, SA, enhancing usability by delineating the scope of values
> > based on direction. An input SA will now exclusively encompass values
> > pertinent to input, effectively segregating them from output-related
> > values. This change aims to streamline the configuration process and
> > improve the overall clarity of SA attributes.
> > 
> > This feature sets the groundwork for future patches, including
> > the upcoming IP-TFS patch. Additionally, the 'dir' attribute can
> > serve purely informational purposes.
> > It currently validates the XFRM_OFFLOAD_INBOUND flag for hardware
> > offload capabilities.
> Frankly, it's a poor API. It will be more confusing than useful.
> This informational attribute could be wrong, there is no check.
> Please consider use cases of people that don't do offload.
> 
> The kernel could accept this attribute only in case of offload. This could be
> relaxed later if needed. With no check at all, nothing could be done later, once
> it's in the uapi.

It is a minor change. I will send a v6 with this check, and express my 
preference for v5:)

Thanks for your feedback.

-antony

