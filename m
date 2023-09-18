Return-Path: <netdev+bounces-34735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89A0C7A53D8
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 22:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866CA1C20B9E
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 20:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15E728687;
	Mon, 18 Sep 2023 20:21:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7019110969
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 20:21:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 194EA10A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1695068462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ezEMV25P7LHUp+2Nnu2vpkGu1EqgXuNpVyjOTSBFstY=;
	b=C0AY2R5RUcb3x4XfCut9cI8xWZQLCxFLcJwY5rt37AFHR/D+510ORMCPguh8BOkICrv8Yv
	pseRdhsItmIiEugl/V6LgraaQltR5qyA+Ukofxm0Ynz4JMNq3YavOPiIsgKpi68P+dLrqr
	RGzOOI4FXmicj8JHeHpDc5C2JnkY5W0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-l11a9xhQM_-hHUq-SbhNQg-1; Mon, 18 Sep 2023 16:21:00 -0400
X-MC-Unique: l11a9xhQM_-hHUq-SbhNQg-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-31fd49d8f2aso3181839f8f.1
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 13:21:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695068459; x=1695673259;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ezEMV25P7LHUp+2Nnu2vpkGu1EqgXuNpVyjOTSBFstY=;
        b=rEtm9moH+Rl5qYxoB/DiywCu/6ruK+ACILIIyebTjQ1GH7g2fwUjG690UWQ79ezLvq
         Jd2/wlTwaXSaECAv6ru57v5YMuV8hMjOgj1BVXJlvaSph/YOtfYA7aapkIxdi9YSuXij
         fSp4CbAoqgGneNOmPB4BQU8gj/Th0D5bCxPb3Zs39Sbkf5PBxUfCAPrA6YSG5k+7BMiz
         7SJ54U/HHwOMCDCGEgVImuqGl1wLdiMKMhWbzlaKB6s4g4HswH6gfa1RjjoAPRk5vDpF
         WhAwZftB7HRVnDDzNwSk+WRCgSOeP4xsq5vUcCjxcrknW2Plkpoz9bDGWAjZluq+Cksb
         1f9Q==
X-Gm-Message-State: AOJu0Yy52ruNxGcg6COhzeUsJLs7OqQr3pYPumAfNxPd25NOnmtS1ktM
	QF76S6wdeUuBqKF966D7Xfd6IMxWaE21fdOxXY98AFEWuPjr/OFQfFotdA/5x8hlBAZUbo1yzjy
	g0YVnsOcFtfuaTW7n
X-Received: by 2002:adf:a3c2:0:b0:321:6429:c977 with SMTP id m2-20020adfa3c2000000b003216429c977mr793562wrb.62.1695068459481;
        Mon, 18 Sep 2023 13:20:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpMVjOmOiq39Xo00Uchf1/TFLikMXMrxItHNSdP8qItz58igB2KvbJ91YfJNpuG26EG65wmA==
X-Received: by 2002:adf:a3c2:0:b0:321:6429:c977 with SMTP id m2-20020adfa3c2000000b003216429c977mr793553wrb.62.1695068459148;
        Mon, 18 Sep 2023 13:20:59 -0700 (PDT)
Received: from localhost ([37.162.200.80])
        by smtp.gmail.com with ESMTPSA id k7-20020adfe3c7000000b0031f8a59dbeasm13441271wrm.62.2023.09.18.13.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 13:20:58 -0700 (PDT)
Date: Mon, 18 Sep 2023 22:20:54 +0200
From: Andrea Claudi <aclaudi@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@gmail.com>
Subject: Re: [PATCH iproute2-next v3] allow overriding color option in
 environment
Message-ID: <ZQixJquSFzcYrWKh@renaissance-vector>
References: <20230918152910.5325-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918152910.5325-1-stephen@networkplumber.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Sep 18, 2023 at 08:29:10AM -0700, Stephen Hemminger wrote:
> For ip, tc, and bridge command introduce IPROUTE_COLORS to enable
> automatic colorization via environment variable.
> Similar to how grep handles color flag.
> 
> Example:
>   $ IPROUTE_COLORS=auto ip -br addr
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
> v3 - drop unneccessary check for NULL in match_colors
>      all three callers pass valid pointer.
>      drop unnecessary check for NULL in default_color

The NULL check in default_color is necessary, because getenv may return
NULL if there is no env variable with the desired name. Indeed it seems
to me this check is maintained in this patch.

However the null string check in default_color is also necessary
because, as I pointed out in the review of the RFC version of this
patch:

IPROUTE_COLORS= ip address

results in colorized output, while I would expect it to produce
colorless output.

This happens because we are effectively passing a null string to
default_color using the above syntax, and match_color_value() treat the
null string as 'always'.

Please note that this is indeed correct when calling match_color_value
when the '-c / --color' option is provided, but not when the env
variable is used to determine the color.


