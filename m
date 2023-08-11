Return-Path: <netdev+bounces-26707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B47778A02
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 591D21C217CD
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:34:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F7E6FC5;
	Fri, 11 Aug 2023 09:32:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F41A6FC4
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:32:11 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B48302D79;
	Fri, 11 Aug 2023 02:32:09 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-99c93638322so368856766b.1;
        Fri, 11 Aug 2023 02:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691746328; x=1692351128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sIQTnICAWyIOt1Hgjl/8UKT20avhM9A3DXCdWfcHe0s=;
        b=WzARiaOWZZK5OzzbZepHRTLwIXGt/TxDu7fP57JAmQ6+s7juPQjn/cSBbyLwJ5Tr72
         C2B9Nxi3gEYxQYdYrzBfYeSJbmq8ziulAB/tlQj8uFNeYbjf+gLj6hjcS50asKpcuPP7
         kWQJjRRcJsI2cDXuJl/feYLzbW1CHbaBciyHrH8rqSAdLDV+98tilNSzdUNaS3ty0tnx
         tIqZCD9qWq0udTo2oA24KBV+2GQLateZkSOZb5U1ds2VRP5PDqrQxQhpRSLOSD2WpO7H
         9fWcj06fJckvLTQZ2zfBCH56s+dedUwNxb1QrpF4KdKYUSuTcbFfHV6zcDpFBOwzus+6
         MF4A==
X-Gm-Message-State: AOJu0YwCJGdVSEy+zxnuUUZG/clUD9sM6PE87n6RJ5xg4tUe6Vy2DZhO
	lwCLOt0NbgCA2HasBjVmfzY=
X-Google-Smtp-Source: AGHT+IFiReBB3BLHP+m7PMgLml7HKBeIWFfcW+pE2GERhGHRA4g1nAIGuE+v2hhOA9FlrfG0obEW0A==
X-Received: by 2002:a17:907:2724:b0:994:1eb4:6896 with SMTP id d4-20020a170907272400b009941eb46896mr1644514ejl.25.1691746327975;
        Fri, 11 Aug 2023 02:32:07 -0700 (PDT)
Received: from localhost (fwdproxy-cln-000.fbsv.net. [2a03:2880:31ff::face:b00c])
        by smtp.gmail.com with ESMTPSA id b12-20020a170906660c00b00992c92af6f4sm2029350ejp.144.2023.08.11.02.32.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Aug 2023 02:32:07 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: rdunlap@infradead.org,
	benjamin.poirier@gmail.com,
	davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	horms@kernel.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next v6 2/2] netconsole: Enable compile time configuration
Date: Fri, 11 Aug 2023 02:31:58 -0700
Message-Id: <20230811093158.1678322-3-leitao@debian.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811093158.1678322-1-leitao@debian.org>
References: <20230811093158.1678322-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Enable netconsole features to be set at compilation time. Create two
Kconfig options that allow users to set extended logs and release
prepending features at compilation time.

Right now, the user needs to pass command line parameters to netconsole,
such as "+"/"r" to enable extended logs and version prepending features.

With these two options, the user could set the default values for the
features at compile time, and don't need to pass it in the command line
to get them enabled, simplifying the command line.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 drivers/net/Kconfig      | 22 ++++++++++++++++++++++
 drivers/net/netconsole.c |  5 +++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 368c6f5b327e..55fb9509bcae 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -332,6 +332,28 @@ config NETCONSOLE_DYNAMIC
 	  at runtime through a userspace interface exported using configfs.
 	  See <file:Documentation/networking/netconsole.rst> for details.
 
+config NETCONSOLE_EXTENDED_LOG
+	bool "Set kernel extended message by default"
+	depends on NETCONSOLE
+	default n
+	help
+	  Set extended log support for netconsole message. If this option is
+	  set, log messages are transmitted with extended metadata header in a
+	  format similar to /dev/kmsg.  See
+	  <file:Documentation/networking/netconsole.rst> for details.
+
+config NETCONSOLE_PREPEND_RELEASE
+	bool "Prepend kernel release version in the message by default"
+	depends on NETCONSOLE_EXTENDED_LOG
+	default n
+	help
+	  Set kernel release to be prepended to each netconsole message by
+	  default. If this option is set, the kernel release is prepended into
+	  the first field of every netconsole message, so, the netconsole
+	  server/peer can easily identify what kernel release is logging each
+	  message.  See <file:Documentation/networking/netconsole.rst> for
+	  details.
+
 config NETPOLL
 	def_bool NETCONSOLE
 
diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
index 670b6f0a054c..3111e1648592 100644
--- a/drivers/net/netconsole.c
+++ b/drivers/net/netconsole.c
@@ -178,6 +178,11 @@ static struct netconsole_target *alloc_and_init(void)
 	if (!nt)
 		return nt;
 
+	if (IS_ENABLED(CONFIG_NETCONSOLE_EXTENDED_LOG))
+		nt->extended = true;
+	if (IS_ENABLED(CONFIG_NETCONSOLE_PREPEND_RELEASE))
+		nt->release = true;
+
 	nt->np.name = "netconsole";
 	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
 	nt->np.local_port = 6665;
-- 
2.34.1


