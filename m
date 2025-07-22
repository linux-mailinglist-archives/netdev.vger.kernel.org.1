Return-Path: <netdev+bounces-209061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 028A0B0E237
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 18:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9BB91AA5EE9
	for <lists+netdev@lfdr.de>; Tue, 22 Jul 2025 16:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFB0F27E076;
	Tue, 22 Jul 2025 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6An+Cuo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A279B26A1BB;
	Tue, 22 Jul 2025 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753203412; cv=none; b=UBBCdIk/ij4ChXORHHwt5xeVd40sam2Xdi4SFJV5l6ZuuoxJBPAVkmZcqyZngybtQ8TVKJqk409TBeZqDZmuci1z43dlkqEHXNfsD+SEFrUVhfy7RiLTP8iMoAWMYC6nW0W637nugKnspT2cnmu4ZWTb9cxK1tyyPUGNJ4Ekmas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753203412; c=relaxed/simple;
	bh=NZFrikSV/AG26VVF+grEqLNPygLwmoKqqxmwzNhYQ3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gtAsz+Hfv7RQF0TzoNt2iNclsAYaOASVmCyn5mit/2h4VISWSw95sVIYIZfn29NTmTUaZo/cIhJmn4nhSaIp1tm7njjkRaoqiF7hMYMb6m1ikC578Dl0B3Y1UoDnqH2V/FKiJpMtRRBUpNVK/2TZ7CTPWmd8n7JrgIwFa3iYTrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6An+Cuo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B331C4CEEB;
	Tue, 22 Jul 2025 16:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753203412;
	bh=NZFrikSV/AG26VVF+grEqLNPygLwmoKqqxmwzNhYQ3w=;
	h=From:To:Cc:Subject:Date:From;
	b=u6An+Cuoc9pkQmmCrQacieTjUDdJlwh83FPwf3bAPi9/YwSwq5/NYauHJlDzM09Zx
	 +rDk5/5pf1FFNScuJVGO5c7d09RlkVSKKmDzCoBbTCErkshuM7wvvgIFAPPLth89wU
	 6FbRAa53uGHvCY420Q5iJ1OBQYs3EccOszHfEjcCMVLGqEqjUvoPxCTWWbyRuquPAW
	 +PVxVQQ5JptL8rbv53U9zDbFIAAZhUr7wFYHWCChjcXnmLYVjhc/QSHSkrcQPUbDkx
	 eswP+0wtvdfVVcOaUJX0huSBxzEUgGPxWTLqhdSdbCEJXlV2sl0dkBTtehvk40QjZz
	 9sEVbPfNhdZdg==
From: Kees Cook <kees@kernel.org>
To: "David S. Miller" <davem@davemloft.net>
Cc: Kees Cook <kees@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH net-next] MAINTAINERS: Add in6.h to MAINTAINERS
Date: Tue, 22 Jul 2025 09:56:49 -0700
Message-Id: <20250722165645.work.047-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=910; i=kees@kernel.org; h=from:subject:message-id; bh=NZFrikSV/AG26VVF+grEqLNPygLwmoKqqxmwzNhYQ3w=; b=owGbwMvMwCVmps19z/KJym7G02pJDBn1hy6udfvenRcn3vfS/XR5zzWu3Ko/Z/nTw2a9fhzv8 OpH0tqejlIWBjEuBlkxRZYgO/c4F4+37eHucxVh5rAygQxh4OIUgInsDWRkuO2rf6LO68PUs1sC bsdFNBsa+u2e+/2KwLVUEzfJS1nbihn+l2/YwmFWxGK+yEUqwTowqOfal7wJ+hq9ey+3/TS8rPC FGwA=
X-Developer-Key: i=kees@kernel.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

My CC-adding automation returned nothing on a future patch to the
include/linux/in6.h file, and I went looking for why. Add the missed
in6.h to MAINTAINERS.

Signed-off-by: Kees Cook <kees@kernel.org>
---
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: <netdev@vger.kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index ffb35359f1e2..210e8402cc2a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17563,6 +17563,7 @@ F:	include/linux/ethtool.h
 F:	include/linux/framer/framer-provider.h
 F:	include/linux/framer/framer.h
 F:	include/linux/in.h
+F:	include/linux/in6.h
 F:	include/linux/indirect_call_wrapper.h
 F:	include/linux/inet.h
 F:	include/linux/inet_diag.h
-- 
2.34.1


