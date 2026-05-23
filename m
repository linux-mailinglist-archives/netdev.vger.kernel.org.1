Return-Path: <netdev+bounces-291036-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EKhjINhBEWrsjAYAu9opvQ
	(envelope-from <netdev+bounces-291036-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 07:57:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E9DAD5BD5BC
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 07:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EAAB7303E6F0
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 05:56:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017EC3264D9;
	Sat, 23 May 2026 05:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kt/6XnIQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f179.google.com (mail-vk1-f179.google.com [209.85.221.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92062231C91
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 05:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779515768; cv=none; b=eWPoLz5NTcDXNhneIXjUe74noJwhw+H5xt384/wCSWsLnwt2xXBxsEEAvvkZIfkwJZ+wEUJ8rkscHdxzQx59a1kL4C/57/ry+WWq7deiB+f+gN1fLz2eU4ba/+fwQL+RHiptIdQ/Tw/xYmNKeVCiOZb52ligsGf61YgmTEkZKM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779515768; c=relaxed/simple;
	bh=uaVDHzjUs+dokQ3wPGoMZge3lrsY5L04UHdr+iWbJn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SjuLjAWP/sBeb4QTRbEpHR9Brngj2WyEXBrPToA20JA5H5wqAI1TETIrkIN9JK+hRKZT//wYK3GDW6008Z7BWRxRkmgPZ1rk7xUtWR8AVoidlyBY181/pJ4xx6WoaMubIdubWle56Ow7EL3l1bil3UMO1pZrMMiMkaS5SSY4bNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Kt/6XnIQ; arc=none smtp.client-ip=209.85.221.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f179.google.com with SMTP id 71dfb90a1353d-5752b279662so2898304e0c.2
        for <netdev@vger.kernel.org>; Fri, 22 May 2026 22:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779515766; x=1780120566; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=Kt/6XnIQ1m+yOKtlQPrGDNUtIqXO6KEjBIT6tCniRsR3vg6YcGcu3Afwj/DMJK0k1x
         hx8bNF28ZkQkElppLUay6zurBbdas384PvKKEgyFjfEk6Qi4I8Io+JVbJq+XXusps4Co
         E973q7cyRAEQyDHaxwBHQ5GSJsXWtmH8PhVXmsiv1g4mSYCMWGjJvagEfVJMiHm7uRZZ
         Q6BSdryFlnj4ABK93qe299QaWK+5RYV1/2kVpn46rWCTt3mvuiXBlaxWuSx8wom3q9SP
         v0heLtHAXAjXS/YNlMNHebcgudkGmMWWaQ24DOT4HdHL2b2CTlA9QN8HIuKgEvuob4lp
         /dfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779515766; x=1780120566;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=BVSL3xKE7m2d1E1FCkVgh5GjzaG9uxeSu8sbMzuLQC5d3Ssrz7gmLLdUfll9w3zcil
         RtK6bkE36gs/QDSR+v7oUoAVA96F5W1XYveov1y8j5oxvQg4FcrCtXrPoY/2kq5OAHNS
         k6EwawioLvwDpw0W8wOHBdkqgewkHMyKy9FwwAPm58ipLjvbwb3rsrfmruEA47ux7nw8
         +8B6o2ZvBWwaRH1ZYeOH6qSXKuvIo+l4LQfhU3yCgTeOZzwPnSzr5xtcLqKZ8wdDSoQV
         M/kgsEhmH2mdBVAYSovdXJiSItrm5N5l6TlPKtuyuBrjdOg1Typb+RU0j/ddHEqGE1BV
         /UOA==
X-Gm-Message-State: AOJu0Ywvi+GTUdOFiQa89sxJFbzxJ7qzaT7n+YNPwy2EHb32TrlC3sql
	XDTILOwsgq/PFO1QHGHNNm9WHnWOlSD8O8O0oMpIYoeaPIsCjtLyEvg4
X-Gm-Gg: Acq92OF8l6/2d+n24T6OpeWNb7fVr3iruY/C46Mon0hQQ/GVTWWJs2MIus4aA8q3JKS
	Rfw5dzPN6sWAwSdcnhp2AIu/ateKUNNz7zD2Td1xdGwq2sjm+YLFxoaRFIr7XDwW5rTOta9m3VL
	wLR5pU+/UWgkiRXEbu5K4bmZN1S29gNLekzIeY6+d5RH/mues9qeuD+uoLu718GUJudiiQgqeXH
	brpzRrrR68c+C18pxBHg8KpolTdi7Ji1b3EqPhBpZ29nNCwAtvcMbO9EE45Ot0NpaBLDm5Gl+Ol
	VIK5z37JhTf+3rgb1Upg9ibC4pNH7nOeITZgGzrVTBx3JkKxQIoTiYufgjaT8vfzdcz82f7JzO/
	SEsM2p+MRhqY3kXzk/AmCC5pyXGCwpeSSeuw084gEvU7eXgQqxwDbRFl4T6ohj6M7yGkroz75Id
	E8Qm60QCZaBaECHgacLVVOrnZ+Ev/XuqgikWQ+7JM=
X-Received: by 2002:a05:6122:130e:b0:56f:7300:37c9 with SMTP id 71dfb90a1353d-586628bddf5mr3211887e0c.10.1779515766464;
        Fri, 22 May 2026 22:56:06 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f973300dsm5023718e0c.18.2026.05.22.22.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 22:56:05 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 23 May 2026 02:55:36 -0300
Subject: [net-next PATCH v7 3/8] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260523-realtek_forward-v7-3-313805e218f3@gmail.com>
References: <20260523-realtek_forward-v7-0-313805e218f3@gmail.com>
In-Reply-To: <20260523-realtek_forward-v7-0-313805e218f3@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291036-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: E9DAD5BD5BC
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


