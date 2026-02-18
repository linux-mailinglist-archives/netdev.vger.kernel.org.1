Return-Path: <netdev+bounces-259349-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDP5OQ8LlmmaZAIAu9opvQ
	(envelope-from <netdev+bounces-259349-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:55:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 63106158D60
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 19:55:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24E0A300B74A
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 18:55:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2044A3446A5;
	Wed, 18 Feb 2026 18:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+4+CdSd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16AE3016F5;
	Wed, 18 Feb 2026 18:55:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771440907; cv=none; b=unoPGgk0DoDvBTZywvDHwdv+0TgF/B4cEduP/W2YrC37VbRUrx/rLQrREevdZrQt8Sf5QulDA7WlB/tRId8pbYJGml7HHTblUZ6kjudg2qrJ1r+SI3kNAky/96DmjvwBMcVomm7whhtiPoAri6f6rk3z8j16PGGMkev+USav4bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771440907; c=relaxed/simple;
	bh=ETQye8Yq0PDr6yLn39oNngvauf1K1x4o4u2DWJ/0Xzc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=EvpNRfFG3tY21tcIB3UeWPWIvXjZYQIUAnq/oE3d60prv0e+ZW1fCoJOnui1Tx66ehm4Dr+W73W8n6RIKdxh8QBRbOocLqKlr/XR59FG4kZK1UH0tHeJ5p1d6uwrbYQCHdBTqiClQsVwkKXOueRN7uhwIHqOzmuEjG0AQFsIs/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+4+CdSd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 98D8FC116D0;
	Wed, 18 Feb 2026 18:55:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771440906;
	bh=ETQye8Yq0PDr6yLn39oNngvauf1K1x4o4u2DWJ/0Xzc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=S+4+CdSdBGGdIehR2DNHBYqPWTGA9LRAoXouejVrXVVXU3it3N36JveOdSZzsWiO+
	 s5z1Kk8Ut6TJbuVesTozf+yTW5pKlDPrgnqhfdPLG8PI/r3dV07Mx58QFe/dtSYIwr
	 ocp2845Og1qKeOZxFJD04fUHmTVYtXOgARD+btUKeYLjSqqgkMqFhjCjwQIozEDfrT
	 Q1hr3SzV8+pRmJpf7FCZWe09MyV0184Bos6MaGe5v3ooZlG01xFZrP9bM8s87NzwA2
	 WpNwfyvfYjOOyeU0tAGrliK8YxdPvxu6HB0Gjc4PFRwDxl3p4C7iPTWKc1nWJa2Z+K
	 FXBuRsjjw5Kwg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FE8EE9A04B;
	Wed, 18 Feb 2026 18:55:06 +0000 (UTC)
From: Satish Kharat via B4 Relay <devnull+satishkh.cisco.com@kernel.org>
Date: Wed, 18 Feb 2026 10:54:45 -0800
Subject: [PATCH] MAINTAINERS: update usnic maintainer list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260218-usnic-maintainers-update-v1-1-dbbcd47e4656@cisco.com>
X-B4-Tracking: v=1; b=H4sIAPUKlmkC/x2MMQqAMAwAvyKZDbRBi/oVcSiaagarNCqC+HeLw
 w033D2gnIQVuuKBxJeobDGLLQsYFx9nRpmyAxlyhmyDp0YZcfUSjwwnxXOf/MFItg4tka2caSD
 ne+Ig97/uh/f9AJjiq41qAAAA
To: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Satish Kharat <satishkh@cisco.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1771440905; l=963;
 i=satishkh@cisco.com; h=from:subject:message-id;
 bh=XXis8Q3RTLAezBt3nclyBpHBs1gea64wFHPCq4VKzdc=;
 b=teoWY4K0b72+WlyIONFEHUsyIaCdb5icol5n9ZTBfdsaEHUuWciXivMbaOs1nwRCdGt2HE6aB
 tVZxYtkrjPPAb1SJg9iIL12ILM6U6ClxwL/uv1O7UJZJ/POEtQs1ED6
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259349-lists,netdev=lfdr.de,satishkh.cisco.com];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	HAS_REPLYTO(0.00)[satishkh@cisco.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cisco.com:mid,cisco.com:email,cisco.com:replyto,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 63106158D60
X-Rspamd-Action: no action

From: Satish Kharat <satishkh@cisco.com>

Remove Christian Benvenuti from the usnic maintainer list because he is no
longer working on the driver and the email address is no longer valid.
Add Satish Kharat and Norman Anderson as maintainers.

Signed-off-by: Satish Kharat <satishkh@cisco.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 04e5fb80c32c..3310c2afa177 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6179,8 +6179,9 @@ S:	Maintained
 F:	drivers/net/ethernet/cisco/enic/
 
 CISCO VIC LOW LATENCY NIC DRIVER
-M:	Christian Benvenuti <benve@cisco.com>
 M:	Nelson Escobar <neescoba@cisco.com>
+M:	Satish Kharat <satishkh@cisco.com>
+M:	Norman Anderson <noanders@cisco.com>
 S:	Supported
 F:	drivers/infiniband/hw/usnic/
 

---
base-commit: 37a93dd5c49b5fda807fd204edf2547c3493319c
change-id: 20260218-usnic-maintainers-update-215f92214608

Best regards,
-- 
Satish Kharat <satishkh@cisco.com>



