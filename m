Return-Path: <netdev+bounces-211789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D434B1BB9F
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 23:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78FFF18A7875
	for <lists+netdev@lfdr.de>; Tue,  5 Aug 2025 21:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0271A21FF2D;
	Tue,  5 Aug 2025 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Z+UzRteo"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2181632
	for <netdev@vger.kernel.org>; Tue,  5 Aug 2025 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754428052; cv=none; b=PPkj83DjMxttLyYZEVni5ErTV4dpRW2XbigtCV2qG4DSsb5xN+oCarfUVzf4jpE2l2H+7FAjky2HfFEtIbIvPESMIGo40vem8QIsq8L6RuTbw9Cm3R5JTbtNmOe28Lwt+aMmvq0OUt+oicLBTfS1BkXfx49+KuW4ZUpQFAwdz1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754428052; c=relaxed/simple;
	bh=n2tBJeLU4Jj59vch1TZH2lZrproxwWqESixZE6iNuGw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JC/fAGcRg+UvuDBHf1X6skcMfcTiy0tVTe3IPYG/1q7/fmBm8+MmPdC+ZeroJbZ6FV1G3P4z7P998v22+/oVmHCaXZlDdqhSblV53CDIpJAiQRbs74WW/ck9zZ2sVWYRGiSsfJRdlaD1w9lv9wUMxDDu2si/LL8YS6r0aF7OYhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Z+UzRteo; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <f871d538-31b8-437a-b838-900836e13eb8@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1754428047;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTH8lCWv5fN9/GBV5Io17kAeDOePVc99yGeJbJcOZJA=;
	b=Z+UzRteoLWVMxtusmEg9JJXb6xa1X/ZavAoXN1v+DBcOUbSJjY5mEhMmApRj++hC7sKDSF
	RSFmt+2HkmMG6mBBQv9isTNH6LSBe3yEbRfbFC8nCPXgNN7GLxhRJJcM0Qkeb2inImtGS6
	D3JWdUBe1tV3dM6/FINf2FfRYpzlh/o=
Date: Tue, 5 Aug 2025 14:07:20 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpf: Add LINK_DETACH for iter and perf links
Content-Language: en-GB
To: Florian Lehner <dev@der-flo.net>, bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 john.fastabend@gmail.com, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, davem@davemloft.net, kuba@kernel.org,
 hawk@kernel.org, netdev@vger.kernel.org
References: <20250801121053.7495-1-dev@der-flo.net>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250801121053.7495-1-dev@der-flo.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 8/1/25 5:10 AM, Florian Lehner wrote:
> 73b11c2a introduced LINK_DETACH and implemented it for some link types,
> like xdp, netns and others.
>
> This patch implements LINK_DETACH for perf and iter links, re-using
> existing link release handling code.
>
> Signed-off-by: Florian Lehner <dev@der-flo.net>
> ---
>   kernel/bpf/bpf_iter.c | 7 +++++++
>   kernel/bpf/syscall.c  | 7 +++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
> index 0cbcae727079..823dad09735d 100644
> --- a/kernel/bpf/bpf_iter.c
> +++ b/kernel/bpf/bpf_iter.c
> @@ -397,6 +397,12 @@ static void bpf_iter_link_release(struct bpf_link *link)
>   		iter_link->tinfo->reg_info->detach_target(&iter_link->aux);
>   }
>   
> +static int bpf_iter_link_detach(struct bpf_link *link)
> +{
> +	bpf_iter_link_release(link);
> +	return 0;
> +}
> +
>   static void bpf_iter_link_dealloc(struct bpf_link *link)
>   {
>   	struct bpf_iter_link *iter_link =
> @@ -490,6 +496,7 @@ static int bpf_iter_link_fill_link_info(const struct bpf_link *link,
>   
>   static const struct bpf_link_ops bpf_iter_link_lops = {
>   	.release = bpf_iter_link_release,
> +	.detach = bpf_iter_link_detach,

Not sure how useful for this one. For bpf_iter programs,
the loaded prog will expect certain bpt_iter (e.g., bpf_map_elem, bpf_map, ...).
So even if you have detach, you won't be able to attach to a different
bpf_iter flavor.

Do you have a use case for this one?

>   	.dealloc = bpf_iter_link_dealloc,
>   	.update_prog = bpf_iter_link_replace,
>   	.show_fdinfo = bpf_iter_link_show_fdinfo,
> diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
> index e63039817af3..e89694f6874a 100644
> --- a/kernel/bpf/syscall.c
> +++ b/kernel/bpf/syscall.c
> @@ -3733,6 +3733,12 @@ static void bpf_perf_link_release(struct bpf_link *link)
>   	fput(perf_link->perf_file);
>   }
>   
> +static int bpf_perf_link_detach(struct bpf_link *link)
> +{
> +	bpf_perf_link_release(link);
> +	return 0;
> +}
> +
>   static void bpf_perf_link_dealloc(struct bpf_link *link)
>   {
>   	struct bpf_perf_link *perf_link = container_of(link, struct bpf_perf_link, link);
> @@ -4027,6 +4033,7 @@ static void bpf_perf_link_show_fdinfo(const struct bpf_link *link,
>   
>   static const struct bpf_link_ops bpf_perf_link_lops = {
>   	.release = bpf_perf_link_release,
> +	.detach = bpf_perf_link_detach,

This one may be possible. You might be able to e.g., try a different bpf_cookie, or
different perf event.

>   	.dealloc = bpf_perf_link_dealloc,
>   	.fill_link_info = bpf_perf_link_fill_link_info,
>   	.show_fdinfo = bpf_perf_link_show_fdinfo,


