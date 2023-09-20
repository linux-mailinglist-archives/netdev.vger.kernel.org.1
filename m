Return-Path: <netdev+bounces-35206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3B377A79AE
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E092816E6
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 10:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EAFA15ACC;
	Wed, 20 Sep 2023 10:49:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE64E154AF
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 10:49:10 +0000 (UTC)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD82CF5
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 03:49:05 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so919911466b.3
        for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 03:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1695206943; x=1695811743; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WfoVQLFTyBMz6qdJ4HQf6iMKbD5VVKNiCRlsodiIXlQ=;
        b=RazleXos7/k53GEoTRbGsHzMX9JT1DA51tFBZ3TYPXQeK02nojwcfEvtKhThwk0g8M
         OvIua8Ana6XbAIrjagYg9R65I2oLsi7VatOXOqZ/jp05kJJcCaQnlsjCvKjtgaSKniBp
         kdQ00CxPkWdHRmAtTG6Vohb/MtRvmFibKLunTXsfkCgE7cjy/qQZPjKENA7TsO4kg7xs
         8XL9ldy45vWFtAsw00TZrwTXm4dAS/8Yn5FvAUNhsJhNPad8JF8Pg6pgAnkC3+2amoNk
         iCvx+vmSwo8oBuBTyg9JsgwKcw2UCn03NpVnskrr2UciHNjkIZk7ImQ2yoMBbrFXudxc
         D8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695206943; x=1695811743;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WfoVQLFTyBMz6qdJ4HQf6iMKbD5VVKNiCRlsodiIXlQ=;
        b=nRymQuEVz8QIEqL0HPQXxFUsxG/Xpia13DgfklvAZf1U6TNNrla6dyN0uzGvIQDAtK
         KX5j4E8M3wUgIL66tzOqTckT4IgUViiljpovQlwel2Ccv/iqmA1OpyVgFZRNapnlnNul
         SS+CEvB9Yv2FEnbSD50W2dQt7x7JJYhlWA6fzaXe+pId0vmi/MnrB0sh/Zq3IJfkk0do
         2GBmuLeXteJ4V3+E6sLJHDPNm6mLqv6tAJTQh4MWVp8yr1edgadTeCQJY0p5EDL9aNIJ
         P9/SDhBa8Kxz/YOTNbVwp8RdPshABIAjd21qjTb3Xy+DeDDDl6LyUZ/rGFzII5L6Eacb
         XJEw==
X-Gm-Message-State: AOJu0YxGroX2B+E6x5EWrQtpXlega8QN+sok2nAD08pUFX9qdu7D49nP
	FT9ILM1opbvPe4C9VW7BWNh2iQ==
X-Google-Smtp-Source: AGHT+IGslN7faGmGQ7juByj4DUF+MXgyDiNwHsBIRgLgzDq+FEqRLW5HdrbYvzX5gsw4DZWdgtvfyw==
X-Received: by 2002:a17:906:3d21:b0:9a2:1e14:86bd with SMTP id l1-20020a1709063d2100b009a21e1486bdmr1622513ejf.65.1695206943489;
        Wed, 20 Sep 2023 03:49:03 -0700 (PDT)
Received: from [192.168.0.105] (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id qb18-20020a1709077e9200b009adc5802d08sm8191805ejc.190.2023.09.20.03.49.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 03:49:03 -0700 (PDT)
Message-ID: <5146e687-f5b8-86b2-e4e3-29871fe4fa5c@blackwall.org>
Date: Wed, 20 Sep 2023 13:49:01 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v4 3/6] net: bridge: Track and limit dynamically
 learned FDB entries
Content-Language: en-US
To: Johannes Nixdorf <jnixdorf-oss@avm.de>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 David Ahern <dsahern@gmail.com>, Eric Dumazet <edumazet@google.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ido Schimmel <idosch@nvidia.com>,
 Jakub Kicinski <kuba@kernel.org>, Oleksij Rempel <linux@rempel-privat.de>,
 Paolo Abeni <pabeni@redhat.com>, Roopa Prabhu <roopa@nvidia.com>,
 Shuah Khan <shuah@kernel.org>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: bridge@lists.linux-foundation.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <20230919-fdb_limit-v4-0-39f0293807b8@avm.de>
 <20230919-fdb_limit-v4-3-39f0293807b8@avm.de>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20230919-fdb_limit-v4-3-39f0293807b8@avm.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 9/19/23 11:12, Johannes Nixdorf wrote:
> A malicious actor behind one bridge port may spam the kernel with packets
> with a random source MAC address, each of which will create an FDB entry,
> each of which is a dynamic allocation in the kernel.
> 
> There are roughly 2^48 different MAC addresses, further limited by the
> rhashtable they are stored in to 2^31. Each entry is of the type struct
> net_bridge_fdb_entry, which is currently 128 bytes big. This means the
> maximum amount of memory allocated for FDB entries is 2^31 * 128B =
> 256GiB, which is too much for most computers.
> 
> Mitigate this by maintaining a per bridge count of those automatically
> generated entries in fdb_n_learned, and a limit in fdb_max_learned. If
> the limit is hit new entries are not learned anymore.
> 
> For backwards compatibility the default setting of 0 disables the limit.
> 
> User-added entries by netlink or from bridge or bridge port addresses
> are never blocked and do not count towards that limit.
> 
> Introduce a new fdb entry flag BR_FDB_DYNAMIC_LEARNED to keep track of
> whether an FDB entry is included in the count. The flag is enabled for
> dynamically learned entries, and disabled for all other entries. This
> should be equivalent to BR_FDB_ADDED_BY_USER and BR_FDB_LOCAL being unset,
> but contrary to the two flags it can be toggled atomically.
> 
> Atomicity is required here, as there are multiple callers that modify the
> flags, but are not under a common lock (br_fdb_update is the exception
> for br->hash_lock, br_fdb_external_learn_add for RTNL).
> 
> Signed-off-by: Johannes Nixdorf <jnixdorf-oss@avm.de>
> ---
>   net/bridge/br_fdb.c     | 35 +++++++++++++++++++++++++++++++++--
>   net/bridge/br_private.h |  4 ++++
>   2 files changed, 37 insertions(+), 2 deletions(-)
> 

I think this is a good counting start. :) It'd be nice to get
more eyes on this one.
Acked-by: Nikolay Aleksandrov <razor@blackwall.org>



