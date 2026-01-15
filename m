Return-Path: <netdev+bounces-250021-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17852D22FEB
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 09:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1581D30050B7
	for <lists+netdev@lfdr.de>; Thu, 15 Jan 2026 08:04:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C7E532D0EA;
	Thu, 15 Jan 2026 08:04:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="NJWG18iH"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAF5225413
	for <netdev@vger.kernel.org>; Thu, 15 Jan 2026 08:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768464261; cv=none; b=TozoRLijvEPqpk5i2kLkZv45RsJsZvFKP8CDpMLxwN68eTXTW2NDiGQ+C80RDO249crdkvI8wmM8xzSoI+0LoRxHVojoETw2Rehqzm79vwxZBQuLQhQHZpV0EyNT86QpLBtJnqirjb54o/FfWFsxFUfQ3xVNwtBoJmsh6AU53a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768464261; c=relaxed/simple;
	bh=MI3D09lePoRNaxeYHU2xV61d/p1r8z4BRKNjbl4FPk0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fT6eXvQ7K98iIfMbqmxgNslnXMBOj72lK46tJwP8CXHw6vVmqAgxC8m5Z0yGmSQ2aO3jM8WxSk2R08BmNkk9oKK1m4mhOWimpf33rvQgEf1t54p5XXfmoyxVxBM/E3xo5vcaHi6NE5I1q5+6rGugnKq8DvEdJxJf5ZIt04gzWD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=NJWG18iH; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 24E4D208B2;
	Thu, 15 Jan 2026 09:04:16 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1GLx_PDHzjbM; Thu, 15 Jan 2026 09:04:15 +0100 (CET)
Received: from EXCH-02.secunet.de (rl2.secunet.de [10.32.0.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 78E1C20882;
	Thu, 15 Jan 2026 09:04:15 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 78E1C20882
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1768464255;
	bh=tissLtDg9HhSILgIRifK9mP7lyWoAnGQ2RYg3MyoiM8=;
	h=From:To:CC:Subject:Date:From;
	b=NJWG18iHY26GwJyi4+S3gnKXdWM5NsjRfc9vhLbnMYGJMl2Q2g7qy3Yp5/0naTAoO
	 bQrypGCWOt/4zV2EHNru29Y9R9W95bTbTittp9Rc4PDKnAH6+CxCoY8CHp3dFSOLLJ
	 dRwtubLCAdWxHkt3/ZV6uHiUQ36RPnGQ9/jLI9zlFqM2YjpnvUKMIPMOnmsC1ODnLT
	 hpfB+Kq/jjMQ5mlpbphKGDSJEqSRC7+qwriUa7cgGtUbIeTk3MrptJnNM/v5EkbJ2U
	 Vpe8o/qzENV3ZmWJcPN0SjIzPNJnMmGdW7x8ujjAijK2+N1aicc+DppitU+Jfw6Qi9
	 0f4myr2NmB1lg==
Received: from moon.secunet.de (172.18.149.1) by EXCH-02.secunet.de
 (10.32.0.172) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 15 Jan
 2026 09:04:14 +0100
From: Antony Antony <antony.antony@secunet.com>
To: Antony Antony <antony.antony@secunet.com>, Steffen Klassert
	<steffen.klassert@secunet.com>, Herbert Xu <herbert@gondor.apana.org.au>,
	<netdev@vger.kernel.org>
CC: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Chiachang Wang <chiachangwang@google.com>, Yan Yan
	<evitayan@google.com>, Shinta Sugimoto <shinta.sugimoto@ericsson.com>,
	<devel@linux-ipsec.org>
Subject: [PATCH ipsec-next v2 0/4] xfrm: XFRM_MSG_MIGRATE_STATE new netlink message
Date: Thu, 15 Jan 2026 09:03:34 +0100
Message-ID: <cover.1768462955.git.antony.antony@secunet.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-02.secunet.de
 (10.32.0.172)

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
of XFRM_MSG_MIGRATE and provides a simpler, extensible mechanism for
precise per-SA migration without involving policies.

Antony Antony (4):
  xfrm: remove redundant assignments
  xfrm: allow migration from UDP encapsulated to non-encapsulated ESP
  xfrm: rename reqid in xfrm_migrate
  xfrm: add XFRM_MSG_MIGRATE_STATE for single SA migration

 include/net/xfrm.h          |   3 +-
 include/uapi/linux/xfrm.h   |  11 +++
 net/key/af_key.c            |  10 +--
 net/xfrm/xfrm_policy.c      |   4 +-
 net/xfrm/xfrm_state.c       |  37 ++++----
 net/xfrm/xfrm_user.c        | 164 +++++++++++++++++++++++++++++++++++-
 security/selinux/nlmsgtab.c |   3 +-
 7 files changed, 200 insertions(+), 32 deletions(-)

--
2.39.5

---
v1->v2: dropped 6/6. That check is already there where the func is called
    - merged patch 4/6 and 5/6, to fix use uninitialized value
    - fix commit messages

thanks,
-antony


