Return-Path: <netdev+bounces-63129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC08E82B4DD
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22DE41F25B5D
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 18:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D506155771;
	Thu, 11 Jan 2024 18:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="hpglDGNv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF0154673
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-6d9bec20980so3316508b3a.2
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 10:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704998705; x=1705603505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pf9YiHke98q12fhK0GUJBdIjwA4/pEcCFP6a3ZKpj3U=;
        b=hpglDGNvuxhfNDgFh8jPaI7S7OS2OAiAWTgzWANCDTr6fpB4LjWbdbrNMSJDe+E/Ht
         QI5cKm6pdCuZ7FObeKRrHQ27KqtGU9jqU/hkFPE49xUY1zKNpSAXb1f1kHsHug1f5J0F
         fROLV719nIqfU0kJTbGFiNU0wJNCneuyw/uGQwgH0Wl4mVB7Z3jaftg5OAlWuG4npTh0
         MWwEWNqrDT2llfm/deZ4U4ObSHJoBikfLh/5X5bf4pj3LgqXlkSPz9SHJ9It+vWznsgI
         zELji9hxFb42tf9LQ/l0MY5kyWWVe5EsspS/bf+AF3+vesg+yvCWl4kFpotL4Zz2J8Qd
         Dfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704998705; x=1705603505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pf9YiHke98q12fhK0GUJBdIjwA4/pEcCFP6a3ZKpj3U=;
        b=waQb8XixD3eXT25NfMBo8gb+w2YgirA8kAlC1ZhapuhTtmJQEi7/1lKEgVeQV18lb0
         RKRKImDRSN1ZSpYrePYKmpkffPKD3GDfR3ogIjCUOXLUtDzpfCGqA6bQZYK4uoLqqQyD
         kPrdFUd3SHknzuhLJIaLzehQOy9jqRlQxKSPd2WGnjb0a5385LY5T9MKvcdyrlfUuKdg
         uKRvv2nLMlbthyqoZGzNDpWVmBpHLEto71xtqeeXPomfpy4cmfZZevXHW1YL+BGzL4D1
         SJEQLXmTef5clC5HAL6tqUV2C0hNXgdMP2hdOHMFxafm/oFk9U85aS+omCFR/vluZ8qg
         6kxg==
X-Gm-Message-State: AOJu0YxaT/7PdkHxZqjvUS5TzcQJi5znvQpQ9UpuL9auUmcpZdwo86Rf
	mLiJBJlLE3G+7f3r2+JkATGQBfngNUW90k9FQnhGMFUSKR1Rcg==
X-Google-Smtp-Source: AGHT+IH2OE+oIfz2q/uUuWjT2hEiSqctpJnE2fm22qdFOYtuunLH1gsX2s8dMqof6pMsh+fK/b4WgQ==
X-Received: by 2002:a05:6a00:4b10:b0:6d9:bdde:bb1d with SMTP id kq16-20020a056a004b1000b006d9bddebb1dmr166116pfb.69.1704998705322;
        Thu, 11 Jan 2024 10:45:05 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id v3-20020aa78083000000b006d9b4303f9csm1513460pff.71.2024.01.11.10.45.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 10:45:04 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 3/4] doc: remove ifb README
Date: Thu, 11 Jan 2024 10:44:10 -0800
Message-ID: <20240111184451.48227-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240111184451.48227-1-stephen@networkplumber.org>
References: <20240111184451.48227-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of this document goes back to when IFB was first integrated
and covers the motivation. Only of historical interest.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/actions/ifb-README | 125 -----------------------------------------
 1 file changed, 125 deletions(-)
 delete mode 100644 doc/actions/ifb-README

