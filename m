Return-Path: <netdev+bounces-45298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BA2F7DC003
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 19:42:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F45C1C20BB2
	for <lists+netdev@lfdr.de>; Mon, 30 Oct 2023 18:42:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB81018B1E;
	Mon, 30 Oct 2023 18:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="unz/cD1b"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC69318E29
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 18:42:15 +0000 (UTC)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2869CC
	for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 11:42:09 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 41be03b00d2f7-565334377d0so3774114a12.2
        for <netdev@vger.kernel.org>; Mon, 30 Oct 2023 11:42:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1698691329; x=1699296129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0st15/6vEsxBLbV8zRPWgK3ZyYWenGMna2c6o8ziv9w=;
        b=unz/cD1bOvBhU/u54J5oeejtEmsXUD/u5ftJxJ8rZebw1NWhkQXiW6mxM3NWz4/cJk
         pQFLArrfnM4ZqChZ2i9TRSl8YJRp/2IX5RpfJUI+5ufbTOoGdudwdeDCLEucluZmEzkQ
         hLoqYGyKVyb5pkR8/J+E5ZlwSVXBM1jKZhahTRREELBg+hcZ6Q31AAFS+fgV2UiyHOIw
         PcavrkKZnTZ+I3Cf2SqRb8kC8v/YxmDajgg82tWCNIfkQbCJVaIR9X/XvNK6d6fr5eip
         TOIuXOhp1Lq1B1s1PqF40f2YjkAmGLKo/37/6mU2cuI3vbw+NDlicf2MmvED5RGWp/ue
         gs9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698691329; x=1699296129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0st15/6vEsxBLbV8zRPWgK3ZyYWenGMna2c6o8ziv9w=;
        b=xU6AwtAEPKrwN5EdHmMqB0Bk3a7STC24qtmELvzTTD1OPkdxs+SzHzmmS+huqgPOk1
         igtP62C6bPiz7S1bsWigAD6qpmZKL+0cpI9nBujSxpYrDfkeTazdq18eteFTUnnUnk1s
         PaZ7Zdjv1NAqQBaCP4AqvnS8aQwC6KV3gkEcynMibzHF+CAV+tfwhPPKLOWx1fGoFZXX
         EFh/lhkqugkfFlmWOkgExk37iHfC3DtI52N/lJn/Pnm46laaD0gruolvJjBXjKsTfwOS
         AayfGLJzKdoeRYbnIRmgbBP2mKAjLThDuCvH+BucOqLsJpSUPq2m62F2mL7mjDzCTwgF
         8/Mw==
X-Gm-Message-State: AOJu0YzxvSfuhv4eiw+baofh0sHvoP2uwfBrRYhC6PQjMrQNWfTtzD8G
	dFdcW98xa8g61aEioPwr9c8GJmIKkdd7DLtHv3hKUJh/t+E=
X-Google-Smtp-Source: AGHT+IE2IAsJt2ds0aQfwxLz++pCr1mevUgxgvSdl3RFwbOFcx4GFAnH6s1ySYLKGS7KGtkHsF+9nQ==
X-Received: by 2002:a05:6a21:7905:b0:175:59b5:5a61 with SMTP id bg5-20020a056a21790500b0017559b55a61mr10508986pzc.60.1698691328292;
        Mon, 30 Oct 2023 11:42:08 -0700 (PDT)
Received: from fedora.. ([38.142.2.14])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a0010c500b006bfb903599esm6206962pfu.139.2023.10.30.11.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 11:42:07 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2 iproute2 1/4] tc: remove support for CBQ
Date: Mon, 30 Oct 2023 11:39:46 -0700
Message-ID: <20231030184100.30264-2-stephen@networkplumber.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231030184100.30264-1-stephen@networkplumber.org>
References: <20231030184100.30264-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The CBQ qdisc was removed in 6.3 kernel by upstream
051d44209842 (net/sched: Retire CBQ qdisc, 2023-02-14)

