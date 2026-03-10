Return-Path: <netdev+bounces-265824-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YOp9ALNrr2m8YQIAu9opvQ
	(envelope-from <netdev+bounces-265824-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:54:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8FB243282
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 01:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E37F30152D2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 00:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D81280A58;
	Tue, 10 Mar 2026 00:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsRWNGpS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E5827AC48;
	Tue, 10 Mar 2026 00:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773104033; cv=none; b=iGLP6iO/3PxOIRB72R1zHB6bAFtAhki7X8KVKhO6uWku32CN6VVJdNmlsVxqT7Wa/AC4Zh2n9xmG6W9rOYXCVKE/6UgJHVndFXPVlsAr50SHWnmF13UrGyt72JY+xfX7EmCc8+XKJZUoCRC0kjDvnJyyVlmZ+z1MgUVYY00by0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773104033; c=relaxed/simple;
	bh=Q5P3Lby7BoTqsw3zgE6Y8mOLMaK67QqrUaEfwCfCBqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MJqpzOly+tJMLjAVHmSsE9UDTg/q9rmbKGyalv6evP7QEbNdwe7Q6r5nKtrLdz4OkHGeFgxwAQ+2zmmZr7SngIcAOh6gPIfk4YQVpGnmlk9nIYOQwir6GQVMZKdb0eI2MyCisV4ekpdwgbzbshMNB/HMrepz0JCMtTGhbaLErUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsRWNGpS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF6D8C4CEF7;
	Tue, 10 Mar 2026 00:53:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773104033;
	bh=Q5P3Lby7BoTqsw3zgE6Y8mOLMaK67QqrUaEfwCfCBqg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UsRWNGpSJPlsW5yjQB+jgugj9AnNjFA0MMOYnbNliUOxhCUNH3NI7YTFZmtAt06Vw
	 sBAi6M76Sr92kE7SlAGReTm/It3m2UwVMZJtIHgQq4UHMpWzz2eRwk+/11wgP00/Pb
	 /qC63vxcEdIlERFXhC1AvWbYI/jvagBmpI+ZvOhjHaIRlC/sJf64kRP/7FpfKhWiJC
	 Ld/oYoPF9D//NbPxw31fPAvckFS3BuENcct8DlPK4+Tz1fnsWPDK48BXWg0UgtguJc
	 vsDgyEI9kJvmXwvOL4/77yOBU/fVRfxqWDFi/txC595pOSZq/5R3Z4NPXih3HmYTJt
	 hMezVZE/vQ7ZA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net,
	donald.hunter@gmail.com
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/5] tools: ynl: add short doc to class YnlFamily
Date: Mon,  9 Mar 2026 17:53:35 -0700
Message-ID: <20260310005337.3594225-4-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310005337.3594225-1-kuba@kernel.org>
References: <20260310005337.3594225-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2D8FB243282
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[davemloft.net,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265824-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

The class is quite long. It's getting hard to find the user-facing
methods. Add a short doc at the class level explaining the main API.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/net/ynl/pyynl/lib/ynl.py | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/tools/net/ynl/pyynl/lib/ynl.py b/tools/net/ynl/pyynl/lib/ynl.py
index 17482c17a976..ec4d95f583fe 100644
--- a/tools/net/ynl/pyynl/lib/ynl.py
+++ b/tools/net/ynl/pyynl/lib/ynl.py
@@ -491,6 +491,32 @@ from .nlspec import SpecFamily
 
 
 class YnlFamily(SpecFamily):
+    """
+    YNL family -- a Netlink interface built from a YAML spec.
+
+    Primary use of the class is to execute Netlink commands:
+
+      ynl.<op_name>(attrs, ...)
+
+    By default this will execute the <op_name> as "do", pass dump=True
+    to perform a dump operation.
+
+    ynl.<op_name> is a shorthand / convenience wrapper for the following
+    methods which take the op_name as a string:
+
+      ynl.do(op_name, attrs, flags=None) -- execute a do operation
+      ynl.dump(op_name, attrs)           -- execute a dump operation
+      ynl.do_multi(ops)                  -- batch multiple do operations
+
+    The flags argument in ynl.do() allows passing in extra NLM_F_* flags
+    which may be necessary for old families.
+
+    Notification API:
+
+      ynl.ntf_subscribe(mcast_name)      -- join a multicast group
+      ynl.check_ntf()                    -- drain pending notifications
+      ynl.poll_ntf(duration=None)        -- yield notifications
+    """
     def __init__(self, def_path, schema=None, process_unknown=False,
                  recv_size=0):
         super().__init__(def_path, schema)
-- 
2.53.0


