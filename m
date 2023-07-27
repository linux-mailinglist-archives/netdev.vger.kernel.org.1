Return-Path: <netdev+bounces-21818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF425764E46
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 10:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D6D281DED
	for <lists+netdev@lfdr.de>; Thu, 27 Jul 2023 08:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86FED537;
	Thu, 27 Jul 2023 08:56:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC6B5D2F7
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 08:56:07 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2ACD85FFB
	for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1690448163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HJr/LOxM4lZv4w4CQeON2CQ08oZ8bTnRRLKHoh2xLYw=;
	b=jAl5974rmDEAlC+phVEM8hKb65NVDlq2AOsqlTe0sUy6so7c6aGst57o/7o6RZmPZ750+w
	EK19hcaXenztS2GS91sJyePW8s3G9WeFohOEcL3MVLW7U2Bco9MeEbP1Wk8musBUnLzk7y
	siV3PFH/lyjsH9oYRKIyG2aRfIvzelE=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-2dF5FPCyOPimYXUVmgBjiQ-1; Thu, 27 Jul 2023 04:56:02 -0400
X-MC-Unique: 2dF5FPCyOPimYXUVmgBjiQ-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-5eee6742285so9294976d6.2
        for <netdev@vger.kernel.org>; Thu, 27 Jul 2023 01:56:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690448161; x=1691052961;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HJr/LOxM4lZv4w4CQeON2CQ08oZ8bTnRRLKHoh2xLYw=;
        b=BDlvhm8mZmHjGpnnJ7RhNMW4wROeNsoT9XaGByUfTneIy1CuOfu7lUsA+CRwBXJFbU
         tnniONlJLEN6bZ+pAg0Gc+2TA4K0SJUdiVU/cnDpkMyv4GDvznj7eBOg7IHYPm4/rKXf
         lZs+333Fo8zhBlg56dvyohi4PHiLbgSJYpTVKaK/1AdyQLiKvMb4mZGfm3z++utEKMEe
         l+kEhttqLZJK4kqafCDtYQifnDasvzEQxje90ej9bf48IAddzZgm0ao6gL48ak+r+RS5
         vWcS2PX02GM2kQE1CDyep0ZIX/EWEKFuXrvpCczWlV+Wk67k5d/Jt39L9V191zKVflzM
         BHMA==
X-Gm-Message-State: ABy/qLaZHzImc3xM34/7jM85Dgwvx3jQ7BszaGaGJ/jJaKpLGRk93Ass
	E+qU5fmIs332PMcFnsWQTbaSmWR4TCS6pf1gy8jDkJ/WCPpJYoyAUXs1pSm+43L9/cHxA66qoav
	LRF80+zzXiNj2NoYNvoE2C9vI0aPDPj8fn9cxXBLTYnnDupMstalrgJQ26Y1VjTTmpGc3CiToMT
	s+eg==
X-Received: by 2002:a0c:a892:0:b0:631:fb35:27e1 with SMTP id x18-20020a0ca892000000b00631fb3527e1mr3390705qva.4.1690448161323;
        Thu, 27 Jul 2023 01:56:01 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFTSssZCGMsNwCshAycu204bY4Oh2wqpnsdZCFy57WNmtumSwYLEcSvcRtqfI61eZGplg/x2Q==
X-Received: by 2002:a0c:a892:0:b0:631:fb35:27e1 with SMTP id x18-20020a0ca892000000b00631fb3527e1mr3390693qva.4.1690448160880;
        Thu, 27 Jul 2023 01:56:00 -0700 (PDT)
Received: from nfvsdn-06.redhat.com (nat-pool-232-132.redhat.com. [66.187.232.132])
        by smtp.gmail.com with ESMTPSA id f30-20020a0caa9e000000b0063612e03433sm273260qvb.101.2023.07.27.01.56.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 01:56:00 -0700 (PDT)
From: mtahhan@redhat.com
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: Maryam Tahhan <mtahhan@redhat.com>
Subject: [net-next,v1 0/2] tools/net/ynl: enable json configuration
Date: Thu, 27 Jul 2023 04:55:55 -0400
Message-Id: <cover.1690447762.git.mtahhan@redhat.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Maryam Tahhan <mtahhan@redhat.com>

Use a json configuration file to pass parameters to ynl to allow
for operations on multiple specs in one go. Additionally, check
this new configuration against a schema to validate it in the cli
module before parsing it and passing info to the ynl module.

Example configs would be:
{
    "yaml-specs-path": "/<path-to>/linux/Documentation/netlink/specs",
    "spec-args": {
        "ethtool.yaml": {
            "do": "rings-get",
            "json-params": {
                "header": {
                    "dev-name": "eno1"
                }
            }
        },
       "netdev.yaml": {
            "do": "dev-get",
            "json-params": {
            "ifindex": 3
            }
        }
    }
}

OR

{
    "yaml-specs-path": "/<path-to>/linux/Documentation/netlink/specs",
    "spec-args": {
        "ethtool.yaml": {
            "subscribe": "monitor",
            "sleep": 10
        },
        "netdev.yaml": {
            "subscribe": "mgmt",
            "sleep": 5
        }
    }
}

Maryam Tahhan (2):
  tools/net/ynl: configuration through json
  tools/net/ynl: validate config against schema

 tools/net/ynl/cli.py            | 135 +++++++++++++++++++++++++++-----
 tools/net/ynl/ynl-config.schema |  72 +++++++++++++++++
 2 files changed, 187 insertions(+), 20 deletions(-)
 create mode 100644 tools/net/ynl/ynl-config.schema

-- 
2.39.2


