Return-Path: <netdev+bounces-293055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IDJQKxdcGWoLvwgAu9opvQ
	(envelope-from <netdev+bounces-293055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:27:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 598365FFEEC
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E35DF301437C
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:26:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1B83AC0FE;
	Fri, 29 May 2026 09:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="zr8uayx5"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FBD3BD62F
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 09:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780046817; cv=none; b=THwb2aWXx9H5iVCezM0pCkYqmeFIRj+DcuuQefDkrcLzo/JLmcnsVasEAh/eCLbaxnMDV/giCqDQi0yoeAPR38esvpGw6oXlOUq//020HXxOwXyRestNxgIzbVMTedxbp9ssINroCdpKwt0cBYPt9ItodywmRLVVRbiXo7RXmH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780046817; c=relaxed/simple;
	bh=jAY5KrxW2liHC8UUQOiPxZIjxqhN6UxpZeVvwNgEJLY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hFyrPJ3WPu9MQr5Ekkf7xhHB1TEwvBk4MPA0HrGA1p9k8C3ic4IuExsfyfCaCgJGah/D4STs4dvtjK6nyYdG+VwMHUlD2wGg8Gn9JNYf/FZrngTpzQD0PgqO2+QRJ0v3mN1gLtT/UVA+oE2ZAF2X0u0+9s0+jU44yd1fHHW3KqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=zr8uayx5; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 1209B2069C;
	Fri, 29 May 2026 11:26:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id brD1XX0zbAFY; Fri, 29 May 2026 11:26:52 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 50A8E2019D;
	Fri, 29 May 2026 11:26:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 50A8E2019D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780046812;
	bh=2/wriyp1dUX7/CSwEezM3t3SBJN/HdmdzNfVRdPEgds=;
	h=From:To:CC:Subject:Date:From;
	b=zr8uayx5s/nwFXao4EheH2wIaCMG1Y5DLXDpb7zTXSZEUgQ3bb/UJmTPFdYVvlafb
	 0CB40Yfbtpx02+cQr9j1cDoZFQCFentlvq4gHjtjbpgOpoqJWXPjricPKwJaE1uIto
	 dNnqxTisYZmcX5pdLlMCb46c4UfRjqXoWvzOrnRjkcG6COY5/E65/ElO6SOT4QRLvV
	 Lk9ivrJN2SvGg1zk7LfUXyrrbsZkekDHKNCclXlbUFZE/v/u6SjFiPh7eGkfVYKv6H
	 wlGxM6Vaf2WTRLw0KVFmOSyiJcdDW3+Ia/ENFnKDMRc+LHFIUEvaaLhy8dGPF47upa
	 eQARfonMRkosA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 29 May
 2026 11:26:51 +0200
Received: (nullmailer pid 3879686 invoked by uid 1000);
	Fri, 29 May 2026 09:26:51 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/10] pull request (net): ipsec 2026-05-29
Date: Fri, 29 May 2026 11:26:02 +0200
Message-ID: <20260529092648.3878973-1-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293055-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 598365FFEEC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

1) xfrm: route MIGRATE notifications to caller's netns
   Thread the caller's netns through km_migrate() so that
   MIGRATE notifications go to the issuing netns, fixing both the
   init_net listener leak and MOBIKE notifications inside
   non-init netns. From Maoyi Xie.

2) xfrm: ipcomp: Free destination pages on acomp errors
   Move the out_free_req label up so that allocated destination
   pages are released on decompression errors, not only on success.
   From Herbert Xu.

3) xfrm: Check for underflow in xfrm_state_mtu
   Reject configurations that cause xfrm_state_mtu() to underflow,
   preventing a negative TFCPAD value from becoming a memset size
   that triggers an out-of-bounds write of several terabytes.
   From David Ahern.

4) xfrm: ah: use skb_to_full_sk in async output callbacks
   Convert the possibly-incomplete skb->sk to a full socket pointer
   in async AH callbacks so that a request_sock or timewait_sock
   never reaches xfrm_output_resume() downstream consumers.
   From Michael Bommarito.

5) Add and revert: esp: fix page frag reference leak on skb_to_sgvec failure
   The patch does not fix te issue completely.

6) xfrm: esp: restore combined single-frag length gate
   Check the aligned post-trailer combined length against a page limit
   in the fast path, preventing skb_page_frag_refill() from falling
   back to a page too small for the destination scatterlist.
   From Jingguo Tan.

7) xfrm: iptfs: reset runtime state when cloning SAs
   Reinitialise the clone's mode_data runtime objects before
   publishing it, preventing queued skbs from being freed with
   list state copied from the original SA when migration fails.
   From Shaomin Chen.

8) xfrm: move policy_bydst RCU sync from per-netns .exit to .pre_exit
   Flush policy tables and drain the workqueue in a .pre_exit handler
   so that cleanup_net() pays one RCU grace period per batch instead
   of one per namespace, fixing stalls at high CLONE_NEWNET rates.
   From Usama Arif.

9) xfrm: input: hold netns during deferred transport reinjection
   Take a netns reference when queueing deferred transport reinjection
   work and drop it after the callback completes, keeping the skb->cb
   net pointer valid until the deferred work runs.
   From Zhengchuan Liang.


Please pull or let me know if there are problems.

Thanks!

The following changes since commit b266bacba796ff5c4dcd2ae2fc08aacf7ab39153:

  net: ethernet: cortina: Drop half-assembled SKB (2026-05-06 18:43:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-05-29

for you to fetch changes up to 6851161feb01cea41358c9ec304bd2f981fc8505:

  Revert "esp: fix page frag reference leak on skb_to_sgvec failure" (2026-05-29 10:23:25 +0200)

----------------------------------------------------------------
ipsec-2026-05-29

----------------------------------------------------------------
David Ahern (1):
      xfrm: Check for underflow in xfrm_state_mtu

Herbert Xu (1):
      xfrm: ipcomp: Free destination pages on acomp errors

Jingguo Tan (1):
      xfrm: esp: restore combined single-frag length gate

Maoyi Xie (1):
      xfrm: route MIGRATE notifications to caller's netns

Michael Bommarito (1):
      xfrm: ah: use skb_to_full_sk in async output callbacks

Shaomin Chen (1):
      xfrm: iptfs: reset runtime state when cloning SAs

Steffen Klassert (1):
      Revert "esp: fix page frag reference leak on skb_to_sgvec failure"

Usama Arif (1):
      xfrm: move policy_bydst RCU sync from per-netns .exit to .pre_exit

Zhengchuan Liang (1):
      xfrm: input: hold netns during deferred transport reinjection

e521588 (1):
      esp: fix page frag reference leak on skb_to_sgvec failure

 include/net/xfrm.h     |  3 ++-
 net/ipv4/ah4.c         |  2 +-
 net/ipv4/esp4.c        |  4 ++--
 net/ipv6/ah6.c         |  2 +-
 net/ipv6/esp6.c        |  4 ++--
 net/key/af_key.c       |  6 +++---
 net/xfrm/xfrm_input.c  | 16 ++++++++++++----
 net/xfrm/xfrm_ipcomp.c | 12 ++++++++----
 net/xfrm/xfrm_iptfs.c  | 28 +++++++++++++++++++++++-----
 net/xfrm/xfrm_policy.c | 17 +++++++++--------
 net/xfrm/xfrm_state.c  | 23 ++++++++++++++++++-----
 net/xfrm/xfrm_user.c   |  5 ++---
 12 files changed, 83 insertions(+), 39 deletions(-)

