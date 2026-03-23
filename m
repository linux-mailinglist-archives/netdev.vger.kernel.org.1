Return-Path: <netdev+bounces-270406-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iP8ZGA/8wGkwPAQAu9opvQ
	(envelope-from <netdev+bounces-270406-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:38:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B60072EE576
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 09:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ED4E930293FC
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 08:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63CE137F754;
	Mon, 23 Mar 2026 08:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="gABfyvCn"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502236E465
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 08:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774254901; cv=none; b=g8uMMjdVAlQHS2ySHBgg2R+U51hgXRadO3bebTk85ubGXsHVj6V+TqF6pPLJCBgGZfkRO46sUQtX4+TKIhHekY9pFxukZnHsF6tcOG+lDks+rYnW4iISGinrWxHz1Ub8MN1f2ipcLOcY38NKT4UEpFrlETTWA5prmOP33IpwnFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774254901; c=relaxed/simple;
	bh=mhROmrTWjmiM2VGHpNJSL5zDOAijqhsMC54pZB8lmbA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n8Nn+uemPwTBnphUdMvZlAcSq2cp/njAo2ZkcaKQhDJoGwgk4KQpqmr2zWU+PfVZZu7B0VZP3ijJ6Mc5YbDoCs8SDuQpai2XNnGK2wXtwEOG+wT3t7yw2Xk7QnRHViReRJNsBwH/zWBvnirNlARW9Qg+RFaavYReYTxt0iNPL0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=gABfyvCn; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id DF5792068C;
	Mon, 23 Mar 2026 09:34:50 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0kMd40-bJ5as; Mon, 23 Mar 2026 09:34:50 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 2A6F5205ED;
	Mon, 23 Mar 2026 09:34:50 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 2A6F5205ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1774254890;
	bh=n3LC1ifBp4PW6vhcowlTAYwrWwVJrxflaoiVxAhJO0A=;
	h=From:To:CC:Subject:Date:From;
	b=gABfyvCnFZw1AOVYQ1/lV6llwqcFAUxQrIH5MA2ARFGsGjB30fHeehD6PcSuudcFa
	 kmu7YsX0blxGsGSRsytj82DSVz0wTJ+a58gRfu+qAwJN3pxvpgHhLS0OvIWWye9ydh
	 dMyHduELgLaZ8ZHQwjGG2bwOVC40dzQpq+l8r2yE8ZOzMNM9cQYwB4uX6Xi/fwaZjD
	 ihFouPIYZ7ZQvTUvlkhjo0smAP2vvglaXBgY+ecSUUXp+aaSxxtNsgWT9dbY15L4R8
	 KggeJ+TmAbUM3LwcD5iX6cwtsvlzKKXNRnctjvAZ1dv0UdgJnQwLM48c8vQguxzYuh
	 Uzwel7t8WIyKg==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 09:34:49 +0100
Received: (nullmailer pid 2741796 invoked by uid 1000);
	Mon, 23 Mar 2026 08:34:49 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 0/20] pull request (net): ipsec 2026-03-23
Date: Mon, 23 Mar 2026 09:33:41 +0100
Message-ID: <20260323083440.2741292-1-steffen.klassert@secunet.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-270406-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,secunet.com:dkim,secunet.com:mid,policy_hthresh.work:url];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B60072EE576
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

1) Add missing extack for XFRMA_SA_PCPU in add_acquire and allocspi.
   From Sabrina Dubroca.

2) Fix the condition on x->pcpu_num in xfrm_sa_len by using the
   proper check. From Sabrina Dubroca.

3) Call xdo_dev_state_delete during state update to properly cleanup
   the xdo device state. From Sabrina Dubroca.

4) Fix a potential skb leak in espintcp when async crypto is used.
   From Sabrina Dubroca.

5) Validate inner IPv4 header length in IPTFS payload to avoid
   parsing malformed packets. From Roshan Kumar.

