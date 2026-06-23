Return-Path: <netdev+bounces-301436-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id whOBJ1rHOmrMGggAu9opvQ
	(envelope-from <netdev+bounces-301436-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:50:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1726B93ED
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 19:50:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dK6iG5t9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301436-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301436-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8F120300B3D4
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 17:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D4538D3F9;
	Tue, 23 Jun 2026 17:50:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7317438D407
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 17:50:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782237013; cv=none; b=RfNKAkODh2dAkN0gyWUqXhbbyPYxQ1foi0VY/r3nh1xHw4yZ6v1Qmxdaj/N96BQGR6M0ACmYofJbcmv4cjdb+amdCFTNS9t5Dh2QnCP2dBVNe5XJzwALWxMAu2KhHlhROPhJ5/giJNH0LmCxGoL+55/M/HIqyLpTd3mblYfOx5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782237013; c=relaxed/simple;
	bh=5dxJpYNmNjYgsCeUDPk0LotgujMFjbFSpptiu28baoo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E94gz4bk3aDGMmfKmzkRed1yWDIv/6RaKsTD+Ccld5nHGzQElzrk529lnWqWRfSMZ3O00MuiwGLZZD8jzGVZZ4CY2BHk9UDri+Oczypj2Mj9XKJgzMQxc7+dh1DybX0culeYpyiU/uOacyXSKj0dcGCAZY4iy5iJtLgKxxnfujw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK6iG5t9; arc=none smtp.client-ip=209.85.210.51
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7e94d272a86so136757a34.2
        for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 10:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782237009; x=1782841809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=91jm4JZIjKWf/o29bp0zeJwiE4GAwL4vFnu1UTAweC0=;
        b=dK6iG5t9ikD3s/LvJHtcKuI81Uqb+jGuY8jIte4TMJxVNwhKTp65k07zQhoJmxWNnf
         0yuwUfew8GfyZKfDMliOlQQSF7K2v7+sYPDjqLymTrIiGPQK0JWXXQbyMW/EPn7Vu+hU
         KbO5jsL8Cg/9NroEXx8TwGM0HfNxyiGMn4bQTVG2HIU5PdSyVKtwOBb8Czd41CYNWHfo
         TAuLKB9p2KIw+Ffas5LaMBzXFB7HssEjBI2SygGfDg8+S3lM8ySuZK4xafMn1UAvah6Y
         6JQzayYFM/8V2x89LdIBBoLjAd6Eq840FEY6bXNwNiGukIRr3iOja0iqt0N1I+7PeWXR
         /Z7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782237009; x=1782841809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=91jm4JZIjKWf/o29bp0zeJwiE4GAwL4vFnu1UTAweC0=;
        b=Q3ZR9euyxuf4tyacShVd1HwVCe18S7Sr+uytvi6lwEoy7gyWDNCT44JbqToVQhIKCW
         y5DSWAnuraWKfXKRPtWPX7l4YVzuO6Ye9X5qgpfbDXXU5BrqXEUWBpJ9Brk3NHQwKgSl
         zKy1q7oYf6m2bcnhKnsmxmswVfWqugufoXiCYx8ciKCkE879JMRNGk4d0rKJxvHlBILM
         hr84YuMte4xQ0ex/Ip6kdH/M8rqvygQ4L2PeXzDk7JhZzFbODM2Z8Y6zYc6FCRN5nSno
         th6YOlW5kGXiESgzCrEnpxJ+VyL+zpdGe+fp7TRTavZI3twAttM4sRy38XIXNNcN47Ib
         04cw==
X-Gm-Message-State: AOJu0YyfYllab9KUylpVorP67bF/IcGy+KZV7+KwMS/MDiDf83EDhQlO
	qHC19QSEEcmOW8NS1khyQbEPDIspn5pAFjv8FHhy8nlXJuyQ4bLv1kzW
X-Gm-Gg: AfdE7cmFe4jGOr4ixGd44f1EESnHmi+EX044fMDJBj4Uz+0XV9Oiar0hMOPCJr8GRV8
	j7zQGTgsW4rGybiHq/UrZoqm/GlqQYDi1WRHHbMUlvgiYozu0lzoaoIWAYkzodZLsvS2pnXe9dd
	/PYQnhx59g55VIyP5fGS/YyYzI7Hi2fyufIGJArVclpc20LQwUIIH8Kmd9p0PUUWbJQW9LW1ISc
	qzh/XT5qGaT1SY82GtIXWHF/v9/1sJVudXRsTCXAR/L8injGVmEUrLo8OCsB0DxkNC27831Ug0d
	Pe1e4im74xAPfXyN0B5369m4hVcuvC66e2fCYoCRF+haw+WHKy7cH2K+GF9jQgv86SEUM1OCy73
	Om0rXZG7opLdMTqe6dxu4mal/9RlETgmUMiQ3vy779XTIiJ8Z/CIpYTfDede2SlcC70uRI5+W35
	WW8KI=
X-Received: by 2002:a05:6830:83ac:b0:7e7:8dc0:3945 with SMTP id 46e09a7af769-7e9867c52b3mr164537a34.8.1782237009413;
        Tue, 23 Jun 2026 10:50:09 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:4e::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e944005ae8sm10073961a34.3.2026.06.23.10.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:50:09 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 01/15] bpf: Remove __rcu tagging in st_link->map
