Return-Path: <netdev+bounces-304288-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8Pn8IlHqRmrcfQsAu9opvQ
	(envelope-from <netdev+bounces-304288-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:46:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF0C6FD494
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 00:46:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=RpDoEVoH;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304288-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304288-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E939B3074680
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 22:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0584E3D4107;
	Thu,  2 Jul 2026 22:42:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj2-f2.google.com (mail-pj2-f2.google.com [74.125.227.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF83A3D332B
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 22:41:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783032121; cv=none; b=cv7TFFNUZP8kjDGNwyGOSjra8RtayvqSGdr8er5MD7y+oZjnIIVqee0QSNO4c8WEJnQHUmfEPCC00odep3XvF08QolI0TAzmKPk6BhCjJiOfDanBEMzNIxgpNUTCibqBlE1/jlEYVUfYFoSZnQyvZ/lqYgbokeYH6bBWmRuxm7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783032121; c=relaxed/simple;
	bh=VGn/FZ4DxFBzmOwuxViO2XXzhRDLgCNWGc0DjnZKhug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FtgT5EJqhRo0OC2JZFnvyG2wPy6LebXLBsycmBE4pmyIXHiJCy9/a9j+//tnw4hg5tDoFW6yso55NzkwGKMWA/n7h+eKAXkUko76oPVYfZD/FYbUhbYljjI6v1sXiZy6UHQJJP5x1oMBPsJ3syxfGOspnTKLVkeCzGq4QJdNglU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpDoEVoH; arc=none smtp.client-ip=74.125.227.130
Received: by mail-pj2-f2.google.com with SMTP id d9443c01a7336-2c9dc2dafeaso9333385ad.0
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 15:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783032117; x=1783636917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U8Q3pzjelt/1WF+Qy/0h3ZAikUKaGYEjLPL9xAA8IEE=;
        b=RpDoEVoHlGQf+efMLGT2IEw5QvgzDacpSOgqTxOtjoqnTlBh71FbS/Jvvs0rXdb6L1
         RmrVrvsbvgTQKX/zl7PWgf7rs4qeyV57FjzQiklrc4/f3DF4aa7vXljV4/oeUwf99RpV
         CuIdz3JwrWJNTcyWwYaRtu43VaW9p4Ynv+shnA7Xe9AkEE2RytdxkK+ZZbLCzZckI2gk
         3I1pu+MjXHBNO1ntedLLlr5ix+yQIdGNSLEfhWKqeN59LPl1cDWzRzrCVOvw3Aoc2tkf
         sEBtdCruSGyj9SrG1SUk3a0A4NhJlsY9N3inoaNelWstUeDdMIuxcZOz9U8FbqMTa/Qm
         pLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783032117; x=1783636917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=U8Q3pzjelt/1WF+Qy/0h3ZAikUKaGYEjLPL9xAA8IEE=;
        b=Bx+i2XaRRPrN034kqVb5WrFiOlB4xCTQPcElb6Zy61Md+m/uugZVKFmnm8jt2UGG0o
         T7Yp4w6aG/7Sdowl77Kd/+jOArZJRI/NdTd4CJFZaCF2sFaKc8yY9bOz6qTwdDMesrCC
         vjAM3BMUivw5CfpVFCae2AnV0bbMXv2QOJLvjXHuzzSrNXimDYN6HYNdvxJZU4VXVC3j
         U6rpWpnojtRbtkYGWIpFkGjBwg28tiI0pj/CjFxMtHhgZIx50ooO9QzwexAYXmkPpW4i
         IcqznnoQ4fy93WEQfqWINVXiVUNlKfxFBWMKmtIq2bUs6iMspV8bgdJ46pDUq2STmvCN
         PzkA==
X-Gm-Message-State: AOJu0YyIZVdv18FPl2WyfSW955ql2x2aa5p+3Myi+2uIy872yndZfrxt
	ti1ckAcUugU9NkEuc670yn+HMgszjHV8L36bjJJMF3Ku5fCS9+adaEnA1zVXbHjy
X-Gm-Gg: AfdE7cmnj0r+hPkPy3WSWbmQncqWfL3TgoQ5pIHU+fozG2H+Fu4AQznF2FzLOeKnDPl
	4jbslXPSjtqRNWRA0lwWgaD/1wsDI4MoOouDVPDTGqZPi+9cGl8DyxR3vfDWPofxPSoCVh4BNvM
	J/WaGp3lrSLyiFjTsnhe7r8OT8ZTSWUpINbC6Dit3HTHkn9OxL9zFssRUu5cL5VojQALS41G+QX
	6Ai+BlaJwodgOOvF0wx8IJPfTBc6BEKYoOrnFD8PqC3KfoqpT1gS/uKq22WBwKaOChzyh48itR5
	U4qbNcoQ8ySq8ugzR3aE7Sl6REagUVKQJ5F7lcn1TDh6awLbhWITRLYnGtEu3UK2S5IklF+k6WQ
	R7ww9m/Q9TZHYVD6NOHIqaPm6gxkzKE+Mum1Sj9mXYPg/fj2ElqH29kzgSytpHXJoZYI712nepz
	Ce3s29
X-Received: by 2002:a17:902:d4c7:b0:2c9:97a7:3276 with SMTP id d9443c01a7336-2ca7e89a620mr91739115ad.39.1783032117088;
        Thu, 02 Jul 2026 15:41:57 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ca9a9cd0dcsm19484465ad.38.2026.07.02.15.41.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 15:41:56 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v2 6/6] net: document NETDEV_UNREGISTER unlocked rationale
Date: Thu,  2 Jul 2026 15:41:50 -0700
Message-ID: <20260702224150.3730033-7-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260702224150.3730033-1-sdf@fomichev.me>
References: <20260702224150.3730033-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304288-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,fomichev.me:mid,fomichev.me:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DCF0C6FD494

The lock-state table marks UNREGISTER as unlocked without saying
why. Add a short note that many handlers release the lowers via
dev_close().

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 Documentation/networking/netdevices.rst | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/networking/netdevices.rst b/Documentation/networking/netdevices.rst
index 1bb68a73bb67..c8b15f6926ed 100644
--- a/Documentation/networking/netdevices.rst
+++ b/Documentation/networking/netdevices.rst
@@ -427,6 +427,11 @@ For devices with locked ops, currently only the following notifiers are
 The following notifiers are running without the lock:
 * ``NETDEV_UNREGISTER``
 
+Many SW devices (uppers) catch their lower's ``NETDEV_UNREGISTER``
+events and may interact with them via ``dev_*()`` handlers, which take
+the instance lock. Until we convert these devices to ``netif_*()`` variants,
+``NETDEV_UNREGISTER`` stays unlocked.
+
 There are no clear expectations for the remaining notifiers. Notifiers not on
 the list may run with or without the instance lock, potentially even invoking
 the same notifier type with and without the lock from different code paths.
-- 
2.53.0-Meta


