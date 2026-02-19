Return-Path: <netdev+bounces-259577-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B9/Fphjl2mnxgIAu9opvQ
	(envelope-from <netdev+bounces-259577-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:25:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 79C88161F41
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 20:25:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C425C301BC29
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 19:25:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 448742F549C;
	Thu, 19 Feb 2026 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3iowRVv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2141A223DD6
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 19:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771529104; cv=none; b=CZhEOmA+YMvC2bD2YTSI7GnIMSFTub0Aw+cD4olX1d4Y5+gyieNMiCfsH5nSKlYF39ZxCMhGYe6DgFxm8+3QlAfH0j2nYyKSyrDdv3vg4As88Cr6HEr6fLnGpbL1O28lxNHRrNJQfeWlL32TC3Am9bl/HBV8dfe61eAp8SFjAog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771529104; c=relaxed/simple;
	bh=jPHRIJogqWXKrosNMERaX11GdtFPtXNjePs/VSQr59c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lIPtuoMmsnZIh+z6Y6rTCd71AlBPuw4z6fTtTxLMACbgNMeDcVkBLvfeGKjaDpAfVm3n89CWHIpysoPClUIHOPmSopbg/4h63dTFMX0gdPTfcg4WKt0cEXMIFPZ5Q1rtSLjbU25VNs7/O8ardkr/Lmha2BrTwi5SobAKT00P94k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3iowRVv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2D84C116D0;
	Thu, 19 Feb 2026 19:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771529104;
	bh=jPHRIJogqWXKrosNMERaX11GdtFPtXNjePs/VSQr59c=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=F3iowRVvaD3/ylQkz43zsgsA3MBw0A/mf29MweUWcbrlw/5ICf16s4DRnqIoWzIp6
	 SVmXE9wROLLzBUMCU7gSNYxSttSOxQGdebDk6FGOgfTCaoUUTnf/js79xlWPV6aTZW
	 rOnaAVRwqf/maqFOH4aYxXIOBdVg26hrpgrvEoKVD1kfZtLnV8jcFMVnUONYTCBFJV
	 rPpZXnL6zoo6/WkJ3CA9q/XgBWqYlThzdoNMt/SKcV99wKZ1YmVCVVLx7R41uWzXE8
	 LvACeb2lUEtVwWsJ6lnTnXXouYuRFnz+MUAy9diD4XD19p8vIAsovIlPKS70+cqPvv
	 GuUWCaKzA6kEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E53E9A054;
	Thu, 19 Feb 2026 19:25:03 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Thu, 19 Feb 2026 11:24:00 -0800
Subject: [PATCH] MAINTAINERS: update enic and usnic maintainers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260219-enic-maintainers-update-v2-v1-1-c58aa11c2ea8@cisco.com>
X-B4-Tracking: v=1; b=H4sIAE9jl2kC/x3MOwqAMBBF0a3I1A7E+EHdilgE89QpjJJoEMS9G
 yxucZr7UIAXBOqzhzyiBNldQpFnNK3GLWCxyaSVbpQuOoaTiTcj7kzBB74Oa05w1GzRokarqnK
 uKA0Oj1nufz6M7/sBYxncCGwAAAA=
To: netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771529102; l=1100;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=7EAm7q54AU0UQ6XPv8J2+vHkr+1SMF1VEQ16JVUETpw=;
 b=YSIdvXPmGz6z8kxnMYyLzYt4Z1lG8y26WJw1hYgR1NWoA45TeRE1AnGgnX1fnI9xxk0zDRTW+
 iHf5ITT0oNbCKmdl57ujzoZxrvbekFkHNEt1UBPWR7ISMce89Vp35m6
X-Developer-Key: i=satishkh@cisco.com; a=ed25519;
 pk=4BxbLoCGvHeIMH/PbpiNVx8/2IcTjFvqcr0AD8K6WLY=
X-Endpoint-Received: by B4 Relay for satishkh@cisco.com/default with
 auth_id=639
X-Original-From: Satish Kharat <satishkh@cisco.com>
Reply-To: satishkh@cisco.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259577-lists,netdev=lfdr.de,satishkh.cisco.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 79C88161F41
X-Rspamd-Action: no action

From: Satish Kharat <satishkh@cisco.com>

Remove Christian Benvenuti from the enic/usnic maintainer lists because he
is no longer working on the drivers and the email address is no longer valid.
Keep Satish Kharat as the enic maintainer and the usnic co-maintainer.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04e5fb80c..239a1948c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6173,14 +6173,13 @@ S:	Supported
 F:	drivers/scsi/snic/
 
 CISCO VIC ETHERNET NIC DRIVER
-M:	Christian Benvenuti <benve@cisco.com>
 M:	Satish Kharat <satishkh@cisco.com>
 S:	Maintained
 F:	drivers/net/ethernet/cisco/enic/
 
 CISCO VIC LOW LATENCY NIC DRIVER
-M:	Christian Benvenuti <benve@cisco.com>
 M:	Nelson Escobar <neescoba@cisco.com>
+M:	Satish Kharat <satishkh@cisco.com>
 S:	Supported
 F:	drivers/infiniband/hw/usnic/
 

---
base-commit: 37a93dd5c49b5fda807fd204edf2547c3493319c
change-id: 20260219-enic-maintainers-update-v2-de8e5e8043f4

Best regards,
-- 
Satish Kharat <satishkh@cisco.com>



