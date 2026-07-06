Return-Path: <netdev+bounces-305066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id PHWDDLXBS2oCZwEAu9opvQ
	(envelope-from <netdev+bounces-305066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:54:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E49A7123C0
	for <lists+netdev@lfdr.de>; Mon, 06 Jul 2026 16:54:44 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eCAIvZB5;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305066-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305066-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 275433394178
	for <lists+netdev@lfdr.de>; Mon,  6 Jul 2026 13:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586983DDAF4;
	Mon,  6 Jul 2026 13:41:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78334381AF9
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 13:41:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345299; cv=none; b=mP0a3nB7pGgfJTzBUlc9713xC6sQYAQkz/SXzdHUWtTJnX4oy/aPSBcZISml3yzillM5wk4E4YyGJi0JI4ykYrfPx2vXhiwCJ0t6zyQKi36+SzNafmqg8yf5nKWg3tVrHGh6uLN8my09O7w62nYlZRC+Ut4eCYdGiMUQmmOmi9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345299; c=relaxed/simple;
	bh=mOW7N46Q/GBL6wFqSLKyexT/4QDxmkuAh3ixiMKAJ4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oIq/stPL0JB4E3/3aM8x3L90QO4Uq8M3m8tmL/UzAZ+A3QXDFbXjCor3tNg3anu5RgfLGDkl+66hh1bKSnfdjsT9ZTq7u72eaKSzD3CohqpYfr97xd/+9LXp0ytDFGQ7cFz40FQUzHCtgv4EtaARTLuu5NR/ToZzm1d5u0XaguM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eCAIvZB5; arc=none smtp.client-ip=209.85.221.52
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-46f88060e8dso452347f8f.2
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 06:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783345296; x=1783950096; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JD+TaV9k8N7lOgvw5CoTEnXWsbsPS2ZPLVs5YvnIoA0=;
        b=eCAIvZB5aYoS8wFDV0Y3zYwEfk9rucR9hwuOOKBIxsQ/i6GUee0qsgQHw8BU9YnHyV
         778a4I+u+bNnSdmQCezMnBP4oyB4uZmm40OIjgCTePCL8NLo+FMe9SgE7zHjrx0akMrZ
         jSV5RCDWByDozYFwc8u28pD/TdZR+AI+tmutB/PfQ23WFy31bzMXGSnXG5xpLJtYIeS6
         pYtgvoiMwhfKLenMNY+nLjLQvYtEegFKcjvZq0NEJtbA5YY3yHrxNT05GShqyMgkjTkz
         nXBVejgg3sfZQ6T8FZOTAMjy1qWxaglTU8FA6zu6k0imU5gdukWPOOhjQIXXVWUIVs4o
         /MMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783345296; x=1783950096;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JD+TaV9k8N7lOgvw5CoTEnXWsbsPS2ZPLVs5YvnIoA0=;
        b=BBr+HiQFjzKOGeoleKRhwTBes5C81xqMA9TPQpHlxpjQYLtre/JUxNxu+Ue7g/xx5c
         qXNdf+pHmgY9US0zlXvvWjGBddrZwUGBEZjkmToCD0IHZTQm7WL9SpFP0c3bAZ/TkqOv
         xDsWX+1FGoWQLmLnkStwv8NGbm+LZzZSofGX5j1XR0Iw8UrQNCyi8urrfXOkS3xFK1Gg
         xMe9upE6jykkyPkM/OsRkNlz2C90WMXZyxGwETDib3S7SuLOHTilqDndvbK1ouTu8Y8u
         CCMZGjofWfmP9xsfwtH9/aVwDR1/4h3I2+iQSMh9v19G1qBVxDoIZH+4ChLL8F0tbEqn
         CYrA==
X-Gm-Message-State: AOJu0YzRqG+rtBIlgjR5sTZSx8Idd5cyz+tcCqztIuIv1dfKoMECAQiY
	YNmnMsN87mhWco+VecUsDZybGJYxZrPTiPEJIDOOEzxeMhHgLoD65vbO32fLKXN2KGs=
X-Gm-Gg: AfdE7cmrQEYiECFMseI1W3ETiqJmoQgiM4JaA3XeYy4xoys90gTF7cJeKcTZ1mjBhep
	uTz5Np4foOsVDm9SI34dEbwY6y+BTHJifJkzGF0c9qicLm7osYfx3TsbxVcp7uIZbgm703Af8d6
	ImMpYc2NJ3DZTfD7olcWi0ornOC5e37+/pHbFAAG7JGOHx1iIP+W9a4qCMO7Y23HiV/a2CuelfK
	z0xt/IHf1vQSHB0bvyWr2UyELbAKCgsxagG9QBwTI1rayL2DmNaKQMP3ZOHvtlt69PsI6IS582h
	FLL4ocF7e+qxGybYpbvwUJ3LSzWamaFH8B5yj35ee8NWnhcy26vz022eUdJtI6zn2832Q9qt9zC
	hLzCHtqehpGZ+U1meSDkZ7vI4DrZ1NAHqpjQWjK4WJkrdiCzC+KpPKNFcZwln/zkT2OtfkKqxfQ
	wwg4LBSuGqsH2uxT9KaCHFsVuLlucxUqnDakk15h5Kvbuh4opw4NLJW48qs1CFSXKHXId5uGXa+
	VG7OUsNrOFBRARyjnxhmH+BJeJIlGYvFfH5vUCLR76/Tap66NE=
X-Received: by 2002:a05:6000:24c3:b0:472:3090:d87c with SMTP id ffacd0b85a97d-47aa997e947mr6896071f8f.1.1783345295801;
        Mon, 06 Jul 2026 06:41:35 -0700 (PDT)
Received: from hpubt (dynamic-2a02-3100-5b6d-48fc-6651-06ff-fed8-72a4.310.pool.telefonica.de. [2a02:3100:5b6d:48fc:6651:6ff:fed8:72a4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47aa039ae44sm23960881f8f.23.2026.07.06.06.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 06:41:35 -0700 (PDT)
From: Xin Xie <xiexinet@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Felix Maurer <fmaurer@redhat.com>,
	Luka Gejak <luka.gejak@linux.dev>,
	Fernando Fernandez Mancera <fmancera@suse.de>,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xin Xie <xiexinet@gmail.com>
Subject: [PATCH net-next v2 3/4] net: hsr: allow PRP RedBox (interlink) creation
Date: Mon,  6 Jul 2026 13:41:30 +0000
Message-ID: <20260706134131.61659-4-xiexinet@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706134131.61659-1-xiexinet@gmail.com>
References: <20260704234704.4297-1-xiexinet@gmail.com>
 <20260706134131.61659-1-xiexinet@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,linutronix.de,linux.dev,suse.de,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-305066-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:bigeasy@linutronix.de,m:fmaurer@redhat.com,m:luka.gejak@linux.dev,m:fmancera@suse.de,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xiexinet@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xiexinet@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E49A7123C0

With the PRP interlink datapath, duplicate discard and supervision support
in place, a PRP device can act as a RedBox. Remove the rtnetlink rejection
of "type hsr ... interlink <dev> proto 1"; the feature is implemented
unconditionally by the preceding patches.

Signed-off-by: Xin Xie <xiexinet@gmail.com>
---
 net/hsr/hsr_netlink.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/hsr/hsr_netlink.c b/net/hsr/hsr_netlink.c
index 8099f2069..88940e801 100644
--- a/net/hsr/hsr_netlink.c
+++ b/net/hsr/hsr_netlink.c
@@ -121,14 +121,8 @@ static int hsr_newlink(struct net_device *dev,
 		}
 	}
 
-	if (proto == HSR_PROTOCOL_PRP) {
+	if (proto == HSR_PROTOCOL_PRP)
 		proto_version = PRP_V1;
-		if (interlink) {
-			NL_SET_ERR_MSG_MOD(extack,
-					   "Interlink only works with HSR");
-			return -EINVAL;
-		}
-	}
 
 	return hsr_dev_finalize(dev, link, interlink, multicast_spec,
 				proto_version, extack);
-- 
2.53.0


