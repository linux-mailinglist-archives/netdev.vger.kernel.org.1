Return-Path: <netdev+bounces-150914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 046279EC122
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 01:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5AE7284F60
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 00:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54D24964F;
	Wed, 11 Dec 2024 00:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="nYHDq9fy"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22E748489;
	Wed, 11 Dec 2024 00:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733878688; cv=none; b=u6vv4kGMFFlavqXbDfPg7AFj+E2V1wIb1UxZcFrRd/RaHktVIwZRAc3qmzOIOAA+aroFoGeHhA0gUeEns2vjOfeh5BuIWFNPd12qwIogUEb+ylXQVIacCFbc8NG0qx7ckwldvtGYt0vF9NiOVr3ntCo8NDhXChBC7+8avMQAULg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733878688; c=relaxed/simple;
	bh=/dgDte9i+UBwJ6YJ9HUdJIzR1rUDImFcX3hu8N9e+ws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZdSM46gZdECDCcInMW/1lW5YHVM+1TLU+l/ednGTj8Jch+foOuBU8ObICXVGmXZMH6GfNgQfue9UyqntOLrsoMR/Lud5yTWu41d33m5qhzaW4d9eR0S7f0vYalxER7KGz/nyU++7/E8MO9g/rS/yf41EorxBVGZsRDVkCmicEZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=nYHDq9fy; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=gLLqSB3NkG3XAYDbGklYCoOXTb9yE5C+VLnEkrpzXg4=; b=nYHDq9fyMS9NdyST
	wmcvMYH1W0Y1GYaBqXT4awyBpYei9Gl3ygumK11tyYL9pwAqsV6OQi7oL7Tf/jPh/3aVmEwxVb0Eg
	nfGwI2h6k+WKdRP0322pRfA40gkAnxKDl/10flqXSX35AeyLxJWC8zA7qUa/KnUdlSZzXeEMDFi8/
	lHhRdmB0DvVZl2/tnttS+22adnct8IIh/FIv3FpThtZmbs5kwt9SNQgivwuLRG3DBr5f9fveh63xI
	wwUF4FeRWekRo6hkTiQZ/DRi7W0IxC6f3izLa8CprFRn9IS8JjkgoNJM+RiD0+JNcms4O9g+1j7Ey
	p5A2aQh+weyHpWf3Gw==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tLB3D-004eI4-2e;
	Wed, 11 Dec 2024 00:58:03 +0000
From: linux@treblig.org
To: isdn@linux-pingi.de,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] isdn: Remove unused get_Bprotocol4id()
Date: Wed, 11 Dec 2024 00:58:02 +0000
Message-ID: <20241211005802.258279-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

get_Bprotocol4id() was added in 2008 in
commit 1b2b03f8e514 ("Add mISDN core files")
but hasn't been used.

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 drivers/isdn/mISDN/core.c | 14 --------------
 drivers/isdn/mISDN/core.h |  1 -
 2 files changed, 15 deletions(-)

diff --git a/drivers/isdn/mISDN/core.c b/drivers/isdn/mISDN/core.c
index e34a7a46754e..8ec2d4d4f135 100644
--- a/drivers/isdn/mISDN/core.c
+++ b/drivers/isdn/mISDN/core.c
@@ -294,20 +294,6 @@ get_Bprotocol4mask(u_int m)
 	return NULL;
 }
 
-struct Bprotocol *
-get_Bprotocol4id(u_int id)
-{
-	u_int	m;
-
-	if (id < ISDN_P_B_START || id > 63) {
-		printk(KERN_WARNING "%s id not in range  %d\n",
-		       __func__, id);
-		return NULL;
-	}
-	m = 1 << (id & ISDN_P_B_MASK);
-	return get_Bprotocol4mask(m);
-}
-
 int
 mISDN_register_Bprotocol(struct Bprotocol *bp)
 {
diff --git a/drivers/isdn/mISDN/core.h b/drivers/isdn/mISDN/core.h
index 42599f49c189..5617c06de8e4 100644
--- a/drivers/isdn/mISDN/core.h
+++ b/drivers/isdn/mISDN/core.h
@@ -55,7 +55,6 @@ extern void	__add_layer2(struct mISDNchannel *, struct mISDNstack *);
 
 extern u_int		get_all_Bprotocols(void);
 struct Bprotocol	*get_Bprotocol4mask(u_int);
-struct Bprotocol	*get_Bprotocol4id(u_int);
 
 extern int	mISDN_inittimer(u_int *);
 extern void	mISDN_timer_cleanup(void);
-- 
2.47.1


