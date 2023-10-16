Return-Path: <netdev+bounces-41475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD117CB153
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 19:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8805281613
	for <lists+netdev@lfdr.de>; Mon, 16 Oct 2023 17:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CCB31A92;
	Mon, 16 Oct 2023 17:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kzMuA8F+"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5400331A7E
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 17:28:21 +0000 (UTC)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1091A1
	for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 10:28:18 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40684f53d11so55004975e9.1
        for <netdev@vger.kernel.org>; Mon, 16 Oct 2023 10:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697477297; x=1698082097; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GnUN5cuxAgIn1AVeXZDWW/Efxhy2T4tZCHS7uiiKgls=;
        b=kzMuA8F+SZXWnOoOLwbjFBhyf3A2zoQnxTdAD/0BAgRWxlK/kF8d9Jva1U6HVSQ3D5
         /V5v/XnJfNLJ0zHtfF2IRjr7/gGiP74VeHLhlbW7QwO/+6nvKzJ4uJFGUDd0ilk+qQ2p
         N1jUORFJA4dyi9DCycILMwVHgikF1WSATJIbOXxjW9Ut2Sg8br8nS0z0jzPyYP2Tx9fx
         pVVaJjS/OCXnoqBbnndjreUZv4GqROvmbpzfYf32738x2fzrdPUY4DaNmrehY7X6MB6n
         t1PYx+7R5TbTs1DpYjR8bMv/sSmCBFFfhLw5p2ltpwVfLPV4rHE+YFMGDkvmvzabeXXZ
         h8dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697477297; x=1698082097;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GnUN5cuxAgIn1AVeXZDWW/Efxhy2T4tZCHS7uiiKgls=;
        b=b9Ytj8ec2zk2onbQ5o565mfqN2H6jwIPTU1EFz0hTFX0coJCQUgK2x2rgZvu5t90NJ
         GL6ApYN/zGlCfRoyl3CaZJSd2O+pIDID9bMWR15/pQj9RN8epXqPC9SNyxgn/bL3ACQU
         K/4rANuIlojsePfzCEs+gQgKklw7URomBxEqB2lsSpwYDMKkf7SBQRXbQs4z/ohY6pPK
         zwOmdYc5t3Jl9B8Jbna+PXMSCp/LPbPddPODNeKbU9c/tvuHVYZ9ENGMI8vUusgK9ge2
         IZqWrQN86/3SlmvDagzfM4OPvM5wl/gjYwC6MjPqZv2KDIFxOTmsOioL3jMljpslknG+
         cB/g==
X-Gm-Message-State: AOJu0YzURHqNF4GsKfv7DliN3Ag1KOlQfG3VtRqmQfbcsl+KuWWutn1x
	fathnUU0dzodPiaK1Gx+4+dLCQ==
X-Google-Smtp-Source: AGHT+IFvIriZAI51ky7DuqcLEVh5b/T3s0wt9PW2D2Orplfm20a2U8/iKGSHNrjNFmituKSYmvwOjw==
X-Received: by 2002:adf:f608:0:b0:32d:b19b:b3d9 with SMTP id t8-20020adff608000000b0032db19bb3d9mr94924wrp.2.1697477297102;
        Mon, 16 Oct 2023 10:28:17 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id bq1-20020a5d5a01000000b0031ad5fb5a0fsm1906088wrb.58.2023.10.16.10.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 10:28:16 -0700 (PDT)
Date: Mon, 16 Oct 2023 20:28:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Steve Glendinning <steve.glendinning@smsc.com>
Cc: Steve Glendinning <steve.glendinning@shawell.net>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH net] net: usb: smsc95xx: Fix an error code in smsc95xx_reset()
Message-ID: <147927f0-9ada-45cc-81ff-75a19dd30b76@moroto.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Return a negative error code instead of success.

Fixes: 2f7ca802bdae ("net: Add SMSC LAN9500 USB2.0 10/100 ethernet adapter driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 drivers/net/usb/smsc95xx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/usb/smsc95xx.c b/drivers/net/usb/smsc95xx.c
index 563ecd27b93e..17da42fe605c 100644
--- a/drivers/net/usb/smsc95xx.c
+++ b/drivers/net/usb/smsc95xx.c
@@ -897,7 +897,7 @@ static int smsc95xx_reset(struct usbnet *dev)
 
 	if (timeout >= 100) {
 		netdev_warn(dev->net, "timeout waiting for completion of Lite Reset\n");
-		return ret;
+		return -ETIMEDOUT;
 	}
 
 	ret = smsc95xx_set_mac_address(dev);
-- 
2.39.2


