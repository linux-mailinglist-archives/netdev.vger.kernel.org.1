Return-Path: <netdev+bounces-294008-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAVUFT9iHmrCiwkAu9opvQ
	(envelope-from <netdev+bounces-294008-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:55:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCEE6283C3
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 06:55:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B29AC3032072
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 04:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0AD22DC78C;
	Tue,  2 Jun 2026 04:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ahfJv3ro"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E612DC332
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 04:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780376005; cv=none; b=ToOciUo4xzuuVrbccowTNPkvbXGHhmIC79goRpRmNLSuP6n59Vl6tRDqkZH2zIA5U8GxVyjWErvQj+ClU5w9PfYGKKFRdTVRPLRO7p14GvwUpVjLyxvT+FP0fRIlhHsEZpWPcJ/flTNoN+0RkykZj/SMZy0EdTgOcmeV7FOUbAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780376005; c=relaxed/simple;
	bh=BonxlASbrudEWQ9VqkFxYPYzf3PGM/pEI5og4/ogyA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MAL1YEfNgyPhBF7IsucDjs/S6AHIWF7cLr3IK8kzOTLvn1ZPJwUxZ5cX8F2Qg+objaZddYS3u7zZlVaJQ17SKgUyP0apr1axCURzDJUyMNf5QojbzwrlCZn6eQZXeeoKMDW32jKuUYeZAD4Sv1i/nX2EYl3wR6fnP8VOP7YZ6mM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ahfJv3ro; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780376005; x=1811912005;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BonxlASbrudEWQ9VqkFxYPYzf3PGM/pEI5og4/ogyA0=;
  b=ahfJv3roctYZO0fvnirxCAMy5VGA0f+EU7kF03vDofGYWseAcV9QwX5p
   BsSCVtu34RsP8gyK9MheouCsDfsHxGdCWujT7+FLS2G8m4dg9Ygtrnihr
   m3cSYbofJTZFGwTcBCcO8VhwwgF5e8GvXZ8ugcY3VxvT7+7724gjtNltd
   OB3YC5HGRbKNTEXfZhK0Duav2M0GWxznTkcOIBtn4uks6/S2+M45NWi4n
   4YP64pE72UF7BcKFoaj3o42DIJ9gR8sZ6n+LmmLmILBLZKtgtxUSHz2Ql
   15gpGPvT9spppEHCL7KmJe+U2m2L0i6irRNq/QeD8iR0uq8+Fr0R19AvF
   w==;
X-CSE-ConnectionGUID: HHgb0TUYTvGXXhzLveJ8wA==
X-CSE-MsgGUID: 5eupOVRPTzysv8+hpzkLdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11804"; a="81120468"
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="81120468"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 21:53:25 -0700
X-CSE-ConnectionGUID: hW255gCBRw+Ra8Q3ZCIs/A==
X-CSE-MsgGUID: FEHHKfuJToqINre5RXEtyA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,182,1774335600"; 
   d="scan'208";a="245604101"
Received: from jraag-z790m-itx-wifi.iind.intel.com ([10.190.239.23])
  by fmviesa004.fm.intel.com with ESMTP; 01 Jun 2026 21:53:21 -0700
From: Raag Jadav <raag.jadav@intel.com>
To: intel-xe@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	netdev@vger.kernel.org
Cc: rodrigo.vivi@intel.com,
	riana.tauro@intel.com,
	dev@lankhorst.se,
	airlied@gmail.com,
	simona@ffwll.ch,
	kuba@kernel.org,
	Raag Jadav <raag.jadav@intel.com>
Subject: [PATCH v3 1/4] drm/ras: Cancel and free message on get counter failure
Date: Tue,  2 Jun 2026 10:18:41 +0530
Message-ID: <20260602044919.702209-2-raag.jadav@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602044919.702209-1-raag.jadav@intel.com>
References: <20260602044919.702209-1-raag.jadav@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294008-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[intel.com,lankhorst.se,gmail.com,ffwll.ch,kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[raag.jadav@intel.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[intel.com:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,intel.com:mid,intel.com:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 7FCEE6283C3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

doit_reply_value() directly returns on get counter failure, which results
in stale sk_buff and genetlink header that aren't cleaned up. Fix it and
while at it, consolidate error handling using goto.

Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
Signed-off-by: Raag Jadav <raag.jadav@intel.com>
Reviewed-by: Riana Tauro <riana.tauro@intel.com>
---
v2: Use goto (Riana)
---
 drivers/gpu/drm/drm_ras.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index d6eab29a1394..467a169026fc 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -201,25 +201,28 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
 
 	hdr = genlmsg_iput(msg, info);
 	if (!hdr) {
-		nlmsg_free(msg);
-		return -EMSGSIZE;
+		ret = -EMSGSIZE;
+		goto free_msg;
 	}
 
 	ret = get_node_error_counter(node_id, error_id,
 				     &error_name, &value);
 	if (ret)
-		return ret;
+		goto cancel_msg;
 
 	ret = msg_reply_value(msg, error_id, error_name, value);
-	if (ret) {
-		genlmsg_cancel(msg, hdr);
-		nlmsg_free(msg);
-		return ret;
-	}
+	if (ret)
+		goto cancel_msg;
 
 	genlmsg_end(msg, hdr);
 
 	return genlmsg_reply(msg, info);
+
+cancel_msg:
+	genlmsg_cancel(msg, hdr);
+free_msg:
+	nlmsg_free(msg);
+	return ret;
 }
 
 /**
-- 
2.43.0


