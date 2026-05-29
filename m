Return-Path: <netdev+bounces-292964-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHORLfwWGWoMqQgAu9opvQ
	(envelope-from <netdev+bounces-292964-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:33:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B02C75FD036
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 06:32:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CD4A030095FD
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 04:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4E936A355;
	Fri, 29 May 2026 04:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JE2om0MA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4160373BEC
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 04:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780029039; cv=none; b=I71nBxPMA2fW9DgeLq1dCRRFy9lmMhqOqPHiL3scDiSH8OWnH0BNXEjqMyB8+hGEJeObY4EEeJhSYNdt9Frs6tS4tCzDtDtmzoUgrOF/VUnkFiViq08fUM7i3J+58sPcYZsXxwNumzyjiGbebp1Mx3z5liIaCYJXhHSScWyDo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780029039; c=relaxed/simple;
	bh=uaVDHzjUs+dokQ3wPGoMZge3lrsY5L04UHdr+iWbJn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y6M3Wmfh8SGUHVtGrqu+8g2mhFPyJFF0504BLTHVnOqSNZy2vkYVeJ9Ne9w4xPWPFvYR/zV/dVncUdA8KkgyPmAoVa7ef1KuwL9RiJrYPNSpLNSKsARa9agkzTCOiMd6e0YX2eCCgvKvSKzhhLfZ2JkJCJYaFM///K5kykNNy4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JE2om0MA; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-50fc496c8baso148692001cf.3
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 21:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780029037; x=1780633837; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=JE2om0MA2Wizj5au36V57d2/6gwTzsUbTXwCEuKnHgP62Mp/iDoewTpKZRvGjds8fc
         4H1Vqb+LzNt1ZrSoxSBQCKD/4NdEZIU7q0tPLxwYvwTwLfc8x4Ny/tHuXDjkbDDjh9QK
         chjmjUfgKUZjT6xjeRlsqNdHEDDcxRNJQwinmuXf5a8vbVN7NxG6nzqjwRrYCj2MTU6I
         4ZQJAXZZ1JSEljljJo455SIMy5mXu+Ap07cg7uO4bVJDCOQeMzMm7i1vNKk2ZTD5IiLk
         f4zxaZCZOYFwHZLpe2hzCeOd+igHSTJBsluo4JgCQhDexS4l3F81BnOY/WXchogbOm8J
         XHxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780029037; x=1780633837;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=RCGdfuKqsil6n8a/FSbTKQPYANS3Vf1us0bNYw0L84hryL/hiXvPH1F1LKYB5s4GAJ
         /yVkjBBVDGhC7cf0IUlII1DXQJzRlI/5XtZXbRdb10QsqUL03nDYrSTqYZEmaWZBOUEF
         V+Uhlmr3DE3LdPH5imMzpm87qYeqIceBEGsgNzVALP8SKpcdaz/cKNMkLJzA1UFoVQJM
         SyCP31Rf2miUhvf0uGzh6lF61rDA0Lj/nHubFemHdUoVgtELZOmbvxjymqMGY0YK+CA0
         e4wNrg2smVF7fsoalDPHX2ErJXN9Tmu3eREWHAeI4+L3/QX2ND+hQ6BGKgOmmekM0CxO
         0VeA==
X-Gm-Message-State: AOJu0Yz0OtZD0Wouva2YF+7tV1WGpRrQG8ebRwNDivPKtZd7AjN15mgr
	wPGPKO5nC+wTJU5Gkz5JfNmDUri/8ENexKs9qkh1C49NXFKQSHfLdlgs
X-Gm-Gg: Acq92OFHoJo8sEOEF5cl5rwSD//45MRLM4LxbawrIjHO5M8NHuKgl0thnowJ+QcAJtW
	vm4WdxzsrqNkts2MGmSLV1LCStdjwNIuzCqvJWd888hIZOmCA2Bra89NFwGA5ussLFUlXDoDnBM
	d7fef2PrA4FwqqqqugBm8i8PsphLl3N5O21KOl6zIp7QbNquC0W24j9Q4op6Abf31+oC3Jx11BW
	xaZ6BNUx7HPTn0KEEDDzH2HOvoEd1ZQLswH+qmPux+2U0jn1mNEclvmOsvByFSbTkSce4SUdB5y
	GZSA2Cd5x4Kt/Z63Wt40q4SxwRlr2ePxRBAGYwRZ0DeM2jo5Oy8CtDu4Z8hKH16ylvv7EucI9z1
	c4tl2aWtqBqTvPanlYJUY4ACBKK1NyEXj8eMeuTpXiQ7fmS8cb/Tty8Q07JsdNYW3dw9x1PSzYu
	y6tGlxlYDw9WNftuqUxxoRKit1yfdHJhO4i/FqbZJeQ3XRl/rJuw==
X-Received: by 2002:ac8:5d44:0:b0:50e:61c1:685f with SMTP id d75a77b69052e-5172dd71aa1mr16818261cf.50.1780029036743;
        Thu, 28 May 2026 21:30:36 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5172ebc7d23sm9260991cf.29.2026.05.28.21.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 21:30:36 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 29 May 2026 01:29:48 -0300
Subject: [net-next PATCH v9 3/8] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260529-realtek_forward-v9-3-e7c61872d923@gmail.com>
References: <20260529-realtek_forward-v9-0-e7c61872d923@gmail.com>
In-Reply-To: <20260529-realtek_forward-v9-0-e7c61872d923@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292964-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: B02C75FD036
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Rename rtl8365mb.c to rtl8365mb_main.c in preparation for subsequent
commits which add additional source files to the driver.

The trailing backslash in the Makefile is deliberate. It allows for new
files to be added without clobbering git history.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Co-developed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/Makefile                          | 1 +
 drivers/net/dsa/realtek/{rtl8365mb.c => rtl8365mb_main.c} | 0
 2 files changed, 1 insertion(+)

diff --git a/drivers/net/dsa/realtek/Makefile b/drivers/net/dsa/realtek/Makefile
index 17367bcba496..3f986e04912f 100644
--- a/drivers/net/dsa/realtek/Makefile
+++ b/drivers/net/dsa/realtek/Makefile
@@ -16,3 +16,4 @@ ifdef CONFIG_NET_DSA_REALTEK_RTL8366RB_LEDS
 rtl8366-objs 				+= rtl8366rb-leds.o
 endif
 obj-$(CONFIG_NET_DSA_REALTEK_RTL8365MB) += rtl8365mb.o
+rtl8365mb-objs := rtl8365mb_main.o \
diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
similarity index 100%
rename from drivers/net/dsa/realtek/rtl8365mb.c
rename to drivers/net/dsa/realtek/rtl8365mb_main.c

-- 
2.54.0


