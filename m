Return-Path: <netdev+bounces-290174-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKIVAdhUDmrl9wUAu9opvQ
	(envelope-from <netdev+bounces-290174-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:42:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90F6A59D5DF
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 02:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5938430268A9
	for <lists+netdev@lfdr.de>; Thu, 21 May 2026 00:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C995123B63E;
	Thu, 21 May 2026 00:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XRyaCjoL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228E121E098
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 00:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779324117; cv=none; b=r1YBMeGRe9rm5u6bKEhsT9cm2KCPdAM0sw1nRdwH5VLVB7Wgo+1RyXYPDLH/ift9QPLX4KzH5a+J8bPMOA/i1tbUjecmQR2yRJQUMuLwkAPGdESyXGY7DsYB4BMuI8T2S3CWAY+9Ek4BXsMoKxKdLWQR3hjwiXqeT4OgbvMImiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779324117; c=relaxed/simple;
	bh=kjSZ1dRI7q35FIIpQf9dma7ELfjgm/6K4fR7s+Z+FnY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G5Tr7EBtqvm8cLoPQr/oIubqJLRLioqoE894Xgc1VQFJWI08jdm9VX+iYXuOAWABzP6/SvQtPSaxDBv5rV42tYxyMsvotmu7GIaLI7QQFKwbOmU6p/Q6Dwkh8P/onSDSJEgKdgFgpoVen0iL3xu+b5HjtID6qVFtDgVrCCNat6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XRyaCjoL; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 341AE1F000E9;
	Thu, 21 May 2026 00:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779324115;
	bh=hMMv3S9vP5vZu7ThHWmKUo5BLkJTctQIlOxweiaOA/Y=;
	h=From:To:Cc:Subject:Date;
	b=XRyaCjoLz3tL+4ZPWIBhBOHUgKfyKWrj2biRvxZgqxySf3BHCffDMCeTy2Dg709o5
	 B8zLSZejyGxeU8sRrLCdsq1a+3v4c9c2qHCTQRjnxfubz6pajFzXjtDVQ3mrG/UQ/I
	 se8zfFDUk2gQwxtxpBmfvFVPdudth8WjHrnzYJebGf+0zLMJ0HA23O9iGgEgj1ilpV
	 eZfDsrisS1myAi2G656UK9ZMDbASaYWpMz3gGlzsrOTINDzRm+YPXvtUM6CzqVdF0z
	 +5n/yPPSDEwuLv05B0TKpAbP6dyVTeWzlrLGP0K9uyaNkNOdlkkUca8TDUXxkpNPUq
	 fj9+DfBSuxVUw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net] MAINTAINERS: add missing entry for Bluetooth include files
Date: Wed, 20 May 2026 17:41:51 -0700
Message-ID: <20260521004151.625049-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-290174-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 90F6A59D5DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

We X-out net/bluetooth/ from "NETWORKING [GENERAL]" so that only
the dedicated list is CCed on patches, and networking gets them
once already processed by Luiz. We missed include/net/bluetooth.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5db1a2923dd2..fa3a766f38f1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18640,6 +18640,7 @@ F:	tools/testing/selftests/net/
 X:	Documentation/networking/mac80211-injection.rst
 X:	Documentation/networking/mac80211_hwsim/
 X:	Documentation/networking/regulatory.rst
+X:	include/net/bluetooth/
 X:	include/net/cfg80211.h
 X:	include/net/ieee80211_radiotap.h
 X:	include/net/iw_handler.h
-- 
2.54.0


