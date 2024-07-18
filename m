Return-Path: <netdev+bounces-112114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0A29351D4
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 20:44:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B5FC1F218A1
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 18:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE40F14535F;
	Thu, 18 Jul 2024 18:43:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF2142045;
	Thu, 18 Jul 2024 18:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721328205; cv=none; b=b3ct02GbmHlPEWvZywtvKaqwkkg6zl8hZcLzdADrga8TPVEf9IOVdeCkIIhsOCXAMBOZnTb2AOLafntr6FZDmoIQtcC8EJDHxQ+mrf6jii+1SgEZ0suN+Y7TDI1kvQ+KQOmAZd1PVXcY3H0x+AArgiQ0kpiJYivNWTGVToB0nms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721328205; c=relaxed/simple;
	bh=1Re9CUu3Zgl6HOcJ0eBT7+tO+vZjwrWPLNQ3FHEOgXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DHhQBKayQXo4zzOQGGC6GAHgCWioTpVzgFRTNlnZ27Uqj/Y7M8r4vso10KpEtERkiDqSogLQuVhV5M9zxJ77RwmdoSnXpvbRLgtM7lF03jFjDjNTm/AnU1SNnoza5mrIuJIHWe0B3sVZTKLrt0wti/wDGXzRqpLMQYVwU6qPZsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5a156556fb4so155831a12.3;
        Thu, 18 Jul 2024 11:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721328202; x=1721933002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7ntRMJH4jqT8CtnIxoH8FmM7SbCkrJsPjFbgTogdVKM=;
        b=ndx1MAhYxkFIMqrgMsNOFlEtsxY3uAQ7H82qNTAAdCN4hIkodkmSsnXWK25mnNPOhs
         GkNLcfbEJNV13HdJMTlnwkDH6aD3KNXaUAP5dFNX8llKC/JciqCHOioFD7bK1J+wF+M0
         Yo5GC1+ihavtqlnAOZu0PTm5cAgoJxXz9O0IzQ28D8NISbUj2dLEgaWZ0DqNHVhhMFYE
         hVQ6lpj2sBWgt1OYLWZisVl7PR47DM/lRXazILXed5poMDbyLlEJcb8wqXKlqfhhQPao
         bCQUUkgzRuReE36YNyOAJ0haGZnxdHz5CFl9X5gxLqsPYlEPNEHeeRrEdhbIpqi3yVgF
         mLAA==
X-Forwarded-Encrypted: i=1; AJvYcCVZlKb+SJ6Vbgv1ENAD0ypACYLh9bwGk62mLEy1t939H1Umn9LdC78KFNaJqyNW+xYwnhufq/RB/iKzMEFbsu8ApTCI0Pa8T9v49XlDYd9CUBEMUEq3TxbEJbBBr2tDJ3aoK92b
X-Gm-Message-State: AOJu0Yxvr0SOV7H6eB1cuPjHbVmbkrd09ZUDRigmsWqYH7HnkrJV5vKt
	erfVt53Lgu180rcOFOLMeSm5RyLzYkckgOsbGtK1xLOks4cXptv4
X-Google-Smtp-Source: AGHT+IGc4SzT/c9z3l4E3IjIJFx+jKUyu9eorrV8iHfVJrN/70JY3gkk6Eg4hdVz3tCAlO0W5nGKUw==
X-Received: by 2002:a17:906:1756:b0:a79:c011:e0d0 with SMTP id a640c23a62f3a-a7a011ad77fmr365305066b.35.1721328202019;
        Thu, 18 Jul 2024 11:43:22 -0700 (PDT)
Received: from localhost (fwdproxy-lla-009.fbsv.net. [2a03:2880:30ff:9::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a79bc7f1d29sm589055466b.105.2024.07.18.11.43.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jul 2024 11:43:21 -0700 (PDT)
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
Subject: [RFC PATCH 0/2] netconsole: Fix netconsole unsafe locking
Date: Thu, 18 Jul 2024 11:43:04 -0700
Message-ID: <20240718184311.3950526-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Problem:
=======

The current locking mechanism in netconsole is unsafe and suboptimal due to the
following issues:

1) Lock Release and Reacquisition Mid-Loop:

In netconsole_netdev_event(), the target_list_lock is released and reacquired within a loop, potentially causing collisions and cleaning up targets that are being enabled.

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

In enabled_store(), the cleanup of structures is not atomic, risking cleanup of structures that are in the process of being enabled.

	size_t enabled_store()
	{
	...
		spin_lock_irqsave(&target_list_lock, flags);
		nt->enabled = false;
		spin_unlock_irqrestore(&target_list_lock, flags);
		netpoll_cleanup(&nt->np);
	...
	}


These issues stem from the following limitations in netconsole's locking design:

1) write_{ext_}msg() functions:

	a) Cannot sleep
	b) Must iterate through targets and send messages to all enabled entries.
	c) List iteration is protected by target_list_lock spinlock.

2) Network event handling in netconsole_netdev_event():

	a) Needs to sleep
	a) Requires iteration over the target list (holding target_list_lock spinlock).
	b) Some events necessitate netpoll struct cleanup, which *needs* to sleep.

The target_list_lock needs to be used by non-sleepable functions while also protecting operations that may sleep, leading to the current unsafe design.


Proposed Solution:
==================

1) Dual Locking Mechanism:
	- Retain current target_list_lock for non-sleepable use cases.
	- Introduce target_cleanup_list_lock (mutex) for sleepable operations.


2) Deferred Cleanup:
	- Implement atomic, deferred cleanup of structures using the new mutex (target_cleanup_list_lock).
	- Avoid the `goto` in the middle of the list_for_each_entry

3) Separate Cleanup List:
	- Create target_cleanup_list for deferred cleanup, protected by target_cleanup_list_lock.
	- This allows cleanup() to sleep without affecting message transmission.
	- When iterating over targets, move devices needing cleanup to target_cleanup_list.
	- Handle cleanup under the target_cleanup_list_lock mutex.

4) Make a clear locking hiearchy

	- The target_cleanup_list_lock takes precedence over target_list_lock.

	- Major Workflow Locking Sequences:
		a) Network Event Affecting Netpoll (netconsole_netdev_event):
			rtnl -> target_cleanup_list_lock -> target_list_lock

		b) Message Writing (write_msg()):
			console_lock -> target_list_lock

		c) Configfs Target Enable/Disable (enabled_store()):
			dynamic_netconsole_mutex -> target_cleanup_list_lock -> target_list_lock


This hierarchy ensures consistent lock acquisition order across different
operations, preventing deadlocks and maintaining proper synchronization. The
target_cleanup_list_lock's higher priority allows for safe deferred cleanup
operations without interfering with regular message transmission protected by
target_list_lock.  Each workflow follows a specific locking sequence, ensuring
that operations like network event handling, message writing, and target
management are properly synchronized and do not conflict with each other.

Tested wostly with https://github.com/leitao/netcons/blob/main/basic_test.sh

Breno Leitao (2):
  netpoll: extract core of netpoll_cleanup
  netconsole: Defer netpoll cleanup to avoid lock release during list
    traversal

 drivers/net/netconsole.c | 77 +++++++++++++++++++++++++++++++---------
 include/linux/netpoll.h  |  1 +
 net/core/netpoll.c       | 12 +++++--
 3 files changed, 71 insertions(+), 19 deletions(-)

-- 
2.43.0


