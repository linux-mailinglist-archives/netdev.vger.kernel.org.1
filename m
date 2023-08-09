Return-Path: <netdev+bounces-25820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F459775E88
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 14:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEE1D1C211F7
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 12:10:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CBFE1800D;
	Wed,  9 Aug 2023 12:10:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F92917FE2
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 12:10:49 +0000 (UTC)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8411C1999
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 05:10:46 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-5233deb7cb9so3650852a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 05:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20221208.gappssmtp.com; s=20221208; t=1691583045; x=1692187845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=emsVZt+9dvElwHgZPHzQQFExfxcIvxnkVGSZFRtftlk=;
        b=uIO/XO4JgHUq0Ud74Kb0DhrTQIh/dI7eA8B9BQVjy6PxM7L2GjSWZ9fg3oVA6Ps3qy
         szs0/RP3E3lfoSDPTZz6qe4Nh+iQuKH+N2uci7XhJDwrTav1HlspmB5THZSVH3xpuUr6
         6xotLpumec2D2HE964Ej6/HaD9DAtrUEaFjq2G7dDVEaCpajLSWZChlXTylHoMIEvBe3
         1AdZ7a+njZxQAvi/asbS8IHDly/4vCQbXJueX1akiQR1C6eGd3j04X4+iGyllkxWCFYR
         c3lLn8B9Vwdxgjx5s1ElnZXmX/cdtGAcv27rjOu0TJgVd9lOT35DeAEnIXdf4F151lr+
         B+HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691583045; x=1692187845;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=emsVZt+9dvElwHgZPHzQQFExfxcIvxnkVGSZFRtftlk=;
        b=jE3fRFAaSmINq38Kd1+CMHfy9Xi75WaFewfAsfqxfLLOFwbGJQaFj698TEJyB1i7xN
         IEOYDIh2Amw9VMDfu+kZLVRWdjlNqdGKDHcPucIcnFRFSDtt0i/HB+QCxBf/s/YczfMv
         nlmA410Hu27Xzsniy0GSaUp0vPgT9++qqWMDquff1t/a0hcC9Jr2Gui0Mw6+F+ilVhMF
         9byisoySnfFKQFw6yjm71tCrXWl5xIMaSy/vJwhd6ztE3N2dBIrxycR4aDkOqYDDfbnY
         u1ZRRUo44VWpP8ALVtyKEKfJGSdG82MjaMO0EJbuZCxKtgv40ehiA8/OjdfaMdL1y29p
         p2dw==
X-Gm-Message-State: AOJu0YxkhLHcIIMXfQ10cu3l75P5UV+DEAvbFSsbUbYp2TG16TVxjtyf
	BK1mX6Jvz5ga3qIcC1pUVpT3NQ==
X-Google-Smtp-Source: AGHT+IEpyz/b/ragRXnBVJgdGeRFKd6jS9q5/tI+Vyfm3DHhn3MHfRkkJFJbLQ3S67/EU8lT1jdiqQ==
X-Received: by 2002:aa7:c045:0:b0:523:493e:929c with SMTP id k5-20020aa7c045000000b00523493e929cmr2038843edo.10.1691583044790;
        Wed, 09 Aug 2023 05:10:44 -0700 (PDT)
Received: from [192.168.1.2] (handbookness.lineup.volia.net. [93.73.104.44])
        by smtp.gmail.com with ESMTPSA id s25-20020a056402015900b0052237dfa82fsm7881726edu.64.2023.08.09.05.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Aug 2023 05:10:44 -0700 (PDT)
Message-ID: <3c9c3d17-cd4b-c7e4-0b28-ffa1540ce9dc@blackwall.org>
Date: Wed, 9 Aug 2023 15:10:42 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net v2 00/17] selftests: forwarding: Various fixes
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, petrm@nvidia.com, mirsad.todorovac@alu.unizg.hr
References: <20230808141503.4060661-1-idosch@nvidia.com>
Content-Language: en-US
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230808141503.4060661-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/8/23 17:14, Ido Schimmel wrote:
> Fix various problems with forwarding selftests. See individual patches
> for problem description and solution.
> 
> v2:
> * Patch #10: Probe for MAC Merge support.
> 

Nice! Thanks for taking the time to fix all these.
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>

> Ido Schimmel (17):
>    selftests: forwarding: Skip test when no interfaces are specified
>    selftests: forwarding: Switch off timeout
>    selftests: forwarding: bridge_mdb: Check iproute2 version
>    selftests: forwarding: bridge_mdb_max: Check iproute2 version
>    selftests: forwarding: Set default IPv6 traceroute utility
>    selftests: forwarding: Add a helper to skip test when using veth pairs
>    selftests: forwarding: ethtool: Skip when using veth pairs
>    selftests: forwarding: ethtool_extended_state: Skip when using veth
>      pairs
>    selftests: forwarding: hw_stats_l3_gre: Skip when using veth pairs
>    selftests: forwarding: ethtool_mm: Skip when MAC Merge is not
>      supported
>    selftests: forwarding: tc_actions: Use ncat instead of nc
>    selftests: forwarding: tc_flower: Relax success criterion
>    selftests: forwarding: tc_tunnel_key: Make filters more specific
>    selftests: forwarding: tc_flower_l2_miss: Fix failing test with old
>      libnet
>    selftests: forwarding: bridge_mdb: Fix failing test with old libnet
>    selftests: forwarding: bridge_mdb_max: Fix failing test with old
>      libnet
>    selftests: forwarding: bridge_mdb: Make test more robust
> 
>   .../selftests/net/forwarding/bridge_mdb.sh    | 59 +++++++++++--------
>   .../net/forwarding/bridge_mdb_max.sh          | 19 ++++--
>   .../selftests/net/forwarding/ethtool.sh       |  2 +
>   .../net/forwarding/ethtool_extended_state.sh  |  2 +
>   .../selftests/net/forwarding/ethtool_mm.sh    | 18 ++++--
>   .../net/forwarding/hw_stats_l3_gre.sh         |  2 +
>   .../net/forwarding/ip6_forward_instats_vrf.sh |  2 +
>   tools/testing/selftests/net/forwarding/lib.sh | 17 ++++++
>   .../testing/selftests/net/forwarding/settings |  1 +
>   .../selftests/net/forwarding/tc_actions.sh    |  6 +-
>   .../selftests/net/forwarding/tc_flower.sh     |  8 +--
>   .../net/forwarding/tc_flower_l2_miss.sh       | 13 ++--
>   .../selftests/net/forwarding/tc_tunnel_key.sh |  9 ++-
>   13 files changed, 109 insertions(+), 49 deletions(-)
>   create mode 100644 tools/testing/selftests/net/forwarding/settings
> 


