Return-Path: <netdev+bounces-241392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B9DC83543
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 05:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 514723AF41E
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 04:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10664284B2F;
	Tue, 25 Nov 2025 04:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHd5+0qB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40FA284689;
	Tue, 25 Nov 2025 04:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764044864; cv=none; b=meQS2+8YM13me+BNHDVmHJWVM3CvCtaVyRBmg8Y3jow4vSuUmFRRSB63cdHw2sy8gtLcji145ZaWROzieCop6Ekj5sgJLOGO0SSO+boPYbu+vksD/1hnCYRLuBdDKWa/CzvaWDfwNKIY4oXNNjPWQtdQUUyb5Xmod20dYcKYtJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764044864; c=relaxed/simple;
	bh=dJz1VBLyE+1afRYMUHSehOjVIEK7YWP+3LTbyiNgxhg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=laQjqbiKj8ZWmAQAvOcYqxuizMMgp0TV64zD9sZisCif5cAYMyzkvNkaAuVkFEA8h//CNs45WfPvqnYm4t1VSm6TvdtDjjGVEpQa3kdEbhk1IBBSjZQsvnn7vKFkiRMr3Mg/hgQTVIxaK2dTFN/+pA+hqFfA+VlWXj//2EWbZr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cHd5+0qB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB5FC4CEF1;
	Tue, 25 Nov 2025 04:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764044864;
	bh=dJz1VBLyE+1afRYMUHSehOjVIEK7YWP+3LTbyiNgxhg=;
	h=Date:From:To:Cc:Subject:From;
	b=cHd5+0qBYv/8Dk5RSM9tgM/Q0SGPiQH0vm5nrh7oxoBKXd0PvzVC1CJCWfPJlXZjm
	 oGxykI1RMQp9E4C36lE5c9k5+37gZfKCifBSxC0TbIflhXqRtSe+tLm7XGOhCFD553
	 z0CepCnKXi4+KbfJPIvb/Pqu9zxPmJBp5Db5mn+cEeq223i2tSZvGVE7rnez1aKjJt
	 5iK2kCKniIvJh3ds1/aZme/+QkHfkA+lYm3XNIhgWrmJ/lxN/r2+lOAIvpDd9iuA0K
	 cE+Vu3cvYxrVahhxEO9zB+ly+FKlS75bypjsGDqQ8Nsrk2wcBuWFwFjfL5MAuYN/+X
	 NyPEGQR7629cA==
Date: Tue, 25 Nov 2025 13:27:38 +0900
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2][next] net: wwan: mhi_wwan_mbim: Avoid
 -Wflex-array-member-not-at-end warning
Message-ID: <aSUwOtiDMYA8aSC3@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Use DEFINE_RAW_FLEX() to avoid a -Wflex-array-member-not-at-end warning.

Remove fixed-size array struct usb_cdc_ncm_dpe16 dpe16[2]; from struct
mbim_tx_hdr, so that flex-array member struct mbim_tx_hdr::ndp16.dpe16[]
ends last in this structure.

Compensate for this by using the DEFINE_RAW_FLEX() helper to declare the
on-stack struct instance that contains struct usb_cdc_ncm_ndp16 as a
member. Adjust the rest of the code, accordingly.

So, with these changes fix the following warning:

drivers/net/wwan/mhi_wwan_mbim.c:81:34: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Add code comment to prevent people from adding new members after
   flex struct member `struct usb_cdc_ncm_ndp16 ndp16;`

v1:
 - Link: https://lore.kernel.org/linux-hardening/aSUubvYfGJ-BIeDq@kspp/

 drivers/net/wwan/mhi_wwan_mbim.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wwan/mhi_wwan_mbim.c b/drivers/net/wwan/mhi_wwan_mbim.c
index c814fbd756a1..313dc5207c93 100644
--- a/drivers/net/wwan/mhi_wwan_mbim.c
+++ b/drivers/net/wwan/mhi_wwan_mbim.c
@@ -78,8 +78,9 @@ struct mhi_mbim_context {
 
 struct mbim_tx_hdr {
 	struct usb_cdc_ncm_nth16 nth16;
+
+	/* Must be last as it ends in a flexible-array member. */
 	struct usb_cdc_ncm_ndp16 ndp16;
-	struct usb_cdc_ncm_dpe16 dpe16[2];
 } __packed;
 
 static struct mhi_mbim_link *mhi_mbim_get_link_rcu(struct mhi_mbim_context *mbim,
@@ -107,20 +108,20 @@ static int mhi_mbim_get_link_mux_id(struct mhi_controller *cntrl)
 static struct sk_buff *mbim_tx_fixup(struct sk_buff *skb, unsigned int session,
 				     u16 tx_seq)
 {
+	DEFINE_RAW_FLEX(struct mbim_tx_hdr, mbim_hdr, ndp16.dpe16, 2);
 	unsigned int dgram_size = skb->len;
 	struct usb_cdc_ncm_nth16 *nth16;
 	struct usb_cdc_ncm_ndp16 *ndp16;
-	struct mbim_tx_hdr *mbim_hdr;
 
 	/* Only one NDP is sent, containing the IP packet (no aggregation) */
 
 	/* Ensure we have enough headroom for crafting MBIM header */
-	if (skb_cow_head(skb, sizeof(struct mbim_tx_hdr))) {
+	if (skb_cow_head(skb, __struct_size(mbim_hdr))) {
 		dev_kfree_skb_any(skb);
 		return NULL;
 	}
 
-	mbim_hdr = skb_push(skb, sizeof(struct mbim_tx_hdr));
+	mbim_hdr = skb_push(skb, __struct_size(mbim_hdr));
 
 	/* Fill NTB header */
 	nth16 = &mbim_hdr->nth16;
@@ -133,12 +134,11 @@ static struct sk_buff *mbim_tx_fixup(struct sk_buff *skb, unsigned int session,
 	/* Fill the unique NDP */
 	ndp16 = &mbim_hdr->ndp16;
 	ndp16->dwSignature = cpu_to_le32(USB_CDC_MBIM_NDP16_IPS_SIGN | (session << 24));
-	ndp16->wLength = cpu_to_le16(sizeof(struct usb_cdc_ncm_ndp16)
-					+ sizeof(struct usb_cdc_ncm_dpe16) * 2);
+	ndp16->wLength = cpu_to_le16(struct_size(ndp16, dpe16, 2));
 	ndp16->wNextNdpIndex = 0;
 
 	/* Datagram follows the mbim header */
-	ndp16->dpe16[0].wDatagramIndex = cpu_to_le16(sizeof(struct mbim_tx_hdr));
+	ndp16->dpe16[0].wDatagramIndex = cpu_to_le16(__struct_size(mbim_hdr));
 	ndp16->dpe16[0].wDatagramLength = cpu_to_le16(dgram_size);
 
 	/* null termination */
@@ -584,7 +584,7 @@ static void mhi_mbim_setup(struct net_device *ndev)
 {
 	ndev->header_ops = NULL;  /* No header */
 	ndev->type = ARPHRD_RAWIP;
-	ndev->needed_headroom = sizeof(struct mbim_tx_hdr);
+	ndev->needed_headroom = struct_size_t(struct mbim_tx_hdr, ndp16.dpe16, 2);
 	ndev->hard_header_len = 0;
 	ndev->addr_len = 0;
 	ndev->flags = IFF_POINTOPOINT | IFF_NOARP;
-- 
2.43.0


