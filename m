Return-Path: <netdev+bounces-278800-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KDRlBwKi32mBXAAAu9opvQ
	(envelope-from <netdev+bounces-278800-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:34:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6854C405571
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:34:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00443313927A
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1741D3D413D;
	Wed, 15 Apr 2026 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b="XWj7bgZ1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958823D3CFB
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776263318; cv=none; b=kce+CHZhx0iXyXiFCHA3QMrT55vXV10VLCsDCKCcsIv2n93pv8t8O/Wuc53dZIzfGc0htVwVWi90RRxgRjqYfSzD6Eht/YayArQWezAEtbTle3Nq0DJE0Mos5MANMcj8T8cg4kRnESagcfKZ2iJiHgY03rjIf4KgTj+WnCUE4+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776263318; c=relaxed/simple;
	bh=ofaAbqx2czVon4Zjr9AEkQANDqZ/drbpS6x/Vapo7H4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDfONwFQenL8knNNUDcu97MB1apfhz/s3cRBfHod7V1zozaBUM2DWd8n5FcRQXcRsYyttjGgvBpullMc9eb94mXahPiXJNYGQmmi3/+1LFDrAE+ldJWn6EJHt0uKenvL8KoWnQxDfcokqBNzcx59h5I6Afvbh9O1rnEXEhv28Ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org; spf=pass smtp.mailfrom=networkplumber.org; dkim=pass (2048-bit key) header.d=networkplumber-org.20251104.gappssmtp.com header.i=@networkplumber-org.20251104.gappssmtp.com header.b=XWj7bgZ1; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2ba895adfeaso7219929eec.0
        for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 07:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776263313; x=1776868113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o4nxWpPJd0zdXl12qY8AdbxQWZgfliKAONcy/KEnN70=;
        b=XWj7bgZ1H4CaOOUxf22qv0ebik8H7YiZI/iqK3INYW7rc4V5cUxzK4pQ6QUboUKKPb
         PIawld2QDKvnrg3u3OUw4GctytyI9y8CqpMAA7Po6lviT/bFjUxQH/3aZQGcseRhWLv4
         dWnf1qNKJzu9C0R1eePKmbM/lxUXZjW4fqXKY9zF/OgiONtbKD8wIgnF/IoeG79YJQ7y
         vM3CYsrJyrIc8nZdACYEES6BUAQrbf8jd59AdGxQLI5YuhOWng091TjbgH/foPgFP49y
         wd/QCUbN/qd5fCyfAcqqLBv78uMIO1u51i9Yw/rzmhxvSsA/LvfPcogcHwmcJcNeqt5m
         aouQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776263313; x=1776868113;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=o4nxWpPJd0zdXl12qY8AdbxQWZgfliKAONcy/KEnN70=;
        b=SJSwUo/Bs4EabTgOuKxv/YJOA5tcWAXNV5QM5zkT0DGUNO0IWY+wV0trecSYg/Q141
         zMUb38YpQcgRYxr6sCEk3dnPgovueN0W/3of8VRULiM2UKib+2e9J03ot6Pm2AdU7USM
         f4+TxGi0Ft4ZUMtTwGFqLFJRrcxkROL9x2t7UG8SsGD31HPRu5TIfKMYA3Xh+IIUHe2M
         Fcj5weOMdJOsGRRcJwDAysTRkudKKO5Jjbwumn4I3MmLI2eTBei1SfsgLFZNolFykN8t
         gUnZEzD30eapnvubtY18rnpkVCpy/NbmKyILQog0PLSqgjRvGhsyuwXIEezAHSIFgW3v
         4b9A==
X-Gm-Message-State: AOJu0YyAwu//nIhkAzNRadnRa/rrx+RNE46xq3RgFm3U8d4281Gl/fS2
	6ZXKA9Dw+2x83zy74tqQdL/t+GPHQCdDPugivZ44mc5mgHTx5VbmAHqADqEaZj8dXx8F/MNs5Xn
	sZzfR
X-Gm-Gg: AeBDieuT908j0naEDU29Fj1YXiztmP21axu771HUzDye+wHnH/OPMIvOb8Z0Zizvadp
	gw0csPf3Qwzc0tJZ9L+pVhxR62aRcenMwncKpc2e/6J9W7+u+pyaRzWSQYGRczwBHuqqsJrr5nI
	YfwmcX/S7Z8QX25cDUYb7W3krZkyUgVRnDwz+HYZGuGyJvBBx2XnO4RhR0FnG56F5gr9Mr6Vri6
	yxyOLRtx9vy26IZ06bE4i3bRqG4xQKyGXk8lYuiOqrRJjCSXF1WXQgKdLzIxx3TWigRkbUnki0r
	iX1OTX0W7aGQ3ZueKxjT1dc3kkXNo4Gj4zO6TW6JXIZdBxx7qlL/PYP9rnsZDAz3+/J+fo/XzOE
	CnaXJgs/aNQY09O4yXms80U+l31E8x4ALk32LuzKEO5eTHCO2T/mbumTybdw5gS+UT0K8gYRNba
	ucS8SzeE/GTV1k/OuM/0vXJc4WS5/rs9ZN2UsqtD023Pu69i/L3hN3zw==
X-Received: by 2002:a05:7301:18a6:b0:2d9:a799:3c4f with SMTP id 5a478bee46e88-2d9a79961f3mr4013649eec.24.1776263312569;
        Wed, 15 Apr 2026 07:28:32 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2de8eb84813sm2751347eec.18.2026.04.15.07.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 07:28:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yousuk Seung <ysseung@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v7 5/5] net/sched: netem: fix slot delay calculation overflow
Date: Wed, 15 Apr 2026 07:27:08 -0700
Message-ID: <20260415142822.133241-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415142822.133241-1-stephen@networkplumber.org>
References: <20260415142822.133241-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[networkplumber-org.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[networkplumber.org : SPF not aligned (relaxed), DKIM not aligned (relaxed),quarantine,sampled_out];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-278800-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stephen@networkplumber.org,netdev@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[networkplumber-org.20251104.gappssmtp.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[networkplumber-org.20251104.gappssmtp.com:dkim,networkplumber.org:mid,networkplumber.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6854C405571
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

get_slot_next() computes a random delay between min_delay and
max_delay using:

  get_random_u32() * (max_delay - min_delay) >> 32

This overflows signed 64-bit arithmetic when the delay range exceeds
approximately 2.1 seconds (2^31 nanoseconds), producing a negative
result that effectively disables slot-based pacing. This is a
realistic configuration for WAN emulation (e.g., slot 1s 5s).

Use mul_u64_u32_shr() which handles the widening multiply without
overflow.

Fixes: 0a9fe5c375b5 ("netem: slotting with non-uniform distribution")
Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_netem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index 8593e62f3c6a..41e56908ab0c 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -659,9 +659,8 @@ static void get_slot_next(struct netem_sched_data *q, u64 now)
 
 	if (!q->slot_dist)
 		next_delay = q->slot_config.min_delay +
-				(get_random_u32() *
-				 (q->slot_config.max_delay -
-				  q->slot_config.min_delay) >> 32);
+			mul_u64_u32_shr(q->slot_config.max_delay - q->slot_config.min_delay,
+					get_random_u32(), 32);
 	else
 		next_delay = tabledist(q->slot_config.dist_delay,
 				       (s32)(q->slot_config.dist_jitter),
-- 
2.53.0


