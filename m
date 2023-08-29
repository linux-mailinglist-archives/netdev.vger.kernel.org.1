Return-Path: <netdev+bounces-31148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3F478BE0C
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 07:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 972AC1C209B1
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 05:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C1F63D5;
	Tue, 29 Aug 2023 05:50:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D76E63A3
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 05:50:35 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7209AEA
	for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 22:50:34 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-565e54cb93aso1519578a12.3
        for <netdev@vger.kernel.org>; Mon, 28 Aug 2023 22:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693288233; x=1693893033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pVhmTAQ+1nl4LpZrgkswEEI9/zbW9fNO0askhN/cncI=;
        b=MfbTjpGth+1B3G+9aPlzippZTENKfm9yz/v0I1oLpbkRQ38mLo2j5T1ZrSw19CANiI
         q0HYAsLB8xyOMfyT7MRrRaamVOh+kJN7eQ19/C7EvO2UH/OUik+frdHxEe0mqBkAchNc
         06DjeKmBe+WlbZgLv23rXsUOPe0vZ+DbWP1Xh+xramniRocWKBKjoI7aNupvH8uG6W1C
         1bIOHL1jiFJvOxtgm2z0NS223dqWW/xAJkMgN+3gwgT0pQZKumxUrYvzRY9S7l+FsxLy
         OdcmTW86bMfCSRIiAoXBmjpEToQFJb2u/zuwLbJmdE2auj4Nw8szjEYdDGRy7O8uYgO2
         C5Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693288233; x=1693893033;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVhmTAQ+1nl4LpZrgkswEEI9/zbW9fNO0askhN/cncI=;
        b=MLktTPp3e4w6SH6fH304OVGh12EX+7q43Au/QGvqzqCjcMYK8Q+FGOOvHOntaT2/qn
         y/q0pY4JjgVDxrdzM5sm7Z80//2a5xvIT8L77s4muHW47UWG5BUeBH6sUygiOL4xvvym
         fd1k/1KhjB2YD+iL9cUF2ZVEjSfemD3nmQKlVyCNTNdqyJM3xKbM65xFQuZJ8YEPGjTG
         iy87xLc9299s4wcUSQ8J+LJXC9XUzKC1bZVl5YRTf4g7vzd9yWzzysqAltO47bggpHcp
         Z+Ny1zxoOgTNCWFJN2xwmxsZn3PnvMv3Fn6JWN5PQFI66isaxlGapnBneqabcLNC10uW
         Hk1Q==
X-Gm-Message-State: AOJu0Yx5VDD3saUb6bPHCbNX4WlQ+sh0qrqep8qOr2mHvqJ3iSZc3gTa
	OLLO6yWdHquR6eLhkkBKWXpPrHTHOmd2PxoF
X-Google-Smtp-Source: AGHT+IHARyJvAM32dhEDaiXqLJyxawM+ClFYOGeA+naCE+/tu81U+vQx+VqPB+EglMB2gfI2D2acpg==
X-Received: by 2002:a05:6a20:6a05:b0:130:7803:5843 with SMTP id p5-20020a056a206a0500b0013078035843mr27234414pzk.4.1693288233478;
        Mon, 28 Aug 2023 22:50:33 -0700 (PDT)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id b25-20020aa78719000000b00687087d8bc3sm7897713pfo.141.2023.08.28.22.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 22:50:33 -0700 (PDT)
From: Alex Henrie <alexhenrie24@gmail.com>
To: netdev@vger.kernel.org,
	jbohac@suse.cz,
	benoit.boissinot@ens-lyon.org,
	davem@davemloft.net,
	hideaki.yoshifuji@miraclelinux.com,
	dsahern@kernel.org,
	pabeni@redhat.com
Cc: Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2 5/5] Documentation: networking: explain what happens if temp_prefered_lft is too small or too large
Date: Mon, 28 Aug 2023 23:44:47 -0600
Message-ID: <20230829054623.104293-6-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230829054623.104293-1-alexhenrie24@gmail.com>
References: <20230821011116.21931-1-alexhenrie24@gmail.com>
 <20230829054623.104293-1-alexhenrie24@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 Documentation/networking/ip-sysctl.rst | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index ae196e78df88..65daececd9bd 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2469,7 +2469,11 @@ temp_valid_lft - INTEGER
 	Default: 172800 (2 days)
 
 temp_prefered_lft - INTEGER
-	Preferred lifetime (in seconds) for temporary addresses.
+	Preferred lifetime (in seconds) for temporary addresses. If
+	temp_prefered_lft is less than the minimum required lifetime (typically
+	5 seconds), the preferred lifetime is the minimum required. If
+	temp_prefered_lft is greater than temp_valid_lft, the preferred lifetime
+	is temp_valid_lft.
 
 	Default: 86400 (1 day)
 
-- 
2.42.0


