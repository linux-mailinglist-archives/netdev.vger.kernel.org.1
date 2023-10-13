Return-Path: <netdev+bounces-40577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 87DB27C7B43
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 03:40:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E904282CF2
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 01:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775A2A46;
	Fri, 13 Oct 2023 01:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NMYo7I5T"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F4A2A
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 01:40:40 +0000 (UTC)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADE5C0;
	Thu, 12 Oct 2023 18:40:39 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1c60cec8041so11778215ad.3;
        Thu, 12 Oct 2023 18:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697161239; x=1697766039; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DPRv8euwqQAa5HdZHHBN6wIaMRdX8/c/YtM/0mxI+pE=;
        b=NMYo7I5TNL7PS+i2v+B1shU6yo0Fn09Yj+CahIGQ9DhsiWY/kYer+hvbc0VJ5ddYTA
         HQ/qr6fCTYF9URPe/TtwdmHtfGGbDeaRTAGVEAGB2qbLISisEycwbY4uWepSVFWSfNeE
         K5Bor3lG03spt+Zm6hgpLMqtyHlhTrYzzUD6byQAyFuHQrCBYUg2jOxxUcBOUPYsxv5R
         tvEYOoGJK7tP1DZrFr0CoOSwVLrOzyqRVTXU2zUv2/LN7e5tvXaZ9EhnArqD/81JVx4R
         WcNBCTU64sl2Cjk17rCXN33gkaugfwGoYTTUiFwnZod/ITUGMcobYtH4se92vxGKFDLb
         TbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697161239; x=1697766039;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DPRv8euwqQAa5HdZHHBN6wIaMRdX8/c/YtM/0mxI+pE=;
        b=iNeM8U3rx7LPFPbm5dWXKRBzoKD+jmrZrtzlChJgalWEbYdUtiHVW+oM21aqif+/57
         WUfzwF/tnN9nKetsV5lRxk0WD7P5nblSds1aOMOty7mR2ZIVdQmXxLqEEG7We0DXdNGK
         gqINhfwq2uzjLSAWp42yRiAyVBO1eH/AY5XkhHHihC56KZBjX9+LpDd3wfulnO9O1nqe
         bpuWjvJSqqd2bDOZLdxyO2PkHn3Ullrk32oR/ivohvbQMMZP7mBwG2r33iCseXPUqZcP
         +clAl7dwc4G5CQOJbI2kQEBAhchDWYbVCEhVy5n0KZeEhg34FGNCqUWNEy/rOjHZwM7b
         y8sA==
X-Gm-Message-State: AOJu0Yw72pw5y/UWkFbqO4PJx4zdv2ytGZ7XQLAyrePPMSZElR2eDlBD
	IX9r5udB6KPZlI93QiQVMSSt47YD0SY=
X-Google-Smtp-Source: AGHT+IGBasQQEGBylu4xLdfmCeBc4KvZVNz4nf3xyb7wZenF2/oIQw0+WhOQyy/S/QTJopSmgHUpcg==
X-Received: by 2002:a17:903:1d0:b0:1bc:844:5831 with SMTP id e16-20020a17090301d000b001bc08445831mr28397725plh.57.1697161238821;
        Thu, 12 Oct 2023 18:40:38 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id jb15-20020a170903258f00b001c88f77a156sm2625374plb.153.2023.10.12.18.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 18:40:37 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 1C9D89AF595C; Fri, 13 Oct 2023 08:40:34 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>
Cc: Loic Poulain <loic.poulain@linaro.org>,
	Sergey Ryazanov <ryazanov.s.a@gmail.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Mat Martineau <martineau@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	"Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>,
	Alan Stern <stern@rowland.harvard.edu>,
	Jesper Juhl <jesperjuhl76@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH net 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
Date: Fri, 13 Oct 2023 08:40:08 +0700
Message-ID: <20231013014010.18338-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231013014010.18338-1-bagasdotme@gmail.com>
References: <20231013014010.18338-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1641; i=bagasdotme@gmail.com; h=from:subject; bh=fer1JEyMCuXDEzrPviMyVtehFTiw4VVBtxEKLeWjkYc=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDKkac6t9zScGf56teZbFL/P+3s85fWydraWvMnMNCxK4j kqkH73fUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgInwnWdkaL7y6t7V86LnjrtW Nl8wm7KrXvU5L9fGZ/bWXfdefL/obs3IsKn8X4aTb+S1DrUFtr/vNDrUGB+qmPkrz192854NBva FXAA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Emails to him bounce with 550 error code:

```
5.1.0 - Unknown address error 550-'5.1.1 <m.chetan.kumar@linux.intel.com>: Recipient address rejected: User unknown in virtual mailbox table'
```

It looks like he had left Intel, so move him to CREDITS.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 CREDITS     | 6 ++++++
 MAINTAINERS | 2 --
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/CREDITS b/CREDITS
index f33a33fd237170..bee086b6bbf2e3 100644
--- a/CREDITS
+++ b/CREDITS
@@ -4308,6 +4308,12 @@ D: ZyXEL omni.net lcd plus driver
 D: RTC subsystem
 S: Italy
 
+
+N: M Chetan Kumar
+E: <m.chetan.kumar@intel.com>
+D: Intel WWAN IOSM driver
+D: Mediatek T7XX 5G WWAN reviewer
+
 N: Marc Zyngier
 E: maz@wild-wind.fr.eu.org
 W: http://www.misterjones.org
diff --git a/MAINTAINERS b/MAINTAINERS
index 4b2c378b4fd930..785c8b13e74df6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10879,7 +10879,6 @@ S:	Maintained
 F:	drivers/platform/x86/intel/wmi/thunderbolt.c
 
 INTEL WWAN IOSM DRIVER
-M:	M Chetan Kumar <m.chetan.kumar@intel.com>
 M:	Intel Corporation <linuxwwan@intel.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
@@ -13504,7 +13503,6 @@ M:	Chandrashekar Devegowda <chandrashekar.devegowda@intel.com>
 M:	Intel Corporation <linuxwwan@intel.com>
 R:	Chiranjeevi Rapolu <chiranjeevi.rapolu@linux.intel.com>
 R:	Liu Haijun <haijun.liu@mediatek.com>
-R:	M Chetan Kumar <m.chetan.kumar@linux.intel.com>
 R:	Ricardo Martinez <ricardo.martinez@linux.intel.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
An old man doll... just what I always wanted! - Clara


