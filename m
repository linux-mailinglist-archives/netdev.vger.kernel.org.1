Return-Path: <netdev+bounces-255357-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ED0UA52PfWmGSgIAu9opvQ
	(envelope-from <netdev+bounces-255357-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:14:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D318C0B87
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 06:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4E26F306C28B
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 05:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF0332AAD2;
	Sat, 31 Jan 2026 05:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGOfdkpe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7917333426
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769836179; cv=none; b=MC3vxrZESahYkY6LNM0Pl7XBZYzsUarTg4ILv2TX2NMFXzPyB3B7bcFE+4fgfICc8sxl1WEtGTkFCwjxdRXCLpy6Lpm9Vl4veoDcuusP3hKgnAYdpo2mU/hRz3N5mloo+AkfltNPIGg4EvpozT5JFJZs/4c9RRYJsLZ0XCY5Wuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769836179; c=relaxed/simple;
	bh=UlL8oZQzeYpieEW9kR3O2tWXV0IGuasLKuUjGh/FzsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oy9FJ4cgQ0/Uvq5ukFkcnQEyYRE86TY3BqAKtH2yGlDCss6pXWRJCjemRzVxEgnCC4WvInJfBVnEr58OBaJJ72q7XWWd+TOMXP3AbnGj9tBMymKek7Ka2qJBHD59sj4LPqMf8RJkBWysZxYfI/Z4gppcZQ4Ll2uM0v7AYzV86uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGOfdkpe; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2a7bced39cfso28282885ad.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 21:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769836176; x=1770440976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+n1cYrkpCAn7OrNMXyl0RSJ5XctP2kSL+z13tA+mKTU=;
        b=RGOfdkpeFbJJo5LSE9UhBK821Y6vpBr07gYql+2WRTatEzRWhRFf0Kw9OPRxjybtyf
         3Jv45Ik4heUVcppbGQLcCQvIw8fjIuOAqFK5AozbCLXSigywhY2pjcudunyOIw7Sks9g
         bn6qMer5uz7QRH/F2RXJEJ0+kd7EPTIUECbcJbPxmJB5fpqp5qnesTT1btv94xiuY0KC
         ovey8s/je+ALtyTCoBMOPG8qhz1Lln9gYk5lSj/1LBFOX5/sUTMXUc/FJrakND937O0D
         gIwfOUB1Pl8TkiPwm2yjBt2A2irFiS8OqKILAij/ZsSsuDZSvF2OWhu0qrhA5xdAh7Vz
         1blw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769836176; x=1770440976;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+n1cYrkpCAn7OrNMXyl0RSJ5XctP2kSL+z13tA+mKTU=;
        b=wt/TRD116SaC3wSw/UtT0Kffb0tnyAAmMKL8gxoAEP8FfkKMdTE4STlsBhxH2t4idQ
         +GrlF0xh6SEyr3Myd/qK8gMMcbdauDQhhZFmexpf2yw/l1dIczejwQCTD89OPv0FMgMU
         Ud1IwisAld5+Vo2Mw+6Wy7ng3vqQixeaSNIpCvWWzwuMhTbru1pJvtys0lYI5d7XJs9C
         L3cGLgl/kBcq32kr9XGJlxa8YJb+eiFc+lA9Ad7DAOMC70aQcHK4pS+4o1xknjoqClWK
         5YoLSTj7vR3TZpScgfHZhkHW1IvWQEr9dfxG8grOYpJVuHopJgeO79Zp/s1eFBZ2ZK2z
         bovQ==
X-Gm-Message-State: AOJu0YxyCUXl37ltSbsqkOwtuPYoCWs0b9MFyWpqRv0/t9CON0am3iIx
	gH3pPhg71MJ5SflVEiq7pTQIPOHSWQq9jwPe7wLly638YC7gBEJh6lAv
X-Gm-Gg: AZuq6aKpTHMLKuQJTld6XD+NdZ35YncUEwipDkozgMGYPpprrU+VtxEvHj72qmbeVoQ
	QXFfSixZuw8FrVv+HVFrindekwuUS7sgGxC4GJO6k/TdXvyzR8O/FQuvSRh9AYiGWP+qvue3R53
	cLoLoHGr7hsVetDEFIUlg2C7NlgTBrWmf85DMcjez80Bx12K3t0XHkV0AzVfYEDGou+HSOewhYM
	/dgqX5pmbXBL8R9RQ1aYqF70Fsw6nw9s/+5VaAuff1XzA3IDAWSzNNlIpcpmLivoGtPFtxC2ukW
	uv0nWqPAZ5QYq24UVF7Ed7SK8iF9i9lF5NfgyhOQcVcZvrEVNXmkKS4a45jbpOPFrZFp4Of2uuH
	MS2ZPDT2bMfIHFyTlApsZiBAbuEOgcuFuIpeh9HvHZE/0SwnBzXRrVxAmW5hmY2mgV7YMKBBlPj
	2Y/g==
X-Received: by 2002:a17:903:1547:b0:2a0:f828:24a3 with SMTP id d9443c01a7336-2a8d99366damr49587775ad.28.1769836176317;
        Fri, 30 Jan 2026 21:09:36 -0800 (PST)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a88b3eedd0sm87330305ad.3.2026.01.30.21.09.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 21:09:36 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	memxor@gmail.com,
	martin.lau@kernel.org,
	kpsingh@kernel.org,
	yonghong.song@linux.dev,
	song@kernel.org,
	haoluo@google.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 13/16] selftests/bpf: Update task_local_storage/recursion test
