Return-Path: <netdev+bounces-64042-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B88830CFB
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 19:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A6641F227C8
	for <lists+netdev@lfdr.de>; Wed, 17 Jan 2024 18:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76E724200;
	Wed, 17 Jan 2024 18:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TiPrGAe3"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F9A2375A
	for <netdev@vger.kernel.org>; Wed, 17 Jan 2024 18:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705517375; cv=none; b=K5aczTnaGl4g3C7fK685EXTzituJi6ujp3MG3Bt8BkcNwt3YIjRQH/ltabXrs9UO0RQLKSrmPyXX/K7z2r2ro6QQPCYaJeHabnHCUHo6M22ClNkHvpr2veHnDsObJoRZ9avi9HEFB3FFA/tYHSv7z/o5p+6yfCQS3EMDq3KIWN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705517375; c=relaxed/simple;
	bh=Y69LbZlpmPQhSPGQgwJ5BiXU48Ysrn62Ksg1+zQQoX8=;
	h=Message-ID:DKIM-Signature:Date:MIME-Version:Subject:
	 Content-Language:To:Cc:References:X-Report-Abuse:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Migadu-Flow; b=nIbzQ8RxzA94/aF0rK4QZoWZV/etvwOhAiKNdzv/xbpv5rAhDIfM8AsWCWtNx9s066aX8Rd7ejUC348Loi1hvt1ic5shNisDLr16RJt7tycNNInWqWmjHF5vpGO/fFP6d3Vl3Xcpz3kRBVzcLbSsVCmC0lznAqHaOdz0tLdSnEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TiPrGAe3; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <13b5ab0a-e906-485d-a803-8f6150f8694c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705517371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gSkkKWJyW6XP2kgmD7ITM47qaghuiBNJxZy8Q988KOM=;
	b=TiPrGAe3/LzDi52R9LEE3Rfz+aO+sdsopo49lndi4HYWGFHhWXbobDxmbkkprjacoO2W8Q
	R625/HXLvj2Kz5C9a/PFPQf8N/ly1C46FeArbp2NtdfFWFBAAgSoxFI2mG9hcGcRPmIzyl
	5dbXWmXoFyG3P5qD3wIOpvixWzMp3BM=
Date: Wed, 17 Jan 2024 10:49:27 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [RFC iproute2 v5 1/3] ss: add support for BPF socket-local
 storage
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>
Cc: David Ahern <dsahern@gmail.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, kernel-team@meta.com, netdev@vger.kernel.org
References: <20240115164605.377690-1-qde@naccy.de>
 <20240115164605.377690-2-qde@naccy.de>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240115164605.377690-2-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/15/24 8:46 AM, Quentin Deslandes wrote:
> +static struct rtattr *bpf_map_opts_alloc_rta(void)
> +{
> +	struct rtattr *stgs_rta, *fd_rta;
> +	size_t total_size;
> +	unsigned int i;
> +	void *buf;
> +
> +	/* If bpf_map_opts.show_all == true, we will send an empty message to
> +	 * the kernel, which will return all the socket-local data attached to
> +	 * a socket, no matter their map ID. */
> +	if (bpf_map_opts.show_all) {
> +		total_size = RTA_LENGTH(0);

This addressed the issue I saw in v4. Thanks!

The set is already very useful in the current form. Thanks for working on it.

> +	} else {
> +		total_size = RTA_LENGTH(RTA_LENGTH(sizeof(int)) *
> +					bpf_map_opts.nr_maps);
> +	}


