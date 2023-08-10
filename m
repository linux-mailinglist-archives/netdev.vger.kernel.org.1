Return-Path: <netdev+bounces-26245-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8991E7774F8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE6E228201B
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 09:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C3B1ED20;
	Thu, 10 Aug 2023 09:55:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC3431E51F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:55:17 +0000 (UTC)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4F13E7F
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 02:55:16 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-4fe1c285690so1014300e87.3
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 02:55:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691661315; x=1692266115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kJN6PmBUbtaOFJo3kd3/wgKNS54x0sUQI5Hg4mm3fE8=;
        b=HxKdoY1jczNlJRSW36ZBlzMOMPt480cRAgPSP3hHz2sUR/T/NUI+djlCICBK6gLUOy
         zboeYaoFrIwTnDB10gcaVMGSBxPwefpqdGjpBXDF6gcduRRir2e8lf85YuH/WIlbH0n/
         N1Yil6T2wjKrl9VN5719NQl3HsrnQJ7ewton4RXeJxIS0y4L6xsPGTIxddk2XqZ6hef6
         1txIOVqpqiKeU5OnF3aV2jDu+x6sMV8/yL7D7LOvF6OcJDhsYkXXNuXgya9H+TNpu+CL
         xDvP1Xc0j2LH32Wn/Zi/ayl6K/4BS6LMi9thXVOUycRVjpxsROUuBZxdbM5p80p0tP8t
         6lfA==
X-Gm-Message-State: AOJu0YzDCJuSD426MxVVnTL+NaSsSP634M50Isgft0uoeXMV8u1x1R5O
	ZxnAxR6vZ08l3AVQtQgnKxw=
X-Google-Smtp-Source: AGHT+IE2AkJmXXuGWhTypN9WOBFdEM62pvLGxgMfL/HueD6DoiK8TB+gHFVF51OCRQlXzGRsyDHs9w==
X-Received: by 2002:ac2:548e:0:b0:4fd:e113:f5fa with SMTP id t14-20020ac2548e000000b004fde113f5famr1429964lfk.7.1691661314654;
        Thu, 10 Aug 2023 02:55:14 -0700 (PDT)
Received: from localhost (fwdproxy-cln-001.fbsv.net. [2a03:2880:31ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id k9-20020a1709065fc900b0099329b3ab67sm703957ejv.71.2023.08.10.02.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:55:14 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: rdunlap@infradead.org,
	benjamin.poirier@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com
Cc: netdev@vger.kernel.org,
	pabeni@redhat.com
Subject: [PATCH net-next v5 0/2] netconsole: Enable compile time configuration
Date: Thu, 10 Aug 2023 02:54:49 -0700
Message-Id: <20230810095452.3171106-1-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enable netconsole features to be set at compilation time. Create two
Kconfig options that allow users to set extended logs and release
prepending features at compilation time.

The first patch de-duplicates the initialization code, and the second
patch adds the support in the de-duplicated code, avoiding touching two
different functions with the same change.

  v1 -> v2:
	* Improvements in the Kconfig help section.

  v2 -> v3:
	* Honour the Kconfig settings when creating sysfs targets
	* Add "by default" in a Kconfig help.

  v3 -> v4:
	* Create an additional patch, de-duplicating the initialization
	  code for netconsole_target, and just patching it.

  v4 -> v5:
	* Remove complex code in the variable initialization.


Breno Leitao (2):
  netconsole: Create a allocation helper
  netconsole: Enable compile time configuration

 drivers/net/Kconfig      | 22 +++++++++++++++++++
 drivers/net/netconsole.c | 47 +++++++++++++++++++++++-----------------
 2 files changed, 49 insertions(+), 20 deletions(-)

-- 
2.34.1


