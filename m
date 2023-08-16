Return-Path: <netdev+bounces-28257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6452F77ECB0
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 00:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 836E91C2122D
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 22:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B661AA80;
	Wed, 16 Aug 2023 22:02:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC593D60
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 22:02:13 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F91110F0
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:02:11 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d6ac5db336eso3980281276.2
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 15:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1692223330; x=1692828130;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AEgXkqWugst5jpvZPX+zODKf8ex3uSn1z5+M2WdsKVI=;
        b=IZVBiRmCHTvB6nW+nDMW/+pfySQdG4Eh/owHKPUYTh9sOFpsWi46f5vrqTzzzKtzka
         aWvMP5yoHR6WKNfgNPSfURBWIgVY1lMsFdzHL9JhzmQV8k1R9DBV+6MQfl5obn9WDyrn
         cqt+trpq1u/KmbR/SyOU2GQlAm3fMeceEnj4d/GbkkKANSAk5Cr30CplONxjAp5ujZ4v
         G44xKnj/XyV1GFvwjBsHfMFZp78I9/j3skDALsOo6i45EE6SaFEqxZWV5KClqogf9d7X
         pdkqmcEr4/nhhXsXV9TyqlaITwed0UMVRLqLuzCExRB+oWv+p+/FKn6fhQtHy8A8wed6
         8/aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692223330; x=1692828130;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEgXkqWugst5jpvZPX+zODKf8ex3uSn1z5+M2WdsKVI=;
        b=TF9KyBZi92qXb54oG0apS7Ps3NXnAiHbmyw0xAcZVjdtXWv1AQjd+PLjyf+Yvhyz78
         gMnGkepvJTXvogTXlnXcutnc/cETl1RHR7iybQ245OPdkmV9Ih1lKihBYDxKybg4O03U
         Z9F290CvRKi9ayb4CHol0ZKY4mo8DiilQH/qR6fn5Tx5ed5ZzLQ4YWHR/SVCvZy5+1tw
         mI4RhGI6sAFQFmTzcjzNAW0uoCYjMlWQma0qibBgNnEX6387jpooeqLVwm1HK4NBdAa4
         wxmcYFvEx1CYnK5Q2YUjx9xoq8MS7ay9X65+LAzYjguY5i7vY5X79nl4HSwyXenDZrFd
         a1Mg==
X-Gm-Message-State: AOJu0YxrCMiqDwcHkHSHZeehNfOon3DeyRWFCMmFEJD17oy2M8fxG6+z
	c5vEKNRshLI0RD9cpS+aTZvzD0/NQw==
X-Google-Smtp-Source: AGHT+IFUSuAULl7JZtvhiImMO/QnrqjheT34vEy9FtfecbnLJwzfg2T/GBFji8ZI3fzwNBKiQSUg1WdbPg==
X-Received: from prohr-desktop.mtv.corp.google.com ([2620:15c:211:200:bdfb:a4b1:29c2:c4f6])
 (user=prohr job=sendgmr) by 2002:a05:6902:1609:b0:d07:7001:495b with SMTP id
 bw9-20020a056902160900b00d077001495bmr49008ybb.11.1692223330661; Wed, 16 Aug
 2023 15:02:10 -0700 (PDT)
Date: Wed, 16 Aug 2023 15:02:03 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.41.0.694.ge786442a9b-goog
Message-ID: <20230816220203.1865432-1-prohr@google.com>
Subject: [netdev-next] net: release reference to inet6_dev pointer
From: Patrick Rohr <prohr@google.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Linux Network Development Mailing List <netdev@vger.kernel.org>, Patrick Rohr <prohr@google.com>, 
	"=?UTF-8?q?Maciej=20=C5=BBenczykowski?=" <maze@google.com>, Lorenzo Colitti <lorenzo@google.com>, David Ahern <dsahern@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

addrconf_prefix_rcv returned early without releasing the inet6_dev
pointer when the PIO lifetime is less than accept_ra_min_lft.

Fixes: 5027d54a9c30 ("net: change accept_ra_min_rtr_lft to affect all RA li=
fetimes")
Cc: Maciej =C5=BBenczykowski <maze@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: David Ahern <dsahern@kernel.org>
Signed-off-by: Patrick Rohr <prohr@google.com>
---
 net/ipv6/addrconf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index 5184bd0ceb12..47d1dd8501b7 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -2742,7 +2742,7 @@ void addrconf_prefix_rcv(struct net_device *dev, u8 *=
opt, int len, bool sllao)
 	}
=20
 	if (valid_lft !=3D 0 && valid_lft < in6_dev->cnf.accept_ra_min_lft)
-		return;
+		goto put;
=20
 	/*
 	 *	Two things going on here:
--=20
2.41.0.694.ge786442a9b-goog


