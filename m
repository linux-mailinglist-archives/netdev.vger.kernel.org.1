Return-Path: <netdev+bounces-149871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4347A9E7DD7
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 02:51:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02E8B2848A9
	for <lists+netdev@lfdr.de>; Sat,  7 Dec 2024 01:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A7EC171BB;
	Sat,  7 Dec 2024 01:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="l3FVDh9j"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD36AD27E
	for <netdev@vger.kernel.org>; Sat,  7 Dec 2024 01:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733536271; cv=none; b=ckSwvZXjPraDxsas7iJKfT1f89pR0BSt0xNbh/na3v9tbcWaWe/+3OD6+sEMGNc/DMe3P0U0rAExvA0WNU/O7LWlLrprK0/Lgs986dXZh0+ey+/wR+lnS2ODfdMhol2jf1ihAEnXq6s5sQYbqFFdGL/bGOdmbDvtwk+qmbUk3Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733536271; c=relaxed/simple;
	bh=fL7UgSvlHvMOgpr+wPg1Prhg27LhYkeiNrwhukxPxjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=npn0uZaJiY04KBI36ZANjmXxgDX0GgF34uGYThnoCc4JKfilaTxm3/JceTg0i9PueK9dsRMQJrifz1l64BS5r8QtzeNgJi1ZUuV5nRH7D9rnm4QmjudqL+ktf2d6/KUaiENCgZof/qNceplYtPZx5CZOoqGRpdA+TfAvQJYie3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=l3FVDh9j; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8da87bf2-0084-4a47-b138-5dc380e7435e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1733536263;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hHDUiCEzwKu1N3+3UCTS+tkCA5hseC4uMepQ7EbCmQ=;
	b=l3FVDh9j0DesQ/bzbfzNcrC0HfvbklRHq9WKxticSISzdnSwGz8FCUBgsXM87X/UsjfAxH
	iDAwzLh1ZtG/ecH26S3ZhGhVmUHg5tOI5QJUplC6p7XrK6vdfg0JfAezoWgFmjUigmlydu
	EGcLT1SSSlzIvqoggx3zt3u5Jnim1Yo=
Date: Fri, 6 Dec 2024 17:50:51 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf-next] bpftool: btf: Support dumping a single type from
 file
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: ast@kernel.org, kuba@kernel.org, andrii@kernel.org, hawk@kernel.org,
 qmo@kernel.org, john.fastabend@gmail.com, davem@davemloft.net,
 daniel@iogearbox.net, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@fomichev.me,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, antony@phenome.org,
 toke@kernel.org
References: <8ae2c1261be36f7594a7ba0ac2d1e0eeb10b457d.1733527691.git.dxu@dxuuu.xyz>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <8ae2c1261be36f7594a7ba0ac2d1e0eeb10b457d.1733527691.git.dxu@dxuuu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/6/24 3:29 PM, Daniel Xu wrote:
> diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
> index d005e4fd6128..668ff0d10469 100644
> --- a/tools/bpf/bpftool/btf.c
> +++ b/tools/bpf/bpftool/btf.c
> @@ -953,6 +953,7 @@ static int do_dump(int argc, char **argv)
>   		NEXT_ARG();
>   	} else if (is_prefix(src, "file")) {
>   		const char sysfs_prefix[] = "/sys/kernel/btf/";
> +		char *end;
>   
>   		if (!base_btf &&
>   		    strncmp(*argv, sysfs_prefix, sizeof(sysfs_prefix) - 1) == 0 &&
> @@ -967,6 +968,17 @@ static int do_dump(int argc, char **argv)
>   			goto done;
>   		}
>   		NEXT_ARG();
> +
> +		if (argc && is_prefix(*argv, "root_id")) {
> +			NEXT_ARG();
> +			root_type_ids[root_type_cnt++] = strtoul(*argv, &end, 0);

I only looked at the do_dump(). Other existing root_type_ids are from the kernel 
map_get_info and they should be valid. I haven't looked at the dump_btf_*, so 
ask a lazy question, is an invalid root_id handled properly?

Others lgtm.

> +			if (*end) {
> +				err = -1;
> +				p_err("can't parse %s as root ID", *argv);
> +				goto done;
> +			}
> +			NEXT_ARG();
> +		}
>   	} else {
>   		err = -1;
>   		p_err("unrecognized BTF source specifier: '%s'", src);


