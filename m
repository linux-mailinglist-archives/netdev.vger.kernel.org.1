Return-Path: <netdev+bounces-255903-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kOGzOYXBgGl3AgMAu9opvQ
	(envelope-from <netdev+bounces-255903-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:23:49 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68182CE261
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 16:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 86A183029ADA
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 15:18:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19A1A36B07F;
	Mon,  2 Feb 2026 15:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="RULgRksi"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.ms.icloud.com (p-west3-cluster6-host8-snip4-3.eps.apple.com [57.103.75.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B10376BD0
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 15:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.75.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770045516; cv=none; b=fv69Ax5qTpwbC85sjDJMNJ7vBQQhNsV8QgmICeNpIs6GmCa2/sDk/nYAzD/d1bX2aNZp1ILiHn8UBHnAUGA6mwlDVh/9SuB9BIIRsDF1oB7D29IsXJ/Eu9eHCgK8+cmTEMaQVdCao2afFG/oksZZmcNpmNI9Ntb5mjFAzFqt5tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770045516; c=relaxed/simple;
	bh=qnPBRg7FWAUGaMjpD3aSpGilx63FWH9xhtNIZLPRvmU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZePLdFsjPIlj9KiogWU5FL9H8ymqbm+zWOidE+iRyrD2sSCweuZIw71qs6Nldy6sE+gkV6zR/0vjK/vBC1jx9yOJIcr4W34XMweF/fDbs6wVcYz0mx7Ats50XlzphDAiEHhelwEhLpEFOs+HxewsgJvJsUpzK+y54KvpMJuLN1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=RULgRksi reason="key not found in DNS"; arc=none smtp.client-ip=57.103.75.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-3 (Postfix) with ESMTPS id 80EFA18001DE;
	Mon,  2 Feb 2026 15:18:31 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; t=1770045514; x=1772637514; bh=86URY0R3OWFSx2Fa+dwHF/mkgOf10kvIJA3+jyD+2yg=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=RULgRksiOqAttMOuRup3Z4MLUGg/fgKF48XXGB369P2C94ZpnadpOSM2fLIXHvwtz4q2eRL2IvV5O6RO2hhKK5MfWh3wKF0TrAduOvpFwkteCiagC7AGYOccmVI7+OHLuvQrkt+VJwS0toh1Yzp6X97z+9SDSiHxkD81TSiJiposrCGUiLWNA3N1BxjOs3A9n9YB4fuGxRr4rIHolXR3e4kG7Yqfk0fX8AnZ2d0A1mLNfA/h1fbfQMXw9HRzHriQE4z1taaS95Dk8x+OGW6aVq1uvOKLARVaIM/5AxHWbxYpPpJ1pooOwtnpF80pFtaZfx/torgVCNZueqRF+J3EUw==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.57.154.37])
	by p00-icloudmta-asmtp-us-west-3a-60-percent-3 (Postfix) with ESMTPSA id AF6E618001C5;
	Mon,  2 Feb 2026 15:18:26 +0000 (UTC)
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
Subject: [PATCH net-next] docs: ethtool: clarify the bit-by-bit bitset format description
Date: Tue,  3 Feb 2026 00:17:19 +0900
Message-ID: <e9ea0fe8bf7935d6439e4dc883414b685afbaf58.1770045398.git.yk@y-koj.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAyMDEyMSBTYWx0ZWRfXwwi1FkKIODPm
 YQJoXNRo1d94rfWWM5bX67vmcEYAdMV/TDRioAcKh/Gl5KrwaN2Zn1Ag6Z+oLta3K/z8doTf4vA
 5RvZDOPe1zQIoaqy5naFS2UFttBQ97sv0ic+bgH8LwFeOv+f0nWLTz19vjr5tlrLqczGdVt9PiU
 S1/vQ83n0LvuJ33y1pCEpq6RCYAPycRRJpZN5AvpW/1VDpz/uPsNjTp6H1TVCaro/KTcFpMSfGH
 qp0jVS90TRKrRSw6qaaUWZ0kCH9Jt5gSDyHX1BT+4E1t9jmXrDGklrDVxcQrBlpwMLD108ERqUX
 JknZ3FLhxeYVla7VWIA3XFpbwtLb7K7LKCLNLtJII0+3+WSxjcJWpxllCHHcm4=
X-Proofpoint-GUID: AHt_TwtUlF6C5Ha09unb-ZnJq36hs8F2
X-Authority-Info-Out: v=2.4 cv=BcrVE7t2 c=1 sm=1 tr=0 ts=6980c048
 cx=c_apl:c_apl_out:c_pps a=qkKslKyYc0ctBTeLUVfTFg==:117 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jnl5ZKOAAAAA:8 a=hY83FSAyczh_wuX0RbwA:9
 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-ORIG-GUID: AHt_TwtUlF6C5Ha09unb-ZnJq36hs8F2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-02_04,2026-01-30_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 clxscore=1030 mlxlogscore=999 lowpriorityscore=0 bulkscore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 malwarescore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602020121
X-JNJ: AAAAAAABhHzFeiUT9L0dTIBkseIX36xI7QHD+2ifPOsmHfw4AZo/RMWB+nWubnIbNGZlXzKDblVLe8NMaJS2h2bB2soNGaWIkdSCg4jlJNdeSNEV2doL5oM6iJfOmVB7u3n7xEQrUgwaKdOPS9wTOgiek6qQLTjt/WZGirLkWiC8EDRZrka6WLOaYiSpDfgZd5fUYKdc5naRhSBe0+A5wRy4Bzpa/+4UKMb7H9Q2guMcgMCUZ34xmzqZgxKqQoVlUbrXTWz7vMc/DHpn7n+UP0NFrX+GtEb97aFbo/yDhoQLjwGo7BBfxEegSkTfjK//hOFrc7snoA5W/CZ60WHDW1zTB8qJhdhHpXJby7GC7NFxMYXG0b7C0KzGRR7aUc2eEGOUIwqekqwNRRHk6meZLZaziV4Va9OP4t0SZU9Juf7T8yHCdx8ltpTQQOtGbyYablLz4onS6iaFQ5hITPPyWOJHa87INPw/OXQLP86VSEAYPjNXbtYTlm5tLPXa6TpdyFeFUtohlCCkoX7dj5PmLosa/krbsj72KSVWKyQ7y985D6Q/Xd2XKDW9fqB4bvQvFeBrMv/njdylmsyhBrN9/advLdkz5mses+scVEPOUFqkdA+yigI497BY5rROY3q+T8j/AyNzfV9B45E/Ju7UUgrEi5cvz60ybvCoSq2+6DJyUL8mDfGzdr90jf+m1VLcAO5NPY4FdYZGo26wWUsmcKsc3c1FbfyCWOKf78v6kW3tgHvfio5HpZF9575IDze9zjRirESoTXj6eDCgVdWr1mc+VnVdHJixtcY8hXFa/Q==
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[y-koj.net:~];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-255903-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[y-koj.net];
	R_DKIM_PERMFAIL(0.00)[y-koj.net:s=sig1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yk@y-koj.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,y-koj.net:mid,y-koj.net:email]
X-Rspamd-Queue-Id: 68182CE261
X-Rspamd-Action: no action

Clarify the format and semantics of the bit-by-bit bitset by the
following changes:
* Explicitly describe the mandatory and optional fields in one paragraph
* Detail what happens if ETHTOOL_A_BITSET_NOMASK is set
* Clarify that users can set both BIT_INDEX and BIT_NAME fields

Signed-off-by: Yohei Kojima <yk@y-koj.net>
---
 Documentation/networking/ethtool-netlink.rst | 31 ++++++++++++--------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/Documentation/networking/ethtool-netlink.rst b/Documentation/networking/ethtool-netlink.rst
index af56c304cef4..e20f8b541a5b 100644
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
@@ -156,17 +156,24 @@ Bit-by-bit form: nested (bitset) attribute contents:
  | | | ``ETHTOOL_A_BITSET_BIT_VALUE`` | flag   | present if bit is set       |
  +-+-+--------------------------------+--------+-----------------------------+
 
-Bit size is optional for bit-by-bit form. ``ETHTOOL_A_BITSET_BITS`` nest can
-only contain ``ETHTOOL_A_BITSET_BITS_BIT`` attributes but there can be an
-arbitrary number of them.  A bit may be identified by its index or by its
-name. When used in requests, listed bits are set to 0 or 1 according to
-``ETHTOOL_A_BITSET_BIT_VALUE``, the rest is preserved. A request fails if
-index exceeds kernel bit length or if name is not recognized.
-
-When ``ETHTOOL_A_BITSET_NOMASK`` flag is present, bitset is interpreted as
-a simple bitmap. ``ETHTOOL_A_BITSET_BIT_VALUE`` attributes are not used in
-such case. Such bitset represents a bitmap with listed bits set and the rest
-zero.
+For bit-by-bit form, ``ETHTOOL_A_BITSET_BITS`` attribute is mandatory, and
+``ETHTOOL_A_BITSET_SIZE`` is optional. ``ETHTOOL_A_BITSET_BITS`` contains
+zero or more ``ETHTOOL_A_BITSET_BITS_BIT``, which must contain
+``ETHTOOL_A_BITSET_BIT_INDEX`` and/or ``ETHTOOL_A_BITSET_BIT_NAME``.
+``ETHTOOL_A_BITSET_BIT_VALUE`` is optional, and ignored if
+``ETHTOOL_A_BITSET_NOMASK`` is present.
+
+``ETHTOOL_A_BITSET_NOMASK`` specifies the semantics of the bitset. If
+``ETHTOOL_A_BITSET_NOMASK`` is present, the bitset represents a list of the
+enabled bits (e.g. all bits are unset if ``ETHTOOL_A_BITSET_BITS`` is empty).
+On the other hand, if ``ETHTOOL_A_BITSET_NOMASK`` is not present, the bitset
+represents a list of the masked (valid) bits, and
+``ETHTOOL_A_BITSET_BIT_VALUE`` is present iff the bit is set.
+
+``ETHTOOL_A_BITSET_BIT_INDEX`` and ``ETHTOOL_A_BITSET_BIT_NAME`` identify
+the bit in the bitset. If both are set, the index and the name must point
+to the same bit. A request fails if the index exceeds kernel bit length or
+the name is not recognized.
 
 In requests, application can use either form. Form used by kernel in reply is
 determined by ``ETHTOOL_FLAG_COMPACT_BITSETS`` flag in flags field of request
-- 
2.52.0


