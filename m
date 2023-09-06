Return-Path: <netdev+bounces-32263-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 000AD793BB4
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 13:48:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D3B28137B
	for <lists+netdev@lfdr.de>; Wed,  6 Sep 2023 11:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4307D507;
	Wed,  6 Sep 2023 11:48:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7CAE6AA7
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 11:48:27 +0000 (UTC)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33B72CF
	for <netdev@vger.kernel.org>; Wed,  6 Sep 2023 04:48:26 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31c615eb6feso2995738f8f.3
        for <netdev@vger.kernel.org>; Wed, 06 Sep 2023 04:48:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694000904; x=1694605704; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oS82Leoqub2W95vZZDo2WS6PwSyrQMpjtL5NGF0oCMA=;
        b=Yq3XSEV0NZL3bDVzLSuC4LhKRk57TZP6EtA7DzC4wt7yc506ekIQXFcfIw5mAxN2+P
         72jkYmsA86ZvSu0FZ8n2l1TIgLPQ3bweRyH+ADKC7MYsB9qJyIfoPf9dqFoja3XQl4bn
         aBezi5qJJIgKhOTo3dVnKyOYc2Spg0QlPyZzX+h8hXV1NDVbzGPb6rlget38cA2LbSeW
         BI1/sa7mREgGqEqn4nZg34L6181RnTMiuINPFioxbCBzwU0LSrcwf29teAcSR6vbKsai
         Jy+U34O60JhERjCHKMaewwm30nEXgLX/bPfjq9zgAvmM4yrmGOuPFHdLrxu+MxegHSmJ
         oZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694000904; x=1694605704;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oS82Leoqub2W95vZZDo2WS6PwSyrQMpjtL5NGF0oCMA=;
        b=QU7LeJXbFWVu9cbpjwNL2iyNRQg7/HdWFmGGHBEEM6EFlIZddWIEIiar3DfuguKVIy
         L81B+kIGxWHG5BJseoAFJrInRMtvY5EpAgRhfqE9fR/LycTRG6sIHMzAakTH90YCQ5LP
         5Ir1sNwzihWz+hT6wVCZ+wBmpBUBPlO40QQ110mtDVazBUhDj1OiP/rG+DJwB9hhgxix
         rlfT2hSEwJ+OnnbZ4GlAIKYhM6PVOHhtFcbIAShmXcx9bYf4mL7llhQgRK+iEHDmFooI
         Qo+oF4TK0XsNBRJDZCzbOv85fWI1AVbjnKQBKkoRjCTW99DuLAAXVvhA1SBLhFzkJnk6
         DQVg==
X-Gm-Message-State: AOJu0YyPDzcOY60Da5kD+edj70sJ3vFhhB9rbbVjfAbYUZrKiVWjYNkM
	pPi+RNVxQwGEG81r2IgLwiTPTt84IS5w0Xlo+i0=
X-Google-Smtp-Source: AGHT+IGaM8Kfaxzl8678JXRb+7hdXFuOhPGqtscx1S1jE8+llUW4xbRq+wKJv+aCHNiG0g8cu7u/6Q==
X-Received: by 2002:a5d:69cf:0:b0:319:6d3c:c5e5 with SMTP id s15-20020a5d69cf000000b003196d3cc5e5mr2166918wrw.58.1694000904688;
        Wed, 06 Sep 2023 04:48:24 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id f12-20020adffccc000000b003143c9beeaesm20158654wrs.44.2023.09.06.04.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 04:48:24 -0700 (PDT)
Date: Wed, 6 Sep 2023 14:48:20 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: vladimir.oltean@nxp.com
Cc: netdev@vger.kernel.org
Subject: [bug report] net: enetc: reimplement RFS/RSS memory clearing as PCI
 quirk
Message-ID: <582183ef-e03b-402b-8e2d-6d9bb3c83bd9@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hello Vladimir Oltean,

The patch f0168042a212: "net: enetc: reimplement RFS/RSS memory
clearing as PCI quirk" from Aug 3, 2023 (linux-next), leads to the
following Smatch static checker warning:

	drivers/net/ethernet/freescale/enetc/enetc_pf.c:1405 enetc_fixup_clear_rss_rfs()
	warn: 'si' is an error pointer or valid

drivers/net/ethernet/freescale/enetc/enetc_pf.c
    1393 static void enetc_fixup_clear_rss_rfs(struct pci_dev *pdev)
    1394 {
    1395         struct device_node *node = pdev->dev.of_node;
    1396         struct enetc_si *si;
    1397 
    1398         /* Only apply quirk for disabled functions. For the ones
    1399          * that are enabled, enetc_pf_probe() will apply it.
    1400          */
    1401         if (node && of_device_is_available(node))
    1402                 return;
    1403 
    1404         si = enetc_psi_create(pdev);
--> 1405         if (si)

I guess this should be if (!IS_ERR(si)) {?

    1406                 enetc_psi_destroy(pdev);
    1407 }

regards,
dan carpenter

