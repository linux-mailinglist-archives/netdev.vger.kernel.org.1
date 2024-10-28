Return-Path: <netdev+bounces-139456-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FCF9B2A42
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 09:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DA32B21A91
	for <lists+netdev@lfdr.de>; Mon, 28 Oct 2024 08:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C70193403;
	Mon, 28 Oct 2024 08:28:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9232191F90;
	Mon, 28 Oct 2024 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730104111; cv=none; b=Xl7wUIEsnzLcsxRSTZVpvBHAPlWmfEj8WH+SQpATfnZslMG0UbO5DlZac5N5JNSf+F1TzmwI55zsj7ETWLl2wcxy0514MwmAj0wXGATbovMKImCThfYLMwKuaIPFMRn+yNulcx2iVyfvgUkbPZKvi2YJSNXeM4fB4jJ3i2/oRBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730104111; c=relaxed/simple;
	bh=KamEan+PnVyNuBX9u57VDrPwGT1hSxL/rVZ/KDiCcyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mQQ8ZW+XcY9ZXiQFY7a9ob3Jsb2Ar3n+sZD9tymqR1G9A6uGyec608ugT6s8YgKdulY6p3l+VSMXUw10UgCrkwnaYhjZOTxPriwMFHDSkJtWK6NWDhE5GL6D0lKbbHd+ouKbsMV7gNE87V4l+u6TE/jmC/956j95MANkU2dt4WY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 950c1472950611efa216b1d71e6e1362-20241028
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.38,REQID:12e56712-1024-4a35-9cd9-1dc2f5bc7837,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:82c5f88,CLOUDID:dc9a7ee7823974db99a90deedbb6bf26,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:1,EDM:-3,IP:nil,URL:1
	1|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,S
	PR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 950c1472950611efa216b1d71e6e1362-20241028
Received: from mail.kylinos.cn [(10.44.16.175)] by mailgw.kylinos.cn
	(envelope-from <jiangyunshui@kylinos.cn>)
	(Generic MTA)
	with ESMTP id 1633757205; Mon, 28 Oct 2024 16:28:17 +0800
Received: from mail.kylinos.cn (localhost [127.0.0.1])
	by mail.kylinos.cn (NSMail) with SMTP id 47811E000E83;
	Mon, 28 Oct 2024 16:28:17 +0800 (CST)
X-ns-mid: postfix-671F4B18-423722651
Received: from kylin-pc.. (unknown [172.25.130.133])
	by mail.kylinos.cn (NSMail) with ESMTPA id 8FBE2E000E84;
	Mon, 28 Oct 2024 16:28:05 +0800 (CST)
From: Yunshui Jiang <jiangyunshui@kylinos.cn>
To: andrew@lunn.ch
Cc: davem@davemloft.net,
	edumazet@google.com,
	jiangyunshui@kylinos.cn,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH v2] tests: hsr: Increase timeout to 50 seconds
Date: Mon, 28 Oct 2024 16:27:56 +0800
Message-ID: <20241028082757.2945232-1-jiangyunshui@kylinos.cn>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <37f34544-b9dc-4d32-ae2f-8228cf50ffa3@lunn.ch>
References: <37f34544-b9dc-4d32-ae2f-8228cf50ffa3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

The HSR test, hsr_ping.sh, actually needs 7 min to run. Around 375s to
be exact, and even more on a debug kernel or kernel with other network
security limits. The timeout setting for the kselftest is currently 45
seconds, which is way too short to integrate hsr tests to run_kselftest
infrastructure. However, timeout of hundreds of seconds is quite a long
time, especially in a CI/CD environment. It seems that we need
accelerate the test and balance with timeout setting.

The most time-consuming func is do_ping_long, where ping command sends
10 packages to the given address. The default interval between two ping
packages is 1s according to the ping Mannual. There isn't any operation
between pings thus we could pass -i 0.1 to ping to make it 10 times
faster.

While even with this short interval, the test still need about 46.4
seconds to finish because of the two HSR interfaces, each of which is
tested by calling do_ping func 12 times and do_ping_long func 19 times
and sleep for 3s.

So, an explicit setting is also needed to slightly increase the
timeout. And to leave us some slack, use 50 as default timeout.

Signed-off-by: Yunshui Jiang <jiangyunshui@kylinos.cn>
---
 tools/testing/selftests/net/hsr/hsr_common.sh | 4 ++--
 tools/testing/selftests/net/hsr/settings      | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)
 create mode 100644 tools/testing/selftests/net/hsr/settings

diff --git a/tools/testing/selftests/net/hsr/hsr_common.sh b/tools/testin=
g/selftests/net/hsr/hsr_common.sh
index 8e97b1f2e7e5..1dc882ac1c74 100644
--- a/tools/testing/selftests/net/hsr/hsr_common.sh
+++ b/tools/testing/selftests/net/hsr/hsr_common.sh
@@ -15,7 +15,7 @@ do_ping()
 {
 	local netns=3D"$1"
 	local connect_addr=3D"$2"
-	local ping_args=3D"-q -c 2"
+	local ping_args=3D"-q -c 2 -i 0.1"
=20
 	if is_v6 "${connect_addr}"; then
 		$ipv6 || return 0
@@ -36,7 +36,7 @@ do_ping_long()
 {
 	local netns=3D"$1"
 	local connect_addr=3D"$2"
-	local ping_args=3D"-q -c 10"
+	local ping_args=3D"-q -c 10 -i 0.1"
=20
 	if is_v6 "${connect_addr}"; then
 		$ipv6 || return 0
diff --git a/tools/testing/selftests/net/hsr/settings b/tools/testing/sel=
ftests/net/hsr/settings
new file mode 100644
index 000000000000..0fbc037f2aa8
--- /dev/null
+++ b/tools/testing/selftests/net/hsr/settings
@@ -0,0 +1 @@
+timeout=3D50
--=20
2.45.2


