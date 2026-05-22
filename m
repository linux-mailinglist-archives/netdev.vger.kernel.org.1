Return-Path: <netdev+bounces-290645-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ClVLUDAD2pwPQYAu9opvQ
	(envelope-from <netdev+bounces-290645-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:32:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5938A5AE045
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:32:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 522123017ECF
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 02:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22C823033D8;
	Fri, 22 May 2026 02:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htDjmukK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B648A30677C
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 02:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779417117; cv=none; b=U0nmTDEQtBijudiL8kIfZxCg0tN5P6OXIgjaGhqdcbk6hfMY5kAgKJtrylGhqUhrSk3JlthtootW+UyL8Lcian9Yid9QIkcxPNQ8Pz5MEOuXMLG9dcFAiRS5s0L8J8te8ABSD5he4R0G32XYYdpBxjlPw+Ia0GXR9A6tMhkTVeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779417117; c=relaxed/simple;
	bh=uaVDHzjUs+dokQ3wPGoMZge3lrsY5L04UHdr+iWbJn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NKdlTy3nnFMNv/oSxcfJ3JyM7+8XuIZIFvNKhWGhp8vc/iADv8wgucTe1fo48ep6gCazYH4fs0swVzLKQIxhiNo/+pXgMPQ6qi7ezIV96JofYIpXdN06Sf/yDC9yFeFWNr0xf58iGkd1cyHpEGahrYy5zB9ysjVXRT7B9VVNYsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htDjmukK; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5751136c561so5973420e0c.1
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 19:31:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779417115; x=1780021915; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=htDjmukKI6oN+TGB1YvVTWZLGWv8HqJvd4irnVNtfHaw1U/+LDd4h9aWOCHJjOGo+N
         hHAPVe7hcLyVBp6ueEqPY9Llv3eucYg/KM/p8QbBHM4ByU0wDpzF0lEDzhucVWKG+zLY
         k3l6s346Wyox88skJkZi/YFSrUitDTZBnqUQLX5DORzjJrGzrpAim/cEDubQKa0TYoYf
         O5KLfcifTiqn/TYLlGaGuuFXGubFKEEY2+CtJC5qp392x+5ih/ZuCSaft0fgjnKf+IWQ
         1Np5Y+TY3CqMnW/jsBgRj9q88071+JSgYSq9uuLUfk3quIUGZTgAWSRdmwnOkEIY44JR
         y1jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779417115; x=1780021915;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=BKCr4aVM+slHgsrggLHkBkPNc3E9oP3RsqhF2P3XoXmdXslI6XQR2S/7wyst7NWsE3
         jFwTJM13+/Mw3dkVN6nJ4lJ9HH/O05CNCFK7VzA7t6CCCX2dXCbb+olI3R/N6G33xfJU
         0rNlO/Pi07xrJtbRMPPqFzv40sfDOZaTNS9cSOf41Lh5W820RmP7ZGXXu9Aqp7nRCtFV
         yHLxWMb6CZcKP9yu2rMOQBBhYnU4RadHblOp1Cx4Kf39eQFrc4RlArAiVPXJO2fZqGvs
         2ucu48OuspPu5sv43zGeGApbmiqKefEsNiLupCSQGsPS8yqdsTBIzQf+BKbhcsGW83y8
         ZnVg==
X-Gm-Message-State: AOJu0YyARe8n47velPS7bLTTy/BALCo5Rof9tcUQOIvf9RH/Wq7w0du5
	V7RL0cM5+QIPLQ2ttaVrUxlphIxb7i9cMy7LBHHQgogQo+FTIEqVy5BJ
X-Gm-Gg: Acq92OE1VrVm+j3R3wLuxDI5Vgg7kUIH45AdYXrGYWPs99cuZzbdus3kc0NNap4tIBf
	sGugl24zkW00uU6ZWwm6tcfEEhNQBgo9aPsKWys1XCHer26qbecUNUWPzp4A7f9m/c+YqRcHVnU
	OYcVQ5Cm3wbdNb3jgzbvQgRWEZYUmeHAujyfz5Yhp/oSt0rbqB924HWXt/5nqopmhv8LpJYRP5v
	Rpnbek2PcXWz/JIJ/OeN4RGzeTvowUzTuj3PsouxSFHEeisGl9YLcb1k4H+PRVROBT7BbZSEgnl
	tnBLkDEqghtC2kj0Li6eoqi8f1nqM+rbi1mgzFwHXLdlLNFmV92jRAUCnfEj4SxR502PcfP8gfg
	jJZQ2mmF0A8clFaEVIgAVR4zV+W1dX9irBLPhf8oJILLot0BYZAAxRfHN2JSc4rpY0117my4ZYq
	Va2Ef4fOn3miI4w2hUtC8QlkLMbwvVyDhsZeHOV3E=
X-Received: by 2002:a05:6122:2089:b0:575:39bc:c6d9 with SMTP id 71dfb90a1353d-5868da996b7mr636723e0c.3.1779417114751;
        Thu, 21 May 2026 19:31:54 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-586f2f791d1sm640709e0c.5.2026.05.21.19.31.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 19:31:53 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Thu, 21 May 2026 23:31:12 -0300
Subject: [net-next PATCH v6 3/8] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260521-realtek_forward-v6-3-d391bbad38c3@gmail.com>
References: <20260521-realtek_forward-v6-0-d391bbad38c3@gmail.com>
In-Reply-To: <20260521-realtek_forward-v6-0-d391bbad38c3@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-290645-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: 5938A5AE045
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


