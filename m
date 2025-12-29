Return-Path: <netdev+bounces-246253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A88BDCE7D0C
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 11CE330115D9
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 18:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451E833031F;
	Mon, 29 Dec 2025 18:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b="fTjksTnz"
X-Original-To: netdev@vger.kernel.org
Received: from outbound.st.icloud.com (p-east2-cluster5-host7-snip4-7.eps.apple.com [57.103.79.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5C3318143
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 18:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=57.103.79.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767033213; cv=none; b=Iebzyi62mEgRu6TxcVazCM/z5NygCAHj0Lsn8oUu1O774W0+rdc7JFZHx+oA1Dc4EFyHRGenkSts/h86qxoI32bqR/H5voNgCGw+mExYOdlkUGk49aOhNxzEBI9GgdIVKIwKWX47lKzWzS9fZdi6osO6CsN9hFDbZdFpDfflFfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767033213; c=relaxed/simple;
	bh=F6hi/n/cmMeLDQQi3XHH51XWTCeUo600IxFKsvd7mA8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pcxehtIOkdt9TOwOkYIDNUY2Qxs2IzC3/6Q1F+/0BGdOOB8wtjAnmFmVLQ57IuSTx6deEAHAiu/YbrB0BwZFUWBHgBXjcQEIZsvifMiCnPfU0UgXmecVxJiIsYZcv1Uhg77REKAYS7qWOp9tR63lESZdeLw+6MTiEk6hhxCtDVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net; spf=pass smtp.mailfrom=y-koj.net; dkim=fail (0-bit key) header.d=y-koj.net header.i=@y-koj.net header.b=fTjksTnz reason="key not found in DNS"; arc=none smtp.client-ip=57.103.79.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=y-koj.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=y-koj.net
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPS id A8B3418002A4;
	Mon, 29 Dec 2025 18:33:26 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=y-koj.net; s=sig1; bh=ffUKAB/WImQI3cUv7+z8VSSk4PPyL0BQeWyDVBCYuQw=; h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme; b=fTjksTnzgvZdnCq9BIdZd27OsphmtwKQZCBhRUCzQyk3UPuSCZANzMkyVTR3TtAZ5OD5DGH8npU0DQgYw+8JwrOyhir+qdsAPcOjwvK145W3i6PiNLJA+YFypg7vToMXWXA6Lxjy/t4v5arsCK2FsCPzuYKzGaRcT05JRqr4E0MRlqWW2OqcLc0ubrROFD9DfbepjspaQIWMMF02G8MKLDNogwIVKe3a7cakZDbqBtMkgGIwK69433cqiBmel+Dr733lo3OQPoSMJTdpgnFsxob8x/IFl43GkBXauqoEOORwoFLEw/tfn+c/1ri1A7zOXtELaawFWWDR7pyDmNMR2w==
mail-alias-created-date: 1719758601013
Received: from desktop.tail809fd.ts.net (unknown [17.42.251.67])
	by p00-icloudmta-asmtp-us-east-1a-60-percent-6 (Postfix) with ESMTPSA id F42381800B84;
	Mon, 29 Dec 2025 18:33:23 +0000 (UTC)
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
Subject: [PATCH net 1/5] net: netdevsim: fix inconsistent carrier state after link/unlink
Date: Tue, 30 Dec 2025 03:32:34 +0900
Message-ID: <ff1139d3236ab7fec2b2b3a2e22510dcd7b01a21.1767032397.git.yk@y-koj.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1767032397.git.yk@y-koj.net>
References: <cover.1767032397.git.yk@y-koj.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info: v=2.4 cv=CdsFJbrl c=1 sm=1 tr=0 ts=6952c977 cx=c_apl:c_pps
 a=YrL12D//S6tul8v/L+6tKg==:117 a=YrL12D//S6tul8v/L+6tKg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=jnl5ZKOAAAAA:8
 a=7gZhQl7Q0LLefV5nMKsA:9 a=RNrZ5ZR47oNZP8zBN2PD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjI5MDE3MCBTYWx0ZWRfXw1QwishnM/P8
 Gn41SsTter2s+4x1iAfaZrAe+xRgfLEXQQQee/t7C+ACKFyIX78ZUVCk+eVocK3vX+wNJuF5ntM
 49q2U7y/NZcA8g3rAnBQzOLSIjpHML+KT2i2orFUp0i5iDphFHbpI/lK/yedARziJF06tS/8V7q
 eHdQDizweHQb2Am4XxjXP05e8T5p7/kV87qFhAZueNuq8ipaKYHJEpXnDgh91JlngFfq5wOLuY/
 yA2CUNnn7d3J2lkwh2lk8TVyLYbvNSMehCjUreMGxhxtyS9iinMYR0wEm1g7L8w6KQD5mZSRJts
 TSE7jQmnpyTHrU9W5m+
X-Proofpoint-GUID: N-l_41a8EYy4qgI23Rkgme3qh5f8JfyC
X-Proofpoint-ORIG-GUID: N-l_41a8EYy4qgI23Rkgme3qh5f8JfyC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-29_05,2025-12-29_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 clxscore=1030 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 mlxscore=0 spamscore=0 classifier=spam authscore=0 adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2512290170
X-JNJ: AAAAAAABtdE5UnxUYPrzEOrDWgG6PiMaIvTKYVNVnWTUG8t90KysQVym6Q98F5O/JEr534WaCzjWlNvjlqt6je/SEHRCkKxuoefJiHh3wEu/Ey33dtdRlLdh+UHz/Xt1omLpePn0L6WAIw5s6DgoiVZB55mfY74aHZcMeWCegpRYHYD2vq3c4uuivmtBZBgd2ils/ehl6st1v97odqWu5A/fRaowjNz+IJOrZmliKdfHmDgehCboHoTz//g5EuW0kDtUAVTDDxCL6Os9OHu8egDVuFkZTLDFc2SR0gJkCrDQPvvNzjXjHEPDL1XFIYaxMil26cNnt1zibzBZux7QiflAevfm4Jjitd4vty0yMExbozEn5rfwWAUEwIXYLkgMsjlmFTu/fnFRSS8btSnyB0g3Ru4NslUwfBdVDG54ed5eokitvgNGyKUnp4/WyGOV58BwLJMBlEKZDnG0bcweZKMgb1WIf/nx0Ic2B+gZXpo5n2ReFYMFrKi/E4Ra+S78RJwthGhey7HzN4ckLzaW9GO4LCBgRgUH2pBsp79Nghoqi9z2WGVHwpzuNo2XjE9TedTA0+9YBjullysuRf0Hsz9WuNIQH0o7iJbcrVL4M4X0v39drCa3xmtMbUHpwWU4K6t4uBIVoY0s4zBQLoVZGUyscwpHGH4QyIgkyYHP6yoEef4LmJnqaRmlMs1kSqJd+SjmzieNRll196vXtjDIhhMc9VjkK0XFQXmhJIwQ/ItFt4dI2w==

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

This patch solves buggy behavior on NetworkManager-based systems which
causes the netdevsim test to fail with the following error:

  # timeout set to 600
  # selftests: drivers/net/netdevsim: peer.sh
  # 2025/12/25 00:54:03 socat[9115] W address is opened in read-write mode but only supports read-only
  # 2025/12/25 00:56:17 socat[9115] W connect(7, AF=2 192.168.1.1:1234, 16): Connection timed out
  # 2025/12/25 00:56:17 socat[9115] E TCP:192.168.1.1:1234: Connection timed out
  # expected 3 bytes, got 0
  # 2025/12/25 00:56:17 socat[9109] W exiting on signal 15
  not ok 13 selftests: drivers/net/netdevsim: peer.sh # exit=1

This patch also fixes timeout on TCP Fast Open (TFO) test because the
test also depends on netdevsim.

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


