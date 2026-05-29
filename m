Return-Path: <netdev+bounces-293265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DGVC876GWrB0QgAu9opvQ
	(envelope-from <netdev+bounces-293265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:45:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 99AAE608A6B
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 22:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B7683014424
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 20:40:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D9B3B38AD;
	Fri, 29 May 2026 20:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PWQpvtEB"
X-Original-To: netdev@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAEB3ED125
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 20:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780087202; cv=none; b=TGNlkF+K1WJjnYW9z83vYvKz3xWyXcIQ+Kfbk4AwU53ZZBpy6Y/+O9tMKvRZfCUO6bQh6gmti8gnWvUbYI5VwrLUmQHMwDuHglMWhEIWM4M9VMt+kdIEiNvxuBSo5oM/zOOkxskZMCrtT8g1qlun0de8WTxAkp6xX+1W3oz2auY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780087202; c=relaxed/simple;
	bh=99Awv4p/YpHh8uIlL20PuCOZqFAaXfStCugn2/mTAzQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lbmGLgtzIAFHtEGe9fed/pA8E/lDqcplFMAoLMGPCBAU3zdnrvdn7+N7XuHnFiUcFiF2vAdF3YqaeoMivHQkgrC2WlGry/EhfFNi2SJQRHUcRQf/5x/fMEjhjcf/gG+4nrwKPn/hJy9yFyNP4g6epEB0awYC+kN37ievLOlaX10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PWQpvtEB; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1780087198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XFVOIICd/CtvKQr1GYXFlIipfXLzMt6AZz01mWTQiLo=;
	b=PWQpvtEByBDge4lKFQt/y6bA9QTcCQ9zsPrtJERPIFdIrBmNMlQTJNyRqRr5gOjvf929Qf
	qQOOr3prPOMcmBEpOP/AkotZDHY9H3LnTduMpf8dt0DKgH8GZK/CIuZX8XcvijtiB37009
	6MAr+TyrAg3zDmdfhWc02BLmyFLhA8E=
From: Martin KaFai Lau <martin.lau@linux.dev>
To: bpf@vger.kernel.org
Cc: 'Alexei Starovoitov ' <ast@kernel.org>,
	'Andrii Nakryiko ' <andrii@kernel.org>,
	'Daniel Borkmann ' <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next] bpf: MAINTAINERS: Update bpf maintainers
Date: Fri, 29 May 2026 13:39:09 -0700
Message-ID: <20260529203909.1222164-1-martin.lau@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-293265-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[martin.lau@linux.dev,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 99AAE608A6B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Martin KaFai Lau <martin.lau@kernel.org>

I am making a life change and will take a long break
from my current work, so I will step down from the "M:" responsibility.

I am currently a "R:" in "BPF [GENERAL]", this part stays unchanged.
I am folding most of the parts into "BPF [GENERAL]".

For "BPF [BTF]", it is long overdue as I am no longer involved.
It is folded into the "BPF [GENERAL]".

The "BPF [STORAGE & CGROUPS]" will also be covered by "BPF [GENERAL]".

For struct_ops, its usage is no longer limited to networking,
so this naturally should move back to "BPF [GENERAL]".

For the reuseport, it will continue to be maintained together
by "BPF [GENERAL]" and the "NETWORKING [SOCKETS]".

For other "BPF [NETWORKING]...", I am moving myself to "R:".

Thanks!

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
---
 MAINTAINERS | 24 +-----------------------
 1 file changed, 1 insertion(+), 23 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dfc621ff629d..d9caa2d980f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4766,13 +4766,6 @@ S:	Supported
 F:	arch/x86/net/
 X:	arch/x86/net/bpf_jit_comp32.c
 
-BPF [BTF]
-M:	Martin KaFai Lau <martin.lau@linux.dev>
-L:	bpf@vger.kernel.org
-S:	Maintained
-F:	include/linux/btf*
-F:	kernel/bpf/btf.c
-
 BPF [CORE]
 M:	Alexei Starovoitov <ast@kernel.org>
 M:	Daniel Borkmann <daniel@iogearbox.net>
@@ -4905,18 +4898,11 @@ F:	tools/testing/selftests/bpf/prog_tests/tc_netkit.c
 F:	tools/testing/selftests/drivers/net/hw/nk_qlease.py
 F:	tools/testing/selftests/net/nk_qlease.py
 
-BPF [NETWORKING] (struct_ops, reuseport)
-M:	Martin KaFai Lau <martin.lau@linux.dev>
-L:	bpf@vger.kernel.org
-L:	netdev@vger.kernel.org
-S:	Maintained
-F:	kernel/bpf/bpf_struct*
-
 BPF [NETWORKING] (tcx & tc BPF, sock_addr)
-M:	Martin KaFai Lau <martin.lau@linux.dev>
 M:	Daniel Borkmann <daniel@iogearbox.net>
 R:	John Fastabend <john.fastabend@gmail.com>
 R:	Stanislav Fomichev <sdf@fomichev.me>
+R:	Martin KaFai Lau <martin.lau@linux.dev>
 L:	bpf@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -4951,14 +4937,6 @@ L:	bpf@vger.kernel.org
 S:	Maintained
 F:	tools/testing/selftests/bpf/
 
-BPF [STORAGE & CGROUPS]
-M:	Martin KaFai Lau <martin.lau@linux.dev>
-L:	bpf@vger.kernel.org
-S:	Maintained
-F:	kernel/bpf/*storage.c
-F:	kernel/bpf/bpf_lru*
-F:	kernel/bpf/cgroup.c
-
 BPF [TOOLING] (bpftool)
 M:	Quentin Monnet <qmo@kernel.org>
 L:	bpf@vger.kernel.org
-- 
2.53.0-Meta


