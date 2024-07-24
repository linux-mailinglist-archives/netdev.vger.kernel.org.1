Return-Path: <netdev+bounces-112821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4D793B5E0
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 19:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63802856A4
	for <lists+netdev@lfdr.de>; Wed, 24 Jul 2024 17:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC83515F3FB;
	Wed, 24 Jul 2024 17:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="cP4vCwsM"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F9F11C693;
	Wed, 24 Jul 2024 17:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721841947; cv=none; b=YBtHgtvqMoQ48B2pl4GyJlt3xdQYY9AXR9zXMyVNJb9P1gjv0eXZB5kk1LmfBxVdQAxMJMlayTc6BrWDMyZ9iDn2iJBZT1ewxZVtkffRWE/QfhPsvQismV2+AxGvph/8tG/EZx42WloWn4//3oJg7mzmlyDyjWmQaItpYPje87Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721841947; c=relaxed/simple;
	bh=IFDNbHqSeEOTyFijWr44MAMPqzBKSnoPL6oS8ztLJFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hem46XAmFtuv51aXBvDEaytuEmw1OiKhHph/qGcme0Jfr2nApKOrBy409gWsOr9jeaBXwpdHGX1xItJUs0M9opHn/T2ycdwEg0qroS4+IGoU0zX66bvatS+qbNsi2QY59lBPmyk3JIsXxUyCrHP7NiUI9dmx10r7E5aGvYs/bH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=cP4vCwsM; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Mh6IK8+qFfHt564eJGyok5X5MvotunJpporRsGCni6c=; b=cP4vCwsMH3ujAX2O
	npvVw1Dgz1wMIUhjr4oexL82UObyg6FpmXVH2GNQqfukD5GbKfzOr3Q3+CrnRTzMrw+rLAIbEp2DH
	DFZHQ8FWgZzyO9iWRDJ8bpRT/fgjRVt+fCephFI9wE0W7FNmouiz1NeI2PwBPxwNNiKH91iWPi3KF
	CaEMTGyDsObjCz/jadk2euB2hHnO6H96X63IMtCBe+T9mKXLPvdy8y+OVrm4SB7fEO3TYEsHm0HW4
	BLdF0LEq7FwQzG1hriZ5YL4b5ntBQbWts1otZeGQiHapXYuGnLZS3EJZax5EzbmcllhOPXiNw9CzE
	4oL7fAB6kPDXe8D7Bw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1sWfk1-00D422-0G;
	Wed, 24 Jul 2024 17:25:29 +0000
From: linux@treblig.org
To: pabeni@redhat.com,
	edumazet@google.com,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	kennetkl@ifi.uio.no,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH] net/tcp: Expand goo.gl link
Date: Wed, 24 Jul 2024 18:25:08 +0100
Message-ID: <20240724172508.73466-1-linux@treblig.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The goo.gl URL shortener is deprecated and is due to stop
expanding existing links in 2025.

Expand the link in Kconfig.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 net/ipv4/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/Kconfig b/net/ipv4/Kconfig
index 8e94ed7c56a0..6d2c97f8e9ef 100644
--- a/net/ipv4/Kconfig
+++ b/net/ipv4/Kconfig
@@ -661,7 +661,8 @@ config TCP_CONG_CDG
 
 	  For further details see:
 	    D.A. Hayes and G. Armitage. "Revisiting TCP congestion control using
-	    delay gradients." In Networking 2011. Preprint: http://goo.gl/No3vdg
+	    delay gradients." In Networking 2011. Preprint:
+	    http://caia.swin.edu.au/cv/dahayes/content/networking2011-cdg-preprint.pdf
 
 config TCP_CONG_BBR
 	tristate "BBR TCP"
-- 
2.45.2


