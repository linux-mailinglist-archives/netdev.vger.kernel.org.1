Return-Path: <netdev+bounces-258715-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fxaGEAaGkGk+agEAu9opvQ
	(envelope-from <netdev+bounces-258715-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 15:26:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A24B13C2F2
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 15:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDA26301F9DA
	for <lists+netdev@lfdr.de>; Sat, 14 Feb 2026 14:26:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88C123AE87;
	Sat, 14 Feb 2026 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oRg4sVS6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956011D63E4;
	Sat, 14 Feb 2026 14:26:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771079169; cv=none; b=qc8WQqWCd9g2MM+kwZ516SftPNOQieNf/h7DFM1ss26yv1McLiIYGp4QozvfVAyAfeUrZHMproA1Ae5ct1bICimJePdrsDaR+K0sB8pXrDp6dFgNXEpq0ZK7WhW2e2UYWC61TC8RNXNKsFh7zHmax+Lrl2bN/fdov1NZn73ChcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771079169; c=relaxed/simple;
	bh=mODyDok++EknqeJdDI8pu9Phdr8eA4ugMTT20UGCnrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Idzs5j+/Ax3tMgjmf8ll1nmYdsj4tvEkI7DrEctDdxTBOcWdewbQqtyxyDwMu8HFi41RwAryOMGLkMybZvDK2XMxXQZjQ5SgxuiFXDCof8rtqy/SR/KF3WAQ5vgmwFWWGGRKMSMmgRi7FJP25F+nI20qeRHbwdAXlDGya//Wp6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oRg4sVS6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 21B14C16AAE;
	Sat, 14 Feb 2026 14:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771079169;
	bh=mODyDok++EknqeJdDI8pu9Phdr8eA4ugMTT20UGCnrM=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=oRg4sVS6/4314eOMFIcvswLjVz7zGnFpD21xGpqEE4trijO96Sc0OzY0jRM9jTszP
	 HrZbCrg4UWrkHIoBKp9Pv8/ABuWmiJ7KOg7q7T8wXNG/LNyRgZBQIuEPAUoFTd95qF
	 j4Mo0aJrkhYeRs9jO5M70peZdUm8kf2Tokh9+bCiYYb4MwmhZWT04Ej3tM51Jmyw5e
	 BAGBoj93RkuOf5BlVo6e8/Du81wVtLHV5k/rIt9fnrrpBLyHNaYEVabBlN6CR/tX7+
	 AbbCEBYkp/5lxeJSx742DcbNgUMYV2sjghnTIxvOEDEwCEgYBWSCNVmBplggzSngnu
	 F+aVAmArBVIqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 173B6EDF142;
	Sat, 14 Feb 2026 14:26:09 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Sat, 14 Feb 2026 06:26:02 -0800
Subject: [PATCH] MAINTAINERS: drop enic maintainer entry for benve
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260214-enic-maintainers-update-v1-1-5bec573f90ff@cisco.com>
X-B4-Tracking: v=1; b=H4sIAPmFkGkC/x2MOQ6AIBAAv2K2dhNEPL9iLFAX3UI0gMaE+HeJx
 RRTzETw5Jg89FkERzd7PmySIs9g3rRdCXlJDlLIWshCIVmecddsQ4Kcx+tcdCA0TVe3eiqnShl
 I9enI8POfh/F9P8GmhphpAAAA
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771079168; l=707;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=hrrYJtxFXPrrNRPRr7m5o4Zl6ZakysaA78D4Co4V8aY=;
 b=SoxCx0+j3d2EBLo+jSVGzdIsR98faUNM3bzZwZFw9cpoxC81/pu3vEwFkePtPg2hywlDoKtvZ
 ZZMuiQrp08SA8RJWq3ZwrJXtUixDrvU9kpXYUjSffZgYBLqFBINCYZP
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258715-lists,netdev=lfdr.de,satishkh.cisco.com];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_THREE(0.00)[3];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cisco.com:mid,cisco.com:email,cisco.com:replyto]
X-Rspamd-Queue-Id: 7A24B13C2F2
X-Rspamd-Action: no action

From: Satish Kharat <satishkh@cisco.com>

Remove Christian Benvenuti from the enic driver maintainer list.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04e5fb80c32c..8b122a39dacf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6173,7 +6173,6 @@ S:	Supported
 F:	drivers/scsi/snic/
 
 CISCO VIC ETHERNET NIC DRIVER
-M:	Christian Benvenuti <benve@cisco.com>
 M:	Satish Kharat <satishkh@cisco.com>
 S:	Maintained
 F:	drivers/net/ethernet/cisco/enic/

---
base-commit: 37a93dd5c49b5fda807fd204edf2547c3493319c
change-id: 20260214-enic-maintainers-update-f7968ab3b54f

Best regards,
-- 
Satish Kharat <satishkh@cisco.com>



