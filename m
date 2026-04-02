Return-Path: <netdev+bounces-274734-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC2XApH0zmmzsAYAu9opvQ
	(envelope-from <netdev+bounces-274734-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:58:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B63F38EEDD
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:58:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 05B33302B38D
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEE93DBD4A;
	Thu,  2 Apr 2026 22:55:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3A83D75A2
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170553; cv=none; b=qqGaJVVUV1qB141FYPShPTX3qXatq1hL7gt1Glbh+/yyOAy6X4VHNm9X/yHqdkjL+dtj+SORqRWVp5r2TdNbpFaMfz/ob5KL1yKQkshK8CkHCGnxuPfnUul3ITWnCZqUxF9xRqdg3r9s1N/RfVwtV0yD26uFPJnvQIwSrl78H3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170553; c=relaxed/simple;
	bh=y6hg7ub34HMWu/fw/qIB0K0yq6pM+wYUJ36IGkXkqdk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCSpVbvgSEJTI6sUrvknw6kv1N4+7JxLc8EGe75VKfSZg100i2KTnlmWWT8RGGVngfV3tDqXs05KPtBPQ7AB+I0H+grLZJTSP6qF4gOnsl9e0sZ3a7ns19wiZj/nFz9M33/p/SbzHgSOBnnSLMuNGnilZIgMu8TN2Yv4rgCFrGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-127380532eeso4038470c88.1
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170549; x=1775775349;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IKaKyGA0Wx9Y5pw8lgVhOxcpdzf7rtgtzO9g3iOdE3I=;
        b=G8P3iGV2YlHyFB6bzC2rGkzKlH6Y7c52oMK74d6j++fg6Gaj6Jt7453vAaWRoO832E
         ppQD3h8l01a9gYc+rslcSkAK+33jeOQItRuzCxLv7sDnh7JQ+B8O3rKzOdT9NI/XFtOB
         tE+9urJtM4R3DG92MzhwIux5k0o1fSIZFV1I9lBby2JYCJ+Ec+xALUiSZ03q4FN9ICl6
         syfWKINPRdj2GT7S0r3L5vqZKemH7JaV6KGs283fgLzlrdbTv0ePFhxHURbkwTj3L+Lh
         71OUgE9qAIP4SiPutx0wyX3pXaw5e8qqHOZ+hb6Lx6ZXz681mql5qI14w9g/iyCTF8I8
         5fnw==
X-Gm-Message-State: AOJu0YyyJRjvrEJnb2UiUJlQnCYUATZfDFIZaWQTF1mDeRY4OyadKYPX
	zBz7V6Q6e2D/sCpdMJZZBNAa9ZHW51ig8E+gyoaspcwkne463nlzSnFJqTsj
X-Gm-Gg: ATEYQzxIu+UEMq72ca++BsQPzNv5KiE+dxrlYoJs2VeaVA7H+KaS3GVlWFh82jWyxWw
	ZDGoW2IMsprNtEv3/SsB6ZSxhiKTMz4b4hIkM1D8FmhTOoawdl9tijRvwe0vMD5qRiIpTCiEf0C
	X5xSYd9rjAuWmAReXvH6KEU1bZov5hIKmUo0Iuk6I1ZAtkVC0mbeHkKdECW25MiLw3OEAbj+7Lw
	blX8WIxScMTC/fbQduyfRje5efqpaU8UkkcPo8bTyVOQG4xAfeIrutuijWQS68bv0m8Mm7hy1GX
	BXN2MNPykKnbRzVFeQz05EuOllEjGkkvzLXlQQH+bW2vDt8LCrO++Un4Ju4fQHMhlKBdaE3ZDDB
	/qCIyjwnuXr+Byxvr21+1muLAsS3YCRQ6iOmZZ3hfyEGPhGdM7O4DStztYoTwhsG3GYxi3OB3jv
	/KO0PFlNDKM3uOOVqh7DWCAdM5II/VCSoS7XZ0iCRZSGgum1QVCUJLerB4rvAmrEjZ/WT57g+kO
	YyoggFIc4QnZQEZnZUMWJ+qyQKm
X-Received: by 2002:a05:7022:e02:b0:12a:68cc:3f08 with SMTP id a92af1059eb24-12bfb6e9821mr421502c88.8.1775170549129;
        Thu, 02 Apr 2026 15:55:49 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12bedd70f18sm3248759c88.6.2026.04.02.15.55.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:55:48 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v5 12/14] net: warn ops-locked drivers still using ndo_set_rx_mode
Date: Thu,  2 Apr 2026 15:55:33 -0700
Message-ID: <20260402225535.4124525-13-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402225535.4124525-1-sdf@fomichev.me>
References: <20260402225535.4124525-1-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-274734-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[fomichev.me:email,fomichev.me:mid,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B63F38EEDD
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


