Return-Path: <netdev+bounces-164605-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC4F0A2E776
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 10:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C73E166819
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 09:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68F8A1B6D15;
	Mon, 10 Feb 2025 09:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GNvY3PqR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SJY9C6Ea"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D492E18CC1D
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 09:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739179182; cv=none; b=BdI+pCj61tlVbN6S/jpdTjZ0F9m3yKnYKCvNrLnZbBdVg+7aU6Bb7bPu5cOatzVLMTb55fFZG76ONJv6Nkwn/K58OQpztC6NxGtZK7p7Z6TyAuLG0lM4zQmQN0dknveeWf6AKqftoaABqKoTJipHekl1FMneyqaPQr4anIyVwYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739179182; c=relaxed/simple;
	bh=F2p1ou/0AZv/PcbfHKVSZ8R2rxDMMGbcUOBFLhTwoJM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HQcK+YRW4zUkQzP9dvuEAY5Qd9L+FYamrwfGMytRLZSYgqyAL9Km95ZSybEN/xKl6lvLZhVz7NkravaF40hYJM1Se3s/8HJujpS4u1nATbxiQyYbtHI6LWTVSUYinXtQOzp7brEIZ0qeTDV5CErlXgvVfpeo87v9/iRWxsI/y6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GNvY3PqR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SJY9C6Ea; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739179178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JkT/vU1zpbrf6oZbGOWeLDS5qg6c+tSDS6gec3w7LM=;
	b=GNvY3PqRQJdMDpy8MZT/0WrDZprpJ6y6jktMscLRYEGjWM7zIGYRjF2cBHiRGp6qD4yruD
	kjMp8WINzffTu2m7PYvGjjS2CdQsBjfFfquafG1ralrm0hsJE/O0C3ACJ8HXO8adCP3c4L
	AsRM5UPknTbRdcxlAdFKhFoZlNYsxioNRW7LB0ragrrUaQHO96BgCzKP2gm/pUp7+UkHM/
	UJvSh7bdS2rQ+HG4NmuEiyVH4OAyt0PSoamjc5zNhqdAG6rQnnnglKC9f1rotjvS0LFNDP
	wkn2rAS2RWD/lQGr9EfmWSU/xY84yZsKt52Bwv6ZbcLrON4ryMCfKH3LudGV1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739179178;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7JkT/vU1zpbrf6oZbGOWeLDS5qg6c+tSDS6gec3w7LM=;
	b=SJY9C6Ea3o3P54PGX+qMXJd1milifVdLaGhKvp59pN/Nkv7mGMBRKAd+dmhTC2DkMuTvkV
	w+N2GrfkPyk5HaBg==
Date: Mon, 10 Feb 2025 10:19:35 +0100
Subject: [PATCH 1/3] igb: Link IRQs to NAPI instances
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250210-igb_irq-v1-1-bde078cdb9df@linutronix.de>
References: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>
In-Reply-To: <20250210-igb_irq-v1-0-bde078cdb9df@linutronix.de>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Joe Damato <jdamato@fastly.com>, intel-wired-lan@lists.osuosl.org, 
 netdev@vger.kernel.org, Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1966; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=F2p1ou/0AZv/PcbfHKVSZ8R2rxDMMGbcUOBFLhTwoJM=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBnqcSoRQ1vVIRYPr5dIdQOzLyrgzcd0/yzueF1p
 u5qsDQ9tCGJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZ6nEqAAKCRDBk9HyqkZz
 glwcD/41sGbRzUy5VSMOm2bmD00F/sUcWmbRbFGp19eYq9TPUz8r4s4g9q66DvuHHobDnzjAvc3
 99ASA9Ls5izWcXl3jW26Si3/Bl9EvBYBc0HPit2N7QdkA9WMUUp5benWQe5JixWJGH3idBc2D1b
 bQmGNvVHVdYQomc2NhMniN77gDRjtPJCLJFv7kGT3m0vMBfSPLJau3a6wVDArSYCZJWuhGkMqnI
 w+mrYR+NpidrLflirvLbvJ+rDKzrTSRLcEsWeNIyFjEYJi5iKfPbKkHMq/qnUsY90WRF2YLt9E9
 c6T4Pr0i61W/Q69QmyIwX4RGZ71Z5ScqCrZC9aBjD443qOCgo+cMBwHusf9+K/f2ACgibgL/u+H
 YuLlwxVVbG0T2BxGCDBQ03oRt/FrwjQq5gASMa4iswQ3BPDTQiMM2V4CRPvtxvzpIfpGCCg8sQe
 1fCh/m8oViL7siTAjqrfmmp4rVngMocwz3OTbG+qiRqFOCOMDusK0QRjLbecgec2Eny/EEf022H
 Yyh59FtysK0hZv2jXZAiMcSrKBYYjiAgSn45/RhT/iL/njOTq0JChHSp5WCP2qUno6fu30EP25a
 YzJ351aWlJlNMM9TrQ7OXx0tVfHtap/3hSDJoJdo1zvyp3F5Dd/uTbbwYFLkjnRs4ds5OMrGx+c
 n5h6g/iXpIsuqTQ==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Link IRQs to NAPI instances via netdev-genl API. This allows users to query
that information via netlink:

|$ ./tools/net/ynl/pyynl/cli.py --spec Documentation/netlink/specs/netdev.yaml \
|                               --dump napi-get --json='{"ifindex": 2}'
|[{'defer-hard-irqs': 0,
|  'gro-flush-timeout': 0,
|  'id': 8204,
|  'ifindex': 2,
|  'irq': 127,
|  'irq-suspend-timeout': 0},
| {'defer-hard-irqs': 0,
|  'gro-flush-timeout': 0,
|  'id': 8203,
|  'ifindex': 2,
|  'irq': 126,
|  'irq-suspend-timeout': 0},
| {'defer-hard-irqs': 0,
|  'gro-flush-timeout': 0,
|  'id': 8202,
|  'ifindex': 2,
|  'irq': 125,
|  'irq-suspend-timeout': 0},
| {'defer-hard-irqs': 0,
|  'gro-flush-timeout': 0,
|  'id': 8201,
|  'ifindex': 2,
|  'irq': 124,
|  'irq-suspend-timeout': 0}]
|$ cat /proc/interrupts | grep enp2s0
|123:          0          1 IR-PCI-MSIX-0000:02:00.0   0-edge      enp2s0
|124:          0          7 IR-PCI-MSIX-0000:02:00.0   1-edge      enp2s0-TxRx-0
|125:          0          0 IR-PCI-MSIX-0000:02:00.0   2-edge      enp2s0-TxRx-1
|126:          0          5 IR-PCI-MSIX-0000:02:00.0   3-edge      enp2s0-TxRx-2
|127:          0          0 IR-PCI-MSIX-0000:02:00.0   4-edge      enp2s0-TxRx-3

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index d368b753a4675d01b5dfa50dee4cd218e6a5e14b..d4128d19cc08f62f95682069bb5ed9b8bbbf10cb 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -947,6 +947,9 @@ static int igb_request_msix(struct igb_adapter *adapter)
 				  q_vector);
 		if (err)
 			goto err_free;
+
+		netif_napi_set_irq(&q_vector->napi,
+				   adapter->msix_entries[vector].vector);
 	}
 
 	igb_configure_msix(adapter);

-- 
2.39.5