Date: Tue, 23 Jun 2026 10:49:49 -0700
Message-ID: <20260623175006.3136053-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260623175006.3136053-1-ameryhung@gmail.com>
References: <20260623175006.3136053-1-ameryhung@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-301436-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0D1726B93ED

From: Martin KaFai Lau <martin.lau@kernel.org>

st_link->map is always written under update_mutex. The paths that read
st_link->map with rcu_read_lock() are not in the fast path, so they can
simply take update_mutex instead. Remove the __rcu annotation and replace
all RCU accessors with direct pointer reads under update_mutex. Use
READ_ONCE() in bpf_struct_ops_map_link_poll() which reads the pointer
without holding update_mutex.

It is a simplification change.

Signed-off-by: Martin KaFai Lau <martin.lau@kernel.org>
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 29 ++++++++++++++---------------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 51b16e5f5534..d06b3d9bcc13 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -57,7 +57,7 @@ struct bpf_struct_ops_map {
 
 struct bpf_struct_ops_link {
 	struct bpf_link link;
-	struct bpf_map __rcu *map;
+	struct bpf_map *map;
 	wait_queue_head_t wait_hup;
 };
 
@@ -1257,8 +1257,7 @@ static void bpf_struct_ops_map_link_dealloc(struct bpf_link *link)
 	struct bpf_struct_ops_map *st_map;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
-	st_map = (struct bpf_struct_ops_map *)
-		rcu_dereference_protected(st_link->map, true);
+	st_map = (struct bpf_struct_ops_map *)st_link->map;
 	if (st_map) {
 		st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 		bpf_map_put(&st_map->map);
@@ -1273,11 +1272,11 @@ static void bpf_struct_ops_map_link_show_fdinfo(const struct bpf_link *link,
 	struct bpf_map *map;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
-	rcu_read_lock();
-	map = rcu_dereference(st_link->map);
+	mutex_lock(&update_mutex);
+	map = st_link->map;
 	if (map)
 		seq_printf(seq, "map_id:\t%d\n", map->id);
-	rcu_read_unlock();
+	mutex_unlock(&update_mutex);
 }
 
 static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
@@ -1287,11 +1286,11 @@ static int bpf_struct_ops_map_link_fill_link_info(const struct bpf_link *link,
 	struct bpf_map *map;
 
 	st_link = container_of(link, struct bpf_struct_ops_link, link);
-	rcu_read_lock();
-	map = rcu_dereference(st_link->map);
+	mutex_lock(&update_mutex);
+	map = st_link->map;
 	if (map)
 		info->struct_ops.map_id = map->id;
-	rcu_read_unlock();
+	mutex_unlock(&update_mutex);
 	return 0;
 }
 
@@ -1314,7 +1313,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 
 	mutex_lock(&update_mutex);
 
-	old_map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
+	old_map = st_link->map;
 	if (!old_map) {
 		err = -ENOLINK;
 		goto err_out;
@@ -1336,7 +1335,7 @@ static int bpf_struct_ops_map_link_update(struct bpf_link *link, struct bpf_map
 		goto err_out;
 
 	bpf_map_inc(new_map);
-	rcu_assign_pointer(st_link->map, new_map);
+	WRITE_ONCE(st_link->map, new_map);
 	bpf_map_put(old_map);
 
 err_out:
@@ -1353,7 +1352,7 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
 
 	mutex_lock(&update_mutex);
 
-	map = rcu_dereference_protected(st_link->map, lockdep_is_held(&update_mutex));
+	map = st_link->map;
 	if (!map) {
 		mutex_unlock(&update_mutex);
 		return 0;
@@ -1362,7 +1361,7 @@ static int bpf_struct_ops_map_link_detach(struct bpf_link *link)
 
 	st_map->st_ops_desc->st_ops->unreg(&st_map->kvalue.data, link);
 
-	RCU_INIT_POINTER(st_link->map, NULL);
+	WRITE_ONCE(st_link->map, NULL);
 	/* Pair with bpf_map_get() in bpf_struct_ops_link_create() or
 	 * bpf_map_inc() in bpf_struct_ops_map_link_update().
 	 */
@@ -1382,7 +1381,7 @@ static __poll_t bpf_struct_ops_map_link_poll(struct file *file,
 
 	poll_wait(file, &st_link->wait_hup, pts);
 
-	return rcu_access_pointer(st_link->map) ? 0 : EPOLLHUP;
+	return READ_ONCE(st_link->map) ? 0 : EPOLLHUP;
 }
 
 static const struct bpf_link_ops bpf_struct_ops_map_lops = {
@@ -1438,7 +1437,7 @@ int bpf_struct_ops_link_create(union bpf_attr *attr)
 		link = NULL;
 		goto err_out;
 	}
-	RCU_INIT_POINTER(link->map, map);
+	link->map = map;
 	mutex_unlock(&update_mutex);
 
 	return bpf_link_settle(&link_primer);
-- 
2.53.0-Meta


