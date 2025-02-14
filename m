Return-Path: <netdev+bounces-166554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8E2A3670D
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 21:43:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D798F3B219B
	for <lists+netdev@lfdr.de>; Fri, 14 Feb 2025 20:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B54491C8611;
	Fri, 14 Feb 2025 20:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N/+ROcA4"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8023193086
	for <netdev@vger.kernel.org>; Fri, 14 Feb 2025 20:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739565800; cv=none; b=ZsUaDfGUZYz0P5q0vMl92/iMhIJgsioF7ELlF7gZ1UALA028TMU3eLhCPWYuLWyoET5vB3yu5dw1pPaRkjz7ahPCS3w/QtmCGwlsSlqWsF85SAj2oGMcplQt/M34/7rwV63ovOjor3kYczalgCVfpbu2FjBJ1GTzulyliOsChyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739565800; c=relaxed/simple;
	bh=28b8zhdrUU4bm/CmeTmiGV3nUJqUZ3vT4wExJKP2z4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ruZRDPOhcGSQQd0bQluWWr7YPJKjJV2cduz1GQci5Yao68HO21nStanfT1sTTR/d8K4S0pcN88uFwmTnZzuSf/WC15JfEmnGVJoMbBp+K1VhafHQ3yMrIDop7B3W1MbH3KrVclux+rp3AIGH6jZM+GNzaz5fRj+QxUM4vRBT60Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N/+ROcA4; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <035d99ac-0f39-444d-bf2a-68d46f0e22a2@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1739565786;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/6YzWD7f/jPVk7pR5S1OI8mishtn1WCwM57dNK163eQ=;
	b=N/+ROcA4831LPC27mULzuAyAblhQtlrkiwtP/rtcTDfhWG+vlxZQ8v+n/+8SwYntYeFQnW
	HglQw6YPkEy0HXyASEMWFAy/8AZFpduVWrgMnG2URH1CE15fJDQcXVxuJdzbYgXawPyirv
	zEpOPpUdQIflTe2Ebb+nCEa3sVq8/Z4=
Date: Fri, 14 Feb 2025 12:42:59 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v11 00/12] net-timestamp: bpf extension to equip
 applications transparently
To: Jason Xing <kerneljasonxing@gmail.com>, willemdebruijn.kernel@gmail.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemb@google.com, ast@kernel.org,
 daniel@iogearbox.net, andrii@kernel.org, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@fomichev.me, haoluo@google.com, jolsa@kernel.org, horms@kernel.org,
 bpf@vger.kernel.org, netdev@vger.kernel.org
References: <20250214010038.54131-1-kerneljasonxing@gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20250214010038.54131-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 2/13/25 5:00 PM, Jason Xing wrote:
> "Timestamping is key to debugging network stack latency. With
> SO_TIMESTAMPING, bugs that are otherwise incorrectly assumed to be
> network issues can be attributed to the kernel." This is extracted
> from the talk "SO_TIMESTAMPING: Powering Fleetwide RPC Monitoring"
> addressed by Willem de Bruijn at netdevconf 0x17).
> 
> There are a few areas that need optimization with the consideration of
> easier use and less performance impact, which I highlighted and mainly
> discussed at netconf 2024 with Willem de Bruijn and John Fastabend:
> uAPI compatibility, extra system call overhead, and the need for
> application modification. I initially managed to solve these issues
> by writing a kernel module that hooks various key functions. However,
> this approach is not suitable for the next kernel release. Therefore,
> a BPF extension was proposed. During recent period, Martin KaFai Lau
> provides invaluable suggestions about BPF along the way. Many thanks
> here!
> 
> This series adds the BPF networking timestamping infrastructure through
> reusing most of the tx timestamping callback that is currently enabled
> by the SO_TIMESTAMPING.. This series also adds TX timestamping support
> for TCP. The RX timestamping and UDP support will be added in the future.
> 
> ---
> v10
> Link: https://lore.kernel.org/all/20250212061855.71154-1-kerneljasonxing@gmail.com/
> 1. rename hwts with hwtimestamp
> 2. use subtest and pid filter in selftest
> 3. use 'tcb->txstamp_ack |= TSTAMP_ACK_SK'

Overall looks good. I only have two minor comments.

Willem, can you also take another look and ack if it looks good to you? Thanks.


