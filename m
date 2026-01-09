Return-Path: <netdev+bounces-248508-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 686A7D0A78C
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 14:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8C520303A940
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 13:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C3733B6E8;
	Fri,  9 Jan 2026 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="ttBfvj7F"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C409635BDC9;
	Fri,  9 Jan 2026 13:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767965821; cv=none; b=Bb6JT/m8UJUc7nGeL/lW62lG8km922p4ugufpRm6RYRTsdLb0KJi4Q++Sel4Oi9P3KMb0pR+osT4Xpr8etuONkUYM7sZnjO25dG+8mQsBWkz15OwNfULVrso777pDyaA5vinexpS24Y0dBw4bUFEI7f/CIV1b2YLBiQYt4QTTOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767965821; c=relaxed/simple;
	bh=Fs4SDqeeT/V7jPIjc1DAJ9wt38YwsDAjRdC1YRYBLNI=;
	h=Date:From:To:CC:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Ynuq4/7RJ7fO+L9AmdXdE2w+3YiaijYIiK/Zk2jJxf4Gk3cLG2yrWMSj0lb3n2SL/jg8NMi2u+/Zy2r8Q1+d4ULCOKQCYGwpjOg2FMZbybxbG3UeCi4AiFPwWwvrHMtj/P/yObQMPvK0aycDhl6Ofbi4/OSsKohVUw452R0gpok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=ttBfvj7F; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 40FEC20842;
	Fri,  9 Jan 2026 14:30:00 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZRYpSB4ZY2jb; Fri,  9 Jan 2026 14:29:59 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id A2570206B0;
	Fri,  9 Jan 2026 14:29:59 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com A2570206B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1767965399;
	bh=nnPON5L6Q6BJnLFR23lfTFkl5lUz26kap1QWvH/dn18=;
	h=Date:From:To:CC:Subject:Reply-To:From;
	b=ttBfvj7FtT4llihZcFtlXsZe4NS7QGvzO+WhKR45S7cuIqK++dmRSpPuufFDSpQlY
	 uA72TG4vvO1b7iekImyqLGPWZrpMRe2m2roDZnnaCGLqN2/Bo9bLVOFgMSNK+uTadj
	 7zXiWJgokQHOeX5bkDaYzmfzfLBsIvD94NXZMoEBBCBXDRDwbht71/7xiAj7cc5K0O
	 Ygi0g82r948N/wu8UC3V2akkXuElUuMEV1bRur5H7T3bz7WYCPWLUPS6N8JZuoXxnL
	 ljAeBppmggyI4ZxvV6LaapEVEZWFUAJLfMdLtwNBfTgjc8Eaq1gdvlME/pL/aUAKlT
	 AUKv08zi/VvNQ==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 14:29:59 +0100
Date: Fri, 9 Jan 2026 14:29:52 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Steffen Klassert <steffen.klassert@secunet.com>, Herbert Xu
	<herbert@gondor.apana.org.au>, <netdev@vger.kernel.org>
CC: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <devel@linux-ipsec.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH ipsec-next 0/6] xfrm: XFRM_MSG_MIGRATE_STATE new netlink
 message
Message-ID: <cover.1767964254.git.antony@moon.secunet.de>
Reply-To: <antony.antony@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Precedence: first-class
Priority: normal
Organization: secunet
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)


    The current XFRM_MSG_MIGRATE interface is tightly coupled to policy and
    SA migration, and it lacks the information required to reliably migrate
    individual SAs. This makes it unsuitable for IKEv2 deployments,
    dual-stack setups (IPv4/IPv6), and scenarios where policies are managed
    externally (e.g., by other daemons than IKE daemon).

    Mandatory SA selector list
    The current API requires a non-empty SA selector list, which does not
    reflect IKEv2 use case.
    A single Child SA may correspond to multiple policies,
    and SA discovery already occurs via address and reqid matching. With
    dual-stack Child SAs this leads to excessive churn: the current method
    would have to be called up to six times (in/out/fwd × v4/v6) on SA,
    while the new method only requires two calls. While polices are
    migrated, first installing a block policy

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
    SA — with complete and unambiguous identification — is required.

    XFRM_MSG_MIGRATE_STATE provides that interface. It supports migration
    of a single SA via xfrm_usersa_id (including SPI) and we fix
    encap removal in this patch set, reqid updates, address changes,
    and other SA-specific parameters. It avoids the structural limitations
    of
    XFRM_MSG_MIGRATE and provides a simpler, extensible mechanism for
    precise per-SA migration without involving policies.

Antony Antony (6):
  xfrm: remove redundent assignment
  xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
  xfrm: rename reqid in xfrm_migrate
  xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration
  xfrm: reqid is invarient in old migration
  xfrm: check that SA is in VALID state before use

 include/net/xfrm.h          |   3 +-
 include/uapi/linux/xfrm.h   |  11 +++
 net/key/af_key.c            |  10 +--
 net/xfrm/xfrm_policy.c      |   4 +-
 net/xfrm/xfrm_state.c       |  41 ++++-----
 net/xfrm/xfrm_user.c        | 164 +++++++++++++++++++++++++++++++++++-
 security/selinux/nlmsgtab.c |   3 +-
 7 files changed, 206 insertions(+), 30 deletions(-)

--
2.39.5


