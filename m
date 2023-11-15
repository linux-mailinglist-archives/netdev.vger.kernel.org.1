Return-Path: <netdev+bounces-47931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4207EBFB1
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 10:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55AAC1C2074E
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 09:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E772B9455;
	Wed, 15 Nov 2023 09:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="vl+QqmR2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A17E
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 09:47:08 +0000 (UTC)
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CD4FE
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 01:47:06 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-543923af573so10176673a12.0
        for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 01:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1700041624; x=1700646424; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2BCeMgOC92ggnpIdusvjFna6bZ8m++lICXft5pnOUeE=;
        b=vl+QqmR2+Xyne685efjXY9/AqTUKhn0cVMxo4PXEJno9JtkH+DETNHAKc50JXh+h23
         nYGMVN73iTkUB5MryMfN05u2gfF++ZpRxtAkApbAy5ivWBG3ZUMyYpt7E79/cBMOUER9
         uPh5AL0kQ2UqFTrTKY/WSTivss7x0/s23pgdoKTUVBc4Nu/dd6aEG701UPKp/TqMvQv7
         xFnbU7+J3Q2LnDO+fdiHcD9+Ac508z3MhuYNNYTBDfEOCY8LWDxxjzJPSOeXqVH+UTi5
         EUlGwY3S6vT6IWLOBWGBI4UF3q1m4o3UTo88g/fCqcZD2e77+Ak8hm/BfAML5XxWZ6zG
         Ning==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700041624; x=1700646424;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2BCeMgOC92ggnpIdusvjFna6bZ8m++lICXft5pnOUeE=;
        b=qu+c6NGoyy9/RgZglyDAdgO6GFFCWwk5IliirBrzpLhXJNN/8fuICj8HOE/fC7Y62U
         XstOTNyUjoZyR1BZQyHYiGIGL3Q7m+XVTKYVu3QJvr8FZSX+FUCBJZE4+0uf5Is3kyXK
         VWEMO63OF72RuDi1a5UYtEfgCAnRWVOM1yGlBazJ3Twe1t66e7z34o0+AftqYp495aN1
         +2dbq5bx0OtlC3UHtMLm5g3SrgQdp+x7NrO2C0mz74+FbVbnGp84n+FUQrO1hxJtoX6e
         F84CO17u4FheHwvYt+z4sbWDViIzUjQszuAo5OcnnN/y0xrL6MYdB/Gkov0+zULmqA96
         mVhA==
X-Gm-Message-State: AOJu0YwLUq3rC50PLiMZ+xN23sZWfVWkwKdCrBycBPk3Ym+J1NtnOiP2
	BPc7Y96ZH1SiKkzV14jlHAB/aw==
X-Google-Smtp-Source: AGHT+IE6BSQCtJ9GPvmYGWqq9rMT2qQG5AOSFBl8Yi/6zwfEq8vtuq2aCrfHGusoj93MGQG/cQ+BWA==
X-Received: by 2002:a17:906:27d9:b0:9e1:46a2:b827 with SMTP id k25-20020a17090627d900b009e146a2b827mr8930435ejc.29.1700041624488;
        Wed, 15 Nov 2023 01:47:04 -0800 (PST)
Received: from [192.168.0.106] (starletless.turnabout.volia.net. [93.73.214.90])
        by smtp.gmail.com with ESMTPSA id a9-20020a17090640c900b009e5ce1acb01sm6739172ejk.103.2023.11.15.01.47.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Nov 2023 01:47:04 -0800 (PST)
Message-ID: <588c2b90-2f57-f40d-2dfe-0c0131788497@blackwall.org>
Date: Wed, 15 Nov 2023 11:47:02 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [RFC PATCHv3 net-next 06/10] docs: bridge: add VLAN doc
Content-Language: en-US
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>,
 David Ahern <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ido Schimmel <idosch@idosch.org>, Roopa Prabhu <roopa@nvidia.com>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Florian Westphal <fw@strlen.de>, Andrew Lunn <andrew@lunn.ch>,
 Florian Fainelli <f.fainelli@gmail.com>, Vladimir Oltean
 <olteanv@gmail.com>, Jiri Pirko <jiri@resnulli.us>
References: <20231110101548.1900519-1-liuhangbin@gmail.com>
 <20231110101548.1900519-7-liuhangbin@gmail.com>
 <794505c1-da3c-c52a-ece8-9629ab6f32db@blackwall.org>
 <ZVSOGvpkyEzCWH2Q@Laptop-X1>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <ZVSOGvpkyEzCWH2Q@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/15/23 11:23, Hangbin Liu wrote:
> On Mon, Nov 13, 2023 at 11:54:36AM +0200, Nikolay Aleksandrov wrote:
>>> +The `VLAN filtering <https://lore.kernel.org/netdev/1360792820-14116-1-git-send-email-vyasevic@redhat.com/>`_
>>
>> drop "The", just VLAN filtering
>>
>>> +on bridge is disabled by default. After enabling VLAN
>>
>> on a bridge
>>
>>> +filter on bridge, the bridge can handle VLAN-tagged frames and forward them
>>
>> filtering on a bridge, it will
>>
>> But here it sounds a bit misleading, as if vlan-tagged frames are not
>> handled otherwise. They are, just vlan tags are not considered when
>> making forwarding decisions (e.g. FDB lookup).
> 
> How about:
> 
> VLAN filtering on a bridge is disabled by default. After enabling VLAN filtering
> on a bridge, it will start forwarding frames to appropriate destinations based
> on their VLAN tag.
> 
> Thanks
> Hangbin

How about a little tweak like: ... it will start forwarding frames to
appropriate destinations based on their destination MAC address and VLAN
tag (both must match).

