Return-Path: <netdev+bounces-45284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 343937DBE5A
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 17:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D79AB2815C7
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 16:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6701918E3A;
	Mon, 30 Oct 2023 16:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="fB+yLYk4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E430EAD5
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 16:55:57 +0000 (UTC)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1768FDD
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 09:55:49 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6be1bc5aa1cso4675107b3a.3
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 09:55:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1698684948; x=1699289748; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mfWD6Zw1vWpFbiQJM6CKwNEI3AIsK+otL6WI0zYUsXo=;
        b=fB+yLYk42VV/LZA0d0PUxRVLFmW7NWVrz9I0bfsEraY2npLAidCHARXg63z6siR4SI
         AT6h6AF5mPVXypAFCcW9z9sxIicXH4DOR7riiAAm+H0ZOYF9Ze1aN2yYLqyzcM3yZfOB
         MiOAwNYc+coO+27Qcj2lGUu85Qup5xlA2jfkoQ3VIoL2x3t0VwLpVeJkKi6vZ81OGC7e
         23vh/J8sNvfsV9d7tvrq8eWUF17TZKx5C9N0IU9/vwSNgUPW6SrIEyV+yBSKkUuj0a1R
         g6xjmZ3nxFC7cnC0KwU4Fi3D2lJrFoJV/9NDbSV2HOagxBpeKqmd85qORXGNSLXGctJS
         Ovqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698684948; x=1699289748;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mfWD6Zw1vWpFbiQJM6CKwNEI3AIsK+otL6WI0zYUsXo=;
        b=wLVKFnxIpO2QGeHfCKfxkRsbaA41ZDMA/USRfI/WJ1xUpgHcruRCOiwUg6QCvH70LQ
         v+Ez33sMhRgBUgig98jpWU/TGCUESo8Knn3z2iBfy0+leXgVCfmYNHpGSkFqmlN7AmKR
         qqPWSabmOu1DkmFJ4UiuNSN1txBPGdhpgSLT9WneR5/58keCYm0qBhs1ojSVcxWUbhuM
         1V+Jrd+BWAUWHdwuMngxbLSBFCG2TZKUBL9DWsphcXdedQ44bANUuyg6DO3PoBk93xNt
         NXGm2xS5GSwwUINb8n9+XCX91+5XBeiUl9CjcrAbssGZbvJkIUsPglm2Sry1DixVntaf
         zw7w==
X-Gm-Message-State: AOJu0YwqFDe60Z9r9WUKnZ9oXDO+LwLgUvrrctbK+Hy0/V3jAlmspUHD
	yVtd0WKvaO63TrO8mBJNv9jIVEF+3ucVtYN1GHbAlpgU
X-Google-Smtp-Source: AGHT+IFue/pK6oMYHx1pq9I3U0A2Kc3z214yBEOFX2KNEBRXxqTGXj9kboEraQNU9jnc8pQvI0GAtA==
X-Received: by 2002:a05:6a00:1ad3:b0:68f:f741:57a1 with SMTP id f19-20020a056a001ad300b0068ff74157a1mr13219009pfv.7.1698684947144;
        Mon, 30 Oct 2023 09:55:47 -0700 (PDT)
Received: from fedora.. ([38.142.2.14])
        by smtp.gmail.com with ESMTPSA id fa39-20020a056a002d2700b0068fece2c190sm6132752pfb.70.2023.10.30.09.55.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 09:55:46 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2] remove support for CBQ, RSVP and tc-index
Date: Mon, 30 Oct 2023 09:54:02 -0700
Message-ID: <20231030165501.10596-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"Bring out your dead".
The kernel removed support for CBQ, RSVP and tcindex because these
features were causing lots of failing syszbot tests.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
Thanks to Jamal at TC workshop for suggestion.
 bash-completion/tc           |  24 +-
 man/man8/tc-cbq-details.8    | 423 -------------------------
 man/man8/tc-cbq.8            | 351 ---------------------
 man/man8/tc-tcindex.8        |  58 ----
 man/man8/tc.8                |  19 +-
 tc/Makefile                  |   4 -
 tc/f_rsvp.c                  | 417 -------------------------
 tc/f_tcindex.c               | 185 -----------
 tc/q_cbq.c                   | 589 -----------------------------------
 tc/tc_cbq.c                  |  53 ----
 tc/tc_cbq.h                  |  10 -
 tc/tc_class.c                |   2 +-
 tc/tc_filter.c               |   2 +-
 tc/tc_qdisc.c                |   2 +-
 testsuite/tests/tc/cbq.t     |  10 -
 testsuite/tests/tc/policer.t |  13 -
 16 files changed, 7 insertions(+), 2155 deletions(-)
 delete mode 100644 man/man8/tc-cbq-details.8
 delete mode 100644 man/man8/tc-cbq.8
 delete mode 100644 man/man8/tc-tcindex.8
 delete mode 100644 tc/f_rsvp.c
 delete mode 100644 tc/f_tcindex.c
 delete mode 100644 tc/q_cbq.c
 delete mode 100644 tc/tc_cbq.c
 delete mode 100644 tc/tc_cbq.h
 delete mode 100755 testsuite/tests/tc/cbq.t
 delete mode 100755 testsuite/tests/tc/policer.t

diff --git a/bash-completion/tc b/bash-completion/tc
index 8352cc94..a097c407 100644
--- a/bash-completion/tc
+++ b/bash-completion/tc
@@ -4,8 +4,8 @@
 
 QDISC_KIND=' choke codel bfifo pfifo pfifo_head_drop fq fq_codel gred hhf \
             mqprio multiq netem pfifo_fast pie fq_pie red sfb sfq tbf atm \
-            cbq drr dsmark hfsc htb prio qfq '
-FILTER_KIND=' basic bpf cgroup flow flower fw route rsvp tcindex u32 matchall '
+            drr dsmark hfsc htb prio qfq '
+FILTER_KIND=' basic bpf cgroup flow flower fw route u32 matchall '
 ACTION_KIND=' gact mirred bpf sample '
 
 # Takes a list of words in argument; each one of them is added to COMPREPLY if
@@ -358,10 +358,6 @@ _tc_qdisc_options()
                 linklayer'
             return 0
             ;;
-        cbq)
-            _tc_once_attr 'bandwidth avpkt mpu cell ewma'
-            return 0
-            ;;
         dsmark)
             _tc_once_attr 'indices default_index set_tc_index'
             return 0
@@ -476,22 +472,6 @@ _tc_filter_options()
             _tc_once_attr 'to classid action'
             return 0
             ;;
