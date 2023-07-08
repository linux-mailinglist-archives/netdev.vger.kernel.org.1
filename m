Return-Path: <netdev+bounces-16228-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A0774BF43
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 23:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6655B1C208F8
	for <lists+netdev@lfdr.de>; Sat,  8 Jul 2023 21:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575BDBE73;
	Sat,  8 Jul 2023 21:20:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4940110E3
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 21:20:42 +0000 (UTC)
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B28E1BC
	for <netdev@vger.kernel.org>; Sat,  8 Jul 2023 14:20:40 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4faaaa476a9so5022725e87.2
        for <netdev@vger.kernel.org>; Sat, 08 Jul 2023 14:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688851239; x=1691443239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y53xA5MYwk0Gih5psD+KZAs65u90ju8iFgTs0miVj/E=;
        b=OSRCvmrjgThKu+L2IhhTk/16Cbke/D11AKSgKmwFJitQ+Yh0kH2NOY5MBpz6dePYS8
         UNYPfasRgWJpnm5cReLE0OALyaQqVXxFPi+nHf+JBJ70NbqojHo6Fzy3tk78VEHETsRx
         iu040FqSUBZ01n1fgnbzRoLruH2LQj/y/TkSCS3pakmj/pKG4chVObdpZuQQAbDsjVyJ
         8n+F71RTfWV9yLD+U84d9BPkGdKck1QahObfC7xwWEZNJIRvWyVscp9GyQti87ScPnbR
         uqcvfpiye1cJ/apZ98Y7pGa8iO0FW/46Os/fDB1wNqXgmpZ2SqxjtrSNMg/OlGmvW6BR
         6DTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688851239; x=1691443239;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y53xA5MYwk0Gih5psD+KZAs65u90ju8iFgTs0miVj/E=;
        b=WyzDicxfVl+uprK6b/RV4IepxS72sNDnVkc37BAINS1GNg+Eg3RukmRNQuhz69tiVq
         w3jdu8RbqjGNI5WynnR4RuXSKToaND6sEOL0Bm6XgLwWl7HbRH0v96tLe52JMoQODnn7
         dhVmBOk+alMGAvVIshbAQn7ADLpli+60TddPsnxDG52YtW101I5Fmmp2AtGVCQYMjxa3
         aEw9SsOvP9ZFA/TKl+GScZb75ynX4zf8PmlavqgjAOv+/DuaueWpIqbW1N3aXJh22Q+Y
         zEY8P4+IQfhOjjpixBlgDGmEdoG/zaEI240Y0AmlyHnh1tNXzK9wI2Q9pVGEFtDkuKYf
         xM2w==
X-Gm-Message-State: ABy/qLazH9v+6XUkBP63wLRnAc1a79Ks7JCFfNYKyaw7HKDd1ssRsX22
	oPcKfGH1sJrMKqUkinOU6hDeug==
X-Google-Smtp-Source: APBJJlHjDWvpkLswEYphysTiXyji5dUPMEatlLayYkwM7N6JcviFiXOK7yiGoG0+PJhhYgr6+wYlLQ==
X-Received: by 2002:a05:6512:1186:b0:4f6:d7b:2f19 with SMTP id g6-20020a056512118600b004f60d7b2f19mr5668779lfr.24.1688851238678;
        Sat, 08 Jul 2023 14:20:38 -0700 (PDT)
Received: from Fecusia.lan (c-05d8225c.014-348-6c756e10.bbcust.telenor.se. [92.34.216.5])
        by smtp.gmail.com with ESMTPSA id y16-20020ac24210000000b004fbb2e7bae3sm1134942lfh.56.2023.07.08.14.20.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jul 2023 14:20:38 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Andrew Lunn <andrew@lunn.ch>,
	Vivien Didelot <vivien.didelot@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org,
	Linus Walleij <linus.walleij@linaro.org>,
	Tobias Waldekranz <tobias@waldekranz.com>
Subject: [PATCH net] dsa: mv88e6xxx: Do a few more tries before timing out
Date: Sat,  8 Jul 2023 23:20:30 +0200
Message-ID: <20230708212030.528783-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

I get sporadic timeouts from the driver when using the
MV88E6352. Increasing the timeout rounds solves the problem.
Some added prints show things like this:

[   58.356209] mv88e6085 mdio_mux-0.1:00: Timeout while waiting
    for switch, addr 1b reg 0b, mask 8000, val 0000, data c000
[   58.367487] mv88e6085 mdio_mux-0.1:00: Timeout waiting for
    ATU op 4000, fid 0001
(...)
[   61.826293] mv88e6085 mdio_mux-0.1:00: Timeout while waiting
    for switch, addr 1c reg 18, mask 8000, val 0000, data 9860
[   61.837560] mv88e6085 mdio_mux-0.1:00: Timeout waiting
    for PHY command 1860 to complete

The reason is probably not the commands: I think those are
mostly fine with the 50+50ms timeout, but the problem
appears when OpenWrt brings up several interfaces in
parallel on a system with 7 populated ports: if one of
them take more than 50 ms and waits one or more of the
others can get stuck on the mutex for the switch and then
this can easily multiply.

Cc: Tobias Waldekranz <tobias@waldekranz.com>
Fixes: 35da1dfd9484 ("net: dsa: mv88e6xxx: Improve performance of busy bit polling")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 08a46ffd53af..63ee1545b79e 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -92,10 +92,10 @@ int mv88e6xxx_wait_mask(struct mv88e6xxx_chip *chip, int addr, int reg,
 	int i;
 
 	/* There's no bus specific operation to wait for a mask. Even
-	 * if the initial poll takes longer than 50ms, always do at
-	 * least one more attempt.
+	 * if the initial poll takes longer than 50ms, always do a few
+	 * attempts.
 	 */
-	for (i = 0; time_before(jiffies, timeout) || (i < 2); i++) {
+	for (i = 0; time_before(jiffies, timeout) || (i < 10); i++) {
 		err = mv88e6xxx_read(chip, addr, reg, &data);
 		if (err)
 			return err;
-- 
2.34.1


