Return-Path: <netdev+bounces-265747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eEqEGPcvr2mWPQIAu9opvQ
	(envelope-from <netdev+bounces-265747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 21:39:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D7FDA240F54
	for <lists+netdev@lfdr.de>; Mon, 09 Mar 2026 21:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC1E73099832
	for <lists+netdev@lfdr.de>; Mon,  9 Mar 2026 20:35:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279582FFDF7;
	Mon,  9 Mar 2026 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b="v35Nfc9B"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.qs.icloud.com (qs-2006k-snip4-1.eps.apple.com [57.103.85.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEAB936AB52
	for <netdev@vger.kernel.org>; Mon,  9 Mar 2026 20:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.85.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773088516; cv=none; b=DN9nLwGj/hfCi2kt1iry2602iOIeGKQFSMjSnrDoY7YlhUV7Y7t2p6CD1atlU80gyxnPyuBQTdRW1ThTzbpKaSGhUjyH2M4T11P6lEAxFXQqCpo/XRnrVL5kI4wUw506hMbuBIvHGWyxsvWArhlXh0yaLx90tcJAIpzpcQtlaZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773088516; c=relaxed/simple;
	bh=lIgX9dZdyiFvlaAuDHbziUCNOnrZy6jpeYu49ndfbnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pzEKRrZ3UwWGLRY6X04Lq77coR1DijTnCKEaYAe7tg9UVftIjKmKUJPeds03JDlX9gNc5pCSzQQzRPcO/c4oDHZ7mKeGi6CTdXeLWXURDoowXaDCiqstVg0JbkuFPM80VDVgqetkpoPg4hY56Xl6KgSmURnyrv2WmOAa5jzBrRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com; spf=pass smtp.mailfrom=me.com; dkim=pass (2048-bit key) header.d=me.com header.i=@me.com header.b=v35Nfc9B; arc=none smtp.client-ip=57.103.85.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=me.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=me.com
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPS id 666811800312;
	Mon,  9 Mar 2026 20:35:11 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai; t=1773088514; x=1775680514; bh=AkLbhD4ZHGNf1q4JHn050zY+yPCHe3qzMApHhpu5F6A=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=v35Nfc9BB+TdaD8Wk0yC3iwrA1GjPLiHnxXN/dWjfjkKRezO91BA384mfeLvDNpNJEND+OCZx+nH94A945Sth/4YhudihfFxEuu1NF9njCeKDWNYozm6S3AiTsCZM5CSI0jB3tCsdt2Wx80PQmGhvLa2LOh8W89o5g0pEVXVuwemi4cBdWHz+G5yqEEOJugFXsntQAAQq4961FN/YQ+22uQW8OcUc9I/BZFWuAQkoKQKhkjg+NbjsTptlfrwblQzml7MR8HozdLd+oL/LughfRZxXblkSE7xi1KPBq2fIoqMJy0iDsx57RoRg2NaTMuJauQRqO7l23Q8PaI3anZTvw==
Received: from bimmer.. (unknown [17.57.155.37])
	by p00-icloudmta-asmtp-us-east-2d-60-percent-7 (Postfix) with ESMTPSA id 12E951800381;
	Mon,  9 Mar 2026 20:35:09 +0000 (UTC)
From: tobgaertner <tob.gaertner@me.com>
To: netdev@vger.kernel.org
Cc: linux-usb@vger.kernel.org,
	gregkh@linuxfoundation.org,
	oneukum@suse.com,
	bjorn@mork.no,
	tobgaertner <tob.gaertner@me.com>
Subject: [PATCH v2 0/2] net: usb: cdc_ncm: fix NDP nframes bounds check
Date: Mon,  9 Mar 2026 13:34:47 -0700
Message-ID: <20260309203449.2594858-1-tob.gaertner@me.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=ZPHaWH7b c=1 sm=1 tr=0 ts=69af2eff
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=Yq5XynenixoA:10 a=x7bEGLp0ZPQA:10
 a=C3-SEi6G3EkA:10 a=VkNPw1HP01LnGYTKEx00:22 a=lWcYMVTi8GCtAv3fkTgA:9
X-Proofpoint-GUID: USU0WP56bUvyG1STNF4IOojq7PXOKWSO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA5MDE4MiBTYWx0ZWRfX3d5OjlybQRRZ
 T9AsTPcUCM8giDdtpBYlgZIE54xuETbSk/jpod4gbrAxSUB3yRZM63sqBinHTpedhrlTneBRlTa
 yPqG96VKccDjqkK6QAVdmRs7gQKcnFZB7nhDiznGwRqM2RRAusOSMzvpD8sX4MKA3eZXCEf5ygQ
 6nTbx9E4vAr8szkjmNR8CgLBtSG+5xO+lC7W4XSei3Vjc0s46Hjqu+CqDz3QMgzlEQE1M68EJFH
 qr5bsCV5fpzBMY3XwstBNCVDH2RajhGJGSXDtLWWjSVdQ6GoG0d0GUDm2UUKO7uAmuCU+Y5BxFy
 +qgc1glRZ8Ph6Fe7vwde65hRlg76moD3z/dnVFRfdIUcDIq6gChADh5TDDhCsY=
X-Proofpoint-ORIG-GUID: USU0WP56bUvyG1STNF4IOojq7PXOKWSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-09_05,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 mlxlogscore=670 mlxscore=0
 malwarescore=0 clxscore=1015 spamscore=0 bulkscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603090182
X-JNJ: AAAAAAAB+AiKPPpR9OBljpp+6iYqmhxYoD6m1x/YqquejOaonAHCdpnrIT+wagbFfWeU8TU6Q4PBfq9hkHqe+qsZ7y92Tu7/B9nhAZgiI1t+zGPKN61Qx5TsIGwDSyGzN/PDc7kmhjK6cZifyu6mFzQeHMgcg3K7loCiN2SLcqVKaiJQYqQws3yr4q/HEW7uyzasc8GDl2tuKmuByrK+37IvSkm60L6OQuPd8lhTV4Y1e/uaMz2eccyGwsK5vLChz+9dWHEtMxdx+OUQSTkLYRrkrXNCmcXH6kp/sAVU1wtiepP48HdhHyWZ375jojSd8XSuv/koelQDsrjyCYtn0yUo4jUzyrJU4thBgAaw3yj5xzH3lDdUNqEtXITo89OS5UG/vOocoT829UCmFBNlmFRM+T/gunpbIsgKcciem8yr9KK8x5nDdHCaFt4YTyaYUDIUEHaX8ZUhlihPEp0LgqLSP4MT9n5B2uR8aySOlVxIsvRRfOIm/p/lXCXEqhoAMv4kiajjkaouVwM5TPvxvKbzrAPIdUp/LCz1XYc6gszLgNDjJ1HIwMPdiJW2GUDRvZ5YIjY3xcvhaVGCgFoNbEo9lNBr9Pa8wrfErYvHNnjHN4h0I1C4rXvySoBl7/x2luBgnp/BUuP5zPVFJr9LsFoPe7ywPjzvTpbhnrntpPOBae6+znfVNDByk+9tZ4E2Zb0cbF8zMtZEZMI=
X-Apple-Category-Label: Mjg5MDYwMTc4OiRjYXRlZ29yeSRfUGVyc29uYWws
X-Rspamd-Queue-Id: D7FDA240F54
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[me.com,quarantine];
	R_DKIM_ALLOW(-0.20)[me.com:s=1a1hai];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[me.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,linuxfoundation.org,suse.com,mork.no,me.com];
	TAGGED_FROM(0.00)[bounces-265747-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,me.com:dkim,me.com:mid]
X-Rspamd-Action: no action

The nframes bounds check in cdc_ncm_rx_fixup() validates that the NDP
fits within the skb, but omits ndpoffset from the calculation. This
allows a malicious USB device to place a valid-looking NDP at a large
offset near the end of the skb, where the frame entries extend past the
skb boundary, causing an out-of-bounds read when iterating the NDP
entries.

Fix by including ndpoffset in the size comparison, so the check
correctly verifies that the entire NDP (header + frame entries) starting
at ndpoffset fits within skb->len.

Also use struct_size_t() for the NDP size calculation instead of manual
sizeof() arithmetic, as suggested by review.

Changes since v1:
- Split into two patches with separate Fixes tags for NDP16 and NDP32
- Use struct_size_t() instead of manual sizeof() + count * sizeof()
- Verified fix prevents out-of-bounds read via fuzzer regression test

tobgaertner (2):
  net: usb: cdc_ncm: add ndpoffset to NDP16 nframes bounds check
  net: usb: cdc_ncm: add ndpoffset to NDP32 nframes bounds check

 drivers/net/usb/cdc_ncm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
2.43.0


