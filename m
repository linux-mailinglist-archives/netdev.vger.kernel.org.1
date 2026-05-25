Return-Path: <netdev+bounces-291438-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kJxLLaWnFGrtPAcAu9opvQ
	(envelope-from <netdev+bounces-291438-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:48:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B82375CE1F3
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF6AF3009E37
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B00F3932E5;
	Mon, 25 May 2026 19:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jS08huGJ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D053E392C25
	for <netdev@vger.kernel.org>; Mon, 25 May 2026 19:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779738508; cv=none; b=dnebwJxdtcX/YMjVrYyaWlKM+T10iN0lYmIB/zjQascjevrGMw9Rv3d++ub+E7ttLBxYMPOZYmHYYsbwnuNErOyRrApV33FKBG0pE3XG/D00A1rGoPmtytg6VS7l/Oy+1l/69pjfSkl4TEnMbwn+UbDJ6PMvguu5mEEatfYDSD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779738508; c=relaxed/simple;
	bh=uaVDHzjUs+dokQ3wPGoMZge3lrsY5L04UHdr+iWbJn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hz5Xkorc97AH+jmAG13Mx3shVNsu4V1veJFicxmLdC+qdZvjFYNljIpGe5cWdOn2nQhq/dEkIc6vTv9Z2pPBxRk9y5BrhvZCXAP2k19eIhfmq2AWhB7S4UXOVwacbjv2F6Ap28XT8T15tDWRVDDqBcGS1e7Ru7XEb3fh9yc/oso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jS08huGJ; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-575124e716fso3377542e0c.1
        for <netdev@vger.kernel.org>; Mon, 25 May 2026 12:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779738506; x=1780343306; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=jS08huGJlBcXgfqWba/NbGjdG/GX+j18zwDd3r/goJYaa2XkDAsA7UsX/om+g8EXzq
         Res0KtGPGfDVb4tC0sXyr5w/fiFGeMowLcgqedqF8Sbrp+h1p/ETEjhKSTbeqdDNy+u3
         D/tJsJV9hlzKXyuiP2408JUhBIO0yqvwdQKTzl55v6gBxnaeXE/Cyjfc7DTR/slJ0Fo5
         zJBXcTHqH0sBVYmIyNIFJv4KkaUGCYkT9AGQymvlmG2K3LGtxNb8MyKhhfvLZJu4W66V
         w0zA9MprRXRDB/ZrdF2sIbyEEEuptf35299a1FIrFpES9epzO1DkAzfzZic9UEVSeBeY
         EC4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779738506; x=1780343306;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=EPkEAIa+0FPg6o5MYjRBFGRbnFFuzO80gMYgKJbDddlj/ySIxbpxVGDKG0Wrn3sEl5
         DwU0b1PCDTWiEtymWFS6QR9IXroO6zLOFw3ZWWo4AUf/JoWaozHL6AJdefZiGpqMGCrk
         pSSoB3RZBbljW5bR2hNFEiRBsjVc1y8/VTaG8fN9GzRKrWqI6VfMv/JAge8rOW7RbBnK
         H9MwfDPk/SVtqZxH3LWby1Hhxvx2XwXb5SF8yJH6EeUDSnab8CK2C21VvzUbZLnHM90X
         9uIMqsm4Pydcd0T1nDDZWsnVj3EqOBLJkN6UjJgi3qk8KpDhFMKv1oRgZJfzVlWZZy6s
         KQTg==
X-Gm-Message-State: AOJu0Yy6Wx7xffB5bgY1GAEX8NftP1u2M+eAb5ES7XcSFvNC3+kW/wgd
	asYt4VdoWl8Ett1p8lJ04giENNQeTIRMwVPoU6cAIPkS3pHAebVBt13h
X-Gm-Gg: Acq92OHVz1ivIAQahL4+hUfBrzW5EbGihGHO7n4hotDvGxLk7XDCS77llcXZY9C5GwQ
	zmcN6FnpTKwEvvqWC7OtxiBaJWn5VzY4KGO+WQjCZuj/d28pW73aTVWOEJRwTMvjctHPYdK9hfs
	ghldYm0arUR5vX8ng/8GrL+DH6KQs1pvBxBiiL9GE/n2Obzp2G4vSVdgWvnuVP1DgIINga65tYN
	TSYVbIXBm9cLzb61g1IvUR2GJFMOS+ycYz/57xYIG4Rx4riVJrAyqJKwPw4XOs5yRBWAKwH4PBe
	8eAZ+1Wu/iaDCwqzlvNQrgfNtXRuMB8jvFPlwgSd2XnheZMLKddyBge2fwzxZLqC9yrTDoB2lA5
	TqRHQ9ZlvzShHid6rI1eakHrkXg/Ky3rbon5zJP9BHiHHKReULQ1TCZdqNPTsfR1SnokH62nBQG
	2rQLiXL3CVGGhrUG65H0GA46RtRs8qGBrQM4HlNQ==
X-Received: by 2002:a05:6122:130e:b0:575:360e:600a with SMTP id 71dfb90a1353d-58661834f53mr7210864e0c.8.1779738505610;
        Mon, 25 May 2026 12:48:25 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96173af3e82sm11092456241.10.2026.05.25.12.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 12:48:24 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Mon, 25 May 2026 16:47:59 -0300
Subject: [net-next PATCH v8 3/8] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260525-realtek_forward-v8-3-5eb80a4675be@gmail.com>
References: <20260525-realtek_forward-v8-0-5eb80a4675be@gmail.com>
In-Reply-To: <20260525-realtek_forward-v8-0-5eb80a4675be@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-291438-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B82375CE1F3
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


