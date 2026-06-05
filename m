Return-Path: <netdev+bounces-295973-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RxTcIxAwI2p6jwEAu9opvQ
	(envelope-from <netdev+bounces-295973-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 22:22:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 072A864B23D
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 22:22:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=l6zOXCPu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295973-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295973-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B46F3043EF0
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 20:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA95A395AF8;
	Fri,  5 Jun 2026 20:21:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3B113ED13E
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 20:21:04 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780690867; cv=none; b=X9auyXRhca5T+Wno1gounWyGCpeI+Jh82v2AowDSVD7oFTNu7wDo9rrJdugqum3psWjLjeVdHfphQN1VtfvHS08iWL/Q9g0lI+Md0j4zaSwCa91JiJd2ClbwYsxwT/Gwnr4BGyJjZL87aOKIU+0Jyk1OLK7RvpZAfCiS8H8Zi9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780690867; c=relaxed/simple;
	bh=0K6YGPmo5oE+oT8qEcDlB0fOA+kgYJZzHLTEFFd7qyI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CrqmESgR1v4f+RVpuJ4pny00AC/+65e6Q6Qu3019JvDfcnSwEXcvhL2Ywc7cV6jlsTFl+BFNUsD47QJ9Gu2R3UF3A0bGulC6IphEaLlTzOuYhEG1ErBIRkpulegByZb6kRtnM+qP+EBVf+2OlX2GP38Hdgo6OkNO82WdSRTUb3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6zOXCPu; arc=none smtp.client-ip=209.85.210.172
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-8419ab3a297so1042900b3a.2
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 13:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780690862; x=1781295662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PvtsSjqoa8csGDPIPn9CW3BdCwPSSCraeMH+eLutkdw=;
        b=l6zOXCPu5E+u2VpaO6S4CEVQTWd36Jf+EkVQYB24YaXI/2HHUtHARBdYtfc8qb0nt3
         yv42/H/aut4gW3dcn6xwWvAcnqYru5Lrdsy3QcEdaSZ4cQ3gVUz3kVPuKpjCbPAlB4Da
         hszgS7h+vx3HT1vKgil6r/I+FXV47uVZ7gtx75CGte8BsVIikB3vBXlRkq/96pL2SVEo
         lxQfz43LeO8fC8tJTPylAil5h+jviL9sDqwB3RFcTlS8NRKEErBmhwJZbZ5SrKSwktI5
         bZdDuXzThMGcuDNW3zikSejYzNahtL/3+upHtcp/50Xt6WLBC02mJHCdmpqCAHBhF/I9
         5Tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780690862; x=1781295662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PvtsSjqoa8csGDPIPn9CW3BdCwPSSCraeMH+eLutkdw=;
        b=ZyuUQv9joTckS6NNTId6QoDAoMvW4Tb5luJ2pexwFXOJ0lfgtw7Wjs1o3LH0OFvRuf
         BJJMuF2Y91jIRMiTP3fgXowe+9pXbpcUNCjX8e6RKA2AqlQF5/UejqDGr7nbRvwDBAS2
         oAW+9wgUYJaymrxmAZ4Jty5dEE9p1a8+b2k+/2OyTbjXhFbfHtVno3/AKyUe6Ec6PE8+
         fJ/upZE67UCpkGgSHn5ZzwDR+sf8CL9rk03Oer797seu6zTkA9ePRV7kgjWtXOpl6OfX
         2RVCKLXQjPQR2aZCE6K4rUKHTFuEtSyLPksGw8vHukdZ5ZJ0waTGESCo+g9oxYZs1TGQ
         ADLA==
X-Gm-Message-State: AOJu0YwcsnGh3DC5dl+D3oTuJC7z68vC02hbEM9FM4JWvSv5OAXe7Nrx
	xKLR7KtDsXIQq1zb0OvQB9ps0BIlQA+BQT69RU+aymdzXFQHUEHUGLI1
X-Gm-Gg: Acq92OETHV4aLO9HJ+I57+LBJySnEDsodkKCnxWLPKY/R3yOLn1Go9lqsYm5WZy38Yp
	dXRsBL5OHJOUjoCYB8cKtXTfX9mTgXNfTIbcC2rKv/s/Qw372ESMPfHoNwv2a8ZBCkxIUT/yHtC
	4kzzn6/QoaGAfsdDspCiCbPjVdEYyDiAV7IiKGkeJnxd6qwUSiHhaWhBbbS6TfuT+HQHkeSWUpB
	lKfPxSOQ7uc+WLYm7o1PNaEWU1k6yPDj9JdvAeFRxg62QUjMiV0z7PPE/kHnYyWXe7bVR7ra/BF
	th2DkGUx3uEU7nRouIty4QR7w3wE145Yw6wkWy6Dcs3k+OzHoytR/NtpwKZ2bYMndJF32dQ17Lb
	eXeaJm3ETmv0+8HLLtJ8d5XhE8O9kzP7k1bU/2ZtYKqvGjpL16eZy+MQXbjLwQJm6neAHzx3Gtg
	9KSzXVRWFlB/RqBEsMvxarJblp88NcNlXrUYU=
X-Received: by 2002:a05:6a00:418d:b0:842:6fac:ba7 with SMTP id d2e1a72fcca58-842b0e1dd8cmr5397249b3a.5.1780690861988;
        Fri, 05 Jun 2026 13:21:01 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:5d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-842822222ccsm12000282b3a.3.2026.06.05.13.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 13:21:01 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	mykyta.yatsenko5@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 5/5] selftests/bpf: Use bpf_dynptr_slice() to read file dynptr in leak test
Date: Fri,  5 Jun 2026 13:20:56 -0700
Message-ID: <20260605202056.1780352-6-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260605202056.1780352-1-ameryhung@gmail.com>
References: <20260605202056.1780352-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295973-lists,netdev=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:mykyta.yatsenko5@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,m:mykytayatsenko5@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 072A864B23D

use_file_dynptr_slice_after_put_file() reads the dynptr via
bpf_dynptr_data(), which always returns NULL for a read-only file
dynptr, making the example confusing. Switch to bpf_dynptr_slice(), the
correct read API for file dynptrs, and read (rather than write) the slice
since it is read-only. The test still fails as expected.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/bpf/progs/file_reader_fail.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/file_reader_fail.c b/tools/testing/selftests/bpf/progs/file_reader_fail.c
index d5fae5e4cf9a..3bb9e2612f8f 100644
--- a/tools/testing/selftests/bpf/progs/file_reader_fail.c
+++ b/tools/testing/selftests/bpf/progs/file_reader_fail.c
@@ -87,7 +87,8 @@ int use_file_dynptr_slice_after_put_file(void *ctx)
 	struct task_struct *task = bpf_get_current_task_btf();
 	struct file *file = bpf_get_task_exe_file(task);
 	struct bpf_dynptr dynptr;
-	char *data;
+	char buf[1];
+	const char *data;
 
 	if (!file)
 		return 0;
@@ -95,15 +96,14 @@ int use_file_dynptr_slice_after_put_file(void *ctx)
 	if (bpf_dynptr_from_file(file, 0, &dynptr))
 		goto out;
 
-	data = bpf_dynptr_data(&dynptr, 0, 1);
+	data = bpf_dynptr_slice(&dynptr, 0, buf, sizeof(buf));
 	if (!data)
 		goto out;
 
 	/* this should fail - file dynptr should be discarded first to prevent resource leak */
 	bpf_put_file(file);
 
-	*data = 'x';
-	return 0;
+	return data[0];
 
 out:
 	bpf_dynptr_file_discard(&dynptr);
-- 
2.53.0-Meta


