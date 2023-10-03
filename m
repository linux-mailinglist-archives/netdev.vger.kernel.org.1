Return-Path: <netdev+bounces-37556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CD8C7B5FB8
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 06:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 94F531C20844
	for <lists+netdev@lfdr.de>; Tue,  3 Oct 2023 04:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F4DEC8;
	Tue,  3 Oct 2023 04:17:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8920C10E8
	for <netdev@vger.kernel.org>; Tue,  3 Oct 2023 04:17:06 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36153C9
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 21:17:02 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d7ec535fe42so756254276.1
        for <netdev@vger.kernel.org>; Mon, 02 Oct 2023 21:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696306621; x=1696911421; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9kMAxl7wnzbYfSitqyqtdz7yD/9Z7wPKR2cHV1SDeLQ=;
        b=m8vxQ8rV0UaHl6IF+fnDSbaw0v9JpXzQdk5grGUeYImsBr/oUjQ1+jOcs0VMcw3Isg
         veN5haPpKgjswFEvNXzDipwNXxWJxy3cleyNxWEjXx6842zrrxpz1fnS3GUfz+0YoK7f
         rlKrWhYeSHrxGEHOAwTibaGQggqrgQP1xQbcmc3rkRxOWzUHrTcuEWL9O7+yTV0rKXrS
         5/ZJKOxDeom2C31YCyrj4BFCjMr54HYMlRJ7p1uB1u2cuo+MyyxbKsSh5DilykEtupul
         E9O3AUCE3fHe2mr4Bbrl5vCXMjqolJVgaLTKE6pKWx/h5ybD5gly7mUOK8Fj8CIwsAZC
         1gVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696306621; x=1696911421;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9kMAxl7wnzbYfSitqyqtdz7yD/9Z7wPKR2cHV1SDeLQ=;
        b=efjR00vqHpruthV5S6SfTG9fe0FoqqEQFKSKzeG6GrCjSC7NzopFK4kI+HVVJqi1aX
         o0UE5iGROzPf7sTSVsR7TVDpaLS9bDX6n/r/sUKcrqMDMzqoS6FuzTW5nberhKlsPQqC
         MZKfnKkCB7/oZDvc9lzu0rIJgLtBx0P7i4EEjswZK4jeszLvmp0xR6d5SwOigRgfMxpU
         JiecrPq4Rqb/JIBb08AWld2bik+Wt+ek1Alvt8Xj4OhOb3K8Xi3ciJpwKRwDvIttj0Qs
         pCmZUgeGMSxEyG1bdUP4+6eUBy2kR40FXwt1OGn5RrguZlWJ76+T9r7vHtsB1pRnz3t9
         JG+A==
X-Gm-Message-State: AOJu0YxeyBBeKSOnpeh483hjJMga0HEi5zCXZnKxu1SThdcvl+Xhy67/
	CJVRvwDDHLQ8eLOB6++c63H0lg7xoMW5TTP5J9Cs4HF8BG37cGvVdYqVyB7FzuUe/fo2YE9VJcW
	5ODZCEr89ynUJMRYJF/xkEd7GxmjxhuTt26KPl1P6HnWsGFkue9wmhxGrQQrziiBO
X-Google-Smtp-Source: AGHT+IFTh73WutQg1HKHRN6gvVmsnoyBnUIIdRWVnhGRA/0U2dv77uh8riZh7TSwPg5ujv/BPkrdVQMikN4x
X-Received: from coldfire.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:2b7a])
 (user=maheshb job=sendgmr) by 2002:a5b:882:0:b0:d7f:f3e:74ab with SMTP id
 e2-20020a5b0882000000b00d7f0f3e74abmr214972ybq.1.1696306621178; Mon, 02 Oct
 2023 21:17:01 -0700 (PDT)
Date: Mon,  2 Oct 2023 21:16:57 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003041657.1745487-1-maheshb@google.com>
Subject: [PATCHv2 next 0/3] add ptp_gettimex64any() API
From: Mahesh Bandewar <maheshb@google.com>
To: Netdev <netdev@vger.kernel.org>, Linux <linux-kernel@vger.kernel.org>, 
	David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: Jonathan Corbet <corbet@lwn.net>, John Stultz <jstultz@google.com>, Don Hatchett <hatch@google.com>, 
	Yuliang Li <yuliangli@google.com>, Mahesh Bandewar <mahesh@bandewar.net>, 
	Mahesh Bandewar <maheshb@google.com>
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
   CLOCK_REALTIME, CLOCK_MONOTONIC, & CLOCK_MONOTONIC_RAW

The CLOCK_REALTIME option is equivalent of using current gettimex64()
method.

The first patch adds this new PTP method while the second patch
adds the ioctl support for this method.

The last patch in the series updates the selftest to exercise this
new method.

Mahesh Bandewar (3):
  ptp: add ptp_gettimex64any() support
  ptp: add ioctl interface for ptp_gettimex64any()
  selftes/ptp: extend test to include ptp_gettimex64any()

 drivers/ptp/ptp_chardev.c             | 34 ++++++++++++
 include/linux/ptp_clock_kernel.h      | 51 ++++++++++++++++++
 include/uapi/linux/ptp_clock.h        | 21 ++++++++
 tools/testing/selftests/Makefile      |  1 +
 tools/testing/selftests/ptp/testptp.c | 76 ++++++++++++++++++++++++++-
 5 files changed, 181 insertions(+), 2 deletions(-)

v1 -> v2
  * Removed ktime_get_cycles64() implementation
  * Removed CYCLES as an option
-- 
2.42.0.582.g8ccd20d70d-goog


