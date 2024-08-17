Return-Path: <netdev+bounces-119396-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 887589556CD
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 11:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14584B21C87
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 09:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4542214831D;
	Sat, 17 Aug 2024 09:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="bVEzUJae"
X-Original-To: netdev@vger.kernel.org
Received: from smtpcmd13158.aruba.it (smtpcmd13158.aruba.it [62.149.156.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D755145FEB
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 09:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.156.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723887375; cv=none; b=DPB35V3Jm15VJvPT37YZHNp14R01KU4tVj204KuH/glmvha/iqSZyeRNd2T9jZDmOd+LIxy0IjHhc1iKy9YGQ21cGAOL9uVrCY8Lsr8PL1YYJkSngykmUs4jslz2Cb0pT60oz/sGoVFzWqeXVEmh4oOZzhoRaCFW3PRpZ+FfJ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723887375; c=relaxed/simple;
	bh=renAFDB7g9RQgbrXWeWBLAScPRJpbdS8Z+QxfPGd79A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DdLr/GS+457Y8DUSEazyo45LtUk+ULk6sqqB/XPdyuOLT6xuGb7MJwjyb7uX/9lUh0OJEcbEaZROKZ60k7YAqePkWMRkjDhX6XPUUGJrnycWMGf6GpVoF/Tu7v0KMQILPQ2BSNreyjGiBAXdZhV1d6gAifd56MBwRI/rI31b790=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xhero.org; spf=pass smtp.mailfrom=xhero.org; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=bVEzUJae; arc=none smtp.client-ip=62.149.156.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xhero.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xhero.org
Received: from xhero.org ([84.74.245.127])
	by Aruba Outgoing Smtp  with ESMTPSA
	id fFnxsP1NM8U42fFnysJHU6; Sat, 17 Aug 2024 11:33:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1723887184; bh=renAFDB7g9RQgbrXWeWBLAScPRJpbdS8Z+QxfPGd79A=;
	h=From:To:Subject:Date:MIME-Version;
	b=bVEzUJaeEjy+kcCpFiNCg7dnogjPY9UAppsZGtKrCQ0g0WTHwg9/LTRqB4pyZA1wa
	 nLbfAcGY/Gf8PyXuehvPCVXewIKM7WOd7U87jvA00YY7rW3H2jtQ1Yv3VTl2cSuKmX
	 IsRkjOG1J6EO0Sr7J33jwZ4K0xLJh96fj1zQPkGCuCUI7rp9x2fol3XNpQV7orEpQ4
	 fb9S/1WZvdjCg1cR8ywwo14eFHWS8a+csEwygY37YLoB8bzZd1YNNNFvvpAlyXtHS2
	 qmEt/wIox8hTAwpNng6YikGJw72vj/bJkCsdNncty/Z5cfAJ2I0y+pPJuLSr2OOyHR
	 jBA5OgPEbLlVg==
From: Rodolfo Zitellini <rwz@xhero.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Doug Brown <doug@schmorgal.com>,
	Rodolfo Zitellini <rwz@xhero.org>
Subject: [PATCH net-next 1/2] tty: Add N_TASHTALK line discipline for TashTalk Localtalk serial driver
Date: Sat, 17 Aug 2024 11:32:58 +0200
Message-Id: <20240817093258.9220-1-rwz@xhero.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfCnaeM6gFMsVxzV2qCfUWbzi29bvj5XHJbHcL4EwtpFYsnON1vEgyYySekkZcZYPFKjFTN4EIlhOtamF0yrF/Bi6yn8UvECN3dOMxUO0qxwv7SzTwXJp
 Gefp8tPRgMYAeorEEqn7kSjWFH0Mv8xzeofgUAReQeIg9e/TvKQ1XSbJ5p0UxZN89D2/1V6hbgY5CT9H0LyMAK91tb5DOVv7rxKAEf2tBhw0t6x3LRArf4w7
 nwOxUfYNTscbQ0bbrNIDeA4oGSYR5ggMATnzY0GwH+7cwuKXtkDizr0F51eMo3b6WTBmaGoz6y3Za93t977Dp/WVZDx7Th/Uky7/oGklIwZzjgWep9tAzWDF
 OxC/epAQ+lw+nSYn4w3eGo6puqKhXzQNtIJih9x3wA67ispBsug+SpzCXefV7Q7PP+0SHes1aQCQA1y7gVpsaYzHA4wTJwlKpXG44cizd2BEyPSkOkVbCQyc
 maH//MA9U64BDDhzoU1qQhHxL4jESb0isWicVxKGUMhbM/8WB1gikRuU+hF7vgz7KeRIulp8q7vgoT+dLOOCgz5H5qx7ctXVl6HcXNeOjBN1mIsdDq33YORX
 /p8=

This is the patch for the line discipline

Signed-off-by: Rodolfo Zitellini <rwz@xhero.org>

---
 include/uapi/linux/tty.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/tty.h b/include/uapi/linux/tty.h
index 68aeae2addec..bac4c0af67e6 100644
--- a/include/uapi/linux/tty.h
+++ b/include/uapi/linux/tty.h
@@ -39,8 +39,9 @@
 #define N_MCTP		28	/* MCTP-over-serial */
 #define N_DEVELOPMENT	29	/* Manual out-of-tree testing */
 #define N_CAN327	30	/* ELM327 based OBD-II interfaces */
+#define N_TASHTALK	31	/* TashTalk LocalTalk driver */
 
 /* Always the newest line discipline + 1 */
-#define NR_LDISCS	31
+#define NR_LDISCS	32
 
 #endif /* _UAPI_LINUX_TTY_H */
-- 
2.34.1


