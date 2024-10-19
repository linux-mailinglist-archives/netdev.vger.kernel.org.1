Return-Path: <netdev+bounces-137178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B02369A4AA8
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 02:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A2061F23A68
	for <lists+netdev@lfdr.de>; Sat, 19 Oct 2024 00:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11E481922F1;
	Sat, 19 Oct 2024 00:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="XJX9VvKL"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta0.migadu.com (out-187.mta0.migadu.com [91.218.175.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E21922D7
	for <netdev@vger.kernel.org>; Sat, 19 Oct 2024 00:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729298066; cv=none; b=hum09RL+oT3SGm6Bm8qN5mGlUulDxvcgOsse9h3fviEM0fgOu2KB9GdWchs7xgNd6cV+XuclUMynOZqdXILdeRTXekYm2PdHPrDcFslIk9J4KzlMGqyGKTlzTeV+nTsoxuTFXI8fgPL61lP32Hlk9YvyCr+De7bkyjJcEHfMOMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729298066; c=relaxed/simple;
	bh=kyq2Is5AVARH9C6wHc4yNYdRW2C8EsYHzw8IWrSprME=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dnK3ppr2lyqJSmU2bv+osNipCE5ZkPKVtrFDi1xse44xNr9/7ub10M0bIAONU3D/JKVvkEpRkdtlf8eYC3YmrIvRCTKX/7HVli0jlSBNnecQEXtKZKNqH4SaVQ3MIXx+b3jXq41ycAuoTUfXPXjlIApiONVQtgiz8wVV4f6oMLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=XJX9VvKL; arc=none smtp.client-ip=91.218.175.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <294f7ba3-fd7a-4c3e-b4a2-580695b604d5@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729298058;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tGiEQEanKgGvIwPUrTuB73lAsnoo0I+tviMcPgBvqEM=;
	b=XJX9VvKLRFj+Xuu7PkLG3UNrO4ySIkGiEFmvK2brgda56YiYkQ72cWENQmqQ8ZnSXs2yjI
	URWTHY5C4y0hlbm1Y7YCY0hUOidBVbSz2McZxi9DF5v+8ExDNfyGg4kN9icU9bvAplZEor
	q8gO1bMwR2gaV1/4B12Q1vrH4viUJL0=
Date: Fri, 18 Oct 2024 17:34:09 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next 6/6] selftests/bpf: remove
 test_tcp_check_syncookie
To: =?UTF-8?Q?Alexis_Lothor=C3=A9_=28eBPF_Foundation=29?=
 <alexis.lothore@bootlin.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>,
 Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 ebpf@linuxfoundation.org, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Lorenz Bauer <lmb@cloudflare.com>, bpf@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241016-syncookie-v1-0-3b7a0de12153@bootlin.com>
 <20241016-syncookie-v1-6-3b7a0de12153@bootlin.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
Content-Language: en-US
In-Reply-To: <20241016-syncookie-v1-6-3b7a0de12153@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 10/16/24 11:35 AM, Alexis Lothoré (eBPF Foundation) wrote:
>   .../bpf/progs/test_tcp_check_syncookie_kern.c      | 167 ----------------
>   .../selftests/bpf/test_tcp_check_syncookie.sh      |  85 --------
>   .../selftests/bpf/test_tcp_check_syncookie_user.c  | 213 ---------------------
Nice.

Left some comments in the earlier patches. Overall looks good. Thanks.

pw-bot: cr


