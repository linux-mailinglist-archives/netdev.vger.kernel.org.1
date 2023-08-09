Return-Path: <netdev+bounces-25695-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FBA775319
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 08:47:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E05FB281A7E
	for <lists+netdev@lfdr.de>; Wed,  9 Aug 2023 06:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C43C812;
	Wed,  9 Aug 2023 06:47:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2BAF7F3
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 06:47:11 +0000 (UTC)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9672310CF
	for <netdev@vger.kernel.org>; Tue,  8 Aug 2023 23:47:08 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1bbf0f36ce4so42557155ad.0
        for <netdev@vger.kernel.org>; Tue, 08 Aug 2023 23:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691563628; x=1692168428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IcytD9f/V3LoGVK112uah+u9yxGDsbcvfvOyo5pNffk=;
        b=qWJZ/IOf8bH+tGRbygeHw5KEyvNLkyJl7nV1pZ2yuuW3tMVGC57HS0XydfZ/5itBuw
         xuJwoHYy1uV66XcCK6IHykF1n3mIknwidQTlSuTQlmEd/Wtzy1ZiTzwKGE3/mYYPaDOW
         CJEysdFrLhRlhYjfPchDDBsSbaCH0caX5kefXuOJEfbypvbxD/eQgFVCzERQ0ycUNvua
         TqajGcN+U9zc178NY/SWUOF5HjOTQHPCXANTboZoUAz8DMnw94eU/IoaZjDT/sKyT+S4
         6/msBmA2DGf2CryUDmNzFupwWHvVs23nVSYOFjneEg5YViFVQbmZCn+BNgUmAeSIxB/I
         z4VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691563628; x=1692168428;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IcytD9f/V3LoGVK112uah+u9yxGDsbcvfvOyo5pNffk=;
        b=bkIuSA6kCPV4qjviXBYeeHcaF9jODckUVV8SSc+hO6TRpiI1cBCbAVCOg1cMJCwDDl
         d61kinZDlnIpOR+ZVhrzR8F1Zh0Z7f6ibBf4FcqX2mw6G/rdjKZkbRLBSY3lDZVHjEFp
         kkAJkCfboQ5+SJ0eZXSxIFeBxiqdVAexcPPZh4Nq/6iizPpJIIzjBCT/ALvbuyT4HUlS
         EnOADvKyVCfoBeIRJ6JHZUuJW8w21F+0L289IDIRhPBfMejVwlbIDzGDk63JVuU6tMki
         SevIz+kJOwiinSfCQ1uoCqoo68WhwcvkiJYCrNV1Fxj1J+4c613o2pbvVD10rCsEtISm
         WXtg==
X-Gm-Message-State: AOJu0YywWjOdqV+j83lsPzjBIYUFOqmvTgiIk8mwMOfYrQq5cXS6BUI0
	VG0nZewJSHPEgHl1g73bD0s=
X-Google-Smtp-Source: AGHT+IGbqRmYv4WM3bpVwTl/P51VOYW5AX7AJ1JpsRerUJVX4zzSKcsO2acvu3L5qNeJXhC5SI5ayg==
X-Received: by 2002:a17:902:c115:b0:1bb:7a73:6b59 with SMTP id 21-20020a170902c11500b001bb7a736b59mr1506454pli.32.1691563628055;
        Tue, 08 Aug 2023 23:47:08 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p16-20020a170902e75000b001bba3a4888bsm10290171plf.102.2023.08.08.23.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 23:47:07 -0700 (PDT)
Date: Wed, 9 Aug 2023 14:47:02 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org,
	pabeni@redhat.com, edumazet@google.com, petrm@nvidia.com,
	razor@blackwall.org, mirsad.todorovac@alu.unizg.hr
Subject: Re: [PATCH net v2 00/17] selftests: forwarding: Various fixes
Message-ID: <ZNM2ZueJboLMjrWf@Laptop-X1>
References: <20230808141503.4060661-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808141503.4060661-1-idosch@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 08, 2023 at 05:14:46PM +0300, Ido Schimmel wrote:
> Fix various problems with forwarding selftests. See individual patches
> for problem description and solution.

Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>

> 
> v2:
> * Patch #10: Probe for MAC Merge support.
> 
> Ido Schimmel (17):
>   selftests: forwarding: Skip test when no interfaces are specified
>   selftests: forwarding: Switch off timeout
>   selftests: forwarding: bridge_mdb: Check iproute2 version
>   selftests: forwarding: bridge_mdb_max: Check iproute2 version
>   selftests: forwarding: Set default IPv6 traceroute utility
>   selftests: forwarding: Add a helper to skip test when using veth pairs
>   selftests: forwarding: ethtool: Skip when using veth pairs
>   selftests: forwarding: ethtool_extended_state: Skip when using veth
>     pairs
>   selftests: forwarding: hw_stats_l3_gre: Skip when using veth pairs
>   selftests: forwarding: ethtool_mm: Skip when MAC Merge is not
>     supported
>   selftests: forwarding: tc_actions: Use ncat instead of nc
>   selftests: forwarding: tc_flower: Relax success criterion
>   selftests: forwarding: tc_tunnel_key: Make filters more specific
>   selftests: forwarding: tc_flower_l2_miss: Fix failing test with old
>     libnet
>   selftests: forwarding: bridge_mdb: Fix failing test with old libnet
>   selftests: forwarding: bridge_mdb_max: Fix failing test with old
>     libnet
>   selftests: forwarding: bridge_mdb: Make test more robust
> 
>  .../selftests/net/forwarding/bridge_mdb.sh    | 59 +++++++++++--------
>  .../net/forwarding/bridge_mdb_max.sh          | 19 ++++--
>  .../selftests/net/forwarding/ethtool.sh       |  2 +
>  .../net/forwarding/ethtool_extended_state.sh  |  2 +
>  .../selftests/net/forwarding/ethtool_mm.sh    | 18 ++++--
>  .../net/forwarding/hw_stats_l3_gre.sh         |  2 +
>  .../net/forwarding/ip6_forward_instats_vrf.sh |  2 +
>  tools/testing/selftests/net/forwarding/lib.sh | 17 ++++++
>  .../testing/selftests/net/forwarding/settings |  1 +
>  .../selftests/net/forwarding/tc_actions.sh    |  6 +-
>  .../selftests/net/forwarding/tc_flower.sh     |  8 +--
>  .../net/forwarding/tc_flower_l2_miss.sh       | 13 ++--
>  .../selftests/net/forwarding/tc_tunnel_key.sh |  9 ++-
>  13 files changed, 109 insertions(+), 49 deletions(-)
>  create mode 100644 tools/testing/selftests/net/forwarding/settings
> 
> -- 
> 2.40.1
> 

