Return-Path: <netdev+bounces-254466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGgGILV9emld7AEAu9opvQ
	(envelope-from <netdev+bounces-254466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:20:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE70EA90FB
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CC0333016D26
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29AF4332EA5;
	Wed, 28 Jan 2026 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="e4zSDpnq"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9619F3033F4;
	Wed, 28 Jan 2026 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635251; cv=none; b=WNlR77Wd3boc5NPkh1zGziwQ1NKpO/kunosIp6//9C+joMU3+GomnCkFRvXd4RQi0P401z3EwgBfF+SxV4exy7gjxdXb/0nXsHX0V1iB16UJZ2C4tubb3Nmdpriwp+av1YTV+zsMNX4lsVgBQVDBC4vsNpn3wzhkOru6mDHAGOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635251; c=relaxed/simple;
	bh=sote/VAIMN8Y4Sk5k0bjotb9QR9MKYCXDNjzh6wnwtw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FPdQtR+6O3TgzJhXoOjGd5ZF6mFovWpGVrWkIjhCCJY6+Uk7rkFrDQcO1BXx3vEXWPY150GB8xRhl6xAfHxbtHkw7Ew4AflcHyAzYpz6zkwzXWKO4gjhxTvsy+yhJjy0E91kBNFQwLRlxVXcn6Xcyrd0aLs1SH+q6HWnu+SSuWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=e4zSDpnq; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60SKnSMG1218206;
	Wed, 28 Jan 2026 13:20:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=gnNkE483piJuelQNFXSfB9+R9CbdWoca6wGcPfV6L/c=; b=e4zSDpnq+kZK
	i3MSsXV/dLntv7OvwW6kXakpWxd4esCliQewKtzITkJFkNgmM0iucSySE6xhOsdS
	Zfudjv5TLWUZSqUia8sdx3yzKdGAz2XHCYlYUCiREiOnYwXdOWeJWDE1Ey6ge60h
	i4/s7OR/nSVP2fkRGe1TBTo+oumhE9FTWFCivEhf9p4bGF4gFPTjAlVBFFQBKAlT
	sscPoPb/97oq60pWmmHWGje50TC3s9f/CI1z9xIc07sgxT00IL360t9oKquliKV+
	VIs/3DqOQ2R/bP/9d8+1j9eOv/mMQoleJ1n5MUh+nV3KZda0LjoYjvJVDTsSiZxX
	WsIxE6K9wg==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4bysu38amx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 28 Jan 2026 13:20:35 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1c::11) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.35; Wed, 28 Jan
 2026 21:20:33 +0000
From: Vishwanath Seshagiri <vishs@meta.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei
	<dw@davidwei.uk>,
        <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next 2/2] selftests: virtio_net: add buffer circulation test
Date: Wed, 28 Jan 2026 13:20:31 -0800
Message-ID: <20260128212031.1431746-3-vishs@meta.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260128212031.1431746-1-vishs@meta.com>
References: <20260128212031.1431746-1-vishs@meta.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE3NiBTYWx0ZWRfXw26/VrKjQjMH
 zW09v8/Yym265BGK80ajaxq/ocv43idPtGMTdVAV2e8dZ381dTLhxlztufG5otsYzb0nir6gRgQ
 HflbNyBio6AoGabd2BHT7HsvtXgAtb/tGHTXYNaUl10CzwxITO6zvRvlQD8JOOzkAP6hmLa4WhV
 x2IlJUD7l/p8pKqEYeEZxOFiwgDmsIXmIumSk2B36zLJcV30L9WTKvGziUniP14TLPMM44spo6+
 SqrEuVAJmeJt1k+ws0+UvNMM6Mx4oqgMakzztQS4dmJ6zP9BT0iZE161o6pKJjXo8ZLeYq7tqns
 IYPtIoIrtUuDfJLZXJwTQ7o1UFGEcGDhwW+O5B8/aDAjxQDO67qx1Ak8e+xuPbClNCCRnH58WKS
 BSgYFCnSjV4PTAUozjGFQoU6tIilZq00qgOmKeeXFsQivAhDn8+axVTB+pofPwKbtpj2SL6EiAw
 Vtp/AZdz8XAGmpHDu5A==
