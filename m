Return-Path: <netdev+bounces-261012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SKQpFwsUn2nWYwQAu9opvQ
	(envelope-from <netdev+bounces-261012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:23:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA001998BE
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:23:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 85A4530AFD9A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506AA3D5246;
	Wed, 25 Feb 2026 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="2TYCnWDU"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster6-host3-snip4-7.eps.apple.com [57.103.76.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB89828489E
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032514; cv=none; b=noMlEWejpnW+mzQyEKF4cYJtWFUSPmfGNfgh8reYEWC5nyxffLqVOjPbSXeB7dbTkJvYI00kAUb0A1aQyDrSawC2p2QBjC3W/pidM664OfeRxNCtVKGfQKx6xfnE1W0xCF0/gVznt7pudkn/MXyABojqZdKCpJ3ZCojfu6U2db8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032514; c=relaxed/simple;
	bh=ZZ7ix51AfEYIX0Jt+w6zB/ER9ghq5eP5PmN1S+UyLnc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RMAKPuAGUHG60zCtqgXiGl3yAcsr1vnvkcUs4HFmpF4fyTwdTT5C7ebA9vZP592UcKn4uGseoFA13qIKurzJKA2ZERDP1ISAUh0o/Prj5Ui2/ZMbnLAfe6PPX/wbZqFfDT30Y9wdhMHo3OdouR0B4VaQFuuPJ/srb/PQwi2KHUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=2TYCnWDU reason="key not found in DNS"; arc=none smtp.client-ip=57.103.76.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPS id C3D78180016C;
	Wed, 25 Feb 2026 15:15:10 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; t=1772032512; x=1774624512; bh=SN1JpAZST7zZcbBBH7RXi7OwS7WQdyzRqZ6Jk74I9i0=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=2TYCnWDUvGakyX0EkX/fGsxbRUT5Lrx8bCbELGOVsThKlrhRUfDsgfjlSJn8+nGu9TtWJDa2+hBit2NdUHNX8PrqUIPOhmKV7MXNUDqW0D2CXzRpNA3EaoYt/MNAM4A8Y6KYrFWWTLyjGm60DVFx/i8m0cCp61LpB0xEGJQh7flpYgOAIgfTyxr5WuC8ribI0nff82L1yV/dbzigZhJRLN2yEnk/OmFg10k+Lu3NyvNfPsaYhe7ya6kyb2L6BaWwEtui9fGmq3wNpxW1EOOiJPqatdodTcQPK2Qtb4r5z49GfmsqPS4Wc27lDsOGA9GRXoc6GwNtW5ymQy9T6z+n8A==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-12 (Postfix) with ESMTPSA id D6BB81800214;
	Wed, 25 Feb 2026 15:15:07 +0000 (UTC)
From: Yohei Kojima <yk@y-koj.net>
To: Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: Yohei Kojima <yk@y-koj.net>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3] docs: ethtool: clarify the bit-by-bit bitset format description
Date: Thu, 26 Feb 2026 00:12:09 +0900
Message-ID: <ef90a56965ca66e57aa177929ce3e10c5ca815fa.1772031974.git.yk@y-koj.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI1MDE0NiBTYWx0ZWRfX1VNyKWyrL6HS
 d9Ryq47JyulJ13KPXNcH2IeV2kfHG9qgIFfV7ef2DXBuJO39R+uFm/eboN4GUy9HXEGU9hb1pER
 mUJBZOURdSdMWxZ6PijI1PLsfAhicJT09TrDejRRFae7b3OutMHKrhaB+0D378aTO6LtEV1oU5k
 UGYXdra4GFugOB7/JEX3oyEmfo1afz/nmpnOn+pNARTCE8jUeG6L9S/PK3DwatrEoUkfNaNZwLX
 4AzBwClcKzBDGMpgE5udHvtlXRxjYmH3PFqFfzYfy4sLNeB+4p18DbN2ltw98RJRymeGy6y0Wxq
 mJE5IX+RiiPO1ffFdoSxn1sr/BLK1FzDQAT0SMCQR4hJHYrrgcAifh28B54BlM=
X-Authority-Info-Out: v=2.4 cv=BcfVE7t2 c=1 sm=1 tr=0 ts=699f11ff
 cx=c_apl:c_apl_out:c_pps a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22 a=VwQbUJbxAAAA:8
 a=jnl5ZKOAAAAA:8 a=8WQVRTqVWvD3vaqRZeAA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-ORIG-GUID: K6e5Zvfi3hVp0fk10h1dDgdg-5bvmlOg
X-Proofpoint-GUID: K6e5Zvfi3hVp0fk10h1dDgdg-5bvmlOg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-25_01,2026-02-25_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 malwarescore=0 adultscore=0 suspectscore=0 mlxlogscore=999 lowpriorityscore=0
 phishscore=0 mlxscore=0 spamscore=0 clxscore=1030 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602250146
X-JNJ: AAAAAAAB8l25vLSFFMxQeBFCwhCHSSa78ZEjmitzaxLHv2ZaC6TZzGpgB+7wr0Qs5ooVYoDL9xLfB95umgtVx3oqZvgXrQQvn+q5tWlRYPu5blV1EOLZGX1HslMDWBhwGS/8ZMfqK4RIuxkHAECGe7ZT3HCTtzYe/5E/gpd5SHaZVLXDXjtSGfFtnx6d9Zq2A69bOj3Fc8z01ZfNACOA4Ooeax961eT2TzBhAFuf33HQsGVCFG+LZz3c/SVpEuoCVQ4OMQosulx0wwdyW9gs9O9+tzkccGxakHomqca5V+M5+rO87UExLStykmwyZl7Xt8HBQnL3Lni2DSG1+f/9VrLn3dShXQ2kxNNuUYqgjw/mR5LaCFaOWUenMZ5YeviTQNBLlE46OR1MJMDYcPFg8qlHwjnt+G1c4WCCe5bo1pPvdbhmw5eSLiGFiPOsqA2KLEeUb/14H7AFFyRtH4Ivx/B5qF6irLMXOoYYGOnOAhXncj/RzhZfG+UdUJLG05RUu8ivYvyiIO+HpmKvjpFwnfNdHLQoWcXBMRGl44RZLB8DS0HewgXRh6lI5nETJbqWD2w1bWSwDDEM9rGzg5fHtTXVpxNFAvEG3zO53wQ2nDKERRKnKp8tDDjL+mO4Wbs38vUJFC2+kHy0mEC/Zls7zKi0IDzG6cDhmp4tm8PD4ARJ03GLi/Ro8qdl7+vOdqDb7ePEePZifbi+GkgBukhx9dJHNkuU7JbAh4c088dtNw/wSeflUns7ubylhgQtVpws/rVulJSYCGUcSi8BA7+vRHNNnY7tRzGAYLQ1AxuSrKZsJS7LZYk=
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[y-koj.net:~];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-261012-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[y-koj.net];
	R_DKIM_PERMFAIL(0.00)[y-koj.net:s=sig1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yk@y-koj.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.774];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,y-koj.net:mid,y-koj.net:email]
X-Rspamd-Queue-Id: 8DA001998BE
X-Rspamd-Action: no action

Clarify the bit-by-bit bitset format's behavior around mandatory
attributes and bit identification. More specifically, the following
changes are made:

* Rephrase a misleading sentence which implies name and index are
  mutually exclusive
* Describe that ETHTOOL_A_BITSET_BITS nest is mandatory
* Describe that a request fails if inconsistent identifiers are given

Signed-off-by: Yohei Kojima <yk@y-koj.net>
Reviewed-by: Jakub Kicinski <kuba@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Current ethtool-netlink documentation doesn't describe several behaviors
around bit-by-bit bitset, which makes it hard to develop a ethtool
library without digging into the kernel code. This patch eases the gap
between the kernel behavior and the documentation by adding descriptions
around the mandatory attribute and bit identification.

ChangeLog
=========
v3 (this version):
* Rebase to the latest net-next/main
* Add Reviewed-by tag provided by Jakub and Simon. Thank you!
v2: https://lore.kernel.org/netdev/f43999612ed9d17fb7fe8f21e777e1c784f23c46.1770457868.git.yk@y-koj.net/
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


