Return-Path: <netdev+bounces-305165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zwjdGNTlS2ppcQEAu9opvQ
	(envelope-from <netdev+bounces-305165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:28:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF9BF713DD4
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 19:28:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PXUUMLOt;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305165-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305165-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D61A330A83E8
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 17:20:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86F1D3DF019;
	Mon,  6 Jul 2026 17:19:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CDEF3BADA3
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 17:19:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783358379; cv=none; b=KfYiHBcL+uhUYWHqfV9XsN9q/kuB0uMWzsObzpZTiGGEtZlvLp3g9AptUN5LLnS3hcwOq94k7FM8Itmh8KQmfe6opTBVi4ethjlheEizEqDp8EZiKQVZXjDXI6ARSxvr4D1v8IVhPwj74KQcyGShUYtHTLeFzxryq4Dm82+uZOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783358379; c=relaxed/simple;
	bh=SO8Au3LdMj3YdJWgfQZnM3I9IcAVk/GaLFUx6z2zfYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HPysPhFTezAehYebOVkIUP8IRa3XZ/Geh1ayn7g4dyf6qDwq/Yi7lytPxU1BrhATJlxaxFNCnKU6y7xJKpidT9EIKHkwGUdeXkLIsjZbM/qQE9U6qOUn42rvcX0+QsoEGU0sC9apF2nKcA1+4rHdMdhJecY0erBzpxgqXkDfPPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXUUMLOt; arc=none smtp.client-ip=209.85.167.182
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-49c38a4f110so1226818b6e.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 10:19:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783358377; x=1783963177; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QpRud8IfHMa48lHaLqrXsmv/FgGxX43vCtItcr3N5Ag=;
        b=PXUUMLOt2X+r0RSzxwuST9KIMc5NevzpgvGolf7ERZJwFat9uAkhLjtHqN1HTadS45
         +TXz/HZB4k5MDgJvuXkZILmoG9L9LftAsbstBLeca3kUNtpbiSt0NF/7zJ/xDywPIqnk
         FzD1mr+oHW+KGh9/6Puxw7AI9YXsq4s7hVYNsD4XPEjxlJFQFLnOq7Dh7LPpDIVsbWCa
         yt5NHYLpRukxUZD/R/cpsjZengkWPGjH5Yxgn+oWZHfgOmu8kjzMBER0Ivn9qdER2e66
         qkmT5TFSs6BsBZ+WI/0RF92pqGQGETa+71prbw4KbPNKwWcN12/NQGW16gU2jXUs0mfe
         TkWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783358377; x=1783963177;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QpRud8IfHMa48lHaLqrXsmv/FgGxX43vCtItcr3N5Ag=;
        b=f+0kPKwJmtO95OtXVnW9OY5kcxjUczIiPoDcoBAvc2m8PSqiPXZLBIRdmt7jYAO6aq
         5B2ztwI9RqDgisyogu0zSUdfqyNBkrIRW1O8tuID62yQn/KH17mYwHqiT0nGWz5vm9uB
         HdVfktyaW7cskdSB6ur/uIeX0odLC+Gpchp/H/HDASDY1Y1ENhbVjEUQQrw9VRXM0Pzh
         WATgO8Wz3fRtfQkFNzzawta7EtGocd6zT3tNYbi6pMIgU43K7Si4ZG3MBtj8P0OLWVk9
         wQvg8f/uOuYzfM10zHGqND2kHOvwCo4a88suDDkhC8nzUwqbjmNDPFuRoA3jUFoWAHKs
         estQ==
X-Gm-Message-State: AOJu0YwOUyUwiYX5vn9jh/p1YTaTIB7ShI6k7EufbtcNkwFpUs6u1OkQ
	sh30zrk02O+avnVJ+BeY1cmsDBP60U47lk6Jlh0oVVMYJHeHd6jGhwyR
X-Gm-Gg: AfdE7clH0AR+tfk2sux9h+m8AX077Woz5o3V/NrYhfYxcDJX3R8DLXYKjyy2/+FrUhM
	3iMbZjelJCEPZhWGbQpuiJqAPjmInysOEB9u6deHrl8EV7MDK6BX45QADM5q0zLTylByz8taD3H
	ZxibufatqlQ41+h+BkA9gNS4xfb5wCgO4kYzON/1CdR3vgoRz2W6GTQSxwE8O8oZeKrkC2U7MxB
	nCxSwVlxk0R76CwtPQwQ9NVwJWC6KWlEW6MvPQMyn1LlZQ1GssuJ7FI62N0CymENzv5rsSytLSa
	zn/HHwQL0OHeCVoflb82uz7LOS1isfQNg8SO84niQOX+Gqi5hlbtiw6OBlbJUXrXBhIqwU95/xF
	YNhy06j2pKrmTugzI2lYPkctXctILucNT1YkzeJFGe7+sRgahylz5Y1I2n58AHQvmVqJx8lbj9U
	2XwVc=
X-Received: by 2002:a05:6808:178d:b0:495:dfbc:c1c6 with SMTP id 5614622812f47-49fdec03600mr1210273b6e.40.1783358376902;
        Mon, 06 Jul 2026 10:19:36 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-497d1853afbsm9451997b6e.8.2026.07.06.10.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 10:19:36 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@kernel.org,
	shakeel.butt@linux.dev,
	roman.gushchin@linux.dev,
	kuniyu@google.com,
	kerneljasonxing@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v3 07/15] bpf: Move LSM trampoline unlink into bpf_cgroup_link_auto_detach()
