Return-Path: <netdev+bounces-116829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C29EB94BD5C
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 14:25:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3265BB23458
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 12:25:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29EA18C937;
	Thu,  8 Aug 2024 12:25:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E2518C352;
	Thu,  8 Aug 2024 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723119927; cv=none; b=IrCoEZowTOSp9Nx5+09CTRpmkB02vV8Uj+lykfSPjatMC5ifb2kpRVByjKd7yj96EGaFEtpLVXFKoutwa2TQzb7xs0YyY13n/vLdeTjWGNLXiKwMwatjjh2GzYC3O4GNfapZG7S5zPxyfsuD43QZOqSXAAmQWAwiKhQsBbtAlnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723119927; c=relaxed/simple;
	bh=cW9OfGPuYV97rht9Ak7z0CkdDfyErDEpb911lmEV3Kw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TDsx8vP2wZFFUcrkHh6H3FTVIyxHAYFKPEzE7/sSvilgejKQVFLyNPyLqJJq+7LWSPVj7NLsJzqnx/AGQ6yPNxcWdJHKXiEtwkoLrbaVYTZR6aCZLvexacz8x7vim1jZP0gp5JGAAO5oiWsBba7E2Zlve9tra4bEDG2C6ctgSw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a1c49632deso942287a12.2;
        Thu, 08 Aug 2024 05:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723119924; x=1723724724;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=15cBkzLbG6bDjzde0nepIYkE92TldIJ/ekzz5J06BOY=;
        b=FopBoCzbaFfMFB0SeTpoCp/EDtBSbAayxb+Leg9kSn7ecOmDmn4xHTS5w/sj7CJ4X0
         S8ir/ZR3ys4rR/3WH3fMqBARpYkAvbxKqYbDaez34RDUsbAYT5WhVBTTAhCyOBxraYqH
         eZn/SZe10Croq3nHSa+Hs3IXhalBwPPd/VLeAtn1dIwZmG+WKRI8oTZjHxfyTV75Mfor
         oTaxdiuXRNeDhTiiaNrNTC0myRujWwhhmSFOp33r8l4HuTtNVcJmboV87Cc0dy7fH66y
         JPV+NWRgLkfl+w4lbud3dOOnTMx71ulN9dNor02P1cmFFaWpI2xX5C7At5hOU9eywyUN
         GDmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTHI5xC6Ej+VCH2wOpRG/r1luLOFchpD3Qq+O++fmpzIfzEIrbV4+ZvbD3vPKbdYO1+2BBFrzPc6O03NS6sVN1OxUVi8np6WPPo2Nkd6sBzdhQmFmRaxLtYcwM5/CxM4kgsF5n
X-Gm-Message-State: AOJu0YxtP8PPWsJaln5apPvqKE4zxBQB4Olql8AdmUwfZreSnvmkDBRT
	K9iScIvHjB/9RCWY1lbyV5oQUJQ50H37YYK6UqmjVmTrtqPTwvad
X-Google-Smtp-Source: AGHT+IGG382fHsKvFVTIXl84b1XkPVp7Rp2dxeoHhZpzEy1brL00pa8flwncBNBNOs9w5W/eGnv8Ww==
X-Received: by 2002:a05:6402:1d49:b0:58c:eee0:4913 with SMTP id 4fb4d7f45d1cf-5bbb233ee34mr1440975a12.27.1723119923809;
        Thu, 08 Aug 2024 05:25:23 -0700 (PDT)
Received: from localhost (fwdproxy-lla-011.fbsv.net. [2a03:2880:30ff:b::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bbb2bf95d9sm577341a12.10.2024.08.08.05.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Aug 2024 05:25:23 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: thepacketgeek@gmail.com,
	riel@surriel.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	paulmck@kernel.org,
	davej@codemonkey.org.uk
Subject: [PATCH net-next v2 0/5] net: netconsole: Fix netconsole unsafe locking
Date: Thu,  8 Aug 2024 05:25:06 -0700
Message-ID: <20240808122518.498166-1-leitao@debian.org>
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

v3:
  * Move  netconsole_process_cleanups() function to inside
    CONFIG_NETCONSOLE_DYNAMIC block, avoiding Werror=unused-function
    (Jakub)

v2:
  * The selftest has been removed from the patchset because veth is now
    IFF_DISABLE_NETPOLL. A new test will be sent separately.
  * https://lore.kernel.org/all/20240807091657.4191542-1-leitao@debian.org/

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


