Return-Path: <netdev+bounces-273819-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLfrDpFzzGn1SwYAu9opvQ
	(envelope-from <netdev+bounces-273819-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:23:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF66373766
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:23:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1999630DA7EC
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5C9C2C375E;
	Wed,  1 Apr 2026 01:19:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F41B2980A8
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 01:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006370; cv=none; b=sAL0O3iAejShwT08NIx4Fx5wETGVjHgAD7qn2LSUH5Nt9TbUstmhikmWbvkeBZGvySM+CDAGHbKQShOxpkauC0WoAEj1+3YlGEgzJ2c6hpT9pUYmRhrVEq6JjsxEhICJyVa2kyxmX7vjdJeAxYpVAcka6P2oHzw07GrLzq6Zzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006370; c=relaxed/simple;
	bh=y6hg7ub34HMWu/fw/qIB0K0yq6pM+wYUJ36IGkXkqdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YUBZmeEueI5Em91ThggY1Turqgk4E2/jaVpFKRO51gwtmj5zwP6QZEg/YmLk7n5cTPk5p2EHMOU75OdLvIhUGRlvbH2ofOIEoPCym7+zJhnGEJNR0i3bGGMa8vBSVXH3o+/rmaCMNHXPwMSYIzvLCSMKbdED7SV1MA4K6dOtG7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-126ea4b77adso9059176c88.1
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:19:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775006369; x=1775611169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IKaKyGA0Wx9Y5pw8lgVhOxcpdzf7rtgtzO9g3iOdE3I=;
        b=Z9ucLNd3DjIh8ESDAhVsaoy7b1kjazdRRwda8TsLWOnzFPphDjQ2h+A+d0UKe1BOI4
         uf8fK6njk2mmT5e3l6NkhBtqvpCZ8T2MnYnnoO16Aog0jH/zWqHuLAPdUWCjkMT1piL4
         hU+GSjqa7gTqW/ZPIc5V5kyPLzNE45gGStsu+/RswqUeBuhlwJuJWYQGrv28qelp+ptt
         Z+oxf5yu2VagmseZAEYgWy9+wJaYr5HkQaEu/oi9m5F+p3OMmy/g9wkVj8LmLYA4onFU
         MkaPsDe9xArXLrQy1E63+dB1ar8TqMkcVQ1LR+lSpV5rAo6ynfqbWqUD1N9RFIOhhG3z
         LQRQ==
X-Gm-Message-State: AOJu0YzYeUWjeKijkYZFhawxZxkmBp34n+YwScnSOfLFC7E75+jGCc8+
	6RHQq/ceRFZV/Hpvr0P0yoUt4u7TwtFDAsUxTxeqf7gi+R4a5mtgyPeX00yr
X-Gm-Gg: ATEYQzzRpmckuSbBEBhC12VzP4xPJyafAL7IB0aXsbCUPQM4n4GBiGDmIvG2Tq8STq2
	z69W3Jzahl2FztVoxoDjiIG3nbjmQp+VZgtU0oe807mnVrKeF+QiQm8W9484lla7h72ExBA4XcG
	r4eZ/pcRPjIAkAy0iVWduR9Gag39DgPN6ycSxs8S3MQka9P6ccFszt84qKVnVb+0QLOjMNiJOSr
	whwId95xhShXL8OwephSOKsyv+wqYtkBMi1ex20bJACnJ9fpyk+w48QuydacX0BBCuPVutc40KP
	1QGS/+NPnsTlkwsZ9XDv/rfNlpPhKwgi++0NEIAduf+Cqva7dUXbhq5pWvLW6jOMvSv1MRWdkoo
	1EDgkONhCZ5sNnDaJtEoLMJBY6bM+4qn0yujwUnqaUBzkjrrcQ2bROzFULh6jQQWoBdtUX3AJQx
	NdWc++wMjZlwxHCbxpuEjFjnY5E+9w+E3wlpz21oYcbecdj0e+dhIq8EsWM/BUvcNZ6XfsAVZ/w
	DDjejfK6L/2zlUgqA==
X-Received: by 2002:a05:7022:62b:b0:128:d084:e921 with SMTP id a92af1059eb24-12be647837cmr904485c88.14.1775006368382;
        Tue, 31 Mar 2026 18:19:28 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12ab983f9f3sm17859972c88.10.2026.03.31.18.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 18:19:28 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v4 12/14] net: warn ops-locked drivers still using ndo_set_rx_mode
Date: Tue, 31 Mar 2026 18:19:12 -0700
Message-ID: <20260401011914.1716692-13-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260401011914.1716692-1-sdf@fomichev.me>
References: <20260401011914.1716692-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-273819-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,fomichev.me:email,fomichev.me:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9EF66373766
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Now that all in-tree ops-locked drivers have been converted to
ndo_set_rx_mode_async, add a warning in register_netdevice to catch
any remaining or newly added drivers that use ndo_set_rx_mode with
ops locking. This ensures future driver authors are guided toward
the async path.

Also route ops-locked devices through netdev_rx_mode_work even if they
lack rx_mode NDOs, to ensure netdev_ops_assert_locked() does not fire
on the legacy path where only RTNL is held.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 net/core/dev.c            | 5 +++++
 net/core/dev_addr_lists.c | 3 ++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 3ddf347dcdd7..89e31b1187a9 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -11341,6 +11341,11 @@ int register_netdevice(struct net_device *dev)
 		goto err_uninit;
 	}
 
+	if (netdev_need_ops_lock(dev) &&
+	    dev->netdev_ops->ndo_set_rx_mode &&
+	    !dev->netdev_ops->ndo_set_rx_mode_async)
+		netdev_WARN(dev, "ops-locked drivers should use ndo_set_rx_mode_async\n");
+
 	ret = netdev_do_alloc_pcpu_stats(dev);
 	if (ret)
 		goto err_uninit;
diff --git a/net/core/dev_addr_lists.c b/net/core/dev_addr_lists.c
index 2cff791ce374..e2d1d671ea56 100644
--- a/net/core/dev_addr_lists.c
+++ b/net/core/dev_addr_lists.c
@@ -1365,7 +1365,8 @@ void __dev_set_rx_mode(struct net_device *dev)
 	if (!netif_device_present(dev))
 		return;
 
-	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags) {
+	if (ops->ndo_set_rx_mode_async || ops->ndo_change_rx_flags ||
+	    netdev_need_ops_lock(dev)) {
 		netif_rx_mode_queue(dev);
 		return;
 	}
-- 
2.53.0


