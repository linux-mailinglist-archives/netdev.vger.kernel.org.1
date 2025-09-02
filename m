Return-Path: <netdev+bounces-218972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B27B3F245
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 04:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2557D3AB9E0
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 02:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A04288512;
	Tue,  2 Sep 2025 02:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Z+tRIZqm"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA104207A;
	Tue,  2 Sep 2025 02:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756779955; cv=none; b=hFeJuvgCoH+vkh5M2z4DzNNdQPXsxvzuZxceYb/uBjRlhlFnDxaiAnbEGvCmNbtSbgbj7eQ3mAnPacH3lAyLVuYGFi0YFO2c57P5sF6p4Fb27kBF829M0maIHT5FmSXM1VIpIMc+HLHevQ4jnNlvJuF03p80S2CDkiiSNcRMyVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756779955; c=relaxed/simple;
	bh=bIpocEP2jvz2mpj+XkMmbRl/rKIkIAkUnbr7f3S3hCE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U4NwTAgTEXzDTAoVuk2HmmrD2Lo7NJa/psktJDXMwccWn0xefWmCVtihGPXNi83RCG9w7ZwezdO1Luhg5RLMhxLdfx/lIlu1g28458AhG+OlaH8bMNsH9tLzbKS3R2JEP1sdI8eKI16GtKwNg0PTGMBEvKX8UWIexOVIOaXphgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Z+tRIZqm; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Z5
	A3QhlnIE64G/fcY6zdZwscP+D2WRRJ4z1gGYC+++4=; b=Z+tRIZqmatAZtP61T0
	B6AfEc+p0d0y4afhoywzcnTzz6Q576h1cpXdix81z7lgNRoQ2/byCvwkDQLOCjAW
	RHbPpzDCYeTLlqYC9QFK6rgrHRbYVfOJtKugE9L7KnFPb5asNu+WlcAePO357+4U
	eSISzxydVcAOyrh9DnehGgpqs=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-2 (Coremail) with SMTP id _____wCnDyebVbZo1fOsFw--.500S2;
	Tue, 02 Sep 2025 10:25:32 +0800 (CST)
From: mysteryli <m13940358460@163.com>
To: willemdebruijn.kernel@gmail.com,
	aleksander.lobakin@intel.com,
	andrew@lunn.ch
Cc: kuba@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mystery <m13940358460@163.com>
Subject: [PATCH v5] net/core: Replace offensive comment in skbuff.c
Date: Tue,  2 Sep 2025 10:25:29 +0800
Message-Id: <20250902022529.1403405-1-m13940358460@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnDyebVbZo1fOsFw--.500S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJr4kGr1kXF48tF18ZrWrXwb_yoW8CF4kpa
	97G345Cr1Dur17Cw4kC3WIvF45tan5JFWj9w4ag34rJwnxWrs2kFZxKrZ0vFWYvrW7trWj
	qrsI9rs0gFWjy3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_yCJUUUUUU=
X-CM-SenderInfo: jprtmkaqtvmkiwq6il2tof0z/xtbBNRK8Omi2TAbsOwABsj

From: Mystery <m13940358460@163.com>

The original comment contained profanity to express the frustration of
dealing with a complex and resource-constrained code path. While the
sentiment is understandable, the language is unprofessional and
unnecessary.
Replace it with a more neutral and descriptive comment that maintains
the original technical context and conveys the difficulty of the
situation without the use of offensive language.
Indeed, I do not believe this will offend any particular individual or group.
Nonetheless, it is advisable to revise any commit that appears overly emotional or rude.

v5:

- Added this detailed changelog section

v4:https://lore.kernel.org/netdev/20250901060635.735038-1-m13940358460@163.com/
- Fixed incorrect Signed-off-by format (removed quotes) as requested by Andrew Lunn
- Consolidated multiple versions (v1/v2) into a single version history

v3:Due to some local reasons in my area, this is a lost version. I'm truly sorry

v2:https://lore.kernel.org/netdev/20250901055802.727743-1-m13940358460@163.com/
- Initial version addressing feedback

v1:https://lore.kernel.org/netdev/20250828084253.1719646-1-m13940358460@163.com/
- First submission

Signed-off-by: Mystery Li <m13940358460@163.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index ee0274417948..202c25a01f22 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5333,7 +5333,7 @@ int skb_cow_data(struct sk_buff *skb, int tailbits, struct sk_buff **trailer)
 		    skb_has_frag_list(skb1)) {
 			struct sk_buff *skb2;
 
-			/* Fuck, we are miserable poor guys... */
+			/* This is a painfully difficult situation with limited resources... */
 			if (ntail == 0)
 				skb2 = skb_copy(skb1, GFP_ATOMIC);
 			else
-- 
2.25.1


