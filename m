Return-Path: <netdev+bounces-25773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 318067756CA
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 473D01C2116E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 10:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB53714F8C;
	Wed,  9 Aug 2023 10:02:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFFE5100B6
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 10:02:47 +0000 (UTC)
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B828C1BFA
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 03:02:46 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-686ed1d2594so6315016b3a.2
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 03:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691575366; x=1692180166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=l3PnAwAhO0hPQux2PIRrbrT++BdxG44s59kqndxfAHE=;
        b=Rn8qqzTdzlFZiflL6reZctJcZ2J0hfuHKYHAhIl3SchazTwC9/OTaPKgMrbTMNC5KE
         Wlap09clYnn7rKl8zUhvtBHrRLTAtYwCZP09JtvAGBQ32VTqZznoKE/ZDGsQw/wNJZcb
         mAF5znEMZEbiyiZkGaOanLqkHJSwdoZWGwWTpqAvfr+en5CelgQg/hOEv86EnASx0ckr
         FwS/4cwGFi2fPvdcLtlRZvFnCitw/hJM0pEKYhOfBf6rs4aCc9anmxK1HvtWEr1iLa6L
         RKqY+3Zlx6duF/nbZDyHJuxXm03bTGPRvpBard2LRf8DXF3jt3nRfgkW/OhzTnGag6Qv
         UqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691575366; x=1692180166;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3PnAwAhO0hPQux2PIRrbrT++BdxG44s59kqndxfAHE=;
        b=O8ibb7Cfb5S37YnIF3uujYySkTXlbSsWQEONTm7/yAFma01oc5bwUM3fGkReKWyo+r
         U1QDWU6N7PUA72ZT+quFUR67St+pRfdsOorbM+SwIif9ZrHlBKiUZPJE1tfPfgGctyZW
         qokQ9tsgc8g+Rx5AkJLfen2IWGKbK4tU2KNOyS/iwUqKxL2Jhow0a5+Tk7itAZ0cCxhl
         TcEK3HRvl3NL3vdI/bCoXsOSex+BkRA9elFJDbjHcjI6alHebTrWSkbzEMvJ9Hp3uig4
         L4nmpR6eAuKyzMXv+pGwCkSLlWBbKDRTEce+q+bWlr2Vbx2t8AZP0Zr+dd7BEl5Y8/Cb
         TsIg==
X-Gm-Message-State: AOJu0YwGnryXbatmqHAFKcqD9rxkZR88YKfl7hK5rwluEMO274J7dOZE
	GbT/I72PFwEGebOXuCXVXqw=
X-Google-Smtp-Source: AGHT+IEA7BrgfRkXYFqRm3NXl9W6CqD3T56FkKIb6z4lzRGesy/RH7Ftdz8F/otrBJP7IfNQPKB0Cg==
X-Received: by 2002:a05:6a21:9983:b0:135:293b:9b14 with SMTP id ve3-20020a056a21998300b00135293b9b14mr2796345pzb.55.1691575366048;
        Wed, 09 Aug 2023 03:02:46 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id jd20-20020a170903261400b001b9dadf8bd2sm10776390plb.190.2023.08.09.03.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 03:02:45 -0700 (PDT)
Date: Wed, 9 Aug 2023 18:02:41 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@idosch.org>
Cc: David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Haller <thaller@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <ZNNkQXLPc0yYwKjR@Laptop-X1>
References: <ZLZnGkMxI+T8gFQK@shredder>
 <20230718085814.4301b9dd@hermes.local>
 <ZLjncWOL+FvtaHcP@Laptop-X1>
 <ZLlE5of1Sw1pMPlM@shredder>
 <ZLngmOaz24y5yLz8@Laptop-X1>
 <d6a204b1-e606-f6ad-660a-28cc5469be2e@kernel.org>
 <ZLobpQ7jELvCeuoD@Laptop-X1>
 <ZLzY42I/GjWCJ5Do@shredder>
 <ZMyyJKZDaR8zED8j@Laptop-X1>
 <ZNM638Ypq7cgUB/k@shredder>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNM638Ypq7cgUB/k@shredder>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 10:06:07AM +0300, Ido Schimmel wrote:
> We can instead represent fib_nh_is_v6 and nh_updated using a single bit:
> 
> diff --git a/include/net/ip_fib.h b/include/net/ip_fib.h
> index a378eff827c7..a91f8a28689a 100644
> --- a/include/net/ip_fib.h
> +++ b/include/net/ip_fib.h
> @@ -152,8 +152,8 @@ struct fib_info {
>  #define fib_rtt fib_metrics->metrics[RTAX_RTT-1]
>  #define fib_advmss fib_metrics->metrics[RTAX_ADVMSS-1]
>         int                     fib_nhs;
> -       bool                    fib_nh_is_v6;
> -       bool                    nh_updated;
> +       u8                      fib_nh_is_v6:1,
> +                               nh_updated:1;
>         struct nexthop          *nh;
>         struct rcu_head         rcu;
>         struct fib_nh           fib_nh[];
> 
> And then add another bit there to mark a FIB info that is deleted
> because of preferred source address deletion.
> 
> I suggest testing with the FIB tests in tools/testing/selftests/net/.

Thanks for the suggestion. The discuss in this patch is getting too long.
Let me post the new patch and we can discuss there.

Hangbin

