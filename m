Return-Path: <netdev+bounces-33502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF07579E457
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 11:55:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 785A5281E95
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 09:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546B41DDCF;
	Wed, 13 Sep 2023 09:55:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4165A179AB
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 09:55:06 +0000 (UTC)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE1DB1BDC
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:55:05 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-26ef24b8e5aso5498058a91.0
        for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 02:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694598905; x=1695203705; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=29S3/dKQUQT8Hg9FfxhLAS3gsFxe94m5pLwVvzvuOBA=;
        b=So1skdkwHIKxX1F0V7kM/hrFDTdXMXkUkLzV9SbGGkZIhLfNbX32WGhCafk7+MMm7X
         Bf7C7QDSG+Do41ED/U7b52RLP/lpEJQMXB6ZffWpQUMXBTUvBD+Uae6wNVPCxZGUf1qK
         8BbclPmSYcQrb9NqHT+EBzWBL0PR57zp0aOKhtKKKmDhxwru7Lf23HD6qlTPX4/vswYj
         bH6UptrZ+vL0qeEtXSlVz+zHyyvfv17gy8X4pPJTbaZnkwq9BYXZfrOO53+VuYYSV8Ms
         rCNqkS6OwuDFpxjXbNV9oQllA1CqgeyY5qzH3yAecLbXblSRvWJTsksM+3bgj4znVZTE
         4p6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694598905; x=1695203705;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29S3/dKQUQT8Hg9FfxhLAS3gsFxe94m5pLwVvzvuOBA=;
        b=xO+iFSpJAEFJT4pnzMYELpDmJGmGR0NJ18+hdj4hXWKpYCvZYdgkc19CRsjBYI8Aq0
         nrUNgFg1FPSrzbFKJ2xfZQvWrnHJNZvfwlDq9Zjrsd0XlnhPk4ICXpIfBEi6kXG8IPJc
         0dOnNCA/IpAz1xbFVtPIEGhyJbQz5dFHy+x0GaqAT3UNB6JDKANWGKoz2LeeNyu+JsGr
         vB8ljVfDwU9y0D+NkA3bTfLhi3GyhTSSSlS5i+JrhzIJwK6RCDeTby3SXfos1+nzZEKI
         80oYaDnFt0DZBuqbSxEsNeHGVISHRpw2q6CAlBAB0k2dgUHg0c/Ugy4GXHcl0YmqkliH
         vtVw==
X-Gm-Message-State: AOJu0YwmIFnHx/JJCMSfNgQ7aFhTzLSlVr3BGf0tM8eOBxtLNYSqfA8x
	WaXUOTJ7f3AKW1fgQ56Z7yk=
X-Google-Smtp-Source: AGHT+IEC9k9z6vSywDCyQxFvaYthmbXRJquoSBY2Jt+pZD/X38ZjmqlQ6bX5fzJ2TS21OZbh0XBVRw==
X-Received: by 2002:a17:90b:4c4f:b0:268:1068:4464 with SMTP id np15-20020a17090b4c4f00b0026810684464mr1598924pjb.30.1694598905294;
        Wed, 13 Sep 2023 02:55:05 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id e4-20020a170902d38400b001b890009634sm10035508pld.139.2023.09.13.02.55.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Sep 2023 02:55:04 -0700 (PDT)
Date: Wed, 13 Sep 2023 17:54:59 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Cc: Thomas Haller <thaller@redhat.com>,
	Benjamin Poirier <bpoirier@nvidia.com>,
	David Ahern <dsahern@kernel.org>,
	Stephen Hemminger <stephen@networkplumber.org>,
	Ido Schimmel <idosch@idosch.org>, netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] ipv4/fib: send RTM_DELROUTE notify when flush
 fib
Message-ID: <ZQGG8xqt8m3IHS4z@Laptop-X1>
References: <20230724084820.4aa133cc@hermes.local>
 <ZL+F6zUIXfyhevmm@Laptop-X1>
 <20230725093617.44887eb1@hermes.local>
 <6b53e392-ca84-c50b-9d77-4f89e801d4f3@6wind.com>
 <7e08dd3b-726d-3b1b-9db7-eddb21773817@kernel.org>
 <640715e60e92583d08568a604c0ebb215271d99f.camel@redhat.com>
 <8f5d2cae-17a2-f75d-7659-647d0691083b@kernel.org>
 <ZNKQdLAXgfVQxtxP@d3>
 <32d40b75d5589b73e17198eb7915c546ea3ff9b1.camel@redhat.com>
 <cc91aa7d-0707-b64f-e7a9-f5ce97d4f313@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cc91aa7d-0707-b64f-e7a9-f5ce97d4f313@6wind.com>

On Wed, Sep 13, 2023 at 09:58:08AM +0200, Nicolas Dichtel wrote:
> Le 11/09/2023 à 11:50, Thomas Haller a écrit :
> [snip]
> > - the fact that it isn't fixed in more than a decade, shows IMO that
> > getting caching right for routes is very hard. Patches that improve the
> > behavior should not be rejected with "look at libnl3 or FRR".
> +1
> 
> I just hit another corner case:
> 
> ip link set ntfp2 up
> ip address add 10.125.0.1/24 dev ntfp2
> ip nexthop add id 1234 via 10.125.0.2 dev ntfp2
> ip route add 10.200.0.0/24 nhid 1234
> 
> Check the config:
> $ ip route
> <snip>
> 10.200.0.0/24 nhid 1234 via 10.125.0.2 dev ntfp2
> $ ip nexthop
> id 1234 via 10.125.0.2 dev ntfp2 scope link
> 
> 
> Set the carrier off on ntfp2:
> ip monitor label link route nexthop&
> ip link set ntfp2 carrier off
> 
> $ ip link set ntfp2 carrier off
> $ [LINK]4: ntfp2: <NO-CARRIER,BROADCAST,MULTICAST,UP> mtu 1500 qdisc mq state
> DOWN group default
>     link/ether de:ed:02:67:61:1f brd ff:ff:ff:ff:ff:ff
> 
> => No nexthop event nor route event (net.ipv4.nexthop_compat_mode = 1)
> 
> 'ip nexthop' and 'ip route' show that the nexthop and the route have been deleted.
> 
> If the nexthop infra is not used (ip route add 10.200.0.0/24 via 10.125.0.2 dev
> ntfp2), the route entry is not deleted.
> 
> I wondering if it is expected to not have a nexthop event when one is removed
> due to a carrier lost.
> At least, a route event should be generated when the compat_mode is enabled.

This thread goes to a long discussion.

Ido has bringing up this issue[1]. In my patchv2[2] we skipped to send the
notification as it is deliberate.

BTW, I'm still looking into the questions you asked in my IPv6 patch[3]. Sorry
for the late response. I was busy with some other stuff recently.

[1] https://lore.kernel.org/netdev/ZLlE5of1Sw1pMPlM@shredder/
[2] https://lore.kernel.org/netdev/20230809140234.3879929-3-liuhangbin@gmail.com/
[3] https://lore.kernel.org/netdev/bf3bb290-25b7-e327-851a-d6a036daab03@6wind.com/

Thanks
Hangbin

