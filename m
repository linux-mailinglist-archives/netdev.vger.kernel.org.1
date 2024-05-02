Return-Path: <netdev+bounces-93139-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C46C08BA425
	for <lists+netdev@lfdr.de>; Fri,  3 May 2024 01:39:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FAE32825BC
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 23:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73564153827;
	Thu,  2 May 2024 23:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="oo2UZqqe"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC18757C99
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 23:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714693161; cv=none; b=qQ6lVAUe4eQQEq99LKiq3gXGIUsIMJ3+CbQwkT7adfpwDFEyiktcItrmJWJhAoBHEgUuBpJN2tIb9VNpe+IzhTPqFTy+TPctJqPwzkDCDZ+84+l5Dz0DVHw8gh61y3sc4OsvKP0M1jg6XQU1lTD55259HjzQGLNSfueAvghXEF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714693161; c=relaxed/simple;
	bh=GK9xI1MmSlOzhapTknrbKNCbWi3Zk586qJQBqrNAhDM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=udb9UOSwvhErgT5WsK1d9ILrPREf01sm4U32BmzvAJ9DILSr3d7ufDgCtb/+uH01KLbQmOqhjeZSXDyfetPVftlbFNtNVgFnOPkId8jh0R1vb3bHOF3+xbcw4CKvgV+MlR7kScpfNBwoY+x7crUa3/d60P8oltUsrbjKt0gaFQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=oo2UZqqe; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <dc051219-5da9-4de9-87fc-82db4c870c3e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1714693155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7+OYu68/VM5ElvGQT9jeiRSgGoDTW9xL8fqocP25lQo=;
	b=oo2UZqqeSiMX7jWWokh3AhyW36QZ46ZcR0gmtWbMcYw+86bzvQjDGiMgD0zQoecdwbgCMH
	3HRDKRdJg+8FRvBe1od249uuJEmlwX7MVbHdwi4tkaDgrq8CiQEJSBWU34w+yVqN3jOCF+
	T3pQN/PHnJu8cUjxHgBhfoDobOQiBe4=
Date: Thu, 2 May 2024 16:39:07 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3 3/3] selftests/bpf: Add test for the use of
 new args in cong_control
To: Miao Xu <miaxu@meta.com>
Cc: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, David Ahern <dsahern@kernel.org>,
 Martin Lau <kafai@meta.com>, netdev@vger.kernel.org, bpf@vger.kernel.org
References: <20240502042318.801932-1-miaxu@meta.com>
 <20240502042318.801932-4-miaxu@meta.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20240502042318.801932-4-miaxu@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 5/1/24 9:23 PM, Miao Xu wrote:
> This patch adds a selftest to show the usage of the new arguments in
> cong_control. For simplicity's sake, the testing example reuses cubic's
> kernel functions.
> ---
> Changes in v3:
> * Renamed the selftest file and the bpf struct_ops' name.
> * Minor changes such as removing unused comments.
> 
> Changes in v2:
> * Added highlights to explain major differences between the bpf program
> and tcp_cubic.c.
> * bpf_tcp_helpers.h should not be further extended, so remove the
>    dependency on this file. Use vmlinux.h instead.
> * Minor changes such as indentation.
> 
> Signed-off-by: Miao Xu <miaxu@meta.com>
> ---
>   .../selftests/bpf/progs/bpf_cc_cubic.c        | 206 ++++++++++++++++++

I just noticed that the bpf_cc_cubic is not run by the test_progs. I have added 
a test to prog_tests/bpf_tcp_ca.c to do that.

I also fixed up your SOB.

Applied. Thanks.

>   .../selftests/bpf/progs/bpf_tracing_net.h     |  10 +
>   2 files changed, 216 insertions(+)
>   create mode 100644 tools/testing/selftests/bpf/progs/bpf_cc_cubic.c


