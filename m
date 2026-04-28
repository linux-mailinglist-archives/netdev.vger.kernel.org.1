Return-Path: <netdev+bounces-281945-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6N0iFynS8GnDYwEAu9opvQ
	(envelope-from <netdev+bounces-281945-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:28:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DE5D487D54
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:28:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D35430ECC5F
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 15:18:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EBA039FCB4;
	Tue, 28 Apr 2026 15:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="HqRy3DiL"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-1.cisco.com (alln-iport-1.cisco.com [173.37.142.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81B553793D0
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389486; cv=none; b=SxonLmPFbNjYo9Uh1rEiDnzK3ajEwZEzTj2A0wJ+0o4cQUwVMNZH9o6/68KUvu6j+6rdy3Cl9I3XxuV+Q47tkC4WTvlomw5VKywI/z1Lpi88C7kKYrwCT6Cv5YlEmqjTyHRi8I4ko79JQSbq+VydoQD1Ldwl9tTjenKr9o9FjZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389486; c=relaxed/simple;
	bh=S5929zWErGM/tIRNdkb61VAXR1zUXL05Jyyv0rDozQE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nhWkeRIhyPnFFmX7ygTF5irIsOraOhutn8CahVUhdsyhjLr5/5oHAzhdMdP+QuClJKTYzdV1R5x0smSAj6q2/+J+j4ltdo2Ki55Npuess2ByLJ6gWRJBYyrRZMtw2lR8LQIjS7nCaUcV71x75JVvdSj+DDZsItUx1GMIJkVQX7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=HqRy3DiL; arc=none smtp.client-ip=173.37.142.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1016; q=dns/txt;
  s=iport01; t=1777389483; x=1778599083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=P4gqXWoMRLYCKhdcRf8k183VKWHh2WPzSSuvO5wezUA=;
  b=HqRy3DiLH5KtoCc2P9lTg+TOgzZ9gNeM8NuKvwNZThCy2nWpgpx0zHm4
   7eVrOHNfOomiUH5thlboJJNIjQ3zG7vqmbmyDE3PcTAbx9fY1otojOHpT
   El9DBNvOWA0Y+ujhWyu0t0plk7i6fUnfgKZZRopfkm9dPeuscI+pEw9Jt
   eDIZP8kMD6IVsQ+JgAzo9VCCh/eefZ86VrH8DLT0yzXM54wHpZAj+ue5K
   y3/9jrvfh4AqEIpchMqaD9U/C21dIzdnzM/qK7TScwNUWgFKwiYL9DEpf
   l25qBQ3OV0/ITP3mjW4wazyHtn4F88DHLsD0u35JyzW33g7q3uC0wT5zD
   w==;
X-CSE-ConnectionGUID: SHw2VDxnQDuSgZ2VHigp4w==
X-CSE-MsgGUID: oaSaAP3gTN2PNpee4c4zEQ==
X-IPAS-Result: =?us-ascii?q?A0BpBAAgzvBp/4//Ja1aHgE8DAILgWWDSF5DSZZLnh2Bf?=
 =?us-ascii?q?w8BAQEPRA0EAQGFBo0zAiY2Bw4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFA?=
 =?us-ascii?q?QEBAgEHBYEOE4ZPDYZdNgFGKYEUgxUBgnMDEQa4L4IsgQGDYgEMD3/ZQ4FqB?=
 =?us-ascii?q?oFNhXKHaYEPhF8nG4FJRIQOMYFDAYFbAQEBAYgiBIINFYEOggOMbUiBHgNZL?=
 =?us-ascii?q?AFVEw0KCwcFgWYDNRIqFW4yHYEjPheBDBsHBYFLgx5taoEGhGB4IywDGwMLG?=
 =?us-ascii?q?A1IESwUIxQbBD5uB4oTGR4Pgi+BDikCc3goApQQkXuhDoQmBYFfijqVOhozh?=
 =?us-ascii?q?ASUFZJSmQaIc4UWllCEaIFvATSBWTMaCBsVgyIfNBkPjjiDa4JZgX/BLSEmM?=
 =?us-ascii?q?j0CBwIHDQMLk2UBAQ?=
IronPort-Data: A9a23:JZa9YaKBHElynN13FE+Rh5QlxSXFcZb7ZxGr2PjKsXjdYENShjwDz
 zccDz2OPfrcZGOgf9snPYq2/UoB7MCGnNBhHVEd+CA2RRqmiyZq6fd1j6vUF3nPRiEWZBs/t
 63yUvGZcoZsCCSa/kvxWlTYhSEU/bmSQbbhA/LzNCl0RAt1IA8skhsLd9QR2uaEuvDnRVnW0
 T/Oi5eHYgH9h2Qkajt8B5+r8XuDgtyj4Fv0gXRmDRx7lAe2v2UYCpsZOZawIxPQKqFIHvS3T
 vr017qw+GXU5X8FUrtJRZ6iLyXm6paLVeS/oiI+t5qK23CulQRuukoPD8fwXG8M49m/c3+d/
 /0W3XC4YV9B0qQhA43xWTEAe811FfUuFLMqvRFTvOTLp3AqfUcAzN1VLF5sA6EI/N9bHFpBx
 6YmCDECdkyc0rfeLLKTEoGAh+w5J8XteYdasXZ6wHSBU7AtQIvIROPB4towMDUY358VW62BI
 ZBENHw2ME+ojx5nYj/7DLollfupnXn8cxVTqUmeouw85G27IAlZj+O2a4OKIYXULSlTtkGRn
 Wvvxz/2PjdADPqHxDfZ+S6+q9aayEsXX6pXTtVU7MVCg0CZz0QQBQcQWF/9puO24ma4Vs5TJ
 lI85CUjt+4x+VatQ927WAe3yENopTYGUNZWVul/4waXx++MvUCSB3MPSXhKb9lOWNIKeAHGH
 2Shx7vBbQGDepXOIZ5B3t94dQ+PBBU=
IronPort-HdrOrdr: A9a23:O7xpl6j11sd9TUdCkisj6IzA53BQXu4ji2hC6mlwRA09TyVXra
 yTdZMgpH3JYVkqNk3I9errBEDiewK+yXcW2+gs1N6ZNWGMhILCFu5fBOXZrgEIYxefysdtkY
 F9bqN5FNr8SXJ+jcr8/U2ENuxI+qjjzEht7t2uqEuEimpRGsVd0zs=
X-Talos-CUID: 9a23:Y7zguG1PpzPZ2vXEL+Hd0bxfIeA6KEPx3HHpD1KDBlQzdp2URkfM5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3ARnNICw9cBdp0CQPn0aIsKQ2Qf8Bh2K2HMBsCrbN?=
 =?us-ascii?q?cg++cOCEsMGuPoQ3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.23,204,1770595200"; 
   d="scan'208";a="733317316"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-1.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Apr 2026 15:17:56 +0000
Received: from satishkh-l-mj0bbv6x.cisco.com (unknown [10.25.128.216])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTPS id CED46180000B5;
	Tue, 28 Apr 2026 15:17:55 +0000 (GMT)
From: Satish Kharat <satishkh@cisco.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	satishkh@cisco.com
Subject: Recommended local LLM-assisted review for netdev submissions?
Date: Tue, 28 Apr 2026 08:17:55 -0700
Message-ID: <20260428151755.1310712-1-satishkh@cisco.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-Client-TLS: ANONYMOUS;unknown [10.25.128.216];TLSv1.3;TLS_AES_256_GCM_SHA384;256
X-Outbound-SMTP-Client: 10.25.128.216, [10.25.128.216]
X-Outbound-Node: rcdn-l-core-06.cisco.com
X-Rspamd-Queue-Id: 9DE5D487D54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[cisco.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[cisco.com:s=iport01];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281945-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[satishkh@cisco.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[cisco.com:+];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cisco.com:dkim,cisco.com:mid]

Hi Jakub,

I'm the author of the in-flight enic SR-IOV series. Before posting
revisions I run checkpatch --strict, make W=1 C=1 on touched files,
scripts/kernel-doc -none, and `b4 prep --check`.

I've read Jesse's Netdev 0x18 talk on AI-enhanced reviews [1], the
LWN coverage [2][3], and looked at sashiko [4]. What I haven't been
able to tell from the public material:

  - Is sashiko (or a successor) what's currently producing the
    LLM-style review replies showing up on netdev, or is that a
    different pipeline?
  - For contributors who'd like to self-review with the same
    prompt/ruleset before posting, is there a recommended setup,
    or is sashiko-as-is the closest thing today?

Happy with a one-line pointer if it's already documented somewhere
I missed.

Thanks,
Satish

[1] https://netdevconf.info/0x18/sessions/talk/ai-enhanced-reviews-for-linux-networking.html
[2] https://lwn.net/Articles/987319/
[3] https://lwn.net/Articles/1032612/
[4] https://github.com/sashiko-dev/sashiko

