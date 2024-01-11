Return-Path: <netdev+bounces-63130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E26EA82B4DE
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 19:45:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10E8F1C245B8
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 18:45:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F164255C00;
	Thu, 11 Jan 2024 18:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="HNsjMHAT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0552654F9A
	for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 18:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d9a795cffbso4219377b3a.0
        for <netdev@vger.kernel.org>; Thu, 11 Jan 2024 10:45:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704998706; x=1705603506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gtyMfHbhaGgr3o4nLTjlZj3oa1+iqbMH9OcTY5kK/MQ=;
        b=HNsjMHATaSVtStYQ0AEvgDlrX2tpCazU59N+iK/8W3wCJ0FLxmT+oQsu5i9oQ6o8Jb
         k5grMQPI71uyS49d7y4aKTBQdBh+IiNbM+MGkIXVsq5KvooAxqCsL0ioItSUukKwZza0
         bf6oIii8skpt6YbJ/GG/4uXvGYrzL3LOmLyeSF4R4YVM1ZJlAwNWdfW63aCcGtZmB3as
         gL4sIKuEPyWY7UBir4qPF3vvoydfyc01MUpzGsC0pMvPuIJBcqwJe0rXYURi5GfKXYom
         z5LQXNyQbxOiQhnjpeB2QCV5fS+UNT7nCc3lYBr4iRx+A5sbItonnbiQLYXJ6q4W7Aw4
         oDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704998706; x=1705603506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gtyMfHbhaGgr3o4nLTjlZj3oa1+iqbMH9OcTY5kK/MQ=;
        b=atq426nXfe37Xz3tivsdzPdOnPoz8fSQjjhLdI19x6yV1L1rLeRJyM/8LRogifS3Lf
         nmqljt1MzSvc8SMGXjKXEppE4zlkHhq0Wt8B3NrNdpuh/0arWz9Rh0rq2Q0FJJNKFEGN
         hiZ074lZA5GFSnRdu0KYXd2rLS1/DqI3DkE+QE5ahtkpdqwmqGPKI9qy56TspZO0frCI
         cTJedy9Bt1JwMvzzcGddfQr26GA4Gu6xS1+yWR68sfWywrsJvQWbrF2frZMiLizBLQSn
         70fcqLE5/kAqc6WxBXsIk9srxoQ91XTbCgnVAeCqquro9y64vU8WT28j37StTXlyN7z3
         Y8mg==
X-Gm-Message-State: AOJu0YwMDmRa+S9SpD28nmd6mi8zH8II9PnJbmxfuyXOOhEUSy547507
	UQXpGl8BkdPtRP/Zfr2MRb41lzc2KO6NPYG/36FWdoiAX1Jc6g==
X-Google-Smtp-Source: AGHT+IGcMmaDycSWbJknsOLNwvwHqLZrAYcaAEkyoFOotCmfpJS8+JUXpfu7IkNqOhRoRzcX+EPIRg==
X-Received: by 2002:a62:5486:0:b0:6da:ed17:bfa7 with SMTP id i128-20020a625486000000b006daed17bfa7mr379316pfb.6.1704998706190;
        Thu, 11 Jan 2024 10:45:06 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id v3-20020aa78083000000b006d9b4303f9csm1513460pff.71.2024.01.11.10.45.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jan 2024 10:45:05 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2-next 4/4] doc: remove out dated actions-general
Date: Thu, 11 Jan 2024 10:44:11 -0800
Message-ID: <20240111184451.48227-5-stephen@networkplumber.org>
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

This file is rather free form, out dated, and redundant.
Everything here should be covered on man pages.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/actions/actions-general | 256 ------------------------------------
 1 file changed, 256 deletions(-)
 delete mode 100644 doc/actions/actions-general

