Return-Path: <netdev+bounces-208604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E119AB0C4B4
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 15:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8218F1AA50F0
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 13:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2132D9ED0;
	Mon, 21 Jul 2025 13:02:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF772D7805;
	Mon, 21 Jul 2025 13:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753102937; cv=none; b=icq7J55/nhbdnv7F2hDiGLaCiqfhVyWzL4Kj+KyoWhe4P++8uQohFbmXvhXpg2s8dXED+f8r/MEtb2Qu+oygrqqVbVLL6dMVrEW+5n1Cog0c6pXUADgC8cAmFdEMzV0RSay54hcEyzblNsz271fmSzjsnLyNyF3PXvFbaqso/OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753102937; c=relaxed/simple;
	bh=UeTGUYRKeuwDXve/GI/R0QfycaffmuY7Dt+7pG5Ntrk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Icf5U8flsPEe+VJuoV4afKXHfAFb+0U/V5M74DlTnfNrf5Smwg7TKZYDyXAXDzoKsoXFsGeu1oEwjg5NMIVZQBEcNtAKd8dKntQb7jX+GsJFqYhH/Oev++3mNR5hVtjbF/oOZGA1G/UaYr4tbSTp4MxJNUFJhqpfI0679jN2oe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-60c4521ae2cso7608268a12.0;
        Mon, 21 Jul 2025 06:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753102933; x=1753707733;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2UQvlecl24zUyb5wtS3n9sQxu6Li+ODjsFHxe5Ob9Ag=;
        b=K412awtZpdCx8HyxYOUcpmFZe0ZZWPkEhT55FuchYIaGzzRrVTBIPhx5sP1WI1f5cw
         os8R1IDpo9a5M1j9W/4I4CkpaM0qhYYH+dAIx+Xpw15AtUXj5r4Mjc5L3LvlKO+Cb3AR
         6H8l+OnbW1TaUZP57c4IHSgPRXF6c1YlMrBYSnD1lbchLCwlSWh/6Si/i/3d2JqqFi3c
         hJFrt1rfIBjzrAwJkTtBe85OErDXwYWSRUY5NHwiOr+cnkOBjdRBzqw/dyvDT3/O96wC
         o583swnVYdTrFkgBHKUs+shQvatPtQKLVveE5eUw2j/CeDvdyAaEyyKqa72fokuDK/Sy
         hmlA==
X-Forwarded-Encrypted: i=1; AJvYcCW2aBRA+2P6MNQSaF1bfggpyva6NxiyVPV5Iny21ARH0jPy9IT2RAlaRJL9i3xrV95QLBJtu1v5aiCN+Ys=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+DIS24m35p2FaK2VOMdTNYXgZ/whQWUi/Fdf8CbohutZ3+aZ/
	FwHJ4mJGS9WAW32TGmXlBOTvkl2vr6ceLosPwDQeCP+nmj1UyTkCsvC9YfOHzA==
X-Gm-Gg: ASbGncuz3KqW2ppsmM8uH94UtSpp/Xules8y86sYGHctHfIJmJlx/TsJx8S3iVbMVTV
	Yn/gxQ39v8+KiPdkArOwV2k6HfUw5YXllXXcyVoB+FmGEoA+v9xRrgiH2mU7DkxUaAPc0+KH+E0
	cPcf2DXMW9G7yCnVH61Ffv3pAv0MR4tLKKEUoNYAUTBCrpazjCd8TRyVGDFhiIGbEic49u550mI
	fkYhlXkbJLz6apW20LRVttuMCpoOt82nyyDLrhDFS7dD8fNfbpAVtw3q6RH2NXo1ajJ7qPqB79D
	iH4Aosr5TCuJ9Mm2c98Nnqcwa7XmEzpi+sEABSUcvPLyrrhWiXzuJ1hiztgQQEBVa1whpROzPPp
	aFWvzpstzoHXQ
X-Google-Smtp-Source: AGHT+IFaMoG7c16tc3oC12jUw+W7U0SiaL7+1I8pv6CofVmHpJx3sJasoucoBfeiBOf2deoWQog8Hg==
X-Received: by 2002:a17:906:f5a3:b0:ae3:7255:ba53 with SMTP id a640c23a62f3a-aec6a672a23mr1143845366b.53.1753102931969;
        Mon, 21 Jul 2025 06:02:11 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:9::])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d7b9csm672901266b.61.2025.07.21.06.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jul 2025 06:02:11 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Date: Mon, 21 Jul 2025 06:02:02 -0700
