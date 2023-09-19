Return-Path: <netdev+bounces-34849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 013357A57BD
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 05:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF9B5281D02
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 03:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF92328AA;
	Tue, 19 Sep 2023 03:06:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06EB1450E6
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 03:06:20 +0000 (UTC)
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D565103
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:06:15 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-792965813e7so196992739f.2
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:06:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695092774; x=1695697574; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7rv+duVn553c84vLh3bOZ24G78S9y2SSVG6Psafjy4s=;
        b=OTgfKlqzYNjw0XptgGlI2UarcoJs26QOcRomPLGznVKspBu7wxpnGb/AMHCAXrgiIp
         7gZSV1FzwcI5QRRbGcqvqHOHH9XL9wfz3aU4izIfSZwD+sQGtUcjVqDVGjDqGKrIyKHX
         bxJYM2jLs8yjBakdhM+WbhN2eOI+wAAy6ttOlb1Gymnv/9Dovll05k6B+WvYlrR0VCES
         KJPrhx16RZWTjs/3ouoUilKw6dgYvffYutUuXsfA8CXVtl8wvCRoCl+bIduD9r/97Ze6
         0TtN2ktb2GuGFazXlF+/AomjDeoUsrvn6kq9f7kZJ0Q6QyldYOL6CW4VNl9HaDZSADYf
         99cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695092774; x=1695697574;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7rv+duVn553c84vLh3bOZ24G78S9y2SSVG6Psafjy4s=;
        b=VEmkjOqgqq+GLnVSRfMTp6DU3WPDXTB67zMnFvoEHyGlS0aTt0aHjbOFf4Hq7CsstI
         rVGNiJs35w21VVie/Pwn5LbkYzuUPmCrnm8j72A9UEra9m8WTPa8UTcAgnjS3vfW+uoi
         A7LLLBKesMfU5ZyFcqd9KwyI/+7z/fOmTTh0dyp+dc/MHWkGiiOL0G0a6puAvfX7GKsS
         rK4rNJUa2G9oO/OGEqa9sYy29rhF06v5igeMSEbaKSuXa+gMh6kV9qUQyc66m9kDlKXa
         GgRReQ6q2psD+9sdWXDY8mz90rOFsGqOxM+QX6XDJnuGtLfYF4flQBVIwc8WOS3u4QH0
         kevA==
X-Gm-Message-State: AOJu0YwgLmynEIuDZ9E/y7nJESp2kxa8M89O0X8+oUb3E/5KMA38hjE6
	IhbVND5TwG3pdszE/zFRQAM=
X-Google-Smtp-Source: AGHT+IGRixk5Yf73FfGcPE7dpw9hnWg+hD9nz6JLQaY/oOw1feWBXIdgXhP/Yr/6ig3YHKGNmD2tjw==
X-Received: by 2002:a5e:8e02:0:b0:790:fc73:6e3c with SMTP id a2-20020a5e8e02000000b00790fc736e3cmr12460787ion.8.1695092774331;
        Mon, 18 Sep 2023 20:06:14 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:a8ed:9f3d:7434:4c90? ([2601:282:1e82:2350:a8ed:9f3d:7434:4c90])
        by smtp.googlemail.com with ESMTPSA id t4-20020a02cca4000000b0042b669f5084sm3257918jap.62.2023.09.18.20.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 20:06:13 -0700 (PDT)
Message-ID: <628fff39-307f-c848-f72e-4ed8c682b34e@gmail.com>
Date: Mon, 18 Sep 2023 21:06:12 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [patch iproute2-next 2/4] devlink: introduce support for netns id
 for nested handle
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org
Cc: stephen@networkplumber.org
References: <20230918105416.1107260-1-jiri@resnulli.us>
 <20230918105416.1107260-3-jiri@resnulli.us>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20230918105416.1107260-3-jiri@resnulli.us>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/18/23 4:54 AM, Jiri Pirko wrote:
>  static const enum mnl_attr_data_type
> @@ -2723,6 +2725,85 @@ static bool should_arr_last_handle_end(struct dl *dl, const char *bus_name,
>  	       !cmp_arr_last_handle(dl, bus_name, dev_name);
>  }
>  
> +static int32_t netns_id_by_name(const char *name)
> +{
> +	struct {
> +		struct nlmsghdr n;
> +		struct rtgenmsg g;
> +		char            buf[1024];
> +	} req = {
> +		.n.nlmsg_len = NLMSG_LENGTH(sizeof(struct rtgenmsg)),
> +		.n.nlmsg_flags = NLM_F_REQUEST,
> +		.n.nlmsg_type = RTM_GETNSID,
> +		.g.rtgen_family = AF_UNSPEC,
> +	};
> +	int ret = NETNSA_NSID_NOT_ASSIGNED;
> +	struct rtattr *tb[NETNSA_MAX + 1];
> +	struct nlmsghdr *n = NULL;
> +	struct rtnl_handle rth;
> +	struct rtgenmsg *rtg;
> +	int len;
> +	int fd;
> +
> +	fd = netns_get_fd(name);
> +	if (fd < 0)
> +		return ret;
> +
> +	if (rtnl_open(&rth, 0) < 0)
> +		return ret;
> +
> +	addattr32(&req.n, sizeof(req), NETNSA_FD, fd);
> +	if (rtnl_talk(&rth, &req.n, &n) < 0)
> +		goto out;
> +
> +	if (n->nlmsg_type == NLMSG_ERROR)
> +		goto out;
> +
> +	rtg = NLMSG_DATA(n);
> +	len = n->nlmsg_len;
> +
> +	len -= NLMSG_SPACE(sizeof(*rtg));
> +	if (len < 0)
> +		goto out;
> +
> +	parse_rtattr(tb, NETNSA_MAX, NETNS_RTA(rtg), len);
> +	if (tb[NETNSA_NSID])
> +		ret = rta_getattr_s32(tb[NETNSA_NSID]);
> +
> +out:
> +	free(n);
> +	rtnl_close(&rth);
> +	close(fd);
> +	return ret;
> +}

duplicates get_netnsid_from_name


