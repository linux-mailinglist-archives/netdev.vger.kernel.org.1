Return-Path: <netdev+bounces-265749-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OVwE0Uvr2mWPQIAu9opvQ
	(envelope-from <netdev+bounces-265749-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 21:36:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54489240E78
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 21:36:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BECE2301080F
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 20:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6713D36B06C;
	Mon,  9 Mar 2026 20:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="RBaoiXyo"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2006k-snip4-11.eps.apple.com [57.103.85.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45C412FFDF7
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 20:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.85.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088529; cv=none; b=kEHAAxFkRazX0ET1iRPvG+f+yd3Urw5ToxmccSKPjxOlcHOQKCyHWjcDBLkZX19Eksj+tC4q0dmS9pliwEivrEdLPGeIHlvjU00IdCRdB/i79FA7P44J3/39xST0DAYqDcwcNPwt30+zOhxsDQ3v5WZ326M78WSo32my9DClbDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088529; c=relaxed/simple;
	bh=Hd7gyt4ncxrjqMgCjhCgu6D4EZhooxAN1ICu9LQNfPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P/YGjA4TKeif1jj0vjcMIQSK5Wlv9fKdWSPxzTfXdh4Fjz5S+q9fdGKt8n1h6RUDJ8CMzgpdpzsxTizW6fkONBqFDfXBj4CKQMEJ//NtPCg+/uhT9YCBSZPrX1fUlsyIQci9med/3uCCOFEvNwcTn9qSzWHL7XirG5N1lE/HQRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=RBaoiXyo; arc=none smtp.client-ip=57.103.85.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id D5E1F1800136;
	Mon,  9 Mar 2026 20:35:22 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1773088527; x=1775680527; bh=GP+HimxQkmCHhvW2f/bofyOK9zGczNr5vWuo/M2LS+w=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=RBaoiXyoTZkYOv/NjmS/S+KIhd6KcW0SzU9+6K6jACJiUvcQYAMv/hzwEWVSzUqLpY7kiSLgu6NErv6YngoIYBles0ovJg7319CdX35qkLFPSaGMGB4IKudOhnfK42bmdG5n/KIBBEH/U4YPvP+706FM11LssktwZ/It8dtsgldn9TiBlE1sG9KAYHsXg5GNgP/Bek+xP13n23WQp/fE0eMPwatHlgYgukkAaHKa0vUwcYx6L2fV7x8hqq3/4O5uzZCqBaRKJVHaMTsFZJeo4vT+AS1Cc9r/blQhKKyAUk+ATHEH0TbZLFtzj4QFr10aLYQOaQwKi2rPHnwWla+HBg==
Received: from bimmer.. (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id A08AF180031F;
	Mon,  9 Mar 2026 20:35:21 +0000 (UTC)
From: tobgaertner <tob.gaertner@me.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	oneukum@suse.com,
	bjorn@mork.no,
	tobgaertner <tob.gaertner@me.com>
Subject: [PATCH v2 2/2] net: usb: cdc_ncm: add ndpoffset to NDP32 nframes bounds check
Date: Mon,  9 Mar 2026 13:34:49 -0700
Message-ID: <20260309203449.2594858-3-tob.gaertner@me.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260309203449.2594858-1-tob.gaertner@me.com>
References: <20260309203449.2594858-1-tob.gaertner@me.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: vb-BSzWM5d3pl4KzEsW3l934PcE89MpT
X-Authority-Info-Out: v=2.4 cv=OsVCCi/t c=1 sm=1 tr=0 ts=69af2f0b
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=C3-SEi6G3EkA:10 a=VkNPw1HP01LnGYTKEx00:22 a=HHGDD-5mAAAA:8
 a=R_FKJuFUQJXXxj-Yl3QA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE4MiBTYWx0ZWRfX5ZZwW6R82I+p
 rvcTWUO77QF40w13QCldHaeSvssj93E13AONYPvuVwcchPoboIwZ5c3ooE3YRP3eb7swhFYwuWN
 hnjzxxPW+Pu0lvFLH3DSM4DZ+G53AlTtU4cepPF7SQP9HuvMrPJ1ZsY+x47qMIopIyJNoGXYYL+
 iEVipxrsUAkUvhMVd7tUrElR5ScN6HX0to6P36tCHgELjBAxIG0S2KH9J3JdvAcw/i/vFe0tcEY
 k8iRs33yxV+ND90GBh5XI4dAac6ojE7dqlked2S4VvbqvnWAFFIgugPldNKPVNUTZ3ixCQL3Qa9
 U/njWCrYglvdoouP1XZ5MPwg6NH4/SR73KEV+BR9JSkk3ZauyO4wF//IL87BoE=
X-Proofpoint-ORIG-GUID: vb-BSzWM5d3pl4KzEsW3l934PcE89MpT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 spamscore=0
 malwarescore=0 mlxlogscore=669 clxscore=1015 suspectscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603090182
X-JNJ: AAAAAAABl3TtMMWIhXlX0H5IPUtBCOj8seFdPsvRlWeFohc1/NWouBxdqKkXnZSF3TiifXparTWooN6Y0a3TS/ZKYIRnhwa7VyhuY4H0zKRrLk0GsTvEstexeGIrr+DhL3kWtzFExoQz0W+37A/et/9HjrrUA+G7evr+70asdLuCZPtYws9yy48PTzZ4DvSFfsnKtJQE/9pjNXIL6vEArGK1IKqDCTH45cNz7M5FL3k9SOkMLgo3yZ4sn7I0afMHhwaED9M4sS/I5uB+iOYCR35CTCsbSIJbTHvUYIVP28DVrPyWGgq6hsEfp5BVKR5g4l07cOGLPXQReQx8NeS/LRjl0DXU/cP80+2qyNYy/Yuo78rttWLKHHl2kghQUJTWShXZx8Aw5ymTebCEJHLYTNlTuOeGqKGct80DNETIbfWhKBfIf0QW93fWNvRw8qd7/PLevFu7/acHnGA9gbDvfrIG5jB9OVAVVQdDwhmagwxSP+1PRq5dfkltMu1VTCQJclX4ibxnZUabSmzw+Y1gzkTcmwuqm+o1ODhh16PreoDg7+BFxj4R6wX3Nsob60TU5mIft8je9c/SYf9MIse6LM1ntvxSvXbQzxxbcWloFk/+rma69DlxS9lWTVYb6h1q/11Zjc8B03Qw5TEif1kGmFlCey8LQhmOI5vHwUA+xSq5Ow7hHMtafvyRYA5HKzWC4VeTH7pXiGQy93i9GbnP3G3Xuxo7ih8i9g==
X-Apple-Category-Label: Mjg5MDYwMTc4OiRjYXRlZ29yeSRfUGVyc29uYWws
X-Rspamd-Queue-Id: 54489240E78
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[me.com,quarantine];
	R_DKIM_ALLOW(-0.20)[me.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[me.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,suse.com,mork.no,me.com];
	TAGGED_FROM(0.00)[bounces-265749-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

The same bounds-check bug fixed for NDP16 in the previous patch also
exists in cdc_ncm_rx_verify_ndp32(). The DPE array size is validated
against the total skb length without accounting for ndpoffset, allowing
out-of-bounds reads when the NDP32 is placed near the end of the NTB.

Add ndpoffset to the nframes bounds check and use struct_size_t() to
express the NDP-plus-DPE-array size more clearly.

Fixes: 0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer Block")
Signed-off-by: Tobi Gaertner <tob.gaertner@me.com>compile-tested only.
---
 drivers/net/usb/cdc_ncm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
index 846f8b997..0689169d3 100644
--- a/drivers/net/usb/cdc_ncm.c
+++ b/drivers/net/usb/cdc_ncm.c
@@ -1711,8 +1711,8 @@ int cdc_ncm_rx_verify_ndp32(struct sk_buff *skb_in, int ndpoffset)
 					sizeof(struct usb_cdc_ncm_dpe32));
 	ret--; /* we process NDP entries except for the last one */
 
-	if ((sizeof(struct usb_cdc_ncm_ndp32) +
-	     ret * (sizeof(struct usb_cdc_ncm_dpe32))) > skb_in->len) {
+	if (ndpoffset + struct_size_t(struct usb_cdc_ncm_ndp32,
+				     dpe32, ret) > skb_in->len) {
 		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);
 		ret = -EINVAL;
 	}
-- 
2.43.0


