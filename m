Return-Path: <netdev+bounces-16288-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 717D874C648
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 17:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E11172810A2
	for <lists+netdev@lfdr.de>; Sun,  9 Jul 2023 15:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515D3A951;
	Sun,  9 Jul 2023 15:44:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A694699
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 15:44:02 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7E09FA
	for <netdev@vger.kernel.org>; Sun,  9 Jul 2023 08:44:01 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b70404a5a0so55294521fa.2
        for <netdev@vger.kernel.org>; Sun, 09 Jul 2023 08:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688917439; x=1691509439;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=1OQhrt8fh17tYTVhYsSZNKsTES/IGVa3gtBLYFCQaEQ=;
        b=GPphGyYRFg7clXzdfnRuVUm6aHz8F64Fo76bnx0NjAGCl1m+TROIee+OKM99/dZX7m
         XcPYSmftTwp1yG9BP/tkCt+DDnG+EcJSOkr+5GS3a4TwTB2SLY0T9FXY0hW7/inrgLKR
         eEZfal2D3OQKDzkJ0acFFozTNTQnSJhkXpBsO5TfB1/IFKCgWp8XBj8tKiIRRHPBg3kS
         CVYLiCQ9VZdYWo9Mb6jQJfoVr+iXr44FPmFeb1TOH4aTZRnEbaeOm8i/yS2UuqKzoK9g
         DNUi9/UEprLRZnRZ8jL1HoBgHL9nU/91troMFqYsi5fkytOW8PIHaubnbJBUWLj6FvM5
         3Hqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688917439; x=1691509439;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1OQhrt8fh17tYTVhYsSZNKsTES/IGVa3gtBLYFCQaEQ=;
        b=OXH1VweGzaMWEcx3i414QkLJrzpGp5UBuoaLo5AwBbSJAAiIiji9SV16x9Zjc4iZk3
         O5mdDmrlYgukQ+1n4OM+G3Iptwg++8Hz6G/pQTne38cxgfJ8H8inuFNy11YTKomW6fy6
         zK/+NeF5hHsX3hLa8kXba8uDJ5I00uP4Cy5tNwWqa2ZEn/MvF1U7/g2JdJlsHWyJPFQ7
         TqJBNQAIS1Q6gfpGFZQ2LT+ntLkH1+kvIfOKvsCPLtnCOzVeHjzTe9sZ+DJOpqfTPAOn
         bfcDnSiEUO7p8Wus/yJAlih0Z7FdEyr2uIazQPAZJ8Pys3pwacCj6AGWsCcZkVtpTNfR
         qOYQ==
X-Gm-Message-State: ABy/qLY6KspGNo2yeF5QYkGOV0fIUvH7ygIX1y3fWx2+Ilg7A1KCC1MF
	SangsCDTqcJ/zZp6932aA9QVkVQVBNvndh6+C4Fv2RBuEiY=
X-Google-Smtp-Source: APBJJlGMXSM0/za1Gxn5wfW+ZsLeqprPpFrjuyb3LQ+mjymWahWK4/Tv+wmim+IeEj7ETVaS2SgHWX9rvqenCmeJ/ig=
X-Received: by 2002:a05:6512:31c4:b0:4fb:db2c:5d77 with SMTP id
 j4-20020a05651231c400b004fbdb2c5d77mr2116646lfe.69.1688917439402; Sun, 09 Jul
 2023 08:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Nayan Gadre <beejoy.nayan@gmail.com>
Date: Sun, 9 Jul 2023 21:13:48 +0530
Message-ID: <CABTgHBsFQo0dvPaNzv+516n3G5_6jU5tvuuZ7HRb5_G8gA3_hw@mail.gmail.com>
Subject: Behavior of tc for bridged ports
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Experts,

I have a wireless router having the client facing interface wlan0 and
the wired gateway facing interface eth0 under a bridge br0.

/ # brctl show
bridge name     bridge id               STP enabled     interfaces
br0             8000.bce67c4d8fb0       no              eth0
                                                                           wlan0

client get IP 192.168.0.105, and server (connected via eth0) has IP
192.168.0.10.
On server I run "iperf3 -s -p 5678 -V"
On client I run "iperf3 -c 192.168.0.10 -p5678 -i1 -tinf"
All works fine.

Now I want to rate limit the traffic going from wlan0 to eth0 to 5000kbits/sec.

I tried to apply a classless qdisc to eth0 port as well as wlan0 port.
# tc qdisc add dev eth0 root tbf rate 5000kbit latency 50ms burst 15k
# tc qdisc add dev wlan0 root tbf rate 5000kbit latency 50ms burst 15k

However, the qdisc does not take effect.

iperf3 -c 192.168.0.10 -p5678 -i1 -tinf
Connecting to host 192.168.0.10, port 5678
[  5] local 192.168.0.105 port 43384 connected to 192.168.0.10 port 5678
[ ID] Interval           Transfer     Bitrate         Retr  Cwnd
[  5]   0.00-1.00   sec  10.7 MBytes  89.6 Mbits/sec    0    526 KBytes
[  5]   1.00-2.00   sec  8.95 MBytes  75.1 Mbits/sec    0    560 KBytes
[  5]   2.00-3.00   sec  9.13 MBytes  76.6 Mbits/sec    0    619 KBytes

/ # tc -s qdisc
qdisc tbf 8005: dev eth0 root refcnt 5 rate 5Mbit burst 15Kb lat 50ms
 Sent 221305 bytes 469 pkt (dropped 157, overlimits 288 requeues 0)
 backlog 0b 0p requeues 0
qdisc tbf 8006: dev wlan16 root refcnt 5 rate 5Mbit burst 15Kb lat 50ms
 Sent 7095 bytes 109 pkt (dropped 0, overlimits 0 requeues 0)
 backlog 0b 0p requeues 0

My kernel is 4.4.60, and I checked that qdisc gets activated in the
egress path after dev_queue_xmit() is called. And for a bridged port,
the path taken by the packet coming to wlan0 is
__br_deliver -> br_forward_finish -> br_dev_queue_push_xmit -> dev_queue_xmit.

So the qdisc should have taken effect even in the bridged case. I see
statistics for eth0 qdisc.
What am I missing in the tc rule ?

If I apply the same rule on the server and client interfaces then I
can see rate limiting taking effect. But on the wireless router linux
bridge it's not working.

Thanks
N Gadre

