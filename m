Return-Path: <netdev+bounces-113371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71DB993DF54
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 14:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A35201C20BA8
	for <lists+netdev@lfdr.de>; Sat, 27 Jul 2024 12:31:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DC88062A;
	Sat, 27 Jul 2024 12:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mvXjV80+"
X-Original-To: netdev@vger.kernel.org
Received: from msa.smtpout.orange.fr (out-72.smtpout.orange.fr [193.252.22.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78F774077;
	Sat, 27 Jul 2024 12:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722083472; cv=none; b=T1zU+NAEDkDZ8rO0/fXwPdauIdVKKwre4hdCMIyBhwN87tc12onsqGG92K0wDTWMJ7D2izLaF5kUbpMB0eRQ5SDHq7pj+veG+z8FGy3Ae6at+tj9O/i/k3nozyf5C6laF/tW938eJB7pIUFjkMOhgUyxJgGTOZGbO3nHiuRiZzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722083472; c=relaxed/simple;
	bh=1kNgpcLGOMfFCKwWAt+UIHH/gXHM2fdPPDKSeY3x5Iw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fn487asR/rLYyMtmm4cbspobPP3CBtg4COb7TkWCmaBFDq2NpOW9rtTNaAfrhbvLHkhGeMN8lkgG+qsxSajMh73asPOnG06fFFxU1hwtbJBlMLUIn9gEmLROn+/rGc0SSi0Oqh6eudQGhsO450QLnzf91h4GxUnoBDF3U6FNY6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=mvXjV80+; arc=none smtp.client-ip=193.252.22.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from fedora.home ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id XgZdsQvW5GdLxXgZdsD4Lu; Sat, 27 Jul 2024 14:30:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1722083458;
	bh=pvdNf+vZIbOx3trn9NLOsntkBxMgNRCPD6bdIvwUm1Y=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=mvXjV80+XrzFQL5a8yjKmW6S8vcBYhx5Vm/LAkl6TDEFCU3Mgv2ZKFfS/2QoYVkCl
	 ND4wj1GTqhaTrsGXo+IxEAZe1BSOFYmA1Wrh6yigNL3OLmVlQtQD/3wbWdAcgjqxR6
	 QAJS2t/h913/HMRAIKMIdfotdEMlXAMfuqRW75Q+xjP1GgiygOYMx931c+kswHVXf3
	 Dg59hxoKSXFObINpZW0KNV0ja4Y4AMidFvG+jZyO0u+GqPJ/STy42qSKIctYP5UiF1
	 DfyURCNEZyh5TxcuOK0V7mbEADt62W5luuxux3XUC+k4K2mO4IbrYQD4jZDCFLR4bn
	 sk7qiEl0tuIAQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 27 Jul 2024 14:30:58 +0200
X-ME-IP: 90.11.132.44
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: David.Laight@ACULAB.COM,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	netdev@vger.kernel.org
Subject: [PATCH net-next] tcp: Use clamp() in htcp_alpha_update()
Date: Sat, 27 Jul 2024 14:30:45 +0200
Message-ID: <22c2e12d7a09202cc31a729fd29c0f2095ea34b7.1722083270.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using clamp instead of min(max()) is easier to read and it matches even
better the comment just above it.

It also reduces the size of the preprocessed files by ~ 36 ko.
(see [1] for a discussion about it)

$ ls -l net/ipv4/tcp_htcp*.i
 5871593 27 juil. 10:19 net/ipv4/tcp_htcp.old.i
 5835319 27 juil. 10:21 net/ipv4/tcp_htcp.new.i

[1]: https://lore.kernel.org/all/23bdb6fc8d884ceebeb6e8b8653b8cfe@AcuMS.aculab.com/

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 net/ipv4/tcp_htcp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/tcp_htcp.c b/net/ipv4/tcp_htcp.c
index 52b1f2665dfa..81b96331b2bb 100644
--- a/net/ipv4/tcp_htcp.c
+++ b/net/ipv4/tcp_htcp.c
@@ -185,7 +185,7 @@ static inline void htcp_alpha_update(struct htcp *ca)
 		u32 scale = (HZ << 3) / (10 * minRTT);
 
 		/* clamping ratio to interval [0.5,10]<<3 */
-		scale = min(max(scale, 1U << 2), 10U << 3);
+		scale = clamp(scale, 1U << 2, 10U << 3);
 		factor = (factor << 3) / scale;
 		if (!factor)
 			factor = 1;
-- 
2.45.2


