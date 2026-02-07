Return-Path: <netdev+bounces-257753-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGEUIm4Th2nBTQQAu9opvQ
	(envelope-from <netdev+bounces-257753-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 11:26:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D49131057B5
	for <lists+netdev@lfdr.de>; Sat, 07 Feb 2026 11:26:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8BBB13019915
	for <lists+netdev@lfdr.de>; Sat,  7 Feb 2026 10:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6601332902;
	Sat,  7 Feb 2026 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="ilP49gaW"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster2-host7-snip4-10.eps.apple.com [57.103.78.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98464311596
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.78.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770460011; cv=none; b=M6ws71KHfmjnDQTgqLu+KbqXuZ9klCD4oojYTLeXtL/YGOqahkQGc18alUxO2ak0k6xURzWN/t7ipPtXzOlMBN3Y5gj1Xv3QKYcin+2yJDJPBcYZJbhKyiPLtEs+a3KEANd+TK0okcIv/Lr/bv25kT3WgK9Kzb4PA5yXiIyEc3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770460011; c=relaxed/simple;
	bh=SYReqYzN9g7HyjPHt5FNWTeMblt8T2P8zOvkbF3FP1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IM+8InzSItpi1ErG6ik8uGfUvK48FQblYG12LZWeqHjYkSIm+4zouSsvBuyUYLYuDmsU2EaiXHXNKhrk+9U5/4DWjJ2KIBSUpTXwqp8n221/hGTul+aAe0yyxxXIx/1TtIcViSM/ctAUow8FOH+TeQern3WPCJe/MR/kiddcNCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=ilP49gaW reason="key not found in DNS"; arc=none smtp.client-ip=57.103.78.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPS id 18C29180021A;
	Sat,  7 Feb 2026 10:26:43 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; t=1770460010; x=1773052010; bh=cQGHVERe2JrIHTNqkTzWQuO6ddheMIUb3WX/j0qEZ1U=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=ilP49gaWzaDOtRQgLipgJu5LQTCO2+wv3z+F87CNewe+j6JIf04xDDWvJp5yZd6gyWvDAh2tzSKn4hpomYSjtaZCSbAexe724/XFOgTWSWn1VbZOpaOUPztWjuiBjOGrGefUlzxXWfWDN1XfsgNlrS+4HlrlurL7+U4g4PpP1237OPoxDqcfFTX7Kg1rEboaFXbyqukMe6+UktnbIuLaiNOW+Y/qplPtuPskn6ijkAODci86P2EGrkmQgg26XDSJCSLVq88eDIZHm//X9K+PR/jqdwIY8lAPwQcLDHfcPt6gNj/YYMAwR95vCI6TknwDHIXMZbqflM2W+BvHpr+WiA==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-10-percent-2 (Postfix) with ESMTPSA id 33C251800181;
	Sat,  7 Feb 2026 10:26:41 +0000 (UTC)
From: Yohei Kojima <yk@y-koj.net>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>
Cc: Yohei Kojima <yk@y-koj.net>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2] docs: ethtool: clarify the bit-by-bit bitset format description
Date: Sat,  7 Feb 2026 19:25:38 +0900
Message-ID: <f43999612ed9d17fb7fe8f21e777e1c784f23c46.1770457868.git.yk@y-koj.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Mqbar9JL4VbLz1s7dUakO2EX_9hbXxmY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA3MDA4MyBTYWx0ZWRfXy+ZYrwEUqa+O
 CZuwiQ2Gim5h5pPN9Cux4OY4lBWGeXLFP+G+P8Fw3shOPWoKzdMwQT0FiUgZ6TlKFF+X1a0YZb9
 0T8R3VphdcoYWR6lgYtht7o7DtknhXE8EpyLx3Z/AvQ3a9fXhoAChxVbcJHeMkLX6RLZPbmoyzL
 GVxvJgl4e18bsLbJFPez4O5tAJqFZu9+LsOWH5hOfEp0bisKNslAIBBn1OwUtUHk9sHfS0O+SE4
 Kae4EnGu++oYufVPihpdKHPFTkQNp2rHJx83EMFhOgDDPWrTS5Urtpt+x9fhVW9R/eltpmu4jIv
 1MUxfy88MJ2T/mQHuj5kNQJWigZgtF70e3kWOajjEkOIBbDtILd5PcX+plLOVk=
X-Authority-Info-Out: v=2.4 cv=V8ZwEOni c=1 sm=1 tr=0 ts=69871368
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=jnl5ZKOAAAAA:8 a=8WQVRTqVWvD3vaqRZeAA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-GUID: Mqbar9JL4VbLz1s7dUakO2EX_9hbXxmY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 adultscore=0 clxscore=1030 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602070083
X-JNJ: AAAAAAABGHk5IeaOfqEE4TOa8Bgt2yzos2vaKW59OL1bb4lWodT7wLi7lvIhEUH7mtchNN6HsNm2W8UjWeyz8KhRc8ITtRb+66/oau7def/gDBkFklDQawQRClwTPg/lwdY82ZCWqe3N3PHGJ6vK3lzlYo1C2vTHkIaLEBQJ+3R4icdymwFFeuucox7T14B3fo7rl1wPnpHJybiW0KrndeERVdhKyIpBEqqnv3U9jR7WCjL0oya3okBMpb9Ga/xS3jm1mbGCGExW6BvPZ6K+g1EprZq5+YMQTyz11sAlqV9cCUYGoawF140vAU/G1xGJygXtqAQCqLLMfhNORP/KbV9oN2cFO8cfzHlCIdCL9VBQYiJnIgEcxeKF3Ot+kpBrXnjOQqTLlNzLeqkkm6luyEj7prpUsELyYwkxFwNXd1lvOQutq+FPsuCVdNQAmzoy1TanM0zMmkic4q9s58DGWmeEcIp4/Op6yvBuEdU43szJTCOUkiKwSR/1jdkSvI+sFiQQx4lXeaMgJT0bm70J7SjaC4ZR6sby2TV0H9Ury9iTl/ANuGP+Driy+ot8w+ZB80W7YOzsMdoIGjlUgHnXHhbrbfL/c/p5ul7u5v9U++LA4o/wHoOwwouY39aGvwcWJqkg9ue9pTkslQdRxnSZwSvwvfpd6cV2SgGAMSLtu0BJslEox9nSIYTYdUE05FtfBFVplFNt2ynY32nmUVSRJ5SDfa9B/Q2Qux7FyFQ5Ef1D5mLuj4jLzReT4UanXbLu/aDjnS0gf4P9reVl+4V/uihlkEnCR3b5R4iK4pJAmbMtxO21Z8s/H3Ye8gOYr8ZK
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257753-lists,netdev=lfdr.de];
	DMARC_NA(0.00)[y-koj.net];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_PERMFAIL(0.00)[y-koj.net:s=sig1];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[yk@y-koj.net,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[y-koj.net:~];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.962];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: D49131057B5
