Return-Path: <netdev+bounces-26230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED98C7773AF
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 11:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6EB71C214A8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA66A1DDFF;
	Thu, 10 Aug 2023 09:07:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABE553C3C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:07:47 +0000 (UTC)
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A152103
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 02:07:44 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b9b5ee9c5aso10696681fa.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 02:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691658463; x=1692263263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WFKk9i4e4fpM9PWXQCHAJK8/NSB0lFX39IJh8OIrSyk=;
        b=2FoQRgaorjMvGigsh1Og0oTAtjuEqYoD5XqjBH1cR4CESAOUDBG1/3YKoSSiiJOL2S
         mKp/hHwUfMzhxOVDJ+4SgOGdae5Vzz9uIukaTzhRbjixjZB+Fvh6ttFMk3deXnvRmVSp
         Y4RVcbmJUtJDX/USPOzFbkqM6sOoQDI/Rkg7rVvsSgh+ja+zzCoWeMg8viWujfLnZ6CF
         Bt1q0RC8yBkkvYPuwaB7nVmCV3JIJwvLM1NcNDngdbAQkgBCeI7nJAT1xJJv5Q2CWPld
         tfDlT43ifK0MY90x/80rFxB5iEq+lbHta681jGsXIheAXuLeXSXTKYpypioGI/j/FfAc
         WKfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691658463; x=1692263263;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WFKk9i4e4fpM9PWXQCHAJK8/NSB0lFX39IJh8OIrSyk=;
        b=dzXwEFso+Dn1wxaqx01h/5iBUVyBhJuDRK9k7uMck5QOd5ochUT0sKU2CVtgeKbE1w
         Ly9e11jAxyQTHNufGPETts65Bv0m8eSe7sB8qSIb3wcdz+675j44nCS+xd+arQtdxaGo
         IgP3IATyK/J2atPqNko3efbbV5xgVjfLOGzRJCHzCh3fIpusYDFBHs4yUOeWVtti6idJ
         pWvnJKD62GEFgCT+uNyyNh1ZCu8Zdt/nC8XYBRcJcMmQOV/dSA/uxMq941R2X17hTYh3
         VjMURESnPN+jJDLSlBQYiicw7j6eI58ZIKkBDH5LYJY0WrPrnW0/TbIZqKfqhmNkhoVz
         mOeA==
X-Gm-Message-State: AOJu0Yzni8dOxCuNFx6xuHxiZAE12dqBA1n22bL/K80XXsaaSMRnwNsY
	5ij/t8x9J+ksnxDMHME0Bf2ckQ==
X-Google-Smtp-Source: AGHT+IEkO6Fe6c2XJS4lYBpGffGKXADm/6pIiWF3po5r2Y1HT650j3raykKtSrtoOOKMqEHFyoCnuQ==
X-Received: by 2002:a2e:2c12:0:b0:2b9:e15f:e780 with SMTP id s18-20020a2e2c12000000b002b9e15fe780mr1322216ljs.26.1691658462906;
        Thu, 10 Aug 2023 02:07:42 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id n24-20020a7bcbd8000000b003fbb0c01d4bsm1486867wmi.16.2023.08.10.02.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 02:07:42 -0700 (PDT)
Date: Thu, 10 Aug 2023 11:07:41 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net
Subject: Re: [PATCH net-next 07/10] genetlink: add genlmsg_iput() API
Message-ID: <ZNSo3X0GeVOgPnN8@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
 <20230809182648.1816537-8-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809182648.1816537-8-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Aug 09, 2023 at 08:26:45PM CEST, kuba@kernel.org wrote:

[...]

>@@ -270,6 +270,31 @@ genl_info_dump(struct netlink_callback *cb)
> 	return &genl_dumpit_info(cb)->info;
> }
> 
>+#ifdef __LITTLE_ENDIAN
>+#define __GENL_PTR_LOW(byte)	((void *)(unsigned long)(byte))
>+#else
>+#define __GENL_PTR_LOW(byte)	\
>+	((void *)((unsigned long)(byte) << (BITS_PER_LONG - 8)))
>+#endif
>+
>+/**
>+ * GENL_INFO_NTF() - define genl_info for notifications
>+ * @__name: name of declared variable
>+ * @__family: pointer to the genetlink family
>+ * @__cmd: command to be used in the notification
>+ */
>+#define GENL_INFO_NTF(__name, __family, __cmd)			\
>+	struct genl_info __name = {				\
>+		.family = (__family),				\
>+		.genlhdr = (void *)&(__name.user_ptr[0]),	\
>+		.user_ptr[0] = __GENL_PTR_LOW(__cmd),		\

Ugh. Took me some time to decypher what you do here. Having endian
specific code here seems quite odd to me. Why don't you have this as
static inline initializer function instead and use struct genlmsghdr
pointer to store cmd where it belong?

static inline void genl_info_ntf(struct genl_info *info,
				 const struct genl_family *family, u8 cmd)
}
	struct genlmsghdr *hdr = (void *) &info->user_ptr[0];

	info->family = family;
	info->genlhdr = hdr;
	hdr->cmd = cmd;
}

[...]

