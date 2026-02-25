Return-Path: <netdev+bounces-260797-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GEmzIqS5nmnwWwQAu9opvQ
	(envelope-from <netdev+bounces-260797-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:58:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E615D1947E9
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 09:58:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 07C113014673
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 08:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6697B3254AE;
	Wed, 25 Feb 2026 08:56:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0935E328B67
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 08:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772009765; cv=none; b=GxA4wgN9YlcCCREADhsBNkJzCDpD6WkpcrjsayoJQFtr5QwDTEJnCOfch2v+acRxqVf/yHxlLn3YDoQYHk1xdQJMes/UO3yMytqZx2u9xj9oKY81eqh8zpSTTse7YfjMcbvoU0PNZIZQir0byRybl9hn3pyh46mb+UT6vSmaOwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772009765; c=relaxed/simple;
	bh=V4B4XiiakSygtWbsYyaS8JURxSizAeL8QWgCE0YFrRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BzHnKrFbAVNbz9NTYiZVxTioBlqwN7ckwEMWpSmAq5ZBcTjXbmiZKV9bhZEN5tXUoS+QPE939exXNc7Eo5vZ5s45e22l2zIFTYyPn+tzXTAgonOO4k/+RcSycL+qmA0Lx20m/9SrzykcoHhHI8kooR00Qm9qGNdllSg5oo+rRvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Received: from kero.packetmixer.de (p200300c5970D83d820CE3bc4f6Cb317e.dip0.t-ipconnect.de [IPv6:2003:c5:970d:83d8:20ce:3bc4:f6cb:317e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id 274A6FA12C;
	Wed, 25 Feb 2026 09:46:18 +0100 (CET)
From: Simon Wunderlich <sw@simonwunderlich.de>
To: davem@davemloft.net,
	kuba@kernel.org
Cc: netdev@vger.kernel.org,
	b.a.t.m.a.n@lists.open-mesh.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 0/1] pull request: batman-adv 2025-05-09
Date: Wed, 25 Feb 2026 09:46:13 +0100
Message-ID: <20260225084614.229077-1-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[simonwunderlich.de : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sw@simonwunderlich.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	R_DKIM_NA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260797-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: E615D1947E9
X-Rspamd-Action: no action

Hi David, hi Jakub,

here is a bugfix for batman-adv which we would like to have integrated into net.

Please pull or let me know of any problem!

Thank you,
      Simon

The following changes since commit 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88:

  Merge tag 'net-next-6.19' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next (2025-12-03 17:24:33 -0800)

are available in the Git repository at:

  https://git.open-mesh.org/linux-merge.git tags/batadv-net-pullrequest-20260225

for you to fetch changes up to cfc83a3c71517b59c1047db57da31e26a9dc2f33:

  batman-adv: Avoid double-rtnl_lock ELP metric worker (2026-02-21 13:01:55 +0100)

----------------------------------------------------------------
Here is a batman-adv bugfix:

 - Avoid double-rtnl_lock ELP metric worker, by Sven Eckelmann

----------------------------------------------------------------
Sven Eckelmann (1):
      batman-adv: Avoid double-rtnl_lock ELP metric worker

 net/batman-adv/bat_v_elp.c      | 10 +++++++++-
 net/batman-adv/hard-interface.c |  8 ++++----
 net/batman-adv/hard-interface.h |  1 +
 3 files changed, 14 insertions(+), 5 deletions(-)

