Return-Path: <netdev+bounces-38253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE707B9DA6
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 15:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 018E2B209D1
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 13:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC420262BC;
	Thu,  5 Oct 2023 13:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i26RxsCQ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B33D1A27F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 13:53:29 +0000 (UTC)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0472A59F4
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 06:53:28 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40535597f01so8713355e9.3
        for <netdev@vger.kernel.org>; Thu, 05 Oct 2023 06:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696514006; x=1697118806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HTfY0bKHPOV3k6EqGPsZc+XcGSg7+pVJDjul7ugrvnE=;
        b=i26RxsCQdOdL6za5MpkM2ZRgEK0tHF8LFMTrpRRm00L2FNEIfDcqE3BHpPvukjNScM
         +uWDO4sA7wxsJ+pmEOSVIWz5Z0O5vklEWWIRE6aq8nu5BMkRe8xgpSYXqHV/sao4naOL
         aanUQU49uUcQzJvTtLDAiFcQuGC5pSkPdMyJATxDg+JCfXmNgILzfqoxMLxK7udnhDfC
         tu3yuZc1nok9VeGDbKtK5fGoWsjYchM0wpHJYftcLOB9Pkq2NDlrz3tJ59wuKAx8eCbN
         E7PDryTzkeIm70MZeJKIU/Jtpczzxl/9yeJ3M0/peyE90DLmUCtgPEe/w9n6OvTo3+RD
         3ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696514006; x=1697118806;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HTfY0bKHPOV3k6EqGPsZc+XcGSg7+pVJDjul7ugrvnE=;
        b=bHpVZdo2H91r3jXA54V7yPQedx2GvDwlSAx8TiV7OCEbHMpmnbtTuFWRvQeeCyK41m
         DuyuuHt+QR+w4bEEfsyjWM5eAsS78FkxTq9ehw0ks7QG6ynzTTNyEUEzwOsAWIrFTJuH
         ng54e3O9z+V67XamAefPoGv/wDAA4AHsydBqsHtZJC3pFRsfKvYQ5AIbyQ1L4s46kBN6
         7Y1d9Dz9ECGqW3H5hlqiZozM2E+vtVOmsS+Y4GmzOES57mEUt51c77wvzd/FrODKPPOx
         dA0GnF1OPWmHyNEHwynTx9eyhNm+jL9EHWZrG7UERY4HK+zUz/Kcio+IQBkX9D+JVT3P
         0kjA==
X-Gm-Message-State: AOJu0YwUVfBl49H8q/KeIXLWMLaLRus/aECykjrCjiofFaVDkZ1LMnJV
	sn8TrPG3EHCoT8sGkWXi91tlC592HDsqyA==
X-Google-Smtp-Source: AGHT+IGtvlVSd75NWL5Cr11t9NrGif2f11xAXC3dsa9XJlXdkF3eH/B89nF944B7BKx8M0qVSrkH+Q==
X-Received: by 2002:a05:600c:ad0:b0:406:7029:7cc3 with SMTP id c16-20020a05600c0ad000b0040670297cc3mr5049116wmr.28.1696514005936;
        Thu, 05 Oct 2023 06:53:25 -0700 (PDT)
Received: from xmarquiegui-HP-ZBook-15-G6.internal.ainguraiiot.com (210.212-55-6.static.clientes.euskaltel.es. [212.55.6.210])
        by smtp.gmail.com with ESMTPSA id h4-20020a056000000400b00327df8fcbd9sm1867041wrx.9.2023.10.05.06.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 06:53:25 -0700 (PDT)
From: Xabier Marquiegui <reibax@gmail.com>
To: netdev@vger.kernel.org
Cc: richardcochran@gmail.com,
	tglx@linutronix.de,
	jstultz@google.com,
	horms@kernel.org,
	chrony-dev@chrony.tuxfamily.org,
	mlichvar@redhat.com,
	reibax@gmail.com,
	ntp-lists@mattcorallo.com,
	vinicius.gomes@intel.com,
	alex.maftei@amd.com,
	davem@davemloft.net,
	rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: [PATCH net-next v4 0/6] ptp: Support for multiple filtered timestamp event queue readers
Date: Thu,  5 Oct 2023 15:53:10 +0200
Message-Id: <cover.1696511486.git.reibax@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On systems with multiple timestamp event channels, there can be scenarios
where multiple userspace readers want to access the timestamping data for
various purposes.

One such example is wanting to use a pps out for time synchronization, and
wanting to timestamp external events with the synchronized time base 
simultaneously.

Timestmp event consumers on the other hand, are often interested in a
subset of the available timestamp channels. linuxptp ts2phc, for example,
is not happy if more than one timestamping channel is active on the device
it is reading from.

This patch-set introduces linked lists to support multiple timestamp event
queue consumers, and timestamp event channel filters through IOCTLs, as
well as a debugfs interface to do some simple verifications.

Xabier Marquiegui (6):
  posix-clock: introduce posix_clock_context concept
  ptp: Replace timestamp event queue with linked list
  ptp: support multiple timestamp event readers
  ptp: support event queue reader channel masks
  ptp: add debugfs interface to see applied channel masks
  ptp: add testptp mask test

 drivers/ptp/ptp_chardev.c                   | 127 ++++++++++++++++----
 drivers/ptp/ptp_clock.c                     |  45 ++++++-
 drivers/ptp/ptp_private.h                   |  28 +++--
 drivers/ptp/ptp_sysfs.c                     |  13 +-
 include/linux/posix-clock.h                 |  22 ++--
 include/uapi/linux/ptp_clock.h              |   2 +
 kernel/time/posix-clock.c                   |  36 ++++--
 tools/testing/selftests/ptp/ptpchmaskfmt.sh |  14 +++
 tools/testing/selftests/ptp/testptp.c       |  19 ++-
 9 files changed, 246 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/ptp/ptpchmaskfmt.sh

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
Suggested-by: Richard Cochran <richardcochran@gmail.com>
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
v4:
  - split modifications in different patches for improved organization
  - rename posix_clock_user to posix_clock_context
  - remove unnecessary flush_users clock operation
  - remove unnecessary tests
  - simpler queue clean procedure
  - fix/clean comment lines
  - simplified release procedures
  - filter modifications exclusive to currently open instance for
    simplicity and security
  - expand mask to 2048 channels
  - make more secure and simple: mask is only applied to the testptp
    instance. Use debugfs to verify effects.
v3: https://lore.kernel.org/netdev/20230928133544.3642650-1-reibax@gmail.com/
  - add this patchset overview file
  - fix use of safe and non safe linked lists for loops
  - introduce new posix_clock private_data and ida object ids for better
    dicrimination of timestamp consumers
  - safer resource release procedures
  - filter application by object id, aided by process id
  - friendlier testptp implementation of event queue channel filters
v2: https://lore.kernel.org/netdev/20230912220217.2008895-1-reibax@gmail.com/
  - fix ptp_poll() return value
  - Style changes to comform to checkpatch strict suggestions
  - more coherent ptp_read error exit routines
  - fix testptp compilation error: unknown type name 'pid_t'
  - rename mask variable for easier code traceability
  - more detailed commit message with two examples
v1: https://lore.kernel.org/netdev/20230906104754.1324412-2-reibax@gmail.com/
---

