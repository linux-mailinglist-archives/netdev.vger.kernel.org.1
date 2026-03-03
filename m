Return-Path: <netdev+bounces-263440-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UBSQGpJYp2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263440-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:54:26 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 882401F7CB5
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:54:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9FAF7302604A
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5F364F7961;
	Tue,  3 Mar 2026 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FohRnZma"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A42D4382F0A
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574826; cv=none; b=ELIS2km+458khkf21JjeGtXkbpRS/dte4Y6jJHlIcfS9VwQ1mlKtOpETREvczy4MY/yvpmndJKaU3kkqPeEuD3TvjBhFGLitD6xN7sN6pbmHl7wiQ25rIiN/+3QceG3iYcgEqcZU6NPXyTp6B8MsE5q06vuud5r2jeMpiW3ll5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574826; c=relaxed/simple;
	bh=jNT3fcozxniGFVL85I9aFeXnpydCb9Uf5Jwn81NeIys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BfXcr1taaQLFjq/AeRwnkoYKm1khxG0LZzMlmdXGA8m3HFO7e2f3L+3dfZS0nAiFcmJUAfUJgLK/5NIAxZGTw4TIo864K+zIhjEGAgSB9qMBQZ2/kVZsLROsjrMCi/C0nAxXq5n2qGSgtOnveuv/w0P0zb/p1eKT4hxdlBgY7iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FohRnZma; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 254E3C2BCB0;
	Tue,  3 Mar 2026 21:53:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574826;
	bh=jNT3fcozxniGFVL85I9aFeXnpydCb9Uf5Jwn81NeIys=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FohRnZmarWtKmYQiu+EKAgZEWO4/UP8CETPFBN/4d52q+feXmCSUuf0i/P5t8OFFl
	 cjgoENtTBogUYWzhbZopyWHXvL1VUaD+1z/bweT7x3Ov7wYfFir8de7Nexh3k9Zgeg
	 GgKauZnqPqh++iM29rJRaq4n1Hsoql4oRkFHhB9mBsyLr4xsIOifoTMTuxBWj9czFk
	 mrtQcdvd0oSj0GZs+TaF98aXV7GO3jiMTce84C26ps0+W/wrkHByWKr93U8tEdWKuU
	 2jWnrWD1pJIRApE7S04I+/dGuKdjkzi4eszCxmQ3D0Uy0UFbFJBB6JSow9WvP/1pVT
	 L4o72Gn3b/RwQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	daniel@makrotopia.org,
	dqfext@gmail.com
Subject: [PATCH net 06/11] MAINTAINERS: remove DENG Qingfang from MediaTek switch
Date: Tue,  3 Mar 2026 13:53:06 -0800
Message-ID: <20260303215339.2333548-7-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260303215339.2333548-1-kuba@kernel.org>
References: <20260303215339.2333548-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 882401F7CB5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,arinc9.com,makrotopia.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263440-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,arinc9.com:email,mediatek.com:email,broadcom.com:email]
X-Rspamd-Action: no action

We have not seen tags from DENG Qingfang for the MediaTek
switch driver in over 5 years. He is active upstream with
PPP/PPPoE patches in net-next. Chester and Daniel are active.

Subsystem MEDIATEK SWITCH DRIVER
  Changes 26 / 70 (37%)
  Last activity: 2025-12-01
  Chester A. Unal <chester.a.unal@arinc9.com>:
    Tags 585943b7ad30 2025-12-01 00:00:00 7
  Daniel Golle <daniel@makrotopia.org>:
    Author 497041d76301 2025-04-23 00:00:00 2
    Tags 3b87e60d2131 2025-12-01 00:00:00 14
  DENG Qingfang <dqfext@gmail.com>:
  Sean Wang <sean.wang@mediatek.com>:
  Top reviewers:
    [4]: andrew@lunn.ch
    [4]: florian.fainelli@broadcom.com
    [4]: arinc.unal@arinc9.com
    [2]: olteanv@gmail.com
  INACTIVE MAINTAINER DENG Qingfang <dqfext@gmail.com>

Acked-by: Chester A. Unal <chester.a.unal@arinc9.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Cc: chester.a.unal@arinc9.com
Cc: daniel@makrotopia.org
Cc: dqfext@gmail.com
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index a90d106efc24..2b2d0bfd3936 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16351,7 +16351,6 @@ F:	include/soc/mediatek/smi.h
 MEDIATEK SWITCH DRIVER
 M:	Chester A. Unal <chester.a.unal@arinc9.com>
 M:	Daniel Golle <daniel@makrotopia.org>
-M:	DENG Qingfang <dqfext@gmail.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/dsa/mt7530-mdio.c
-- 
2.53.0


