Return-Path: <netdev+bounces-298000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tC1vFyhxKmqapQMAu9opvQ
	(envelope-from <netdev+bounces-298000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:26:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6E4F66FD5F
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 10:26:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b="d/vzkYul";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298000-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298000-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A26E331363F9
	for <lists+netdev@lfdr.de>; Thu, 11 Jun 2026 08:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E13379C22;
	Thu, 11 Jun 2026 08:25:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9549A349B02
	for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 08:25:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781166334; cv=none; b=WsiwtEGGR7limHoLzCG3pIVNLH806jVSH+9ZTX08qn0lu8hx26nA4VOzP5iEjs02+aaDP2WHYgQeRY+/ji+06buLTxIAHZxPELYZieMnbLUs/lzM0Fmfx93kwJ9lGUC+uvsfh94kcMR1X/kaW3/4GrcNqy3gruaEJZ9fckUJuz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781166334; c=relaxed/simple;
	bh=Q3NkdWXx04dk51bngFegpoq0D1jZnKePjwXk+F4IJD8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JOk6R6p6wv6gxnE6rX8BbYbxuXvaft52U6qLTQfBqPS2KI5WwJ12hj9M3h0Fao0oaUjjzmAovKPMeUs/L2/PYvyK7OdubJKZcKBX6QLlTPi94PcQO024eey0C+5awq6IjUf0jhxgBIyMCCA8SZK3EaTRBXY97luC7hVq+4iOxGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=d/vzkYul; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=TNuwlxs0Z48h2C9Bp+JpHM0jxx7cEqWS1ngd8I69KZM=; b=d/vzkYul6XU0Tv7e0uxNGVsMU9
	Ls0uxSpQmmctUADWqvly2kNO3t6cLhndOPlJuy3hlgm7Bjtm4EszHxPyEdcRjtQ+zfts6fwpZNPqF
	z54QxwydZCdov/AoljIbcO8u5nibxdt7yxcYY+PgSRSUvTM4uGDA5v7xdoodc9TacVOznrGlRSouH
	0rGMg/7mi7MAg7tSQjg29ff+bokQ2EKMMcvGBN9NkHQNrCNPAxwNiNpkgjd4j2+alNR5Ltl6bMFHQ
	QDkrMbAqpo86CIFmgs/DnJMRrt/gYQ2HMSFa6Mej+8iezw7D1lK1HdH5+0Cl4T3wMJ5hmyo4nSq2S
	gaZD9S/w==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wXajA-0009qy-1X;
	Thu, 11 Jun 2026 10:25:28 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: razor@blackwall.org,
	bobbyeshleman@meta.com,
	dw@davidwei.uk,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/4] Extend netkit io_uring ZC selftests
Date: Thu, 11 Jun 2026 10:25:23 +0200
Message-ID: <20260611082527.741674-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28028/Thu Jun 11 08:27:22 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-298000-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:razor@blackwall.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,iogearbox.net:dkim,iogearbox.net:mid,iogearbox.net:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A6E4F66FD5F

Small follow-up to the HW net selftests, in particular to add a
selftest showing that also large rx_buf_len for io_uring ZC is
supported with netkit queue leasing.

v1 -> v2:
  - Switch to cmd(..., ns=cfg.netns) (Bobby)
  - Add mp_clear_wait for large rx_buf_len test (Bobby)

Daniel Borkmann (4):
  selftests/net: Move netkit lease hw setup into per-test fixtures
  selftests/net: Use public NetDrvContEnv API in nk_qlease fixtures
  selftests/net: Add netkit io_uring ZC test for large rx_buf_len
  selftests/net: Add hugepage kernel config dependency for zcrx

 tools/testing/selftests/drivers/net/hw/config |   1 +
 .../selftests/drivers/net/hw/nk_qlease.py     | 304 +++++++++++++++---
 .../selftests/drivers/net/lib/py/env.py       |  36 ++-
 3 files changed, 274 insertions(+), 67 deletions(-)

-- 
2.43.0


