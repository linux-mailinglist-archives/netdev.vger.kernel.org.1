Return-Path: <netdev+bounces-254454-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0PdlJ+p5emkC7AEAu9opvQ
	(envelope-from <netdev+bounces-254454-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:04:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 45EAAA8EBB
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C419E30058DF
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9ADA329C77;
	Wed, 28 Jan 2026 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZR0f4xV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6EDE2F2607
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 21:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769634280; cv=none; b=R7kD7lPHLv/EjnGqblE3VjMIDsJHcvQ66FPfKs0XKQU89m4y7R6xpC8Zv2zv6CAo5R+5UyT1oarhSO75cCvAxUtQsjX2hfSAhY8cLmsCm+ecOiofZjDnLgNkBdwJo2pLW6Ag3LrVv9VqBNj+CaIpnAy1vUSpXeqEgyu52Tkbut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769634280; c=relaxed/simple;
	bh=Bj8zWZOCir3+dSvnXCTxNaUi7oNxP9dc2irjuUED4aE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DwAMoNC63sKOsCRTVJCb2xoZmU7JglzQOq8Ov+0yO9FYWWpsUu0HwHcXfi0YQew+F/Z2hFtBDNpYG7WuLxcUBMhHnjPiI1Tih/OUPpaMdZQ9yTkhLy2njToLShiBtFnbdBFfdGMnTzX1UZWSDPsUpd5HcoUXLQIa82GW5Jj+w0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZR0f4xV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E285CC4CEF1;
	Wed, 28 Jan 2026 21:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769634280;
	bh=Bj8zWZOCir3+dSvnXCTxNaUi7oNxP9dc2irjuUED4aE=;
	h=From:To:Cc:Subject:Date:From;
	b=tZR0f4xVenoy3aGM6oubAPnDZ+ZJFA951B2yV26wCscaCprO0KLXXDnQR4g198e15
	 bwfhmajStiA+TDWp8CWIujDZd759eXZ0uNtMH47Cdm76laNtv+Fs8l3e6ykYNLe6Bj
	 adxsIX/IS9Tz8dCyH4Rv+wUCLgE4VZ0aPdkWwpVL1Qfmp9lsYnVIYeB42k/ffz8BaG
	 ikuiTk/Gv7zgLUwjNBIofeMqz4QlV9ZwfWBQl0dPrRLOPuGgLjanuj7sSaWy+P4oQR
	 wAP1F1WazIIuYg8oXWdlSmXYgS39REWchj+XXlPOXivq7mGRho072CDsi25eNT+Lhm
	 i0ebNp1x8qcOQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	daniel.zahka@gmail.com,
	willemdebruijn.kernel@gmail.com
Subject: [PATCH net] MAINTAINERS: add an entry for PSP
Date: Wed, 28 Jan 2026 13:04:35 -0800
Message-ID: <20260128210435.161061-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254454-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email]
X-Rspamd-Queue-Id: 45EAAA8EBB
X-Rspamd-Action: no action

We are missing a MAINTAINERS entry for PSP, create one.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: daniel.zahka@gmail.com
CC: willemdebruijn.kernel@gmail.com
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c3df85fd5acd..bcd2e71dec1c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20991,6 +20991,18 @@ F:	Documentation/devicetree/bindings/net/pse-pd/
 F:	drivers/net/pse-pd/
 F:	net/ethtool/pse-pd.c
 
+PSP SECURITY PROTOCOL
+M:	Daniel Zahka <daniel.zahka@gmail.com>
+M:	Jakub Kicinski <kuba@kernel.org>
+M:	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
+F:	Documentation/netlink/specs/psp.yaml
+F:	Documentation/networking/psp.rst
+F:	include/net/psp/
+F:	include/net/psp.h
+F:	include/uapi/linux/psp.h
+F:	net/psp/
+K:	struct\ psp(_assoc|_dev|hdr)\b
+
 PSTORE FILESYSTEM
 M:	Kees Cook <kees@kernel.org>
 R:	Tony Luck <tony.luck@intel.com>
-- 
2.52.0


