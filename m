Return-Path: <netdev+bounces-293332-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yNB4NHLCGmp88AgAu9opvQ
	(envelope-from <netdev+bounces-293332-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:56:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3249460C4C9
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 12:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9889830A2154
	for <lists+netdev@lfdr.de>; Sat, 30 May 2026 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED45039D6FF;
	Sat, 30 May 2026 10:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WzWIJbBW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7F8366079
	for <netdev@vger.kernel.org>; Sat, 30 May 2026 10:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780138330; cv=none; b=jyy7DQ7inYbcdFjZFlxt2hJ2bRXUQrZNxdIquaa3n2osr4ET/gqFvcvbssfcJXCXzGJaH0TBniEkN/lSVb6n05egadTRPzCUV7jkSPIsEhehAHPEdFd2XMOY4xY0oKW+yA70QN0G0vjBcUXs64HQnMFfepsUqlUoLuYUPFHIDbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780138330; c=relaxed/simple;
	bh=uaVDHzjUs+dokQ3wPGoMZge3lrsY5L04UHdr+iWbJn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BTDMBLSoIiJQZ9imwiRSaoHFXb8iRkKIc500tIsUHldUJy1T3nUHhpEW+P+bMI3JpqFqz1NxBAqMT5OXFnUqcZOdpKexuAr8A03Zf0PQglFvxtgqkOCjSDps1Ukk2lAAM36GKTROdE5DJiXw1lwC7gNCNACaNJbpFOeOkkCmlq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WzWIJbBW; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7e0aa486af8so3422657b3.1
        for <netdev@vger.kernel.org>; Sat, 30 May 2026 03:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780138329; x=1780743129; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=WzWIJbBWLL1lUH8IbPbNWtILQHelbxMLx6S443cJ2x3H5ua4uXUIoSCjmavCVGjxbJ
         xoCSs89pG0BAorx337JmcJedn9/rBr+8Pm81qGtPOD45V1p/0vKC7TTFHWaY2UYdkx4J
         94nAzaoEB5JPKI7wYCpGBv0vZ09L6GKomXUsmyBwDQZJP5fAbrIt3C0VVTXAb3KU5XS8
         /51Oe2cc7gv21Phs5BRi+FK4Hw2+DtDQiwcSvZbxBDsos0lIV3ujOgms0Ny48YXhT+og
         Xysa961BV4YaThFxgdJvLY16cqaBJNILpKvfoOzfYq++wiAkKgJtY9ofXV7BTeIHRZ5f
         KrFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780138329; x=1780743129;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=IpvjtnVj26Pe8NE2T7dtrEg+Dn8EzNK7ekyeuS5bZI2TeZbuNdqDz9P0BvsIKbxreQ
         booDPMNuwFBkP60jgehj3gEQ05FPYjDxCr2Sj6NiDBEh6s1eqhV/r89CGu9k3KMrcgDy
         UYERT9g/fJpxfsV390SJRmGEFS7069iXhKpXf4zT7oHhIholG8RwlYkxJHzD6dzZ9H2G
         IS77eORAWEpWDKvjahLkIDl3cxay8tRRuIF4cNhM24pbhTFSz+np1TfKSKYVjIJY/ebs
         P6dgnIzwBWLOyY7/ufnG0BT5POzdiHikApas1jOGzbrrb3XMPD6hxjNpjO/qWAJJSJhF
         kTVg==
X-Gm-Message-State: AOJu0Yz+V1E71PgQdaiSZ2T/AsBU96zXu6IyTzGv32xXpvDJ4QV7sgrT
	gek1kWXdy0zOC7ADZW2AzuIGr/FHkO26gG9nknLi2+imGUbjfIxqTrPo
X-Gm-Gg: Acq92OGkW6Lex3LQnifSHzHUoiSGCq0FdhLFVnDkPYlnQv/mYsnX60pQYz8jQUnr7GC
	Y3qZv6s5CG1vJhNtIp8j60A5N4Re8VtBawquJoPnqMdG5L/T8MlTN1NHNG60nLDt0sgIEQxgVVq
	CDkczSLJxjPp3iGiKFJLqg7dngo+RUf0MKcs4fs4ujAqbKBfSxaIbtlu3of8LWISMpCx0eWOT1n
	y1hXS+K7e2zLd7+70d0INiv9LoQ5YrRK/gF8ToUdS3BGqESLvZ3FD2WbPXkyReVASdbdtrgGwbE
	Dk6JTj1CvgEkmDI/aw1b2HduYayJdJJcHntUlcuduVGhrFkpmwqwJJq3gNye8/ql2SidYCe6yDm
	sJZ6BJn7NILmvf+QhEbzYVh+n1TMJY50rRC2/OdCZbIbPgQpNZUxn2dH0Iba20tS3ZJcH9YHO1k
	geIlfA2abPywke5b8zcScYKQMocpx847oMKyFa9i9YBTvsPYgSCA==
X-Received: by 2002:a05:690c:c50b:b0:7dd:a645:a57 with SMTP id 00721157ae682-7de21c5a2f0mr55191047b3.10.1780138328841;
        Sat, 30 May 2026 03:52:08 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7e176d6ff86sm5579357b3.16.2026.05.30.03.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 03:52:08 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 30 May 2026 07:51:09 -0300
Subject: [net-next PATCH v10 4/9] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260530-realtek_forward-v10-4-d14b51e6a69d@gmail.com>
References: <20260530-realtek_forward-v10-0-d14b51e6a69d@gmail.com>
In-Reply-To: <20260530-realtek_forward-v10-0-d14b51e6a69d@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-293332-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3249460C4C9
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


