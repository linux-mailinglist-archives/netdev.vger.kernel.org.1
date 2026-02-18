Return-Path: <netdev+bounces-259366-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sERKFuo1lmkkcQIAu9opvQ
	(envelope-from <netdev+bounces-259366-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:58:02 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B9DCE15A773
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 22:58:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 62D69300FEE1
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 21:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B984833122A;
	Wed, 18 Feb 2026 21:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="M7Ejn14f"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48641335064;
	Wed, 18 Feb 2026 21:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771451847; cv=none; b=dFA0q/8ZDBWjxCQpWfu6kuA2ZCsbgQKiu83MmJZl2LNcrXJzrMIOqBwcDIMJ1dI6GWZ0mR5nuJ7bZzl/P5UEycFsuO88IDQaKac8hWBHAXqbH2ZUgmkwy/pPzUyCgbsdYhVHxnxeOZQi3rTfpzZve//TmYhooMFJGWmzC6hazWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771451847; c=relaxed/simple;
	bh=DRgr1EbFrdyTMoT7piwL2u7hZCduWCNaUokBHV+e5hE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NSdeRWIIrWOdeexR1xLgF+xJ4VfPZpceYtUB0jEL5vIx8uUMElOG4LMfuNwms8h5/zRfPL1+wQW0UKD/G3jTpWXbFutILc4PykDsPjDr8fXyOux8Rc5KXHzuZL3PoQOWbNanNenbNSJuaJKRD1f3nb/gYsYC2o76BLCm3pbGu1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=M7Ejn14f; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771451844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=afWp1dJ7RUaL93yOIWrXY/cdbONGwsWj/SKBhi2ZCLc=;
	b=M7Ejn14fzQ50VScpn1Mcf6UmFfYqxQvdxWhP44UnyJi6ehJug+KAb3KP5IRXaJpxDpRLr4
	U7/uUiGwCxZAvTL+yqMgvSAD1bqOqo84WQ5/CLHhKzpiBG8CP1Q35OdQIu5IkqAFeLSgj+
	VyNFRPxz2OJgg/4smNBqMXdasVhWsK0=
From: Ihor Solodrai <ihor.solodrai@linux.dev>
To: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf v1 2/2] libbpf: Remove extern declaration of bpf_stream_vprintk()
Date: Wed, 18 Feb 2026 13:56:51 -0800
Message-ID: <20260218215651.2057673-3-ihor.solodrai@linux.dev>
In-Reply-To: <20260218215651.2057673-1-ihor.solodrai@linux.dev>
References: <20260218215651.2057673-1-ihor.solodrai@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259366-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ihor.solodrai@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: B9DCE15A773
X-Rspamd-Action: no action

An issue was reported that building BPF program which includes both
vmlinux.h and bpf_helpers.h from libbpf fails due to conflicting
declarations of bpf_stream_vprintk().

Remove the extern declaration from bpf_helpers.h to address this.

In order to use bpf_stream_printk() macro, BPF programs are expected
to either include vmlinux.h of the kernel they are targeting, or add
their own extern declaration.

Reported-by: Luca Boccassi <luca.boccassi@gmail.com>
Closes: https://github.com/libbpf/libbpf/issues/947
Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
---
 tools/lib/bpf/bpf_helpers.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index c145da05a67c..9d160b5b9c0e 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -315,9 +315,6 @@ enum libbpf_tristate {
 			  ___param, sizeof(___param));		\
 })
 
-extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
-			      __u32 len__sz) __weak __ksym;
-
 #define bpf_stream_printk(stream_id, fmt, args...)					\
 ({											\
 	static const char ___fmt[] = fmt;						\
-- 
2.53.0