Date: Mon,  6 Jul 2026 10:19:09 -0700
Message-ID: <20260706171918.317102-8-ameryhung@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260706171918.317102-1-ameryhung@gmail.com>
References: <20260706171918.317102-1-ameryhung@gmail.com>
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,kernel.org,iogearbox.net,linux.dev,google.com,meta.com];
	TAGGED_FROM(0.00)[bounces-305165-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:alexei.starovoitov@gmail.com,m:andrii@kernel.org,m:daniel@iogearbox.net,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@kernel.org,m:shakeel.butt@linux.dev,m:roman.gushchin@linux.dev,m:kuniyu@google.com,m:kerneljasonxing@gmail.com,m:ameryhung@gmail.com,m:kernel-team@meta.com,m:alexeistarovoitov@gmail.com,s:lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ameryhung@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CF9BF713DD4

From: Martin KaFai Lau <martin.lau@kernel.org>

Move the LSM trampoline unlink into bpf_cgroup_link_auto_detach().
The purpose is to consolidate the auto_detach cleanup logic.

It prepares for the upcoming struct_ops cgroup attachment patch where
bpf_cgroup_link_auto_detach() will need to handle the struct_ops case
(link->map != NULL).

This is a no-op change.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/cgroup.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index b43f0bff184c..7abbe12e108f 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -313,6 +313,8 @@ static void bpf_cgroup_storages_link(struct bpf_cgroup_storage *storages[],
  */
 static void bpf_cgroup_link_auto_detach(struct bpf_cgroup_link *link)
 {
+	if (link->link.prog->expected_attach_type == BPF_LSM_CGROUP)
+		bpf_trampoline_unlink_cgroup_shim(link->link.prog);
 	cgroup_put(link->cgroup);
 	link->cgroup = NULL;
 }
@@ -346,11 +348,8 @@ static void cgroup_bpf_release(struct work_struct *work)
 					bpf_trampoline_unlink_cgroup_shim(pl->prog);
 				bpf_prog_put(pl->prog);
 			}
-			if (pl->link) {
-				if (pl->link->link.prog->expected_attach_type == BPF_LSM_CGROUP)
-					bpf_trampoline_unlink_cgroup_shim(pl->link->link.prog);
+			if (pl->link)
 				bpf_cgroup_link_auto_detach(pl->link);
-			}
 			kfree(pl);
 			static_branch_dec(&cgroup_bpf_enabled_key[atype]);
 		}
-- 
2.52.0


