Return-Path: <netdev+bounces-125287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A284096CA94
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 00:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFD16B21C1B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 22:47:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53AE149DE8;
	Wed,  4 Sep 2024 22:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="HhGAkxud"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B418A79E1
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 22:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725490034; cv=none; b=gEYtUoRYZO35vfDuujBwKTHzbfc4Ahwr2Vfiljf2pdAjKtI1bbm6PWwvpUWvKAbcFBNOdgSJmYSXM/AK3lqqAj9zrOdFSD7saqBc+lYICkmbcraBSHfDSvungOdcMNraN79iSei5EkSsBMeXC8uRCcBEmL6c3mMXhXrRLwBbVk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725490034; c=relaxed/simple;
	bh=fa0FNHRIf4XAveWlNk5NirJyRFaHqQBbKE8zNLTRZWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWrTHZy7x/WKJrz+QJerZnm+/lATkQFzeE65o9PXFAxRnptuLJEgx3/yyN3RlvfxdmL56QggjmcEKV21ZX/DKYmupu1wrbw7XHxrsF3pUXkECTJlV7PXIM1XRcR8H40VLzFdk8efQZD3D1fBoE8j2gSrkBvv0FPCnFQhdaNGu1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=HhGAkxud; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e76530ba-b191-4d64-8692-70a319e57f99@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725490030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpU4GuA2JgIk0e7oT7WdtcBl8yBTP4McC9MYgnQn8VU=;
	b=HhGAkxudt/7ALdKtg3kaxuNAtsHuhuIK62AhbeLMT3mdif2V3hGpENRsFX5SrJeAwqVuJS
	Woulj2Fo3AjHYEwEHtXUcThG4zbksJhw2VocvP7k4+yQM9R2JhuBNQeIpL4We/51G+WXYp
	sVBWw5Nr3B/zg4bU0Dfvi+FOEKnD/2A=
Date: Wed, 4 Sep 2024 23:47:07 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net] MAINTAINERS: fix ptp ocp driver maintainers address
To: Simon Horman <horms@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org
References: <20240904131855.559078-1-vadim.fedorenko@linux.dev>
 <20240904201724.GE1722938@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20240904201724.GE1722938@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 04/09/2024 21:17, Simon Horman wrote:
> On Wed, Sep 04, 2024 at 01:18:55PM +0000, Vadim Fedorenko wrote:
>> While checking the latest series for ptp_ocp driver I realised that
>> MAINTAINERS file has wrong item about email on linux.dev domain.
>>
>> Fixes: 795fd9342c62 ("ptp_ocp: adjust MAINTAINERS and mailmap")
>> Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
> 
> Hi Vadim,
> 
> Should an entry also be added to .mailmap ?
> 
> ...

I don't think so. The vadfed@linux.dev items has never been a real 
address, I haven't seen any one complaining about bouncing emails from 
this address. It's just a mistake done within the patch mentioned in
Fixes tag.

