Return-Path: <netdev+bounces-44699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1DD27D94A9
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:06:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3456F1C20FC2
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 10:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6527F168CF;
	Fri, 27 Oct 2023 10:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="VhXq9unJ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98E9C17732
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 10:06:07 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC8910E
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:06:04 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c50ec238aeso26628911fa.0
        for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1698401162; x=1699005962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EzUFAA0TdPmj/Cb4HKxf5oHBR+/7qG5RzYUy2yOEkT4=;
        b=VhXq9unJJzUaKJ0Jg1y1kfTx6dum6K1IVYtyqWi3MsDIzBlw+oNDQRmg4pZYsu+SJR
         WHJ01If5Tin8kLPKIaZLMUS9tBHH7K/jy4MR1PBlM/AlxXK1F8tE2iCVx/QNaJrsBOLi
         sRErgsbfISYfDigukmfTZlH6UjS9b/0+2IX9P5mq+FHp56kIn50sQTc5xEjhzv/XyJGD
         /mmJFpc8RdINmDHQn3fcvrcm6gbU37T8ghFJ9geRg+p7IdFgZi2UEmkD/gfBAd/Q/mLu
         2JsN7/JGFcvtQyL448kzZdhAVt8+U3pTT+8NsrSknz7pLUduyrSUVjEYTbSZ3cLiIOIQ
         aIFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698401162; x=1699005962;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EzUFAA0TdPmj/Cb4HKxf5oHBR+/7qG5RzYUy2yOEkT4=;
        b=KBmXqn/33WuQj6kNaSNCW4dP4VwX2ec+bauZQsND1PNTU2gMLyGR5UGu1j/3gJj+gz
         MXakyhzC0j8Q2g9rrUaddVvov8gw0we5csYzVtMhiH85rXFhHez1UGIGe1J4FvHSArWJ
         FqwBwvp1U1YrsJoQ9gWm8Iwnk/lprXXwdbaYcDMaglPtaJZewQhIoSEzrxRI9aeXUGgF
         XkKKGwAhKfEu5MzmCOmUu5iX0TJFM99oewZe1koEDs0am3EPrcK4RLfgiGiPTx3QJF6O
         f5ogo9m0HDOrqy9VhDEyPAamHavGQAXEzC1ypYE+yHpdLqaT5KPWWezu3kHbnd+8o8gO
         qUEA==
X-Gm-Message-State: AOJu0Yz5dbcfD67keC+FnXR2bxyVbXlBp0znAs6r4b1h6fWmebN+fbRd
	cdGn8H/fj/P/tWwAkG/9JI+OIbioxcLi4iFfUQQ=
X-Google-Smtp-Source: AGHT+IHMw/VGq/ex38Jd96pI1ZaMYN2dDPL+SSmNkWe+mKerLueKy0bGPXr07gAo++VUysXUUy1H4A==
X-Received: by 2002:a05:651c:319:b0:2c5:7afd:75a1 with SMTP id a25-20020a05651c031900b002c57afd75a1mr1598290ljp.44.1698401162166;
        Fri, 27 Oct 2023 03:06:02 -0700 (PDT)
Received: from dev.. (haunt.prize.volia.net. [93.72.109.136])
        by smtp.gmail.com with ESMTPSA id j15-20020adfb30f000000b0032d8eecf901sm1430586wrd.3.2023.10.27.03.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Oct 2023 03:06:01 -0700 (PDT)
From: Nikolay Aleksandrov <razor@blackwall.org>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	bridge@lists.linux-foundation.org,
	roopa@nvidia.com,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next] net: bridge: fill in MODULE_DESCRIPTION()
Date: Fri, 27 Oct 2023 13:05:49 +0300
Message-Id: <20231027100549.1695865-1-razor@blackwall.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20231026190101.1413939-1-kuba@kernel.org>
References: <20231026190101.1413939-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fill in bridge's module description.

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Nikolay Aleksandrov <razor@blackwall.org>
---
 net/bridge/br.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/bridge/br.c b/net/bridge/br.c
index a6e94ceb7c9a..cda9d7871f72 100644
--- a/net/bridge/br.c
+++ b/net/bridge/br.c
@@ -477,3 +477,4 @@ module_exit(br_deinit)
 MODULE_LICENSE("GPL");
 MODULE_VERSION(BR_VERSION);
 MODULE_ALIAS_RTNL_LINK("bridge");
+MODULE_DESCRIPTION("Ethernet bridge driver");
-- 
2.38.1


