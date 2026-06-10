Return-Path: <netdev+bounces-297514-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pa6XH2IbKWoHQwMAu9opvQ
	(envelope-from <netdev+bounces-297514-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:08:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0999666EFD
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 10:08:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=iogearbox.net header.s=default2302 header.b=OEi+7trl;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297514-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297514-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=iogearbox.net;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C532A304C132
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 08:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D74F39EF2B;
	Wed, 10 Jun 2026 08:03:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68BF370D69
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 08:03:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781078631; cv=none; b=Z2FKR4eT9wu73KZifo84pAmHwV6Jf+ggzd1JFBF0w7ORGiDAUMMR0KYsJ656c94j2BIrxWMdkA4HEy/SnqwjrW3G6KwR4AOUinddtLiKS0S762Teyblaxj+K/3kDb6/TTycGbboSXToIP7AXuPFKqjQVU8JAsJ+cm23g6naYjp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781078631; c=relaxed/simple;
	bh=9AVlTfMFne4cAcItTg2VZLDydDOlgGO61bv3Y2Hioww=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gbHsTB6DYFoIkEd0QJ3os/qRvqw5hNmX8pBHXW8Ye9eNR0FZVgR3ybxMXNhUK7ms2oxc3vjvHIz2uYeU95m3uoeTNt+MmkEcufbwn3NmjIFgpu2c8DcR7WWVK+HxsI6x71qf4s7U9byGtq6C4w5e2MQNGWo2lAAgqOuKcr8tucg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=OEi+7trl; arc=none smtp.client-ip=213.133.104.62
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=un0QOeKpdantbMireaInMMpbCGBn17FNrBwbdM3hLsk=; b=OEi+7trlNhxOJhNUhLxgwmZUwN
	oSCd6UHgA0MunvXZnaPCQe7ji8dGNuWFwTP0vxxo/7fxG57Em8/H+FOyGT8I7Uwn4JRRzZUqKl0q2
	BPqA75P/sxBNNTgISx/gg74YYVry2I/e/yvzAbuXOxg9YyIHJGg/UJ+r2sVrwftyE/5YyapHTe8L6
	XiVmexlh/xmHy9coJgxDLOgsruAV0sJ9+yocRbQ+sCFZonHi7mvPdK7WSL58t19zCEM2lO4dCGh2W
	4sfXmEM12LS+/h6PDCVtkbUfz7/2TDRKEz0obVBsJr5Ab/0n2lbLtCx3hvVEJgNGJrHxtZHCjOK0U
	yE0VTggQ==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wXDub-0009Vk-1Y;
	Wed, 10 Jun 2026 10:03:45 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: kuba@kernel.org
Cc: razor@blackwall.org,
	bobbyeshleman@meta.com,
	dw@davidwei.uk,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/4] Extend netkit io_uring ZC selftests
Date: Wed, 10 Jun 2026 10:03:40 +0200
Message-ID: <20260610080344.701380-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28027/Wed Jun 10 08:29:13 2026)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-297514-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:kuba@kernel.org,m:razor@blackwall.org,m:bobbyeshleman@meta.com,m:dw@davidwei.uk,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,iogearbox.net:dkim,iogearbox.net:mid,iogearbox.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E0999666EFD

Small follow-up to the HW net selftests, in particular to add a
selftest showing that also large rx_buf_len for io_uring ZC is
supported with netkit queue leasing.

Daniel Borkmann (4):
  selftests/net: Move netkit lease hw setup into per-test fixtures
  selftests/net: Use public NetDrvContEnv API in nk_qlease fixtures
  selftests/net: Add netkit io_uring ZC test for large rx_buf_len
  selftests/net: Add hugepage kernel config dependency for zcrx

 tools/testing/selftests/drivers/net/hw/config |   1 +
 .../selftests/drivers/net/hw/nk_qlease.py     | 277 ++++++++++++++----
 .../selftests/drivers/net/lib/py/env.py       |  36 ++-
 3 files changed, 250 insertions(+), 64 deletions(-)

-- 
2.43.0


