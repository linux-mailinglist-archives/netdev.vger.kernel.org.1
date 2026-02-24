Return-Path: <netdev+bounces-260276-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAE5ABnwnGkaMQQAu9opvQ
	(envelope-from <netdev+bounces-260276-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:26:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 544B7180382
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 01:26:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9B983115E30
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 00:24:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5262135D7;
	Tue, 24 Feb 2026 00:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b="wsdv0yF9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B685221F06
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 00:24:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771892692; cv=none; b=IFAN0bGHgCS8f5ER3LANefVwYF0Q3fFUzaHmYM8vMSmzedSLpX4efY+tSzeucvps98KKGBIiiZi9wTX52WU6YvItPBg7pCnNBLpMSJapBsk1x9tvUqInAkrfrJW+tYmgegu7livUYDz/4MBABZkMFKlBkDHBZpuBTRua0R6qtdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771892692; c=relaxed/simple;
	bh=MVCVU00DeDCDbNOXgcH2VDl4snjVGDj4J6MwgDXWU24=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mqlFf8DlcYn5Nj3IvzkWtBmcCiw/CB66+an4eu6PjZreC0z8BJOrpbTIrkACWEVwvM2SC5vvNu2m8IanFsFZvBwf1kBzwHkdaOJW1n/8W53F+b0JiC23dlAp8M8ATJYBhEHdkdJNoY8YjqUwi1qkSaiegDdRfcOmJ/oPeKfH3XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=fb.com header.i=@fb.com header.b=wsdv0yF9; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61NJD5Gd3058462
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:24:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=OIfz4L05ht3QleeHuZ/yuHK+3PErwO/TVAG9fwN0tCI=; b=wsdv0yF91PS8
	ECCyya8b7D5JC11FvzhRMcewgy1//vGhM27GmDkfL5P+ZPg5Es3HnoE5l/urmKSt
	rYX6XWmN/pgil954+shi0TB+yX8EjMYG07Sewl9J6iO+XescIhpeBGi+7JeqiGOz
	NpXVZzfSD633OAfl8IUU3grZ5XiFGEhfi45DyiDclb0SebDy1rhlQ7RyWYjbCorU
	8fEuOy7ZJOwQfHwRY3u9KDCAgP6cgFcUESjs1Ql04v8NlDnq+r2qUv+BjuP1A6jx
	G7wxf3vplqJ7UhbiWwatUWOdvk0cAiEaHDYITBY5iHGlYzYoDV0GvbcHvy4KXO4V
	UJJscrvaow==
Received: from mail.thefacebook.com ([163.114.134.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4cgvuyjxrx-12
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:24:50 -0800 (PST)
Received: from twshared18080.32.frc3.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 24 Feb 2026 00:24:47 +0000
Received: by devbig1867.frc2.facebook.com (Postfix, from userid 708122)
	id 96DD865F7ED4; Mon, 23 Feb 2026 16:24:38 -0800 (PST)
From: Wei Wang <weibunny@fb.com>
To: <netdev@vger.kernel.org>, Jakub Kicinski <kuba@kernel.org>,
        Daniel Zahka
	<daniel.zahka@gmail.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        David Wei <dw@davidwei.uk>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S.
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>
CC: Wei Wang <weibunny@fb.com>
Subject: [PATCH net-next 2/9] selftests/net: Export Netlink class via lib.py
Date: Mon, 23 Feb 2026 16:24:02 -0800
Message-ID: <20260224002410.1553838-3-weibunny@fb.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224002410.1553838-1-weibunny@fb.com>
References: <20260224002410.1553838-1-weibunny@fb.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDAwMSBTYWx0ZWRfX7avh6a6wZyiu
 LIAf/2bwKzUs7+Uaxc7/EMmJHZmfbjTYfx5e2RKTcaox7HYCP+WlVspXQWBdh4Gt0RQ6XwHcLPP
 F7VsH9/4NkJLK6oEwr2d55bpHJHxkFvkvZFhk2JcN4xjMw1qjDzm4pny7I+qTG4g5tM7nOiTjjK
 puOjT5EZReveNAyf7hyNTh6MfRrXmC2MYVeyFYCiGwafzjXPOVa/933WriyQK5TDDcmqYg1xETz
 L440mXrX43PEa616UTIFCp+dH69i1d2VnWwmMvDGIo5X1AXzGQ0CvQQi8r+dfQMq6THVIW8keEc
 NX6beWtDK4v22/Wz04T5y2jiH8h+kxVjOHdchajGvn86n3OGSoy1GXc6WFx/O5ts1LDgbd///Pp
 JFF0s7Fi6ctGEkEjMzEnkaUSstqF8sX6i1gfNOzTP559r2T3aCrQUjtq72dJMmHIggekHe/xLLr
 iSh7JbQbN9ocfPCfYFQ==
X-Proofpoint-GUID: ZCD3gaeog8B_NfmEkKnkQULYNWQFNeoR
X-Proofpoint-ORIG-GUID: ZCD3gaeog8B_NfmEkKnkQULYNWQFNeoR
X-Authority-Analysis: v=2.4 cv=Vqcuwu2n c=1 sm=1 tr=0 ts=699cefd2 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=iRNz6Rt8Zo2PrG0X1xAA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-23_06,2026-02-23_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[fb.com,reject];
	R_DKIM_ALLOW(-0.20)[fb.com:s=s2048-2025-q2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,kernel.org,gmail.com,davidwei.uk,lunn.ch,davemloft.net,google.com];
	TAGGED_FROM(0.00)[bounces-260276-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[fb.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[weibunny@fb.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.py:url,fb.com:mid,fb.com:dkim,davidwei.uk:email];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 544B7180382
X-Rspamd-Action: no action

From: David Wei <dw@davidwei.uk>

Making rtnl newlink calls requires constants defined in Netlink class in
pyynl. Export it.

Signed-off-by: David Wei <dw@davidwei.uk>
---
 tools/testing/selftests/drivers/net/lib/py/__init__.py | 4 ++--
 tools/testing/selftests/net/lib/py/__init__.py         | 4 ++--
 tools/testing/selftests/net/lib/py/ynl.py              | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/lib/py/__init__.py b/too=
ls/testing/selftests/drivers/net/lib/py/__init__.py
index 8b75faa9af6d..a18e21069f7a 100644
--- a/tools/testing/selftests/drivers/net/lib/py/__init__.py
+++ b/tools/testing/selftests/drivers/net/lib/py/__init__.py
@@ -19,7 +19,7 @@ try:
     # Import one by one to avoid pylint false positives
     from net.lib.py import NetNS, NetNSEnter, NetdevSimDev
     from net.lib.py import EthtoolFamily, NetdevFamily, NetshaperFamily,=
 \
-        NlError, RtnlFamily, DevlinkFamily, PSPFamily
+        NlError, RtnlFamily, DevlinkFamily, PSPFamily, Netlink
     from net.lib.py import CmdExitFailure
     from net.lib.py import bkg, cmd, bpftool, bpftrace, defer, ethtool, =
\
         fd_read_timeout, ip, rand_port, wait_port_listen, wait_file
@@ -31,7 +31,7 @@ try:
=20
     __all__ =3D ["NetNS", "NetNSEnter", "NetdevSimDev",
                "EthtoolFamily", "NetdevFamily", "NetshaperFamily",
-               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily",
+               "NlError", "RtnlFamily", "DevlinkFamily", "PSPFamily", "N=
etlink",
                "CmdExitFailure",
                "bkg", "cmd", "bpftool", "bpftrace", "defer", "ethtool",
                "fd_read_timeout", "ip", "rand_port",
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testi=
ng/selftests/net/lib/py/__init__.py
index f528b67639de..fec518c2a0dc 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -15,7 +15,7 @@ from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, wait_port_listen, wait_fi=
le, tool
 from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFa=
mily, RtnlAddrFamily
-from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily
+from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
=20
 __all__ =3D ["KSRC",
            "KsftFailEx", "KsftSkipEx", "KsftXfailEx", "ksft_pr", "ksft_e=
q",
@@ -30,4 +30,4 @@ __all__ =3D ["KSRC",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
-           "RtnlAddrFamily"]
+           "RtnlAddrFamily", "Netlink"]
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/se=
lftests/net/lib/py/ynl.py
index 32c223e93b2c..a52b067f7589 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -13,14 +13,14 @@ try:
         SPEC_PATH =3D KSFT_DIR / "net/lib/specs"
=20
         sys.path.append(tools_full_path.as_posix())
-        from net.lib.ynl.pyynl.lib import YnlFamily, NlError
+        from net.lib.ynl.pyynl.lib import YnlFamily, NlError, Netlink
     else:
         # Running in tree
         tools_full_path =3D KSRC / "tools"
         SPEC_PATH =3D KSRC / "Documentation/netlink/specs"
=20
         sys.path.append(tools_full_path.as_posix())
-        from net.ynl.pyynl.lib import YnlFamily, NlError
+        from net.ynl.pyynl.lib import YnlFamily, NlError, Netlink
 except ModuleNotFoundError as e:
     ksft_pr("Failed importing `ynl` library from kernel sources")
     ksft_pr(str(e))
--=20
2.47.3


