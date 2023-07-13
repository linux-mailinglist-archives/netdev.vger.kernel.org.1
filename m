Return-Path: <netdev+bounces-17691-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B78EE752B26
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 21:46:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EAEA9281D5F
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 19:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E682200B4;
	Thu, 13 Jul 2023 19:46:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01B9E1F929
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 19:46:31 +0000 (UTC)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00F1269D
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:46:29 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso10322365e9.2
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 12:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689277588; x=1691869588;
        h=content-transfer-encoding:subject:content-language:cc:to:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H8FVQt/Ihh7+ze4XBJytPBV8sTM5BLWS3tnCLrJQRSI=;
        b=AGsf9wbC6Dhr49zJIx+Bh5Usq0SzvCNiO4it55aCHAoeo6BGRmEqSuBtc8JaMbwK2d
         WczTDslgsh1jOqXf/TaO+JXL9y1RNQTCPvgJh0lq26g0CA6mdNNPIBCiwrm4sKNqh2CZ
         Zbe4rfsPSdu0Nx8WJLlHdQHJGdD1H/maEI9ECXiUpaHOodWehsp9S+rAtzeRN6jc86ym
         yJdVyB8QisEC0MXBBqigWlYr202uLNolmBIJWrF2Zysigccok7n3CkJcFJkzs3Nk3Af+
         QFSsMLSA9S5tyxIu8U54JutYmUvEoLeFUKUdGrIRYDR3GI2PvAPmy/AXcEmJmRkY22z5
         AEng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689277588; x=1691869588;
        h=content-transfer-encoding:subject:content-language:cc:to:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=H8FVQt/Ihh7+ze4XBJytPBV8sTM5BLWS3tnCLrJQRSI=;
        b=f2GDSttyjkXwlojNcYHDyG9ZOhzfPjIIwMrExRcVxp+Tk2x9tbDCAWVlDOGVUEE6Tz
         53/k4gUPwI+pqPduvL5AQlnR6M1Qq4rtAi0audfg/9M4XZW5rWSBfT0KiPkPUwP5rtUp
         +6UOY8pUJ+ojCdnipqOPRzhtl81QNOgj6l9v/d9kd4nFtBQ52i3yuUieEOIEd6/OQiUD
         FG58ooB7OkpkPhZ+m+PnioI0QjqsEiOmM47f+7b/7D9k56vk/H5cnCavHLxE67Fl+bsX
         QNeheqpSzmrwnWZ0CT8UAUKTfDdNzZ4G9s9gQM/4L4iSpEuJz5AVd8lpERVLuylldS9k
         uq3w==
X-Gm-Message-State: ABy/qLYB06VAa1Cp/otBVe28vqnWgYyDzQ8yKKTwm7P9B76fpqSnDRA3
	l+lMGEmJXSkfl+ylU801b3w=
X-Google-Smtp-Source: APBJJlF7s5wJZq2w8NDMoLnVK/1Jl1PIB9KcEDAO1lMCdTS+QP1jQuAs/R3bMvfH1QdpaQS9kkxyFQ==
X-Received: by 2002:a5d:4090:0:b0:314:16db:537d with SMTP id o16-20020a5d4090000000b0031416db537dmr2220776wrp.2.1689277587868;
        Thu, 13 Jul 2023 12:46:27 -0700 (PDT)
Received: from ?IPV6:2a01:c23:b8ac:4400:ad12:96b1:cbda:7fe2? (dynamic-2a01-0c23-b8ac-4400-ad12-96b1-cbda-7fe2.c23.pool.telefonica.de. [2a01:c23:b8ac:4400:ad12:96b1:cbda:7fe2])
        by smtp.googlemail.com with ESMTPSA id l18-20020a5d6752000000b0031434cebcd8sm8742148wrw.33.2023.07.13.12.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 12:46:27 -0700 (PDT)
Message-ID: <82ea9e63-d8c8-0b86-cd88-913cc249fa9a@gmail.com>
Date: Thu, 13 Jul 2023 21:46:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 joey.joey586@gmail.com
Content-Language: en-US
Subject: [PATCH net] r8169: fix ASPM-related problem for chip version 42 and
 43
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Referenced commit missed that for chip versions 42 and 43 ASPM
remained disabled in the respective rtl_hw_start_...() routines.
This resulted in problems as described in [0].
Therefore re-instantiate the previous logic.

[0] https://bugzilla.kernel.org/show_bug.cgi?id=217635

Fixes: 5fc3f6c90cca ("r8169: consolidate disabling ASPM before EPHY access")
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 9445f04f8..2b3aa6b45 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2747,6 +2747,13 @@ static void rtl_hw_aspm_clkreq_enable(struct rtl8169_private *tp, bool enable)
 		return;
 
 	if (enable) {
+		/* On these chip versions ASPM can even harm
+		 * bus communication of other PCI devices.
+		 */
+		if (tp->mac_version == RTL_GIGA_MAC_VER_42 ||
+		    tp->mac_version == RTL_GIGA_MAC_VER_43)
+			return;
+
 		rtl_mod_config5(tp, 0, ASPM_en);
 		rtl_mod_config2(tp, 0, ClkReqEn);
 
-- 
2.41.0

