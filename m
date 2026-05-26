Return-Path: <netdev+bounces-291791-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MFSzLKXHFWpNbQcAu9opvQ
	(envelope-from <netdev+bounces-291791-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:17:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9725D9838
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 18:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 82047302FD04
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 16:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CDD3AE70F;
	Tue, 26 May 2026 16:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MeG9dX4G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A9D379ED8;
	Tue, 26 May 2026 16:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811330; cv=none; b=qjDmQZNOM9j1R6CPPG99fEehhsptWlpa3SvRImg2Kn9ZBnEC+CYsFg2Q9TULLUn4AA0eLLTvGI5p5MjJsKGiNWgik8/9rDKhGoAOFKyXAVFwdz612uoCqTSIiKrnxgkSQBo7UNrKhFxKaAxWbl6/RZl2Akix8uYwR1AK/434IDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811330; c=relaxed/simple;
	bh=hxVYRXPvIsESkTfNM6Ys0NLCqgf5UJvDr7UEHFKyY5A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mvM9/nv/i82IDsYE9ABjQGDqdq/aDvE4yy8kvxXzf3AsjMRvm/lcCaCditSEmifJ6fdECpJjFn0VTjUaQJ4hoB4uU85nUawGLDHPJGJwdUenB3h88o3BA36f5w1dNRqYtuY5ny+9ifYWpM6+QZ5Vyxu/N2sj8+7W21Ifj8Qduds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MeG9dX4G; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B201F00A3E;
	Tue, 26 May 2026 16:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811328;
	bh=fhj4g7QPBK5Ph+CioRSfC4CN3qGuaDD7YpnRGLQrphE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MeG9dX4GXi3hn2Ff8aPu9vW5X6S5wagSvTe7rpHwql15P3iGJC7be7TN2PSpvw4ad
	 kVRw+I2U8d3D2yTrYH/VigYOP0FzwwgiZ64U8XifAtQ5iSd6kUy5xXatq2EgaphKfW
	 0jima1eqzkvSifJz0Je1+lHHzzb4hzI5c5NINANoCpJJungXSnJ0Gj54gdBylFVm4d
	 AgjKOp0jghNzbqUV92z++16KR7amq6zPef3cApCo22N0tlyjArKVQI5EOmukiWZ3y3
	 Hy5baZtAHxPaUbcPXQklwywoUWDIr6q/XF1meGZibjw7yMm/kuLtSNnR3So6UXNBE3
	 UyIngRatJ9Ltg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	corbet@lwn.net,
	vladimir.oltean@nxp.com,
	willemb@google.com,
	sdf.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	jesse.brandeburg@intel.com,
	linux-doc@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 03/10] docs: net: statistics: fix kernel-internal stats list
Date: Tue, 26 May 2026 09:01:44 -0700
Message-ID: <20260526160151.2793354-4-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526160151.2793354-1-kuba@kernel.org>
References: <20260526160151.2793354-1-kuba@kernel.org>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,lwn.net,nxp.com,gmail.com,intel.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-291791-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.998];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BD9725D9838
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Update the kernel-internal ethtool stats list to match current code:

- spell the entries as "struct ethtool_*_stats", not as functions
- list the full set of structures, not only pause and fec
- mention that fields are pre-initialized to ETHTOOL_STAT_NOT_SET by
  ethtool_stats_init() and drivers should leave unsupported fields at
  that value rather than zeroing them

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/networking/statistics.rst | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/statistics.rst b/Documentation/networking/statistics.rst
index 66b0ef941457..824ebc549383 100644
--- a/Documentation/networking/statistics.rst
+++ b/Documentation/networking/statistics.rst
@@ -231,8 +231,19 @@ Kernel-internal data structures
 -------------------------------
 
 The following structures are internal to the kernel, their members are
-translated to netlink attributes when dumped. Drivers must not overwrite
-the statistics they don't report with 0.
+translated to netlink attributes when dumped. Fields are pre-initialized
+to ``ETHTOOL_STAT_NOT_SET`` (by ``ethtool_stats_init()``); drivers must
+leave fields they do not report at that value rather than overwriting
+them with 0.
 
-- ethtool_pause_stats()
-- ethtool_fec_stats()
+- ``struct ethtool_eth_ctrl_stats``
+- ``struct ethtool_eth_mac_stats``
+- ``struct ethtool_eth_phy_stats``
+- ``struct ethtool_fec_hist``
+- ``struct ethtool_fec_stats``
+- ``struct ethtool_link_ext_stats``
+- ``struct ethtool_mm_stats``
+- ``struct ethtool_pause_stats``
+- ``struct ethtool_phy_stats``
+- ``struct ethtool_rmon_stats``
+- ``struct ethtool_ts_stats``
-- 
2.54.0


