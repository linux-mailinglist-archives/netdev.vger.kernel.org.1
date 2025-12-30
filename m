Return-Path: <netdev+bounces-246367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19330CEA215
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 17:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7523C303C9B4
	for <lists+netdev@lfdr.de>; Tue, 30 Dec 2025 16:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB85931D371;
	Tue, 30 Dec 2025 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="Klsbaahn"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster6-host3-snip4-10.eps.apple.com [57.103.76.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EBAF2264D5
	for <netdev@vger.kernel.org>; Tue, 30 Dec 2025 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.76.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767110644; cv=none; b=TzfwcHK51zCw5TKN7DzzJST0XnlbwVSlhraLtBNDclwJTlCWq/OuOL2tyAbzuF2km1pzTHVxW9d3PpN2k6hcG6VnWJO91iYGhw1sYc7pQeri442rIH13wFmSPBuyk3aVX5vIWZthyfv8QzLY9tJ0fEfOQVJ2VlDyMF6KpPyGedc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767110644; c=relaxed/simple;
	bh=zmPQmcjqAS7+NLVup1Hb6uzKU7ZBzGKrGU1sJsVUJ6k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJhl1oZC0+qJengeN08kqOmfNqpnXJCYTk/k1KMJsqY5wN/FJ1OtHVpBm1L7gFOL07zNXtYBta3TcYaq/M6XSyhsarXSAh7dZOd9E7e7/fAub1NAlyyZeymLz/2dGe7DmgN1d0cgBvaYMoyilv966X342wB3sCkHOXh07YcLwyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=Klsbaahn reason="key not found in DNS"; arc=none smtp.client-ip=57.103.76.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPS id 737E018000A7;
	Tue, 30 Dec 2025 16:03:58 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=r+5vsbdcbm7QVQah2qYll7weZW7TjzysSqYVCHYd9FA=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=Klsbaahnbi8ZF+eDbXiNzgE0HNwIQuUTo90op3pIklieOMOIrBIvHDbw9BrX3Kd0C14k7nVvoWnK/oK69GU3YjDIez+ltrM2Y1n7cOhkDJ774YlmDKOIcaUylyxddQEiJJ+cTP8FkfQaK/pD0znhQRKPh3B5Cl0hp+yOTRP/DrpWiCGjehZVIpZ8iITumMu23sZDSjqVqzJJVPIrU9eaDKnubWgqJjwJ6ATPhWznOe1AybiQnHb96mOzr0226Stn7Ng6qLQcdtlfFFNWjHMtcc7wVKAHlbN3u1Z6lm+0fiVaTa/T0nrSVeQ0QNaGuXneAZh+dv6egMWaNAHs5t/o0A==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-7 (Postfix) with ESMTPSA id 218CE18005BB;
	Tue, 30 Dec 2025 16:03:54 +0000 (UTC)
From: yk@y-koj.net
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Breno Leitao <leitao@debian.org>
Cc: Yohei Kojima <yk@y-koj.net>,
	Andrew Lunn <andrew@lunn.ch>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 1/2] net: netdevsim: fix inconsistent carrier state after link/unlink
Date: Wed, 31 Dec 2025 01:03:29 +0900
Message-ID: <c1a057c1586b1ec11875b3014cdf6196ffb2c62b.1767108538.git.yk@y-koj.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1767108538.git.yk@y-koj.net>
References: <cover.1767108538.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=RLy+3oi+ c=1 sm=1 tr=0 ts=6953f7ef cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jnl5ZKOAAAAA:8
 a=7gZhQl7Q0LLefV5nMKsA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-ORIG-GUID: QDTPjWdtM5vIiwIBa7uqsmtpjtnbJ-FG
