Return-Path: <netdev+bounces-298989-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id xE15InuMLWqHhQQAu9opvQ
	(envelope-from <netdev+bounces-298989-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:59:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA4967F1AD
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:59:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fjBbDRUn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298989-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298989-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B8BEB300371B
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 16:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91AFA3FFAA3;
	Sat, 13 Jun 2026 16:59:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7334337F73A;
	Sat, 13 Jun 2026 16:59:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781369971; cv=none; b=V8MAdzrI4TdOb4fSPq9EUY9yc0dkF9vqL+sSYBg29Il6pCfVXMW74AXVLIb6Iot+FZbwGLPYcG4ngcUnBPeJDPBpilj6tH88KQzuDVgUQ5QBHHWkcBAYl5jxb34sGCzbikvmeeCIEvA6/stU0IhlmhwX5c0nBNDH5w96HYncz2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781369971; c=relaxed/simple;
	bh=WsM6hIwBlgKP/iJGhCTYw+fxP60SFox4pLMYNunMfxM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+3bvw9QODowOMmHx/Zmzvj7I/+eClBkUNSyrLPEdGyoVlg95HMguo9m59WOXXiy3p6CIKCyb+89TsOZDg7EGUiryquWT48vfvhavsnRn4o8nI3gSrPTsgxaCMGpq67dkBytHA4Mm12+81bugdIX0cNWL/go9IO9vKZOo7AAk5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjBbDRUn; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF481F000E9;
	Sat, 13 Jun 2026 16:59:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781369970;
	bh=PoyqbnMOKGL4zdJyLQEydV3BYKBfmL/0A6dqA3GuXPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fjBbDRUn7OqBdyHL/ZSxj/DqZATg1Ojrl4v4Up4ylL0zqStpmk2D/ngCrTEAW5w5F
	 ISIrr9lxlPS/rjuBgjkSeDvkIvES8HONLePKuGH1TcBqywWP1XF2GffoaPdr3k8FXJ
	 5pp6J88pk8sntb9XzgTHc141g8JBletaT+fuRjYkh0dITJTKerZKWuJ0qS5YGFrsyZ
	 KgmRADTNdwCTM+tdEqqsjoismotD45Crt915w3rCef4oLJQM/V8AMj8UW5GGSxX4n9
	 wiOZfTHCX36f2gxvG1TfReElJlKZJLqiPB4C5XTdypyGwb4TgpFURQgVrz1znXI0Dr
	 hQMebJQv0hEOQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	linux-doc@vger.kernel.org,
	john.fastabend@gmail.com,
	sd@queasysnail.net,
	jiri@resnulli.us,
	Jakub Kicinski <kuba@kernel.org>,
	skhan@linuxfoundation.org
Subject: [PATCH net-next v2 3/3] docs: net: fix minor issues with strparser docs
Date: Sat, 13 Jun 2026 09:58:46 -0700
Message-ID: <20260613165846.2913092-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613165846.2913092-1-kuba@kernel.org>
References: <20260613165846.2913092-1-kuba@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-298989-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:davem@davemloft.net,m:netdev@vger.kernel.org,m:edumazet@google.com,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:horms@kernel.org,m:corbet@lwn.net,m:linux-doc@vger.kernel.org,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:jiri@resnulli.us,m:kuba@kernel.org,m:skhan@linuxfoundation.org,m:andrew@lunn.ch,m:johnfastabend@gmail.com,s:lists@lfdr.de];
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
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,gmail.com,queasysnail.net,resnulli.us,linuxfoundation.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,lwn.net:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7EA4967F1AD

Not sure if anyone would read this doc, but the API has evolved
since it was written. Update to:
- show the int return type for strp_init()
- refer to strp_data_ready(), not the old strp_tcp_data_ready() name
- direct users to strp_msg(skb) for strparser metadata instead of
  treating skb->cb as struct strp_msg directly

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: corbet@lwn.net
CC: skhan@linuxfoundation.org
CC: linux-doc@vger.kernel.org
---
 Documentation/networking/strparser.rst | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/Documentation/networking/strparser.rst b/Documentation/networking/strparser.rst
index 8dc6bb04c710..372106b61e65 100644
--- a/Documentation/networking/strparser.rst
+++ b/Documentation/networking/strparser.rst
@@ -40,8 +40,8 @@ Functions
 
      ::
 
-	strp_init(struct strparser *strp, struct sock *sk,
-		const struct strp_callbacks *cb)
+	int strp_init(struct strparser *strp, struct sock *sk,
+		      const struct strp_callbacks *cb)
 
      Called to initialize a stream parser. strp is a struct of type
      strparser that is allocated by the upper layer. sk is the TCP
@@ -95,7 +95,7 @@ Functions
 
 	void strp_data_ready(struct strparser *strp);
 
-    The upper layer calls strp_tcp_data_ready when data is ready on
+    The upper layer calls strp_data_ready when data is ready on
     the lower socket for strparser to process. This should be called
     from a data_ready callback that is set on the socket. Note that
     maximum messages size is the limit of the receive socket
@@ -123,9 +123,9 @@ Callbacks
     should parse the sk_buff as containing the headers for the
     next application layer message in the stream.
 
-    The skb->cb in the input skb is a struct strp_msg. Only
-    the offset field is relevant in parse_msg and gives the offset
-    where the message starts in the skb.
+    The strparser metadata in the input skb can be accessed with
+    strp_msg(skb). Only the offset field is relevant in parse_msg and
+    gives the offset where the message starts in the skb.
 
     The return values of this function are:
 
@@ -176,11 +176,11 @@ Callbacks
     received in rcv_msg (see strp_pause above). This callback
     must be set.
 
-    The skb->cb in the input skb is a struct strp_msg. This
-    struct contains two fields: offset and full_len. Offset is
-    where the message starts in the skb, and full_len is the
-    the length of the message. skb->len - offset may be greater
-    than full_len since strparser does not trim the skb.
+    The strparser metadata in the input skb can be accessed with
+    strp_msg(skb). This struct contains two fields: offset and full_len.
+    Offset is where the message starts in the skb, and full_len is
+    the length of the message. skb->len - offset may be greater than
+    full_len since strparser does not trim the skb.
 
     ::
 
-- 
2.54.0