Remove associated support from iproute2 including dropping
tests, man pages and fixing other references.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 man/man7/tc-hfsc.7           |   2 +-
 man/man8/tc-cbq-details.8    | 423 -------------------------
 man/man8/tc-cbq.8            | 351 ---------------------
 man/man8/tc-htb.8            |   8 +-
 man/man8/tc.8                |   9 +-
 tc/Makefile                  |   2 -
 tc/q_cbq.c                   | 589 -----------------------------------
 tc/tc_cbq.c                  |  53 ----
 tc/tc_cbq.h                  |  10 -
 tc/tc_class.c                |   2 +-
 tc/tc_qdisc.c                |   2 +-
 testsuite/tests/tc/cbq.t     |  10 -
 testsuite/tests/tc/policer.t |  13 -
 13 files changed, 7 insertions(+), 1467 deletions(-)
 delete mode 100644 man/man8/tc-cbq-details.8
 delete mode 100644 man/man8/tc-cbq.8
 delete mode 100644 tc/q_cbq.c
 delete mode 100644 tc/tc_cbq.c
 delete mode 100644 tc/tc_cbq.h
 delete mode 100755 testsuite/tests/tc/cbq.t
 delete mode 100755 testsuite/tests/tc/policer.t

diff --git a/man/man7/tc-hfsc.7 b/man/man7/tc-hfsc.7
index 412b4c3b..72fb5f2c 100644
--- a/man/man7/tc-hfsc.7
+++ b/man/man7/tc-hfsc.7
@@ -35,7 +35,7 @@ it matters only for leaf classes (where the actual queues are) \- thus class
 hierarchy is ignored in the realtime case.
 
 Feature \fB(2)\fR is well, obvious \- any algorithm featuring class hierarchy
-(such as HTB or CBQ) strives to achieve that. HFSC does that well, although
+(such as HTB) strives to achieve that. HFSC does that well, although
 you might end with unusual situations, if you define service curves carelessly
 \- see section CORNER CASES for examples.
 
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
diff --git a/man/man8/tc-htb.8 b/man/man8/tc-htb.8
index 031b73ac..7aa62615 100644
--- a/man/man8/tc-htb.8
+++ b/man/man8/tc-htb.8
@@ -35,15 +35,13 @@ bytes
 .B ]
 
 .SH DESCRIPTION
-HTB is meant as a more understandable and intuitive replacement for
-the CBQ qdisc in Linux. Both CBQ and HTB help you to control the use
-of the outbound bandwidth on a given link. Both allow you to use one
-physical link to simulate several slower links and to send different
+HTB allows  control of the outbound bandwidth on a given link.
+It allows simulating simulating several slower links and to send different
 kinds of traffic on different simulated links. In both cases, you have
 to specify how to divide the physical link into simulated links and
 how to decide which simulated link to use for a given packet to be sent.
 
-Unlike CBQ, HTB shapes traffic based on the Token Bucket Filter algorithm
+HTB shapes traffic based on the Token Bucket Filter algorithm
 which does not depend on interface characteristics and so does not need to
 know the underlying bandwidth of the outgoing interface.
 
diff --git a/man/man8/tc.8 b/man/man8/tc.8
index d436d464..8f730dda 100644
--- a/man/man8/tc.8
+++ b/man/man8/tc.8
@@ -402,12 +402,6 @@ ATM
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
@@ -452,7 +446,7 @@ well to a hardware implementation.
 .SH THEORY OF OPERATION
 Classes form a tree, where each class has a single parent.
 A class may have multiple children. Some qdiscs allow for runtime addition
-of classes (CBQ, HTB) while others (PRIO) are created with a static number of
+of classes (HTB) while others (PRIO) are created with a static number of
 children.
 
 Qdiscs which allow dynamic addition of classes can have zero or more
@@ -876,7 +870,6 @@ was written by Alexey N. Kuznetsov and added in Linux 2.2.
 .BR tc-bfifo (8),
 .BR tc-bpf (8),
 .BR tc-cake (8),
-.BR tc-cbq (8),
 .BR tc-cgroup (8),
 .BR tc-choke (8),
 .BR tc-codel (8),
diff --git a/tc/Makefile b/tc/Makefile
index 98d2ee59..95ba3b5d 100644
--- a/tc/Makefile
+++ b/tc/Makefile
@@ -14,7 +14,6 @@ TCMODULES += q_red.o
 TCMODULES += q_prio.o
 TCMODULES += q_skbprio.o
 TCMODULES += q_tbf.o
-TCMODULES += q_cbq.o
 TCMODULES += q_multiq.o
 TCMODULES += q_netem.o
 TCMODULES += q_choke.o
@@ -118,7 +117,6 @@ endif
 
 TCLIB := tc_core.o
 TCLIB += tc_red.o
-TCLIB += tc_cbq.o
 TCLIB += tc_estimator.o
 TCLIB += tc_stab.o
 TCLIB += tc_qevent.o
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


