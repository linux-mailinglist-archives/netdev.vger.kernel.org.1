Return-Path: <netdev+bounces-287751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGwNHeYOBWrcRwIAu9opvQ
	(envelope-from <netdev+bounces-287751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:53:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C8553C257
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 01:53:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 405B830136AC
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 23:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858263CC327;
	Wed, 13 May 2026 23:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OGfgBQae"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F842D29C8
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 23:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778716387; cv=none; b=QJeCuDQYlrPvfOnhcQfv4Z7t408fD5mCYLVaeRQATJnazNxd0yNzNBb7D67EyccsIMPSohV8HSRJ/YT0tfaxJ4UvrpFOoWYAduGoUjR0W40Mp4mT3RdewDFr51NBCsTrj3hTTWUn+nrdlD679wp9X4opKHcwmUXN8fd7lGOyex8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778716387; c=relaxed/simple;
	bh=0gQKUOWRFCHFEXWMgOwPi1lRiFrKxliXZKk8yZyJNWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8teNdPhcuXUlh+Tf/W9lL/1DYLtFcup3/OP5Tst32upzC7Jg7zqX8ZL1hIrT/0SeJF/jhsMlVpDwO4KTinllJkxWodUyNAws5C1WDF+rHjK8wVOS4SChcgXbc5yZPqB9nK/+CZuQejHpJjYlzloWAE3aTQgIz6eXAJawDDye4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OGfgBQae; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1778716386; x=1810252386;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0gQKUOWRFCHFEXWMgOwPi1lRiFrKxliXZKk8yZyJNWM=;
  b=OGfgBQaepJ9JlEWxwTkURhVBDdkEfuDAMrIBuGgV4nKJgM4KvBGEWC6C
   P8hpDmBeeja9ejY1GmFVZxHxIkL/IhH37M0tA6ZRwmBGOFdXHP9H2b+mY
   Brsum5BeQc5ismaHZzFwaiWg3RnPKYZXhlrMXSAD80HOa3jYA1UhsaekL
   qqcPoatup1llsM/61wNyA4MxYtdm7oMJy9i9liWQWeaMKyxvdkKP8Fr3+
   5NFRpQnxCodqW3lzkWGn7A3XrfB+2w1ZR/NgoW6NtMaaGlxviA6OI6gyX
   kthDB5Gouc49Wor7gkjCoN6ynzDVf1XtfkVrDfN8Gi4JgA1tX+gIhAm9k
   w==;
X-CSE-ConnectionGUID: B4fm2WKgRrqCs6bydxvQJg==
X-CSE-MsgGUID: GMOBchDMQU+VEf53ncLpLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11785"; a="78799223"
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="78799223"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 16:53:05 -0700
X-CSE-ConnectionGUID: tCemc5wKRrG+PeePlDaJaw==
X-CSE-MsgGUID: foyqgXBUQj6+80Nam2tavg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,233,1770624000"; 
   d="scan'208";a="276319925"
Received: from dmert-dev.jf.intel.com ([10.166.241.33])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2026 16:53:04 -0700
From: Dave Ertman <david.m.ertman@intel.com>
To: cratiu@nvidia.com
Cc: andrew+netdev@lunn.ch,
	cjubran@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	gal@nvidia.com,
	horms@kernel.org,
	jiri@resnulli.us,
	kuba@kernel.org,
	leonro@nvidia.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com
Subject: Re:net-shapers plan
Date: Wed, 13 May 2026 16:53:26 -0400
Message-ID: <20260513205326.2571971-1-david.m.ertman@intel.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
References: <d9831d0c940a7b77419abe7c7330e822bbfd1cfb.camel@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E9C8553C257
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-287751-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[intel.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[14];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[david.m.ertman@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

On 3/6/2025 6:03 AM, Cosmin Ratiu wrote:
> Hello,
> 
> This (long) email presents a plan agreed with Simon and Paolo for
> extending net-shapers with use cases currently serviced by devlink-
> rate. The goal is to get net-shapers to feature parity with devlink-
> rate so that the amount of code dedicated to traffic shaping in the
> kernel could eventually be reduced significantly.
> 
> This is in response to Jakub's concerns raised in [3] and [4].
> 
> Context
> -------
> devlink-rate ([1]) can control traffic shaping for a VF / VF group and
> is currently implemented by the Intel ice and NVIDIA mlx5 drivers. It
> operates either on devlink ports (for VF rates) or on devlink objects
> (for group rates). Rate objects are owned by the devlink object.
> 
> net-shapers ([2]) is a recently added API for shaping traffic for a
> netdev tx queue / queue group / entire netdev. It is more granular than
> devlink-rate but cannot currently control shaping for groups of
> netdevs. It operates with netdev handles. Stores the shaping hierarchy
> in the netdevice.
> 
> [3] & [4] add support to devlink-rate for traffic-class shaping, which
> is controlling the shaping hierarchy in hardware to control the
> bandwidth allocation different traffic classes get. The question is how
> to represent traffic classes in net-shapers.

[ ... ]

> 3. Extend NODE scope to group multiple netdevs and new DEVLINK binding
> Today, all net-shapers objects are owned by a netdevice. Who should own
> a net shaper that represents a group of netdevices? It needs to be a
> stable object that isn't affected by group membership changes and
> therefore cannot be any netdev from the group. The only sensible option
> would be to pick an object corresponding to the eswitch to own such
> groups, which neatly corresponds to the devlink object today.

Will you be using two sets of _ops structs?

One for the netdev (ndo_shaper_ops) when the scope is meant to target a
VF handling its own sub-tree, and another for devlink
(devlink_ops .rate_*) for when the scope is for the hypervisor managing
its netdevs?

DaveE

