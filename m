Return-Path: <netdev+bounces-162356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 366D8A26A0A
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 03:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9E373A3B59
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 02:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61DFD137C37;
	Tue,  4 Feb 2025 02:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M8UP63wh"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD06179BD
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 02:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738636067; cv=none; b=VByBdd7npCYsQQI3pj7GZh3snZ1tS9NDQYlvhk304iEUIjabBwBt15fLeMyqdGStVFZ0MnvpRpPUMumqHnbDeOlgyig3JK+2yH0v18VthJTy6KSep0SdL2RZanokY0ViEam7KCHbMnvNFASC45thvZFT9KFd4V72rgvYu7TgO14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738636067; c=relaxed/simple;
	bh=giKV7IBfa5TNifPFNJi5zG1LfF0ATeb1RwNi6a5RaSM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhApiEPpUgnhy7wpYUeEWiBqlcJsElKGY7z2zPIaDs74YXGNhqSdwYZZhdWZO5EQEkCcNs+oCN0ZW6phdG5BXWbqc+dJPmf34bqR+gKAtnwZiQ/ecbzZR4+kGPykjGgBpWXqQDP8IsOFfdQCs9udphPKibsAWPiJuajr4+xReBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M8UP63wh; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <2706706c-3d85-4f43-ad91-d04bbb4f2b92@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738636053;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wDOjkWeZDxQA0dcDawvIHdzCfu8gPdyp1yIL9e6+a3c=;
	b=M8UP63whNboMiNhLZuEIYOh/XJdgltcMap7pkRdJ+nVALF46Czut5XMNt0uFkjdfZ2pohu
	iwSJe8zZNZIyipRrh2LfHWfMnyHkMTXfuVpwh7hPqqSLDPSa/gETU+sNP343qBRNPK4Xwo
	NF1q5sivgMhxib5RQxwY+UigCJm8fAg=
Date: Mon, 3 Feb 2025 18:27:26 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next v7 00/13] net-timestamp: bpf extension to equip
 applications transparently
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, dsahern@kernel.org, willemdebruijn.kernel@gmail.com,
 willemb@google.com, ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, horms@kernel.org, bpf@vger.kernel.org,
 netdev@vger.kernel.org
References: <20250128084620.57547-1-kerneljasonxing@gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20250128084620.57547-1-kerneljasonxing@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 1/28/25 12:46 AM, Jason Xing wrote:
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
> In this series, I only support foundamental codes and tx for TCP.

*fundamental*.

May be just "only tx time stamping for TCP is supported..."

> This approach mostly relies on existing SO_TIMESTAMPING feature, users
> only needs to pass certain flags through bpf_setsocktopt() to a separate
> tsflags. Please see the last selftest patch in this series.
> 
> After this series, we could step by step implement more advanced
> functions/flags already in SO_TIMESTAMPING feature for bpf extension.

Patch 1-4 and 6-11 can use an extra "bpf:" tag in the subject line. Patch 13 
should be "selftests/bpf:" instead of "bpf:" in the subject.

Please revisit the commit messages of this patch set to check for outdated 
comments from the earlier revisions. I may have missed some of them.

Overall, it looks close. I will review at your replies later.

Willem, could you also take a look? Thanks.


