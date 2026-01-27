Return-Path: <netdev+bounces-253802-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QGiDOK+XeGkWrQEAu9opvQ
	(envelope-from <netdev+bounces-253802-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:47:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 48008931C6
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 11:47:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6545C3046E8B
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 10:42:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F275E34251B;
	Tue, 27 Jan 2026 10:42:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="HDnZWQeH"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92B7342507
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 10:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769510532; cv=none; b=iOCFQmd0PfTXrrrRjNIUnk3QBvT5caDq1hayhLorTfGd4zSnqHOjtBZuquwfN/cBVRqCGEE1CE83lJdkVCT3wch+VBfvMKEkX+QqCDeplWcBWnv5LFxxyq1JiT1BVMbth7VxWAJ7bTtISk83/Z0tCvOcWTlbpT9syUIJsDCOZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769510532; c=relaxed/simple;
	bh=PtbfycW0DcpjnSd/15r9NHZqjFl99LPlD2D8HBRcd1w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TKRKzSwhoGduJpbPP6carEFGQU8mCeFd/3BQyaxwlTBqKPzduazJC8S0f84Ie7V4rWc6zhQkEZ+Mygc5/05BXYB1dWCfmDQE9ok/e7+ymGlqg28OIQXKpcGhZE5tGYJEYccCGFu4BM7uzqJq0I8ucg0QlDfutgOZwWltyVKIqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=HDnZWQeH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id CBB362006C;
	Tue, 27 Jan 2026 11:42:01 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id re0C1QFSNCbL; Tue, 27 Jan 2026 11:42:01 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id CC338206E9;
	Tue, 27 Jan 2026 11:42:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com CC338206E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1769510520;
	bh=HdE4GfM0yZ6SDqAqWJtgr4HfnoG5p+FZ6Ih0ST3h8io=;
	h=From:To:CC:Subject:Date:From;
	b=HDnZWQeH0G1YOegvFFIVDkOpXeix78Nt4B4ITSBBCVkx/QyWfJZ+u+gnV6OHrhBLC
	 81BBw4t63T2SjZEgzL2F9E3q7sy3qWBhhxm5dLgnsUZNAEklnK72oWx5VBQdtYjD9A
	 XKvzFAu5qy5UCwPlUBO+ZQs9RfntE4DrRuB1OXFJuH1z0QpcNT1AYPY+AVuOxTTKQd
	 E8fpqWvn8dvrXAq12IHBSuQvDYuSX2I7IFhq3Y4vzY3mEyz+wzEQ5CR2cB2WSSYVAz
	 2d94nkSNpC/PgQSsu/GVc5Sj/ezCexbu4OZjWYrulOA0b96zq2DDmvaxqRZp6Yiqym
	 hDbvb4bt/XNbA==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 27 Jan
 2026 11:41:59 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, <devel@linux-ipsec.org>
Subject: [PATCH ipsec-next v5 0/8] xfrm: XFRM_MSG_MIGRATE_STATE new netlink message
Date: Tue, 27 Jan 2026 11:41:41 +0100
Message-ID: <cover.1769509130.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-03.secunet.de (10.32.0.183) To EXCH-02.secunet.de
 (10.32.0.172)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253802-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:mid,secunet.com:dkim];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antony.antony@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 48008931C6
X-Rspamd-Action: no action

The current XFRM_MSG_MIGRATE interface is tightly coupled to policy and
SA migration, and it lacks the information required to reliably migrate
individual SAs. This makes it unsuitable for IKEv2 deployments,
dual-stack setups (IPv4/IPv6), and scenarios where policies are managed
externally (e.g., by daemons other than the IKE daemon).

Mandatory SA selector list
The current API requires a non-empty SA selector list, which does not
reflect the IKEv2 use case.
A single Child SA may correspond to multiple policies,
and SA discovery already occurs via address and reqid matching. With
dual-stack Child SAs this leads to excessive churn: the current method
would have to be called up to six times (in/out/fwd × v4/v6) on SA,
while the new method only requires two calls.

Selectors lack SPI (and marks)
XFRM_MSG_MIGRATE cannot uniquely identify an SA when multiple SAs share
the same policies (per-CPU SAs, SELinux label-based SAs, etc.). Without
the SPI, the kernel may update the wrong SA instance.

Reqid cannot be changed
Some implementations allocate reqids based on traffic selectors. In
host-to-host or selector-changing scenarios, the reqid must change,
which the current API cannot express.

Because strongSwan and other implementations manage policies
independently of the kernel, an interface that updates only a specific
SA - with complete and unambiguous identification - is required.

XFRM_MSG_MIGRATE_STATE provides that interface. It supports migration
of a single SA via xfrm_usersa_id (including SPI) and we fix
encap removal in this patch set, reqid updates, address changes,
and other SA-specific parameters. It avoids the structural limitations
of XFRM_MSG_MIGRATE and provides a simpler, extensible mechanism for
precise per-SA migration without involving policies.

New migration steps: first install block policy, remove the old policy,
call XFRM_MSG_MIGRATE_STATE for each state, then re-install the
policies and remove the block policy.

If the target SA tuple (daddr, SPI, proto, family) is already
occupied, the operation returns -EEXIST. In this case the original
SA is not preserved. Userspace must handle -EEXIST by
re-establishing the SA at the IKE level and manage policies.

Antony Antony (8):
  xfrm: add missing __rcu annotation to nlsk
  xfrm: remove redundant assignments
  xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
  xfrm: rename reqid in xfrm_migrate
  xfrm: split xfrm_state_migrate into create and install functions
  xfrm: add state synchronization after migration
  xfrm: add error messages to state migration
  xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration

 include/net/netns/xfrm.h    |   2 +-
 include/net/xfrm.h          |  60 ++++++++++--
 include/uapi/linux/xfrm.h   |  11 +++
 net/key/af_key.c            |  10 +-
 net/xfrm/xfrm_policy.c      |   5 +-
 net/xfrm/xfrm_state.c       | 119 +++++++++++++++---------
 net/xfrm/xfrm_user.c        | 180 +++++++++++++++++++++++++++++++++++-
 security/selinux/nlmsgtab.c |   3 +-
 8 files changed, 324 insertions(+), 66 deletions(-)
---
v1->v2: dropped 6/6. That check is already there where the func is called
    - merged patch 4/6 and 5/6, to fix use uninitialized value
    - fix commit messages

v2->v3: - fix commit message formatting

v3->v4: add patch to fix pre-existing missing __rcu annotation on nlsk
   (exposed by sparse when modifying xfrm_user.c)
v4->v5: add synchronize after migrate and delete it inside a lock
    - split xfrm_state_migrate into create and install functions

-antony

