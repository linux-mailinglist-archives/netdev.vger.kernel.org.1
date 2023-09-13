Return-Path: <netdev+bounces-33475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8855579E146
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:58:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90C341C20B80
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 07:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B103E1DA3A;
	Wed, 13 Sep 2023 07:58:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EF0659
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 07:58:12 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40411988
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:58:11 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-403004a96eeso45306005e9.3
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 00:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1694591890; x=1695196690; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=dhVe2M/8NgfCR4xBwjMBpmISC1PM3t0cuI0SnDBA/yI=;
        b=TVohnLuJZOpf6Xqz+ZSRIYfo7pFkx/GbPScl4bzlihtVGv4ufAtBaEViDBYW3LNViL
         Ka9zKwN6JfKDBWiL9Wo7eI7r8MIwyIqa/+A8/IBQ51wv7IMc6Jy2lhPWj1uP1ghY3YPW
         37XuhuXo1OvADPfawSn4PdEH8isiqGhxAHo9TG1MmCYEf+vGQ31sHkfnbzXsF91yuU3f
         0h7rqLRuMiHJDT/lkTWhmm9L7TboQFEuaDzaeJHojB5XPonxrbwUqpaB59Gpsu81j+0y
         2VSBtE6xoFs4Be6Aen4Lu1OahWcQ9m0vhMP1sVpmmQV+juUzfmSIQONITcDM8u6AAVYx
         PzKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694591890; x=1695196690;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:reply-to:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dhVe2M/8NgfCR4xBwjMBpmISC1PM3t0cuI0SnDBA/yI=;
        b=GkATOHs3lL4pgKjNOpUdutA4VrmhDgx+u+D68HdjEBthK6RuG5ms2RlSBi4bezmrpm
         YjE+5S5c2GRUv8nynYojoML6wx7PDzL18YIEIkf117RGAnzJK2ziePdZ4/TtAafE6wPX
         wdJxCqCHlS4ugLXTpiKfpuTwWUVYOL2bPljhKv703EffBnvkAKMYApPbddKuWMbBt3k5
         8xqQ4ofHolkWYmpfl5Plyp4vSsYHFlfmVC6G8xtRUtWr7ygEiGu7MLvnvdX75/+isaU0
         UgPv6D/nRvp5lvH/CKoi2OVW4XHGBrzJ8zXbVfPEpTUOwFiws87JcYV0uI8r3nwVX8Eh
         Z0QQ==
X-Gm-Message-State: AOJu0Yypi++oV33yad4d/cBUs7BaKfIFK1m/Kmr1a4Chj7ifZL4bbbhR
	o2dsZHaa9CQSV5peOzrOkDktWg==
X-Google-Smtp-Source: AGHT+IESJlmzTFdFhyaqHie5gV7Rv+cKIS7wXRScWBkNMk0PrygKM18hDwAsX6C1/gMJc12qjK8kPw==
X-Received: by 2002:a05:600c:20d5:b0:3fb:d1db:545b with SMTP id y21-20020a05600c20d500b003fbd1db545bmr1390098wmm.20.1694591890100;
        Wed, 13 Sep 2023 00:58:10 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:b41:c160:2210:4d5b:b108:14b3? ([2a01:e0a:b41:c160:2210:4d5b:b108:14b3])
        by smtp.gmail.com with ESMTPSA id l14-20020a1c790e000000b003fe4ca8decdsm1222070wme.31.2023.09.13.00.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Sep 2023 00:58:09 -0700 (PDT)
Message-ID: <cc91aa7d-0707-b64f-e7a9-f5ce97d4f313@6wind.com>
Date: Wed, 13 Sep 2023 09:58:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Reply-To: nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Content-Language: en-US
To: Thomas Haller <thaller@redhat.com>, Benjamin Poirier
 <bpoirier@nvidia.com>, David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Hangbin Liu <liuhangbin@gmail.com>, Ido Schimmel <idosch@idosch.org>,
 netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <ZLobpQ7jELvCeuoD@Laptop-X1> <ZLzY42I/GjWCJ5Do@shredder>
 <ZL48xbowL8QQRr9s@Laptop-X1> <20230724084820.4aa133cc@hermes.local>
 <ZL+F6zUIXfyhevmm@Laptop-X1> <20230725093617.44887eb1@hermes.local>
 <6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
 <7e08dd3b-726d-3b1b-9db7-eddb21773817@kernel.org>
 <640715e60e92583d08568a604c0ebb215271d99f.camel@redhat.com>
 <8f5d2cae-17a2-f75d-7659-647d0691083b@kernel.org> <ZNKQdLAXgfVQxtxP@d3>
 <32d40b75d5589b73e17198eb7915c546ea3ff9b1.camel@redhat.com>
From: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Organization: 6WIND
In-Reply-To: <32d40b75d5589b73e17198eb7915c546ea3ff9b1.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Le 11/09/2023 à 11:50, Thomas Haller a écrit :
[snip]
> - the fact that it isn't fixed in more than a decade, shows IMO that
> getting caching right for routes is very hard. Patches that improve the
> behavior should not be rejected with "look at libnl3 or FRR".
+1

I just hit another corner case:

ip link set ntfp2 up
ip address add 10.125.0.1/24 dev ntfp2
ip nexthop add id 1234 via 10.125.0.2 dev ntfp2
ip route add 10.200.0.0/24 nhid 1234

Check the config:
$ ip route
<snip>
10.200.0.0/24 nhid 1234 via 10.125.0.2 dev ntfp2
$ ip nexthop
id 1234 via 10.125.0.2 dev ntfp2 scope link


Set the carrier off on ntfp2:
ip monitor label link route nexthop&
ip link set ntfp2 carrier off

$ ip link set ntfp2 carrier off
$ [LINK]4: ntfp2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
DOWN group default
    link/ether de:ed:02:67:61:1f brd ff:ff:ff:ff:ff:ff

=> No nexthop event nor route event (net.ipv4.nexthop_compat_mode = 1)

'ip nexthop' and 'ip route' show that the nexthop and the route have been deleted.

If the nexthop infra is not used (ip route add 10.200.0.0/24 via 10.125.0.2 dev
ntfp2), the route entry is not deleted.

I wondering if it is expected to not have a nexthop event when one is removed
due to a carrier lost.
At least, a route event should be generated when the compat_mode is enabled.


Regards,
Nicolas

