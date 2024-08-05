Return-Path: <netdev+bounces-115834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D070F947F48
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 18:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0F01C21119
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 16:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69ED115E5CB;
	Mon,  5 Aug 2024 16:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ISfsfpKg"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3972515C12F;
	Mon,  5 Aug 2024 16:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722875074; cv=none; b=Sp2ep5PyW4+T/JoZMIOBAeXK/yeegJYKYVVVp7SVTJ9Ztyzz1jfOF3OMntqZtxdgQ3/5+r40JAfBRkaPJjIPj76h+p+Ar/IWMQWpFVK6UXIG29l7aTocppLpHSlVqGVeC+0/7z0jXOTfacGVk4WCUHdx++cVoTW5MdVbMYmQ0r0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722875074; c=relaxed/simple;
	bh=Ye5K+2WX+QVln0pMQeyafCRvdteEp2wVQ6NkGAh738E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=KNdl0WniyOsRI3fkhSvxS9/yDrP/eZnBM1jwhHAdNh8X4c1G5OaLf7pyMEOqPEu8rowMi6h0mj2+muk7Xl83xrl508v/n5K1V7ikDzDFXM6aosXGMzoGFjD/Stq4IzNlu76XAyQ5PylqtdIskXxEHbIua+VVH6Wq3u2k+RP/TaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ISfsfpKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4AFAC4AF0E;
	Mon,  5 Aug 2024 16:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722875073;
	bh=Ye5K+2WX+QVln0pMQeyafCRvdteEp2wVQ6NkGAh738E=;
	h=Date:From:To:Cc:Subject:From;
	b=ISfsfpKg6BlZu/rxLShqd/U4pzi9REHRbp8SbY1G4eRIJlx621TBuiEmxH9g5Oq52
	 B9PwFN85pWscEmFnLtOV+cbw/WfFd7W+dmgbeRBtpxhM9P7wv5DByd9UICtp7gQIQP
	 SSrrlLxq3cn1yXCrw3l7zWTpwyuVKmQVgeK5FEkI6UP2apJi5AbyksENuCaDGlhlrl
	 axO/79MFpFKpGRZlhVXDuvR8kctNUZPL2TUshhAB5tBWJdL249dvoX07JGWNNFIObA
	 T+m1/x1ur+JpVg1z5eXS9veaXkct4I/CBgP9iYHg9siZHMKLumU68OKlzol+i83Seo
	 W28vxppEwXuew==
Date: Mon, 5 Aug 2024 10:24:30 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Potnuri Bharat Teja <bharat@chelsio.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH][next] cxgb4: Avoid -Wflex-array-member-not-at-end warning
Message-ID: <ZrD8vpfiYugd0cPQ@cute>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

So, in order to avoid ending up with a flexible-array member in the
middle of multiple other structs, we use the `__struct_group()`
helper to create a new tagged `struct tc_u32_sel_hdr`. This structure
groups together all the members of the flexible `struct tc_u32_sel`
except the flexible array.

As a result, the array is effectively separated from the rest of the
members without modifying the memory layout of the flexible structure.
We then change the type of the middle struct member currently causing
trouble from `struct tc_u32_sel` to `struct tc_u32_sel_hdr`.

This approach avoids having to implement `struct tc_u32_sel_hdr`
as a completely separate structure, thus preventing having to maintain
two independent but basically identical structures, closing the door
to potential bugs in the future.

So, with these changes, fix the following warning:
drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h:245:27: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 .../chelsio/cxgb4/cxgb4_tc_u32_parse.h        |  2 +-
 include/uapi/linux/pkt_cls.h                  | 23 +++++++++++--------
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
index 9050568a034c..64663112cad8 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_tc_u32_parse.h
@@ -242,7 +242,7 @@ struct cxgb4_next_header {
 	 * field's value to jump to next header such as IHL field
 	 * in IPv4 header.
 	 */
-	struct tc_u32_sel sel;
+	struct tc_u32_sel_hdr sel;
 	struct tc_u32_key key;
 	/* location of jump to make */
 	const struct cxgb4_match_field *jump;
diff --git a/include/uapi/linux/pkt_cls.h b/include/uapi/linux/pkt_cls.h
index d36d9cdf0c00..2c32080416b5 100644
--- a/include/uapi/linux/pkt_cls.h
+++ b/include/uapi/linux/pkt_cls.h
@@ -246,16 +246,19 @@ struct tc_u32_key {
 };
 
 struct tc_u32_sel {
-	unsigned char		flags;
-	unsigned char		offshift;
-	unsigned char		nkeys;
-
-	__be16			offmask;
-	__u16			off;
-	short			offoff;
-
-	short			hoff;
-	__be32			hmask;
+	/* New members MUST be added within the __struct_group() macro below. */
+	__struct_group(tc_u32_sel_hdr, hdr, /* no attrs */,
+		unsigned char		flags;
+		unsigned char		offshift;
+		unsigned char		nkeys;
+
+		__be16			offmask;
+		__u16			off;
+		short			offoff;
+
+		short			hoff;
+		__be32			hmask;
+	);
 	struct tc_u32_key	keys[];
 };
 
-- 
2.34.1


