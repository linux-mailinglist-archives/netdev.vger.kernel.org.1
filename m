Return-Path: <netdev+bounces-116378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E888394A418
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 11:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD6C9B2927A
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF4A41CCB28;
	Wed,  7 Aug 2024 09:17:15 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43A31C8245;
	Wed,  7 Aug 2024 09:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723022235; cv=none; b=KZL62ZGK2NC884r3BkubyvV55syIUzCURezALDLidTqydspVHTsFk1cAmaGmmGmH6/jUyLR4SeM6tMxmcyQF81cNz9vhwHxpjrgN+34P3JzOPa9dHBHxRG2ncb+H1GpHDeHhXqekXz7mTEb+211bvXq5ycERGC++gzP9f18YDZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723022235; c=relaxed/simple;
	bh=3e+vHqi+9lGms/J7VdIUNzaJqPVVYb4q/s3IB2R546g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bo/z0ZJj3ZUFNw90SLffYCiZ3YEsIb9BnrDJfxi2AaVK5dQ1AMoUr4ftw37VDoCes0sH7nTEv8nkHn8BIYOa1RCEoassdlVVFdo29/AWMz4Kny9RRFHIIZhB2ZkHG8LoXkoAw7fAlV+0l/dxT2FAKwLrcz9Meeg3gQgV4/JiQKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a7ac469e4c4so113086166b.0;
        Wed, 07 Aug 2024 02:17:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723022232; x=1723627032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bf26F/9A9E4kz+Y75NOFq4Jn25o57n/ul71pdkaicr8=;
        b=GTZQ4dCJuTjemdH5WWM7/hFRu3Vv87uL1Ul29MZoVR1SELAMmLxKZmhRucKm4Bjd4F
         giUCYB9Ze7p9vbRTokqR03HH3OgNFX6ylkD2T5UJYims7KBJx6CHbjN6TJB2lfDfs5UF
         fweRfodr+r2wY93guC++wucaU5ZVSCsNX4KejHSBxqabyASjcqGL0K+krz4pGO1bWRH3
         NqPJrg89RRAIvG1J0/nQjQ0BFrAAQXrP12ZUtBXK8uFY2b1yiVjw3qImQXk99CTX+Vgb
         wqoBVNehtAfyaLRoFnErXNJ4wB1l3duZJsNltLD+76dGGFdWhK5wBNus3LZz9S7IC1k2
         sCzQ==
X-Forwarded-Encrypted: i=1; AJvYcCVLhQJDOjVVINKmN1ztoM/9LmiDhfqZZa+qtQg9kwbJl2/B2h4ojzBILxMDC6KTmo4RUprSz8nnGmb84dFpBuDhKoRpke3KEAEs1v4ZgGFAMRblnVS4h9rrJXjKuH+81dBS+lC7
X-Gm-Message-State: AOJu0YzVTZk4PvXZwfL724tDZrmrQFPUF1uWnjSljghIhK32BazbwNrq
	0YlDtG6X5njyPLEvM0LzhuI1PAnh5y5ql5mxiSYuBif18ttHfAsT
X-Google-Smtp-Source: AGHT+IGEePJIL7rxrPd2G7hGtahmgWDdy0/uyZavyu8WsDIaLl8mfydGtKE1y5GgXEfm2frvmBbT0g==
X-Received: by 2002:a17:907:806:b0:a7a:bae8:f2b5 with SMTP id a640c23a62f3a-a807916ffafmr122303966b.36.1723022231632;
        Wed, 07 Aug 2024 02:17:11 -0700 (PDT)
