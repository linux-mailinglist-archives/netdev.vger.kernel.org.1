Return-Path: <netdev+bounces-276155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGsHNnNm1Wm05gcAu9opvQ
	(envelope-from <netdev+bounces-276155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 22:17:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4539A3B472B
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 22:17:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C1CD33032F55
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 20:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4C012BDC1C;
	Tue,  7 Apr 2026 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aY9cyvS+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095E126C17;
	Tue,  7 Apr 2026 20:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775593072; cv=none; b=ipAIsUaXo3vhedK3dEY+lx01pOb17OHAml/rnuDFsjpfb8tJFqtW2nq/5vhYily7L3tT8o8Fe9rQS40z6rTtGTBWbPiAtp4gFqaRkSKS9JAxew56j7r8SFtiA5bvlF26Gzcyrxk0i4e/vdFjT8uPpo6u79KRtGK2DO75EFmUPEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775593072; c=relaxed/simple;
	bh=YIlxGwPr5hMd/xYC92n77YTEg4ZxfpXED5MmFXnriGA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HXMrYSVnnHboqpsWDYiIwXCs2aDSHysxc/DT6IkxX5d5BZK/7ikCXFDcvC7QjGUzBomfrkxvjKTjn1KCTx3WgvDmCdYf+qy951oPCpS4rO8i/w8ziKpDS3b9B8Td4nfSG3ez8/WBi5SWgToCyRjoP/9Wh36DqYbJXuT5XOdDF5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aY9cyvS+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB22EC116C6;
	Tue,  7 Apr 2026 20:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775593072;
	bh=YIlxGwPr5hMd/xYC92n77YTEg4ZxfpXED5MmFXnriGA=;
	h=Date:From:To:Cc:Subject:From;
	b=aY9cyvS+NuBlEel2iN4VnPeSPAGTXC+fYIzUx6/hoADqBAt44qPcm9V3DEGneNHiE
	 ogXvOct3xQADoFP3ZJI1Kz2YtK4RvlToAvMIoqfZSGOBSgQY4aGgxdgjm5y2o9wtoT
	 gJ/o9SS3rh0alX/xWYAavFiyXMgmvWgImytTCWxq5QYn1R/DO9vc3qveo84hAoEde5
	 wwtu02RkrSpM7KDwMbExhM5OJIaWL9k8Xfzi8bteqp36Wn3fcDQXjz696KvxtKKhbB
	 5AHSh33vk2rs7SDSQCGyfxSq7OPn1d8ZEua744e3ibVNUD64GAzBcH6MqT3ni7k+Ag
	 2ik7meiMmb57g==
Date: Tue, 7 Apr 2026 14:16:46 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Marcel Holtmann <marcel@holtmann.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org
Subject: [PATCH RESEND][next] Bluetooth: hci.h: Avoid a couple
 -Wflex-array-member-not-at-end warnings
Message-ID: <adVmLsJCQrBCMDD6@kspp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276155-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[holtmann.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gustavoars@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4539A3B472B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

struct hci_std_codecs and struct hci_std_codecs_v2 are flexible
structures, this is structures that contain a flexible-array member
(__u8 codec[]; and struct hci_std_codec_v2 codec[];, correspondingly.)

Since struct hci_rp_read_local_supported_codecs and struct
hci_rp_read_local_supported_codecs_v2 are defined by hardware, we
create the new struct hci_std_codecs_hdr and struct hci_std_codecs_v2_hdr
types, and use them to replace the object types causing trouble in
struct hci_rp_read_local_supported_codecs and struct
hci_rp_read_local_supported_codecs_v2, namely struct hci_std_codecs
std_codecs; and struct hci_std_codecs_v2_hdr std_codecs;.

Also, once -fms-extensions is enabled, we can use transparent struct
members in both struct hci_std_codecs and struct hci_std_codecs_v2_hdr.

Notice that the newly created types does not contain the flex-array
member `codec`, which is the object causing the -Wfamnae warnings.

After these changes, the size of struct hci_rp_read_local_supported_codecs
and struct hci_rp_read_local_supported_codecs_v2, along with their
member's offsets remain the same, hence the memory layouts don't
change:

Before changes:
struct hci_rp_read_local_supported_codecs {
        __u8                       status;               /*     0     1 */
        struct hci_std_codecs      std_codecs;           /*     1     1 */
        struct hci_vnd_codecs      vnd_codecs;           /*     2     1 */

        /* size: 3, cachelines: 1, members: 3 */
        /* last cacheline: 3 bytes */
} __attribute__((__packed__));

struct hci_rp_read_local_supported_codecs_v2 {
        __u8                       status;               /*     0     1 */
        struct hci_std_codecs_v2   std_codecs;           /*     1     1 */
        struct hci_vnd_codecs_v2   vendor_codecs;        /*     2     1 */

        /* size: 3, cachelines: 1, members: 3 */
        /* last cacheline: 3 bytes */
} __attribute__((__packed__));

After changes:
struct hci_rp_read_local_supported_codecs {
	__u8                       status;               /*     0     1 */
	struct hci_std_codecs_hdr  std_codecs;           /*     1     1 */
	struct hci_vnd_codecs      vnd_codecs;           /*     2     1 */

	/* size: 3, cachelines: 1, members: 3 */
	/* last cacheline: 3 bytes */
} __attribute__((__packed__));

struct hci_rp_read_local_supported_codecs_v2 {
	__u8                       status;               /*     0     1 */
	struct hci_std_codecs_v2_hdr std_codecs;         /*     1     1 */
	struct hci_vnd_codecs_v2   vendor_codecs;        /*     2     1 */

	/* size: 3, cachelines: 1, members: 3 */
	/* last cacheline: 3 bytes */
} __attribute__((__packed__));

With these changes fix the following warnings:

include/net/bluetooth/hci.h:1490:31: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/net/bluetooth/hci.h:1525:34: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/net/bluetooth/hci.h | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 89ad9470fa71..572b1c620c5d 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -1468,8 +1468,12 @@ struct hci_rp_read_data_block_size {
 } __packed;
 
 #define HCI_OP_READ_LOCAL_CODECS	0x100b
-struct hci_std_codecs {
+struct hci_std_codecs_hdr {
 	__u8	num;
+} __packed;
+
+struct hci_std_codecs {
+	struct hci_std_codecs_hdr;
 	__u8	codec[];
 } __packed;
 
@@ -1487,7 +1491,7 @@ struct hci_vnd_codecs {
 
 struct hci_rp_read_local_supported_codecs {
 	__u8	status;
-	struct hci_std_codecs std_codecs;
+	struct hci_std_codecs_hdr std_codecs;
 	struct hci_vnd_codecs vnd_codecs;
 } __packed;
 
@@ -1504,8 +1508,12 @@ struct hci_std_codec_v2 {
 	__u8	transport;
 } __packed;
 
-struct hci_std_codecs_v2 {
+struct hci_std_codecs_v2_hdr {
 	__u8	num;
+} __packed;
+
+struct hci_std_codecs_v2 {
+	struct hci_std_codecs_v2_hdr;
 	struct hci_std_codec_v2 codec[];
 } __packed;
 
@@ -1522,7 +1530,7 @@ struct hci_vnd_codecs_v2 {
 
 struct hci_rp_read_local_supported_codecs_v2 {
 	__u8	status;
-	struct hci_std_codecs_v2 std_codecs;
+	struct hci_std_codecs_v2_hdr std_codecs;
 	struct hci_vnd_codecs_v2 vendor_codecs;
 } __packed;
 
-- 
2.43.0


