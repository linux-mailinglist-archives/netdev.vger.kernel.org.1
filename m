Return-Path: <netdev+bounces-269069-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YHyaGnDBumkGbgIAu9opvQ
	(envelope-from <netdev+bounces-269069-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:14:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A022BDFB1
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 16:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DEC1A3030E9F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 15:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12533ED138;
	Wed, 18 Mar 2026 15:03:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F7383EB810
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773846209; cv=none; b=F/cOzrvxkV662yIsHlB3+RYgqYZg8UFvOAlh7mk0PMGylQvC4icSDDe6RBNwlL3pDnj3imAfuymhv5+sJqzFU9A9q6UaU3VHe4opLZ8INdcES5nHcXgHEpWjixSaqB9WdLCRg6G10glmCyPe0V/QpV6+IfJEiGjOBj2VfV458A4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773846209; c=relaxed/simple;
	bh=5NcsxaHVIQ2NmCj9OLQh+nSLlXz0JVUjSv0mBYVb1MM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m+YJosUXXQ2WMnT7UCEE2dWBGKe/AcmaRJtKJG8eybydD5JPJiSxdSO14HgZo/2J3cd12RrYosGJLQv07QN+MVHS/Q0IzPXSxYHpfJ+aKjY72p5gRoyLPx5LORDR/4KoNoDDhQhPHLL4tBHkwUJCvQpXE8/7i8Jbrt15lH/YZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-126ea4e9694so2428614c88.1
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 08:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773846206; x=1774451006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HbyBRqP1dM0VO6fEJ4blZH7JfwL0DV5fAiX12aFZ5no=;
        b=l3V0Il8y/xtnIjA1Uefb+SU0CWTgZNLpv2hUuAVK0CFPp5kECaGhH8eAuI9V1M4IQD
         3jetYk4O2JKGX/IriHBWpCiHhspbfp4QJRTE2vq2sh6QpeZmWFyM5mkvYx0Gn/x9vR/f
         qt+xycVxgwXyTk/G+sLiIzjPXOgOFMueX2n7g797dNr9BGsLM6qtoWitWUNCekwK8Ofe
         pkzsppum57KK1wNCY/iSi/Y/ljpRFtwHWjgkkjfzVbi0hwzYD6qMhQEmSm/aiubkJf8k
         DwOxW1hsaTMKDeKrC0JBSytSucoa4eCUH0m35mv3cKUaAHw/dtGytA3Xm0hmlkOgUqC+
         IIyg==
X-Gm-Message-State: AOJu0Yw/snkDo8ulfXXhayA599Zbw/q/6uOCOrvfIuVW2jsCibwtnXni
	zWYrsbYiDP0k47x9raQmiftMMysg/Ajy+jn6CqnyC8R7Sz+szyNntgnur7aw
X-Gm-Gg: ATEYQzyzMW8+d1zJtnlr6K5gBi3ZXjfYRQDAwyi5aWF9+ulPRX+9bzXXqm+VbRi2Xfo
	eSAkSpn9xlV49KzvQnoAUndXasyP+fr8bU8xyhA6ZL97JYYoz3xmYF5P/jgT+TCMIvu5ND28qFk
	lVduTaof9LRwhgf7ck38VFbX5WJaoIi06h694zdOr5w1cPjoSqVgo9gM9WKVyg5QoeR47naJeuc
	sP8m0UGgPVS0DRT0TbjzJLckkfdBG1qG5Rh7CAgjrvjRELxRC13ltti2yqy5Ic+5MzJ9mqgK7mX
	/8NaajnBjatOfJwwDW/1paQbQKvRNYbCP6aZ4EWhEW9yozY16OJ4cpNiRoHwNLJEOv/Fte+AmE2
	U3EdeRxiqmkHPCIzcx3UNUJhBFFj0ScYy7Fv15dl6gDVqsCjzvQ+YVW60fXjju7pmYxwGPoImwl
	d/0Xbet6vGHu0gcftN5dn68zOhc2GtTo3ZY6jvO2MKiz4gRvEFne8x2NRjBAciOklm0XgFPPcJY
	Hwo9Qq0A6bgT+7j6A==
X-Received: by 2002:a05:7022:b9f:b0:128:d51a:5161 with SMTP id a92af1059eb24-129a715e828mr2027441c88.27.1773846205882;
        Wed, 18 Mar 2026 08:03:25 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-129b41271aasm3384562c88.11.2026.03.18.08.03.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 08:03:25 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	alexanderduyck@fb.com,
	kernel-team@meta.com,
	johannes@sipsolutions.net,
	sd@queasysnail.net,
	jianbol@nvidia.com,
	dtatulea@nvidia.com,
	sdf@fomichev.me,
	mohsin.bashr@gmail.com,
	jacob.e.keller@intel.com,
	willemb@google.com,
	skhawaja@google.com,
	bestswngs@gmail.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net-next v2 11/13] dummy: convert to ndo_set_rx_mode_async
Date: Wed, 18 Mar 2026 08:03:03 -0700
Message-ID: <20260318150305.123900-12-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318150305.123900-1-sdf@fomichev.me>
References: <20260318150305.123900-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269069-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DMARC_NA(0.00)[fomichev.me];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lwn.net,linuxfoundation.org,lunn.ch,broadcom.com,intel.com,nvidia.com,fb.com,meta.com,sipsolutions.net,queasysnail.net,fomichev.me,gmail.com,vger.kernel.org,lists.osuosl.org];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[sdf@fomichev.me,netdev@vger.kernel.org];
	NEURAL_SPAM(0.00)[0.027];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[35];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,fomichev.me:email,fomichev.me:mid]
X-Rspamd-Queue-Id: B8A022BDFB1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert dummy driver from ndo_set_rx_mode to ndo_set_rx_mode_async.
The dummy driver's set_multicast_list is a no-op, so the conversion
is straightforward: update the signature and the ops assignment.

Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
---
 drivers/net/dummy.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dummy.c b/drivers/net/dummy.c
index d6bdad4baadd..f8a4eb365c3d 100644
--- a/drivers/net/dummy.c
+++ b/drivers/net/dummy.c
@@ -47,7 +47,9 @@
 static int numdummies = 1;
 
 /* fake multicast ability */
-static void set_multicast_list(struct net_device *dev)
+static void set_multicast_list(struct net_device *dev,
+			       struct netdev_hw_addr_list *uc,
+			       struct netdev_hw_addr_list *mc)
 {
 }
 
@@ -87,7 +89,7 @@ static const struct net_device_ops dummy_netdev_ops = {
 	.ndo_init		= dummy_dev_init,
 	.ndo_start_xmit		= dummy_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
-	.ndo_set_rx_mode	= set_multicast_list,
+	.ndo_set_rx_mode_async	= set_multicast_list,
 	.ndo_set_mac_address	= eth_mac_addr,
 	.ndo_get_stats64	= dummy_get_stats64,
 	.ndo_change_carrier	= dummy_change_carrier,
-- 
2.53.0


