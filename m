Return-Path: <netdev+bounces-140808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FE69B847A
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 21:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E1C521F23204
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 20:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6711C9ED4;
	Thu, 31 Oct 2024 20:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="drkgFHgi"
X-Original-To: netdev@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF401531C0
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 20:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730407187; cv=none; b=azE20mBNoQPrhD3Bj30RV2bRLj3VZpVXx1eVHiM3JrP5uKsiJDV1dz/CrfqgyZZ/A6bSz1UmcL+ODyu0Jxt8NKCvZn0fUl6ys0X0MJwzlebc/7kX8gBSABY9mPN0OgC5sj5Xh5wsk2csWiRc76HTJ6WTdfDVZ1Ees/t4zBuJNXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730407187; c=relaxed/simple;
	bh=pwQJMig8pqTMJYRWafVSMjffQIxCG7FoU2oK/45uC+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8eAQSGFZNSEsXQz4JTGP5dDyNP80qsNCFNXXaaem0rrjvT4lSeSUJIpZh///VlDEFaLc3csuo4pXGEMYLc7ws11PDN5lWhZy+eHiBRt55/rb/oW45mxXr2N2t7xEMraw7IkGNTHVox8gtRFzSs7DPl5A/0GZ7Fr/Umw248VyQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=drkgFHgi; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e03cfadc-8720-4351-a83b-cc8d4566f53f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730407182;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pwQJMig8pqTMJYRWafVSMjffQIxCG7FoU2oK/45uC+k=;
	b=drkgFHgi7h2weZ1Ltf7O1cbmKY7B/NIqjeXyGM1EzLZBbu4VPEX9XspbTNml+m4a521W5u
	+yb+pKpIVCPk/BAEb8pSbDWJQ1t9HXiayucaWATdMbYvB5Ev7RLc8vFG/cSzncGbbx4fof
	Ti3ByPDsHVHwTsIfoNkjR7K4/qumdgg=
Date: Thu, 31 Oct 2024 13:39:36 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Add kernel symbol for struct_ops trampoline
Content-Language: en-GB
To: Xu Kuohai <xukuohai@huaweicloud.com>, bpf@vger.kernel.org,
 netdev@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman
 <eddyz87@gmail.com>, Kui-Feng Lee <thinker.li@gmail.com>
References: <20241030111533.907289-1-xukuohai@huaweicloud.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20241030111533.907289-1-xukuohai@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 10/30/24 4:15 AM, Xu Kuohai wrote:
> From: Xu Kuohai <xukuohai@huawei.com>
>
> Without kernel symbols for struct_ops trampoline, the unwinder may
> produce unexpected stacktraces.
>
> For example, the x86 ORC and FP unwinders check if an IP is in kernel
> text by verifying the presence of the IP's kernel symbol. When a
> struct_ops trampoline address is encountered, the unwinder stops due
> to the absence of symbol, resulting in an incomplete stacktrace that
> consists only of direct and indirect child functions called from the
> trampoline.

Please give some concrete examples here, e.g. stack trace before and
after this patch, so it will be clear what is fixed.

>
> The arm64 unwinder is another example. While the arm64 unwinder can
> proceed across a struct_ops trampoline address, the corresponding
> symbol name is displayed as "unknown", which is confusing.
>
> Thus, add kernel symbol for struct_ops trampoline. The name is
> bpf_trampoline_<PROG_NAME>, where PROG_NAME is the name of the
> struct_ops prog linked to the trampoline.
>
> Fixes: 85d33df357b6 ("bpf: Introduce BPF_MAP_TYPE_STRUCT_OPS")
> Signed-off-by: Xu Kuohai <xukuohai@huawei.com>

There is a warning in kernel test bot, please fix it. Otherwise,
the patch LGTM. I also tried with one struct_ops example and it
does show full *good* stack with this patch, and without
this patch, the backtrace stops right before trampoline symbols.

Acked-by: Yonghong Song <yonghong.song@linux.dev>


