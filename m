Return-Path: <netdev+bounces-258155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGLTDVCPi2nYWAAAu9opvQ
	(envelope-from <netdev+bounces-258155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 21:04:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5853F11EDF5
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 21:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 000F3303743B
	for <lists+netdev@lfdr.de>; Tue, 10 Feb 2026 20:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D92331A46;
	Tue, 10 Feb 2026 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b="mUnjdL4f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C73331214
	for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 20:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753865; cv=none; b=lQBcGUwonmrFce7SwhaxKBisD7vMO4G2TTUNyAokHgY6jvUrx0rBSrFGn+v4CRrGOcMDv67BVri7Zf8TQc14dAMHF+2/2j0AKt2rnsbgjxUnaxgTmp9qZfzpN2ZNQWWQdiJlxpaoprmd4aWubNlSZ0VK06Qn9IX1WjJxq1sQDXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753865; c=relaxed/simple;
	bh=sPmix59H2C1cYe6RWQi1HyeyyQZOU/8D95KeCn7K9QE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRlhtYoWnNf8Q7iYJIo8A2ct2GPvGkLLS/AwDR6x6a108ohJFI4o7kc8ypeqjH/hMrNROnRJMkrjaT0lcLAM/5xAgenbMVyvoAhqchfpu0ZWW2DjQ8ohOUwjgaSz4Qt4ed6awTCt5tZk2KYHEOxWR7dGdHb0/Erc/Pmq4BTcwmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk; spf=none smtp.mailfrom=davidwei.uk; dkim=pass (2048-bit key) header.d=davidwei-uk.20230601.gappssmtp.com header.i=@davidwei-uk.20230601.gappssmtp.com header.b=mUnjdL4f; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=davidwei.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=davidwei.uk
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-45f126d47b8so2842005b6e.2
        for <netdev@vger.kernel.org>; Tue, 10 Feb 2026 12:04:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=davidwei-uk.20230601.gappssmtp.com; s=20230601; t=1770753862; x=1771358662; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GtLJ51MVvzxIjJKbVfy4ay9B4kth9zqdhIvM1OEySYE=;
        b=mUnjdL4fq3jM2c1VMYbsTq/BX58NIA/Ac55SAwyg3xX3q9JK0CIRlnEP36CGzd3brF
         UATKd5KOux9n8Bs1LYVzM1yKroFY7is0rhmFa13FW+vsnNZGjh8RrceMEua1uOqvYNLh
         vDH1JMojDRm82DWiSdok4Jr69YgGGstHbqegFetxBiAny5RxJnUMQycxidZPunw6X3Uk
         Q9cHdbDgJ4mnRyHSimu83ehY21hNPZajMhUTRn4hfCdsYeaMfBnmzGk0Z4GBR3dj2tv6
         S8xgAn7wk1aXW7XGLm6QKau7Fzy4LS48PZ2wK0HeN5K+nFgz7VJtIqOWOGlUOTwn3UQu
         hb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770753862; x=1771358662;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GtLJ51MVvzxIjJKbVfy4ay9B4kth9zqdhIvM1OEySYE=;
        b=w9smDclZXkOEwDyyDutLOFitGR0JomeH4Z9NrqSVDKDCqSwYBYtqopBCdq2VJ4YMn6
         wrgOVHVWJec6ZR3Jann22VhBA1xx8DYTVd8LyMnhveagWzAzxU09ByhMUFZ4uqaHdH8L
         4SiBfhqqjfS87aW5r15u0bVfZyCaFoWTRC761Cf3b04GAmTPvOdBDDKO9Q2twl9SbH7G
         eEwAhmDkfoNL0l04p78QS8Z7xYHc3fOixWzU4EqgA54xm41dhjrfSsUJPeL3hhkkpifl
         sjD+9N8Rmk6BOrCpQ5TuWFu5bi9u91fJm6AbU9jFiKNCqAnj/9ctVkx4Lx3rWF5MnLwz
         lrcA==
X-Gm-Message-State: AOJu0YxOWBQyK0P51xoFh/LzukBRtU9Oq4hZHONDr9Zx+1siP24MiraW
	k2+3op2T3N7KLQaBkBc4vZyhTsZ/T8NHnlCEopKPQ0t6FB0JgGskY4dx7OfSARLxsTUyjDx2Nhw
	cvr/X
X-Gm-Gg: AZuq6aIdbOezecDAfWKqWChhewTRkvCYbks3hYZ9h+5bTWbqVB+17ClAgFu8umlIsIt
	hynRxzRuztGYjzyDSYRjGv4htxl+0QmLgeCjSyD/shG+HJe5uKNX9sBHohAiDMMHC4I8yEC5Eqv
	lVCKbsu8u+1nVTGasWpenjl12cHBa1RYjBsDVvrjEiuQf47xlxBrGjxEDwkzHyFkWJtT//zg/A3
	cbH65J5RSwoz/v7r4kGurAr9QMOkx1JSOuQEDbEfdBSXoEUfwccu+6tk9ET/u9vOfI7SydkAOSa
	K/AvOxIYSxwCsqQszooa8N+GFmLVyCpdLGh5h0qht/tzzoh/W2mE4wV06kwka8uz8uWfFdS3bOp
	V6hYnRb0tcHgpulloQRFjI8fCwialO8lTUuqpSSPOdMs72tx0Cl/TFi/7F1Seb8RVdZfzU4pGVm
	g/3/I0Thsret00RY5NX6SMLi9fJi0XSnby0ls4SFpqOg==
X-Received: by 2002:a05:6808:2383:b0:463:1f4a:3b91 with SMTP id 5614622812f47-463664676e3mr217023b6e.14.1770753861750;
        Tue, 10 Feb 2026 12:04:21 -0800 (PST)
Received: from localhost ([2a03:2880:10ff:5f::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-462fe9a12f5sm8917604b6e.5.2026.02.10.12.04.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 12:04:21 -0800 (PST)
From: David Wei <dw@davidwei.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>,
	Wei Wang <weibunny@meta.com>,
	Bobby Eshleman <bobbyeshleman@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next 1/4] selftests/net: Add bpf skb forwarding program
Date: Tue, 10 Feb 2026 12:04:16 -0800
Message-ID: <20260210200419.3555944-2-dw@davidwei.uk>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260210200419.3555944-1-dw@davidwei.uk>
References: <20260210200419.3555944-1-dw@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[davidwei-uk.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-258155-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,dama.to,meta.com,gmail.com,fomichev.me,blackwall.org];
	DMARC_NA(0.00)[davidwei.uk];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dw@davidwei.uk,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[davidwei-uk.20230601.gappssmtp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Queue-Id: 5853F11EDF5
X-Rspamd-Action: no action

Add nk_forward.bpf.c, a BPF program that forwards skbs matching some IPv6
prefix received on eth0 ifindex to a specified netkit ifindex. This will
be needed by netkit container tests.

Signed-off-by: David Wei <dw@davidwei.uk>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 .../selftests/drivers/net/hw/nk_forward.bpf.c | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c

diff --git a/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c b/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
new file mode 100644
index 000000000000..86ebfc1445b6
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/hw/nk_forward.bpf.c
@@ -0,0 +1,49 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <linux/if_ether.h>
+#include <linux/ipv6.h>
+#include <linux/in6.h>
+#include <bpf/bpf_endian.h>
+#include <bpf/bpf_helpers.h>
+
+#define TC_ACT_OK 0
+#define ETH_P_IPV6 0x86DD
+
+#define ctx_ptr(field)		((void *)(long)(field))
+
+#define v6_p64_equal(a, b)	(a.s6_addr32[0] == b.s6_addr32[0] && \
+				 a.s6_addr32[1] == b.s6_addr32[1])
+
+volatile __u32 netkit_ifindex;
+volatile __u8 ipv6_prefix[16];
+
+SEC("tc/ingress")
+int tc_redirect_peer(struct __sk_buff *skb)
+{
+	void *data_end = ctx_ptr(skb->data_end);
+	void *data = ctx_ptr(skb->data);
+	struct in6_addr *peer_addr;
+	struct ipv6hdr *ip6h;
+	struct ethhdr *eth;
+
+	peer_addr = (struct in6_addr *)ipv6_prefix;
+
+	if (skb->protocol != bpf_htons(ETH_P_IPV6))
+		return TC_ACT_OK;
+
+	eth = data;
+	if ((void *)(eth + 1) > data_end)
+		return TC_ACT_OK;
+
+	ip6h = data + sizeof(struct ethhdr);
+	if ((void *)(ip6h + 1) > data_end)
+		return TC_ACT_OK;
+
+	if (!v6_p64_equal(ip6h->daddr, (*peer_addr)))
+		return TC_ACT_OK;
+
+	return bpf_redirect_peer(netkit_ifindex, 0);
+}
+
+char __license[] SEC("license") = "GPL";
-- 
2.47.3