diff --git a/doc/actions/actions-general b/doc/actions/actions-general
deleted file mode 100644
index a0074a58c653..000000000000
--- a/doc/actions/actions-general
+++ /dev/null
@@ -1,256 +0,0 @@
-
-This documented is slightly dated but should give you idea of how things
-work.
-
-What is it?
------------
-
-An extension to the filtering/classification architecture of Linux Traffic
-Control.
-Up to 2.6.8 the only action that could be "attached" to a filter was policing.
-i.e you could say something like:
-
------
-tc filter add dev lo parent ffff: protocol ip prio 10 u32 match ip src \
-127.0.0.1/32 flowid 1:1 police mtu 4000 rate 1500kbit burst 90k
------
-
-which implies "if a packet is seen on the ingress of the lo device with
-a source IP address of 127.0.0.1/32 we give it a classification id  of 1:1 and
-we execute a policing action which rate limits its bandwidth utilization
-to 1.5Mbps".
-
-The new extensions allow for more than just policing actions to be added.
-They are also fully backward compatible. If you have a kernel that doesn't
-understand them, then the effect is null i.e if you have a newer tc
-but older kernel, the actions are not installed. Likewise if you
-have a newer kernel but older tc, obviously the tc will use current
-syntax which will work fine. Of course to get the required effect you need
-both newer tc and kernel. If you are reading this you have the
-right tc ;->
-
-A side effect is that we can now get stateless firewalling to work with tc.
-Essentially this is now an alternative to iptables.
-I won't go into details of my dislike for iptables at times, but
-scalability is one of the main issues; however, if you need stateful
-classification - use netfilter (for now).
-
-This stuff works on both ingress and egress qdiscs.
-
-Features
---------
-
-1) new additional syntax and actions enabled. Note old syntax is still valid.
-
-Essentially this is still the same syntax as tc with a new construct
-"action". The syntax is of the form:
-tc filter add <DEVICE> parent 1:0 protocol ip prio 10 <Filter description>
-flowid 1:1 action <ACTION description>*
-
-You can have as many actions as you want (within sensible reasoning).
-
-In the past the only real action was the policer; i.e you could do something
-along the lines of:
-tc filter add dev lo parent ffff: protocol ip prio 10 u32 \
-match ip src 127.0.0.1/32 flowid 1:1 \
-police mtu 4000 rate 1500kbit burst 90k
-
-Although you can still use the same syntax, now you can say:
-
-tc filter add dev lo parent 1:0 protocol ip prio 10 u32 \
-match ip src 127.0.0.1/32 flowid 1:1 \
-action police mtu 4000 rate 1500kbit burst 90k
-
-" generic Actions" (gact) at the moment are:
-{ drop, pass, reclassify, continue}
-(If you have others, no listed here give me a reason and we will add them)
-+drop says to drop the packet
-+pass and ok (are equivalent) says to accept it
-+reclassify requests for reclassification of the packet
-+continue requests for next lookup to match
-
-2)In order to take advantage of some of the targets written by the
-iptables people, a classifier can have a packet being massaged by an
-iptable target. I have only tested with mangler targets up to now.
-(in fact anything that is not in the mangling table is disabled right now)
-
-In terms of hooks:
-*ingress is mapped to pre-routing hook
-*egress is mapped to post-routing hook
-I don't see much value in the other hooks, if you see it and email me good
-reasons, the addition is trivial.
-
-Example syntax for iptables targets usage becomes:
-tc filter add ..... u32 <u32 syntax> action ipt -j <iptables target syntax>
-
-example:
-tc filter add dev lo parent ffff: protocol ip prio 8 u32 \
-match ip dst 127.0.0.8/32 flowid 1:12 \
-action ipt -j mark --set-mark 2
-
-NOTE: flowid 1:12 is parsed flowid 0x1:0x12.  Make sure if you want flowid
-decimal 12, then use flowid 1:c.
-
-3) A feature i call pipe
-The motivation is derived from Unix pipe mechanism but applied to packets.
-Essentially take a matching packet and pass it through
-action1 | action2 | action3 etc.
-You could do something similar to this with the tc policer and the "continue"
-operator but this rather restricts it to just the policer and requires
-multiple rules (and lookups, hence quiet inefficient);
-
-as an example -- and please note that this is just an example _not_ The
-Word Youve Been Waiting For (yes i have had problems giving examples
-which ended becoming dogma in documents and people modifying them a little
-to look clever);
-
-i selected the metering rates to be small so that i can show better how
-things work.
-
-The script below does the following:
-- an incoming packet from 10.0.0.21 is first given a firewall mark of 1.
-
-- It is then metered to make sure it does not exceed its allocated rate of
-1Kbps. If it doesn't exceed rate, this is where we terminate action execution.
-
-- If it does exceed its rate, its "color" changes to a mark of 2 and it is
-then passed through a second meter.
-
--The second meter is shared across all flows on that device [i am surpised
-that this seems to be not a well know feature of the policer; Bert was telling
-me that someone was writing a qdisc just to do sharing across multiple devices;
-it must be the summer heat again; weve had someone doing that every year around
-summer  -- the key to sharing is to use a operator "index" in your policer
-rules (example "index 20"). All your rules have to use the same index to
-share.]
-
--If the second meter is exceeded the color of the flow changes further to 3.
-
--We then pass the packet to another meter which is shared across all devices
-in the system. If this meter is exceeded we drop the packet.
-
-Note the mark can be used further up the system to do things like policy
-or more interesting things on the egress.
-
------------------- cut here -------------------------------
-#
-# Add an ingress qdisc on eth0
-tc qdisc add dev eth0 ingress
-#
-#if you see an incoming packet from 10.0.0.21
-tc filter add dev eth0 parent ffff: protocol ip prio 1 \
-u32 match ip src 10.0.0.21/32 flowid 1:15 \
-#
-# first give it a mark of 1
-action ipt -j mark --set-mark 1 index 2 \
-#
-# then pass it through a policer which allows 1kbps; if the flow
-# doesn't exceed that rate, this is where we stop, if it exceeds we
-# pipe the packet to the next action
-action police rate 1kbit burst 9k pipe \
-#
-# which marks the packet fwmark as 2 and pipes
-action ipt -j mark --set-mark 2 \
-#
-# next attempt to borrow b/width from a meter
-# used across all flows incoming on eth0("index 30")
-# and if that is exceeded we pipe to the next action
-action police index 30 mtu 5000 rate 1kbit burst 10k pipe \
-# mark it as fwmark 3 if exceeded
-action ipt -j mark --set-mark 3 \
-# and then attempt to borrow from a meter used by all devices in the
-# system. Should this be exceeded, drop the packet on the floor.
-action police index 20 mtu 5000 rate 1kbit burst 90k drop
----------------------------------
-
-Now lets see the actions installed with
-"tc filter show parent ffff: dev eth0"
-
--------- output -----------
-jroot# tc filter show parent ffff: dev eth0
-filter protocol ip pref 1 u32
-filter protocol ip pref 1 u32 fh 800: ht divisor 1
-filter protocol ip pref 1 u32 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1:15
-
-   action order 1: tablename: mangle  hook: NF_IP_PRE_ROUTING
-        target MARK set 0x1  index 2
-
-   action order 2: police 1 action pipe rate 1Kbit burst 9Kb mtu 2Kb
-
-   action order 3: tablename: mangle  hook: NF_IP_PRE_ROUTING
-        target MARK set 0x2  index 1
-
-   action order 4: police 30 action pipe rate 1Kbit burst 10Kb mtu 5000b
-
-   action order 5: tablename: mangle  hook: NF_IP_PRE_ROUTING
-        target MARK set 0x3  index 3
-
-   action order 6: police 20 action drop rate 1Kbit burst 90Kb mtu 5000b
-
-  match 0a000015/ffffffff at 12
--------------------------------
-
-Note the ordering of the actions is based on the order in which we entered
-them. In the future i will add explicit priorities.
-
-Now lets run a ping -f from 10.0.0.21 to this host; stop the ping after
-you see a few lines of dots
-
-----
-[root@jzny hadi]# ping -f  10.0.0.22
-PING 10.0.0.22 (10.0.0.22): 56 data bytes
-....................................................................................................................................................................................................................................................................................................................................................................................................................................................
---- 10.0.0.22 ping statistics ---
-2248 packets transmitted, 1811 packets received, 19% packet loss
-round-trip min/avg/max = 0.7/9.3/20.1 ms
------------------------------
-
-Now lets take a look at the stats with "tc -s filter show parent ffff: dev eth0"
-
---------------
-jroot# tc -s filter show parent ffff: dev eth0
-filter protocol ip pref 1 u32
-filter protocol ip pref 1 u32 fh 800: ht divisor 1
-filter protocol ip pref 1 u32 fh 800::800 order 2048 key ht 800 bkt 0 flowid 1:1
-5
-
-   action order 1: tablename: mangle  hook: NF_IP_PRE_ROUTING
-        target MARK set 0x1  index 2
-         Sent 188832 bytes 2248 pkts (dropped 0, overlimits 0)
-
-   action order 2: police 1 action pipe rate 1Kbit burst 9Kb mtu 2Kb
-         Sent 188832 bytes 2248 pkts (dropped 0, overlimits 2122)
-
-   action order 3: tablename: mangle  hook: NF_IP_PRE_ROUTING
-        target MARK set 0x2  index 1
-         Sent 178248 bytes 2122 pkts (dropped 0, overlimits 0)
-
-   action order 4: police 30 action pipe rate 1Kbit burst 10Kb mtu 5000b
-         Sent 178248 bytes 2122 pkts (dropped 0, overlimits 1945)
-
-   action order 5: tablename: mangle  hook: NF_IP_PRE_ROUTING
-        target MARK set 0x3  index 3
-         Sent 163380 bytes 1945 pkts (dropped 0, overlimits 0)
-
-   action order 6: police 20 action drop rate 1Kbit burst 90Kb mtu 5000b
-         Sent 163380 bytes 1945 pkts (dropped 0, overlimits 437)
-
-  match 0a000015/ffffffff at 12
--------------------------------
-
-Neat, eh?
-
-
-Want to  write an action module?
-------------------------------
-Its easy. Either look at the code or send me email. I will document at
-some point; will also accept documentation.
-
-TODO
-----
-
-Lotsa goodies/features coming. Requests also being accepted.
-At the moment the focus has been on getting the architecture in place.
-Expect new things in the spurious time i have to work on this
-(particularly around end of year when i have typically get time off
-from work).
-- 
2.43.0