X-Proofpoint-GUID: QDTPjWdtM5vIiwIBa7uqsmtpjtnbJ-FG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjMwMDE0NSBTYWx0ZWRfX4TpdrEMIZFUM
 lnrEJZihx4jnC2BNw8lcaCUu7snXG6ZjZr7rM+lRYt3F8IizjZ4a5TOX1mILRo1GKHSsVbmt6/A
 6w1qhCtpSAmfTpXAxygW3MZuZy15TNQM14uFdpf5ZMqZEseEGHYq4/iOoimHR4Hp+/azyCJUTmc
 NlZq3B7dmV7z5r72ZLPNQGTTjubLIL7Z31SCaXQhXaO1afVCgjqV9O1mTLAKhxgrk8BTgmrMO0J
 CmYmTWpPvThsyezKjI6+jsR+qIE4NLvC+vz0QojjeOsgi9p9kfVK7fwlEhS03A7UaKBQk2hHWrX
 g36SAEAbE9vaWAisY25
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-30_02,2025-12-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxscore=0 clxscore=1030 suspectscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 adultscore=0 classifier=spam authscore=0
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512300145
X-JNJ: AAAAAAAB8UvIsOlzKWmqERuE86hb1M8IOF5qYRRp70XsOZ7NioeitzLEUPXiRiL3+iG1Z2FMBcCR2+jWwClZ7aIohfj2LC/PX74J5qJvZRSXVua6U1Wx8nBOXkBuY9x2LBAMI4An1K1sEn81UktY2ThKacssxeLL/sq1iEWlp82X2Ac6qtfeqREvWeNPS9ISbDr5a7q4W1uMpxizTMgweNYNXrAzRV9e0QpYBCVcIqdpDOOk7T3jiyYt6grHuaYNBUyDCLK3CsfAA+lF38AE6JrUYoXTKeFroWIFk4phAWTjkbQP3kmBekXHxFKYt3G7bWgZSRukW1yUOkyOUFy+jzfa9CK5q78WyI2AOBtl+vSB9ri/fpriPGKvcs3m+ZPqJCoWdPRj9k21VsyZb54wlL6hDTKD2XLGo3DsoIZ3dqNbrsbC0OpGUYo5Z/DI7QFV6B5SnXY1iYSzUeSYESfEaVUgqQRHfoBbSyCVncwtGsAo8Gb+stufNBJsiuTfkrq5uxHtl/rEZfxHOR+PE8u9/rduJ1LvAw3PiAKGhJQGqnEq6BXrfZvMtNt3A4gTntAwYEXa3n9IvybzAtmxnb9/IJpx1Y+Dz7SSoF+nnZbTcYbQ8n0qu5TaAYaD3f7NUK5hGG/gt8teT4Br+E8MPnHBYzn9J/vg7qWq68foEQPtBkuLa6mvVc1AsNxs0DYtZ84xKVgY2ZtjazpciNQgm5M0UlDvVulZp85/lhq7oUzMvA5r9ly7v+woPv+0

From: Yohei Kojima <yk@y-koj.net>

This patch fixes the edge case behavior on ifup/ifdown and
linking/unlinking two netdevsim interfaces:

1. unlink two interfaces netdevsim1 and netdevsim2
2. ifdown netdevsim1
3. ifup netdevsim1
4. link two interfaces netdevsim1 and netdevsim2
5. (Now two interfaces are linked in terms of netdevsim peer, but
    carrier state of the two interfaces remains DOWN.)

This inconsistent behavior is caused by the current implementation,
which only cares about the "link, then ifup" order, not "ifup, then
link" order. This patch fixes the inconsistency by calling
netif_carrier_on() when two netdevsim interfaces are linked.

This patch fixes buggy behavior on NetworkManager-based systems which
causes the netdevsim test to fail with the following error:

  # timeout set to 600
  # selftests: drivers/net/netdevsim: peer.sh
  # 2025/12/25 00:54:03 socat[9115] W address is opened in read-write mode but only supports read-only
  # 2025/12/25 00:56:17 socat[9115] W connect(7, AF=2 192.168.1.1:1234, 16): Connection timed out
  # 2025/12/25 00:56:17 socat[9115] E TCP:192.168.1.1:1234: Connection timed out
  # expected 3 bytes, got 0
  # 2025/12/25 00:56:17 socat[9109] W exiting on signal 15
  not ok 13 selftests: drivers/net/netdevsim: peer.sh # exit=1

This patch also solves timeout on TCP Fast Open (TFO) test in
NetworkManager-based systems because it also depends on netdevsim's
carrier consistency.

Fixes: 1a8fed52f7be ("netdevsim: set the carrier when the device goes up")
Signed-off-by: Yohei Kojima <yk@y-koj.net>
---
 drivers/net/netdevsim/bus.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index 70e8c38ddad6..fa94c680c92a 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -332,6 +332,9 @@ static ssize_t link_device_store(const struct bus_type *bus, const char *buf, si
 	rcu_assign_pointer(nsim_a->peer, nsim_b);
 	rcu_assign_pointer(nsim_b->peer, nsim_a);
 
+	netif_carrier_on(dev_a);
+	netif_carrier_on(dev_b);
+
 out_err:
 	put_net(ns_b);
 	put_net(ns_a);
@@ -381,6 +384,9 @@ static ssize_t unlink_device_store(const struct bus_type *bus, const char *buf,
 	if (!peer)
 		goto out_put_netns;
 
+	netif_carrier_off(dev);
+	netif_carrier_off(peer->netdev);
+
 	err = 0;
 	RCU_INIT_POINTER(nsim->peer, NULL);
 	RCU_INIT_POINTER(peer->peer, NULL);
-- 
2.51.2


