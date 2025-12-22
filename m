Return-Path: <netdev+bounces-245683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DDA5ACD5565
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 10:34:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90FDF3004B95
	for <lists+netdev@lfdr.de>; Mon, 22 Dec 2025 09:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54A4D3101A7;
	Mon, 22 Dec 2025 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BwnmJbN0"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4BFF1E5018
	for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 09:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766396093; cv=none; b=qCS5aSN4RZ7x92HsMCveQ3j8ivNMHs2oyEsyaJPsd0tmyHM82iVE2tbTz6pk6vBjAVSNs2h5a0qYL9SRb+eLtme8OP/6XqWxkurf835n+W+8aCYvgJ0nmg3AIIraLmkpW1vGAeTvtZm92hc3eaU+BwuCCQ3d/BcWIOPle32YviU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766396093; c=relaxed/simple;
	bh=Yuh0UlcHJPPpLxL6quNb2fIFWrsAC8T7M0bEg0sTCOw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PiUgZ7gQZfVGg7JPt945J4gobRd7HUoJKZFTfvJdB9GZYvUQmoDb6vmGDWmRxH2MLF2/pHkT51jhEBBpLM4vJKBesZQBTiseM5qyqc+N8L1aagxI0LReh15vLpIBWkrvijgknw//ckpnHkQ31vj+cy8pTufPd2MnZVVPZaleA1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BwnmJbN0; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cfb231cd-17bc-41aa-9533-f1a048eeb1be@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766396089;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yuh0UlcHJPPpLxL6quNb2fIFWrsAC8T7M0bEg0sTCOw=;
	b=BwnmJbN0khyfPHz+EhlpgZiGpq20M4MQdpTrS6PdJdW6y6knFR51Q3ZMNvTnM/9QFdVvfr
	+tg8dweNEFaEQtz/WGCARD33SJ6pCvLBiRHQI5BeEe6HdTsF396i9xN8sLnmjo1fkMR1gq
	Cjf/QwmK4cdOEsALW6M32TUmNGe+UUQ=
Date: Mon, 22 Dec 2025 09:34:43 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RFC net 5/5] selftests/net: use scapy for
 no_bcastnull_poison
To: =?UTF-8?B?TWFyYyBTdcOxw6k=?= <marcdevel@gmail.com>, kuba@kernel.org,
 willemdebruijn.kernel@gmail.com, pabeni@redhat.com
Cc: netdev@vger.kernel.org, dborkman@kernel.org
References: <cover.1766349632.git.marcdevel@gmail.com>
 <3cfd28edb2c2b055e74b975623a3d38ade0237f1.1766349632.git.marcdevel@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <3cfd28edb2c2b055e74b975623a3d38ade0237f1.1766349632.git.marcdevel@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 21/12/2025 21:19, Marc SuÃ±Ã© wrote:
> Use Scapy to generate ARP/ND packets for ARP/ND no bcast/NULL MAC
> poisoning.

What's wrong with current implementation in arp_send.c and ndisc_send.c?

