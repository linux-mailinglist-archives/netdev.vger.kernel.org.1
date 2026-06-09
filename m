Return-Path: <netdev+bounces-297272-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nHipIRt0KGrVEwMAu9opvQ
	(envelope-from <netdev+bounces-297272-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:14:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 235776640BA
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 22:14:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B7fNvFMP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297272-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297272-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0572B3058B82
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 20:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 108C33B775A;
	Tue,  9 Jun 2026 20:12:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D399C37A4B9;
	Tue,  9 Jun 2026 20:12:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781035949; cv=none; b=F4i6VGCdDyg6soqgrtXMunmesQXWSSnbfWyMehMhUsWyURIywd89D1NlS0MlUOUGak5WKuGUXBHsv3CIq5IxiwzcUx0MG/Nr7l1BUrfrJDnvlhq8DMCP9vB5cY+uJZKfPKywMbkXJToaejRNT/pFLyzHGtscqpxrdmuRr6o2xkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781035949; c=relaxed/simple;
	bh=NFiqVKfJAWu9Jxe63lmkVmmow46zdGwaFGVjKVYfUOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hF/mWkTyETRs5kfqjl8+bOmS6N5qJryOCIpRrHWkM74uL6HI7wLFlFWD3G0oo5Yp2ehdqzkQbaAvOPm0rYNrzrwN4YPtcXqi3sPoljp4lak14IjwDpLRwOtd30dBm7G8tU+VmFrBEui5FWNO8r5NVJTfpiqcd5HTJ7ZhIDtPGFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7fNvFMP; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343DF1F0089D;
	Tue,  9 Jun 2026 20:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781035948;
	bh=xlaHXL/dwpOmq1QcMg3P+QxgnKAOp4bWBq2VchZKBLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B7fNvFMPpQ0ZS3x6PuRlyYTQcOpBKP9eiUnUIcq37TpV4W3A12htxbwoazCGLnkap
	 vLxTcuvuLmhtzlmA2Dl3HWZ8fsg32QOoqdrytsu/2FmvOsuPIcBDBZgW7SA1DJc/jZ
	 Yud8ko1ycD2xQzMCS7UttNvmzj1arjIh9iNQ9xoOb73tLng1p71Dc5keWKEtnRF0mC
	 VJ6afJPHH/926Apeqj0yJwYmY3CUhOa+xNjLX/zkDKV7BpQNEnenjfiBJorimOmzks
	 WLTxjiiYymS6fRvd91AbmMibQ5fHO0jrLPD/jRRigqKX3uaV/W0qIUiEWRUnBZk0Hf
	 m9XY8W6CaNjPg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	bpf@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	skhan@linuxfoundation.org
Subject: [PATCH net-next 2/3] docs: net: tls-offload: document tls_dev_del, tls_dev_resync, and rekey
Date: Tue,  9 Jun 2026 13:12:23 -0700
Message-ID: <20260609201224.1191391-3-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260609201224.1191391-1-kuba@kernel.org>
References: <20260609201224.1191391-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297272-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:linux-doc@vger.kernel.org,m:bpf@vger.kernel.org,m:kuba@kernel.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,gmail.com,queasysnail.net,linuxfoundation.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,queasysnail.net:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:email,lwn.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 235776640BA

Fill in some gaps in the TLS offload doc:

- describe the tls_dev_del and tls_dev_resync callbacks
- add a mention of rekeying being out of scope for now

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: john.fastabend@gmail.com
CC: sd@queasysnail.net
CC: corbet@lwn.net
CC: skhan@linuxfoundation.org
CC: linux-doc@vger.kernel.org
---
 Documentation/networking/tls-offload.rst | 29 ++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/networking/tls-offload.rst b/Documentation/networking/tls-offload.rst
index c173f537bf4d..a41f46885e8c 100644
--- a/Documentation/networking/tls-offload.rst
+++ b/Documentation/networking/tls-offload.rst
@@ -104,6 +104,29 @@ at the end of kernel structures (see :c:member:`driver_state` members
 in ``include/net/tls.h``) to avoid additional allocations and pointer
 dereferences.
 
+When the offloaded connection is destroyed the core calls
+the :c:member:`tls_dev_del` callback so the driver can release per-direction
+state:
+
+.. code-block:: c
+
+	void (*tls_dev_del)(struct net_device *netdev,
+			    struct tls_context *ctx,
+			    enum tls_offload_ctx_dir direction);
+
+``tls_dev_del`` is mandatory whenever ``tls_dev_add`` is provided.
+
+The third TLS device callback is :c:member:`tls_dev_resync`, called by the core
+to synchronize the TCP stream with the record boundaries:
+
+.. code-block:: c
+
+	int (*tls_dev_resync)(struct net_device *netdev,
+			      struct sock *sk, u32 seq, u8 *rcd_sn,
+			      enum tls_offload_ctx_dir direction);
+
+See the `Resync handling`_ section for details.
+
 TX
 --
 
@@ -381,6 +404,12 @@ synchronization with an exponential back off (first after 2 encrypted
 records, then after 4 records, after 8, after 16... up until every
 128 records).
 
+Rekey
+=====
+
+Offload does not currently support TLS 1.3, therefore key rotation
+is not a concern for offloaded connections at this point.
+
 Error handling
 ==============
 
-- 
2.54.0


