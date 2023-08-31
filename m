Return-Path: <netdev+bounces-31626-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63FC178F190
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 18:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2F928168C
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 16:58:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91F5418C20;
	Thu, 31 Aug 2023 16:58:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817D3E57F
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 16:58:27 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF8C1107
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 09:58:25 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401b5516104so10003505e9.2
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 09:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1693501104; x=1694105904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ymn3azl+ScmGyPjO3oOg448+KpidrafzQafY6W6ymC0=;
        b=LruVMMvKaPaQOHBp6u09F1Y18jzjswvDiPeo/sVIP5Z4PxVQ7tdnVW0ztRYBjs0Ifa
         csD6tfao9EI5SF0FRiPwcousnmwfcbt9CiWyL0p4jOlQPa8MwoMDa4V1WYU/KEFC/Z3s
         zGLFvqBr25kr9eCIknMtqfDQ38H+fShWfBSqJCTGMEepUyqE5Ab2b8yECwAQupA66SPX
         UvqUqiYTqtTL7grFEmGTT+/lzVLO7n9MCgmJHj6VNOTVxLFvspHhSaiZZcUf2bUbi8G6
         /6j6t9h6d46jh7AgZJKlpAfoKkqTikY/Dvn8fMxw6+tEpqIpYHp5MCo127QWId1BFBRU
         tauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693501104; x=1694105904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ymn3azl+ScmGyPjO3oOg448+KpidrafzQafY6W6ymC0=;
        b=Kv3w/VQnHL5k03w4AgA3g4w4oG4+82kEQvaZPSx4FaTyvLZ54PyDCqDnoH2E+P/IID
         yBlUSdrOG1v1BbyFIT/WL5IFagiEGyNtusZ//5QFMbnJda9/kqOz6D7/0eESQVR0SB+e
         OTQVNM3IH8lclmBVCY61BDozVIFg6a9wZlugJh1a3Aktmy6InZbCZ0gfSP6s9tTOXQiG
         E4u+xkaKnfkGaMTWlr8Amb+xZsph3LC8A+8Ol+2GG6L257iQmqa7CX5c7OUWN1ueFMe6
         m5KLQ4sGIoUheRUv+ZCp2vQ4WZKvLYB3uquD3PAei8upc/0XyMuyhKnwSTvT0WQApeXA
         NDeg==
X-Gm-Message-State: AOJu0Yysb5BsWk7PpXZ7DNj4mVrY3Sl4dTh1kZhDV2gM19FD4fEBZnc/
	1xy7gSyNfKnEzVsdgiAANDe3vw==
X-Google-Smtp-Source: AGHT+IFOUsI6eFJ17qu/fO5dGue7InUW+VcH88IT/1Dp5OagpUUf2LZ08n3sp3NqUKUY+vyrFB1DVA==
X-Received: by 2002:a7b:c453:0:b0:3fb:a102:6d7a with SMTP id l19-20020a7bc453000000b003fba1026d7amr4368492wmi.28.1693501104291;
        Thu, 31 Aug 2023 09:58:24 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:791d:1b48:cf5a:273d? ([2a02:8011:e80c:0:791d:1b48:cf5a:273d])
        by smtp.gmail.com with ESMTPSA id m13-20020a7bce0d000000b003fed630f560sm2512350wmc.36.2023.08.31.09.58.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 09:58:23 -0700 (PDT)
Message-ID: <d3ba2fc4-2210-418c-ac56-6b3af7ef1cce@isovalent.com>
Date: Thu, 31 Aug 2023 17:58:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next v3 6/9] bpftool: Add support for cgroup unix
 socket address hooks
Content-Language: en-GB
To: Daan De Meyer <daan.j.demeyer@gmail.com>, bpf@vger.kernel.org
Cc: martin.lau@linux.dev, kernel-team@meta.com, netdev@vger.kernel.org
References: <20230831153455.1867110-1-daan.j.demeyer@gmail.com>
 <20230831153455.1867110-7-daan.j.demeyer@gmail.com>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230831153455.1867110-7-daan.j.demeyer@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 31/08/2023 16:34, Daan De Meyer wrote:
> Add the necessary plumbing to hook up the new cgroup unix sockaddr
> hooks into bpftool.
> 
> Signed-off-by: Daan De Meyer <daan.j.demeyer@gmail.com>
> ---
>  .../bpftool/Documentation/bpftool-cgroup.rst  | 23 ++++++++++++++-----
>  .../bpftool/Documentation/bpftool-prog.rst    | 10 ++++----
>  tools/bpf/bpftool/bash-completion/bpftool     | 14 +++++------
>  tools/bpf/bpftool/cgroup.c                    | 17 ++++++++------
>  tools/bpf/bpftool/prog.c                      |  9 ++++----
>  5 files changed, 45 insertions(+), 28 deletions(-)
> 
> diff --git a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> index bd015ec9847b..19dba2b55246 100644
> --- a/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst
> +++ b/tools/bpf/bpftool/Documentation/bpftool-cgroup.rst

> @@ -98,25 +101,33 @@ DESCRIPTION
>  		  **device** device access (since 4.15);
>  		  **bind4** call to bind(2) for an inet4 socket (since 4.17);
>  		  **bind6** call to bind(2) for an inet6 socket (since 4.17);
> +		  **bindun** call to bind(2) for a unix socket (since 6.3);
I missed it earlier - kernel version (6.3) won't be correct, please
update it for the next iteration.

Bpftool changes look all good otherwise, thank you!

Acked-by: Quentin Monnet <quentin@isovalent.com>

