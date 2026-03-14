Return-Path: <netdev+bounces-267671-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GL4aGVX2tGkHvAAAu9opvQ
	(envelope-from <netdev+bounces-267671-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 06:47:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C93D628BD21
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 06:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 668CF302E7F8
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 05:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EB19248F57;
	Sat, 14 Mar 2026 05:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="hPoRN+Tn"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster5-host2-snip4-4.eps.apple.com [57.103.79.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B021A3029
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 05:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773467218; cv=none; b=E/jKZu1faxINhFDHZhjv5GlnnDjvAh7iBxPeAkndrEYnaYgHZWOn3LtGINjJCTtfRRadEhyRh3iJVBp9cgTRr2DxmEojchjxsXAzwHN3k6oArG1JEFcMeL05f4YCM0MDmplTYhx06ufBLBczR63duTWduAMw+5iVXVc7Ai8BOVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773467218; c=relaxed/simple;
	bh=xXJANK+QVN0ybILeXpGThlMsZyph3b1yJJWPFGEbi5c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abPWd9DnMWelvpuBCES3siDio8OZpssrlhDavWZ+dxpxDLOsW7IHpF9fpQTGGiWNo8TevMZdjBtb2OIPNSEtzROQlzB3rhAuDPuMecKKUsrgBOBRRHJsZ/Q/4wYKZj1OPayTR/SuxXJ2SEqjCC3kLRO0Q/jMPjc5calWVXcaZoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=hPoRN+Tn; arc=none smtp.client-ip=57.103.79.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-3 (Postfix) with ESMTPS id 79A1418000AA;
	Sat, 14 Mar 2026 05:46:54 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1773467216; x=1776059216; bh=sgaus1XzjuCnQ0JHx85V94hD0f54pZgp+Wcv5gztz1c=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=hPoRN+Tn+T+zQAnxoPbKsDquMQHDJ2qhwxwUn3t+d0KEdfnJIU0qWF/rWnSgQtgI2dfPLwDx7l0Z20qV/gtLRz83bNkcn7x1g1NaDqMmhMgo8w2p7bL20v9TsXZ8OWSftpTDbHl0IdupuwfE7qIJfbe3sbrQOmqHKQZcAOPr9CcIyEb1fEPR1jYIKQE3ychSqWwEKMoFSjWH1OVtNpYou5/x9v6PNB/tKglqYDt40Vdvj2ZdyHfm5veWrZcxNWYX1Pxu/VEoIfF0UEZBdnnj6lFNqx9PmQtXur5hgebFO4wxTfAWHnPmakGwG7sWMaCk2kjgkIF/YXKmPfCSSM/QDw==
Received: from bimmer.. (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-3 (Postfix) with ESMTPSA id A1EEB18000A4;
	Sat, 14 Mar 2026 05:46:53 +0000 (UTC)
From: tobgaertner <tob.gaertner@me.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: kuba@kernel.org,
	gregkh@linuxfoundation.org,
	oneukum@suse.com,
	bjorn@mork.no,
	Tobi Gaertner <tob.gaertner@me.com>
Subject: [PATCH v3 1/2] net: usb: cdc_ncm: add ndpoffset to NDP16 nframes bounds check
Date: Fri, 13 Mar 2026 22:46:39 -0700
Message-ID: <20260314054640.2895026-2-tob.gaertner@me.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314054640.2895026-1-tob.gaertner@me.com>
References: <20260314054640.2895026-1-tob.gaertner@me.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDA0MiBTYWx0ZWRfX+5xygoMrZRtv
 AGfeUl80DEIKG0Qqf3TBuv91YZRxIRe5NUoCmWQzym1ZMjUfgVGmqsZP7nzN1q3ojkDZBnqIbBf
 gWD4zd+TRRG8x/y4yMBjELQKZkSTu7gHkPhKlhgJ3u9adlvBY4Y6HLHbEuB3E8iN4k1j/W/6urq
 PJ4xI+DRIBH9wgn1CZ/yCeW2r394JoVIMf6kB5bcObZhNg5kqdj6gWucJeMAFOfiJOEKrA4wk0J
 DFMey4xxFOaYl2jbzgG8ePClxgz8chSPw9z8lCvrWPksfXyLB7Y83q1Yl045nI6iYk2zUoBwNeZ
 Nu9oURJHfJ38xPhhnTyc0Ee7IZJW57GUTU7PzAHIoYX2S2DOQT8N7w1vyqcTT0=
X-Authority-Info-Out: v=2.4 cv=X6xf6WTe c=1 sm=1 tr=0 ts=69b4f64e
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=C3-SEi6G3EkA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8
 a=X9ZKYl2M72dmM7fdp4sA:9
X-Proofpoint-GUID: yA2GHtDjDPX4CZ7z90gAX0HPj3wxnIVT
X-Proofpoint-ORIG-GUID: yA2GHtDjDPX4CZ7z90gAX0HPj3wxnIVT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 phishscore=0 mlxscore=0 malwarescore=0 adultscore=0 clxscore=1015
 mlxlogscore=939 spamscore=0 lowpriorityscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603140042
X-JNJ: AAAAAAAB8E6g3ByPigf0kiJZ4NzNkDwXY37ImjtHq+HHLPfnFwbnm1rHE837oO42zyyFNDeMhSJpAlfE+kRIw5C9VRtjhc3d6xwlEKDnfuy7SIDX5l2AdxcPaAAGB4AKosVnKhcCQhOklc6evu8GS9AnenMXtTMg8WF749F8PjANiTZn0z3piR5S6vcnuQzPYEq3H0bBy1n1h1FFAiyxKUjXXYzBDqfmbfZ6fiflvPYQtfY2UAxoIG6MaLeL7sKE3lEbL35i7gBckJ9KtWA/EAWYuuiqSB0GO0ozi168t7HRem4D9jQnrfFYikxQ82+RdIgdhnB9rFPa1P4J6p9nV1XQ6c4XiHaSZDFf1dkwydcb3r8ujdf52H+e/vAbiQCwwYyCFkR1qSyhWeXY6F6ofyjMljLBho2cx6R7ERpxrHePKf0fVLRgQapa9L5LjfSpwFiB7RCYxsYBfqYdq2qHy2J0xFBbm/JY661LCK/axLRQKggi4IcPE2PUGllBWLJy00EmDp3KNwtI/k92Kmkjy6mz8M4jH31ai/OwflspfMIRGaBG0VlUOAG6bdRW7nJocPYRaNntg+mjDYeZ3wreaQAc3HX00yuOlmX1jaMe00djrdCWAlVfozwwjJjgn5klRTuTvvMuf3sUyxqwf25nv4wgcq4G3DsJWZLvN+qKKKeHBwgFSZ7F0p6/nS5uxofC+6Px1L4LJlmQ/UdcghEp
X-Apple-Category-Label: Mjg5MDYwMTc4OiRjYXRlZ29yeSRfUGVyc29uYWws
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[me.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[me.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,suse.com,mork.no,me.com];
	TAGGED_FROM(0.00)[bounces-267671-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tob.gaertner@me.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[me.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[me.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[me.com:dkim,me.com:email,me.com:mid]
X-Rspamd-Queue-Id: C93D628BD21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tobi Gaertner <tob.gaertner@me.com>

cdc_ncm_rx_verify_ndp16() validates that the NDP header and its DPE
entries fit within the skb. The first check correctly accounts for
ndpoffset:

  if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp16)) > skb_in->len)

but the second check omits it:

  if ((sizeof(struct usb_cdc_ncm_ndp16) +
       ret * (sizeof(struct usb_cdc_ncm_dpe16))) > skb_in->len)

This validates the DPE array size against the total skb length as if
the NDP were at offset 0, rather than at ndpoffset. When the NDP is
placed near the end of the NTB (large wNdpIndex), the DPE entries can
extend past the skb data buffer even though the check passes.
cdc_ncm_rx_fixup() then reads out-of-bounds memory when iterating
the DPE array.

Add ndpoffset to the nframes bounds check and use struct_size_t() to
express the NDP-plus-DPE-array size more clearly.

Fixes: ff06ab13a4cc ("net: cdc_ncm: splitting rx_fixup for code reuse")
Signed-off-by: Tobi Gaertner <tob.gaertner@me.com>
---
 drivers/net/usb/cdc_ncm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 5d123df0a..a9d0162b5 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1656,6 +1656,7 @@ int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset)
 	struct usbnet *dev = netdev_priv(skb_in->dev);
 	struct usb_cdc_ncm_ndp16 *ndp16;
 	int ret = -EINVAL;
+	size_t ndp_len;
 
 	if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp16)) > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "invalid NDP offset  <%u>\n",
@@ -1675,8 +1676,8 @@ int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset)
 					sizeof(struct usb_cdc_ncm_dpe16));
 	ret--; /* we process NDP entries except for the last one */
 
-	if ((sizeof(struct usb_cdc_ncm_ndp16) +
-	     ret * (sizeof(struct usb_cdc_ncm_dpe16))) > skb_in->len) {
+	ndp_len = struct_size_t(struct usb_cdc_ncm_ndp16, dpe16, ret);
+	if (ndpoffset + ndp_len > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);
 		ret = -EINVAL;
 	}
-- 
2.43.0


