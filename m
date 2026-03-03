Return-Path: <netdev+bounces-263437-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oA4aFH9Yp2lsgwAAu9opvQ
	(envelope-from <netdev+bounces-263437-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:54:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E0CB1F7C9D
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 22:54:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5FF583032D6A
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 21:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0394548B399;
	Tue,  3 Mar 2026 21:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B0CUpErG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44BE481FA5
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 21:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772574824; cv=none; b=PWdECptMaBOIdFgOI1wJZDe2c2KKljmPQ6OutgInSAiSDxNhQmm0Cs1KY+w56XqsDlQnOt05v74MC+oDDaa5CL5e0oG+VEQpWRM277ngywXBEBWmU5I99v0CNAGdpoGydFbITCXFdGTKig8Q4zYPgdP+Yrcd4vLrWfJaqdHLlTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772574824; c=relaxed/simple;
	bh=9e1i+bE2pcchT9fdCIwej6LX2yc1+tVOzQKsKrm1DFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mON0Jc2u8FrD+oVtclElC80y5WjmXl8XVLgjT7gQaZ70mhHQkn9MsLXIXi06jAld8kPSnqCfdxa49oTspsxkvYL3D+I9/+KM6co9GpirM+mYMTTjtDSS/mW4CjY8CI3VAryLZVFg/2atV2ygwqaFu5rvLeOiYGRjvbxYQHrpqZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B0CUpErG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E2F3C2BCAF;
	Tue,  3 Mar 2026 21:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772574824;
	bh=9e1i+bE2pcchT9fdCIwej6LX2yc1+tVOzQKsKrm1DFw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=B0CUpErGxBDoT1Y++eapcnsH/0IrtDoN0Wm4L6QCZhaD3DFHJMxf6Iy9Wy4Kav+4l
	 IS2ClsfO5ZQRTinNg+oiBlqJRZWGnC+2uLV+bdFSnPDPNaFO0MY/OUkSKK/R4t/2QM
	 oCVvlvghgCXC0Wmg2xLHQMQ6GOdqiTpAaRFhUzUiuCT/+81flBQkDh952yDfvk2NAV
	 OQNtLntxjIKKDdGBan29Y+JzgZv0pbjukceS5cN56EKSpHfnPsN5rX41W0tU4eHpL3
	 R57XuSOfbrKtTUIzEVKFnkr3ukeLVbWAX+dp9aJGwBDp66IEJul9n9YpSV9Blvruop
	 zpEArjPMyRzNQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	sgoutham@marvell.com,
	lcherian@marvell.com,
	gakula@marvell.com,
	jerinj@marvell.com,
	hkelam@marvell.com,
	sbhatta@marvell.com
Subject: [PATCH net 03/11] MAINTAINERS: remove Jerin Jacob from Marvell OcteonTX2
Date: Tue,  3 Mar 2026 13:53:03 -0800
Message-ID: <20260303215339.2333548-4-kuba@kernel.org>
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
X-Rspamd-Queue-Id: 5E0CB1F7C9D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-263437-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,huawei.com:email,nvidia.com:email,marvell.com:email]
X-Rspamd-Action: no action

We have not seen tags from Jerin for OcteonTX2 in over 5 years.
Recent lore activity is in DPDK (non-kernel), not Linux.
Sunil, Linu, Geetha, hariprasad, and Subbaraya are active,
though the review coverage isn't great (38%).

Subsystem MARVELL OCTEONTX2 RVU ADMIN FUNCTION DRIVER
  Changes 53 / 138 (38%)
  Last activity: 2026-02-18
  Sunil Goutham <sgoutham@marvell.com>:
    Author fc1b2901e0fe 2024-03-08 00:00:00 1
    Tags 70f8986ecef1 2025-06-16 00:00:00 9
  Linu Cherian <lcherian@marvell.com>:
    Author a861e5809f3e 2025-10-30 00:00:00 7
    Tags a861e5809f3e 2025-10-30 00:00:00 7
  Geetha sowjanya <gakula@marvell.com>:
    Author 70e9a5760abf 2026-01-29 00:00:00 16
    Tags 70e9a5760abf 2026-01-29 00:00:00 20
  Jerin Jacob <jerinj@marvell.com>:
  hariprasad <hkelam@marvell.com>:
    Author 45be47bf5d7d 2026-02-18 00:00:00 22
    Tags 45be47bf5d7d 2026-02-18 00:00:00 25
  Subbaraya Sundeep <sbhatta@marvell.com>:
    Author 47a1208776d7 2025-10-30 00:00:00 20
    Tags 47a1208776d7 2025-10-30 00:00:00 30
  Top reviewers:
    [36]: horms@kernel.org
    [4]: jacob.e.keller@intel.com
    [4]: kalesh-anakkur.purayil@broadcom.com
    [3]: vadim.fedorenko@linux.dev
    [2]: shaojijie@huawei.com
    [2]: jiri@nvidia.com
  INACTIVE MAINTAINER Jerin Jacob <jerinj@marvell.com>

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
Cc: sgoutham@marvell.com
Cc: lcherian@marvell.com
Cc: gakula@marvell.com
Cc: jerinj@marvell.com
Cc: hkelam@marvell.com
Cc: sbhatta@marvell.com
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index c939a76b9a2b..49eb81ec3709 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15473,7 +15473,6 @@ MARVELL OCTEONTX2 RVU ADMIN FUNCTION DRIVER
 M:	Sunil Goutham <sgoutham@marvell.com>
 M:	Linu Cherian <lcherian@marvell.com>
 M:	Geetha sowjanya <gakula@marvell.com>
-M:	Jerin Jacob <jerinj@marvell.com>
 M:	hariprasad <hkelam@marvell.com>
 M:	Subbaraya Sundeep <sbhatta@marvell.com>
 L:	netdev@vger.kernel.org
-- 
2.53.0


