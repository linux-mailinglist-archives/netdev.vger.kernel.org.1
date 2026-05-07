Return-Path: <netdev+bounces-285129-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KqaLbAA/GnjJgAAu9opvQ
	(envelope-from <netdev+bounces-285129-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 05:02:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1757C4E286C
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 05:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 38715303B4C5
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 02:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C676829B78F;
	Thu,  7 May 2026 02:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o6BsaTEE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5448E225403
	for <netdev@vger.kernel.org>; Thu,  7 May 2026 02:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778122731; cv=none; b=Qi5CDkQ1w3qixU2ph8pFQjHbM2lTxtS7hlJrkAkBGq1ceW4hB9e7LVIC/zowySNZ68M2y8UxHPiE/7wWXq1+GmjYT1utVkjxWh2NCTXDuUFCiadIDeLSiFwPcx2b8mbpT6aftLsy61wH7zfr90Gz52vRsKc8jR80HU0na7jYA5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778122731; c=relaxed/simple;
	bh=B+8GQ5Fgrmsl4U0roo4LfBYLAZxaWZHpoY4kytzgVtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iO4JVPKrWkCGx6yX9fFm5tdJaTSKdyRdIr0PzonxgRJR6ye25UPKWHQxgZXhjByCrLAx/RzbQjkMlsmGEpdia23bDF7eBUMeliwqbzFCF6lDaGgoLA5Kq7Sb8QMwsW/3J1Ht0trnx2TthoAmjjDYqUCg/OQx4vkAzoclkrRdnV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o6BsaTEE; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-12e332315a8so1094831c88.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 19:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778122729; x=1778727529; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ph+ORfNsRwGMHJwVx2ee6HQkUuQVHVtz01TlpsSN4i0=;
        b=o6BsaTEEOWRkI3EKmvxh51EJ33ILQ6vYy1jRqdC4vM99Cnl3+AKuq7q7M9abeBkab7
         0eOJIddnejYnan7c1l6DOHKyYIT+9u6gMMiX9KgNj3RgkinG1BHXoc/zKU8bcpDRpY8I
         q6fDsz0pyOxWUmkXQR1JDoY9SQnXo6fZgmHnln87CbTHd2U+f/TmsJIc6CdCxhbzKe2b
         4hWeGPDBppHaOuhFqEvdenoaZYFxvAEDbNyD8biBZXRgdmtrET+4cD3qPztUKmRmLsK9
         cKi7VcIE24Hp+I9H3xF4YpEkL33ki0Zrnqwky+zPo1hATGdnchqd+6cpmwpGbF0DmkaP
         5o0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778122729; x=1778727529;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ph+ORfNsRwGMHJwVx2ee6HQkUuQVHVtz01TlpsSN4i0=;
        b=XORYaffVKBokdo0M19F8WJg/mqDuvOhNN+rCbKSsb4Dv3qZhROZv/lPxXHzvnexgyX
         Uo5mBFXK0PxLZK5nCVWxGo1KZre5NTrnRfPB4Cd/AFeMfgH+zim1ufxUe3sZw7TXd+mJ
         MbX6lA9W7Wuy3Lpu+xcL26wPutEBZwsEYEaCe/kSpmJiYIW+kN5kErPxSnawhtTni7Fg
         YruOdGn+6IG4BCW+UfYkaQ82c75T7rsbNb9mC1kM3Mt275x1JkYJh5VZJLird0CtWkSW
         zkgZn4w0gIHZufXqeBc9porNeso2I4Z2oS6urxuru4qR4mtOiy7APEklgZmxA+7uFe1k
         HDPg==
X-Gm-Message-State: AOJu0YwDyWCogtZrgNbUTfHILOipUqLOyXOVYkAPDFMwRvnwNLP6WAGb
	vKyC7SDe1di41k/j565jfjgLT+i9tKhzXTvksEv7EKPOlzGCR6qWNP2m
X-Gm-Gg: AeBDievh5kcDBqibtoOTnMyG9KaYtoQsoGBSlWBavDGfY+XzShDxP9LH4g96BiY6rxf
	N9qk5yJ55VBT4GSk4rGr22PjPH37SX/nRHWbGdSxydSb+2d7ZLsmtpnO2HQ+z6tBIxjS+XvbbOi
	Z5kJfowzrQ9LvnB6LiShjz2+ot0vMT5/bOLMeTDrA54QQa1kGhqbbJll2JB1OSgxvHC86JM5rzz
	MrJ8NSiaqACF9PG/hqX54W7xVqDfQ1cilEtAIchdOtkJOvXGDYhaz9lym9nqbnUxOh55KrczwFf
	/fNtFpaB8q+ESFTJCdWBF8OKnaA7yg3+yDQRZc2fr5AkATJ8CzgJq44QrBDIBKc7irkZ1RcgKiD
	GpjgtZPDujKlB/a5IlxTlXcAKwvKlyuWhzyhgUX9HRl0xWY54cwPW/NRdus67m6DuTrtRgFmVgj
	oo9lwsJgULZmuF6TQoy63E0Ud7PuZIBUvvFKYO5CZlfsxdnz6lUA==
X-Received: by 2002:a05:7022:79a:b0:128:d4be:7428 with SMTP id a92af1059eb24-131853de2c5mr3370711c88.19.1778122729356;
        Wed, 06 May 2026 19:58:49 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-131f9789e3dsm6561267c88.8.2026.05.06.19.58.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 19:58:48 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Wed, 06 May 2026 23:58:20 -0300
Subject: [net-next PATCH v3 3/8] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260506-realtek_forward-v3-3-1d87c5f85a3b@gmail.com>
References: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com>
In-Reply-To: <20260506-realtek_forward-v3-0-1d87c5f85a3b@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2
X-Rspamd-Queue-Id: 1757C4E286C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285129-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bang-olufsen.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Rename rtl8365mb.c to rtl8365mb_main.c in preparation for subsequent
commits which add additional source files to the driver.

The trailing backslash in the Makefile is deliberate. It allows for new
files to be added without clobbering git history.

Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Linus Walleij <linusw@kernel.org>
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


