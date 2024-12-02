Return-Path: <netdev+bounces-148140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C0EB99E0AE6
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 19:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2C087B2BAF6
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 15:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97DE1208993;
	Mon,  2 Dec 2024 15:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jkFmoR5A"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80619208986;
	Mon,  2 Dec 2024 15:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733153659; cv=none; b=iyQ7iYVi5st4x3c7ovwS0CliYLp7Gete40+aRX3AWB/wSQ2NtGu6PZcjEdN+Y/CkFQXX0rXMLAWA9BET5FJvuUOmaSbiApDjPx2zhh7pNdxqLpsiol0HnhssD3DxiVVj7fCiae0mZBQgL1Na6g4lV+PIJ+ZrgwyM5NFKS1g2KKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733153659; c=relaxed/simple;
	bh=26VnanjFRCPQ64E+0QrEzr8k+WRBR1WeMvaZsB9GYfA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KoKGDcZ20CCHyPe6tj4AJwJQNWfv+LWZui0ppjIUs1MvuadzfRKJFrTHUQiZ0znqaZnYK1IoBow4/EvtR5rqf2GMvztJwDbz9tPAMiiuSA/QVETSM8HJJLGi/2vgYS7OYun+nIOAaOc1Rv1iEEUuTvn7zi0vpixyGWE/b1pS3Jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jkFmoR5A; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2D531E000E;
	Mon,  2 Dec 2024 15:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733153649;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=GH73Zxavz3tXadnXYMcGQBHsBqaFNZnzohIfStkLYAM=;
	b=jkFmoR5AQNvVJ/5yuNA2ROvXY2LA2a8qcz2kU7gVCFdTUdoTQ68yJuYAVBoMVSgOoyXRYc
	sGdkrJkO/HKRXS+4KRSEyxYiZRWpgHTPInijGeUskeKKxDVLP6qrAWN2e+HupM2t1V/Uhe
	Xwj+oxMjqn4zFBuuVUi7Q9U2EZy0qR47YCw0+Bi6HKr5GnVnXQarej5Fihmm1LGEZViiGz
	qUvkOlyUVDaIuSSgmiCnkAhRLHsJ05xYe04aUHbMOrre6XMx+XGplKXJHzQH02PNoUQRHf
	ywdNA1hcDHf8HJyf9JPImarXCK2yYIQnJeEboraFpLzdCFA2OLVj/am04/cOJg==
From: Kory Maincent <kory.maincent@bootlin.com>
To: Michal Kubecek <mkubecek@suse.cz>,
	"David S. Miller" <davem@davemloft.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	thomas.petazzoni@bootlin.com,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>
Subject: [PATCH net v4] ethtool: Fix wrong mod state in case of verbose and no_mask bitset
Date: Mon,  2 Dec 2024 16:33:57 +0100
Message-Id: <20241202153358.1142095-1-kory.maincent@bootlin.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: kory.maincent@bootlin.com

A bitset without mask in a _SET request means we want exactly the bits in
the bitset to be set. This works correctly for compact format but when
verbose format is parsed, ethnl_update_bitset32_verbose() only sets the
bits present in the request bitset but does not clear the rest. The commit
6699170376ab ("ethtool: fix application of verbose no_mask bitset") fixes
this issue by clearing the whole target bitmap before we start iterating.
The solution proposed brought an issue with the behavior of the mod
variable. As the bitset is always cleared the old value will always
differ to the new value.

Fix it by adding a new function to compare bitmaps and a temporary variable
which save the state of the old bitmap.

Fixes: 6699170376ab ("ethtool: fix application of verbose no_mask bitset")
Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Resend a fix that got merged and reverted because it was broken.
https://lore.kernel.org/netdev/20231009133645.44503-1-kory.maincent@bootlin.com/
https://lore.kernel.org/netdev/20231019070904.521718-1-o.rempel@pengutronix.de/
https://lore.kernel.org/netdev/20231019-feature_ptp_bitset_fix-v1-1-70f3c429a221@bootlin.com/

Thanks Michal for the code proposal.

Changes in v4:
- Add the function purposed by Michal for bitmap comparison.

