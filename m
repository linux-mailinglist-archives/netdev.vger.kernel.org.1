Return-Path: <netdev+bounces-273776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EN/zAxhSzGmvSQYAu9opvQ
	(envelope-from <netdev+bounces-273776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:00:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BD5463728CB
	for <lists+netdev@lfdr.de>; Wed, 01 Apr 2026 01:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0B999303756F
	for <lists+netdev@lfdr.de>; Tue, 31 Mar 2026 23:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCF3D466B73;
	Tue, 31 Mar 2026 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WU0sbQ5B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31467346766
	for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 23:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774998031; cv=none; b=cDPx18UfChuoGV8Wq72KzIGIeddUsdap0gwpalFQyW+Yih//gDnQNTLkA7F70akjj3OPjd/YgcJ5Xup9pXVQLPqFafdyB9DhHImE9vfQnwA38cIgjgTS3B1n+OVbUQds5smvf/jJ9nDPuOiNnVYDARTMEVRfLcTGJkleaUIitrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774998031; c=relaxed/simple;
	bh=WPNJNWrBYnAojkkcHRpxEx5f5nMRyycsOuMu5ztrywo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ImJZhjjSYVHYx09uR409R95ij+ZNcXjhwJqmXV0U1BO2qrjsUhYNs4E7GMtLjfEYeUNsxadAoGchOwhaJBAz1HMozkWbtDWy9RPkJ+cfIus8cMN3VJI4fFfScws4SJ2VH2mKxWrXSHT+32dQ20drQxQmLKOdbYQr5i3wFLtn2xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WU0sbQ5B; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-5673804da95so2252005e0c.0
        for <netdev@vger.kernel.org>; Tue, 31 Mar 2026 16:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774998028; x=1775602828; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KZrJJG+BUOXCgvao7M4HPDJpbagyCTvtNjqLqKAeBdA=;
        b=WU0sbQ5Bzv3PCz2QpNUfUn44OnIRh7xR72ijqk3z3kD6JA+/uqWlZ2upkJM8GAZt4A
         s5ma9egrWfVfKw4qx9G13dL1eN65vay6IFfBzfpIlQQ7ZqtbongB4CuwHsCPGoEQMWCi
         /bTq52+XjmohwTk68+jJgth61hkS9HNUwDYrBtigWblodK9KbYu9PAu5aCAXrwKoXR11
         HhHsyLryoj1SuxpyArCR2u5BQY4Fzf3B5sUhbTPvrJfBVXYkjCgtmtJuW0iE42aBoQXc
         GkTsbx8gdzOrgxvnGdC5yIP2c/TAofmB4EMLddkw0qnWC96hKlbjheLpxHEJ/kjH1OxH
         dQoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774998028; x=1775602828;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KZrJJG+BUOXCgvao7M4HPDJpbagyCTvtNjqLqKAeBdA=;
        b=repSHEtZDk0zWiP5mJUoBHwKA6k5cgoE8HnpFPlaDsTs3HlVoBgL9ttcr1nkA7QdSN
         QdZGX8/M1c8I5abFstoQr8pSRl7H03CAlItA7owc2sa/qNBlvIICV+xhSEh5VrswmWRY
         m/8xgL7wjzFEX3T7d6MI9hOhX41wuUb9O4JFcV6FjKSdA3yzW9lSCN817wZVTVM9bcKv
         9Ot4GiMERu1squ3Gw575nGjbPO/uQjxxZweFeBULjqNC6fL07OpqA+ojVs+AYVcNTVWq
         ronnC7g+CZO9zlwPmBCKDqi9WVQh/537JAa01yJl9Vh2qoy/uT7s2P49pLuAcj4/6JA6
         CLrQ==
X-Gm-Message-State: AOJu0Yw8cLEXJe+vBSNtQP0Fc5TSTPxuNePiuFQgx3/Rr/2hPeaYpGd7
	HZkQ52Y8ozWt9ATaYoMSMGG0gznaItZkwztHkPZu5dN+8ksR3y09gPH2
X-Gm-Gg: ATEYQzx5tVoep/awarIuRhmJf4IIc8yM0Fky5kD5sZdTok2mgDSZoGqkQFm+/vKiOiX
	rMiASzrxg8p82DuYfZ9BRoFRvg8sOTJdJ8XIyHAoruZyuQYN6/oiXthHVr3pY0jrmzLVaNlA8XV
	pksV8yCLLd+hY5k19IOxt16in+QvF25wMH8nJJUbprL+pSJc6KsxyzlF1eAvuCCI4738xa5vuFg
	gWWQLcyfNaodHnKUX11S7iUyP0jGvU5Nxmb7nVw2ZDUWJIKcFeK6DE1H/h/4QUi+0pxNIw6HnvY
	ZgNP+tp4tZ2wlGf4N/tB/SS2UDIePWcRkA9DgJhtUn2g4jwzkJVntIvEVinLO2wyn3CWDtynA1w
	WxAR8rVjDszMXtTXoC5KwOtNgTdOJKeX33J2aJTZO0sAf2Xhuaoa9LqldE09kB1Zwz6EQNjQPpt
	ZfJ05MH8acBblvzUKJ3c/bylLQTUYGR8lvp4MbIA==
X-Received: by 2002:a05:6122:3288:b0:56a:e46f:2cfa with SMTP id 71dfb90a1353d-56d8a916d32mr621207e0c.12.1774998028157;
        Tue, 31 Mar 2026 16:00:28 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d58a7ba96sm13948214e0c.17.2026.03.31.16.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2026 16:00:27 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Tue, 31 Mar 2026 20:00:03 -0300
Subject: [net-next PATCH 03/10] net: dsa: realtek: rtl8365mb: prepare for
 multiple source files
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260331-realtek_forward-v1-3-44fb63033b7e@gmail.com>
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com>
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
X-Mailer: b4 0.15.1
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273776-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,bang-olufsen.dk:email]
X-Rspamd-Queue-Id: BD5463728CB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alvin Šipraga <alsi@bang-olufsen.dk>

Rename rtl8365mb.c to rtl8365mb_main.c in preparation for subsequent
commits which add additional source files to the driver.

The trailing backslash in the Makefile is deliberate. It allows for new
files to be added without clobbering git history.

Co-developed-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
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
2.53.0