-        rsvp)
-            _tc_once_attr 'ipproto session sender classid action tunnelid \
-                tunnel flowlabel spi/ah spi/esp u8 u16 u32'
-            [[ ${words[${#words[@]}-3]} == tunnel ]] && \
-                    COMPREPLY+=( $( compgen -W 'skip' -- "$cur" ) )
-            [[ ${words[${#words[@]}-3]} =~ u(8|16|32) ]] && \
-                    COMPREPLY+=( $( compgen -W 'mask' -- "$cur" ) )
-            [[ ${words[${#words[@]}-3]} == mask ]] && \
-                    COMPREPLY+=( $( compgen -W 'at' -- "$cur" ) )
-            return 0
-            ;;
-        tcindex)
-            _tc_once_attr 'hash mask shift classid action'
-            _tc_one_of_list 'pass_on fall_through'
-            return 0
-            ;;
         u32)
             _tc_once_attr 'match link classid action offset ht hashkey sample'
             COMPREPLY+=( $( compgen -W 'ip ip6 udp tcp icmp u8 u16 u32 mark \
diff --git a/man/man8/tc-cbq-details.8 b/man/man8/tc-cbq-details.8
deleted file mode 100644
index 9368103b..00000000
--- a/man/man8/tc-cbq-details.8
+++ /dev/null
@@ -1,423 +0,0 @@
-.TH CBQ 8 "8 December 2001" "iproute2" "Linux"
-.SH NAME
-CBQ \- Class Based Queueing
-.SH SYNOPSIS
-.B tc qdisc ... dev
-dev
-.B  ( parent
-classid
-.B | root) [ handle
-major:
-.B ] cbq avpkt
-bytes
-.B bandwidth
-rate
-.B [ cell
-bytes
-.B ] [ ewma
-log
-.B ] [ mpu
-bytes
-.B ]
-
-.B tc class ... dev
-dev
-.B parent
-major:[minor]
-.B [ classid
-major:minor
-.B ] cbq allot
-bytes
-.B [ bandwidth
-rate
-.B ] [ rate
-rate
-.B ] prio
-priority
-.B [ weight
-weight
-.B ] [ minburst
-packets
-.B ] [ maxburst
-packets
-.B ] [ ewma
-log
-.B ] [ cell
-bytes
-.B ] avpkt
-bytes
-.B [ mpu
-bytes
-.B ] [ bounded isolated ] [ split
-handle
-.B & defmap
-defmap
-.B ] [ estimator
-interval timeconstant
-.B ]
-
-.SH DESCRIPTION
-Class Based Queueing is a classful qdisc that implements a rich
-linksharing hierarchy of classes. It contains shaping elements as
-well as prioritizing capabilities. Shaping is performed using link
-idle time calculations based on the timing of dequeue events and
-underlying link bandwidth.
-
-.SH SHAPING ALGORITHM
-Shaping is done using link idle time calculations, and actions taken if
-these calculations deviate from set limits.
-
-When shaping a 10mbit/s connection to 1mbit/s, the link will
-be idle 90% of the time. If it isn't, it needs to be throttled so that it
-IS idle 90% of the time.
-
-From the kernel's perspective, this is hard to measure, so CBQ instead
-derives the idle time from the number of microseconds (in fact, jiffies)
-that elapse between  requests from the device driver for more data. Combined
-with the  knowledge of packet sizes, this is used to approximate how full or
-empty the link is.
-
-This is rather circumspect and doesn't always arrive at proper
-results. For example, what is the actual link speed of an interface
-that is not really able to transmit the full 100mbit/s of data,
-perhaps because of a badly implemented driver? A PCMCIA network card
-will also never achieve 100mbit/s because of the way the bus is
-designed - again, how do we calculate the idle time?
-
-The physical link bandwidth may be ill defined in case of not-quite-real
-network devices like PPP over Ethernet or PPTP over TCP/IP. The effective
-bandwidth in that case is probably determined by the efficiency of pipes
-to userspace - which not defined.
-
-During operations, the effective idletime is measured using an
-exponential weighted moving average (EWMA), which considers recent
-packets to be exponentially more important than past ones. The Unix
-loadaverage is calculated in the same way.
-
-The calculated idle time is subtracted from the EWMA measured one,
-the resulting number is called 'avgidle'. A perfectly loaded link has
-an avgidle of zero: packets arrive exactly at the calculated
-interval.
-
-An overloaded link has a negative avgidle and if it gets too negative,
-CBQ throttles and is then 'overlimit'.
-
-Conversely, an idle link might amass a huge avgidle, which would then
-allow infinite bandwidths after a few hours of silence. To prevent
-this, avgidle is capped at
-.B maxidle.
-
-If overlimit, in theory, the CBQ could throttle itself for exactly the
-amount of time that was calculated to pass between packets, and then
-pass one packet, and throttle again. Due to timer resolution constraints,
-this may not be feasible, see the
-.B minburst
-parameter below.
-
-.SH CLASSIFICATION
-Within the one CBQ instance many classes may exist. Each of these classes
-contains another qdisc, by default
-.BR tc-pfifo (8).
-
-When enqueueing a packet, CBQ starts at the root and uses various methods to
-determine which class should receive the data. If a verdict is reached, this
-process is repeated for the recipient class which might have further
-means of classifying traffic to its children, if any.
-
-CBQ has the following methods available to classify a packet to any child
-classes.
-.TP
-(i)
-.B skb->priority class encoding.
-Can be set from userspace by an application with the
-.B SO_PRIORITY
-setsockopt.
-The
-.B skb->priority class encoding
-only applies if the skb->priority holds a major:minor handle of an existing
-class within  this qdisc.
-.TP
-(ii)
-tc filters attached to the class.
-.TP
-(iii)
-The defmap of a class, as set with the
-.B split & defmap
-parameters. The defmap may contain instructions for each possible Linux packet
-priority.
-
-.P
-Each class also has a
-.B level.
-Leaf nodes, attached to the bottom of the class hierarchy, have a level of 0.
-.SH CLASSIFICATION ALGORITHM
-
-Classification is a loop, which terminates when a leaf class is found. At any
-point the loop may jump to the fallback algorithm.
-
-The loop consists of the following steps:
-.TP
-(i)
-If the packet is generated locally and has a valid classid encoded within its
-.B skb->priority,
-choose it and terminate.
-
-.TP
-(ii)
-Consult the tc filters, if any, attached to this child. If these return
-a class which is not a leaf class, restart loop from the class returned.
-If it is a leaf, choose it and terminate.
-.TP
-(iii)
-If the tc filters did not return a class, but did return a classid,
-try to find a class with that id within this qdisc.
-Check if the found class is of a lower
-.B level
-than the current class. If so, and the returned class is not a leaf node,
-restart the loop at the found class. If it is a leaf node, terminate.
-If we found an upward reference to a higher level, enter the fallback
-algorithm.
-.TP
-(iv)
-If the tc filters did not return a class, nor a valid reference to one,
-consider the minor number of the reference to be the priority. Retrieve
-a class from the defmap of this class for the priority. If this did not
-contain a class, consult the defmap of this class for the
-.B BEST_EFFORT
-class. If this is an upward reference, or no
-.B BEST_EFFORT
-class was defined,
-enter the fallback algorithm. If a valid class was found, and it is not a
-leaf node, restart the loop at this class. If it is a leaf, choose it and
-terminate. If
-neither the priority distilled from the classid, nor the
-.B BEST_EFFORT
-priority yielded a class, enter the fallback algorithm.
-.P
-The fallback algorithm resides outside of the loop and is as follows.
-.TP
-(i)
-Consult the defmap of the class at which the jump to fallback occurred. If
-the defmap contains a class for the
-.B
-priority
-of the class (which is related to the TOS field), choose this class and
-terminate.
-.TP
-(ii)
-Consult the map for a class for the
-.B BEST_EFFORT
-priority. If found, choose it, and terminate.
-.TP
-(iii)
-Choose the class at which break out to the fallback algorithm occurred. Terminate.
-.P
-The packet is enqueued to the class which was chosen when either algorithm
-terminated. It is therefore possible for a packet to be enqueued *not* at a
-leaf node, but in the middle of the hierarchy.
-
-.SH LINK SHARING ALGORITHM
-When dequeuing for sending to the network device, CBQ decides which of its
-classes will be allowed to send. It does so with a Weighted Round Robin process
-in which each class with packets gets a chance to send in turn. The WRR process
-starts by asking the highest priority classes (lowest numerically -
-highest semantically) for packets, and will continue to do so until they
-have no more data to offer, in which case the process repeats for lower
-priorities.
-
-.B CERTAINTY ENDS HERE, ANK PLEASE HELP
-
-Each class is not allowed to send at length though - they can only dequeue a
-configurable amount of data during each round.
-
-If a class is about to go overlimit, and it is not
-.B bounded
-it will try to borrow avgidle from siblings that are not
-.B isolated.
-This process is repeated from the bottom upwards. If a class is unable
-to borrow enough avgidle to send a packet, it is throttled and not asked
-for a packet for enough time for the avgidle to increase above zero.
-
-.B I REALLY NEED HELP FIGURING THIS OUT. REST OF DOCUMENT IS PRETTY CERTAIN
-.B AGAIN.
-
-.SH QDISC
-The root qdisc of a CBQ class tree has the following parameters:
-
-.TP
-parent major:minor | root
-This mandatory parameter determines the place of the CBQ instance, either at the
-.B root
-of an interface or within an existing class.
-.TP
-handle major:
-Like all other qdiscs, the CBQ can be assigned a handle. Should consist only
-of a major number, followed by a colon. Optional.
-.TP
-avpkt bytes
-For calculations, the average packet size must be known. It is silently capped
-at a minimum of 2/3 of the interface MTU. Mandatory.
-.TP
-bandwidth rate
-To determine the idle time, CBQ must know the bandwidth of your underlying
-physical interface, or parent qdisc. This is a vital parameter, more about it
-later. Mandatory.
-.TP
-cell
-The cell size determines he granularity of packet transmission time calculations. Has a sensible default.
-.TP
-mpu
-A zero sized packet may still take time to transmit. This value is the lower
-cap for packet transmission time calculations - packets smaller than this value
-are still deemed to have this size. Defaults to zero.
-.TP
-ewma log
-When CBQ needs to measure the average idle time, it does so using an
-Exponentially Weighted Moving Average which smooths out measurements into
-a moving average. The EWMA LOG determines how much smoothing occurs. Defaults
-to 5. Lower values imply greater sensitivity. Must be between 0 and 31.
-.P
-A CBQ qdisc does not shape out of its own accord. It only needs to know certain
-parameters about the underlying link. Actual shaping is done in classes.
-
-.SH CLASSES
-Classes have a host of parameters to configure their operation.
-
-.TP
-parent major:minor
-Place of this class within the hierarchy. If attached directly to a qdisc
-and not to another class, minor can be omitted. Mandatory.
-.TP
-classid major:minor
-Like qdiscs, classes can be named. The major number must be equal to the
-major number of the qdisc to which it belongs. Optional, but needed if this
-class is going to have children.
-.TP
-weight weight
-When dequeuing to the interface, classes are tried for traffic in a
-round-robin fashion. Classes with a higher configured qdisc will generally
-have more traffic to offer during each round, so it makes sense to allow
-it to dequeue more traffic. All weights under a class are normalized, so
-only the ratios matter. Defaults to the configured rate, unless the priority
-of this class is maximal, in which case it is set to 1.
-.TP
-allot bytes
-Allot specifies how many bytes a qdisc can dequeue
-during each round of the process. This parameter is weighted using the
-renormalized class weight described above.
-
-.TP
-priority priority
-In the round-robin process, classes with the lowest priority field are tried
-for packets first. Mandatory.
-
-.TP
-rate rate
-Maximum rate this class and all its children combined can send at. Mandatory.
-
-.TP
-bandwidth rate
-This is different from the bandwidth specified when creating a CBQ disc. Only
-used to determine maxidle and offtime, which are only calculated when
-specifying maxburst or minburst. Mandatory if specifying maxburst or minburst.
-
-.TP
-maxburst
-This number of packets is used to calculate maxidle so that when
-avgidle is at maxidle, this number of average packets can be burst
-before avgidle drops to 0. Set it higher to be more tolerant of
-bursts. You can't set maxidle directly, only via this parameter.
-
-.TP
-minburst
-As mentioned before, CBQ needs to throttle in case of
-overlimit. The ideal solution is to do so for exactly the calculated
-idle time, and pass 1 packet. However, Unix kernels generally have a
-hard time scheduling events shorter than 10ms, so it is better to
-throttle for a longer period, and then pass minburst packets in one
-go, and then sleep minburst times longer.
-
-The time to wait is called the offtime. Higher values of minburst lead
-to more accurate shaping in the long term, but to bigger bursts at
-millisecond timescales.
-
-.TP
-minidle
-If avgidle is below 0, we are overlimits and need to wait until
-avgidle will be big enough to send one packet. To prevent a sudden
-burst from shutting down the link for a prolonged period of time,
-avgidle is reset to minidle if it gets too low.
-
-Minidle is specified in negative microseconds, so 10 means that
-avgidle is capped at -10us.
-
-.TP
-bounded
-Signifies that this class will not borrow bandwidth from its siblings.
-.TP
-isolated
-Means that this class will not borrow bandwidth to its siblings
-
-.TP
-split major:minor & defmap bitmap[/bitmap]
-If consulting filters attached to a class did not give a verdict,
-CBQ can also classify based on the packet's priority. There are 16
-priorities available, numbered from 0 to 15.
-
-The defmap specifies which priorities this class wants to receive,
-specified as a bitmap. The Least Significant Bit corresponds to priority
-zero. The
-.B split
-parameter tells CBQ at which class the decision must be made, which should
-be a (grand)parent of the class you are adding.
-
-As an example, 'tc class add ... classid 10:1 cbq .. split 10:0 defmap c0'
-configures class 10:0 to send packets with priorities 6 and 7 to 10:1.
-
-The complimentary configuration would then
-be: 'tc class add ... classid 10:2 cbq ... split 10:0 defmap 3f'
-Which would send all packets 0, 1, 2, 3, 4 and 5 to 10:1.
-.TP
-estimator interval timeconstant
-CBQ can measure how much bandwidth each class is using, which tc filters
-can use to classify packets with. In order to determine the bandwidth
-it uses a very simple estimator that measures once every
-.B interval
-microseconds how much traffic has passed. This again is a EWMA, for which
-the time constant can be specified, also in microseconds. The
-.B time constant
-corresponds to the sluggishness of the measurement or, conversely, to the
-sensitivity of the average to short bursts. Higher values mean less
-sensitivity.
-
-
-
-.SH SOURCES
-.TP
-o
-Sally Floyd and Van Jacobson, "Link-sharing and Resource
-Management Models for Packet Networks",
-IEEE/ACM Transactions on Networking, Vol.3, No.4, 1995
-
-.TP
-o
-Sally Floyd, "Notes on CBQ and Guarantee Service", 1995
-
-.TP
-o
-Sally Floyd, "Notes on Class-Based Queueing: Setting
-Parameters", 1996
-
-.TP
-o
-Sally Floyd and Michael Speer, "Experimental Results
-for Class-Based Queueing", 1998, not published.
-
-
-
-.SH SEE ALSO
-.BR tc (8)
-
-.SH AUTHOR
-Alexey N. Kuznetsov, <kuznet@ms2.inr.ac.ru>. This manpage maintained by
-bert hubert <ahu@ds9a.nl>
diff --git a/man/man8/tc-cbq.8 b/man/man8/tc-cbq.8
deleted file mode 100644
index 301265d8..00000000
--- a/man/man8/tc-cbq.8
+++ /dev/null
@@ -1,351 +0,0 @@
-.TH CBQ 8 "16 December 2001" "iproute2" "Linux"
-.SH NAME
-CBQ \- Class Based Queueing
-.SH SYNOPSIS
-.B tc qdisc ... dev
-dev
-.B  ( parent
-classid
-.B | root) [ handle
-major:
-.B ] cbq [ allot
-bytes
-.B ] avpkt
-bytes
-.B bandwidth
-rate
-.B [ cell
-bytes
-.B ] [ ewma
-log
-.B ] [ mpu
-bytes
-.B ]
-
-.B tc class ... dev
-dev
-.B parent
-major:[minor]
-.B [ classid
-major:minor
-.B ] cbq allot
-bytes
-.B [ bandwidth
-rate
-.B ] [ rate
-rate
-.B ] prio
-priority
-.B [ weight
-weight
-.B ] [ minburst
-packets
-.B ] [ maxburst
-packets
-.B ] [ ewma
-log
-.B ] [ cell
-bytes
-.B ] avpkt
-bytes
-.B [ mpu
-bytes
-.B ] [ bounded isolated ] [ split
-handle
-.B & defmap
-defmap
-.B ] [ estimator
-interval timeconstant
-.B ]
-
-.SH DESCRIPTION
-Class Based Queueing is a classful qdisc that implements a rich
-linksharing hierarchy of classes. It contains shaping elements as
-well as prioritizing capabilities. Shaping is performed using link
-idle time calculations based on the timing of dequeue events and
-underlying link bandwidth.
-
-.SH SHAPING ALGORITHM
-When shaping a 10mbit/s connection to 1mbit/s, the link will
-be idle 90% of the time. If it isn't, it needs to be throttled so that it
-IS idle 90% of the time.
-
-During operations, the effective idletime is measured using an
-exponential weighted moving average (EWMA), which considers recent
-packets to be exponentially more important than past ones. The Unix
-loadaverage is calculated in the same way.
-
-The calculated idle time is subtracted from the EWMA measured one,
-the resulting number is called 'avgidle'. A perfectly loaded link has
-an avgidle of zero: packets arrive exactly at the calculated
-interval.
-
-An overloaded link has a negative avgidle and if it gets too negative,
-CBQ throttles and is then 'overlimit'.
-
-Conversely, an idle link might amass a huge avgidle, which would then
-allow infinite bandwidths after a few hours of silence. To prevent
-this, avgidle is capped at
-.B maxidle.
-
-If overlimit, in theory, the CBQ could throttle itself for exactly the
-amount of time that was calculated to pass between packets, and then
-pass one packet, and throttle again. Due to timer resolution constraints,
-this may not be feasible, see the
-.B minburst
-parameter below.
-
-.SH CLASSIFICATION
-Within the one CBQ instance many classes may exist. Each of these classes
-contains another qdisc, by default
-.BR tc-pfifo (8).
-
-When enqueueing a packet, CBQ starts at the root and uses various methods to
-determine which class should receive the data.
-
-In the absence of uncommon configuration options, the process is rather easy.
-At each node we look for an instruction, and then go to the class the
-instruction refers us to. If the class found is a barren leaf-node (without
-children), we enqueue the packet there. If it is not yet a leaf node, we do
-the whole thing over again starting from that node.
-
-The following actions are performed, in order at each node we visit, until one
-sends us to another node, or terminates the process.
-.TP
-(i)
-Consult filters attached to the class. If sent to a leafnode, we are done.
-Otherwise, restart.
-.TP
-(ii)
-Consult the defmap for the priority assigned to this packet, which depends
-on the TOS bits. Check if the referral is leafless, otherwise restart.
-.TP
-(iii)
-Ask the defmap for instructions for the 'best effort' priority. Check the
-answer for leafness, otherwise restart.
-.TP
-(iv)
-If none of the above returned with an instruction, enqueue at this node.
-.P
-This algorithm makes sure that a packet always ends up somewhere, even while
-you are busy building your configuration.
-
-For more details, see
-.BR tc-cbq-details(8).
-
-.SH LINK SHARING ALGORITHM
-When dequeuing for sending to the network device, CBQ decides which of its
-classes will be allowed to send. It does so with a Weighted Round Robin process
-in which each class with packets gets a chance to send in turn. The WRR process
-starts by asking the highest priority classes (lowest numerically -
-highest semantically) for packets, and will continue to do so until they
-have no more data to offer, in which case the process repeats for lower
-priorities.
-
-Classes by default borrow bandwidth from their siblings. A class can be
-prevented from doing so by declaring it 'bounded'. A class can also indicate
-its unwillingness to lend out bandwidth by being 'isolated'.
-
-.SH QDISC
-The root of a CBQ qdisc class tree has the following parameters:
-
-.TP
-parent major:minor | root
-This mandatory parameter determines the place of the CBQ instance, either at the
-.B root
-of an interface or within an existing class.
-.TP
-handle major:
-Like all other qdiscs, the CBQ can be assigned a handle. Should consist only
-of a major number, followed by a colon. Optional, but very useful if classes
-will be generated within this qdisc.
-.TP
-allot bytes
-This allotment is the 'chunkiness' of link sharing and is used for determining packet
-transmission time tables. The qdisc allot differs slightly from the class allot discussed
-below. Optional. Defaults to a reasonable value, related to avpkt.
-.TP
-avpkt bytes
-The average size of a packet is needed for calculating maxidle, and is also used
-for making sure 'allot' has a safe value. Mandatory.
-.TP
-bandwidth rate
-To determine the idle time, CBQ must know the bandwidth of your underlying
-physical interface, or parent qdisc. This is a vital parameter, more about it
-later. Mandatory.
-.TP
-cell
-The cell size determines he granularity of packet transmission time calculations. Has a sensible default.
-.TP
-mpu
-A zero sized packet may still take time to transmit. This value is the lower
-cap for packet transmission time calculations - packets smaller than this value
-are still deemed to have this size. Defaults to zero.
-.TP
-ewma log
-When CBQ needs to measure the average idle time, it does so using an
-Exponentially Weighted Moving Average which smooths out measurements into
-a moving average. The EWMA LOG determines how much smoothing occurs. Lower
-values imply greater sensitivity. Must be between 0 and 31. Defaults
-to 5.
-.P
-A CBQ qdisc does not shape out of its own accord. It only needs to know certain
-parameters about the underlying link. Actual shaping is done in classes.
-
-.SH CLASSES
-Classes have a host of parameters to configure their operation.
-
-.TP
-parent major:minor
-Place of this class within the hierarchy. If attached directly to a qdisc
-and not to another class, minor can be omitted. Mandatory.
-.TP
-classid major:minor
-Like qdiscs, classes can be named. The major number must be equal to the
-major number of the qdisc to which it belongs. Optional, but needed if this
-class is going to have children.
-.TP
-weight weight
-When dequeuing to the interface, classes are tried for traffic in a
-round-robin fashion. Classes with a higher configured qdisc will generally
-have more traffic to offer during each round, so it makes sense to allow
-it to dequeue more traffic. All weights under a class are normalized, so
-only the ratios matter. Defaults to the configured rate, unless the priority
-of this class is maximal, in which case it is set to 1.
-.TP
-allot bytes
-Allot specifies how many bytes a qdisc can dequeue
-during each round of the process. This parameter is weighted using the
-renormalized class weight described above. Silently capped at a minimum of
-3/2 avpkt. Mandatory.
-
-.TP
-prio priority
-In the round-robin process, classes with the lowest priority field are tried
-for packets first. Mandatory.
-
-.TP
-avpkt
-See the QDISC section.
-
-.TP
-rate rate
-Maximum rate this class and all its children combined can send at. Mandatory.
-
-.TP
-bandwidth rate
-This is different from the bandwidth specified when creating a CBQ disc! Only
-used to determine maxidle and offtime, which are only calculated when
-specifying maxburst or minburst. Mandatory if specifying maxburst or minburst.
-
-.TP
-maxburst
-This number of packets is used to calculate maxidle so that when
-avgidle is at maxidle, this number of average packets can be burst
-before avgidle drops to 0. Set it higher to be more tolerant of
-bursts. You can't set maxidle directly, only via this parameter.
-
-.TP
-minburst
-As mentioned before, CBQ needs to throttle in case of
-overlimit. The ideal solution is to do so for exactly the calculated
-idle time, and pass 1 packet. However, Unix kernels generally have a
-hard time scheduling events shorter than 10ms, so it is better to
-throttle for a longer period, and then pass minburst packets in one
-go, and then sleep minburst times longer.
-
-The time to wait is called the offtime. Higher values of minburst lead
-to more accurate shaping in the long term, but to bigger bursts at
-millisecond timescales. Optional.
-
-.TP
-minidle
-If avgidle is below 0, we are overlimits and need to wait until
-avgidle will be big enough to send one packet. To prevent a sudden
-burst from shutting down the link for a prolonged period of time,
-avgidle is reset to minidle if it gets too low.
-
-Minidle is specified in negative microseconds, so 10 means that
-avgidle is capped at -10us. Optional.
-
-.TP
-bounded
-Signifies that this class will not borrow bandwidth from its siblings.
-.TP
-isolated
-Means that this class will not borrow bandwidth to its siblings
-
-.TP
-split major:minor & defmap bitmap[/bitmap]
-If consulting filters attached to a class did not give a verdict,
-CBQ can also classify based on the packet's priority. There are 16
-priorities available, numbered from 0 to 15.
-
-The defmap specifies which priorities this class wants to receive,
-specified as a bitmap. The Least Significant Bit corresponds to priority
-zero. The
-.B split
-parameter tells CBQ at which class the decision must be made, which should
-be a (grand)parent of the class you are adding.
-
-As an example, 'tc class add ... classid 10:1 cbq .. split 10:0 defmap c0'
-configures class 10:0 to send packets with priorities 6 and 7 to 10:1.
-
-The complimentary configuration would then
-be: 'tc class add ... classid 10:2 cbq ... split 10:0 defmap 3f'
-Which would send all packets 0, 1, 2, 3, 4 and 5 to 10:1.
-.TP
-estimator interval timeconstant
-CBQ can measure how much bandwidth each class is using, which tc filters
-can use to classify packets with. In order to determine the bandwidth
-it uses a very simple estimator that measures once every
-.B interval
-microseconds how much traffic has passed. This again is a EWMA, for which
-the time constant can be specified, also in microseconds. The
-.B time constant
-corresponds to the sluggishness of the measurement or, conversely, to the
-sensitivity of the average to short bursts. Higher values mean less
-sensitivity.
-
-.SH BUGS
-The actual bandwidth of the underlying link may not be known, for example
-in the case of PPoE or PPTP connections which in fact may send over a
-pipe, instead of over a physical device. CBQ is quite resilient to major
-errors in the configured bandwidth, probably a the cost of coarser shaping.
-
-Default kernels rely on coarse timing information for making decisions. These
-may make shaping precise in the long term, but inaccurate on second long scales.
-
-See
-.BR tc-cbq-details(8)
-for hints on how to improve this.
-
-.SH SOURCES
-.TP
-o
-Sally Floyd and Van Jacobson, "Link-sharing and Resource
-Management Models for Packet Networks",
-IEEE/ACM Transactions on Networking, Vol.3, No.4, 1995
-
-.TP
-o
-Sally Floyd, "Notes on CBQ and Guaranteed Service", 1995
-
-.TP
-o
-Sally Floyd, "Notes on Class-Based Queueing: Setting
-Parameters", 1996
-
-.TP
-o
-Sally Floyd and Michael Speer, "Experimental Results
-for Class-Based Queueing", 1998, not published.
-
-
-
-.SH SEE ALSO
-.BR tc (8)
-
-.SH AUTHOR
-Alexey N. Kuznetsov, <kuznet@ms2.inr.ac.ru>. This manpage maintained by
-bert hubert <ahu@ds9a.nl>
diff --git a/man/man8/tc-tcindex.8 b/man/man8/tc-tcindex.8
deleted file mode 100644
index ccf2c5e8..00000000
--- a/man/man8/tc-tcindex.8
+++ /dev/null
@@ -1,58 +0,0 @@
-.TH "Traffic control index filter" 8 "21 Oct 2015" "iproute2" "Linux"
-
-.SH NAME
-tcindex \- traffic control index filter
-.SH SYNOPSIS
-.in +8
-.ti -8
-.BR tc " " filter " ... " tcindex " [ " hash
-.IR SIZE " ] [ "
-.B mask
-.IR MASK " ] [ "
-.B shift
-.IR SHIFT " ] [ "
-.BR pass_on " | " fall_through " ] [ " classid
-.IR CLASSID " ] [ "
-.B action
-.BR ACTION_SPEC " ]"
-.SH DESCRIPTION
-This filter allows one to match packets based on their
-.B tcindex
-field value, i.e. the combination of the DSCP and ECN fields as present in IPv4
-and IPv6 headers.
-.SH OPTIONS
-.TP
-.BI action " ACTION_SPEC"
-Apply an action from the generic actions framework on matching packets.
-.TP
-.BI classid " CLASSID"
-Push matching packets into the class identified by
-.IR CLASSID .
-.TP
-.BI hash " SIZE"
-Hash table size in entries to use. Defaults to 64.
-.TP
-.BI mask " MASK"
-An optional bitmask to binary
-.BR AND " to the packet's " tcindex
-field before use.
-.TP
-.BI shift " SHIFT"
-The number of bits to right-shift a packet's
-.B tcindex
-value before use. If a
-.B mask
-has been set, masking is done before shifting.
-.TP
-.B pass_on
-If this flag is set, failure to find a class for the resulting ID will make the
-filter fail and lead to the next filter being consulted.
-.TP
-.B fall_through
-This is the opposite of
-.B pass_on
-and the default. The filter will classify the packet even if there is no class
-present for the resulting class ID.
-
-.SH SEE ALSO
-.BR tc (8)
diff --git a/man/man8/tc.8 b/man/man8/tc.8
index d436d464..ae6de397 100644
--- a/man/man8/tc.8
+++ b/man/man8/tc.8
@@ -241,13 +241,6 @@ Filter packets based on routing table. See
 .BR tc-route (8)
 for details.
 .TP
-rsvp
-Match Resource Reservation Protocol (RSVP) packets.
-.TP
-tcindex
-Filter packets based on traffic control index. See
-.BR tc-tcindex (8).
-.TP
 u32
 Generic filtering on arbitrary packet data, assisted by syntax to abstract common operations. See
 .BR tc-u32 (8)
@@ -402,12 +395,6 @@ ATM
 Map flows to virtual circuits of an underlying asynchronous transfer mode
 device.
 .TP
-CBQ
-Class Based Queueing implements a rich linksharing hierarchy of classes.
-It contains shaping elements as well as prioritizing capabilities. Shaping is
-performed using link idle time calculations based on average packet size and
-underlying link bandwidth. The latter may be ill-defined for some interfaces.
-.TP
 DRR
 The Deficit Round Robin Scheduler is a more flexible replacement for Stochastic
 Fairness Queuing. Unlike SFQ, there are no built-in queues \-\- you need to add
@@ -452,7 +439,7 @@ well to a hardware implementation.
 .SH THEORY OF OPERATION
 Classes form a tree, where each class has a single parent.
 A class may have multiple children. Some qdiscs allow for runtime addition
-of classes (CBQ, HTB) while others (PRIO) are created with a static number of
+of classes (HTB) while others (PRIO) are created with a static number of
 children.
 
 Qdiscs which allow dynamic addition of classes can have zero or more
@@ -876,7 +863,6 @@ was written by Alexey N. Kuznetsov and added in Linux 2.2.
 .BR tc-bfifo (8),
 .BR tc-bpf (8),
 .BR tc-cake (8),
-.BR tc-cbq (8),
 .BR tc-cgroup (8),
 .BR tc-choke (8),
 .BR tc-codel (8),
@@ -902,8 +888,7 @@ was written by Alexey N. Kuznetsov and added in Linux 2.2.
 .BR tc-sfq (8),
 .BR tc-stab (8),
 .BR tc-tbf (8),
-.BR tc-tcindex (8),
-.BR tc-u32 (8),
+.BR tc-u32 (8)
 .br
 .RB "User documentation at " http://lartc.org/ ", but please direct bugreports and patches to: " <netdev@vger.kernel.org>
 
diff --git a/tc/Makefile b/tc/Makefile
index 98d2ee59..ab6ad2f5 100644
--- a/tc/Makefile
+++ b/tc/Makefile
@@ -14,12 +14,10 @@ TCMODULES += q_red.o
 TCMODULES += q_prio.o
 TCMODULES += q_skbprio.o
 TCMODULES += q_tbf.o
-TCMODULES += q_cbq.o
 TCMODULES += q_multiq.o
 TCMODULES += q_netem.o
 TCMODULES += q_choke.o
 TCMODULES += q_sfb.o
-TCMODULES += f_rsvp.o
 TCMODULES += f_u32.o
 TCMODULES += f_route.o
 TCMODULES += f_fw.o
@@ -30,7 +28,6 @@ TCMODULES += f_cgroup.o
 TCMODULES += f_flower.o
 TCMODULES += q_dsmark.o
 TCMODULES += q_gred.o
-TCMODULES += f_tcindex.o
 TCMODULES += q_ingress.o
 TCMODULES += q_hfsc.o
 TCMODULES += q_htb.o
@@ -118,7 +115,6 @@ endif
 
 TCLIB := tc_core.o
 TCLIB += tc_red.o
-TCLIB += tc_cbq.o
 TCLIB += tc_estimator.o
 TCLIB += tc_stab.o
 TCLIB += tc_qevent.o
diff --git a/tc/f_rsvp.c b/tc/f_rsvp.c
deleted file mode 100644
index 84187d62..00000000
--- a/tc/f_rsvp.c
+++ /dev/null
@@ -1,417 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * q_rsvp.c		RSVP filter.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-#include <string.h>
-
-#include "rt_names.h"
-#include "utils.h"
-#include "tc_util.h"
-
-static void explain(void)
-{
-	fprintf(stderr,
-		"Usage:	... rsvp ipproto PROTOCOL session DST[/PORT | GPI ]\n"
-		"		[ sender SRC[/PORT | GPI ] ]\n"
-		"		[ classid CLASSID ] [ action ACTION_SPEC ]\n"
-		"		[ tunnelid ID ] [ tunnel ID skip NUMBER ]\n"
-		"Where:	GPI := { flowlabel NUMBER | spi/ah SPI | spi/esp SPI |\n"
-		"		u{8|16|32} NUMBER mask MASK at OFFSET}\n"
-		"	ACTION_SPEC := ... look at individual actions\n"
-		"	FILTERID := X:Y\n"
-		"\nNOTE: CLASSID is parsed as hexadecimal input.\n");
-}
-
-static int get_addr_and_pi(int *argc_p, char ***argv_p, inet_prefix *addr,
-		    struct tc_rsvp_pinfo *pinfo, int dir, int family)
-{
-	int argc = *argc_p;
-	char **argv = *argv_p;
-	char *p = strchr(*argv, '/');
-	struct tc_rsvp_gpi *pi = dir ? &pinfo->dpi : &pinfo->spi;
-
-	if (p) {
-		__u16 tmp;
-
-		if (get_u16(&tmp, p+1, 0))
-			return -1;
-
-		if (dir == 0) {
-			/* Source port: u16 at offset 0 */
-			pi->key = htonl(((__u32)tmp)<<16);
-			pi->mask = htonl(0xFFFF0000);
-		} else {
-			/* Destination port: u16 at offset 2 */
-			pi->key = htonl(((__u32)tmp));
-			pi->mask = htonl(0x0000FFFF);
-		}
-		pi->offset = 0;
-		*p = 0;
-	}
-	if (get_addr_1(addr, *argv, family))
-		return -1;
-	if (p)
-		*p = '/';
-
-	argc--; argv++;
-
-	if (pi->mask || argc <= 0)
-		goto done;
-
-	if (strcmp(*argv, "spi/ah") == 0 ||
-	    strcmp(*argv, "gpi/ah") == 0) {
-		__u32 gpi;
-
-		NEXT_ARG();
-		if (get_u32(&gpi, *argv, 0))
-			return -1;
-		pi->mask = htonl(0xFFFFFFFF);
-		pi->key = htonl(gpi);
-		pi->offset = 4;
-		if (pinfo->protocol == 0)
-			pinfo->protocol = IPPROTO_AH;
-		argc--; argv++;
-	} else if (strcmp(*argv, "spi/esp") == 0 ||
-		   strcmp(*argv, "gpi/esp") == 0) {
-		__u32 gpi;
-
-		NEXT_ARG();
-		if (get_u32(&gpi, *argv, 0))
-			return -1;
-		pi->mask = htonl(0xFFFFFFFF);
-		pi->key = htonl(gpi);
-		pi->offset = 0;
-		if (pinfo->protocol == 0)
-			pinfo->protocol = IPPROTO_ESP;
-		argc--; argv++;
-	} else if (strcmp(*argv, "flowlabel") == 0) {
-		__u32 flabel;
-
-		NEXT_ARG();
-		if (get_u32(&flabel, *argv, 0))
-			return -1;
-		if (family != AF_INET6)
-			return -1;
-		pi->mask = htonl(0x000FFFFF);
-		pi->key = htonl(flabel) & pi->mask;
-		pi->offset = -40;
-		argc--; argv++;
-	} else if (strcmp(*argv, "u32") == 0 ||
-		   strcmp(*argv, "u16") == 0 ||
-		   strcmp(*argv, "u8") == 0) {
-		int sz = 1;
-		__u32 tmp;
-		__u32 mask = 0xff;
-
-		if (strcmp(*argv, "u32") == 0) {
-			sz = 4;
-			mask = 0xffff;
-		} else if (strcmp(*argv, "u16") == 0) {
-			mask = 0xffffffff;
-			sz = 2;
-		}
-		NEXT_ARG();
-		if (get_u32(&tmp, *argv, 0))
-			return -1;
-		argc--; argv++;
-		if (strcmp(*argv, "mask") == 0) {
-			NEXT_ARG();
-			if (get_u32(&mask, *argv, 16))
-				return -1;
-			argc--; argv++;
-		}
-		if (strcmp(*argv, "at") == 0) {
-			NEXT_ARG();
-			if (get_integer(&pi->offset, *argv, 0))
-				return -1;
-			argc--; argv++;
-		}
-		if (sz == 1) {
-			if ((pi->offset & 3) == 0) {
-				mask <<= 24;
-				tmp <<= 24;
-			} else if ((pi->offset & 3) == 1) {
-				mask <<= 16;
-				tmp <<= 16;
-			} else if ((pi->offset & 3) == 3) {
-				mask <<= 8;
-				tmp <<= 8;
-			}
-		} else if (sz == 2) {
-			if ((pi->offset & 3) == 0) {
-				mask <<= 16;
-				tmp <<= 16;
-			}
-		}
-		pi->offset &= ~3;
-		pi->mask = htonl(mask);
-		pi->key = htonl(tmp) & pi->mask;
-	}
-
-done:
-	*argc_p = argc;
-	*argv_p = argv;
-	return 0;
-}
-
-
-static int rsvp_parse_opt(struct filter_util *qu, char *handle, int argc,
-			  char **argv, struct nlmsghdr *n)
-{
-	int family = strcmp(qu->id, "rsvp") == 0 ? AF_INET : AF_INET6;
-	struct tc_rsvp_pinfo pinfo = {};
-	struct tcmsg *t = NLMSG_DATA(n);
-	int pinfo_ok = 0;
-	struct rtattr *tail;
-
-	if (handle) {
-		if (get_u32(&t->tcm_handle, handle, 0)) {
-			fprintf(stderr, "Illegal \"handle\"\n");
-			return -1;
-		}
-	}
-
-	if (argc == 0)
-		return 0;
-
-	tail = addattr_nest(n, 4096, TCA_OPTIONS);
-
-	while (argc > 0) {
-		if (matches(*argv, "session") == 0) {
-			inet_prefix addr;
-
-			NEXT_ARG();
-			if (get_addr_and_pi(&argc, &argv, &addr, &pinfo, 1, family)) {
-				fprintf(stderr, "Illegal \"session\"\n");
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_RSVP_DST, &addr.data, addr.bytelen);
-			if (pinfo.dpi.mask || pinfo.protocol)
-				pinfo_ok++;
-			continue;
-		} else if (matches(*argv, "sender") == 0 ||
-			   matches(*argv, "flowspec") == 0) {
-			inet_prefix addr;
-
-			NEXT_ARG();
-			if (get_addr_and_pi(&argc, &argv, &addr, &pinfo, 0, family)) {
-				fprintf(stderr, "Illegal \"sender\"\n");
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_RSVP_SRC, &addr.data, addr.bytelen);
-			if (pinfo.spi.mask || pinfo.protocol)
-				pinfo_ok++;
-			continue;
-		} else if (matches("ipproto", *argv) == 0) {
-			int num;
-
-			NEXT_ARG();
-			num = inet_proto_a2n(*argv);
-			if (num < 0) {
-				fprintf(stderr, "Illegal \"ipproto\"\n");
-				return -1;
-			}
-			pinfo.protocol = num;
-			pinfo_ok++;
-		} else if (matches(*argv, "classid") == 0 ||
-			   strcmp(*argv, "flowid") == 0) {
-			unsigned int classid;
-
-			NEXT_ARG();
-			if (get_tc_classid(&classid, *argv)) {
-				fprintf(stderr, "Illegal \"classid\"\n");
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_RSVP_CLASSID, &classid, 4);
-		} else if (strcmp(*argv, "tunnelid") == 0) {
-			unsigned int tid;
-
-			NEXT_ARG();
-			if (get_unsigned(&tid, *argv, 0)) {
-				fprintf(stderr, "Illegal \"tunnelid\"\n");
-				return -1;
-			}
-			pinfo.tunnelid = tid;
-			pinfo_ok++;
-		} else if (strcmp(*argv, "tunnel") == 0) {
-			unsigned int tid;
-
-			NEXT_ARG();
-			if (get_unsigned(&tid, *argv, 0)) {
-				fprintf(stderr, "Illegal \"tunnel\"\n");
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_RSVP_CLASSID, &tid, 4);
-			NEXT_ARG();
-			if (strcmp(*argv, "skip") == 0) {
-				NEXT_ARG();
-			}
-			if (get_unsigned(&tid, *argv, 0)) {
-				fprintf(stderr, "Illegal \"skip\"\n");
-				return -1;
-			}
-			pinfo.tunnelhdr = tid;
-			pinfo_ok++;
-		} else if (matches(*argv, "action") == 0) {
-			NEXT_ARG();
-			if (parse_action(&argc, &argv, TCA_RSVP_ACT, n)) {
-				fprintf(stderr, "Illegal \"action\"\n");
-				return -1;
-			}
-			continue;
-		} else if (matches(*argv, "police") == 0) {
-			NEXT_ARG();
-			if (parse_police(&argc, &argv, TCA_RSVP_POLICE, n)) {
-				fprintf(stderr, "Illegal \"police\"\n");
-				return -1;
-			}
-			continue;
-		} else if (strcmp(*argv, "help") == 0) {
-			explain();
-			return -1;
-		} else {
-			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
-			return -1;
-		}
-		argc--; argv++;
-	}
-
-	if (pinfo_ok)
-		addattr_l(n, 4096, TCA_RSVP_PINFO, &pinfo, sizeof(pinfo));
-	addattr_nest_end(n, tail);
-	return 0;
-}
-
-static char *sprint_spi(struct tc_rsvp_gpi *pi, int dir, char *buf)
-{
-	if (pi->offset == 0) {
-		if (dir && pi->mask == htonl(0xFFFF)) {
-			snprintf(buf, SPRINT_BSIZE-1, "/%d", htonl(pi->key));
-			return buf;
-		}
-		if (!dir && pi->mask == htonl(0xFFFF0000)) {
-			snprintf(buf, SPRINT_BSIZE-1, "/%d", htonl(pi->key)>>16);
-			return buf;
-		}
-		if (pi->mask == htonl(0xFFFFFFFF)) {
-			snprintf(buf, SPRINT_BSIZE-1, " spi/esp 0x%08x", htonl(pi->key));
-			return buf;
-		}
-	} else if (pi->offset == 4 && pi->mask == htonl(0xFFFFFFFF)) {
-		snprintf(buf, SPRINT_BSIZE-1, " spi/ah 0x%08x", htonl(pi->key));
-		return buf;
-	} else if (pi->offset == -40 && pi->mask == htonl(0x000FFFFF)) {
-		snprintf(buf, SPRINT_BSIZE-1, " flowlabel 0x%05x", htonl(pi->key));
-		return buf;
-	}
-	snprintf(buf, SPRINT_BSIZE-1, " u32 0x%08x mask %08x at %d",
-		 htonl(pi->key), htonl(pi->mask), pi->offset);
-	return buf;
-}
-
-static int rsvp_print_opt(struct filter_util *qu, FILE *f, struct rtattr *opt, __u32 handle)
-{
-	int family = strcmp(qu->id, "rsvp") == 0 ? AF_INET : AF_INET6;
-	struct rtattr *tb[TCA_RSVP_MAX+1];
-	struct tc_rsvp_pinfo *pinfo = NULL;
-
-	if (opt == NULL)
-		return 0;
-
-	parse_rtattr_nested(tb, TCA_RSVP_MAX, opt);
-
-	if (handle)
-		fprintf(f, "fh 0x%08x ", handle);
-
-	if (tb[TCA_RSVP_PINFO]) {
-		if (RTA_PAYLOAD(tb[TCA_RSVP_PINFO])  < sizeof(*pinfo))
-			return -1;
-
-		pinfo = RTA_DATA(tb[TCA_RSVP_PINFO]);
-	}
-
-	if (tb[TCA_RSVP_CLASSID]) {
-		SPRINT_BUF(b1);
-		if (!pinfo || pinfo->tunnelhdr == 0)
-			fprintf(f, "flowid %s ", sprint_tc_classid(rta_getattr_u32(tb[TCA_RSVP_CLASSID]), b1));
-		else
-			fprintf(f, "tunnel %d skip %d ", rta_getattr_u32(tb[TCA_RSVP_CLASSID]), pinfo->tunnelhdr);
-	} else if (pinfo && pinfo->tunnelhdr)
-		fprintf(f, "tunnel [BAD] skip %d ", pinfo->tunnelhdr);
-
-	if (tb[TCA_RSVP_DST]) {
-		char buf[128];
-
-		fprintf(f, "session ");
-		if (inet_ntop(family, RTA_DATA(tb[TCA_RSVP_DST]), buf, sizeof(buf)) == 0)
-			fprintf(f, " [INVALID DADDR] ");
-		else
-			fprintf(f, "%s", buf);
-		if (pinfo && pinfo->dpi.mask) {
-			SPRINT_BUF(b2);
-			fprintf(f, "%s ", sprint_spi(&pinfo->dpi, 1, b2));
-		} else
-			fprintf(f, " ");
-	} else {
-		if (pinfo && pinfo->dpi.mask) {
-			SPRINT_BUF(b2);
-			fprintf(f, "session [NONE]%s ", sprint_spi(&pinfo->dpi, 1, b2));
-		} else
-			fprintf(f, "session NONE ");
-	}
-
-	if (pinfo && pinfo->protocol) {
-		SPRINT_BUF(b1);
-		fprintf(f, "ipproto %s ", inet_proto_n2a(pinfo->protocol, b1, sizeof(b1)));
-	}
-	if (pinfo && pinfo->tunnelid)
-		fprintf(f, "tunnelid %d ", pinfo->tunnelid);
-	if (tb[TCA_RSVP_SRC]) {
-		char buf[128];
-
-		fprintf(f, "sender ");
-		if (inet_ntop(family, RTA_DATA(tb[TCA_RSVP_SRC]), buf, sizeof(buf)) == 0) {
-			fprintf(f, "[BAD]");
-		} else {
-			fprintf(f, " %s", buf);
-		}
-		if (pinfo && pinfo->spi.mask) {
-			SPRINT_BUF(b2);
-			fprintf(f, "%s ", sprint_spi(&pinfo->spi, 0, b2));
-		} else
-			fprintf(f, " ");
-	} else if (pinfo && pinfo->spi.mask) {
-		SPRINT_BUF(b2);
-		fprintf(f, "sender [NONE]%s ", sprint_spi(&pinfo->spi, 0, b2));
-	}
-
-	if (tb[TCA_RSVP_ACT]) {
-		tc_print_action(f, tb[TCA_RSVP_ACT], 0);
-	}
-	if (tb[TCA_RSVP_POLICE])
-		tc_print_police(f, tb[TCA_RSVP_POLICE]);
-	return 0;
-}
-
-struct filter_util rsvp_filter_util = {
-	.id = "rsvp",
-	.parse_fopt = rsvp_parse_opt,
-	.print_fopt = rsvp_print_opt,
-};
-
-struct filter_util rsvp6_filter_util = {
-	.id = "rsvp6",
-	.parse_fopt = rsvp_parse_opt,
-	.print_fopt = rsvp_print_opt,
-};
diff --git a/tc/f_tcindex.c b/tc/f_tcindex.c
deleted file mode 100644
index ae4cbf11..00000000
--- a/tc/f_tcindex.c
+++ /dev/null
@@ -1,185 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * f_tcindex.c		Traffic control index filter
- *
- * Written 1998,1999 by Werner Almesberger
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <string.h>
-#include <netinet/in.h>
-
-#include "utils.h"
-#include "tc_util.h"
-
-static void explain(void)
-{
-	fprintf(stderr,
-		" Usage: ... tcindex	[ hash SIZE ] [ mask MASK ] [ shift SHIFT ]\n"
-		"			[ pass_on | fall_through ]\n"
-		"			[ classid CLASSID ] [ action ACTION_SPEC ]\n");
-}
-
-static int tcindex_parse_opt(struct filter_util *qu, char *handle, int argc,
-			     char **argv, struct nlmsghdr *n)
-{
-	struct tcmsg *t = NLMSG_DATA(n);
-	struct rtattr *tail;
-	char *end;
-
-	if (handle) {
-		t->tcm_handle = strtoul(handle, &end, 0);
-		if (*end) {
-			fprintf(stderr, "Illegal filter ID\n");
-			return -1;
-		}
-	}
-	if (!argc) return 0;
-	tail = addattr_nest(n, 4096, TCA_OPTIONS);
-	while (argc) {
-		if (!strcmp(*argv, "hash")) {
-			int hash;
-
-			NEXT_ARG();
-			hash = strtoul(*argv, &end, 0);
-			if (*end || !hash || hash > 0x10000) {
-				explain();
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_TCINDEX_HASH, &hash,
-				  sizeof(hash));
-		} else if (!strcmp(*argv,"mask")) {
-			__u16 mask;
-
-			NEXT_ARG();
-			mask = strtoul(*argv, &end, 0);
-			if (*end) {
-				explain();
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_TCINDEX_MASK, &mask,
-				  sizeof(mask));
-		} else if (!strcmp(*argv,"shift")) {
-			int shift;
-
-			NEXT_ARG();
-			shift = strtoul(*argv, &end, 0);
-			if (*end) {
-				explain();
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_TCINDEX_SHIFT, &shift,
-			    sizeof(shift));
-		} else if (!strcmp(*argv,"fall_through")) {
-			int value = 1;
-
-			addattr_l(n, 4096, TCA_TCINDEX_FALL_THROUGH, &value,
-			    sizeof(value));
-		} else if (!strcmp(*argv,"pass_on")) {
-			int value = 0;
-
-			addattr_l(n, 4096, TCA_TCINDEX_FALL_THROUGH, &value,
-			    sizeof(value));
-		} else if (!strcmp(*argv,"classid")) {
-			__u32 handle;
-
-			NEXT_ARG();
-			if (get_tc_classid(&handle, *argv)) {
-				fprintf(stderr, "Illegal \"classid\"\n");
-				return -1;
-			}
-			addattr_l(n, 4096, TCA_TCINDEX_CLASSID, &handle, 4);
-		} else if (!strcmp(*argv,"police")) {
-			NEXT_ARG();
-			if (parse_police(&argc, &argv, TCA_TCINDEX_POLICE, n)) {
-				fprintf(stderr, "Illegal \"police\"\n");
-				return -1;
-			}
-			continue;
-		} else if (!strcmp(*argv,"action")) {
-			NEXT_ARG();
-			if (parse_action(&argc, &argv, TCA_TCINDEX_ACT, n)) {
-				fprintf(stderr, "Illegal \"action\"\n");
-				return -1;
-			}
-			continue;
-		} else {
-			explain();
-			return -1;
-		}
-		argc--;
-		argv++;
-	}
-	addattr_nest_end(n, tail);
-	return 0;
-}
-
-
-static int tcindex_print_opt(struct filter_util *qu, FILE *f,
-			     struct rtattr *opt, __u32 handle)
-{
-	struct rtattr *tb[TCA_TCINDEX_MAX+1];
-
-	if (opt == NULL)
-		return 0;
-
-	parse_rtattr_nested(tb, TCA_TCINDEX_MAX, opt);
-
-	if (handle != ~0) fprintf(f, "handle 0x%04x ", handle);
-	if (tb[TCA_TCINDEX_HASH]) {
-		__u16 hash;
-
-		if (RTA_PAYLOAD(tb[TCA_TCINDEX_HASH]) < sizeof(hash))
-			return -1;
-		hash = rta_getattr_u16(tb[TCA_TCINDEX_HASH]);
-		fprintf(f, "hash %d ", hash);
-	}
-	if (tb[TCA_TCINDEX_MASK]) {
-		__u16 mask;
-
-		if (RTA_PAYLOAD(tb[TCA_TCINDEX_MASK]) < sizeof(mask))
-			return -1;
-		mask = rta_getattr_u16(tb[TCA_TCINDEX_MASK]);
-		fprintf(f, "mask 0x%04x ", mask);
-	}
-	if (tb[TCA_TCINDEX_SHIFT]) {
-		int shift;
-
-		if (RTA_PAYLOAD(tb[TCA_TCINDEX_SHIFT]) < sizeof(shift))
-			return -1;
-		shift = rta_getattr_u32(tb[TCA_TCINDEX_SHIFT]);
-		fprintf(f, "shift %d ", shift);
-	}
-	if (tb[TCA_TCINDEX_FALL_THROUGH]) {
-		int fall_through;
-
-		if (RTA_PAYLOAD(tb[TCA_TCINDEX_FALL_THROUGH]) <
-		    sizeof(fall_through))
-			return -1;
-		fall_through = rta_getattr_u32(tb[TCA_TCINDEX_FALL_THROUGH]);
-		fprintf(f, fall_through ? "fall_through " : "pass_on ");
-	}
-	if (tb[TCA_TCINDEX_CLASSID]) {
-		SPRINT_BUF(b1);
-		fprintf(f, "classid %s ", sprint_tc_classid(*(__u32 *)
-		    RTA_DATA(tb[TCA_TCINDEX_CLASSID]), b1));
-	}
-	if (tb[TCA_TCINDEX_POLICE]) {
-		fprintf(f, "\n");
-		tc_print_police(f, tb[TCA_TCINDEX_POLICE]);
-	}
-	if (tb[TCA_TCINDEX_ACT]) {
-		fprintf(f, "\n");
-		tc_print_action(f, tb[TCA_TCINDEX_ACT], 0);
-	}
-	return 0;
-}
-
-struct filter_util tcindex_filter_util = {
-	.id = "tcindex",
-	.parse_fopt = tcindex_parse_opt,
-	.print_fopt = tcindex_print_opt,
-};
diff --git a/tc/q_cbq.c b/tc/q_cbq.c
deleted file mode 100644
index 58afdca7..00000000
--- a/tc/q_cbq.c
+++ /dev/null
@@ -1,589 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * q_cbq.c		CBQ.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-#include <string.h>
-
-#include "utils.h"
-#include "tc_util.h"
-#include "tc_cbq.h"
-
-static void explain_class(void)
-{
-	fprintf(stderr,
-		"Usage: ... cbq	bandwidth BPS rate BPS maxburst PKTS [ avpkt BYTES ]\n"
-		"		[ minburst PKTS ] [ bounded ] [ isolated ]\n"
-		"		[ allot BYTES ] [ mpu BYTES ] [ weight RATE ]\n"
-		"		[ prio NUMBER ] [ cell BYTES ] [ ewma LOG ]\n"
-		"		[ estimator INTERVAL TIME_CONSTANT ]\n"
-		"		[ split CLASSID ] [ defmap MASK/CHANGE ]\n"
-		"		[ overhead BYTES ] [ linklayer TYPE ]\n");
-}
-
-static void explain(void)
-{
-	fprintf(stderr,
-		"Usage: ... cbq bandwidth BPS avpkt BYTES [ mpu BYTES ]\n"
-		"               [ cell BYTES ] [ ewma LOG ]\n");
-}
-
-static void explain1(char *arg)
-{
-	fprintf(stderr, "Illegal \"%s\"\n", arg);
-}
-
-
-static int cbq_parse_opt(struct qdisc_util *qu, int argc, char **argv, struct nlmsghdr *n, const char *dev)
-{
-	struct tc_ratespec r = {};
-	struct tc_cbq_lssopt lss = {};
-	__u32 rtab[256];
-	unsigned mpu = 0, avpkt = 0, allot = 0;
-	unsigned short overhead = 0;
-	unsigned int linklayer = LINKLAYER_ETHERNET; /* Assume ethernet */
-	int cell_log =  -1;
-	int ewma_log =  -1;
-	struct rtattr *tail;
-
-	while (argc > 0) {
-		if (matches(*argv, "bandwidth") == 0 ||
-		    matches(*argv, "rate") == 0) {
-			NEXT_ARG();
-			if (strchr(*argv, '%')) {
-				if (get_percent_rate(&r.rate, *argv, dev)) {
-					explain1("bandwidth");
-					return -1;
-				}
-			} else if (get_rate(&r.rate, *argv)) {
-				explain1("bandwidth");
-				return -1;
-			}
-		} else if (matches(*argv, "ewma") == 0) {
-			NEXT_ARG();
-			if (get_integer(&ewma_log, *argv, 0)) {
-				explain1("ewma");
-				return -1;
-			}
-			if (ewma_log > 31) {
-				fprintf(stderr, "ewma_log must be < 32\n");
-				return -1;
-			}
-		} else if (matches(*argv, "cell") == 0) {
-			unsigned int cell;
-			int i;
-
-			NEXT_ARG();
-			if (get_size(&cell, *argv)) {
-				explain1("cell");
-				return -1;
-			}
-			for (i = 0; i < 32; i++)
-				if ((1<<i) == cell)
-					break;
-			if (i >= 32) {
-				fprintf(stderr, "cell must be 2^n\n");
-				return -1;
-			}
-			cell_log = i;
-		} else if (matches(*argv, "avpkt") == 0) {
-			NEXT_ARG();
-			if (get_size(&avpkt, *argv)) {
-				explain1("avpkt");
-				return -1;
-			}
-		} else if (matches(*argv, "mpu") == 0) {
-			NEXT_ARG();
-			if (get_size(&mpu, *argv)) {
-				explain1("mpu");
-				return -1;
-			}
-		} else if (matches(*argv, "allot") == 0) {
-			NEXT_ARG();
-			/* Accept and ignore "allot" for backward compatibility */
-			if (get_size(&allot, *argv)) {
-				explain1("allot");
-				return -1;
-			}
-		} else if (matches(*argv, "overhead") == 0) {
-			NEXT_ARG();
-			if (get_u16(&overhead, *argv, 10)) {
-				explain1("overhead"); return -1;
-			}
-		} else if (matches(*argv, "linklayer") == 0) {
-			NEXT_ARG();
-			if (get_linklayer(&linklayer, *argv)) {
-				explain1("linklayer"); return -1;
-			}
-		} else if (matches(*argv, "help") == 0) {
-			explain();
-			return -1;
-		} else {
-			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain();
-			return -1;
-		}
-		argc--; argv++;
-	}
-
-	/* OK. All options are parsed. */
-
-	if (r.rate == 0) {
-		fprintf(stderr, "CBQ: bandwidth is required parameter.\n");
-		return -1;
-	}
-	if (avpkt == 0) {
-		fprintf(stderr, "CBQ: \"avpkt\" is required.\n");
-		return -1;
-	}
-	if (allot < (avpkt*3)/2)
-		allot = (avpkt*3)/2;
-
-	r.mpu = mpu;
-	r.overhead = overhead;
-	if (tc_calc_rtable(&r, rtab, cell_log, allot, linklayer) < 0) {
-		fprintf(stderr, "CBQ: failed to calculate rate table.\n");
-		return -1;
-	}
-
-	if (ewma_log < 0)
-		ewma_log = TC_CBQ_DEF_EWMA;
-	lss.ewma_log = ewma_log;
-	lss.maxidle = tc_calc_xmittime(r.rate, avpkt);
-	lss.change = TCF_CBQ_LSS_MAXIDLE|TCF_CBQ_LSS_EWMA|TCF_CBQ_LSS_AVPKT;
-	lss.avpkt = avpkt;
-
-	tail = addattr_nest(n, 1024, TCA_OPTIONS);
-	addattr_l(n, 1024, TCA_CBQ_RATE, &r, sizeof(r));
-	addattr_l(n, 1024, TCA_CBQ_LSSOPT, &lss, sizeof(lss));
-	addattr_l(n, 3024, TCA_CBQ_RTAB, rtab, 1024);
-	if (show_raw) {
-		int i;
-
-		for (i = 0; i < 256; i++)
-			printf("%u ", rtab[i]);
-		printf("\n");
-	}
-	addattr_nest_end(n, tail);
-	return 0;
-}
-
-static int cbq_parse_class_opt(struct qdisc_util *qu, int argc, char **argv, struct nlmsghdr *n, const char *dev)
-{
-	int wrr_ok = 0, fopt_ok = 0;
-	struct tc_ratespec r = {};
-	struct tc_cbq_lssopt lss = {};
-	struct tc_cbq_wrropt wrr = {};
-	struct tc_cbq_fopt fopt = {};
-	__u32 rtab[256];
-	unsigned mpu = 0;
-	int cell_log =  -1;
-	int ewma_log =  -1;
-	unsigned int bndw = 0;
-	unsigned minburst = 0, maxburst = 0;
-	unsigned short overhead = 0;
-	unsigned int linklayer = LINKLAYER_ETHERNET; /* Assume ethernet */
-	struct rtattr *tail;
-
-	while (argc > 0) {
-		if (matches(*argv, "rate") == 0) {
-			NEXT_ARG();
-			if (strchr(*argv, '%')) {
-				if (get_percent_rate(&r.rate, *argv, dev)) {
-					explain1("rate");
-					return -1;
-				}
-			} else if (get_rate(&r.rate, *argv)) {
-				explain1("rate");
-				return -1;
-			}
-		} else if (matches(*argv, "bandwidth") == 0) {
-			NEXT_ARG();
-			if (strchr(*argv, '%')) {
-				if (get_percent_rate(&bndw, *argv, dev)) {
-					explain1("bandwidth");
-					return -1;
-				}
-			} else if (get_rate(&bndw, *argv)) {
-				explain1("bandwidth");
-				return -1;
-			}
-		} else if (matches(*argv, "minidle") == 0) {
-			NEXT_ARG();
-			if (get_u32(&lss.minidle, *argv, 0)) {
-				explain1("minidle");
-				return -1;
-			}
-			lss.change |= TCF_CBQ_LSS_MINIDLE;
-		} else if (matches(*argv, "minburst") == 0) {
-			NEXT_ARG();
-			if (get_u32(&minburst, *argv, 0)) {
-				explain1("minburst");
-				return -1;
-			}
-			lss.change |= TCF_CBQ_LSS_OFFTIME;
-		} else if (matches(*argv, "maxburst") == 0) {
-			NEXT_ARG();
-			if (get_u32(&maxburst, *argv, 0)) {
-				explain1("maxburst");
-				return -1;
-			}
-			lss.change |= TCF_CBQ_LSS_MAXIDLE;
-		} else if (matches(*argv, "bounded") == 0) {
-			lss.flags |= TCF_CBQ_LSS_BOUNDED;
-			lss.change |= TCF_CBQ_LSS_FLAGS;
-		} else if (matches(*argv, "borrow") == 0) {
-			lss.flags &= ~TCF_CBQ_LSS_BOUNDED;
-			lss.change |= TCF_CBQ_LSS_FLAGS;
-		} else if (matches(*argv, "isolated") == 0) {
-			lss.flags |= TCF_CBQ_LSS_ISOLATED;
-			lss.change |= TCF_CBQ_LSS_FLAGS;
-		} else if (matches(*argv, "sharing") == 0) {
-			lss.flags &= ~TCF_CBQ_LSS_ISOLATED;
-			lss.change |= TCF_CBQ_LSS_FLAGS;
-		} else if (matches(*argv, "ewma") == 0) {
-			NEXT_ARG();
-			if (get_integer(&ewma_log, *argv, 0)) {
-				explain1("ewma");
-				return -1;
-			}
-			if (ewma_log > 31) {
-				fprintf(stderr, "ewma_log must be < 32\n");
-				return -1;
-			}
-			lss.change |= TCF_CBQ_LSS_EWMA;
-		} else if (matches(*argv, "cell") == 0) {
-			unsigned int cell;
-			int i;
-
-			NEXT_ARG();
-			if (get_size(&cell, *argv)) {
-				explain1("cell");
-				return -1;
-			}
-			for (i = 0; i < 32; i++)
-				if ((1<<i) == cell)
-					break;
-			if (i >= 32) {
-				fprintf(stderr, "cell must be 2^n\n");
-				return -1;
-			}
-			cell_log = i;
-		} else if (matches(*argv, "prio") == 0) {
-			unsigned int prio;
-
-			NEXT_ARG();
-			if (get_u32(&prio, *argv, 0)) {
-				explain1("prio");
-				return -1;
-			}
-			if (prio > TC_CBQ_MAXPRIO) {
-				fprintf(stderr, "\"prio\" must be number in the range 1...%d\n", TC_CBQ_MAXPRIO);
-				return -1;
-			}
-			wrr.priority = prio;
-			wrr_ok++;
-		} else if (matches(*argv, "allot") == 0) {
-			NEXT_ARG();
-			if (get_size(&wrr.allot, *argv)) {
-				explain1("allot");
-				return -1;
-			}
-		} else if (matches(*argv, "avpkt") == 0) {
-			NEXT_ARG();
-			if (get_size(&lss.avpkt, *argv)) {
-				explain1("avpkt");
-				return -1;
-			}
-			lss.change |= TCF_CBQ_LSS_AVPKT;
-		} else if (matches(*argv, "mpu") == 0) {
-			NEXT_ARG();
-			if (get_size(&mpu, *argv)) {
-				explain1("mpu");
-				return -1;
-			}
-		} else if (matches(*argv, "weight") == 0) {
-			NEXT_ARG();
-			if (get_size(&wrr.weight, *argv)) {
-				explain1("weight");
-				return -1;
-			}
-			wrr_ok++;
-		} else if (matches(*argv, "split") == 0) {
-			NEXT_ARG();
-			if (get_tc_classid(&fopt.split, *argv)) {
-				fprintf(stderr, "Invalid split node ID.\n");
-				return -1;
-			}
-			fopt_ok++;
-		} else if (matches(*argv, "defmap") == 0) {
-			int err;
-
-			NEXT_ARG();
-			err = sscanf(*argv, "%08x/%08x", &fopt.defmap, &fopt.defchange);
-			if (err < 1) {
-				fprintf(stderr, "Invalid defmap, should be MASK32[/MASK]\n");
-				return -1;
-			}
-			if (err == 1)
-				fopt.defchange = ~0;
-			fopt_ok++;
-		} else if (matches(*argv, "overhead") == 0) {
-			NEXT_ARG();
-			if (get_u16(&overhead, *argv, 10)) {
-				explain1("overhead"); return -1;
-			}
-		} else if (matches(*argv, "linklayer") == 0) {
-			NEXT_ARG();
-			if (get_linklayer(&linklayer, *argv)) {
-				explain1("linklayer"); return -1;
-			}
-		} else if (matches(*argv, "help") == 0) {
-			explain_class();
-			return -1;
-		} else {
-			fprintf(stderr, "What is \"%s\"?\n", *argv);
-			explain_class();
-			return -1;
-		}
-		argc--; argv++;
-	}
-
-	/* OK. All options are parsed. */
-
-	/* 1. Prepare link sharing scheduler parameters */
-	if (r.rate) {
-		unsigned int pktsize = wrr.allot;
-
-		if (wrr.allot < (lss.avpkt*3)/2)
-			wrr.allot = (lss.avpkt*3)/2;
-		r.mpu = mpu;
-		r.overhead = overhead;
-		if (tc_calc_rtable(&r, rtab, cell_log, pktsize, linklayer) < 0) {
-			fprintf(stderr, "CBQ: failed to calculate rate table.\n");
-			return -1;
-		}
-	}
-	if (ewma_log < 0)
-		ewma_log = TC_CBQ_DEF_EWMA;
-	lss.ewma_log = ewma_log;
-	if (lss.change&(TCF_CBQ_LSS_OFFTIME|TCF_CBQ_LSS_MAXIDLE)) {
-		if (lss.avpkt == 0) {
-			fprintf(stderr, "CBQ: avpkt is required for max/minburst.\n");
-			return -1;
-		}
-		if (bndw == 0 || r.rate == 0) {
-			fprintf(stderr, "CBQ: bandwidth&rate are required for max/minburst.\n");
-			return -1;
-		}
-	}
-	if (wrr.priority == 0 && (n->nlmsg_flags&NLM_F_EXCL)) {
-		wrr_ok = 1;
-		wrr.priority = TC_CBQ_MAXPRIO;
-		if (wrr.allot == 0)
-			wrr.allot = (lss.avpkt*3)/2;
-	}
-	if (wrr_ok) {
-		if (wrr.weight == 0)
-			wrr.weight = (wrr.priority == TC_CBQ_MAXPRIO) ? 1 : r.rate;
-		if (wrr.allot == 0) {
-			fprintf(stderr, "CBQ: \"allot\" is required to set WRR parameters.\n");
-			return -1;
-		}
-	}
-	if (lss.change&TCF_CBQ_LSS_MAXIDLE) {
-		lss.maxidle = tc_cbq_calc_maxidle(bndw, r.rate, lss.avpkt, ewma_log, maxburst);
-		lss.change |= TCF_CBQ_LSS_MAXIDLE;
-		lss.change |= TCF_CBQ_LSS_EWMA|TCF_CBQ_LSS_AVPKT;
-	}
-	if (lss.change&TCF_CBQ_LSS_OFFTIME) {
-		lss.offtime = tc_cbq_calc_offtime(bndw, r.rate, lss.avpkt, ewma_log, minburst);
-		lss.change |= TCF_CBQ_LSS_OFFTIME;
-		lss.change |= TCF_CBQ_LSS_EWMA|TCF_CBQ_LSS_AVPKT;
-	}
-	if (lss.change&TCF_CBQ_LSS_MINIDLE) {
-		lss.minidle <<= lss.ewma_log;
-		lss.change |= TCF_CBQ_LSS_EWMA;
-	}
-
-	tail = addattr_nest(n, 1024, TCA_OPTIONS);
-	if (lss.change) {
-		lss.change |= TCF_CBQ_LSS_FLAGS;
-		addattr_l(n, 1024, TCA_CBQ_LSSOPT, &lss, sizeof(lss));
-	}
-	if (wrr_ok)
-		addattr_l(n, 1024, TCA_CBQ_WRROPT, &wrr, sizeof(wrr));
-	if (fopt_ok)
-		addattr_l(n, 1024, TCA_CBQ_FOPT, &fopt, sizeof(fopt));
-	if (r.rate) {
-		addattr_l(n, 1024, TCA_CBQ_RATE, &r, sizeof(r));
-		addattr_l(n, 3024, TCA_CBQ_RTAB, rtab, 1024);
-		if (show_raw) {
-			int i;
-
-			for (i = 0; i < 256; i++)
-				printf("%u ", rtab[i]);
-			printf("\n");
-		}
-	}
-	addattr_nest_end(n, tail);
-	return 0;
-}
-
-
-static int cbq_print_opt(struct qdisc_util *qu, FILE *f, struct rtattr *opt)
-{
-	struct rtattr *tb[TCA_CBQ_MAX+1];
-	struct tc_ratespec *r = NULL;
-	struct tc_cbq_lssopt *lss = NULL;
-	struct tc_cbq_wrropt *wrr = NULL;
-	struct tc_cbq_fopt *fopt = NULL;
-	struct tc_cbq_ovl *ovl = NULL;
-	unsigned int linklayer;
-
-	SPRINT_BUF(b1);
-	SPRINT_BUF(b2);
-
-	if (opt == NULL)
-		return 0;
-
-	parse_rtattr_nested(tb, TCA_CBQ_MAX, opt);
-
-	if (tb[TCA_CBQ_RATE]) {
-		if (RTA_PAYLOAD(tb[TCA_CBQ_RATE]) < sizeof(*r))
-			fprintf(stderr, "CBQ: too short rate opt\n");
-		else
-			r = RTA_DATA(tb[TCA_CBQ_RATE]);
-	}
-	if (tb[TCA_CBQ_LSSOPT]) {
-		if (RTA_PAYLOAD(tb[TCA_CBQ_LSSOPT]) < sizeof(*lss))
-			fprintf(stderr, "CBQ: too short lss opt\n");
-		else
-			lss = RTA_DATA(tb[TCA_CBQ_LSSOPT]);
-	}
-	if (tb[TCA_CBQ_WRROPT]) {
-		if (RTA_PAYLOAD(tb[TCA_CBQ_WRROPT]) < sizeof(*wrr))
-			fprintf(stderr, "CBQ: too short wrr opt\n");
-		else
-			wrr = RTA_DATA(tb[TCA_CBQ_WRROPT]);
-	}
-	if (tb[TCA_CBQ_FOPT]) {
-		if (RTA_PAYLOAD(tb[TCA_CBQ_FOPT]) < sizeof(*fopt))
-			fprintf(stderr, "CBQ: too short fopt\n");
-		else
-			fopt = RTA_DATA(tb[TCA_CBQ_FOPT]);
-	}
-	if (tb[TCA_CBQ_OVL_STRATEGY]) {
-		if (RTA_PAYLOAD(tb[TCA_CBQ_OVL_STRATEGY]) < sizeof(*ovl))
-			fprintf(stderr, "CBQ: too short overlimit strategy %u/%u\n",
-				(unsigned int) RTA_PAYLOAD(tb[TCA_CBQ_OVL_STRATEGY]),
-				(unsigned int) sizeof(*ovl));
-		else
-			ovl = RTA_DATA(tb[TCA_CBQ_OVL_STRATEGY]);
-	}
-
-	if (r) {
-		tc_print_rate(PRINT_FP, NULL, "rate %s ", r->rate);
-		linklayer = (r->linklayer & TC_LINKLAYER_MASK);
-		if (linklayer > TC_LINKLAYER_ETHERNET || show_details)
-			fprintf(f, "linklayer %s ", sprint_linklayer(linklayer, b2));
-		if (show_details) {
-			fprintf(f, "cell %ub ", 1<<r->cell_log);
-			if (r->mpu)
-				fprintf(f, "mpu %ub ", r->mpu);
-			if (r->overhead)
-				fprintf(f, "overhead %ub ", r->overhead);
-		}
-	}
-	if (lss && lss->flags) {
-		int comma = 0;
-
-		fprintf(f, "(");
-		if (lss->flags&TCF_CBQ_LSS_BOUNDED) {
-			fprintf(f, "bounded");
-			comma = 1;
-		}
-		if (lss->flags&TCF_CBQ_LSS_ISOLATED) {
-			if (comma)
-				fprintf(f, ",");
-			fprintf(f, "isolated");
-		}
-		fprintf(f, ") ");
-	}
-	if (wrr) {
-		if (wrr->priority != TC_CBQ_MAXPRIO)
-			fprintf(f, "prio %u", wrr->priority);
-		else
-			fprintf(f, "prio no-transmit");
-		if (show_details) {
-			fprintf(f, "/%u ", wrr->cpriority);
-			if (wrr->weight != 1)
-				tc_print_rate(PRINT_FP, NULL, "weight %s ",
-					      wrr->weight);
-			if (wrr->allot)
-				fprintf(f, "allot %ub ", wrr->allot);
-		}
-	}
-	if (lss && show_details) {
-		fprintf(f, "\nlevel %u ewma %u avpkt %ub ", lss->level, lss->ewma_log, lss->avpkt);
-		if (lss->maxidle) {
-			fprintf(f, "maxidle %s ", sprint_ticks(lss->maxidle>>lss->ewma_log, b1));
-			if (show_raw)
-				fprintf(f, "[%08x] ", lss->maxidle);
-		}
-		if (lss->minidle != 0x7fffffff) {
-			fprintf(f, "minidle %s ", sprint_ticks(lss->minidle>>lss->ewma_log, b1));
-			if (show_raw)
-				fprintf(f, "[%08x] ", lss->minidle);
-		}
-		if (lss->offtime) {
-			fprintf(f, "offtime %s ", sprint_ticks(lss->offtime, b1));
-			if (show_raw)
-				fprintf(f, "[%08x] ", lss->offtime);
-		}
-	}
-	if (fopt && show_details) {
-		char buf[64];
-
-		print_tc_classid(buf, sizeof(buf), fopt->split);
-		fprintf(f, "\nsplit %s ", buf);
-		if (fopt->defmap) {
-			fprintf(f, "defmap %08x", fopt->defmap);
-		}
-	}
-	return 0;
-}
-
-static int cbq_print_xstats(struct qdisc_util *qu, FILE *f, struct rtattr *xstats)
-{
-	struct tc_cbq_xstats *st;
-
-	if (xstats == NULL)
-		return 0;
-
-	if (RTA_PAYLOAD(xstats) < sizeof(*st))
-		return -1;
-
-	st = RTA_DATA(xstats);
-	fprintf(f, "  borrowed %u overactions %u avgidle %g undertime %g", st->borrows,
-		st->overactions, (double)st->avgidle, (double)st->undertime);
-	return 0;
-}
-
-struct qdisc_util cbq_qdisc_util = {
-	.id		= "cbq",
-	.parse_qopt	= cbq_parse_opt,
-	.print_qopt	= cbq_print_opt,
-	.print_xstats	= cbq_print_xstats,
-	.parse_copt	= cbq_parse_class_opt,
-	.print_copt	= cbq_print_opt,
-};
diff --git a/tc/tc_cbq.c b/tc/tc_cbq.c
deleted file mode 100644
index 7d1a4456..00000000
--- a/tc/tc_cbq.c
+++ /dev/null
@@ -1,53 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/*
- * tc_cbq.c		CBQ maintenance routines.
- *
- * Authors:	Alexey Kuznetsov, <kuznet@ms2.inr.ac.ru>
- */
-
-#include <stdio.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <fcntl.h>
-#include <math.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <arpa/inet.h>
-#include <string.h>
-
-#include "utils.h"
-#include "tc_core.h"
-#include "tc_cbq.h"
-
-unsigned int tc_cbq_calc_maxidle(unsigned int bndw, unsigned int rate, unsigned int avpkt,
-			     int ewma_log, unsigned int maxburst)
-{
-	double maxidle;
-	double g = 1.0 - 1.0/(1<<ewma_log);
-	double xmt = (double)avpkt/bndw;
-
-	maxidle = xmt*(1-g);
-	if (bndw != rate && maxburst) {
-		double vxmt = (double)avpkt/rate - xmt;
-
-		vxmt *= (pow(g, -(double)maxburst) - 1);
-		if (vxmt > maxidle)
-			maxidle = vxmt;
-	}
-	return tc_core_time2tick(maxidle*(1<<ewma_log)*TIME_UNITS_PER_SEC);
-}
-
-unsigned int tc_cbq_calc_offtime(unsigned int bndw, unsigned int rate, unsigned int avpkt,
-			     int ewma_log, unsigned int minburst)
-{
-	double g = 1.0 - 1.0/(1<<ewma_log);
-	double offtime = (double)avpkt/rate - (double)avpkt/bndw;
-
-	if (minburst == 0)
-		return 0;
-	if (minburst == 1)
-		offtime *= pow(g, -(double)minburst) - 1;
-	else
-		offtime *= 1 + (pow(g, -(double)(minburst-1)) - 1)/(1-g);
-	return tc_core_time2tick(offtime*TIME_UNITS_PER_SEC);
-}
diff --git a/tc/tc_cbq.h b/tc/tc_cbq.h
deleted file mode 100644
index fa17d249..00000000
--- a/tc/tc_cbq.h
+++ /dev/null
@@ -1,10 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _TC_CBQ_H_
-#define _TC_CBQ_H_ 1
-
-unsigned tc_cbq_calc_maxidle(unsigned bndw, unsigned rate, unsigned avpkt,
-			     int ewma_log, unsigned maxburst);
-unsigned tc_cbq_calc_offtime(unsigned bndw, unsigned rate, unsigned avpkt,
-			     int ewma_log, unsigned minburst);
-
-#endif
diff --git a/tc/tc_class.c b/tc/tc_class.c
index 65776180..f6a3d134 100644
--- a/tc/tc_class.c
+++ b/tc/tc_class.c
@@ -45,7 +45,7 @@ static void usage(void)
 		"\n"
 		"       tc class show [ dev STRING ] [ root | parent CLASSID ]\n"
 		"Where:\n"
-		"QDISC_KIND := { prio | cbq | etc. }\n"
+		"QDISC_KIND := { prio | etc. }\n"
 		"OPTIONS := ... try tc class add <desired QDISC_KIND> help\n");
 }
 
diff --git a/tc/tc_filter.c b/tc/tc_filter.c
index d28b1859..eb45c588 100644
--- a/tc/tc_filter.c
+++ b/tc/tc_filter.c
@@ -35,7 +35,7 @@ static void usage(void)
 		"       tc filter show [ dev STRING ] [ root | ingress | egress | parent CLASSID ]\n"
 		"       tc filter show [ block BLOCK_INDEX ]\n"
 		"Where:\n"
-		"FILTER_TYPE := { rsvp | u32 | bpf | fw | route | etc. }\n"
+		"FILTER_TYPE := { u32 | bpf | fw | route | etc. }\n"
 		"FILTERID := ... format depends on classifier, see there\n"
 		"OPTIONS := ... try tc filter add <desired FILTER_KIND> help\n");
 }
diff --git a/tc/tc_qdisc.c b/tc/tc_qdisc.c
index 56086c43..84fd659f 100644
--- a/tc/tc_qdisc.c
+++ b/tc/tc_qdisc.c
@@ -33,7 +33,7 @@ static int usage(void)
 		"\n"
 		"       tc qdisc { show | list } [ dev STRING ] [ QDISC_ID ] [ invisible ]\n"
 		"Where:\n"
-		"QDISC_KIND := { [p|b]fifo | tbf | prio | cbq | red | etc. }\n"
+		"QDISC_KIND := { [p|b]fifo | tbf | prio | red | etc. }\n"
 		"OPTIONS := ... try tc qdisc add <desired QDISC_KIND> help\n"
 		"STAB_OPTIONS := ... try tc qdisc add stab help\n"
 		"QDISC_ID := { root | ingress | handle QHANDLE | parent CLASSID }\n");
diff --git a/testsuite/tests/tc/cbq.t b/testsuite/tests/tc/cbq.t
deleted file mode 100755
index bff814b7..00000000
--- a/testsuite/tests/tc/cbq.t
+++ /dev/null
@@ -1,10 +0,0 @@
-#!/bin/sh
-$TC qdisc del dev $DEV root >/dev/null 2>&1
-$TC qdisc add dev $DEV root handle 10:0 cbq bandwidth 100Mbit avpkt 1400 mpu 64
-$TC class add dev $DEV parent 10:0  classid 10:12   cbq bandwidth 100mbit rate 100mbit allot 1514 prio 3 maxburst 1 avpkt  500 bounded
-$TC qdisc list dev $DEV
-$TC qdisc del dev $DEV root
-$TC qdisc list dev $DEV
-$TC qdisc add dev $DEV root handle 10:0 cbq bandwidth 100Mbit avpkt 1400 mpu 64
-$TC class add dev $DEV parent 10:0  classid 10:12   cbq bandwidth 100mbit rate 100mbit allot 1514 prio 3 maxburst 1 avpkt  500 bounded
-$TC qdisc del dev $DEV root
diff --git a/testsuite/tests/tc/policer.t b/testsuite/tests/tc/policer.t
deleted file mode 100755
index eaf16acf..00000000
--- a/testsuite/tests/tc/policer.t
+++ /dev/null
@@ -1,13 +0,0 @@
-#!/bin/sh
-$TC qdisc del dev $DEV root >/dev/null 2>&1
-$TC qdisc add dev $DEV root handle 10:0 cbq bandwidth 100Mbit avpkt 1400 mpu 64
-$TC class add dev $DEV parent 10:0  classid 10:12   cbq bandwidth 100mbit rate 100mbit allot 1514 prio 3 maxburst 1 avpkt  500 bounded
-$TC filter add dev $DEV parent 10:0 protocol ip prio 10 u32 match ip protocol 1 0xff police rate 2kbit buffer 10k drop flowid 10:12
-$TC qdisc list dev $DEV
-$TC filter list dev $DEV parent 10:0
-$TC qdisc del dev $DEV root
-$TC qdisc list dev $DEV
-$TC qdisc add dev $DEV root handle 10:0 cbq bandwidth 100Mbit avpkt 1400 mpu 64
-$TC class add dev $DEV parent 10:0  classid 10:12   cbq bandwidth 100mbit rate 100mbit allot 1514 prio 3 maxburst 1 avpkt  500 bounded
-$TC filter add dev $DEV parent 10:0 protocol ip prio 10 u32 match ip protocol 1 0xff police rate 2kbit buffer 10k drop flowid 10:12
-$TC qdisc del dev $DEV root
-- 
2.41.0


