Return-Path: <netdev+bounces-150196-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB08C9E967B
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 14:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B55283D89
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 996E7222D6C;
	Mon,  9 Dec 2024 13:15:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QqqkEGV9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F741ACED3
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 13:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733750147; cv=none; b=WI4LV0cheSt9ut4F3W2/3AZE49mi9hMXwm+Ij8miJ0YlIUm0FwgXOmPy4l58Ci5PD+zJ/7V+Er9ZrapfSyptPGuxItWPBK9/HT7ftulYLjW0/Rp9fgD+suSdfuSeFr2kcF09ifv5Cb0nB3cWdc4U0m1OF1zgmLNWHQL4/pR/XDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733750147; c=relaxed/simple;
	bh=OfsSxi1ioU/l1gn0t70Nt6sTdN6Vx9XfWhlSAt3Qeho=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dmtV8xGitbNM60btALk5gbLPXcKsMbrUvQ6KOedPwC69fJl6RUHC5phXLTYpgsx09sk/EGJlm9cnoLYulnrNhelg9NaVUh0YTSFdd/+P0PGxl1shWl8TfGlbA3wBO0Y+FTxAbe/+oSf2B7sVCiowbyCzh3S8aaaUAjhek2K8wAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QqqkEGV9; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733750145; x=1765286145;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OfsSxi1ioU/l1gn0t70Nt6sTdN6Vx9XfWhlSAt3Qeho=;
  b=QqqkEGV9rV4oXX74nAP3kLuYthCQjg3n0RYaCa3LZwn3jxvqB3W9d7+5
   kbHz8CvUw0O6EKO4njjuw7pMys1sseXJaJ0tDjRe5FweG6CiTjmN890oj
   HGCOQnUAo1zmK/hU/PFu2dfpclzqgsB27V+fOP33V5lUFaej7RyqNZyYy
   guo64jb31J6R0cLvRq9ft652S/LRdSxIVSgQ5kFbTcNngVQvPkcIZwfwY
   dZ6J+ACkkxmuVPbA7c9OwsMVa+/JknmMmH/g2X8ZAEHkPItgMm1zdZ3hr
   UAJxix3zkna6oORdboumA8V1K6tYQLTLj8qXLx4pfx8TC0BReXqwa3taF
   w==;
X-CSE-ConnectionGUID: IN2JnEXXSEW53kZgp2LaeQ==
X-CSE-MsgGUID: IwZvtH3USu2pq9Bi+LGcbg==
X-IronPort-AV: E=McAfee;i="6700,10204,11281"; a="33387377"
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="33387377"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2024 05:15:26 -0800
X-CSE-ConnectionGUID: upH4BBDWQw6YKV0qsT03pg==
X-CSE-MsgGUID: dd1JiDxAQlmtXN0f/DQ3Qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,219,1728975600"; 
   d="scan'208";a="94934876"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa009.jf.intel.com with ESMTP; 09 Dec 2024 05:15:23 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: netdev@vger.kernel.org,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jiri@resnulli.us,
	stephen@networkplumber.org
Cc: anthony.l.nguyen@intel.com,
	jacob.e.keller@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [RFC 0/1] Proposal for new devlink command to enforce firmware security
Date: Mon,  9 Dec 2024 14:14:50 +0100
Message-ID: <20241209131450.137317-2-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RFC: Proposal for new devlink command to enforce firmware security

This RFC proposes addition of a new command to devlink API, providing a
mechanism to enforce secure firmware versions at the user's request. 
The primary goal is to enhance security by preventing the programming
of firmware with a lower security revision value. This feature is
particularly needed for Intel ice driver (and some other Intel drivers
next) but will be generic enough for other drivers to implement as well
for their purposes. Additionally, it proposes displaying the running
firmware security revision value and the set firmware minimum security
revision value in the output of the `devlink dev info` command for
Intel ice driver. 

Motivation

The E810 Ethernet controller provides a mechanism to prevent
downgrading to firmware versions containing known security
vulnerabilities. Specifically, the NVM components are signed
with a security revision, E810 ensures that components with
a lower security revision than the defined minimum cannot be loaded
onto the device.
Intel customers require that this action is not autonomous. Customers
typically uses this feature only in the target deployments after
finalizing testing of the new FW version. Autonomous action would
require manufacturer direct access to card to downgrade image to
previous stable version. By allowing the driver and user to manage the 
firmware security revision value, we can provide a flexible and secure
solution.
Additionally, displaying the current and minimum security revision
values in the `devlink dev info` command output will provide better
visibility and management for users.

Initial proposal for Minimum Security Revision update, via dedicated
parameter, was initially part of first devlink update deployment,
mechanism was questioned by community members [1]. However, Intel
still needs this functionality thus we are proposing a different
approach now to address the concerns raised previously. (In the last
community proposal, community proposed to make a decision based on
FW image - instead of dedicated parameter.)

Proposed design

New command, `devlink dev lock-firmware` (or `devlink dev guard-firmware`),
will be added to devlink API. Implementation in devlink will be simple
and generic, with no predefined operations, offering flexibility for drivers
to define the firmware locking mechanism appropriate to the hardware's
capabilities and security requirements. Running this command will allow
ice driver to ensure firmware with lower security value downgrades are
prevented.

Add also changes to Intel ice driver to display security values
via devlink dev info command running and set minimum. Also implement
lock-firmware devlink op callback in ice driver to update firmware
minimum security revision value.


Example usage:

$ devlink dev info pci/0000:b1:00.0

pci/0000:b1:00.0:
  driver ice
  serial_number 00-01-00-ff-ff-00-00-00
  versions:
      fixed:
        fw.mgmt.min.srev 8
        fw.undi.min.srev 8
      running:
        fw.mgmt.srev 9
        fw.undi.srev 9
        

$ devlink dev lock-firmware pci/0000:03:00.0

WARNING: This action will prevent downgrades to versions with lower the
security version Are you sure you want to lock the firmware on device %s?. (y/N)
>y

$ devlink dev info pci/0000:03:00.0

pci/0000:03:00.0:
  driver ice
  versions:
      fixed:
        fw.mgmt.min.srev 9
        fw.undi.min.srev 9


This feature is essential for the `ice` Ethernet driver (and other
Intel drivers next) but is designed to be generic for other drivers
to implement. Feedback and suggestions are welcome.

[1] https://lore.kernel.org/netdev/20210203124112.67a1e1ee@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/T/#u


Martyna Szapar-Mudlaw (1):
  devlink: add new devlink lock-firmware command

 include/net/devlink.h        |  2 ++
 include/uapi/linux/devlink.h |  2 ++
 net/devlink/dev.c            | 13 +++++++++++++
 net/devlink/netlink_gen.c    | 18 +++++++++++++++++-
 net/devlink/netlink_gen.h    |  4 +++-
 5 files changed, 37 insertions(+), 2 deletions(-)

-- 
2.47.0