6) Fix skb_put() panic on non-linear skb during IPTFS reassembly.
   From Fernando Fernandez Mancera.

7) Silence various sparse warnings related to RCU, state, and policy
   handling. From Sabrina Dubroca.

8) Fix work re-schedule race after cancel in xfrm_nat_keepalive_net_fini().
   From Hyunwoo Kim.

9) Prevent policy_hthresh.work from racing with netns teardown by using
   a proper cleanup mechanism. From Minwoo Ra.

10) Validate that the family of the source and destination addresses match
    in pfkey_send_migrate(). From Eric Dumazet.

11) Only publish mode_data after the clone is setup in the IPTFS receive path.
    This prevents leaving x->mode_data pointing at freed memory on error.
    From Paul Moses.


Please pull or let me know if there are problems.

Thanks!

The following changes since commit 2f61f38a217462411fed950e843b82bc119884cf:

  net: stmmac: fix timestamping configuration after suspend/resume (2026-02-24 17:46:15 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/klassert/ipsec.git tags/ipsec-2026-03-23

for you to fetch changes up to d849a2f7309fc0616e79d13b008b0a47e0458b6e:

  xfrm: iptfs: only publish mode_data after clone setup (2026-03-17 11:43:14 +0100)

----------------------------------------------------------------
ipsec-2026-03-23

----------------------------------------------------------------
Eric Dumazet (1):
      af_key: validate families in pfkey_send_migrate()

Fernando Fernandez Mancera (1):
      xfrm: iptfs: fix skb_put() panic on non-linear skb during reassembly

Hyunwoo Kim (1):
      xfrm: Fix work re-schedule after cancel in xfrm_nat_keepalive_net_fini()

Minwoo Ra (1):
      xfrm: prevent policy_hthresh.work from racing with netns teardown

Paul Moses (1):
      xfrm: iptfs: only publish mode_data after clone setup

Roshan Kumar (1):
      xfrm: iptfs: validate inner IPv4 header length in IPTFS payload

Sabrina Dubroca (14):
      xfrm: add missing extack for XFRMA_SA_PCPU in add_acquire and allocspi
      xfrm: fix the condition on x->pcpu_num in xfrm_sa_len
      xfrm: call xdo_dev_state_delete during state update
      esp: fix skb leak with espintcp and async crypto
      xfrm: state: fix sparse warnings on xfrm_state_hold_rcu
      xfrm: state: fix sparse warnings in xfrm_state_init
      xfrm: state: fix sparse warnings around XFRM_STATE_INSERT
      xfrm: state: add xfrm_state_deref_prot to state_by* walk under lock
      xfrm: remove rcu/state_hold from xfrm_state_lookup_spi_proto
      xfrm: state: silence sparse warnings during netns exit
      xfrm: policy: fix sparse warnings in xfrm_policy_{init,fini}
      xfrm: policy: silence sparse warning in xfrm_policy_unregister_afinfo
      xfrm: add rcu_access_pointer to silence sparse warning for xfrm_input_afinfo
      xfrm: avoid RCU warnings around the per-netns netlink socket

Steffen Klassert (1):
      Merge branch 'xfrm-fix-most-sparse-warnings'

 include/net/netns/xfrm.h      |   2 +-
 net/ipv4/esp4.c               |   9 ++--
 net/ipv6/esp6.c               |   9 ++--
 net/key/af_key.c              |  19 ++++---
 net/xfrm/xfrm_input.c         |   5 +-
 net/xfrm/xfrm_iptfs.c         |  17 +++++--
 net/xfrm/xfrm_nat_keepalive.c |   2 +-
 net/xfrm/xfrm_policy.c        |  12 +++--
 net/xfrm/xfrm_state.c         | 116 +++++++++++++++++++++++-------------------
 net/xfrm/xfrm_user.c          |  32 ++++++++----
 10 files changed, 137 insertions(+), 86 deletions(-)

