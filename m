Return-Path: <netdev+bounces-259382-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yvB/HKtflmkZegIAu9opvQ
	(envelope-from <netdev+bounces-259382-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 01:56:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B53615B448
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 01:56:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 027FC301F796
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 00:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62AA723BD1D;
	Thu, 19 Feb 2026 00:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S/w/Jay/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24C1F4CB3
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 00:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771462567; cv=none; b=g38F44Wt9vTGaWu2WsIJg3WEmWyiRSqGxg02fD/vBDRjgBcB3q4qyzTTNpzO8P2JElKl93qM5lrJA6zo5FQ8vht9jZinhTsPRpJnc1MrfJI0onDG7Q527gL0ALjUK7Z5mUcC48vKu/hjZ/L/r0ezbpxtH92WSDmYvyqil7cLSb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771462567; c=relaxed/simple;
	bh=ArX//496bE2FskhpynLTmC6UDYXpDSzY0XjLm4x0EFk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IEhLLKRwL7YABzXWi9LE2A4ut/lWV77KUnneEsfcwFX2vjgtx222GdrHTOOmeD/qJHwPDHfUwFH9BUHB5MArvvnp4+8FfeJFIrtG2StWFf8mKqIrgegT0KUtR9uGsWOsntc84Wu05prG57QxkGvZwm0ePyLNPnYp3/ZdcEYhz0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S/w/Jay/; arc=none smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-1270be4d125so410118c88.1
        for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 16:56:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771462564; x=1772067364; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HGgT8gl4BQs4As/G6azTBQb16A9Jfxh7/HDWdFmRLcI=;
        b=S/w/Jay/t0W3W9uB4C8DAp9kQUvZjsm+j+7g+b2tzxSfl4Gm+iytx1UiR/6rzNGc9D
         NsamUPXceAcpUx7DSefv/CxElhAGLPHB+Qk+5SKtbVbVk/zHYSCICn6JFfyvl0BxeaB9
         Uyn6HtQx5uu9nayyfThKkfycm/+XjNkP7BEMJxRqNIwc1YJh6iO93chmnn3igpRG81ft
         u6bLk8ZY2EsCxAefgOH+rE1rXt7uJOquFwgHUOQLgOuDnzOi5hNQrukGo6FJ37A9DYXE
         MVfgSQfM9OAetvM3PjBA5Nnojop1jxeExB+MNkZWK/xdwQbdxNz5E4XPYx1RYsifgcbq
         JzcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771462564; x=1772067364;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HGgT8gl4BQs4As/G6azTBQb16A9Jfxh7/HDWdFmRLcI=;
        b=Ffd5rWdUaF5EkV1+4rF1FqSWw6kfsbLZuwHxlqiKlqtHgSugKPuqD0P1adi5orHkoR
         2wpLL28JmHpFtiQKOcY4D0VNl3A1CUFxvZp3wz0xrh6Wws9Pbzy+vuaJv6pvMfmwCSfZ
         oR5WlAdSrHCSRw/6OWJg3+/WAxYsZZ8ilPWi0h5oZ6ZnxR9V054K5KrmaDSjf/21rOfp
         kYxc/CfGtd9p4kZYj2Pf8yR9MNKapnzzMwNczNyS8xHTXp72g+PFixaxUGjtIJY7ITit
         PoLKnR13kH7bDM6xGi6M4TroEsVcGVpxHk2Iuvv6sI9pZ9Wu3M7l1R6AMPm3UGUrEwtP
         Xz2g==
X-Forwarded-Encrypted: i=1; AJvYcCW7rNJSqopjnboiLeAfolOfhQmzREe0cZLUvkb2e8TMC3GsTkUDGUt3Sql0aaQ7/eRgUubF9WQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8jP8w6CZMSWE+2hiQkRK8h+7iPnnONXO+5spqUm0LSyCBxX+r
	GRgKV9dm0kG5t1opfssprwLKbD16EExtXnvbajA6rUwEsAWvvOr1Qaj2
X-Gm-Gg: AZuq6aLqiGv4E4NLKN6MLZVR8P6bV4hVdJAG6CMRWNX1yvrd3gCSpU2JSlaNSO57ixr
	0GnM72evzyxirV5N9QEIkd5s1nDINjagViRQ0DD1EeMcEo73rym63LusmiZd5M+DrFA+oEVV+sn
	aNv6eRm5WS+MJUXewsaSfy7paBdQsZ7+FstxuFIcOnSMPbFMXqiRw2hsYbYysWHxa6HfFjXgV1G
	ZebBDEgbuT/zSn1I+FS9ye70cHbEH1M9276smXZ7tkeAV5MF3E4KskS2zpMYTE9Gh7E5b/oIoLq
	m014WaS+zqjBlJchyy6M2SlZXM8PRwHOJp6dnS0vJxpVd+F9edAmoQfIE+amk6AFRWS28/sGRTZ
	7+vzmuLF2kUWNkORd1sq7fZ5l01TaXMfzKH6tFhABkpevIG3mJc7+ZH3KlLx7CvEvL6H7s1/xVG
	JL8CxdSzgAaW91EG/g2bV4ObiaNh19KFN1x6ISrMvLCo6i8d3DtzTg7q05oWProBUp
X-Received: by 2002:a05:7022:396:b0:11d:f440:b758 with SMTP id a92af1059eb24-12741bc0129mr7691550c88.25.1771462563993;
        Wed, 18 Feb 2026 16:56:03 -0800 (PST)
Received: from google.com ([2a00:79e0:2ebe:8:265b:f5ad:9e03:677e])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12742cbc900sm23969207c88.14.2026.02.18.16.56.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 16:56:03 -0800 (PST)
Date: Wed, 18 Feb 2026 16:56:00 -0800
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: [PATCH net v2] net: phy: qcom: qca807x: normalize return value of
 gpio_get
Message-ID: <aZZeyr2ysqqk2GqA@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259382-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmitrytorokhov@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2B53615B448
X-Rspamd-Action: no action

The GPIO get callback is expected to return 0 or 1 (or a negative error
code). Ensure that the value returned by qca807x_gpio_get() is
normalized to the [0, 1] range.

Fixes: 86ef402d805d ("gpiolib: sanitize the return value of gpio_chip::get()")
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---

v2: add correct netdev tree prefix and "fixes" tag.

 drivers/net/phy/qcom/qca807x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/qcom/qca807x.c b/drivers/net/phy/qcom/qca807x.c
index d8f1ce5a7128..6004da5741af 100644
--- a/drivers/net/phy/qcom/qca807x.c
+++ b/drivers/net/phy/qcom/qca807x.c
@@ -375,7 +375,7 @@ static int qca807x_gpio_get(struct gpio_chip *gc, unsigned int offset)
 	reg = QCA807X_MMD7_LED_FORCE_CTRL(offset);
 	val = phy_read_mmd(priv->phy, MDIO_MMD_AN, reg);
 
-	return FIELD_GET(QCA807X_GPIO_FORCE_MODE_MASK, val);
+	return !!FIELD_GET(QCA807X_GPIO_FORCE_MODE_MASK, val);
 }
 
 static int qca807x_gpio_set(struct gpio_chip *gc, unsigned int offset, int value)
-- 
2.53.0.335.g19a08e0c02-goog


-- 
Dmitry

