Return-Path: <netdev+bounces-34529-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B697A47A1
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04BE81C20CB6
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7A038FB4;
	Mon, 18 Sep 2023 10:54:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E76E663B6
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 10:54:50 +0000 (UTC)
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EE612A
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 03:54:21 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9ad8bba8125so574938666b.3
        for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 03:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1695034460; x=1695639260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xm57SUfFZHH+8dv1S0QHpRMRBULiYAXcl59n2S0Yyw=;
        b=ITJikVE1t+gBhy8OlVP4h7YARNmw+Q/QRHpfbhJ0hY14YMucyDCoisJwANPCXPrZs8
         y4S6AcmG6yN/IrEA79IujN9DsWTpMpG91PjVH4UNiu57YQ00GbMtMFSAKb3f+i+4R9tb
         o+zKc3xa0Niuznro2nxRz5po86foTufKfkWQqnZ5YLT8Q2WMbY9EpojtTLpDjtJMpwJr
         ZofosniW/OeBiKeayPLd977sgXlgDAGsztPt+XPJ2mAJeo7wwIbp8U9tE5v2Podotvh1
         eddyMdY0Zak9MCCRoQttaPegnAGeoQ8rfIMybx6DRBkV8Pic0e1c8QlXJ7Edckz8/+Su
         Pkgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695034460; x=1695639260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0xm57SUfFZHH+8dv1S0QHpRMRBULiYAXcl59n2S0Yyw=;
        b=V1Ics5I7xcfnGB+8I1M0L2TAnMxQeIXNsyJBKWTotI3iRLqMGwpHDu7cMphfwatxHF
         4oMezxA81/imWgqKH1LBZnruBO2ASgUMYVMgaNFODUGcDfD/3sHyIC9x+/fn+fivLoMi
         YgCYjdrJRHQ6Z1yYCr8ltnAAM4XoTGbZMn9EjIcnUPRlS/ob5szISk60U/oKweqTvHAS
         vdQN0fGzO5yMKwFbq4EY3MYknLSo2ypNqRAZGNkQmIKx9CH6SgIVAYdUP4TTbX7a91s0
         EbNHm28nkp60iP3tdoNJjPacvpMpJstO0M8/Ne+QWxv9jbtgQuTuTClm7B35MB6WhYvR
         DQ5A==
X-Gm-Message-State: AOJu0YwrtgOAZ5UjANRzxjF1z6n8Cp9Oc/DRmem/7nJa7lAs7Wes1Ltp
	SwFDzUZtKwmdNFskTVE/ZrUOoZPgxJDglUQTNTs=
X-Google-Smtp-Source: AGHT+IF2RVJ/5N/TLNvDdBK1ZeINZe4seUB9s3rEMUo75tDL+sTndStCCuCpa/uiUthUQy3rCFmNSw==
X-Received: by 2002:a17:906:3053:b0:9a1:e994:3440 with SMTP id d19-20020a170906305300b009a1e9943440mr7926965ejd.4.1695034459855;
        Mon, 18 Sep 2023 03:54:19 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id vr6-20020a170907a50600b009adce1c97ccsm4848143ejc.53.2023.09.18.03.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 03:54:19 -0700 (PDT)
From: Jiri Pirko <jiri@resnulli.us>
To: netdev@vger.kernel.org
Cc: stephen@networkplumber.org,
	dsahern@gmail.com
Subject: [patch iproute2-next 1/4] devlink: update headers
Date: Mon, 18 Sep 2023 12:54:13 +0200
Message-ID: <20230918105416.1107260-2-jiri@resnulli.us>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230918105416.1107260-1-jiri@resnulli.us>
References: <20230918105416.1107260-1-jiri@resnulli.us>
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

Update the devlink headers to recent net-next.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>
---
 include/uapi/linux/devlink.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
index 8b9b98e75059..6c4721270910 100644
--- a/include/uapi/linux/devlink.h
+++ b/include/uapi/linux/devlink.h
@@ -680,6 +680,7 @@ enum devlink_port_function_attr {
 	DEVLINK_PORT_FN_ATTR_STATE,	/* u8 */
 	DEVLINK_PORT_FN_ATTR_OPSTATE,	/* u8 */
 	DEVLINK_PORT_FN_ATTR_CAPS,	/* bitfield32 */
+	DEVLINK_PORT_FN_ATTR_DEVLINK,	/* nested */
 
 	__DEVLINK_PORT_FUNCTION_ATTR_MAX,
 	DEVLINK_PORT_FUNCTION_ATTR_MAX = __DEVLINK_PORT_FUNCTION_ATTR_MAX - 1
-- 
2.41.0


