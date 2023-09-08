Return-Path: <netdev+bounces-32533-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 218A7798308
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 09:03:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7A5228182E
	for <lists+netdev@lfdr.de>; Fri,  8 Sep 2023 07:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8440F1867;
	Fri,  8 Sep 2023 07:03:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A9B15B9
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 07:03:44 +0000 (UTC)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F84A19B6
	for <netdev@vger.kernel.org>; Fri,  8 Sep 2023 00:03:42 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-402c1407139so19553525e9.1
        for <netdev@vger.kernel.org>; Fri, 08 Sep 2023 00:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694156621; x=1694761421; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VRwLn/yXnNs2xVeTU3vC9hmBD8Sa61al2g8apCmPNbs=;
        b=tfWXNszRQwivvuTIbF3YF4SVVW02MXoCeryLcyHX/KWdJ+OmpHU9snt9nyTYm1U++j
         azmV2EdP/pTKGFxd5Yc0/4Er6EnHVTJZfVd+qnJdwPXP2g9dH09SR9a3mg3pd7UaKRpM
         0JXjgkZbkN2PGq46Ba6GMOZZLpZ7jGoIObLYjVMKcxSHsu8Y4GzC0PAgI+Bi9jlK4BgU
         qGygRZF/WLpWCdE5PTiJLOvkdY4aQSLbiWU0oyq74EPs5+B77CIf6rEX2jobF+DO5bhF
         FaAEQ9N21eXBQSDyb+G2sl0emBTta1zVC4Nqpf4DJZlzJo/q34aH52H2xvUqFx8b7CjT
         iYfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694156621; x=1694761421;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VRwLn/yXnNs2xVeTU3vC9hmBD8Sa61al2g8apCmPNbs=;
        b=O7rfWl5x1be8cUAzhPSME33eKJq1psUas/b5jYrtZW/lPI/og9Lp6vxlZYyJfRWSwT
         Oaug6nsWHf/SOqu1BqlDHKlW+9dtKsTztYbD/XqPnZgEqTGQDsg/w3oj+nPiZVuo7pH/
         QV2yZEcd0dRoWJl8dnhKMJCHz4S54PXkLk+pJTJHGVatWUMHLmm0YWN44h1KVmJqJNLi
         4npLKhTqnq5R8mB1HysICTOdTC5uHO3BgcSgDWBgbzjU7w2k79iDq+OWbYs/sYo0VQh6
         H4OxJ3Wu+AmfoMxtQ2n5vvoQ3ulXAjdJOAVHBL0sKgrMqc9q5oUBDs642x9M2VW77/aN
         4Yrw==
X-Gm-Message-State: AOJu0YxDuOAHY5WIV+yiQrxT4L/52N7/ly9TImD6NjXn6OOlbBZyz7cb
	CT+1EKNonBlVHnBEg9x4qKkSQA==
X-Google-Smtp-Source: AGHT+IHXaMtp3QOtjBcz+3G+pXLpG/LbHb9b0+uIlRsYErVGK1E/nhr+0+AXCHRWwkAMu3qkSRXzDQ==
X-Received: by 2002:a7b:cc99:0:b0:401:c52c:5ed8 with SMTP id p25-20020a7bcc99000000b00401c52c5ed8mr1366780wma.13.1694156620923;
        Fri, 08 Sep 2023 00:03:40 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id p11-20020a1c740b000000b003ff013a4fd9sm1188820wmc.7.2023.09.08.00.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Sep 2023 00:03:40 -0700 (PDT)
Date: Fri, 8 Sep 2023 10:03:37 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Lars Povlsen <lars.povlsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH net-next] net: microchip: sparx5: clean up error checking in
 vcap_show_admin()
Message-ID: <b88eba86-9488-4749-a896-7c7050132e7b@moroto.mountain>
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

The vcap_decode_rule() never returns NULL.  There is no need to check
for that.  This code assumes that if it did return NULL we should
end abruptly and return success.  It is confusing.  Fix the check to
just be if (IS_ERR()) instead of if (IS_ERR_OR_NULL()).

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/r/202309070831.hTvj9ekP-lkp@intel.com/
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
This bug is old, but it doesn't affect runtime so it should go to
net-next.

 drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
index c2c3397c5898..59bfbda29bb3 100644
--- a/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
+++ b/drivers/net/ethernet/microchip/vcap/vcap_api_debugfs.c
@@ -300,7 +300,7 @@ static int vcap_show_admin(struct vcap_control *vctrl,
 	vcap_show_admin_info(vctrl, admin, out);
 	list_for_each_entry(elem, &admin->rules, list) {
 		vrule = vcap_decode_rule(elem);
-		if (IS_ERR_OR_NULL(vrule)) {
+		if (IS_ERR(vrule)) {
 			ret = PTR_ERR(vrule);
 			break;
 		}
-- 
2.39.2