Date: Fri, 30 Jan 2026 21:09:16 -0800
Message-ID: <20260131050920.2574084-14-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131050920.2574084-1-ameryhung@gmail.com>
References: <20260131050920.2574084-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255357-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9D318C0B87
X-Rspamd-Action: no action

Update the expected result of the selftest as recursion of task local
storage syscall and helpers have been relaxed. Now that the percpu
counter is removed, task local storage helpers, bpf_task_storage_get()
and bpf_task_storage_delete() can now run on the same CPU at the same
time unless they cause deadlock.

Note that since there is no percpu counter preventing recursion in
task local storage helpers, bpf_trampoline now catches the recursion
of on_update as reported by recursion_misses.

on_enter: tp_btf/sys_enter
on_update: fentry/bpf_local_storage_update

           Old behavior                         New behavior
           ____________                         ____________
on_enter                             on_enter
  bpf_task_storage_get(&map_a)         bpf_task_storage_get(&map_a)
    bpf_task_storage_trylock succeed     bpf_local_storage_update(&map_a)
    bpf_local_storage_update(&map_a)

    on_update                            on_update
      bpf_task_storage_get(&map_a)         bpf_task_storage_get(&map_a)
        bpf_task_storage_trylock fail        on_update::misses++ (1)
        return NULL                        create and return map_a::ptr

                                           map_a::ptr += 1 (1)

                                           bpf_task_storage_delete(&map_a)
                                             return 0

      bpf_task_storage_get(&map_b)         bpf_task_storage_get(&map_b)
        bpf_task_storage_trylock fail        on_update::misses++ (2)
        return NULL                        create and return map_b::ptr

                                           map_b::ptr += 1 (1)

    create and return map_a::ptr         create and return map_a::ptr
  map_a::ptr = 200                     map_a::ptr = 200

  bpf_task_storage_get(&map_b)         bpf_task_storage_get(&map_b)
    bpf_task_storage_trylock succeed     lockless lookup succeed
    bpf_local_storage_update(&map_b)     return map_b::ptr

    on_update
      bpf_task_storage_get(&map_a)
        bpf_task_storage_trylock fail
        lockless lookup succeed
        return map_a::ptr

      map_a::ptr += 1 (201)

      bpf_task_storage_delete(&map_a)
        bpf_task_storage_trylock fail
        return -EBUSY
      nr_del_errs++ (1)

      bpf_task_storage_get(&map_b)
        bpf_task_storage_trylock fail
        return NULL

    create and return ptr

  map_b::ptr = 100

Expected result:

map_a::ptr = 201                          map_a::ptr = 200
map_b::ptr = 100                          map_b::ptr = 1
nr_del_err = 1                            nr_del_err = 0
on_update::recursion_misses = 0           on_update::recursion_misses = 2
On_enter::recursion_misses = 0            on_enter::recursion_misses = 0

Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 .../testing/selftests/bpf/prog_tests/task_local_storage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
index 42e822ea352f..559727b05e08 100644
--- a/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
+++ b/tools/testing/selftests/bpf/prog_tests/task_local_storage.c
@@ -117,19 +117,19 @@ static void test_recursion(void)
 	map_fd = bpf_map__fd(skel->maps.map_a);
 	err = bpf_map_lookup_elem(map_fd, &task_fd, &value);
 	ASSERT_OK(err, "lookup map_a");
-	ASSERT_EQ(value, 201, "map_a value");
-	ASSERT_EQ(skel->bss->nr_del_errs, 1, "bpf_task_storage_delete busy");
+	ASSERT_EQ(value, 200, "map_a value");
+	ASSERT_EQ(skel->bss->nr_del_errs, 0, "bpf_task_storage_delete busy");
 
 	map_fd = bpf_map__fd(skel->maps.map_b);
 	err = bpf_map_lookup_elem(map_fd, &task_fd, &value);
 	ASSERT_OK(err, "lookup map_b");
-	ASSERT_EQ(value, 100, "map_b value");
+	ASSERT_EQ(value, 1, "map_b value");
 
 	prog_fd = bpf_program__fd(skel->progs.on_update);
 	memset(&info, 0, sizeof(info));
 	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
 	ASSERT_OK(err, "get prog info");
-	ASSERT_EQ(info.recursion_misses, 0, "on_update prog recursion");
+	ASSERT_EQ(info.recursion_misses, 2, "on_update prog recursion");
 
 	prog_fd = bpf_program__fd(skel->progs.on_enter);
 	memset(&info, 0, sizeof(info));
-- 
2.47.3


