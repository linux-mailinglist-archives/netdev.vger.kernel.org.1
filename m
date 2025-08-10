Return-Path: <netdev+bounces-212364-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CC223B1FB01
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 18:09:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B407A4987
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 16:08:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80447264F8A;
	Sun, 10 Aug 2025 16:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="nIFeQbWJ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Ch+sH5SJ"
X-Original-To: netdev@vger.kernel.org
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB27D1E32B9
	for <netdev@vger.kernel.org>; Sun, 10 Aug 2025 16:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754842192; cv=none; b=t2vOJ6NPUsPTuRIFM1dDyqoW26lX5SPE8KhEHt//TRkTp/8wUHjGkrsiRc6OU5zwycgxr2guhKGQ1w1E6ZsfZoqnT+OLDWIJzZHYL6YMAxk/UxWQSadtQTzJpc2P3jusMA3CWEsbqMdcOjID721zalDylQenbq4aC7md/bJUr4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754842192; c=relaxed/simple;
	bh=tO5g3Ss0oI1NacNBg4LkJiBvvGw9JA3Yfxxs5uYOcZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l2oVlCr40ooCtAWWeYLlEJ+OcOH6ozn/UzYfwEr1SmKjaVSdXTZ7Q2xG9nDIWDbcO0OGVqRoJT/gKJp93fhC/bVIgIq8986k5jeEHvkBoYeR0XUjk184eDdwbHPE+Fztf/3F0BWG8k29YTYe2dOSJSLIJMd3uJ2kVZNq6fTuEI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=nIFeQbWJ; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Ch+sH5SJ; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4c0N591K70z9sWZ;
	Sun, 10 Aug 2025 18:09:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754842189;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L1V50+Sjgw++E3ED3ULak4ITPOMq5xeLsGrSPh1XRxk=;
	b=nIFeQbWJWKpAKt+Q98RYKnu4URl3bq2M656b/f7ZXiMMejzHcKyB8NTqwx8kPlWFd5dA2Z
	gYKPPnihxG3Q83vrMF2r0+a1Bdrj6ACXwJAJObU1b8GQ96VhdajbGG6qMCiZFd6hsMGpJ9
	WHGCl1Lmi8Ni7RPV5qhmh+/fuYVMCyCs+rJ0rthHTKa0whZZ80TnZ5Cr/IlGy+CTd2gP/l
	xwog0eYDMk77AeLLbbt5PwP96Doxd4N0fjpyHaYG6jegyhezpL2+04BywVL+Lpr+et3Yjf
	50/UQZJ6jFXhP47etNDVVrqAlW4vunLu+53ZpUojD/7SUzXtHD9T2fqcP5KQKA==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=Ch+sH5SJ;
	spf=pass (outgoing_mbo_mout: domain of marek.vasut@mailbox.org designates 2001:67c:2050:b231:465::102 as permitted sender) smtp.mailfrom=marek.vasut@mailbox.org
From: Marek Vasut <marek.vasut@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1754842187;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=L1V50+Sjgw++E3ED3ULak4ITPOMq5xeLsGrSPh1XRxk=;
	b=Ch+sH5SJkWMT9GY53vwfUbZ33j89h3QZdXd3V4juOAC3zPfNFJlxzIy7/ZAY2/d2mbsKuz
	yrVbJkRwG3bWB6adZk+IDebqecdKA2qvVemUETxd9PBcZh7+/1VWVUF+i52c5jpCJIczKR
	KP98ZfjaugeUvgMnl/u1YXnmO7pFFMm50vDg152rzkYLRdKItop8eXv51N4ikludPOoa2L
	bDDwADkrHugPCXgeoNe+Lx6bZQHoZsDmL28FBBaZuILz2YSDmELYLjhWZatw3j0JrfH4r+
	HF6R8t1HgP1lYPCs+uEBewTFzwoWwXNzmx/8f1V6HFKb1w0+nQrrZ8+wNMsEbA==
To: netdev@vger.kernel.org
Cc: Marek Vasut <marek.vasut@mailbox.org>,
	Andrew Lunn <andrew@lunn.ch>,
	Arun Ramadoss <arun.ramadoss@microchip.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Tristram Ha <tristram.ha@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>
Subject: [net-next,PATCH] net: dsa: microchip: Do not count RX/TX Bytes and discards on KSZ87xx
Date: Sun, 10 Aug 2025 18:09:05 +0200
Message-ID: <20250810160933.10609-1-marek.vasut@mailbox.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: wappa3p47umcrbam1jz6ot4mdkhu69me
X-MBO-RS-ID: 0d6e00154e6efc66efa
X-Rspamd-Queue-Id: 4c0N591K70z9sWZ

Unlike KSZ94xx, the KSZ87xx is missing the last four MIB counters at
address 0x20..0x23, namely rx_total, tx_total, rx_discards, tx_discards.

Using values from rx_total / tx_total in rx_bytes / tx_bytes calculation
results in an underflow, because rx_total / tx_total returns values 0,
and the "raw->rx_total - stats->rx_packets * ETH_FCS_LEN;" calculation
undeflows if rx_packets / tx_packets is > 0 .

Stop using the missing MIB counters on KSZ87xx .

Fixes: c6101dd7ffb8 ("net: dsa: ksz9477: move get_stats64 to ksz_common.c")
Signed-off-by: Marek Vasut <marek.vasut@mailbox.org>
---
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Tristram Ha <tristram.ha@microchip.com>
Cc: UNGLinuxDriver@microchip.com
Cc: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>
Cc: netdev@vger.kernel.org
---
 drivers/net/dsa/microchip/ksz_common.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 7292bfe2f7cac..9c01526779a6d 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2239,20 +2239,23 @@ void ksz_r_mib_stats64(struct ksz_device *dev, int port)
 	/* HW counters are counting bytes + FCS which is not acceptable
 	 * for rtnl_link_stats64 interface
 	 */
-	stats->rx_bytes = raw->rx_total - stats->rx_packets * ETH_FCS_LEN;
-	stats->tx_bytes = raw->tx_total - stats->tx_packets * ETH_FCS_LEN;
-
+	if (!ksz_is_ksz87xx(dev)) {
+		stats->rx_bytes = raw->rx_total - stats->rx_packets * ETH_FCS_LEN;
+		stats->tx_bytes = raw->tx_total - stats->tx_packets * ETH_FCS_LEN;
+	}
 	stats->rx_length_errors = raw->rx_undersize + raw->rx_fragments +
 		raw->rx_oversize;
 
 	stats->rx_crc_errors = raw->rx_crc_err;
 	stats->rx_frame_errors = raw->rx_align_err;
-	stats->rx_dropped = raw->rx_discards;
+	if (!ksz_is_ksz87xx(dev))
+		stats->rx_dropped = raw->rx_discards;
 	stats->rx_errors = stats->rx_length_errors + stats->rx_crc_errors +
 		stats->rx_frame_errors  + stats->rx_dropped;
 
 	stats->tx_window_errors = raw->tx_late_col;
-	stats->tx_fifo_errors = raw->tx_discards;
+	if (!ksz_is_ksz87xx(dev))
+		stats->tx_fifo_errors = raw->tx_discards;
 	stats->tx_aborted_errors = raw->tx_exc_col;
 	stats->tx_errors = stats->tx_window_errors + stats->tx_fifo_errors +
 		stats->tx_aborted_errors;
-- 
2.47.2


