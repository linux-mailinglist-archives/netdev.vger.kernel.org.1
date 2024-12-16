Return-Path: <netdev+bounces-152317-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 020E59F36E9
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:03:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A5C621893A36
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101132066E1;
	Mon, 16 Dec 2024 16:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="DRqUxdag"
X-Original-To: netdev@vger.kernel.org
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC721CEAD8;
	Mon, 16 Dec 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734368178; cv=none; b=ef0f/1m5zTvs+sdyJFeKlZ37us4eJqlilAJMeh6qQFwa/thPaCBkI85qPULqnvtfWe6VXiS5JTUf+onDva02l6BdJHCn6rrJG9Qk40ArBZynLui2Rd5BvrCVERmUUcY61xNO09sLILIyCLiC+yCHd1NDBfZr4FXz59H4oaB4aME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734368178; c=relaxed/simple;
	bh=JnopqHGGrYK5dFH/NuYM6LzKLjX7Z02kN7/Zi/iatOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mRepouyN39aPqciBTjKqT70chN+iUTpiaJ7/Avhk+ZhjVIQm98lfNADJ49vN8NMDMHQ10EXjTZJYWSKgPm0FkiKUW2I+x/Fm4T3Gh/qhSFJVWt/S66Y/znOo5wxXLTmnX09XMVNm1kqZEHMX1M1CwHoAe9AJKI3Gf6Icob7oANk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=DRqUxdag; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=Vbno3uxFXL5LLP12h6Tb9cL3wlf6uGvwZcC++Ip5T3Q=; b=DRqUxdaglpX20yYH
	enn4OR8qpbdTZJFb5+eHyDk4p96LkkrzWsLq8qM/dmoACkIBGLAMA0i/unDjGrFxV/+2pGQnHJsWL
	1G3oaBE4wtynWRyQcSgZb54v8Iy0FqmR59T0iYagypwg2njImTf/Mw58hTTpJ6xzRqBLBagNgStCU
	gIBmgE8G4Xhqnem5eYYQSUQCbRYgMRyTd4AGZcGgyllxvK+EYQ6C1t6DNmSoiLYdPplK1IcpRPg8e
	skIESb7XwaRqcTEvW/pWwNXylglWzy38Xfy70TedbFnsndiivqJ+fWeGLtD0piuH4m2/xt33PLu1R
	NbAz1Ppsk3/4o52OWQ==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1tNEO6-005fLl-0W;
	Mon, 16 Dec 2024 16:56:06 +0000
From: linux@treblig.org
To: jes@trained-monkey.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH net-next] net: Remove bouncing hippi list
Date: Mon, 16 Dec 2024 16:56:05 +0000
Message-ID: <20241216165605.63700-1-linux@treblig.org>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

linux-hippi is bouncing with:

 <linux-hippi@sunsite.dk>:
 Sorry, no mailbox here by that name. (#5.1.1)

Remove it.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e6e71b05710b..26b9ff7da90d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10280,7 +10280,6 @@ F:	drivers/input/touchscreen/himax_hx83112b.c
 
 HIPPI
 M:	Jes Sorensen <jes@trained-monkey.org>
-L:	linux-hippi@sunsite.dk
 S:	Maintained
 F:	drivers/net/hippi/
 F:	include/linux/hippidevice.h
-- 
2.47.1


