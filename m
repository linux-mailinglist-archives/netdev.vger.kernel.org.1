Return-Path: <netdev+bounces-39521-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F36B7BF93F
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 13:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70C421C20C70
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 11:08:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 071BB182C3;
	Tue, 10 Oct 2023 11:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="ME9OjRnq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5916B18AFB
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 11:08:44 +0000 (UTC)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53F77A4
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:43 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9b98a699f45so928730366b.3
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 04:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1696936122; x=1697540922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kM02SIuCjPQuvbcPkGwYEgRE2+V9EtA2WBhqCYO5cok=;
        b=ME9OjRnqfQGHbPWbSE/mVyniAoVD+4EBIH7Jd2meVG8n+Q0cRWbiTbJoqxyW9L1I4A
         ioTqlVjXBAr03SdFZITKM6qCqI5G2Sjf1+OwJegWdD5x/0bozct+YFRhnrGmqO6zmjO5
         m6K2qzxXr1nNOEp4v0wvK7fjSwSUjWK9LGoxMGS1QuQWg77xUuMpnJwJ/lkGMOkkRKj7
         LkxxvtlmCSRcuVkP/IxTGtT2vhyGsE9Vgm02Wz6ObkPWJuZmcXWo2fNsVxoo2ATFVNlf
         VuuxfT2hg1paynN0Rs38fnmuyJ8ZZlwk058RjNA6HjbakTExJvwGIqskBn2vxF/wRJUw
         RL1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696936122; x=1697540922;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kM02SIuCjPQuvbcPkGwYEgRE2+V9EtA2WBhqCYO5cok=;
        b=n88/ajCqrg6GSGElj8xTKNgUoMUIkgzdDt9TpTXZ8SiIrAbcYAQe0RC/FP/5Od1PHT
         YZ/d3JWktXq4q9RixXoq9fcf5+Rj/gv4Y+5JNpQrK1EGGzGsvbet6yB9VMgor1+uccJC
         YOafz7oCvz9elXYCqXHXnaOVwVeO1pi5w34HYkLAGUObcYZ2DLLACkySITrsIjFK1uf4
         aOvHzHXgJRCD/oHyR/zUSOLpZlHJrXkIK1uF9UpZvWDqL6c6l5ccKou9CviLw62SIz0F
         YyyvKnI6+z1esCHpqskk8sp46vQHlD+qdIMWE1tWtL08qogFvaYwimd+Kig/tGEaVH1z
         CtXQ==
X-Gm-Message-State: AOJu0YwW05QgfPhvdTcrMzZNYLTjNsu3M5qsMv19I7RXrX5NZp+28Enj
	/U7V5t9pw8G1LnJELn+Po/bZB4FqmctcnNXV6dU=
X-Google-Smtp-Source: AGHT+IF6lRf/x16foJsd/RnTQc+XDNMU47bMjNulDxStzvIurVatlKuYAqUtfpdooUhZ2fARjghVRA==
X-Received: by 2002:a17:906:2101:b0:9b8:8bcf:8732 with SMTP id 1-20020a170906210100b009b88bcf8732mr15755011ejt.43.1696936121910;
        Tue, 10 Oct 2023 04:08:41 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id w13-20020a170906480d00b0099b76c3041csm8255439ejq.7.2023.10.10.04.08.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 04:08:41 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next 06/10] devlink: make devlink_flash_overwrite enum named one
Date: Tue, 10 Oct 2023 13:08:25 +0200
Message-ID: <20231010110828.200709-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231010110828.200709-1-jiri@resnulli.us>
References: <20231010110828.200709-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Jiri Pirko <jiri@nvidia.com>

Since this enum is going to be used in generated userspace file, name it
properly.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/uapi/linux/devlink.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index cd4b82458d1b..b3c8383d342d 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -265,7 +265,7 @@ enum {
  * Documentation/networking/devlink/devlink-flash.rst
  *
  */
-enum {
+enum devlink_flash_overwrite {
 	DEVLINK_FLASH_OVERWRITE_SETTINGS_BIT,
 	DEVLINK_FLASH_OVERWRITE_IDENTIFIERS_BIT,
 
-- 
2.41.0


