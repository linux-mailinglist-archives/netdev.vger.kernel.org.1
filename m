Return-Path: <netdev+bounces-36265-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1417AEB4F
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 13:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 063651F2590D
	for <lists+netdev@lfdr.de>; Tue, 26 Sep 2023 11:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0ED266D6;
	Tue, 26 Sep 2023 11:19:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF20266C9
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 11:19:08 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC45410E
	for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 04:19:06 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-404314388ceso91755415e9.2
        for <netdev@vger.kernel.org>; Tue, 26 Sep 2023 04:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1695727145; x=1696331945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ojE+prwSKtzPXYd9eFa+SVcSJ14O2nJ11QeixBfVSIk=;
        b=Gle24KXBpNqTNsBwk6bbh2p9B5a0oaIMpzItvJbAbBUcA5wC+Ehes7iyKGCiRxNWWX
         wl7T43qYtZMLG8iirHryz5f0/fJErvNaFiK1p5zoKom9LmiypP9Z7hInSV4661zmaRzA
         mrSD67Dt2jlWFi3czoEMxwyEaYBzxEnUTIqsYPZqxD2dTuAaqe1n8P85EH4XQRk2VfEA
         hwQZlmOuLpEPI3WtZdShHssMZ8RNyYS4MRGshPubRFCEfhXGZqY8LWOX24cS6mYt7nyo
         WC5chirhjQu2+TPgqTY8VulZqyRtAIWH7YpLkUn67nfMCh5ZsIIbFYUHq8ZHjmM06TXB
         A+sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695727145; x=1696331945;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ojE+prwSKtzPXYd9eFa+SVcSJ14O2nJ11QeixBfVSIk=;
        b=xIYH9dljBV3FcjeO1znWpsCLupL1Lc2v3FVB0DkoJqi7VrVO0HLKxe6IeT9JBxiaCh
         ogAc2uTn++nN7AaZ5lUHSNWhdV8H+bMNL7Q+Va+arviFqC9vcm8T+nE103NlpLcpsuCr
         0nwA5gu/fYktPCVnvSdDKsUqJSB8TLNhVxwrQIbenpyf3Hw6OLpLaGw2VGoigXpPthwK
         6VfaIk3ZF/sTFiqPEyMb0fPAo2ar3Y7iyQK8AQ+9Z0lCenQH7OvdAPPSlfO7ehIuisEd
         NByPgbPWnvy4nwg5zw9Vsrajf6ItAp0u5vZ4wRCEzqMEgCR5Y/q+Xy7J2eQwyK7uzxws
         /Y3g==
X-Gm-Message-State: AOJu0YzkY4hCViMuUWuFnr7KtIwe2meaPaPPbhKqYrBnn+kB/8bDCdQ4
	FUIvOrMmSfSpEinxAAxVVrpgbeXoZPtqpD3b226GFQ==
X-Google-Smtp-Source: AGHT+IEQhLhNbG7eMsqAhgTXgxeNuNUuK+ftH0vef6uqoUSSsM8PiEIV9HLCWd1kHC4x7w4oMRZk3g==
X-Received: by 2002:a05:600c:2247:b0:3fe:173e:4a34 with SMTP id a7-20020a05600c224700b003fe173e4a34mr8521054wmm.40.1695727144823;
        Tue, 26 Sep 2023 04:19:04 -0700 (PDT)
Received: from ?IPV6:2a02:8011:e80c:0:b095:3966:9c75:5de? ([2a02:8011:e80c:0:b095:3966:9c75:5de])
        by smtp.gmail.com with ESMTPSA id d18-20020a05600c251200b00401e32b25adsm14870004wma.4.2023.09.26.04.19.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Sep 2023 04:19:03 -0700 (PDT)
Message-ID: <7b691525-a92c-43e0-985d-555b584723b4@isovalent.com>
Date: Tue, 26 Sep 2023 12:19:02 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 4/8] libbpf: Add link-based API for meta
Content-Language: en-GB
To: Daniel Borkmann <daniel@iogearbox.net>, bpf@vger.kernel.org
Cc: netdev@vger.kernel.org, martin.lau@kernel.org, razor@blackwall.org,
 ast@kernel.org, andrii@kernel.org, john.fastabend@gmail.com
References: <20230926055913.9859-1-daniel@iogearbox.net>
 <20230926055913.9859-5-daniel@iogearbox.net>
From: Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20230926055913.9859-5-daniel@iogearbox.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 26/09/2023 06:59, Daniel Borkmann wrote:
> This adds bpf_program__attach_meta() API to libbpf. Overall it is very
> similar to tcx. The API looks as following:
> 
>   LIBBPF_API struct bpf_link *
>   bpf_program__attach_meta(const struct bpf_program *prog, int ifindex,
>                            bool peer_device, const struct bpf_meta_opts *opts);
> 
> The struct bpf_meta_opts is done in similar way as struct bpf_tcx_opts.
> bpf_program__attach_meta() compared to bpf_program__attach_tcx() has one
> additional argument, that is peer_device. The latter denotes whether the
> program should be attached to the relative peer of ifindex or whether it
> should be attached to ifindex itself.
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> ---
>  tools/lib/bpf/bpf.c      | 16 +++++++++++
>  tools/lib/bpf/bpf.h      |  5 ++++
>  tools/lib/bpf/libbpf.c   | 61 ++++++++++++++++++++++++++++++++++++----
>  tools/lib/bpf/libbpf.h   | 15 ++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  5 files changed, 92 insertions(+), 6 deletions(-)

> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index b4758e54a815..4d4da8ba2179 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -121,6 +121,8 @@ static const char * const attach_type_name[] = {
>  	[BPF_TCX_INGRESS]		= "tcx_ingress",
>  	[BPF_TCX_EGRESS]		= "tcx_egress",
>  	[BPF_TRACE_UPROBE_MULTI]	= "trace_uprobe_multi",
> +	[BPF_META_PRIMARY]		= "meta",
> +	[BPF_META_PEER]			= "meta",

"meta_primary" and "meta_peer"? Or is there a particular reason for
making these the only array entries with identical values?