Received: from localhost (fwdproxy-lla-007.fbsv.net. [2a03:2880:30ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9ec4a8dsm619420066b.190.2024.08.07.02.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 02:17:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thevlad@fb.com,
	thepacketgeek@gmail.com,
	riel@surriel.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	davej@codemonkey.org.uk
Subject: [PATCH net-next v2 0/5] net: netconsole: Fix netconsole unsafe locking
Date: Wed,  7 Aug 2024 02:16:46 -0700
Message-ID: <20240807091657.4191542-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem:
=======

The current locking mechanism in netconsole is unsafe and suboptimal due
to the following issues:

1) Lock Release and Reacquisition Mid-Loop:

In netconsole_netdev_event(), the target_list_lock is released and
reacquired within a loop, potentially causing collisions and cleaning up
targets that are being enabled.

	int netconsole_netdev_event()
	{
	...
		spin_lock_irqsave(&target_list_lock, flags);
		list_for_each_entry(nt, &target_list, list) {
			spin_unlock_irqrestore(&target_list_lock, flags);
			__netpoll_cleanup(&nt->np);
			spin_lock_irqsave(&target_list_lock, flags);
		}
		spin_lock_irqsave(&target_list_lock, flags);
	...
	}

2) Non-Atomic Cleanup Operations:

In enabled_store(), the cleanup of structures is not atomic, risking
cleanup of structures that are in the process of being enabled.

	size_t enabled_store()
	{
	...
		spin_lock_irqsave(&target_list_lock, flags);
		nt->enabled = false;
		spin_unlock_irqrestore(&target_list_lock, flags);
		netpoll_cleanup(&nt->np);
	...
	}


These issues stem from the following limitations in netconsole's locking
design:

1) write_{ext_}msg() functions:

	a) Cannot sleep
	b) Must iterate through targets and send messages to all enabled entries.
	c) List iteration is protected by target_list_lock spinlock.

2) Network event handling in netconsole_netdev_event():

	a) Needs to sleep
	b) Requires iteration over the target list (holding
	   target_list_lock spinlock).
	c) Some events necessitate netpoll struct cleanup, which *needs*
	   to sleep.

The target_list_lock needs to be used by non-sleepable functions while
also protecting operations that may sleep, leading to the current unsafe
design.


Solution:
========

1) Dual Locking Mechanism:
	- Retain current target_list_lock for non-sleepable use cases.
	- Introduce target_cleanup_list_lock (mutex) for sleepable
	  operations.

2) Deferred Cleanup:
	- Implement atomic, deferred cleanup of structures using the new
	  mutex (target_cleanup_list_lock).
	- Avoid the `goto` in the middle of the list_for_each_entry

3) Separate Cleanup List:
	- Create target_cleanup_list for deferred cleanup, protected by
	  target_cleanup_list_lock.
	- This allows cleanup() to sleep without affecting message
	  transmission.
	- When iterating over targets, move devices needing cleanup to
	  target_cleanup_list.
	- Handle cleanup under the target_cleanup_list_lock mutex.

4) Make a clear locking hierarchy

	- The target_cleanup_list_lock takes precedence over target_list_lock.

	- Major Workflow Locking Sequences:
		a) Network Event Affecting Netpoll (netconsole_netdev_event):
			rtnl -> target_cleanup_list_lock -> target_list_lock

		b) Message Writing (write_msg()):
			console_lock -> target_list_lock

		c) Configfs Target Enable/Disable (enabled_store()):
			dynamic_netconsole_mutex -> target_cleanup_list_lock -> target_list_lock


This hierarchy ensures consistent lock acquisition order across
different operations, preventing deadlocks and maintaining proper
synchronization. The target_cleanup_list_lock's higher priority allows
for safe deferred cleanup operations without interfering with regular
message transmission protected by target_list_lock.  Each workflow
follows a specific locking sequence, ensuring that operations like
network event handling, message writing, and target management are
properly synchronized and do not conflict with each other.


Changelog:

v2:
  * The selftest has been removed from the patchset because veth is now
    IFF_DISABLE_NETPOLL. A new test will be sent separately.

v1:
  * https://lore.kernel.org/all/20240801161213.2707132-1-leitao@debian.org/

Breno Leitao (5):
  net: netpoll: extract core of netpoll_cleanup
  net: netconsole: Correct mismatched return types
  net: netconsole: Standardize variable naming
  net: netconsole: Unify Function Return Paths
  net: netconsole: Defer netpoll cleanup to avoid lock release during
    list traversal

 drivers/net/netconsole.c | 173 ++++++++++++++++++++++++---------------
 include/linux/netpoll.h  |   1 +
 net/core/netpoll.c       |  12 ++-
 3 files changed, 118 insertions(+), 68 deletions(-)

-- 
2.43.5


