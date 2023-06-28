Return-Path: <netdev+bounces-14467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 64388741C88
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 01:39:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D248280D03
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 23:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61931125B3;
	Wed, 28 Jun 2023 23:38:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5628E125B2
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 23:38:21 +0000 (UTC)
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062E01BDF
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 16:38:20 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-55b1238cab4so60932a12.2
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 16:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1687995499; x=1690587499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onEX/oRr9tY3MSi85RyuaTMSXEt3k1jsWtH3Fh4bBbY=;
        b=QkIULJzDlujxJfftUIBG5vS8SkYXV5tcdauvGRu3VbP4QtKL9DUsokzjcE2sDfhS3A
         55NO2pIuA8ETVnaPL6O9BkCtv1YdbUQ+QsOWhu/vnxgab3yFdMq0hgDvEuUBPdpjHCZs
         b+2rde/TL309NfzFwnXbv30StHJYWxZZPubJd5mTiUwxebeyIvY0EDP0vYn2P/Bafefz
         Kz7KW6pK8MHzCpcs+n8tKhMlYBMeV2YAu87zaFS82O5HRAR3RySSfWSNTb4gGebw+Dxy
         Y+UCoLhjsRfdio20f9SIu/IwwXHj3MLO532xV4RnjdLOmm/jCGlzkIc31eRsLqXPyg69
         CVag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687995499; x=1690587499;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=onEX/oRr9tY3MSi85RyuaTMSXEt3k1jsWtH3Fh4bBbY=;
        b=LLuIVrT+NhgG25CA6ZSwFdv0s+XS34oxtpGECvIpamOY1/MDlA7INNbAZ7S9Gu9xyo
         tUJ73dIXQoj1NOkrE37IhTPsvP+8IbtktVSgZbmkpXaWWk8Q1S2BtBjBQ5qQeUy3V69m
         qfBIsMSRqlZxOgefk5SF7hTqFTJGB2BoGb7rpvF5pJZPYkHkoh1uPQGkmtK6vgDpecey
         JIbWK4torrsLBTMDepSWA6vf2xof+VD/atw8WE5pfg2/LPyM8/bx6qMJwIkZ1rcbpRxR
         M3NfR7VxLhFdXo4yZrYGZk/HCnxUdrFFMJ1AI0UULRSd56hk0dw4+qe7ZOa5oBLYPowJ
         uh+Q==
X-Gm-Message-State: AC+VfDz/Vm9/bgHoIzrpFgwuwA/+5WJ9xpQ2d2ou+jD0Tbj+3tXhohtm
	5+DhDBE8ix0B3bk/QsaHOjFV7m3IJN/LDxOiGBtbsw==
X-Google-Smtp-Source: ACHHUZ4MMEJ4P9B4XHA5cee67FoLi5ySnj2Wwa8MnvM0A5wIS8Wn5MZCARxXj7T7iOswoeQ+h/URsw==
X-Received: by 2002:a17:902:d4c3:b0:1b6:771a:3516 with SMTP id o3-20020a170902d4c300b001b6771a3516mr12686126plg.22.1687995499128;
        Wed, 28 Jun 2023 16:38:19 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902a51200b001b7fb1a8200sm6437196plq.258.2023.06.28.16.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 16:38:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 3/5] ss: fix warning about empty if()
Date: Wed, 28 Jun 2023 16:38:11 -0700
Message-Id: <20230628233813.6564-4-stephen@networkplumber.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230628233813.6564-1-stephen@networkplumber.org>
References: <20230628233813.6564-1-stephen@networkplumber.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

With all warnings enabled gcc wants brackets around the
empty if() clause. "Yes I really want an empty clause"

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ss.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/misc/ss.c b/misc/ss.c
index de02fccb539b..e9d813596b91 100644
--- a/misc/ss.c
+++ b/misc/ss.c
@@ -627,8 +627,9 @@ static void user_ent_hash_build_task(char *path, int pid, int tid)
 
 			fp = fopen(stat, "r");
 			if (fp) {
-				if (fscanf(fp, "%*d (%[^)])", task) < 1)
+				if (fscanf(fp, "%*d (%[^)])", task) < 1) {
 					; /* ignore */
+				}
 				fclose(fp);
 			}
 		}
-- 
2.39.2


