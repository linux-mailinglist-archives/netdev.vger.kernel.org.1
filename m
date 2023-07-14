Return-Path: <netdev+bounces-17803-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6610775315A
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 07:39:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AFC5282072
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 05:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 260F16AB4;
	Fri, 14 Jul 2023 05:39:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A6B6AA4
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 05:39:45 +0000 (UTC)
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F422735
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 22:39:44 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3fbc59de009so13652665e9.3
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 22:39:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689313183; x=1691905183;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PghXL2nj0bR1AkbvTWEvPVUujehAvZqC6bXTuYKarO4=;
        b=sRtAqt/uPpzCDQx7F84Puxwm7bEoL4jC60zuSC4QHJkoM5Tm/htAgFpM+YZ4utVKl8
         dC+DgmPWfmGZBug6sPsgqRV1RCX3j9zbVnTZTJtnCD8vTKeZhJ7A2uaEC1VLvRF2ZuOh
         EYIIFx/V4rCvGrDaPt1V09DInCondQU96gutLUmE8akVyJRHefhqsPqVuohBoM32AyWo
         AjSvOsXDEKoB30J2+thaUvMlSCt38AEV8CCneVGcuSskS4noFIS4xrhO0qkzofQef8xi
         COVX5lm6rMelLzB+fXGWVHtOWkF+SIKJ4AA3+UqPgoDKiXR9wr/5AYVvFIBufJcKCODb
         Rj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689313183; x=1691905183;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PghXL2nj0bR1AkbvTWEvPVUujehAvZqC6bXTuYKarO4=;
        b=VKLauMv8+A2J1shRdhgZFuws20+qxBEa6gO+ldWUesfzrrGdChqDi+yH54jSFLHsev
         AbrKHnzEhc1xIRbepIrbLmB4YuvAfzKKtUWGfmecZBZjzIro2cUHo3T+dBmVHi13NrbK
         iW3GD4xFa/k0SF2fL1Z+E4qJNh2PhsX2MD6H39y33YFJxXrQsJTT/DjtAF0wWHf810+v
         v3K6qELy6hWldAitPDeHrP0etop2rXXWFN3CfKziCN1hWRj18cICKY7ZPMbbm30vocO+
         oa9b+h/eXhQvaog1ipJ9kmaPKh51lpEyA+t6CbPHh+V+UtPDDYAyiQGVWlACa8hcTLVP
         sUiA==
X-Gm-Message-State: ABy/qLa6IWP1Qh/HMFqgokicjO+HN+XUl0vGz6cOuUfVG7nBUsP3877e
	svohwwfp2ycX7BFPtonR7yg3bF7l7pI=
X-Google-Smtp-Source: APBJJlH42Qc3jaAjtoQ2irlB5opLg8u1XsnD9QuF1c/D3fNThKvjdg7+k2oJUCEMitJob2vpU1Z4qQ==
X-Received: by 2002:a7b:c5c5:0:b0:3fa:7478:64be with SMTP id n5-20020a7bc5c5000000b003fa747864bemr2900437wmk.1.1689313182676;
        Thu, 13 Jul 2023 22:39:42 -0700 (PDT)
Received: from ?IPV6:2a01:c22:72e8:a200:99ec:cf51:6f55:b3af? (dynamic-2a01-0c22-72e8-a200-99ec-cf51-6f55-b3af.c22.pool.telefonica.de. [2a01:c22:72e8:a200:99ec:cf51:6f55:b3af])
        by smtp.googlemail.com with ESMTPSA id f14-20020a5d58ee000000b003143c532431sm9836618wrd.27.2023.07.13.22.39.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 22:39:42 -0700 (PDT)
Message-ID: <f605d9cd-220d-5fa2-142e-746afa9e1665@gmail.com>
Date: Fri, 14 Jul 2023 07:39:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, David Miller <davem@davemloft.net>,
 Realtek linux nic maintainers <nic_swsd@realtek.com>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>,
 joey.joey586@gmail.com
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH net v2] r8169: fix ASPM-related problem for chip version 42
 and 43
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
This resulted in problems as described in the referenced bug
ticket. Therefore re-instantiate the previous logic.

Fixes: 5fc3f6c90cca ("r8169: consolidate disabling ASPM before EPHY access")
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217635
Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v2:
- add Closes tag
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

