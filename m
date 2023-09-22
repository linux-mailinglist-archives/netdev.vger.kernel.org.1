Return-Path: <netdev+bounces-35847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A89A37AB542
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 17:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id E094DB209E9
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 15:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D864174A;
	Fri, 22 Sep 2023 15:51:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88B74405E6
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 15:51:21 +0000 (UTC)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63D5C1A4
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 08:51:19 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id ffacd0b85a97d-3216ba1b01eso2239906f8f.2
        for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 08:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1695397878; x=1696002678; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PesNzGzgs/M04opEkHztma2ejl/yk8qPHiAQF6kIYXs=;
        b=h0NxG8zKdc6AybJsLljYvh80UImr1uTdH+fhZDwdPFYZlNDLvtUiFnR06IzEztlt5E
         nrFyB/fqjYah76RaK5Bz4mGeRU+jxJg2Y7GAWtpP4ajmBaEu1GP0elyqYCqzI2LgPcbl
         hDYkskJrGhsLPXaIAULLHcDTuywBENaxn+A05+OZ+DL7xTm5DXQfGba4Ph5y8TYsR1+/
         rL8H8wWaNbbmi8lCK5LpALp1RoaVcOQAmrjFKmGf4toq+xI+fwOcpktdhUd6S/fPgcFY
         C8B6YCXbdNrRWyG4xtm8VxJ09T9dwEfeQfPT/sdJCdDoPLqeNlfWtUtFdDu9BTQ46md7
         054Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695397878; x=1696002678;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PesNzGzgs/M04opEkHztma2ejl/yk8qPHiAQF6kIYXs=;
        b=Z644j/ek/HnolpyNFCRV65FDN9mycbq/zpjFU8Z6yEgqTU2VMlyzdv0iAW1t9Rfao1
         frg1LjQ1xDwl5TJiep3nifZmuCtT8sOP1W4V2vxtQW0e3Nc7uZUjFdhzdV3Xgg2unHyc
         4fJfyIPCi7dHy/4P7afoO2mIIGWGZd7zhvSvtGfILwtILFdoO86sDL/nkDHH0tU2++uG
         dpT4gsYaxy4fX4J1XIZRwJwYZNUvF9IKXcxQVFnYetRddpp3ZXIUAwnCBROpc46biwR0
         Qv1jiw172uh+GJDsHFAZZfFv8GLOPzgraxCkf/ycNrSKqJwhOOt5vf08ZDXVTwm6trzu
         SEpg==
X-Gm-Message-State: AOJu0YyFFb2xUyiS9avUdmLa2iPKBcC/iMESoLhXpK1Sa+QrKsUYJv64
	2bs3Uq9jKmoQiVjAAU5vVSXc4A==
X-Google-Smtp-Source: AGHT+IEeD0srB04JPyidhV+jDln6djApiAcFBVSa+XLgP6L2lQpRLdsIMRc5oV1wIvDkTdJTvpxD7Q==
X-Received: by 2002:a5d:4f04:0:b0:31f:f9fe:e739 with SMTP id c4-20020a5d4f04000000b0031ff9fee739mr54713wru.59.1695397877790;
        Fri, 22 Sep 2023 08:51:17 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:fa64:3224:433b:7ca1? ([2a01:e0a:b41:c160:fa64:3224:433b:7ca1])
        by smtp.gmail.com with ESMTPSA id w10-20020adfd4ca000000b0031762e89f94sm4759379wrk.117.2023.09.22.08.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Sep 2023 08:51:16 -0700 (PDT)
Message-ID: <7ed5f6ab-4206-1c1e-6485-f970b9b5b79d@6wind.com>
Date: Fri, 22 Sep 2023 17:51:15 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCHv4 net] ipv4/fib: send notify when delete source address
 routes
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@nvidia.com>, David Ahern <dsahern@kernel.org>,
 Benjamin Poirier <bpoirier@nvidia.com>, Thomas Haller <thaller@redhat.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Eric Dumazet <edumazet@google.com>
References: <20230922075508.848925-1-liuhangbin@gmail.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <20230922075508.848925-1-liuhangbin@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



Le 22/09/2023 à 09:55, Hangbin Liu a écrit :
> After deleting an interface address in fib_del_ifaddr(), the function
> scans the fib_info list for stray entries and calls fib_flush() and
> fib_table_flush(). Then the stray entries will be deleted silently and no
> RTM_DELROUTE notification will be sent.
> 
> This lack of notification can make routing daemons, or monitor like
> `ip monitor route` miss the routing changes. e.g.
> 
> + ip link add dummy1 type dummy
> + ip link add dummy2 type dummy
> + ip link set dummy1 up
> + ip link set dummy2 up
> + ip addr add 192.168.5.5/24 dev dummy1
> + ip route add 7.7.7.0/24 dev dummy2 src 192.168.5.5
> + ip -4 route
> 7.7.7.0/24 dev dummy2 scope link src 192.168.5.5
> 192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
> + ip monitor route
> + ip addr del 192.168.5.5/24 dev dummy1
> Deleted 192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
> Deleted broadcast 192.168.5.255 dev dummy1 table local proto kernel scope link src 192.168.5.5
> Deleted local 192.168.5.5 dev dummy1 table local proto kernel scope host src 192.168.5.5
> 
> As Ido reminded, fib_table_flush() isn't only called when an address is
> deleted, but also when an interface is deleted or put down. The lack of
> notification in these cases is deliberate. And commit 7c6bb7d2faaf
> ("net/ipv6: Add knob to skip DELROUTE message on device down") introduced
> a sysctl to make IPv6 behave like IPv4 in this regard. So we can't send
> the route delete notify blindly in fib_table_flush().
> 
> To fix this issue, let's add a new flag in "struct fib_info" to track the
> deleted prefer source address routes, and only send notify for them.
> 
> After update:
> + ip monitor route
> + ip addr del 192.168.5.5/24 dev dummy1
> Deleted 192.168.5.0/24 dev dummy1 proto kernel scope link src 192.168.5.5
> Deleted broadcast 192.168.5.255 dev dummy1 table local proto kernel scope link src 192.168.5.5
> Deleted local 192.168.5.5 dev dummy1 table local proto kernel scope host src 192.168.5.5
> Deleted 7.7.7.0/24 dev dummy2 scope link src 192.168.5.5
> 
> Suggested-by: Thomas Haller <thaller@redhat.com>
> Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>
Acked-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>

