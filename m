Return-Path: <netdev+bounces-170397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CCE8A48825
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 19:49:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 209BB3A4671
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8DB1DB951;
	Thu, 27 Feb 2025 18:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b="b5RLBkla"
X-Original-To: netdev@vger.kernel.org
Received: from ksmg01.maxima.ru (ksmg01.maxima.ru [81.200.124.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 214A118CC15;
	Thu, 27 Feb 2025 18:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.200.124.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740682156; cv=none; b=oGWR+lhgChp27wfREFqf4/kJHICpj64Sguq3w2spl+BpjXwZE3dQYgmgVXIVlsCnsP+vzuPcraAB82LzPBwzBK6O/FnyTQyFPWW2lKrT5e43HzLHn+Nm30UTzsW40KIqRGQQjLCBxmom+zexWEy5rUG6W0v6GrzJ+5lz37RTmEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740682156; c=relaxed/simple;
	bh=GP7F5y7w+kGu/rqgKexPi6wRjgXckuCo4h5O/xVjMwI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VS/pbzpcKBPjuIAS0nhjRoUmTTJlB4NLN29qIOPJ3ZMXVTPqh6nTJ2h6hJwK7+0itUKM0pnB9WXSovjO01C5IhMqUOcsKxpjvI2ye453Zx9IovEC8RSN+PgeQJ7vpRwXXqGcE1ZSleTPXz4cy0rY7vqJo230deSEP7LFBd24kH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru; spf=pass smtp.mailfrom=mt-integration.ru; dkim=pass (2048-bit key) header.d=mt-integration.ru header.i=@mt-integration.ru header.b=b5RLBkla; arc=none smtp.client-ip=81.200.124.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mt-integration.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mt-integration.ru
Received: from ksmg01.maxima.ru (localhost [127.0.0.1])
	by ksmg01.maxima.ru (Postfix) with ESMTP id CF7E5C0015;
	Thu, 27 Feb 2025 21:49:02 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 ksmg01.maxima.ru CF7E5C0015
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mt-integration.ru;
	s=sl; t=1740682142; bh=PzAwn6aI8D4wUfpWcy4C4+Z60jtIAMMhJRHTKaUDOI4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
	b=b5RLBklaQwEc6E3j5nmFJKJUbWwEaxQ3NghzfadpkPqmHKMTSb7O+4zlQFcmWeprY
	 iUOB1uLkbgs3FxWDUQ6sg+sAlW6/KD65OE6O+phagxH2NBmwdVmuj2reVDSgNqBDsR
	 Q1GhBn3CK/YJPNmNDoxzhwWCUaCK2DiL3q4Ko4gmwAuUXl+phGrfLJB9jJQ91TCDCl
	 fC7rRciXpKvU/Z0/cqHaZ7Se3BSMevKVOBSNWe4nCqQX4ExROxXPMzC20oXohTMBWV
	 xCEPup+Rd+JZ57MXuzfBrNrL1AjDGwLSYRloFtjxmy6MNidS1hw9Q6brXYK3tt9ARY
	 HgxVdDGZMgLMQ==
Received: from ksmg01.maxima.ru (autodiscover.maxima.ru [81.200.124.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client CN "*.maxima.ru", Issuer "GlobalSign GCC R3 DV TLS CA 2020" (verified OK))
	by ksmg01.maxima.ru (Postfix) with ESMTPS;
	Thu, 27 Feb 2025 21:49:02 +0300 (MSK)
Received: from localhost.maximatelecom.ru (178.236.220.144) by
 mmail-p-exch01.mt.ru (81.200.124.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.4; Thu, 27 Feb 2025 21:49:00 +0300
From: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
To: Andrew Lunn <andrew+netdev@lunn.ch>
CC: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "Michael S. Tsirkin"
	<mst@redhat.com>, Jiri Pirko <jiri@resnulli.us>, Krzysztof Kozlowski
	<krzysztof.kozlowski@linaro.org>, Rusty Russell <rusty@rustcorp.com.au>,
	Erwan Yvin <erwan.yvin@stericsson.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] caif_virtio: fix wrong pointer check in cfv_probe()
Date: Thu, 27 Feb 2025 23:46:27 +0500
Message-ID: <20250227184716.4715-1-v.shevtsov@mt-integration.ru>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: mt-exch-01.mt.ru (91.220.120.210) To mmail-p-exch01.mt.ru
 (81.200.124.61)
X-KSMG-AntiPhishing: NotDetected
X-KSMG-AntiSpam-Auth: dmarc=none header.from=mt-integration.ru;spf=none smtp.mailfrom=mt-integration.ru;dkim=none
X-KSMG-AntiSpam-Envelope-From: v.shevtsov@mt-integration.ru
X-KSMG-AntiSpam-Info: LuaCore: 51 0.3.51 68896fb0083a027476849bf400a331a2d5d94398, {rep_avail}, {Tracking_from_domain_doesnt_match_to}, mt-integration.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;ksmg01.maxima.ru:7.1.1;127.0.0.199:7.1.2;81.200.124.61:7.1.2, FromAlignment: s, ApMailHostAddress: 81.200.124.61
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiSpam-Lua-Profiles: 191358 [Feb 27 2025]
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Version: 6.1.1.11
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.1.1.8310, bases: 2025/02/27 14:12:00 #27481496
X-KSMG-AntiVirus-Status: NotDetected, skipped
X-KSMG-LinksScanning: NotDetected
X-KSMG-Message-Action: skipped
X-KSMG-Rule-ID: 7

del_vqs() frees virtqueues, therefore cfv->vq_tx pointer should be checked
for NULL before calling it, not cfv->vdev. Also the current implementation
is redundant because the pointer cfv->vdev is dereferenced before it is
checked for NULL.

Fix this by checking cfv->vq_tx for NULL instead of cfv->vdev before
calling del_vqs().

Found by Linux Verification Center (linuxtesting.org) with Svace.

Fixes: 0d2e1a2926b1 ("caif_virtio: Introduce caif over virtio")
Signed-off-by: Vitaliy Shevtsov <v.shevtsov@mt-integration.ru>
---
 drivers/net/caif/caif_virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/caif/caif_virtio.c b/drivers/net/caif/caif_virtio.c
index 7fea00c7ca8a..c60386bf2d1a 100644
--- a/drivers/net/caif/caif_virtio.c
+++ b/drivers/net/caif/caif_virtio.c
@@ -745,7 +745,7 @@ static int cfv_probe(struct virtio_device *vdev)
 
 	if (cfv->vr_rx)
 		vdev->vringh_config->del_vrhs(cfv->vdev);
-	if (cfv->vdev)
+	if (cfv->vq_tx)
 		vdev->config->del_vqs(cfv->vdev);
 	free_netdev(netdev);
 	return err;
-- 
2.48.1