X-Rspamd-Action: no action

Clarify the bit-by-bit bitset format's behavior around mandatory
attributes and bit identification. More specifically, the following
changes are made:

* Rephrase a misleading sentence which implies name and index are
  mutually exclusive
* Describe that ETHTOOL_A_BITSET_BITS nest is mandatory
* Describe that a request fails if inconsistent identifiers are given

Signed-off-by: Yohei Kojima <yk@y-koj.net>
---
Current ethtool-netlink documentation doesn't describe several behavior
around bit-by-bit bitset, which makes it hard to develop a ethtool
library without digging into the kernel code. This patch eases the gap
between the kernel behavior and the documentation by adding descriptions
around the mandatory attribute and bit identification.

ChangeLog
=========
v2 (this version):
* Minimize the diff for ease of review
v1: https://lore.kernel.org/lkml/e9ea0fe8bf7935d6439e4dc883414b685afbaf58.1770045398.git.yk@y-koj.net/

---
 Documentation/networking/ethtool-netlink.rst | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index af56c304cef4..32179168eb73 100644
--- a/Documentation/networking/ethtool-netlink.rst
+++ b/Documentation/networking/ethtool-netlink.rst
@@ -96,7 +96,7 @@ For short bitmaps of (reasonably) fixed length, standard ``NLA_BITFIELD32``
 type is used. For arbitrary length bitmaps, ethtool netlink uses a nested
 attribute with contents of one of two forms: compact (two binary bitmaps
 representing bit values and mask of affected bits) and bit-by-bit (list of
-bits identified by either index or name).
+bits identified by index or name).
 
 Verbose (bit-by-bit) bitsets allow sending symbolic names for bits together
 with their values which saves a round trip (when the bitset is passed in a
@@ -156,12 +156,16 @@ Bit-by-bit form: nested (bitset) attribute contents:
  | | | ``ETHTOOL_A_BITSET_BIT_VALUE`` | flag   | present if bit is set       |
  +-+-+--------------------------------+--------+-----------------------------+
 
-Bit size is optional for bit-by-bit form. ``ETHTOOL_A_BITSET_BITS`` nest can
+For bit-by-bit form, ``ETHTOOL_A_BITSET_SIZE`` is optional, and
+``ETHTOOL_A_BITSET_BITS`` is mandatory. ``ETHTOOL_A_BITSET_BITS`` nest can
 only contain ``ETHTOOL_A_BITSET_BITS_BIT`` attributes but there can be an
 arbitrary number of them.  A bit may be identified by its index or by its
 name. When used in requests, listed bits are set to 0 or 1 according to
-``ETHTOOL_A_BITSET_BIT_VALUE``, the rest is preserved. A request fails if
-index exceeds kernel bit length or if name is not recognized.
+``ETHTOOL_A_BITSET_BIT_VALUE``, the rest is preserved.
+
+A request fails if index exceeds kernel bit length or if name is not
+recognized. If both name and index are set, the request will fail if they
+point to different bits.
 
 When ``ETHTOOL_A_BITSET_NOMASK`` flag is present, bitset is interpreted as
 a simple bitmap. ``ETHTOOL_A_BITSET_BIT_VALUE`` attributes are not used in
-- 
2.52.0


