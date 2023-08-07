Return-Path: <netdev+bounces-24804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB877771BE3
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 09:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7658B280EBD
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 07:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7094AC2DA;
	Mon,  7 Aug 2023 07:56:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 628005251
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 07:56:55 +0000 (UTC)
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05F6010F4
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 00:56:53 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9db1de50cso63702591fa.3
        for <netdev@vger.kernel.org>; Mon, 07 Aug 2023 00:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691395011; x=1691999811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9X5bdW2tg9UJAuSkealMvYLVvu+VYHMvYfm0lzMKtlc=;
        b=CUrzVyahwtYzhrnnRp2UBmh3Oqh+6E1KSIDCSyA0abNRU23EsUGEsfPGj1muqqRPhZ
         UkrKgbcfaRJS23eXs756pTkgl0e2XeWKqqMhdBiULbarxSzBWD5rsPOwIZ7KQAlkzu+d
         QHfLsoa55LLYBl0MoV+rIvwloG6l4ZjdL92uCWey0CNcwjENDuxc5QiKADKW8DOd2ZC/
         sbZerpqaie90RkiICyZjwp5qmQrs4nNiOTrWdz0OZP8DoXOm1uPjMfszKLA1GEc01X3j
         0xpu0Z353qZA4Sk5EtIHrrXdYg9M6y7jU0lfwwmgwCQaPUpP/ne/Aheu0zS98UUXbDIk
         tHjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691395011; x=1691999811;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9X5bdW2tg9UJAuSkealMvYLVvu+VYHMvYfm0lzMKtlc=;
        b=eOpnBjEsLrBljB/hkFD3hkEi1AwEdlUz8W8SGpD/utDuDp1XlYr2+qJ54Nc/0JGcQ3
         c3GewWXiigv4j3t9Kgs2b0qGtQmOD/yRnrEY8JY4mbKq0ZrJzxrd/7QMs8dC9/RDa8zn
         pA55uH5PjiSoSXx06fyYyTHtvs+N3UXtv0MPNFBcrMPP0RmEnFYKYctCz7s1ONrtcPsc
         0K+imWOVXiOlnuWlu9IA47COOlOZAv9iaE/Yd7FPcdjglbObjUqMYGxFYiZAKi1CiACw
         RUGxbHWE02FO8eUWeJIB1bTVrLbAOwFrl2zIEkhrtWIWg+31uEzZSaexSZaLDZwaJ4ZD
         xYSw==
X-Gm-Message-State: AOJu0Yy2uInEb8EDjT+Wn5jZcfDrSwFdYJIRd0uZnytTOAn8ykz+gDB9
	DBDI0vToMy7wF5nn1TgiO3TM1g==
X-Google-Smtp-Source: AGHT+IHq37YjmUYw/gjf949OCDtsNW8K+MdHewkK97EovTahgtapHBI9OvPKVkhkmLSnNYg0vxfjow==
X-Received: by 2002:a2e:9316:0:b0:2b9:bcac:7ba6 with SMTP id e22-20020a2e9316000000b002b9bcac7ba6mr5601319ljh.46.1691395010925;
        Mon, 07 Aug 2023 00:56:50 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id q1-20020a05600c040100b003fe29dc0ff2sm9862961wmb.21.2023.08.07.00.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 00:56:50 -0700 (PDT)
Date: Mon, 7 Aug 2023 09:56:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jonathan Lemon <jonathan.lemon@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Milena Olech <milena.olech@intel.com>,
	Michal Michalik <michal.michalik@intel.com>,
	linux-arm-kernel@lists.infradead.org, poros@redhat.com,
	mschmidt@redhat.com, netdev@vger.kernel.org,
	linux-clk@vger.kernel.org, Bart Van Assche <bvanassche@acm.org>,
	intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH net-next v2 2/9] dpll: spec: Add Netlink spec in YAML
Message-ID: <ZNCjwfn8MBnx4k6a@nanopsycho>
References: <20230804190454.394062-1-vadim.fedorenko@linux.dev>
 <20230804190454.394062-3-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230804190454.394062-3-vadim.fedorenko@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 04, 2023 at 09:04:47PM CEST, vadim.fedorenko@linux.dev wrote:
>Add a protocol spec for DPLL.
>Add code generated from the spec.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>Signed-off-by: Michal Michalik <michal.michalik@intel.com>
>Signed-off-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
>Signed-off-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
>---

Hmm, running tools/net/ynl/ynl-regen.sh generates following diff:
diff --git a/drivers/dpll/dpll_nl.c b/drivers/dpll/dpll_nl.c
index ff3f55f0ca94..638e21a9a06d 100644
--- a/drivers/dpll/dpll_nl.c
+++ b/drivers/dpll/dpll_nl.c
@@ -17,7 +17,6 @@ const struct nla_policy dpll_pin_parent_device_nl_policy[DPLL_A_PIN_STATE + 1] =
 	[DPLL_A_PIN_PRIO] = { .type = NLA_U32, },
 	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U8, 1, 3),
 };
-
 const struct nla_policy dpll_pin_parent_pin_nl_policy[DPLL_A_PIN_STATE + 1] = {
 	[DPLL_A_PIN_STATE] = NLA_POLICY_RANGE(NLA_U8, 1, 3),
 	[DPLL_A_PIN_ID] = { .type = NLA_U32, },
diff --git a/include/uapi/linux/dpll.h b/include/uapi/linux/dpll.h
index f659fabb1041..18d4fda484e8 100644
--- a/include/uapi/linux/dpll.h
+++ b/include/uapi/linux/dpll.h
@@ -163,7 +163,6 @@ enum dpll_a {
 	DPLL_A_PIN_PARENT_DEVICE,
 	DPLL_A_PIN_PARENT_PIN,
 
-	/* private: */
 	__DPLL_A_MAX,
 	DPLL_A_MAX = (__DPLL_A_MAX - 1)
 };
@@ -182,7 +181,6 @@ enum dpll_cmd {
 	DPLL_CMD_PIN_DELETE_NTF,
 	DPLL_CMD_PIN_CHANGE_NTF,
 
-	/* private: */
 	__DPLL_CMD_MAX,
 	DPLL_CMD_MAX = (__DPLL_CMD_MAX - 1)
 };

Do you base this patchset on top of recent net-next? If not, please do
rebase.


Other than this, looks fine to me.

Signed-off-by: Jiri Pirko <jiri@nvidia.com>

