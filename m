Return-Path: <netdev+bounces-14469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 612DC741C8B
	for <lists+netdev@lfdr.de>; Thu, 29 Jun 2023 01:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1CAA0280DA0
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 23:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1579F125D9;
	Wed, 28 Jun 2023 23:38:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A9AA125B2
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 23:38:23 +0000 (UTC)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 285111BDF
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 16:38:22 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-553a998bca3so67625a12.2
        for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 16:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1687995501; x=1690587501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=11GUKqOUe5mm/xH9kAyzUO3R487RfQnLA77IgHYuaOM=;
        b=WbA5yksJeKttZ1e1pCkiRnBsM2cQwHzUGpebW5WaUWJAQe6h/8894btRu+KIPQIG5P
         Vf7BMihDDLV9TaRmZQO34pzQfg2ivtEN7X6XMLlfZ/QPGMuSVja2Wbd5wMkaZy/qPy9j
         BwNFJC+Ui/ZqIRCa5ykLODiWLGNMP6Xbxkm5DGzTbKCAj7N3tIDHJMmrnSTIK2EmhkoH
         eKEHkOwFlOre8XxanweTHxacd8YXmZsGkS7xUHpOdTUtXW+S/MGPOPGxobLXvuI+5EZf
         0ayFBjF4jrDgDkO+KWPcvCwe+LvCEOVcBkALAHtgZaUme1yQEdfBp1V5pZErl7a+qSGD
         8X9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687995501; x=1690587501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=11GUKqOUe5mm/xH9kAyzUO3R487RfQnLA77IgHYuaOM=;
        b=PGXljZ9QkZcze5DJ79qGKK0R2QkwkF7SpQaBfQ21fsIAvgyd/FtNGOKi/sG3mYh/yo
         rkojZbO2hqGgL5uISWMQ/Gv5EwVcRra33fp7mHc8IQRvDft0/iJxV6q8s930GDhIHL8L
         a7AihLG1nQROy6r/K0S9I3LSfyVBNO7N0zFc3wfiY8LNpSY2gJufNC0HhR4+Ebqnmgmp
         8U4RBoisW7ijO9B0ZWTcGDpIdTb53jxoarcXKVYacW20qgQV9M19amhbBkrlwbugn61T
         3L4fhDLawyYLp0Yo6sP9ZBMvkk2p8au8n8WOgGEBiKLl4a9RwSHO7E2srkS6ouy7vf/T
         NwgA==
X-Gm-Message-State: AC+VfDwZQCTZQ3Mt8Hukw2dkgyMg9K+dfcbnZpdLC3XzPB0GdLE/q61i
	B00ZrVGp9K56bmu0eLDLfYdyAtd95/C80e0CkhZbHg==
X-Google-Smtp-Source: ACHHUZ59CEdbxguXauJ43O0KPtbQ3CyLfDaSOV1JmWRHbwUTiQI8qHlfoyzGL6/ZZ1/KnE+DCYExUw==
X-Received: by 2002:a17:902:e744:b0:1b6:6e3a:77fb with SMTP id p4-20020a170902e74400b001b66e3a77fbmr18325470plf.2.1687995501432;
        Wed, 28 Jun 2023 16:38:21 -0700 (PDT)
Received: from hermes.local (204-195-120-218.wavecable.com. [204.195.120.218])
        by smtp.gmail.com with ESMTPSA id s18-20020a170902a51200b001b7fb1a8200sm6437196plq.258.2023.06.28.16.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Jun 2023 16:38:20 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH iproute2 5/5] ifstat: fix warning about conditional
Date: Wed, 28 Jun 2023 16:38:13 -0700
Message-Id: <20230628233813.6564-6-stephen@networkplumber.org>
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

Gcc with warnings enabled complains because the conditional.
  if ((long)(a - b) < 0)
could be construed as never true.  Change to simple comparison.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 misc/ifstat.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/misc/ifstat.c b/misc/ifstat.c
index 4ce5ca8af4e7..f6f9ba5027d3 100644
--- a/misc/ifstat.c
+++ b/misc/ifstat.c
@@ -608,7 +608,7 @@ static void update_db(int interval)
 				int i;
 
 				for (i = 0; i < MAXS; i++) {
-					if ((long)(h1->ival[i] - n->ival[i]) < 0) {
+					if (h1->ival[i] < n->ival[i]) {
 						memset(n->ival, 0, sizeof(n->ival));
 						break;
 					}
-- 
2.39.2