Changes in v3:
- Add comment.
- Updated variable naming.
- Add orig_bitmap variable to avoid n_mask condition in the
  nla_for_each_nested() loop.

Changes in v2:
- Fix the allocated size.
---
 net/ethtool/bitset.c | 48 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 44 insertions(+), 4 deletions(-)

diff --git a/net/ethtool/bitset.c b/net/ethtool/bitset.c
index 0515d6604b3b..f0883357d12e 100644
--- a/net/ethtool/bitset.c
+++ b/net/ethtool/bitset.c
@@ -425,12 +425,32 @@ static int ethnl_parse_bit(unsigned int *index, bool *val, unsigned int nbits,
 	return 0;
 }
 
+/**
+ * ethnl_bitmap32_equal() - Compare two bitmaps
+ * @map1:  first bitmap
+ * @map2:  second bitmap
+ * @nbits: bit size to compare
+ *
+ * Return: true if first @nbits are equal, false if not
+ */
+static bool ethnl_bitmap32_equal(const u32 *map1, const u32 *map2,
+				 unsigned int nbits)
+{
+	if (memcmp(map1, map2, nbits / 32 * sizeof(u32)))
+		return false;
+	if (nbits % 32 == 0)
+		return true;
+	return !((map1[nbits / 32] ^ map2[nbits / 32]) &
+		 ethnl_lower_bits(nbits % 32));
+}
+
 static int
 ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 			      const struct nlattr *attr, struct nlattr **tb,
 			      ethnl_string_array_t names,
 			      struct netlink_ext_ack *extack, bool *mod)
 {
+	u32 *saved_bitmap = NULL;
 	struct nlattr *bit_attr;
 	bool no_mask;
 	int rem;
@@ -448,8 +468,20 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 	}
 
 	no_mask = tb[ETHTOOL_A_BITSET_NOMASK];
-	if (no_mask)
-		ethnl_bitmap32_clear(bitmap, 0, nbits, mod);
+	if (no_mask) {
+		unsigned int nwords = DIV_ROUND_UP(nbits, 32);
+		unsigned int nbytes = nwords * sizeof(u32);
+		bool dummy;
+
+		/* The bitmap size is only the size of the map part without
+		 * its mask part.
+		 */
+		saved_bitmap = kcalloc(nwords, sizeof(u32), GFP_KERNEL);
+		if (!saved_bitmap)
+			return -ENOMEM;
+		memcpy(saved_bitmap, bitmap, nbytes);
+		ethnl_bitmap32_clear(bitmap, 0, nbits, &dummy);
+	}
 
 	nla_for_each_nested(bit_attr, tb[ETHTOOL_A_BITSET_BITS], rem) {
 		bool old_val, new_val;
@@ -458,22 +490,30 @@ ethnl_update_bitset32_verbose(u32 *bitmap, unsigned int nbits,
 		if (nla_type(bit_attr) != ETHTOOL_A_BITSET_BITS_BIT) {
 			NL_SET_ERR_MSG_ATTR(extack, bit_attr,
 					    "only ETHTOOL_A_BITSET_BITS_BIT allowed in ETHTOOL_A_BITSET_BITS");
+			kfree(saved_bitmap);
 			return -EINVAL;
 		}
 		ret = ethnl_parse_bit(&idx, &new_val, nbits, bit_attr, no_mask,
 				      names, extack);
-		if (ret < 0)
+		if (ret < 0) {
+			kfree(saved_bitmap);
 			return ret;
+		}
 		old_val = bitmap[idx / 32] & ((u32)1 << (idx % 32));
 		if (new_val != old_val) {
 			if (new_val)
 				bitmap[idx / 32] |= ((u32)1 << (idx % 32));
 			else
 				bitmap[idx / 32] &= ~((u32)1 << (idx % 32));
-			*mod = true;
+			if (!no_mask)
+				*mod = true;
 		}
 	}
 
+	if (no_mask && !ethnl_bitmap32_equal(saved_bitmap, bitmap, nbits))
+		*mod = true;
+
+	kfree(saved_bitmap);
 	return 0;
 }
 
-- 
2.34.1


