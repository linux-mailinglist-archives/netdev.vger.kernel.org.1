Return-Path: <netdev+bounces-38922-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E6507BD103
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 00:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6E8F1C2074F
	for <lists+netdev@lfdr.de>; Sun,  8 Oct 2023 22:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91AE31A91;
	Sun,  8 Oct 2023 22:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtethckF"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B0768C13
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 22:49:31 +0000 (UTC)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC15A6
	for <netdev@vger.kernel.org>; Sun,  8 Oct 2023 15:49:29 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-406618d0992so38513915e9.0
        for <netdev@vger.kernel.org>; Sun, 08 Oct 2023 15:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696805367; x=1697410167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sKKAUlHJJPlvgAXnSDKZJObIGjCQD18vBnS0s8yRisM=;
        b=jtethckFg0tcq/PVwUDbo+bOhwgqYhpcSB3gskRD/UI3+o/wohZPxeCj8yj4l/Jwvl
         B8y2Pfck6zzAOdf/q305YbvPuewPo7hyEGX4CjE48qd62jO6eq+Jm6xFNzQYcndi4LfN
         ozyNrRwEa8S/+8cT+6MiwzFJ9rhK2nnm2BJv4QESZhqpD/BK4t/gf2nfUIQl4Zpc+5Mo
         9d0nJQdioX5Ds/R4LXGiptDrUTFbI5K7KlGy3JemxZWEM4ajdBvt8EKmfsWEMPCiNwUi
         /qhKsuZBB2amEdp007c9zGvWw+7OQfRhaMhNsQrmM+wBH27wB197Nvxm8d0+g3Jjtol2
         rzCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696805367; x=1697410167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKKAUlHJJPlvgAXnSDKZJObIGjCQD18vBnS0s8yRisM=;
        b=XBVpT1Jf4vhxpYXnx0qhDb/h8zVkUT9GoN7SrYRUDTb4HY3Ctfsd1vGl3L4MEE3bm6
         MSU4Yu8v0mRdjaTPzSrO8xY3otaC2CMHgej5kvqrdoQbGYJi/QLiggoMaSTSPM8XkP4I
         3Ff766ylnGY71FcXtUMFiE5WMPIYxXLhuM1UVw7NAQg3Osy1Lqk5raGz7pEQev8setwB
         US9BiHWN/wtnlXYiZndHgn17QMObn2TQB7DuADo3uZupC4EU1gXDigRODsgF5nZqg2f9
         7H6wFgl5dsBXmm4KJwGYL2Lr9LcO+l0ZlxxZWNidcLzZiMUJ/ztrcxu4EqePv9H+FE5C
         9rMw==
X-Gm-Message-State: AOJu0Ywys5P/wtrTWJMLuc8vTBnD0NFk7eNH3ev/TnvFqrjR8MIwpsur
	38snZW2peugVXx3OdNMCdC0VZX73vLt8Pg==
X-Google-Smtp-Source: AGHT+IF0LVstWtnQ1RC1JUNW4FY8ie3ewjQ3ljiumPQivbcBOsYC9w81/ISBILln3BW8rqr/u7c+sw==
X-Received: by 2002:a1c:720a:0:b0:401:b6f6:d90c with SMTP id n10-20020a1c720a000000b00401b6f6d90cmr12600227wmc.35.1696805366958;
        Sun, 08 Oct 2023 15:49:26 -0700 (PDT)
Received: from reibax-minipc.lan ([2a0c:5a80:3e06:7600::978])
        by smtp.gmail.com with ESMTPSA id 6-20020a05600c22c600b0040303a9965asm11804891wmg.40.2023.10.08.15.49.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 15:49:26 -0700 (PDT)
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
	davem@davemloft.net,
	rrameshbabu@nvidia.com,
	shuah@kernel.org
Subject: [PATCH net-next v5 0/6] ptp: Support for multiple filtered timestamp event queue readers
Date: Mon,  9 Oct 2023 00:49:15 +0200
Message-Id: <cover.1696804243.git.reibax@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
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

 drivers/ptp/ptp_chardev.c                   | 129 ++++++++++++++++----
 drivers/ptp/ptp_clock.c                     |  45 ++++++-
 drivers/ptp/ptp_private.h                   |  28 +++--
 drivers/ptp/ptp_sysfs.c                     |  13 +-
 include/linux/posix-clock.h                 |  22 ++--
 include/uapi/linux/ptp_clock.h              |   2 +
 kernel/time/posix-clock.c                   |  36 ++++--
 tools/testing/selftests/ptp/ptpchmaskfmt.sh |  14 +++
 tools/testing/selftests/ptp/testptp.c       |  19 ++-
 9 files changed, 248 insertions(+), 60 deletions(-)
 create mode 100644 tools/testing/selftests/ptp/ptpchmaskfmt.sh

Signed-off-by: Xabier Marquiegui <reibax@gmail.com>
Suggested-by: Richard Cochran <richardcochran@gmail.com>
Suggested-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
---
v5:
  - fix spelling on commit message
  - fix memory leak on ptp_open
v4: https://lore.kernel.org/netdev/cover.1696511486.git.reibax@gmail.com/
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

