Return-Path: <netdev+bounces-36955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 485C57B2A55
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 04:37:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 653D2281D66
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 02:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCDB17D5;
	Fri, 29 Sep 2023 02:37:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CA717D2
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 02:37:40 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB2841A2
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 19:37:38 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-59bdb9fe821so265580657b3.0
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 19:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695955058; x=1696559858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9fNDjspVJr/ayAsGgaCrOKgIRYGYktlfH6pYdojDtfM=;
        b=0RHaWIw9GdyELJ4ajvBJ3/4Wf7KArLr6jhlcdc6D2BauXzt/BP7kmoTdTG8cy1XN8V
         az7XdpK6a8w4cVEttDnXcCwrlENT8C1oLt/0ipDz31QE5yRJGmhrMgW+UM8RpXjfGIyi
         fN0RQyBGRi2ZfCnNsgVL/6YTIsY7HRG2uLSTf2O7DA+z0iOa/wj9SPPjAzsHjoXlEjVD
         KmwvAphAkWi15gaxisNlYyZb4lIfGUQ0EFCXVHFFgJWTr4ch6T2/Bw0obtrX0KQQwB2B
         mmFx+ozGj4DQLwMqjc4DJyTDzVO5jt3pgdOxhbLW6gTnfqRF8DVa5/8NKi/QQopE+WM5
         1W3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695955058; x=1696559858;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9fNDjspVJr/ayAsGgaCrOKgIRYGYktlfH6pYdojDtfM=;
        b=sdSD6/QcpYEA0qxiWJg8vSv9YU/vsBS6twq+cig7l5n+0jZliKK77PIrdyQjNVVQix
         8qSBLOlDfJyfl3p7z+WuUk6dkHWUzui1TkYJLPgEvqT3h/FBSo+r64Vty79zqXQvNgzN
         YL1erQQMfZFSwAhx+4YwF4j2I+Gc/cnf8Y7rFgV6J7wjmEgMADiDlHgB5NyBxxU1sNEl
         4HN/bQXYIEOOiI8B3avvJPmjkzz6tMAb5IE8KayKroi6csQlGpei9FUgTL4FBx/XyAou
         TmoyUNhiMgECgeepygQf24jQTStX2Ii4pukiyEGmaKaTHZM12RMd3p3xVULBiCWB63dc
         Wa2Q==
X-Gm-Message-State: AOJu0YzW7emMfffpBUtiDwy/2Q4yZgICl+vnDcspZ04Bi5OP+F5qbUMB
	JVBgcLfIjeZgSoLbu3NYzZ42XCqHN4YyT1lDD8Im/Zxj7kz6r4L4uRLnotcE1i8jIFGPDw948Tf
	OuqZyqHmaeqQpkL6NYrbacLUpQ914fofxyliToZ+rH5qm2LJNwxbhtWpJ8JVWnXCu
X-Google-Smtp-Source: AGHT+IH244p4A7/TsBZIkhUS1BEg573rPjXKPmFYA0OVVgZdwGCpQAo30ChlwRAAxjtbecMcVXZ8/tGwPX5e
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a81:ac0e:0:b0:59b:f138:c845 with SMTP id
 k14-20020a81ac0e000000b0059bf138c845mr39421ywh.2.1695955056958; Thu, 28 Sep
 2023 19:37:36 -0700 (PDT)
Date: Thu, 28 Sep 2023 19:37:21 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20230929023721.1610484-1-maheshb@google.com>
Subject: [PATCH 0/4] add ptp_gettimex64any() API
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, Don Hatchett <hatch@google.com>, Yuliang Li <yuliangli@google.com>, 
	Mahesh Bandewar <mahesh@bandewar.net>, Mahesh Bandewar <maheshb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

The current API to get the sandwich TS for the master-PTP clock read
supports only the sys-time sandwich. This is not really suitable for
all the use cases of sandwich TS needs. Ideally it should
allow a choice of a timebase to use for ts-sandwich need. Updating
the existing API [gettimex64()] is not an option since it would
break compatibility.

About the name - This is a superset of current gettimex64. Since 
the timebase for gettimex64 is fixed and is only 'sys-time / real-time'. 
I'm appending "any" to add the choice factor. so gettimex64any() would
give you eXtended time with sandwitch TS of a timebase of your choice.
If there is a better name, I won't mind changing.

The timebase options are -
   CLOCK_REALTIME, CLOCK_MONOTONIC, CLOCK_MONOTONIC_RAW, & RAW_CYCLES

Since the ioctl() returns 'stuct ptp_clock_time *', the RAW_CYCLES are
converted into sec = 10^9 cycles, nsec = remainder-cycles basically
ns_to_timespec64. Caller can convert the value into raw-cycles
by using calculations similar to timespec64_to_ns()

The CLOCK_REALTIME option is equivalent of using current gettimex64()
method.

The first patch adds the ktime_get_cycles64() method to support
RAW-CYCLES option. The other timebases already have supporting
methods available.

The second patch adds this new PTP method while the third patch adds the
ioctl support for this method.

The last patch in the series updates the selftest to exercise this new
method.

Mahesh Bandewar (4):
  time: add ktime_get_cycles64() api
  ptp: add ptp_gettimex64any() support
  ptp: add ioctl interface for ptp_gettimex64any()
  selftes/ptp: extend test to include ptp_gettimex64any()

 drivers/ptp/ptp_chardev.c             | 34 ++++++++++++
 include/linux/ptp_clock_kernel.h      | 57 +++++++++++++++++++
 include/linux/timekeeping.h           |  1 +
 include/uapi/linux/ptp_clock.h        | 22 ++++++++
 kernel/time/timekeeping.c             | 24 ++++++++
 tools/testing/selftests/Makefile      |  1 +
 tools/testing/selftests/ptp/testptp.c | 79 ++++++++++++++++++++++++++-
 7 files changed, 216 insertions(+), 2 deletions(-)

-- 
2.42.0.582.g8ccd20d70d-goog


