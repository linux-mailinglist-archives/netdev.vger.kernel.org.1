Return-Path: <netdev+bounces-249421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28BE2D18861
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 12:42:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 489DE300F9F6
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 11:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D808835CB86;
	Tue, 13 Jan 2026 11:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OkQ7ULiq"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908872BE644
	for <netdev@vger.kernel.org>; Tue, 13 Jan 2026 11:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768304531; cv=none; b=WkvLauTI2aK7OgKkKrkWB+XtGoxXhFzEJzQl2mB66Bp/sN3JLuVCaF2RbV6ICO/fOI3hwf2NeooD/lLhvWcSDlNdZXy+hBuh53qMZdekeakmOXtp5dCBxUJgRVKOsJXx3K3ZhEfWm7rmKaNB58w9TldvDnbFDUYPy0R2HaSWSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768304531; c=relaxed/simple;
	bh=2+ipIYDbNYYZYB768f4XnhO95OY6vPbnkSlu9gig+K0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gPeR7AeL4QZYUBJlkVKNJXgKyNmDJRS60IOwpyZsrcOxN2fE4TA3LzCIDF2aS8/NWhD7n7dPTvz2BbVaPntMdzenvbFHgMTOBnXNwTSvl3dje7pXs6GcFMrTlSYJjM5pd2pue2Alf9vP+U/mJ2kiBiDFso5pgSQL2g32yBPZ+Yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OkQ7ULiq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768304529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zme19PqktiZaeWPqXSVs234DIJrEP7IzNWk0WMredpM=;
	b=OkQ7ULiqN8SXDJevPcseBp94uotTsF4MK0kEw+mIp0yoiuGTnrz98tGIeN9wwGDPDnTYmB
	VFU+J+96HF0iCoURyz08Zda5ocotUCJgB4RdKqM8BO2U9mALqRq/TfNVmeuFFPjQAeyB8o
	i0/Pk7WDN+zMN9BsIkmFPbcdQCe26wA=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-509-Mlu9L2yOPCOI75Rnu-fPwg-1; Tue,
 13 Jan 2026 06:42:08 -0500
X-MC-Unique: Mlu9L2yOPCOI75Rnu-fPwg-1
X-Mimecast-MFC-AGG-ID: Mlu9L2yOPCOI75Rnu-fPwg_1768304527
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 721671956050;
	Tue, 13 Jan 2026 11:42:07 +0000 (UTC)
Received: from fedora (unknown [10.45.225.207])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 11DAB19560BA;
	Tue, 13 Jan 2026 11:42:05 +0000 (UTC)
From: Jan Vaclav <jvaclav@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org,
	Jan Vaclav <jvaclav@redhat.com>,
	Gris Ge <fge@redhat.com>
Subject: [PATCH iproute2] ip/iplink: fix off-by-one KIND length in modify()
Date: Tue, 13 Jan 2026 12:41:27 +0100
Message-ID: <20260113114127.36386-1-jvaclav@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

The expected size for IFLA_INFO_KIND in kernel is strlen(kind) + 1.
See `size` in rtnl_link_get_size() in net/core/rtnetlink.c.

Fixes: 1d93483985f0 ("iplink: use netlink for link configuration")
Reported-by: Gris Ge <fge@redhat.com>
Signed-off-by: Jan Vaclav <jvaclav@redhat.com>
---
 ip/iplink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/ip/iplink.c b/ip/iplink.c
index 59e8caf4..fce6631d 100644
--- a/ip/iplink.c
+++ b/ip/iplink.c
@@ -1139,7 +1139,7 @@ static int iplink_modify(int cmd, unsigned int flags, int argc, char **argv)
 
 		linkinfo = addattr_nest(&req.n, sizeof(req), IFLA_LINKINFO);
 		addattr_l(&req.n, sizeof(req), IFLA_INFO_KIND, type,
-			 strlen(type));
+			 strlen(type) + 1);
 
 		lu = get_link_kind(type);
 		if (ulinep && !strcmp(ulinep, "_slave"))
-- 
2.51.0


