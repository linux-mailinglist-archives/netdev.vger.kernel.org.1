Return-Path: <netdev+bounces-267672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eC5xFXn2tGkHvAAAu9opvQ
	(envelope-from <netdev+bounces-267672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 06:47:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C9828BD37
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 06:47:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F074A305B086
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 05:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9512F1FC3;
	Sat, 14 Mar 2026 05:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="D4hACL+f"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster5-host6-snip4-2.eps.apple.com [57.103.79.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE9D264614
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 05:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773467224; cv=none; b=kHFcSxty6QKW0aCSnT4S64bzQ1856KjvPAZeqiGmAV/DNmgrX5FP1He7nROBDVCVKz8k+Dy2Fc2LIimwn9XUlNVbcEOKf+9VtE6H4mVsPFO+puDrAGAGE8/4tNTXYLNFTp44YYGmPLbQxlqrb/odzr1VHKJCk4vFD4fpmbtca34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773467224; c=relaxed/simple;
	bh=r/Y9+eV0y9NRXpqsmsVhkOxb3EJuKBHFAD9Z9PX0OJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EzOqTZaOvrVsAf3J6PqGUW/8ZbglVOLq95LakvwDe486aO+ZKZgNsrMxl4GfxYCwPte1tP4jlvum3cdaRL4yoxlyzDQsGYpuxe8v3yhbXB9pkYVf6zJ7Un0OX2rR3a9Atg8Pv1QCoY02tsM78UQUMPWifbkspvinMYnzs3MZUH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=D4hACL+f; arc=none smtp.client-ip=57.103.79.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-3 (Postfix) with ESMTPS id C0A8518000BC;
	Sat, 14 Mar 2026 05:46:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1773467222; x=1776059222; bh=ByIdtOQ7hDJ1Q78bJf0XQmaMBtIrKorokTIO5FAIGkg=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=D4hACL+fMz2BKR8ne2CPlHfSmC1EMgAS7seSUUct3kiaOKjctP6Qnx2zh8btnLyafvbR7wXBG1xFRP7mjoJYgbvcwPKX+i2eLhHpjR3GEe8t7tvg2YZv6Yy6S3c/t/hHnQfDCXIDCcsHun9BdAOKorgN654jIJAC9sZLnGlTuIfKC9lgXzx1gE5greNGjTv6vopncSpoVbk+ZUIj2lACY7AZjVt2rTBZ/V1/rezzCXh0QV2iEvVj+LaLZPSmCqLXVHvHXFlV9O0aabeu/pK02qp7CPo/Gzx5fAodlMJF6x03ogApUfJu251psTFh0UKbuz7gB0CGUVY7sic3GXTqXg==
Received: from bimmer.. (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-3 (Postfix) with ESMTPSA id 01BE8180009D;
	Sat, 14 Mar 2026 05:46:56 +0000 (UTC)
From: tobgaertner <tob.gaertner@me.com>
To: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org
Cc: kuba@kernel.org,
	gregkh@linuxfoundation.org,
	oneukum@suse.com,
	bjorn@mork.no,
	Tobi Gaertner <tob.gaertner@me.com>
Subject: [PATCH v3 2/2] net: usb: cdc_ncm: add ndpoffset to NDP32 nframes bounds check
Date: Fri, 13 Mar 2026 22:46:40 -0700
Message-ID: <20260314054640.2895026-3-tob.gaertner@me.com>
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
X-Proofpoint-ORIG-GUID: YiFsOpSpNtPmcu0EKWRIpdaXii9R1PUl
X-Authority-Info-Out: v=2.4 cv=eb0wvrEH c=1 sm=1 tr=0 ts=69b4f654
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=C3-SEi6G3EkA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8
 a=LUIGT9A1_zUNolzWI8IA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE0MDAzOSBTYWx0ZWRfX+MdZNBbllHwk
 /gi1hr50s+x/NywSbA3hODeYJi1QcdWqQ5vY+M/B6fbpLLNvhDfS7lcgGyZQ6Kw4xEdSKjqA28L
 iSGFHJ3hqOxmcf0zfcY6JV0nxWUNYAWbUtCzFoXko1PuQM/Hv2MyyZKbcpfrjuwb3CVTxRNlxSF
 IzQixgHZAJlwWAsy3b44DXoz6D6bKdZuMbEX2JDkG7ucrW1M3cNcp5TUwHVJF8JIH9wO7vBRDB1
 dhIfasvQbZsJvKyqvcQ595nrQWZMOaHcDF5+EUvLzS6KGoDzN8Z6+u7sZEhV43nYZrp5FFG6qIq
 Cl9L26kWobrukkmu/PwwXP2zJ13vHoUxMuglPln9+jyx/gVeXMiJvJ7+tqbfOc=
X-Proofpoint-GUID: YiFsOpSpNtPmcu0EKWRIpdaXii9R1PUl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-14_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=800 phishscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603140039
X-JNJ: AAAAAAAB/+u1cLqjkcN8Ea3ZcclNdBqvxRNNL3hMAsmOBmoTQOPN+dJsr0dg6igthqnr8MhdvSrne1gTMrmKGxZqJPmPQgf3R3/k7nMCiqe3kxIJ8KiQ2IixxLq7NTsj6/c9iVrDYkKApQ/mM8eaQ+GZwIraFSKb/z7mjbOYCXIUVjUOtwU8wct7LTzV3yWqQlPcU7Gft9e2MdxXxQkUZSEgIrFsqescGKcfp72XK7JuloY1Bl2KZaXo8T1c91AgHICzAUhIF8AgiHJAv2wjqNH3RC6x3N5EN9hjoG+fm7Vp1D1fCCGf1CFkI3FcFpFHblXXQoau6EgRt/b35so1mD3xtilW/ygLp/AbARTp7FoXYFSCHx9hWkU1cr+NcGjZ9r3b9+8K+tAJ5Vd8BG5M/tODll7iXjCcXovNl5sa+E7aycZ0cneS4293wYvA68XpeCNsz5KMPHTlkP71ccqkvziVv2DwqmIHsDliAemm8NrYEzPq8w9bB/iB97PzA0iQAFYqWjfqbebMOPHCiU8NoIDkGTsglXzYDKOKtEO6qFkQ2LY29whm8MJI6O18wl3JbMYJmSp1epjgJkde6uV+XbRmN4CsGuowF3zbMeC2C+L4DNcK5dXDvtYXSwGOtNs6pSc7sLptXeyK2NqksVqoo9oJsMtkQD9kIhnxAT+3C2OV8SZI3vOXFrjq/zeVFqjSXtReeDM1b5MHQBI=
X-Apple-Category-Label: Mjg5MDYwMTc4OiRjYXRlZ29yeSRfUGVyc29uYWws
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[me.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[me.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,suse.com,mork.no,me.com];
	TAGGED_FROM(0.00)[bounces-267672-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[me.com:dkim,me.com:email,me.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C3C9828BD37
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Tobi Gaertner <tob.gaertner@me.com>

The same bounds-check bug fixed for NDP16 in the previous patch also
exists in cdc_ncm_rx_verify_ndp32(). The DPE array size is validated
against the total skb length without accounting for ndpoffset, allowing
out-of-bounds reads when the NDP32 is placed near the end of the NTB.

Add ndpoffset to the nframes bounds check and use struct_size_t() to
express the NDP-plus-DPE-array size more clearly.

Compile-tested only.

Fixes: 0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer Block")
Signed-off-by: Tobi Gaertner <tob.gaertner@me.com>
---
 drivers/net/usb/cdc_ncm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index a9d0162b5..81d7e99fc 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1693,6 +1693,7 @@ int cdc_ncm_rx_verify_ndp32(struct sk_buff *skb_in, int ndpoffset)
 	struct usbnet *dev = netdev_priv(skb_in->dev);
 	struct usb_cdc_ncm_ndp32 *ndp32;
 	int ret = -EINVAL;
+	size_t ndp_len;
 
 	if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp32)) > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "invalid NDP offset  <%u>\n",
@@ -1712,8 +1713,8 @@ int cdc_ncm_rx_verify_ndp32(struct sk_buff *skb_in, int ndpoffset)
 					sizeof(struct usb_cdc_ncm_dpe32));
 	ret--; /* we process NDP entries except for the last one */
 
-	if ((sizeof(struct usb_cdc_ncm_ndp32) +
-	     ret * (sizeof(struct usb_cdc_ncm_dpe32))) > skb_in->len) {
+	ndp_len = struct_size_t(struct usb_cdc_ncm_ndp32, dpe32, ret);
+	if (ndpoffset + ndp_len > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);
 		ret = -EINVAL;
 	}
-- 
2.43.0


