Return-Path: <netdev+bounces-278326-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6P5OLmHy3WmMlQkAu9opvQ
	(envelope-from <netdev+bounces-278326-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:53:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C12A3F6C41
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 09:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B84D301FA62
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 07:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D069B386C22;
	Tue, 14 Apr 2026 07:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="C9MBp3L1"
X-Original-To: netdev@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F175386C2A
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 07:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776153178; cv=none; b=r12O2PAynvVSNhQYpHkCd7w8RSBalV3PhKlMnD5HODO+P0QlJvlipUWLEc9WQ0hI+dQKm3bKOW0gPoO+srvkRjTFKkaVVeJLY4Pawf0whRpgSJiNfetJ9/7fJR3lkr1zme2IG5/NODtShJrKnnnHrAtQLwSx+P0NMvgqhw6f0oU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776153178; c=relaxed/simple;
	bh=V4KG5wElUlezmm/yj1BYoN4o9YUHIwTu2s72ur4KbfE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C1jBX1MaL5XaaKdmCmegFH/IM0JUemEk+mzugKrrRwoGgzNOW1sHcEOGp/wCsNy67YRDRVv/mZ1Ewt1orGIEdQxKh3cAB/N721FGm2t4BhMOHIGEshEEkxT8qHyFTxA/PAc9wb9CFrMl9vro+nUyLo25GgzIvZdeuRPkxNI32Q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=C9MBp3L1; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=LXhy0xtXR5CdHT8zZ2R+BWAYxXUsO6P0r/n1Iimw8NA=; b=C9MBp3L1g0FWuVPKUJB5+jP0a+
	8YfOPFU5x/5Wo4YhPZJz8Mz6stLOA6en18aF9lRtJjHRQmc0s1nowNz90UwdlxDxUKGKISnOyXQ/6
	BkyQCnK7LGp7MNaQbAxp9ziz2FwV/AH8h5F+GQE9yUln7Tje2a+fetkP+QyuBd6ffbOIYp7TZm/4t
	SoaMaG/YGomrd9uFECiK9Yjf+XT2P9OFz3kG8d0xB7/4gJjB98PLCNbvqGUfePVIXt+GQoNgwM4MK
	oF7ThdUlT/Oeg0HCQmz28b597iO2PJBAzIITdPmK3bPFg0cPiQeVSy7P07cczYTY7sXwCGMADE2/U
	EFf4XMvg==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1wCYZm-000CXZ-1T;
	Tue, 14 Apr 2026 09:52:50 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	dw@davidwei.uk,
	pabeni@redhat.com,
	razor@blackwall.org
Subject: [PATCH net-next] MAINTAINERS: Add netkit selftest files
Date: Tue, 14 Apr 2026 09:52:49 +0200
Message-ID: <20260414075249.611608-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27971/Tue Apr 14 08:24:44 2026)
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[iogearbox.net,reject];
	R_DKIM_ALLOW(-0.20)[iogearbox.net:s=default2302];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278326-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[iogearbox.net:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@iogearbox.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iogearbox.net:dkim,iogearbox.net:email,iogearbox.net:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 1C12A3F6C41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The following selftest files are related to netkit and should have
netkit folks in Cc for review:

  - tools/testing/selftests/bpf/prog_tests/tc_netkit.c
  - tools/testing/selftests/drivers/net/hw/nk_qlease.py
  - tools/testing/selftests/net/nk_qlease.py

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
---
 [ on top of https://lore.kernel.org/netdev/20260413220809.604592-1-daniel@iogearbox.net/ ]

 MAINTAINERS | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 65902b97f5df..fa1bdb1db73e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4901,6 +4901,9 @@ L:	netdev@vger.kernel.org
 S:	Supported
 F:	drivers/net/netkit.c
 F:	include/net/netkit.h
+F:	tools/testing/selftests/bpf/prog_tests/tc_netkit.c
+F:	tools/testing/selftests/drivers/net/hw/nk_qlease.py
+F:	tools/testing/selftests/net/nk_qlease.py
 
 BPF [NETWORKING] (struct_ops, reuseport)
 M:	Martin KaFai Lau <martin.lau@linux.dev>
-- 
2.43.0


