Return-Path: <netdev+bounces-228051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 88959BBFE88
	for <lists+netdev@lfdr.de>; Tue, 07 Oct 2025 03:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3B9294ECDE5
	for <lists+netdev@lfdr.de>; Tue,  7 Oct 2025 01:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29251E47B7;
	Tue,  7 Oct 2025 01:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="V4XBo5R9"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD908F9C1
	for <netdev@vger.kernel.org>; Tue,  7 Oct 2025 01:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759799431; cv=none; b=rGWmH85MYszPLLtglTW91patJOqldT3DR1Htn26qIg2P0wbgfj0D/9F3EowN0czwtNeShOppoaizNpbROkyHjS8N+PBiPqa5Y/Jj3CBdmiEWMdrR/p51BiFcO0HS0l9UzR3FA2oHp28jEH9v/gHH97tVPZRVwuh3sv/78OaTc48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759799431; c=relaxed/simple;
	bh=JlSaKWGuV5dim81gtrAXDpQsohCMts943PFDEhkU/Ao=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vFnPeKkcFy5mCH6Q8mS4fIwG3ark3rfDTGTuRuYqBcop1NzXU+fGiSlk2ZZ5/h0WnHIfUBzEWwrqeGYkJXCLzfCkM+ROs8kYlPM6GFU4h+1/17GDSJXdxAgM0V/AbE37aXcVFrG1pApjNNY6twypuX7AQfGviWZWBiIB7Uf7ieA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=V4XBo5R9; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759799417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=4IYA9vOqgZNsg468nDc3Sy33/MTaTQ7pzXXNVegBBCg=;
	b=V4XBo5R9e3GtTvE4tPnliRP7jzbjOuOLkj6jk04LW+fO4OraRRkoGe4U/Tj2BdSxpcegUv
	9Zy+DfP9kELq4uUtjkTjzB4V9VOVOfq3O9s1AbH0xMBryQVXPfio1m2yHO9mXGkEcckROO
	NALsV4+6wrPwFGLI2P74KaiWqAu6ur0=
From: Roman Gushchin <roman.gushchin@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>,  Andrii Nakryiko
 <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,  Martin
 KaFai Lau <martin.lau@linux.dev>,  John Fastabend
 <john.fastabend@gmail.com>,  Stanislav Fomichev <sdf@fomichev.me>,  "David
 S. Miller" <davem@davemloft.net>,  Eric Dumazet <edumazet@google.com>,
  Jakub Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Neal
 Cardwell <ncardwell@google.com>,  Willem de Bruijn <willemb@google.com>,
  Mina Almasry <almasrymina@google.com>,  Kuniyuki Iwashima
 <kuni1840@gmail.com>,  bpf@vger.kernel.org,  netdev@vger.kernel.org
Subject: Re: [PATCH bpf-next/net 0/6] bpf: Allow opt-out from
 sk->sk_prot->memory_allocated.
In-Reply-To: <20251007001120.2661442-1-kuniyu@google.com> (Kuniyuki Iwashima's
	message of "Tue, 7 Oct 2025 00:07:25 +0000")
References: <20251007001120.2661442-1-kuniyu@google.com>
Date: Mon, 06 Oct 2025 18:10:09 -0700
Message-ID: <87ldlnfrf2.fsf@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Kuniyuki Iwashima <kuniyu@google.com> writes:

> This series allows opting out of the global per-protocol memory
> accounting if socket is configured as such by sysctl or BPF prog.
>
> This series is v11 of the series below [0], but I start as a new series
> because the changes now fall in net and bpf subsystems only.
>
> I discussed with Roman Gushchin offlist, and he suggested not mixing
> two independent subsystems and it would be cleaner not to depend on
> memcg.
>
> So, sk->sk_memcg and memcg code are no longer touched, and instead we
> use another hole near sk->sk_prot to store a flag for the net feature.
>
> Overview of the series:
>
>   patch 1 is misc cleanup
>   patch 2 allows opt-out from sk->sk_prot->memory_allocated
>   patch 3 introduces net.core.bypass_prot_mem
>   patch 4 & 5 supports flagging sk->sk_bypass_prot_mem via bpf_setsockopt()
>   patch 6 is selftest

Acked-by: Roman Gushchin <roman.gushchin@linux.dev>
for the series.

Thanks!

