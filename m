Return-Path: <netdev+bounces-60637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 23237820885
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 22:03:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB0F1F21CD9
	for <lists+netdev@lfdr.de>; Sat, 30 Dec 2023 21:03:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EABB6BE4B;
	Sat, 30 Dec 2023 21:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h/QRC1TQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91764C2D0
	for <netdev@vger.kernel.org>; Sat, 30 Dec 2023 21:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7b3b819f8a3so423297239f.1
        for <netdev@vger.kernel.org>; Sat, 30 Dec 2023 13:03:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703970223; x=1704575023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cr27JGMnHKz4adjvmWl46GdtF8plLDaMkL7A19QP/f0=;
        b=h/QRC1TQ+OQ9TFfMV2J4jx6irAK793z7+kBxQm//CvTNl4eaRnhTrcAdO6nODXQT39
         IbK45VdMLxDy+tpIkLWEjWw+fzZlDlVWSxno8OW0J6ozy0vwy08lJJjpNWQHYD7AHGAZ
         EQn2nqvOQ25SEjG3OmbNlp2F1fkTcIbjiWk0jpjHbOuGwaf3O2sbR+1NLpT7tpKPhVYC
         cGkn3aNG869Ip/r+s0vyewvkm+XIM8HtR45XLzmSPv9KvmYyXkJz/fwRr9lK9ZhU+eh1
         L6H02L3uY1lhEkitedyNDP5157ID7rLrerLDrWSA8ZaDmiur5+9vMkYrTn7rHnKXzhg9
         tUTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703970223; x=1704575023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cr27JGMnHKz4adjvmWl46GdtF8plLDaMkL7A19QP/f0=;
        b=rHOsKNAOUy0mtGX5te+gE2bscZ6obcQDUG5Fs/xZwBGei9UfnL9lTQPM0fC+LQBJXE
         /opugA/WaQUJN7R8DB/S72j7Hbc0z3T5pZ0vbncfHJYxh32VU465N1coEwNj+xx4kMpF
         ESsWh5gBrZX8CCHWOp2jc1lZ9xyFeSkXXqrBCIFUWs7R+iC/D8ke4y9pKhWZfE1/00/N
         OCE5S5z+4tFR5fpNmr5o+gISr3XdCGi2DKoHiy6PqQ0upqL5vZz+vtkM8RAMeLIhTR6j
         Z+PX7sxkghgBthAaYYv8/XyMg8cC2XQpsYc3HxHXUU/2s7DVw8bAkXfBrrUZGR6NLrnT
         chdw==
X-Gm-Message-State: AOJu0YxS0asCHCQZUq5RVe95ejE+KtdnDmQxdTVrFTvfEeUq0MhX4itG
	LQN1grqQQyPWuNFwDJXuWT8=
X-Google-Smtp-Source: AGHT+IFYALpQAg7VfepMUDh90Pm/PKZnPF6tWJUk0Wof5EPstQ/Yh9Kt8YbfcRC/5f9lepZ91pLg0w==
X-Received: by 2002:a05:6e02:17cf:b0:360:da7:3172 with SMTP id z15-20020a056e0217cf00b003600da73172mr9879502ilu.131.1703970223662;
        Sat, 30 Dec 2023 13:03:43 -0800 (PST)
Received: from ?IPV6:2601:282:1e82:2350:5017:6182:740b:2f80? ([2601:282:1e82:2350:5017:6182:740b:2f80])
        by smtp.googlemail.com with ESMTPSA id j33-20020a056e02222100b0035161817c37sm6402423ilf.1.2023.12.30.13.03.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 13:03:43 -0800 (PST)
Message-ID: <3f139dae-62cd-4314-81c5-b908d54b7cdc@gmail.com>
Date: Sat, 30 Dec 2023 14:03:41 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] ss: add support for BPF socket-local storage
Content-Language: en-US
To: Quentin Deslandes <qde@naccy.de>, netdev@vger.kernel.org
Cc: Martin KaFai Lau <martin.lau@kernel.org>, kernel-team@meta.com
References: <20231220132326.11246-1-qde@naccy.de>
 <20231220132326.11246-2-qde@naccy.de>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20231220132326.11246-2-qde@naccy.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

a few nits ...

On 12/20/23 8:23 AM, Quentin Deslandes wrote:
> +static struct rtattr *bpf_map_opts_alloc_rta(void)
> +{
> +	size_t total_size = RTA_LENGTH(RTA_LENGTH(sizeof(int)) * bpf_map_opts.nr_maps);

line is too long.

> +	struct rtattr *stgs_rta, *fd_rta;

move declaration here and ..

> +	unsigned int i;
> +	void *buf;
> +

set here.

> +	buf = malloc(total_size);
> +	if (!buf)
> +		return NULL;
> +
> +	stgs_rta = buf;
> +	stgs_rta->rta_type = INET_DIAG_REQ_SK_BPF_STORAGES | NLA_F_NESTED;
> +	stgs_rta->rta_len = total_size;
> +
> +	buf = RTA_DATA(stgs_rta);
> +	for (i = 0; i < bpf_map_opts.nr_maps; i++) {
> +		int *fd;
> +
> +		fd_rta = buf;
> +		fd_rta->rta_type = SK_DIAG_BPF_STORAGE_REQ_MAP_FD;
> +		fd_rta->rta_len = RTA_LENGTH(sizeof(int));
> +
> +		fd = RTA_DATA(fd_rta);
> +		*fd = bpf_map_opts.maps[i].fd;
> +
> +		buf += fd_rta->rta_len;
> +	}
> +
> +	return stgs_rta;
> +}
> +
> +static void show_sk_bpf_storages(struct rtattr *bpf_stgs)
> +{
> +	struct rtattr *tb[SK_DIAG_BPF_STORAGE_MAX + 1], *bpf_stg;
> +	unsigned int rem;
> +
> +	for (bpf_stg = RTA_DATA(bpf_stgs), rem = RTA_PAYLOAD(bpf_stgs);
> +		RTA_OK(bpf_stg, rem); bpf_stg = RTA_NEXT(bpf_stg, rem)) {
> +
> +		if ((bpf_stg->rta_type & NLA_TYPE_MASK) != SK_DIAG_BPF_STORAGE)
> +			continue;
> +
> +		parse_rtattr_nested(tb, SK_DIAG_BPF_STORAGE_MAX,
> +			(struct rtattr *)bpf_stg);
> +
> +		if (tb[SK_DIAG_BPF_STORAGE_MAP_ID]) {
> +			out("map_id:%u",
> +				rta_getattr_u32(tb[SK_DIAG_BPF_STORAGE_MAP_ID]));
> +		}
> +	}
> +}
> +
> +#endif
> +
>  static int inet_show_sock(struct nlmsghdr *nlh,
>  			  struct sockstat *s)
>  {
> @@ -3381,8 +3620,8 @@ static int inet_show_sock(struct nlmsghdr *nlh,
>  	struct inet_diag_msg *r = NLMSG_DATA(nlh);
>  	unsigned char v6only = 0;
>  
> -	parse_rtattr(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
> -		     nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)));
> +	parse_rtattr_flags(tb, INET_DIAG_MAX, (struct rtattr *)(r+1),
> +		nlh->nlmsg_len - NLMSG_LENGTH(sizeof(*r)), NLA_F_NESTED);

column alignment and I think NESTED will need to be on the next line.

>  
>  	if (tb[INET_DIAG_PROTOCOL])
>  		s->type = rta_getattr_u8(tb[INET_DIAG_PROTOCOL]);


Also, please add a patch that updates the man page for all new options.

