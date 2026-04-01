Return-Path: <netdev+bounces-273818-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKt1OdFyzGn1SwYAu9opvQ
	(envelope-from <netdev+bounces-273818-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:20:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0A53736E9
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 03:20:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D14B43045907
	for <lists+netdev@lfdr.de>; Wed,  1 Apr 2026 01:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B502C15BB;
	Wed,  1 Apr 2026 01:19:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4020728CF5F
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 01:19:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775006369; cv=none; b=ZLXgKkzDtHHhmE0jaywDg6RpeumLlIY/dhhkCUVccrIw0aIYeKqsWY+WXRcgmHPZpdRc+IDzZVwszh9t0v5uwQkxzLwK7zh+rNm4Mx11A3hFWgqs9GB7ybi3wNSTDIdo0R3K4QX4ek7pZEc2nA1RWs0xs/KLBYWvNDx6M117dcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775006369; c=relaxed/simple;
	bh=sq51Mii20F8uVXKJ8Rmvg3VjlqX4JzUqO+SzwSaxzlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UYAxMnAczwgnPfpNaz9r+rybIEwQnIzsERug+RS6A3Ps6ZVEK6heRthxChz/6V/fQvA88Cj/ekbGpoiniyflTJ2CZDXJUWlVu+8lEgFgAfhVzOlmFXYnwDhiQjPQjBhH4zjUG64y9R1hDmENh0oJ6OE6sRYL1gig+6xoHvZFQhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fomichev.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-12a71ade78cso7580410c88.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 18:19:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775006367; x=1775611167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z7kOas3SlEcS2WTH3lhdKOGfzUP63bu0wXRmUC1Kb2I=;
        b=BIY3gxpkVwG/EMRuuvCpNS6ID3WXITy0J1FMz2EubA94FnVukDtvZP9k6sgPgzAn80
         t1vYx9HKLPkalAvT7v12dQ7Y67JA7RDCNtwpMw5/mfL6OoKtEiYZxY5wfAO9Orb9xPHV
         LtF/BkB5ZbKNM576Ma5BJ19ljxRAMUMBZ7Cg7AUMWE0+BLuo2zgoELDRqjCVsr5/imDJ
         8iGnCWU/0KEHKnNL6TJwjBFP6ma5MHJxaOcv8P8BM4kfGuyHxVBHpreyCBiIehl0ALw/
         4XDZzNErZ985fZnAkMvRfnTxL/EfAz87TxoMdoTjQHh4fukI6zyfmoeuewi+8tt+oHJZ
         pMBg==
X-Gm-Message-State: AOJu0YzUJam3woTW0SIpwy2VqrmA02xj3wGOOl+8PKYm3JL/5/fFPu5t
	fYMXcmGW/qqJIRDkNkKIa2MGINslAQlThHAOCmhg8zWdlMErC1i4ptuaN0d8
X-Gm-Gg: ATEYQzwoo6RsUcUFqWQzXmkqlY7uNDr71cUMzlGYKXLOd4c5ibfa3DX7nMowGFT3/Sf
	QlrFJinBmoaKMSYoMmipYQYhv2UEuy3ezG6+AQ4RflzhDSQbd4TKriG+RAHk04lAbs1gC9HmnYd
	SO0H43sTL8UxGmSnP4sFGdNzFI8g6ScqmzVMxwR4xZOdeHA0RxYfJdO84vvFyqhHXyvIdGEMaGN
	IpsXsDIwcxs9nbb4Mo15PM6veYr+U6Rp5+7nk3ovZTQg2twqnxbrFFvtmPivBlhWE+TrM37hXRF
	jeY/C4YVtkotDgOvebrl3VUCaZHAfSCYUWGx6V7U4nVvvlAy3r67dJ/kjQIf6NKwB+Setnrxaco
	EZ5mbc0diRw39i0LsPOEN0viKqIn8lnRPvmWd6A9B31eVSP84S/5eH3RvYe5154nKXFVdVSXh43
	+9USrVgQ5E+KVRk2qJNCz0ZmjApsFLcHMHFRENBLFmnO6Bt1yNVqgZ5bY9lf8Q84qa5a6W/DZ2b
	QRKm2rhywtoCjbGAQ==
X-Received: by 2002:a05:7022:2395:b0:128:d23d:81a7 with SMTP id a92af1059eb24-12be645df13mr1109244c88.6.1775006367319;
        Tue, 31 Mar 2026 18:19:27 -0700 (PDT)
Received: from localhost (c-76-102-12-149.hsd1.ca.comcast.net. [76.102.12.149])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2c3c68b272esm11317231eec.15.2026.03.31.18.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 18:19:26 -0700 (PDT)
From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net-next v4 11/14] dummy: convert to ndo_set_rx_mode_async
Date: Tue, 31 Mar 2026 18:19:11 -0700
Message-ID: <20260401011914.1716692-12-sdf@fomichev.me>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-273818-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.968];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,fomichev.me:email,fomichev.me:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D0A53736E9
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


