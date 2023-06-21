Return-Path: <netdev+bounces-12807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFC9738FDB
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 21:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 059D8281727
	for <lists+netdev@lfdr.de>; Wed, 21 Jun 2023 19:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2BC1C740;
	Wed, 21 Jun 2023 19:14:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7306319BA2
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 19:14:32 +0000 (UTC)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4AED1BD4
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:14:23 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-98802908fedso622209766b.1
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 12:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687374862; x=1689966862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oUpzAnb7H9C1XbzLWIwmOq5mZMKGIdlo6zaMD3zxDSQ=;
        b=ZA8/DQTYDe+BgTijCQuIVDKbTaIhjuZmRWbSdo4jcLRzEVaPgZMOELlxUHNOLlyrYB
         LJBbU6EN/X76kLKPPKHfa7Q5DPgONCRMF1lE0pl2ZnvPyoVTYlflD//X25gRcWsj8HIc
         Fxy4vz8RRsXaZjfdlUwwy89DbVHEgR414pyj/DQageoBC01/h8IHgUYTs4lmdgfGctsM
         cDkCXUac1FiT2yjTYh/0/zhHMNQA8sF+tQCMFEA8hK/VP8Ju2zhHLHw1IGgHob00EKF2
         RdwD0yUXxXTKBXzaVbSGyTUbZgf7iDCOwzedVnCyr/cn1ctihl5qEUnkBFyrwCYVuWRe
         Z96g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687374862; x=1689966862;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oUpzAnb7H9C1XbzLWIwmOq5mZMKGIdlo6zaMD3zxDSQ=;
        b=O9enyKBMY/W61Y468Kfd6VHxeUnRS8j3JgA2Ws2QSlFMp+cfKWSU5x1Zp36/5yiEi9
         TYOTBNT81Hk5B+JbBfvQgYFb9skZV5mTUp6nhwGyI0719glP3RP0kn1u5qJVNXUyda15
         rqrv7MtQ905xciAllpVM21n3tZkjO2myglLrlrPUNWefFJKBPvz61SU+Qucl0Su5QXAp
         tvvTcU7JMKOjQ66EviyyV4moNkBUBOEo13tm/gUN9GwZNQM6h3v4LshxBIKPaj3Cg6Dz
         oFs0GCnKQd+9+ZtagfU3BocbcuKr36PFBzfFDffr4RJZYELeljY7QS+5r69pBsd4pOsH
         t6UQ==
X-Gm-Message-State: AC+VfDw06byqK+uFw52LyyCG6dbMI+qqf3b4yJcZoKqY+ZsSneLZC4Qh
	hBSy4GqYBsfhi+cSz8GgPx/nrOnCPfKPIQ==
X-Google-Smtp-Source: ACHHUZ4/FCyCpHEDIaFkeqEg3FPQec8bfAV50imGmt9ErHcBYqX/HIznoWHYtOmRo32Jpbg+pG29HA==
X-Received: by 2002:a17:907:1b1e:b0:97e:aad0:12fe with SMTP id mp30-20020a1709071b1e00b0097eaad012femr11151328ejc.77.1687374861744;
        Wed, 21 Jun 2023 12:14:21 -0700 (PDT)
Received: from WBEC325.dom.local ([185.188.71.122])
        by smtp.gmail.com with ESMTPSA id gu1-20020a170906f28100b009829a5ae8b3sm3539562ejb.64.2023.06.21.12.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 12:14:21 -0700 (PDT)
From: Pawel Dembicki <paweldembicki@gmail.com>
To: netdev@vger.kernel.org
Cc: linus.walleij@linaro.org,
	Pawel Dembicki <paweldembicki@gmail.com>
Subject: [PATCH net-next 0/6] net: dsa: vsc73xx: Make vsc73xx usable
Date: Wed, 21 Jun 2023 21:13:03 +0200
Message-Id: <20230621191302.1405623-7-paweldembicki@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230621191302.1405623-1-paweldembicki@gmail.com>
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patch series is focused on getting vsc73xx usable.

First patch is simple convert to phylink, because adjust_link won't work
anymore.

Patches 2-5 are basic implementation of tag8021q funcionality with QinQ
support without vlan filtering in bridge and simple vlan aware in vlan
filtering mode.

STP frames isn't forwarded at this moment. BPDU frames are forwarded 
only from to PI/SI interface. For more info see chapter 
2.7.1 (CPU Forwarding) in datasheet.

Last patch fix wrong MTU configuration.

Pawel Dembicki (6):
  net: dsa: vsc73xx: convert to PHYLINK
  net: dsa: vsc73xx: add port_stp_state_set function
  net: dsa: vsc73xx: Add dsa tagging based on 8021q
  net: dsa: vsc73xx: Add bridge support
  net: dsa: vsc73xx: Add vlan filtering
  net: dsa: vsc73xx: fix MTU configuration

 drivers/net/dsa/Kconfig                |   2 +-
 drivers/net/dsa/vitesse-vsc73xx-core.c | 928 ++++++++++++++++++++-----
 drivers/net/dsa/vitesse-vsc73xx.h      |   1 +
 include/net/dsa.h                      |   2 +
 net/dsa/Kconfig                        |   6 +
 net/dsa/Makefile                       |   1 +
 net/dsa/tag_vsc73xx_8021q.c            |  87 +++
 7 files changed, 857 insertions(+), 170 deletions(-)
 create mode 100644 net/dsa/tag_vsc73xx_8021q.c

-- 
2.34.1


