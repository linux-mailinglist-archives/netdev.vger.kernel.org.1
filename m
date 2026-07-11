Return-Path: <netdev+bounces-306776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id CFNsEMgJUmrVLQMAu9opvQ
	(envelope-from <netdev+bounces-306776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:15:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD1AB741009
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 11:15:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=gsWo+rfU;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306776-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306776-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D7ED3050433
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 09:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16DC384254;
	Sat, 11 Jul 2026 09:12:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3E83845D0
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 09:12:33 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783761155; cv=none; b=L5EY1Roki4y5yl8SpSMWgBDxxqmb2DfRyKiR1YKp8/MEVlJp+IscBZ8xA/P3mLMRgc49otOKT3MbfLjfxkRArjSgLAa+k/gEBXZaKrQR0OOBqA6I8XhN5lkVrACnXp0p4VUBymsiaPVkIajZ2dXU0UmObx8tydanUt2zA8Bte8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783761155; c=relaxed/simple;
	bh=j/5GZEQZbF38L9JaQiUk3YKk/MPhOlWpLdjb7h/aMHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MTgYFOqpko1+vMUyqZ8q70zk6EzhzB0mj9Kk4mDFT9WYgEnaFJcB2E7bgEDkm3PDUSEY+l++Z1x/fZXwA1YqpbQC7uwsJKbFLlmAQzMGaTH4MMIdh93JuROxtYxyj/kDvAqeABjsKhvjMinXRZ1nbEYGBNq2kyJpghHy99BFhpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsWo+rfU; arc=none smtp.client-ip=209.85.208.53
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-698bf7a1a2dso2386605a12.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 02:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783761152; x=1784365952; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SN7mHS7hqYCVkOLfVfbV8OTyhnbG54L9cTrZjvi9uwY=;
        b=gsWo+rfUmYCnQj8dadtyJecKJEtCI2n9ILhshUtMwZ131pC+x34jIgqovtS2yYHdJb
         M1Tdrn40oQO5JpLtbk8R6BmL5Dwe0NpcA0Np/twypmVXZXjLkKYCOUHjL7ftiy+Nly2k
         9/pE7wrtVL0Qjev6nzhqiiJOFOxX4o/Oe8wOq/Nt2KiAizNqAvnoDKkYMghQZVSdS6nx
         Yu+5wvrstFMZpkTSNriJD/mqpfVD5tv9pzOFEEChGcC7QBLsIxjPEiMONj5LgUSHtNRi
         4lneRvNLpxy8xbAL584cOnGVZGCft/AP6N6vLzvNQWvaVUvBUMrBwU91AqGG4BP0YHrw
         JceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783761152; x=1784365952;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SN7mHS7hqYCVkOLfVfbV8OTyhnbG54L9cTrZjvi9uwY=;
        b=cb4pDpUvWv5GiudnRgPUWWBoqjvXihAMmSS9HipWMS2Sc+pCQ9ajfWIKgIj8Hmu9rs
         nZWTbZ9d4vcESLzT8foAc0RgVBfVWN4detjcTwtrgCSrbAqyyQ4hgWR51ZF2SX6ePoOt
         8yBYsfhQLBGMmWxIbEHmu6W/FFUuxNh2unOXogf3z2u/gfLDmgbHFpoFcFyMH4V4DvQq
         XX9ou+LTc/vUUSmYzbwrF+tH1hZmK6n6enxPQ+NcaJwbAf9ssNgxseC4ZdyXb7AjHa9Y
         uRfbBgRYLg0V55FE4om1EvhWV6VfvO14cKgm7FoVug1bvX90JH57P6KYsMllTbk4Fqom
         zrjA==
X-Forwarded-Encrypted: i=1; AHgh+Ro4KeudMBx1M1gHX6g0qbTSpRA3bH7dkiUZZgpZaB2Z2knfKmz4H/7MnHtu3yHjtxyGvXY+lig=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywrjy6/hJhpOAxXx6gOAKgaZJZIP8RCdFgj9oOp4TaXMLwn/42w
	vUL6j7c4KQlxbF9zt68bPhK0uRr49Ji5gWxeCdQ1RqkQejy5Q5JnvQvj
X-Gm-Gg: AfdE7ckxBN4IN+hV0vrDmtuRxLXlDJJeqmQvOfWfZKOxkdhW5z7uxom7P8JlvrpK3mI
	kErsHy378oThmmSxNLivS9tKRTtZ3gkN9vCuWs/FX/KX1EdRWiC+DsVfHW/gvnKEG0lw/IVWA+1
	ZPJe/KDnL5ozFFnMfDHa1BqpUWH7lUTuvUOpYfVvT4uBdSNrDZwbnUs2Q1U+80hBcsTL052QZrC
	RRAPz0aiMEoBWR4AOnCsmgMDUJlg4UIm6KciGJKqp9GchucqXC10OWJRVO5FY5bUTayW4jVM9fD
	TkzyNaBZacFQTDHIu9p4nldP+B2kDrugXA+OHxxs0XJw7JZ+Zgs/NkAhOYQbPqm+ElOmviDndgZ
	myGyaRctFAncIcqKJZ/X2zH/HQyAj36VNjr//USXCIZ0MEHagHkfysXYZCMrnle1+CUpsrGeeFl
	lY17GggYVmXNfht5Vljc9hyki1RLuWbZmI1Tboub15Q1UTGGf21zO2J/9fq3DknJAFMP2EJYq3j
	O+b5ODBzRJY9djQyBpUn7YgWLGa5SjOwiH1QGLyRnJwRJXk2473Mptt+A==
X-Received: by 2002:a05:6402:1cc9:b0:695:822c:1083 with SMTP id 4fb4d7f45d1cf-69c5f124c51mr1053684a12.28.1783761151896;
        Sat, 11 Jul 2026 02:12:31 -0700 (PDT)
Received: from 127.0.0.1localhost (82-132-221-54.dab.02.net. [82.132.221.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-69c60d47188sm681191a12.27.2026.07.11.02.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 02:12:29 -0700 (PDT)
From: Pavel Begunkov <asml.silence@gmail.com>
To: io-uring@vger.kernel.org
Cc: asml.silence@gmail.com,
	netdev@vger.kernel.org
Subject: [PATCH review-only 08/17] io_uring/zcrx: don't pass ifq_reg to area creation
Date: Sat, 11 Jul 2026 10:11:31 +0100
Message-ID: <843ae4982c9e590713ac23ebb470dc0731b4da7f.1783616211.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <cover.1783616211.git.asml.silence@gmail.com>
References: <cover.1783616211.git.asml.silence@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306776-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:io-uring@vger.kernel.org,m:asml.silence@gmail.com,m:netdev@vger.kernel.org,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AD1AB741009

We might want to create an area without having an instance of struct
io_uring_zcrx_ifq_reg. Extract a helper that doesn't have the ifq
registration structure as an argument but takes the buf length
explicitly.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 io_uring/zcrx.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/io_uring/zcrx.c b/io_uring/zcrx.c
index cfbfbd262f90..79099a78f8cd 100644
--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -460,21 +460,22 @@ static int io_zcrx_append_area(struct io_zcrx_ifq *ifq,
 	return 0;
 }
 
-static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
+static int __zcrx_create_area(struct io_zcrx_ifq *ifq,
 			       struct io_uring_zcrx_area_reg *area_reg,
-			       struct io_uring_zcrx_ifq_reg *reg)
+			       u32 rx_buf_len)
 {
 	int buf_size_shift = PAGE_SHIFT;
 	struct io_zcrx_area *area;
 	unsigned nr_iovs;
 	int i, ret;
 
-	if (reg->rx_buf_len) {
-		if (!is_power_of_2(reg->rx_buf_len) ||
-		     reg->rx_buf_len < PAGE_SIZE)
+	if (rx_buf_len) {
+		if (!is_power_of_2(rx_buf_len) || rx_buf_len < PAGE_SIZE)
 			return -EINVAL;
-		buf_size_shift = ilog2(reg->rx_buf_len);
+		buf_size_shift = ilog2(rx_buf_len);
 	}
+	if (WARN_ON_ONCE(ifq->niov_shift))
+		return -EINVAL;
 	if (!ifq->dev && buf_size_shift != PAGE_SHIFT)
 		return -EOPNOTSUPP;
 
@@ -544,6 +545,13 @@ static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
 	return ret;
 }
 
+static int io_zcrx_create_area(struct io_zcrx_ifq *ifq,
+			       struct io_uring_zcrx_area_reg *area_reg,
+			       struct io_uring_zcrx_ifq_reg *reg)
+{
+	return __zcrx_create_area(ifq, area_reg, reg->rx_buf_len);
+}
+
 static struct io_zcrx_ifq *io_zcrx_ifq_alloc(struct io_ring_ctx *ctx)
 {
 	struct io_zcrx_ifq *ifq;
-- 
2.54.0


