Return-Path: <netdev+bounces-34572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8447A4BDF
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 334D2281C3F
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F001D68A;
	Mon, 18 Sep 2023 15:22:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5704F1CF9A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:22:23 +0000 (UTC)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93A5D10CB
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:20:14 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-45269fe9d6bso647911137.2
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 08:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695050410; x=1695655210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmBupPZhl++AIgDxS5SsWonrNnPkklzkEGd3FcARC5w=;
        b=RPS9WAppQD8iKtURVvhGF0GdIiqGQ3ok3E2oZh6B5zXeNsAytmULxyxOgPBCeJdTLi
         Q/nVTmUlyjbDWaOBl2YGPbWIM+XsieQdmzy73N/yojIz9KC7rWxUud7280XFCZ88vGC3
         V18A9HUqJcYXauaHQq4gVZkRxl8hb8ECHLLj6VYLnhg7L5I1HCpexgFg9CT18NCXEFGM
         PTNltV7nBeshNxTmVrov+nVP656aALtbjnZACwcDCWyeILq1zs3t6kZuG0QqTWU+CX/V
         L8JXJlpv9WXxxMgIkli0V3LKSyroDrSSqGOn7pDDQDfvNtjKmdldhNQ4BFr1Lf1oWinJ
         RuHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695050410; x=1695655210;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmBupPZhl++AIgDxS5SsWonrNnPkklzkEGd3FcARC5w=;
        b=Q49+oJCd3fV5NBZxwq2/jW244CqaNTb/5s2F+hqdb4bqj8o4aZ/EO+suADAdC5RLC7
         Ie5j4vus52/jiP2gkkAFzXvCPtngYyAXoGhGisOoKvyGPNa3t+K6MJKd60DSFtB0yr+l
         EkRy4vP9ze8gLb9tgD0CDl49J62jqSWe2bSzamGxjzjJQGsHMVXnh+V7zfI9G5o0aiUA
         Ff2ceSx23bBKAayE1btFCTsWpy//fUJ6BPmGSBeazVuYO4xSPkueiJf6lCJq/vrii9PU
         hUUCJj/e6JcNQgcsHk6gchqgr09tdUmf0HuZo4ICAfbH2IDRyoyIXwncUM5l8/+OXP9A
         Yq3w==
X-Gm-Message-State: AOJu0Yx1u4ZmsAoTUiBOlofLBgLt0N9WUd5L7FNlOwCirzxK/JMRuRnF
	09OKWAavTWGOAUSo0XK6VV6ORyYepC4=
X-Google-Smtp-Source: AGHT+IGj/94cXsd7Y2QJn9t9lPkvMVZCpFPtoC3gxq8SMbuDiH0Wgv0n6PBMmIvVNwMuUyksYGMU6Q==
X-Received: by 2002:a92:cd8a:0:b0:34f:e656:8deb with SMTP id r10-20020a92cd8a000000b0034fe6568debmr4830503ilb.17.1695049913241;
        Mon, 18 Sep 2023 08:11:53 -0700 (PDT)
Received: from ?IPV6:2601:282:1e82:2350:2d71:6451:e70a:d690? ([2601:282:1e82:2350:2d71:6451:e70a:d690])
        by smtp.googlemail.com with ESMTPSA id q7-20020a056e02078700b0034f6a95cab1sm1192334ils.46.2023.09.18.08.11.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 08:11:52 -0700 (PDT)
Message-ID: <76f6f003-defb-96c8-162b-7242fe51f1ec@gmail.com>
Date: Mon, 18 Sep 2023 09:11:51 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH iproute2 v2] allow overriding color option in environment
Content-Language: en-US
To: Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org
References: <20230916150326.7942-1-stephen@networkplumber.org>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20230916150326.7942-1-stephen@networkplumber.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/16/23 9:03 AM, Stephen Hemminger wrote:
> diff --git a/lib/color.c b/lib/color.c
> index 59976847295c..e2ffefaf75a8 100644
> --- a/lib/color.c
> +++ b/lib/color.c
> @@ -93,6 +93,32 @@ bool check_enable_color(int color, int json)
>  	return false;
>  }
>  
> +static bool match_color_value(const char *arg, int *val)
> +{
> +	if (*arg == '\0' || !strcmp(arg, "always"))

here you check for a null string

> +		*val = COLOR_OPT_ALWAYS;
> +	else if (!strcmp(arg, "auto"))
> +		*val = COLOR_OPT_AUTO;
> +	else if (!strcmp(arg, "never"))
> +		*val = COLOR_OPT_NEVER;
> +	else
> +		return false;
> +	return true;
> +}
> +
> +int default_color(void)
> +{
> +	const char *name;
> +	int val;
> +
> +	name = getenv("IPROUTE_COLORS");
> +	if (name && *name && match_color_value(name, &val))

so you can drop the `*name` check here


