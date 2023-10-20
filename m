Return-Path: <netdev+bounces-42937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DD77D0B7A
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 11:22:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AF9BB215C4
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 09:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCD013ACE;
	Fri, 20 Oct 2023 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="wfLWFiMk"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE1F12E78
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:21:47 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5CB41991
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:30 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-9c53e8b7cf4so91135766b.1
        for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 02:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697793689; x=1698398489; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kM02SIuCjPQuvbcPkGwYEgRE2+V9EtA2WBhqCYO5cok=;
        b=wfLWFiMkMMJYstHYZRvoo2+AaLAHaXyVqOlVH8JkXwiR3BaTbpCLaQ6gvEIA5Mlp2x
         Jl7NJmPtz4dMZ0+N+jfYhFCpZ5oUeCRYYhvi8sPxPTqJlPMCWWWFqbS7SFIoRwo/V8cB
         ZOBh89FsnAeZwKMQ5byYC8MV0r/WxhAA3xr7f8OJvMWJdpzW5vLwb9JmsUl2sQNWU9Nh
         t1QOxPot7MpmXWSBKwtBT6htSkNrfSx3r0UmctCxfuriUv2YjWHlzubKZsDjz6k8EM+R
         R3evu7exjqkkxgbRp77fJU61vVf/e4TFypA9PnOGMoQqpaMjD0PdF9Qm78883hdyhpBf
         ruiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697793689; x=1698398489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kM02SIuCjPQuvbcPkGwYEgRE2+V9EtA2WBhqCYO5cok=;
        b=SyCqdKB0YhdrKAqmNQviPmx0U4BO/QTMSU9wwUVxD62/QR0NssW/r9GLG+TM5Mom+S
         O/B4LF8/WeUr1xEDStKpvMODTTjYFZRK0NGX/pq+9yHY4l36HlIRAPv+KZrJm53M+/+L
         6OJc7yM7vOGtQ5lE9u0NJt8ZDnNYMfWNburmxVEgtLvnVDHSTc2v51ar2oR/zDOlvDTV
         0ttRnZK9fRgcOMAzMoBdAEfDhh4hco0QzqgCe5wB1XXzKFjUPYe3g7l+/xxV/NNOeShi
         hLAod+lSO2KlTTX/My4fdC/PT35Hj8xxlDcEa5wNrCqdl5W8fx2djJ2uI/QkE9dHLirh
         0xCQ==
X-Gm-Message-State: AOJu0YxfRDyv6jyVgaBdaON3L26qYZN8vtCWVbjO1POhnGKbWodaHcNs
	HsOxFpRnU62eFbL8zlj+sDc7+MnD8hPl2bPgd2M=
X-Google-Smtp-Source: AGHT+IGrHsBtRkJlZID0t/k82Hn65pWQi91hi3xkkLwqbJ2mn+Gfw8TBmYp50de17A+t1/N4+kdgww==
X-Received: by 2002:a17:906:dc92:b0:9c7:59d1:b2ce with SMTP id cs18-20020a170906dc9200b009c759d1b2cemr808587ejc.5.1697793689051;
        Fri, 20 Oct 2023 02:21:29 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id jt23-20020a170906dfd700b009c74c56d71dsm1121407ejc.13.2023.10.20.02.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:21:28 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	jacob.e.keller@intel.com,
	johannes@sipsolutions.net
Subject: [patch net-next v2 06/10] devlink: make devlink_flash_overwrite enum named one
Date: Fri, 20 Oct 2023 11:21:13 +0200
Message-ID: <20231020092117.622431-7-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231020092117.622431-1-jiri@resnulli.us>
References: <20231020092117.622431-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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


