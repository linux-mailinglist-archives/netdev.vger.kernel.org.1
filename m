Return-Path: <netdev+bounces-274735-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MIw6Dq70zmmzsAYAu9opvQ
	(envelope-from <netdev+bounces-274735-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:58:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A1D38EEFA
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 00:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E891B30499A2
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 22:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505873D6478;
	Thu,  2 Apr 2026 22:55:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5913839FCB6
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 22:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775170554; cv=none; b=ryNIGGTd/whm7oEa1FBVeDn7D/qGl4p9O8h6rlatR6Z897Vu+TzmMnFY9VBDC41B0ME3Ifwwt8Cdx2TT2Urydq2WMO7zk5i7xsN+QReNZdLkjf+wYbS9+olq8GeHomF2GacIJLNulpUAd4yXuGvkufKgV4sarpwz6HGQUnxgl+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775170554; c=relaxed/simple;
	bh=sq51Mii20F8uVXKJ8Rmvg3VjlqX4JzUqO+SzwSaxzlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=boHUA6STif3qH4KC+6C61tRdXH+ceBtuAgQzRUVguEtTt03ZCTD3F/9rba3gfbclz++NR/UJh8QnMTo0G3OgovlldivsSuG9NowGc3YRTt5TFXI+MM557Eq6SOyKReYAeF0pUMHNwsHwyQACvBIU4pswLMDIHARPmuIoqZRkXek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-12bfa7fe691so573479c88.0
        for <netdev@vger.kernel.org>; Thu, 02 Apr 2026 15:55:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775170548; x=1775775348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z7kOas3SlEcS2WTH3lhdKOGfzUP63bu0wXRmUC1Kb2I=;
        b=KzpIhTOmyONOtYEwLq1klsddkGIROd7cW6Ewv6ctiBD7w/mgAmWSY7LTLprCJrd60x
         XmBK1tNuK0p32SzFfB4vPH0c/eNL2cafbbO20hs2IB0J4RXbZN/sDbLUGl4Yl+y3fJRV
         6KHGkuqRE3QhKoibqbcCQnw+yXaAlHzvXHuqHLNlMIcHOsNGOnu5ArpEigKclo2FCqsj
         HQ7s5n/IIV+KdZcJdL884NZMtCYPB2mPmFngAZxFvrxqcNGvrebtrUZx42KbmsMxUhyt
         /tORctKmLNQFUWruFp58aGX4BoKsywBnGyMHIdkFaGslbK580UAEIpmhSs7O9QtsgRnH
         MIkg==
X-Gm-Message-State: AOJu0YzyM/IDiG1tCnWKps+O+qV5bn/oY01MOz7XXbN5uRxVaAGaFhKN
	tEGmqpJ5EJIQcc0hbOSKDexcMfIfvi8L76sz70mTbz2q6HPQfaDj7+UQltTO
X-Gm-Gg: AeBDietdyHqBEDI7rnQVruC93Ybl17gjN3EzoJAxrh7u5GXAfvwVXTiDKI0Ph0UhChz
	48DulhMN91AwCc/9LYduSOk61Sfq140NzEoX65F9NHE6Uga6+6DER2c2WnKRVJnoNrtpCqnaYeP
	YesLA1hIh7Q4be7OrD/z4itH1gh3siksujr47QuavWo0BVT5eH1MzpYsr63lRxRuIXkpcFw3b1h
	9PAgueIfjqzPLg2Cem3V/mmeGZlLgi2aV7SV+lP2URKk6NANkrVZMqm5xk6pR6qDPXH/OOFM7Yn
	hiYLrheXNZCp4PSa8i2pxWxjkKQ95RanNst4y470rijK436eSidf5kK7do7AB7QYw+Iz2aYY76+
	QEi5bbATEid4DUbr1DPUc0q4kJRu0QiAP6qOXNYHKzheUKXtNZAqDgdInbMEfzrAjFowWA0KUYb
	00fc6b+JqsW6oAsC3Ew8L7Q1Oa5/3qqSjQp6ADitbNvoetXCvsBp5k0nzu4cZ12gJWrA9BqNdGO
	Xg7MNkDTwIuYiV96Q==
X-Received: by 2002:a05:7301:4090:b0:2c8:6361:ab58 with SMTP id 5a478bee46e88-2cbfaaaaf92mr554357eec.13.1775170548130;
        Thu, 02 Apr 2026 15:55:48 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2cb92ea0ef1sm1534008eec.21.2026.04.02.15.55.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2026 15:55:47 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v5 11/14] dummy: convert to ndo_set_rx_mode_async
Date: Thu,  2 Apr 2026 15:55:32 -0700
Message-ID: <20260402225535.4124525-12-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-274735-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,fomichev.me:email,fomichev.me:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 72A1D38EEFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Convert dummy driver from ndo_set_rx_mode to ndo_set_rx_mode_async.
The dummy driver's set_multicast_list is a no-op, so the conversion
is straightforward: update the signature and the ops assignment.

Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
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


