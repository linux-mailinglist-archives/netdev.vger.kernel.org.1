Return-Path: <netdev+bounces-255532-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MLcWOUqIfmlkaQIAu9opvQ
	(envelope-from <netdev+bounces-255532-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:55:06 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F13BC443D
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 23:55:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA3BB3020017
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 22:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E70378800;
	Sat, 31 Jan 2026 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EcUxlbd+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333FD376469
	for <netdev@vger.kernel.org>; Sat, 31 Jan 2026 22:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769900097; cv=none; b=K1eEkvyWAidOWLJCpVzhxIoZHQueBXsgjoCriJD/K1k50nOtT+rC/QEu3wo2v3Yb6CS1E7e64QaIn/jzjWw0OD4PH7iWcYuDOHQCd+0WHkG2m1WbJQe1/TR4lEs+K0xyO9msMPFF8O/K5Kvbpq+5Uu30cHPAKHLhARuNxUY3yyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769900097; c=relaxed/simple;
	bh=3pii18ZchJqzbG8bH0JNq+EL4aIfGLn1g77OaUlCRaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ez4EfxaPaN9jTtADtO9TNHgZ5/dKwPqtLvuoXjpLCH62iXOQPhVzqN9tqUr9wjw1I1Ve04GU70eBikCUs1r2o+2LMhNENZWEEMxFoF6FeSg5PzgSPuTaDrFcswL4bUbCAPwzTbTFzsuwOf5rpdJKs5n569glosEmyfv/WwEA/z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EcUxlbd+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B2A6C19421;
	Sat, 31 Jan 2026 22:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769900097;
	bh=3pii18ZchJqzbG8bH0JNq+EL4aIfGLn1g77OaUlCRaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EcUxlbd+4yDaIZwM6sl6zSfL9p+hVm8Zb2xrItJnJB32wV7hN663M9qqQ0q1HL9cN
	 LXOjjXcrO8DV4ZeTlpet0yFdU5lAasadKdOs+zWRzwGZg2EYYmu3+EvzkWMtAqN83o
	 YcIp7GsINl//cw9xgFmO9Pw0XXCmgwQ10VoVrBOxE5WN8KsvteHPaFRXTmvmiA//Gq
	 QsknWb2bCLvxQdrLFzQXPxp+6JFYsPqSpORX2713y6GrxIFopQLVXFAQSn8Q5uSVKn
	 DgZDeuibiuptO/O9j48sE3rzD57UyJdDAbAsstgj6VZTKjpIjMNkH5v9X0bKKndjoF
	 bPdbAvn3t3c9g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/2] docs: networking: mention that RSS table should be 4x the queue count
Date: Sat, 31 Jan 2026 14:54:54 -0800
Message-ID: <20260131225454.1225151-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260131225454.1225151-1-kuba@kernel.org>
References: <20260131225454.1225151-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255532-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7F13BC443D
X-Rspamd-Action: no action

Spell out the recommendation that the RSS table should be
4x the queue count to avoid traffic imbalance. Include minor
rephrasing and removal of the explicit 128 entry example
since a 128 entry table is inadequate on modern machines.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - new patch

CC: edumazet@google.com
---
 Documentation/networking/scaling.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/scaling.rst b/Documentation/networking/scaling.rst
index 99b6a61e5e31..0023afa530ec 100644
--- a/Documentation/networking/scaling.rst
+++ b/Documentation/networking/scaling.rst
@@ -38,11 +38,15 @@ that is not the focus of these techniques.
 The filter used in RSS is typically a hash function over the network
 and/or transport layer headers-- for example, a 4-tuple hash over
 IP addresses and TCP ports of a packet. The most common hardware
-implementation of RSS uses a 128-entry indirection table where each entry
+implementation of RSS uses an indirection table where each entry
 stores a queue number. The receive queue for a packet is determined
-by masking out the low order seven bits of the computed hash for the
-packet (usually a Toeplitz hash), taking this number as a key into the
-indirection table and reading the corresponding value.
+by indexing the indirection table with the low order bits of the
+computed hash for the packet (usually a Toeplitz hash).
+
+The indirection table helps even out the traffic distribution when queue
+count is not a power of two. NICs should provide an indirection table
+at least 4 times larger than the queue count. 4x table results in ~16%
+imbalance between the queues, which is acceptable for most applications.
 
 Some NICs support symmetric RSS hashing where, if the IP (source address,
 destination address) and TCP/UDP (source port, destination port) tuples
-- 
2.52.0


