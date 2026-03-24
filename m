Return-Path: <netdev+bounces-271197-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2IB+HmHKwmmqmAQAu9opvQ
	(envelope-from <netdev+bounces-271197-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:31:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7756231A09F
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:31:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8B0113003728
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D793B3CCFCD;
	Tue, 24 Mar 2026 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="wz8zEDU2"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster5-host4-snip4-2.eps.apple.com [57.103.79.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7939D6DE
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 17:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774372905; cv=none; b=gqei8cyJ1ITu3LTcG5VHXvqvEiQ/Ua3MGTVMB1glfkZ6cSOLIcB+JKv3W5vlyd+uMc55IwI62EMW6kPz3Qkp9IJhiCLwuuHg14fzvQP4W8EvjZgPMNhDxadMT8T3zV97zKRdrgHBxVWtWTPRxLjqEjLsdt+Y7euYI9/CzFvFI/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774372905; c=relaxed/simple;
	bh=n11RC5xGi3Eqqo8dni8B5p/CecU+PWfIEHqbFXPy3/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U2AQGhwIsB088Sj7vmO6qq3jMB5iIim3cGWFt+zSqheVVSpGPRyjB+gd3MhQBCc/u5P4ai5Ta3KFXP8Jl1ZHZQZiWWIkiM/4fhF5L0sHau0VcDq5G/X/1scW9HRUDHJb6Axl1QGhy2AvbOg2y/yIIWNwaMtK3E9lxpsm9VB3Qjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=wz8zEDU2 reason="key not found in DNS"; arc=none smtp.client-ip=57.103.79.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPS id 702911800412;
	Tue, 24 Mar 2026 17:21:42 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; t=1774372903; x=1776964903; bh=5N248yRNZbk4OwemYeCBCc74/Z2S56l/BlKY0cPI2Tg=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=wz8zEDU2fFYtScOtlrmh8rGde5twb/SkPI/qEVrk4ERZqip3APHtT1xiNoprPrQlsmCbhu9D44+bnEmOYLKcQWub8rcryA6XdxIoNIou+kMRRA3rYyWMrmmc82oH1yQ4bNwo/NVCH9utajNjOoGvlc75jq/nkb2a+GN5aISYmSQAl9m78AvELqm/Q4YXSwwkpY0TyW1VrHjusSqV65ryW1qPBQ8WyWN9417zFj4mX0FmXKpK0A9Fpfg7E05UsoSMx49WodFOxXpN46n9AvXoHKycsmaybdhPAPJO6mr21sDSNvkUlObVSGbSGWTclMWfByNYQgEa7h3TvfdqAaR95w==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-100-percent-7 (Postfix) with ESMTPSA id 11A521800419;
	Tue, 24 Mar 2026 17:21:39 +0000 (UTC)
From: Yohei Kojima <yk@y-koj.net>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Yohei Kojima <yk@y-koj.net>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] selftests: net: Remove unnecessary backslashes in fq_band_pktlimit.sh
Date: Wed, 25 Mar 2026 02:20:28 +0900
Message-ID: <dd0bbd48cdf468da56ec34fd61cecd4d2111d7ba.1774372510.git.yk@y-koj.net>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: UJEfL8xXweIli2HRHjaa8-TdZMvOyd4U
X-Authority-Info-Out: v=2.4 cv=PPsCOPqC c=1 sm=1 tr=0 ts=69c2c827
 cx=c_apl:c_pps:t_out a=YrL12D//S6tul8v/L+6tKg==:117
 a=YrL12D//S6tul8v/L+6tKg==:17 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=mDV3o1hIAAAA:8 a=jnl5ZKOAAAAA:8 a=88Xg6KwLHtp4lb6h7asA:9
 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-ORIG-GUID: UJEfL8xXweIli2HRHjaa8-TdZMvOyd4U
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDEzNSBTYWx0ZWRfX8Le6WKJ6hgVH
 /qsXePC6Z532bflkQcmaK7WY5ZZrbUxsT4MVt8SLf9MwN+iivV5q4n59FgPEubBgPg0WaKK5dj/
 sGX1RY5Lo7WUcYoSXDQ5UqXOrfqR/AzHsep+hkbONzokuZBIilz2ozrqm4D869zEHs4rIIgb+Yh
 AgLEyk3K7Ri6HJbNqX2ITEboLV+Nvid6KHontDr32zKzm8dx75LaG5gbkr12lP3fMOcVf1X5R58
 FxaMv+eiRG6agtCFJhAyWb1IodXytGSr34Q4tmyC2nfBZcaIWbgYg97D1x8f1zlyoUUkEjfg86W
 REpFpmctZ0laHsm7VZMiTmUVdP2nG2j8ZXleEundHi3Zzewq6thyd458Y4yYtA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 clxscore=1030 phishscore=0 classifier=spam
 authscore=0 adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2603240135
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[y-koj.net:~];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-271197-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[y-koj.net];
	R_DKIM_PERMFAIL(0.00)[y-koj.net:s=sig1];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yk@y-koj.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7756231A09F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Address "grep: warning: stray \ before white space" warning from GNU
grep 3.12. This warns the misplaced backslashes before whitespaces
(e.g. \\' ' or '\ ') which leads to unspecified behavior [1].

We can just remove the backslashes before whitespaces as POSIX says:

  Enclosing characters in single-quotes ('') shall preserve the literal
  value of each character within the single-quotes.

and bourne-compatible shells behave so.

[1]: https://lists.gnu.org/r/bug-gnulib/2022-05/msg00057.html

Signed-off-by: Yohei Kojima <yk@y-koj.net>
---
I tested the patch with bash 5.3.9. I couldn't test it with dash because
the test depends on a bash extension with "if [[ $# -eq 0 ]]".

Thanks,
Yohei
---
 tools/testing/selftests/net/fq_band_pktlimit.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/fq_band_pktlimit.sh b/tools/testing/selftests/net/fq_band_pktlimit.sh
index 977070ed42b3..223f9efe4090 100755
--- a/tools/testing/selftests/net/fq_band_pktlimit.sh
+++ b/tools/testing/selftests/net/fq_band_pktlimit.sh
@@ -32,19 +32,19 @@ tc qdisc replace dev dummy0 root handle 1: fq quantum 1514 initial_quantum 1514
 DELAY=400000
 
 ./cmsg_sender -6 -p u -d "${DELAY}" -n 20 fdaa::2 8000
-OUT1="$(tc -s qdisc show dev dummy0 | grep '^\ Sent')"
+OUT1="$(tc -s qdisc show dev dummy0 | grep '^ Sent')"
 
 ./cmsg_sender -6 -p u -d "${DELAY}" -n 20 fdaa::2 8000
-OUT2="$(tc -s qdisc show dev dummy0 | grep '^\ Sent')"
+OUT2="$(tc -s qdisc show dev dummy0 | grep '^ Sent')"
 
 ./cmsg_sender -6 -p u -d "${DELAY}" -n 20 -P 7 fdaa::2 8000
-OUT3="$(tc -s qdisc show dev dummy0 | grep '^\ Sent')"
+OUT3="$(tc -s qdisc show dev dummy0 | grep '^ Sent')"
 
 # Initial stats will report zero sent, as all packets are still
 # queued in FQ. Sleep for at least the delay period and see that
 # twenty are now sent.
 sleep 0.6
-OUT4="$(tc -s qdisc show dev dummy0 | grep '^\ Sent')"
+OUT4="$(tc -s qdisc show dev dummy0 | grep '^ Sent')"
 
 # Log the output after the test
 echo "${OUT1}"
@@ -53,7 +53,7 @@ echo "${OUT3}"
 echo "${OUT4}"
 
 # Test the output for expected values
-echo "${OUT1}" | grep -q '0\ pkt\ (dropped\ 10'  || die "unexpected drop count at 1"
-echo "${OUT2}" | grep -q '0\ pkt\ (dropped\ 30'  || die "unexpected drop count at 2"
-echo "${OUT3}" | grep -q '0\ pkt\ (dropped\ 40'  || die "unexpected drop count at 3"
-echo "${OUT4}" | grep -q '20\ pkt\ (dropped\ 40' || die "unexpected accept count at 4"
+echo "${OUT1}" | grep -q '0 pkt (dropped 10'  || die "unexpected drop count at 1"
+echo "${OUT2}" | grep -q '0 pkt (dropped 30'  || die "unexpected drop count at 2"
+echo "${OUT3}" | grep -q '0 pkt (dropped 40'  || die "unexpected drop count at 3"
+echo "${OUT4}" | grep -q '20 pkt (dropped 40' || die "unexpected accept count at 4"
-- 
2.52.0