X-Proofpoint-GUID: w5yBQG5QgZziHWyBYKN8rM9SYJdwhBD3
X-Authority-Analysis: v=2.4 cv=ecMwvrEH c=1 sm=1 tr=0 ts=697a7da3 cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VabnemYjAAAA:8
 a=-RNOp1hDGyVVwNzvGBsA:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: w5yBQG5QgZziHWyBYKN8rM9SYJdwhBD3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-254466-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,meta.com:dkim,meta.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DE70EA90FB
X-Rspamd-Action: no action

Add iperf3-based test to verify RX buffer handling under load.
Optionally logs page_pool tracepoints when available.

Signed-off-by: Vishwanath Seshagiri <vishs@meta.com>
---
 .../drivers/net/virtio_net/basic_features.sh  | 70 +++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
index cf8cf816ed48..c2c8023d2b92 100755
--- a/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
+++ b/tools/testing/selftests/drivers/net/virtio_net/basic_features.sh
@@ -6,6 +6,7 @@
 ALL_TESTS="
 	initial_ping_test
 	f_mac_test
+	buffer_circulation_test
 "
 
 source virtio_net_common.sh
@@ -16,6 +17,8 @@ source "$lib_dir"/../../../net/forwarding/lib.sh
 h1=${NETIFS[p1]}
 h2=${NETIFS[p2]}
 
+require_command iperf3
+
 h1_create()
 {
 	simple_if_init $h1 $H1_IPV4/24 $H1_IPV6/64
@@ -83,6 +86,73 @@ f_mac_test()
 	log_test "$test_name"
 }
 
+buffer_circulation_test()
+{
+	RET=0
+	local test_name="buffer circulation"
+	local tracefs="/sys/kernel/tracing"
+
+	setup_cleanup
+	setup_prepare
+
+	ping -c 1 -I $h1 $H2_IPV4 >/dev/null
+	if [ $? -ne 0 ]; then
+		check_err 1 "Ping failed"
+		log_test "$test_name"
+		return
+	fi
+
+	local rx_start=$(cat /sys/class/net/$h2/statistics/rx_packets)
+	local tx_start=$(cat /sys/class/net/$h1/statistics/tx_packets)
+
+	if [ -d "$tracefs/events/page_pool" ]; then
+		echo > "$tracefs/trace"
+		echo 1 > "$tracefs/events/page_pool/enable"
+	fi
+
+	iperf3 -s --bind-dev $h2 -p 5201 &>/dev/null &
+	local server_pid=$!
+	sleep 1
+
+	if ! kill -0 $server_pid 2>/dev/null; then
+		if [ -d "$tracefs/events/page_pool" ]; then
+			echo 0 > "$tracefs/events/page_pool/enable"
+		fi
+		check_err 1 "iperf3 server died"
+		log_test "$test_name"
+		return
+	fi
+
+	iperf3 -c $H2_IPV4 --bind-dev $h1 -p 5201 -t 5 >/dev/null 2>&1
+	local iperf_ret=$?
+
+	kill $server_pid 2>/dev/null || true
+	wait $server_pid 2>/dev/null || true
+
+	if [ -d "$tracefs/events/page_pool" ]; then
+		echo 0 > "$tracefs/events/page_pool/enable"
+		local trace="$tracefs/trace"
+		local hold=$(grep -c "page_pool_state_hold" "$trace" 2>/dev/null)
+		local release=$(grep -c "page_pool_state_release" "$trace" 2>/dev/null)
+		log_info "page_pool events: hold=${hold:-0}, release=${release:-0}"
+	fi
+
+	local rx_end=$(cat /sys/class/net/$h2/statistics/rx_packets)
+	local tx_end=$(cat /sys/class/net/$h1/statistics/tx_packets)
+	local rx_delta=$((rx_end - rx_start))
+	local tx_delta=$((tx_end - tx_start))
+
+	log_info "Circulated TX:$tx_delta RX:$rx_delta"
+
+	if [ $iperf_ret -ne 0 ]; then
+		check_err 1 "iperf3 failed"
+	elif [ "$rx_delta" -lt 10000 ]; then
+		check_err 1 "Too few packets: $rx_delta"
+	fi
+
+	log_test "$test_name"
+}
+
 setup_prepare()
 {
 	virtio_device_rebind $h1
-- 
2.47.3


