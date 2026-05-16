Return-Path: <netdev+bounces-288566-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YMYQKJPpB2pFOQMAu9opvQ
	(envelope-from <netdev+bounces-288566-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:50:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 080D355A126
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 05:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 22E3A303C026
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 03:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553C02BE639;
	Sat, 16 May 2026 03:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o0beEe2A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D28D28A3FA
	for <netdev@vger.kernel.org>; Sat, 16 May 2026 03:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778903244; cv=none; b=rG3jlTt5HCeDD9G22DLVyG9wHgNrkDosQTdbpaj7LtDqqV2xZeOlbhJgjdxWZZIqKpyrPr7qtsueQe7mnDNs7/z23hejp26SHH0ddkfvQTokhPuqwDC93lMevaRnPiVZDYrVhNvAOuwGWKyRh2aTJ2CB7VG07ncurzIxRLWGQ7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778903244; c=relaxed/simple;
	bh=bHsLPOXrluehOuKUcFn4n7urdpC0Ou8B1BpSJskP9+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=otUUoO/ALQHY1u7Dug6c6W9jDORdvW6yACsO8qukfI1Jqajo2qlDzSnIWCGlyCRXx3iKvtNOn1obC9K/WQQ9eKqEGD9fyFNtbjnDOkZ/56TRpMINyB771UQehT2lMfe2scGUrpJkJqgAaoME4IWkTeCyEaPpqQCsGQ3wBNbxrj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o0beEe2A; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8b4eb1fd5d0so8415486d6.0
        for <netdev@vger.kernel.org>; Fri, 15 May 2026 20:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778903242; x=1779508042; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cbJtwuZVN1lk7Yk+XDCZlr7tUa9Ancx4oTQZLyWObYo=;
        b=o0beEe2A7fXs9Nm6ENNENOZGuK5D04lYQxF9bgj0MZS4TMajS5svXoRZje3MU5DWCZ
         aH+FUg1gS1bGS+h2dGkfkbb3PQi9pqqxSFV6ZkkvbFSMxiHvt3QmTJIgOBIMB0b7Siif
         BSmFUAty+LtxJXYwDnGXJbtrYRqJLfd4Up6vMBjf5GqwgpzqcpFGs79oB4mX7/ehCbTp
         HTI6jQZbKXx3Rm3DQs39Mvs1uMvbhTo7AkoI9WRyiiJC0p90VXrfSSfMkK61kDALrSgV
         4haAwmPpM9T/rxjf0SH6Gb5rhgmPF55wyYk9AjMmaIWkhrhny+e/6o3BC18BdleteKao
         IlDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778903242; x=1779508042;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=cbJtwuZVN1lk7Yk+XDCZlr7tUa9Ancx4oTQZLyWObYo=;
        b=cxA7aHS9XKj1KJCf12xxSatYupKAjqdilVm86pwC3OIvDwe4X9hr8G3gvkKHHzdlv0
         ddi3leqD6OcEFBe7RwrgPlgMlUfA6n24RqNOW55vRgaotynHRW4tLdt94aQR4CqhDooj
         fdOmrMneSFlse5RibqTR65qjXepJRN+lzZOUmyQLWm2t0iFUeWcqxZoDDDKwvSJomGvi
         H0chEABflMOScQXfuLQ0f6GSqpCMbj95cUbvM4Wh9p49PUVYVtx4DcIqGkP3w7DQPFge
         5lp188tWtKQoqjjLzi2k5Bfbjghy6O47idxAofmPg0yjCTT2Vlm3bPt67eWxEz9RJan+
         NIow==
X-Gm-Message-State: AOJu0YzbiOr9IyRH872457IlTZqSRKlUJUwmYe9HLAuJ9fDNQPJ+1I/g
	mbT72vUvmeA4n46kdD+e5NZi3IXbVuaecnjbFcVi4I2wA344eIk/I3j2
X-Gm-Gg: Acq92OEOLi5oHuu3DxIwL1dTEL+XULKowlyVi79wNTBqLvDkd7TVMiU9L9xF+QiaL1J
	5h1OJx6qiSBKVLgxrtY6w6b5hJ8w7nt3VmtLaXedSm+UOo1WfhXM8G94/ZO6FFel32OJBffcvXp
	U8lglIrs6qMd75ZgX6zNOFA5zjQ/BdSKq1C0dG1DaJQIE0S8Ipsow40f6S4KZgdVQBqc8TuA3VK
	2BJuz1QuB13299yGNRbhZ+lvpUW5pBaT2Xnu92FmSraQ8hGMCIQd6rdf9poyqfeqCBxrVSraGfG
	mtWLbkfMmKaHNomcWcURXUJEDEQZrF8YmGGmqdpNNvsY+qzriS4mndcK0WRLhLhHAjSoOW4qnSG
	ew3AWt1DQ6d5rcsHOcZ9zjC35uykNO5xIcgIipZ3qMmmT4JYckpvanZFxG1GFlo+yY4dt62vD41
	LZxEL4fqhR0hYIGw/8CSs5EyPrCzrL1bRV9eg9wseWWLsvbW3LUg==
X-Received: by 2002:ad4:4027:0:b0:8ae:5fcc:ebb5 with SMTP id 6a1803df08f44-8ca0f6d9122mr87816096d6.47.1778903241851;
        Fri, 15 May 2026 20:47:21 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c908d1d2e7sm70874546d6.16.2026.05.15.20.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 20:47:21 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 16 May 2026 00:46:19 -0300
Subject: [net-next PATCH v4 3/8] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260516-realtek_forward-v4-3-8b6d6a1eefdc@gmail.com>
References: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
In-Reply-To: <20260516-realtek_forward-v4-0-8b6d6a1eefdc@gmail.com>
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
X-Rspamd-Queue-Id: 080D355A126
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
	TAGGED_FROM(0.00)[bounces-288566-lists,netdev=lfdr.de];
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
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
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


