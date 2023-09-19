Return-Path: <netdev+bounces-34915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3767A5E51
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 11:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BC2B1C20F77
	for <lists+netdev@lfdr.de>; Tue, 19 Sep 2023 09:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B26623FB26;
	Tue, 19 Sep 2023 09:40:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 380FB79E1
	for <netdev@vger.kernel.org>; Tue, 19 Sep 2023 09:40:27 +0000 (UTC)
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE9CBE5;
	Tue, 19 Sep 2023 02:40:24 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-3216ba1b01eso187051f8f.2;
        Tue, 19 Sep 2023 02:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695116423; x=1695721223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xTBOgApdCZqtXfBGdHJ8Yj4aJ1bsJAJH5MGuBHuHFVE=;
        b=JC5QLZork8Hz0Vfboei41o5ODZlYjVAcXAxN0Rya119hZI8nPubLu3bpZSOVIsf7iF
         hABK6bAvDdZVgx+UWp7uLlBfCVWI8GE/VLC352B5DgufWDsB1UEFNYMBS5dQyXnRvEVR
         rntDevLqDZu6oZekgtnpkI7unwzULgXNobMXTvQDZsTHxA6vIglM1ATiBmDVhupbRdx6
         zgtl4bcnPmEcJ5apdJeU7uAOBe+50lZMANt+b05yeVzRMnxQwcEvovVEz/sNtmkxf7Au
         0zNj1YUPssOWMahdmsm1JWYI+yNmPv3PjkdGaP9E3lS2EdkG8cghT9BPrcj8IJtQjXNy
         npPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695116423; x=1695721223;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xTBOgApdCZqtXfBGdHJ8Yj4aJ1bsJAJH5MGuBHuHFVE=;
        b=ihQbSfshgaweDt/RNuN81IteDk68QxrJZoUfSafP4M69nM1slNdsptlH/fszVarAc7
         sLav2okbWAPdf4tpXxMnrkZVIE1kREjlEWdiBldmJR9PCvSGWYVqzDVEOGJSvzyadGbZ
         3dGGUR7w2yeT10Gdvent4Am3xezfHCZtunEEqm/Witr9aTrObj6s1i7zRVmHqCl7jjRr
         dwQXT28y/YpbfftoWQu6F3+6zLsaPHfih/e6i9fnS8CVIOy0jQPulywDRjIMdXbbvuEh
         FZNHYHkbEpaOPO2u6WW3Y/A1tTVIhqG+E7yC7UUk6Wk14rkcJHJTSURBQUZbOB2p9j+c
         dkHA==
X-Gm-Message-State: AOJu0Yy8eGWHqkpn7ypmJXJsHmkAoVuqyyW/u4Fv3LY837UoDxBIULM1
	UWWsBgKumnKFT+I3xeLRgPg=
X-Google-Smtp-Source: AGHT+IGvvtaaTRm0rho8AELKVpXh9MSlP/ae7jVRFKj0wZKN+Mgu15qUPVF/AbnEyqmAeIcK/hDU8Q==
X-Received: by 2002:a05:6000:22b:b0:31f:f982:5395 with SMTP id l11-20020a056000022b00b0031ff9825395mr8563350wrz.35.1695116422875;
        Tue, 19 Sep 2023 02:40:22 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id v17-20020a5d4b11000000b00319779ee691sm15014885wrq.28.2023.09.19.02.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Sep 2023 02:40:22 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] net: dsa: mv88e6xxx: make const read-only array lanes static
Date: Tue, 19 Sep 2023 10:40:21 +0100
Message-Id: <20230919094021.24699-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Don't populate the const read-only array lanes on the stack, instead make
it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/net/dsa/mv88e6xxx/pcs-639x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/pcs-639x.c b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
index ba373656bfe1..9a8429f5d09c 100644
--- a/drivers/net/dsa/mv88e6xxx/pcs-639x.c
+++ b/drivers/net/dsa/mv88e6xxx/pcs-639x.c
@@ -208,7 +208,7 @@ static void mv88e639x_sgmii_pcs_pre_config(struct phylink_pcs *pcs,
 
 static int mv88e6390_erratum_3_14(struct mv88e639x_pcs *mpcs)
 {
-	const int lanes[] = { MV88E6390_PORT9_LANE0, MV88E6390_PORT9_LANE1,
+	static const int lanes[] = { MV88E6390_PORT9_LANE0, MV88E6390_PORT9_LANE1,
 		MV88E6390_PORT9_LANE2, MV88E6390_PORT9_LANE3,
 		MV88E6390_PORT10_LANE0, MV88E6390_PORT10_LANE1,
 		MV88E6390_PORT10_LANE2, MV88E6390_PORT10_LANE3 };
-- 
2.39.2


