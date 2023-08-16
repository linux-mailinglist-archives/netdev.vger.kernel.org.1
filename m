Return-Path: <netdev+bounces-28060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E9877E1B3
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 14:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45A061C2109B
	for <lists+netdev@lfdr.de>; Wed, 16 Aug 2023 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51F9CDF60;
	Wed, 16 Aug 2023 12:32:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B8F1096A
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 12:32:44 +0000 (UTC)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8D411B2
	for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 05:32:42 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bdfb11ea2aso10926375ad.2
        for <netdev@vger.kernel.org>; Wed, 16 Aug 2023 05:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692189162; x=1692793962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Rgx5N6H6hM4C9x/ItXoCkp885/IrXUuodxrLkhO9ks4=;
        b=Jw1Vu6ZhYKqKSoO0kDDOjtBH/SeAptmZBYY3szMTq84YpjHUctysx6vkDcOudApaiu
         QONylOdR/FrlnwHVJg2h6Y54J9Tu+DWkUlHyCL/OEjf2gBLFdB50uE5L2l07c7xoIbZ+
         TYoAnJ8WbUfHTJ5MLypx9s/PTjjZO9XxdflxlTWMcb7qfrQ5sJNHBuiW2Ga0JCWPMa9v
         Nstx4yaGKTTa844JJv8QnjJn+uVIOqhaM8wKNc5dTYV3VHheto/igxCEd637q2now86t
         PSzgYR5cA2+itCmHsC54bpB+O1u+oWqHcSQs7wAR+9TYHxzURi3rWfUkdx+F9CrZsH3F
         xY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692189162; x=1692793962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rgx5N6H6hM4C9x/ItXoCkp885/IrXUuodxrLkhO9ks4=;
        b=V71yFmUqbD32Eu6LMiwyPpEJ7cAa7h/ZU+G5JA2VEr3eBwZCNEASm4rT1qM2sGs/Wk
         ntFFILlTvyAuDC9v6Dn3vXtn4xOcnNrwsu9jAuIgDgOhappD6hFaWaarCZWAu0tYg/dL
         yPaMlSpRPAbhAt0IYsUXiaIdyJkxL7f8FvvUh6aG7hH4Y5S04u3Cv6bvIeX4pRLqYwmL
         PWvlrLRdoc+O5eV+pEblCUyQsNC89wAC2Jw81lWVQGof0m0VKw3dUt0YTfgnA71BIvQE
         gqInpY/m9Tlc3LnB7Xc4wQ78YqX4MHoxRdTkBJyiapydFFxoEmQJEBHr5kjhOtNpfC54
         J06g==
X-Gm-Message-State: AOJu0YwGICUPnir+WijhP+6o8fKkdF9J2eGBk4sCfQuXR3qJCfU6SeRD
	YnmCe2tkPllewjFoKBNZtWU=
X-Google-Smtp-Source: AGHT+IGOH89TrkK7tMouEQwNbzU8Vs/ZgMl5CnRSGl2SVBAOuwYR5GbQdBG7Kbn0dln2fb1XsU1bNQ==
X-Received: by 2002:a17:902:b283:b0:1bc:4f77:e34b with SMTP id u3-20020a170902b28300b001bc4f77e34bmr1571086plr.9.1692189162231;
        Wed, 16 Aug 2023 05:32:42 -0700 (PDT)
Received: from localhost.localdomain ([50.7.159.34])
        by smtp.googlemail.com with ESMTPSA id x2-20020a170902ec8200b001bba669a7eesm13096539plg.52.2023.08.16.05.32.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 05:32:40 -0700 (PDT)
From: Liang Chen <liangchen.linux@gmail.com>
To: hawk@kernel.org,
	horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linyunsheng@huawei.com
Cc: ilias.apalodimas@linaro.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	netdev@vger.kernel.org,
	liangchen.linux@gmail.com
Subject: [RFC PATCH net-next v3 0/2] net: veth: Optimizing page pool usage
Date: Wed, 16 Aug 2023 20:30:27 +0800
Message-Id: <20230816123029.20339-1-liangchen.linux@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Page pool is supported for veth, but at the moment pages are not properly
recyled for XDP_TX and XDP_REDIRECT. That prevents veth xdp from fully
leveraging the advantages of the page pool. So this RFC patchset is mainly
to make recycling work for those cases. With that in place, it can be
further optimized by utilizing the napi skb cache. Detailed figures are
presented in each commit message, and together they demonstrate a quite
noticeable improvement.

Changes from v2:
- refactor the code to make it more readable
- make use of the napi skb cache for further optimization 
- take the Page pool creation error handling patch out for separate
  submission

Liang Chen (2):
  net: veth: Improving page pool recycling
  net: veth: Optimizing skb reuse in NAPI Context

 drivers/net/veth.c | 66 ++++++++++++++++++++++++++++++++++++++++------
 net/core/skbuff.c  |  1 +
 2 files changed, 59 insertions(+), 8 deletions(-)

-- 
2.40.1