diff --git a/doc/actions/ifb-README b/doc/actions/ifb-README
deleted file mode 100644
index 5fe91714671b..000000000000
--- a/doc/actions/ifb-README
+++ /dev/null
@@ -1,125 +0,0 @@
-
-IFB is intended to replace IMQ.
-Advantage over current IMQ; cleaner in particular in in SMP;
-with a _lot_ less code.
-
-Known IMQ/IFB USES
-------------------
-
-As far as i know the reasons listed below is why people use IMQ.
-It would be nice to know of anything else that i missed.
-
-1) qdiscs/policies that are per device as opposed to system wide.
-IFB allows for sharing.
-
-2) Allows for queueing incoming traffic for shaping instead of
-dropping. I am not aware of any study that shows policing is
-worse than shaping in achieving the end goal of rate control.
-I would be interested if anyone is experimenting.
-
-3) Very interesting use: if you are serving p2p you may want to give
-preference to your own locally originated traffic (when responses come back)
-vs someone using your system to do bittorent. So QoSing based on state
-comes in as the solution. What people did to achieve this was stick
-the IMQ somewhere prelocal hook.
-I think this is a pretty neat feature to have in Linux in general.
-(i.e not just for IMQ).
-But i won't go back to putting netfilter hooks in the device to satisfy
-this.  I also don't think its worth it hacking ifb some more to be
-aware of say L3 info and play ip rule tricks to achieve this.
---> Instead the plan is to have a conntrack related action. This action will
-selectively either query/create conntrack state on incoming packets.
-Packets could then be redirected to ifb based on what happens -> eg
-on incoming packets; if we find they are of known state we could send to
-a different queue than one which didn't have existing state. This
-all however is dependent on whatever rules the admin enters.
-
-At the moment this 3rd function does not exist yet. I have decided that
-instead of sitting on the patch for another year, to release it and then
-if there is pressure i will add this feature.
-
-An example, to provide functionality that most people use IMQ for below:
-
---------
-export TC="/sbin/tc"
-
-$TC qdisc add dev ifb0 root handle 1: prio
-$TC qdisc add dev ifb0 parent 1:1 handle 10: sfq
-$TC qdisc add dev ifb0 parent 1:2 handle 20: tbf rate 20kbit buffer 1600 limit 3000
-$TC qdisc add dev ifb0 parent 1:3 handle 30: sfq
-$TC filter add dev ifb0 protocol ip pref 1 parent 1: handle 1 fw classid 1:1
-$TC filter add dev ifb0 protocol ip pref 2 parent 1: handle 2 fw classid 1:2
-
-ifconfig ifb0 up
-
-$TC qdisc add dev eth0 ingress
-
-# redirect all IP packets arriving in eth0 to ifb0
-# use mark 1 --> puts them onto class 1:1
-$TC filter add dev eth0 parent ffff: protocol ip prio 10 u32 \
-match u32 0 0 flowid 1:1 \
-action ipt -j MARK --set-mark 1 \
-action mirred egress redirect dev ifb0
-
---------
-
-
-Run A Little test:
-
-from another machine ping so that you have packets going into the box:
------
-[root@jzny action-tests]# ping 10.22
-PING 10.22 (10.0.0.22): 56 data bytes
-64 bytes from 10.0.0.22: icmp_seq=0 ttl=64 time=2.8 ms
-64 bytes from 10.0.0.22: icmp_seq=1 ttl=64 time=0.6 ms
-64 bytes from 10.0.0.22: icmp_seq=2 ttl=64 time=0.6 ms
-
---- 10.22 ping statistics ---
-3 packets transmitted, 3 packets received, 0% packet loss
-round-trip min/avg/max = 0.6/1.3/2.8 ms
-[root@jzny action-tests]#
------
-Now look at some stats:
-
----
-[root@jmandrake]:~# $TC -s filter show parent ffff: dev eth0
-filter protocol ip pref 10 u32
-filter protocol ip pref 10 u32 fh 800: ht divisor 1
-filter protocol ip pref 10 u32 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1:1
-  match 00000000/00000000 at 0
-        action order 1: tablename: mangle  hook: NF_IP_PRE_ROUTING
-        target MARK set 0x1
-        index 1 ref 1 bind 1 installed 4195sec  used 27sec
-         Sent 252 bytes 3 pkts (dropped 0, overlimits 0)
-
-        action order 2: mirred (Egress Redirect to device ifb0) stolen
-        index 1 ref 1 bind 1 installed 165 sec used 27 sec
-         Sent 252 bytes 3 pkts (dropped 0, overlimits 0)
-
-[root@jmandrake]:~# $TC -s qdisc
-qdisc sfq 30: dev ifb0 limit 128p quantum 1514b
- Sent 0 bytes 0 pkts (dropped 0, overlimits 0)
-qdisc tbf 20: dev ifb0 rate 20Kbit burst 1575b lat 2147.5s
- Sent 210 bytes 3 pkts (dropped 0, overlimits 0)
-qdisc sfq 10: dev ifb0 limit 128p quantum 1514b
- Sent 294 bytes 3 pkts (dropped 0, overlimits 0)
-qdisc prio 1: dev ifb0 bands 3 priomap  1 2 2 2 1 2 0 0 1 1 1 1 1 1 1 1
- Sent 504 bytes 6 pkts (dropped 0, overlimits 0)
-qdisc ingress ffff: dev eth0 ----------------
- Sent 308 bytes 5 pkts (dropped 0, overlimits 0)
-
-[root@jmandrake]:~# ifconfig ifb0
-ifb0    Link encap:Ethernet  HWaddr 00:00:00:00:00:00
-          inet6 addr: fe80::200:ff:fe00:0/64 Scope:Link
-          UP BROADCAST RUNNING NOARP  MTU:1500  Metric:1
-          RX packets:6 errors:0 dropped:3 overruns:0 frame:0
-          TX packets:3 errors:0 dropped:0 overruns:0 carrier:0
-          collisions:0 txqueuelen:32
-          RX bytes:504 (504.0 b)  TX bytes:252 (252.0 b)
------
-
-You send it any packet not originating from the actions it will drop them.
-[In this case the three dropped packets were ipv6 ndisc].
-
-cheers,
-jamal
-- 
2.43.0


