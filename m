Return-Path: <netdev+bounces-289273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id APjnHw3uC2pQRQUAu9opvQ
	(envelope-from <netdev+bounces-289273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:58:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F4735774E0
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 06:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3443B302C8D3
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 04:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5208130E829;
	Tue, 19 May 2026 04:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FzV/AtbG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DA33081BE
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 04:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779166715; cv=none; b=SkR/oI1M5CRfjjQg+3k23N8K3mfHzaHpso8iPkDQ1mjD47zEy1oEuS7y1aBHI46GuzWelvSFX0jxt7wdmvciJJXIM+jaIZNcxrMru4/5tdHX8rtfKTV+VyeCfEc0biQWFtSebV9Dam+jkOKRNHvyHKPFodc/p5dDlqcldw2pYak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779166715; c=relaxed/simple;
	bh=uaVDHzjUs+dokQ3wPGoMZge3lrsY5L04UHdr+iWbJn4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=acSdO+ObwSCAb17nXxFlG1rCdxCQIPK2s/OngE0kUJc4600Gx4/IjFfpojZf1FtOROfiMnntoadekmc3MTnk68/GVA0LrM4k9u6qKJuloxDebOhNPFA4jI08Nfmc6TtprpMIPlD5KkFRd4IDjsVBU4Oe+3qg+i54M3CJkh63ImI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FzV/AtbG; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-90ca6f20872so517443885a.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 21:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779166713; x=1779771513; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=FzV/AtbG4IDkjruEo1NqCESD92C5Iwt0omVpdvaTtLwk2T+qytVZm1T3t2EHb3YdC5
         GRuwvhjpJ1Zuc+NHPl+g7FtJp9/ScSSIA2PwFHLlENt2jMTApDFzh8P5CXZIfgo1yHqf
         /fxq1td1CykwKFBYQORH7l6nHoPq+uVgjUIyfPnrTkIYP3FBTDlW4YIc5uWhQ0r3nYER
         lEN5urgsJq0Zd7ZwtMNjpFHi0AmcxT+FUOKdPKwQmW7e+Vpz9K7OjSJBqXNWA6q0RwuY
         PyBD4XHYLK3+KdGBrlSNVCq+WM3C4qQsWEsgjtsaPMSRoFATuU/DgPadXDrOw6GzKJjo
         59AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779166713; x=1779771513;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FLOz0VoE+9wDRod0HV4DIxsE7THsHZvGN/KHVGKhxOs=;
        b=DR8OPoZ2qkoEkK3kGQwREUKRD5d23JzIjchjqoq6V3/7P6asYfpalKbYJaQdADiFDV
         OKtubUdw8epLVxZg4oIqqXo8lULffggXeTVfZW1ncptS6mpl6HuErRWaquUZ7DqPjNsg
         2lVIa/ilMooxV7ZY5MVL8C4+/a1PcsYf8rGCjAdE09Sk+5r79UZcfel69ku2vqt/Uxsy
         /WXDpztDEWHhjpfEqB8lJOycpKazvTxFcm8JCSiDrovi1WptOgkKTTT+LstQq+anQmxZ
         7bgc6lqzbwKUefnYyZ9G1Y4jGtgP6R5sjjRNKpX+rrTO94S4M0NnFkBQZx48VVGM1BYi
         RoPQ==
X-Gm-Message-State: AOJu0YxVmLihsLfeOsWnHlkybc5p6hJ0pM2axw2v0+G07IXo1GdR2ily
	fWLJE6MwjUNh0smpoKOiKN5xVzqhmMrLBvSAhdREP3l5AMZ7IQnBZwzs
X-Gm-Gg: Acq92OHRPcRFoWV/T4NDB79IKOE5yimIBcGItuzVV0SCtIJIcFLIbWttaUZCt9qFLx5
	ucnpCoX9bjKwjIDQq0W4E6gyaHdYys4idqqdEs+S9aE5+vSJbTSfqgP90+C1mU7xRQgrEEBYgEM
	4I6T86/ZWPelJ69NmzZf0MQLTfpdYPNpTEvjzjdczJ/eKyD8jnSKRc5wipdR8ALYkJkLgdJg5nx
	cKOg2PwGzyqk/6hZtmG7EIspwU+rKxaZH4Plro5eA4EQNQf1CsvHSO3S5MHuRNb3m3OyGnGKfB6
	BnUGJ+eNFWMwHYJFA81odHYe7WZtw6W1W4zEhSwtpghKxQugGrnZpCvoYSfJawKe6gEkHkifQGI
	JkeUgDFx1HOq4+TQ7E769j6Dv6KOz+f4kbra3XBzOZ6qyiTvNBMSN+ciWUaReNAx080ETSnSb22
	HXAHTNIwHWAAwRrByIocEUuCY5aiNLIxsKCerK0P3KzESXA5+Cfg==
X-Received: by 2002:a05:620a:8886:b0:910:1c85:4adb with SMTP id af79cd13be357-910b110235bmr1880987185a.37.1779166712776;
        Mon, 18 May 2026 21:58:32 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9114edfd3ebsm1588593185a.23.2026.05.18.21.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 21:58:31 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 19 May 2026 01:57:58 -0300
Subject: [net-next PATCH v5 3/8] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260519-realtek_forward-v5-3-cb9f702c1782@gmail.com>
References: <20260519-realtek_forward-v5-0-cb9f702c1782@gmail.com>
In-Reply-To: <20260519-realtek_forward-v5-0-cb9f702c1782@gmail.com>
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
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289273-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[vger.kernel.org,yahoo.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luizluca@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: 2F4735774E0
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