Subject: [PATCH net-next v2 2/5] netconsole: move netpoll_parse_ip_addr()
 earlier for reuse
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250721-netconsole_ref-v2-2-b42f1833565a@debian.org>
References: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
In-Reply-To: <20250721-netconsole_ref-v2-0-b42f1833565a@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Breno Leitao <leitao@debian.org>, Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel-team@meta.com
X-Mailer: b4 0.15-dev-dd21f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1886; i=leitao@debian.org;
 h=from:subject:message-id; bh=UeTGUYRKeuwDXve/GI/R0QfycaffmuY7Dt+7pG5Ntrk=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBofjpOyLAo0ONXYxLsaCtLYZeLoQ8PQJcJ/Yj7W
 zyXhMLDOQWJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaH46TgAKCRA1o5Of/Hh3
 bbuSD/4gFbWhzeR+tVZuf0kiaqgTVijBmROJRRucZPMDRgtNQrGZ/Evlr35NrgjW14xVqH6eLQR
 Vb7bWxOuSi03FxOdGvneY07SpwkTXoPhSuscXU1eSnzFlQ5xtmpNITyNzr8m73wpjolF22L0bsl
 lne+LSJyadDFwV3aR2xIQcHXgVZoZ0iRZ9T1VkYVL2Z8la5VkpV/3B6MMkI58vR91KFzKUV/sry
 X7NW2D+hAhEl1Ueq+pB40aTseh1qSlwMfGfWzQMQGWxTOQlkr+FCBlOH4UMpSzIpyESW7aed3S5
 g3hWTyebIk18qQkkJYJjbPloofir3Sb1mKocOQn6SE5iHhD2Z3O1tlVjKJvziaLe1UD7TUv92XJ
 vGMiplNaP25HJBTg5hCjbIoI7kgbFQgX3jvB5dZsMyfNYBmQV1hX94BOpfefoQ+FCy/bErTpCtX
 vUni/BT2amLY12I+qP76fMvsrpJvElrikAVOt8RAxPZJh71UFOXRd88fJjV0FXcUR1lzzO3S5FO
 9MhQ3IVg9ngivVOG8gcUV+4CIsaoK+JoasI9unsBvxBPtTI79ju9oAIwtf+k7SbE9gKtpmtvzld
 HJprD8lfAAYnAUYiZrdUrIKMJpXwOM545EGFvA7dGNiJc8oAoX6h/pcHJwfSKrGcCAPDimdezYw
 mNyHIazYlv6bhFA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D

Move netpoll_parse_ip_addr() earlier in the file to be reused in
other functions, such as local_ip_store(). This avoids duplicate
address parsing logic and centralizes validation for both IPv4
and IPv6 string input.

No functional changes intended.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/netconsole.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index e3722de08ea9f..8d1b93264e0fd 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -300,6 +300,26 @@ static void netconsole_print_banner(struct netpoll *np)
 	np_info(np, "remote ethernet address %pM\n", np->remote_mac);
 }
 
+static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
+{
+	const char *end;
+
+	if (!strchr(str, ':') &&
+	    in4_pton(str, -1, (void *)addr, -1, &end) > 0) {
+		if (!*end)
+			return 0;
+	}
+	if (in6_pton(str, -1, addr->in6.s6_addr, -1, &end) > 0) {
+#if IS_ENABLED(CONFIG_IPV6)
+		if (!*end)
+			return 1;
+#else
+		return -1;
+#endif
+	}
+	return -1;
+}
+
 #ifdef	CONFIG_NETCONSOLE_DYNAMIC
 
 /*
@@ -1742,26 +1762,6 @@ static void write_msg(struct console *con, const char *msg, unsigned int len)
 	spin_unlock_irqrestore(&target_list_lock, flags);
 }
 
-static int netpoll_parse_ip_addr(const char *str, union inet_addr *addr)
-{
-	const char *end;
-
-	if (!strchr(str, ':') &&
-	    in4_pton(str, -1, (void *)addr, -1, &end) > 0) {
-		if (!*end)
-			return 0;
-	}
-	if (in6_pton(str, -1, addr->in6.s6_addr, -1, &end) > 0) {
-#if IS_ENABLED(CONFIG_IPV6)
-		if (!*end)
-			return 1;
-#else
-		return -1;
-#endif
-	}
-	return -1;
-}
-
 static int netconsole_parser_cmdline(struct netpoll *np, char *opt)
 {
 	bool ipversion_set = false;

-- 
2.47.1


