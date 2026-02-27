Return-Path: <netdev+bounces-261738-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIkDBmNHoWkirwQAu9opvQ
	(envelope-from <netdev+bounces-261738-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:27:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB361B3DDB
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 08:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 408A6308B411
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 07:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C5C346E7F;
	Fri, 27 Feb 2026 07:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="AlxxlEOY"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster1-host5-snip4-10.eps.apple.com [57.103.73.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C1F21ABD7
	for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 07:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.73.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772176969; cv=none; b=qPzgkdpnSg1u1VGPtHISIEKFIMk6SikgZHV+k9bmk+XpRSGkCSOz3tC5tLB80+X5tJ7+t/Pk2O1sR052k7Iy8GDo1b9e5u4zWGGHqt3DQmnGj+Dc1NpiKNZFwcnLpsNwGQlHNWnWMxZjW5FXReEqLaxV251MnbZ/c0skBK2RCig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772176969; c=relaxed/simple;
	bh=w98eDsZkzjEe+Ffyv9Ip+o/RLVFx44efBAuFt2TydPk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nJnf2smilkFYYCC/Kwh61Kc2ck8oAaKOo7Op2Jx0qkMSYKaGxNbdWYOz/S3UgOSILunfqzJBuL7WpdpkyUkyZk9ZmKjw0MqpwQximBqJqpxXd11cPXdvaWhoN2OK6X5HSi7xb6cXlV5TyDjsfFt9+tCVarj3rP7sklnpPrawdGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=AlxxlEOY; arc=none smtp.client-ip=57.103.73.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPS id F037D180010F;
	Fri, 27 Feb 2026 07:22:45 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1772176968; x=1774768968; bh=wsqdwjcS/G8vahkuU8zoCOVkVQ5Hgnn4VlKPjVEpLaM=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=AlxxlEOY3GXSVv04PIOkkmUsjbC45C1x+8KqUzngXSEIyEBy9d3rO1u+u5DQA2CbGY6R54pc5sbf7zB2tmTVYp3Zb3hGnmMAeJaaDvqdhd/Ba/iOuw9LMntT9swbIBBBHY2/wk5Sl5t+1MSrqdxl6KCZQFo70SvQ8RYHP6zDIaQz50DSYOrO3IUrA3zJN1KSnbIoLf427+CVvrVmWnEBITKKOGUpnjSbQYmFHJ8KjR4p36gmveSaHycues1mAw0iJw7Sv1oGmoIZzdf8iVAjjLKI7bJTCBDbvE6hK/uNfcJMF4ICK9BgIR5HrlqXzBMeIrqEu3/8BUQFXpETqxEeHQ==
Received: from bimmer.. (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-10-percent-0 (Postfix) with ESMTPSA id CF42C18000BE;
	Fri, 27 Feb 2026 07:22:44 +0000 (UTC)
From: tobgaertner <tob.gaertner@me.com>
To: linux-usb@vger.kernel.org,
	netdev@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	oneukum@suse.com,
	bjorn@mork.no,
	Tobi Gaertner <tob.gaertner@me.com>
Subject: [PATCH] net: usb: cdc_ncm: add ndpoffset to nframes bounds check
Date: Thu, 26 Feb 2026 23:22:41 -0800
Message-ID: <20260227072241.566212-1-tob.gaertner@me.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI3MDA2MSBTYWx0ZWRfX6Gv1WuhgHBuF
 +s8G7wNPPaW6SVOYiY11y8wqYCQP7fOKdaBF8c3jnhiwQOiwXFaiRQDPJJ85Heip8ZKuUHmKHDQ
 W1DUtLvgNpfPnurhhnTQXvSwPPUSe2gQXqxzR1jfKgEWDywTuhxer3VmHt4yHObRjC5Xt/Bqi3K
 ZINci8y3td/6wBJ+QIwPL2Pd9nLJ4o9/CYypCeFeVH84pZwGbwSZzyzM+ooZds8cgCgfUT8+4l5
 IImBHSJX0dB9leOaLlbzDaMEWVHZ6NlawaFxTl+4PCg8Pz484LQBWKH9xyMwABW21Cw+h1S7Rd4
 UHyeMea1di5QnXSxY9LtHAw1cJKtZZwGgpmpL53IoJICOB2XZEFvERDOk7FiZs=
X-Proofpoint-GUID: ulfFZAcguy4Rhl7WJyPVunenllPl93KH
X-Proofpoint-ORIG-GUID: ulfFZAcguy4Rhl7WJyPVunenllPl93KH
X-Authority-Info-Out: v=2.4 cv=K8Av3iWI c=1 sm=1 tr=0 ts=69a14646
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=HzLeVaNsDn8A:10
 a=x7bEGLp0ZPQA:10 a=C3-SEi6G3EkA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=HHGDD-5mAAAA:8
 a=X9ZKYl2M72dmM7fdp4sA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-27_01,2026-02-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0
 clxscore=1011 mlxlogscore=747 bulkscore=0 mlxscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602270061
X-JNJ: AAAAAAABd3KSaJBbs9c6X/UwNWlOgP/5uiofsBdgGLg/Jz/ezut8NS9azSRLbjAJWR2euNReGH+oBW7Oyo2pNvbTjFYQOWK/ipLwvC2T3XFtjKu/xcKJEFCORGlR/cFVpbp23Fu875i3kmCBg4B6RpqwZpkKPQSF/IHOYhBkwoj8Vi+NculbFDENyARMPkzbo7f/efJG4GmnMiad+wABer2lNdiWtIvY10SVSLHcCcqSprP3bBBfqhe6wyFs8WgPemId/y/ayNErod/1UqH6oJXvtR08Nw8DxA3UXnlz+Pouy6XJ+SNYNn4Tib/Fg/hDe2RSEC4V82vM2LLMBkycwhxSnJ58nq5VBQNmCUU9JKYINliV1cWaOXtseaWO10+iZrx5jhejjjFZ/MeIb0AMtiSw0zmFbPupaQZjwfX2ALfCAUH/u+ynXOmQgAY6Dbws/sMTg9oueoI20RdAX+x3+f4+G00GIbngpy9fdtC8w9a/qlJtYSTn3sdMfevI9wDfnxYYklO1PLLmAP4ckEzoTgVdG79MaFGb/vHJzDZNls4kxnVxNBISNaj5w4Q7SLFXh2LFX+PYiUyD5ie+qTV5E7gwGQOPtpcD6YHGKO9Nadn6pm69xe4V0537X1jpyC4dNxLXJnFdVbOiIMK73BXJGP7VO+YgESLEOKSsyqGMkftYba15cg==
X-Apple-Category-Label: Mjg5MDYwMTc4OiRjYXRlZ29yeSRfUGVyc29uYWws
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[me.com,quarantine];
	R_DKIM_ALLOW(-0.20)[me.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[me.com];
	FREEMAIL_CC(0.00)[linuxfoundation.org,suse.com,mork.no,me.com];
	TAGGED_FROM(0.00)[bounces-261738-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tob.gaertner@me.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[me.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,me.com:mid,me.com:dkim,me.com:email]
X-Rspamd-Queue-Id: 6FB361B3DDB
X-Rspamd-Action: no action

From: Tobi Gaertner <tob.gaertner@me.com>

cdc_ncm_rx_verify_ndp16() and cdc_ncm_rx_verify_ndp32() validate that
the NDP header and its DPE entries fit within the skb. The first check
correctly accounts for ndpoffset:

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

Add ndpoffset to the nframes bounds check in both the NDP16 and NDP32
verification functions.

Found by coverage-guided fuzzing with QEMU system-mode emulation.

Fixes: ff06ab13a4cc ("net: cdc_ncm: splitting rx_fixup for code reuse")
Signed-off-by: Tobi Gaertner <tob.gaertner@me.com>
---
 drivers/net/usb/cdc_ncm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 5d123df0a..39d2ad95d 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1675,7 +1675,7 @@ int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset)
 					sizeof(struct usb_cdc_ncm_dpe16));
 	ret--; /* we process NDP entries except for the last one */
 
-	if ((sizeof(struct usb_cdc_ncm_ndp16) +
+	if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp16) +
 	     ret * (sizeof(struct usb_cdc_ncm_dpe16))) > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);
 		ret = -EINVAL;
@@ -1711,7 +1711,7 @@ int cdc_ncm_rx_verify_ndp32(struct sk_buff *skb_in, int ndpoffset)
 					sizeof(struct usb_cdc_ncm_dpe32));
 	ret--; /* we process NDP entries except for the last one */
 
-	if ((sizeof(struct usb_cdc_ncm_ndp32) +
+	if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp32) +
 	     ret * (sizeof(struct usb_cdc_ncm_dpe32))) > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);
 		ret = -EINVAL;
-- 
2.43.0


