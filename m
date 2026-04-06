Return-Path: <netdev+bounces-275675-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CA/1Gzvz02lxoQcAu9opvQ
	(envelope-from <netdev+bounces-275675-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:54:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E01B13A5EE4
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 19:54:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A7CF13015A4C
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 17:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F593909B2;
	Mon,  6 Apr 2026 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zg53ftYm"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806C134D4CB;
	Mon,  6 Apr 2026 17:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775498040; cv=none; b=Ghz/kCZMyNom7GiXq3Rv0qpv3YTdQUDNuUH0JkTrJOJXQ24JOdikHpbR93cGGbu/AKKtqd3anRcStzsYq7qThFmJTHBpDPuQwsZWavcnO/u11LzF3K8nY+M5Ir707hjl0GMI3EQ7d9TRGVXcZT6cv+pO7owon1t29DOnn7f4yLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775498040; c=relaxed/simple;
	bh=zA7m5oU/NJ9fvMR5m4o7q8dH3dg40qu1Vl8apDvy+9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FQ6jJGD0w7iomrf788MOVwr4vAd6mmnu9LqEmRi8cKlt6FSw35UMmModH6y25KK+ZUUPz/PG5uakquO1nfO0pvQLIiC/3vOzeUGXTPSgndFd1QFWcS82sb1lwZoRDrIe8oIwZuLyobL/MscGfwae58XQ0Y3dQavPUJaijUjOfZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zg53ftYm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DB60C4CEF7;
	Mon,  6 Apr 2026 17:53:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775498040;
	bh=zA7m5oU/NJ9fvMR5m4o7q8dH3dg40qu1Vl8apDvy+9c=;
	h=From:To:Cc:Subject:Date:From;
	b=Zg53ftYm1m9TBCK/i3/x6URlGV1KX4r7JNOjam34i51Cm3FxoWWcEGs1LJuuEqazW
	 2+lBnE8yC1JwudMhvdzMcK6kevgqNGpZwGOKAHk6yTAEecLO4LGuc50AD/VJr8OGLK
	 9sqIyKfv/ZrZMEtL/w4lSg0pMcPsCKKK+FyGmZoqHcGOko69/8G9edpzhK/kzbBCIP
	 BXAhMFs8VxGM12sHqkx3UDS5+QjfjvOGTq7DPyQkmvaBXhPq6I8vwVAJogthmaz9+Z
	 vfj1vOuaS/Rm5IlptE/TMJ8XX/X6PuClkdkK4Db1LjJq+oKgZB0huF7WYYyxxLKpO4
	 YLcEyUZcm5hTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next] docs: netdev: improve wording of reviewer guidance
Date: Mon,  6 Apr 2026 10:53:34 -0700
Message-ID: <20260406175334.3153451-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-275675-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lwn.net:email,linuxfoundation.org:email]
X-Rspamd-Queue-Id: E01B13A5EE4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Reword the reviewer guidance based on behavior we see on the list.
Steer folks:
 - towards sending tags
 - away from process issues.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: corbet@lwn.net
CC: skhan@linuxfoundation.org
CC: workflows@vger.kernel.org
CC: linux-doc@vger.kernel.org
---
 Documentation/process/maintainer-netdev.rst | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/Documentation/process/maintainer-netdev.rst b/Documentation/process/maintainer-netdev.rst
index 3aa13bc2405d..bda93b459a05 100644
--- a/Documentation/process/maintainer-netdev.rst
+++ b/Documentation/process/maintainer-netdev.rst
@@ -551,10 +551,12 @@ helpful tips please see :ref:`development_advancedtopics_reviews`.
 
 It's safe to assume that netdev maintainers know the community and the level
 of expertise of the reviewers. The reviewers should not be concerned about
-their comments impeding or derailing the patch flow.
+their comments impeding or derailing the patch flow. A Reviewed-by tag
+is understood to mean "I have reviewed this code to the best of my ability"
+rather than "I can attest this code is correct".
 
-Less experienced reviewers are highly encouraged to do more in-depth
-review of submissions and not focus exclusively on trivial or subjective
+Reviewers are highly encouraged to do more in-depth review of submissions
+and not focus exclusively on process issues, trivial or subjective
 matters like code formatting, tags etc.
 
 Testimonials / feedback
-- 
2.53.0


