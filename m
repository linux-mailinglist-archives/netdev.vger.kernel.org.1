Return-Path: <netdev+bounces-26469-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8E89777E81
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:42:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0546A1C21643
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19FC20C83;
	Thu, 10 Aug 2023 16:42:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67471E1DC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:42:34 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539A59C
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:42:32 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fe5695b180so9488935e9.2
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 09:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691685751; x=1692290551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ED72sRBkVwVnev4gyC8Z6wf4u8unBQ2qfJAkU7RDih4=;
        b=SuYk+bl7WCG4+vQ6g5oWOp6W4tt8cPvJl4MazNNnTyv4XlpVqF6nZY7w4AorYwdRbA
         myB/FIggCNVePAbqKq8H4Dc8dbuB48JkjLSrt1wWEU00p/aS0vnrJyx1X6NBxg7z/hsI
         G51oHN6X+Aktrm9nDbk0HAHfEdNRuZWNFh9e5BUPIXbIaGmoDMWnPe4kxKUXZl9kQGrW
         1FkVtUN0IXS7D8g6D53Oee+cYMnhiQLdVOLaUBaeq/hucOR/PxG/7v3/Wx/nwOkBxPag
         P8uoK9aTkG/Tdc7C4CaGDGhnJJwjOiJK0TzYEH0JM+QKy3Awbi8MGnyiog7SH6i38+xM
         koOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685751; x=1692290551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ED72sRBkVwVnev4gyC8Z6wf4u8unBQ2qfJAkU7RDih4=;
        b=R5osoSiK3hfXQhImwDansB2nMCqMPMsqAbRwNP4Bb10DTSJlKi3z8sU/jvNLUUPb2g
         2/gwMYB8x3fjoMP4pOjhIjWMYETJZ8+HLk6WD4SWiqAFu4u8YETeJl0QBUTny3f/ezxo
         C951ZP0XNnHJ+JEn8Fh9hPz0BRuAbbAy0CLZ9B8gY48ocPwl+bNdFRSrjF75/ytj3Fz1
         JMt6zPJqlko/q/hSIwp4rryvemCMAcZj1kSOvA2vllyiRwjRfNDGFvBQAez6akGlC9vy
         +sqx8VNq6GXjs5XWmy7VjPxATUBN9x/aq162gmTHag4gXLCgrYgENtl3WHppZtVrDjEV
         dESQ==
X-Gm-Message-State: AOJu0YzAb2LVSxn+3PP3VjqpS8cH9fyV4mh8F6od36qv2Vg8zdLo/mw3
	4tCyonSJl/ccPw9PLrulDIkcbAz2sYlniluaZ/v7Ug==
X-Google-Smtp-Source: AGHT+IG2I3yErVuH4NNHmx9WTaVGq6emdfekgN5xJibDcjUpc8ACHaOLry8LGSuB6en/uYnN36CCyA==
X-Received: by 2002:a05:600c:22ca:b0:3f7:f884:7be3 with SMTP id 10-20020a05600c22ca00b003f7f8847be3mr2425300wmg.4.1691685750720;
        Thu, 10 Aug 2023 09:42:30 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id p19-20020a05600c205300b003fe17901fcdsm5522606wmg.32.2023.08.10.09.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:42:30 -0700 (PDT)
Date: Thu, 10 Aug 2023 18:42:29 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net
Subject: Re: [PATCH net-next 07/10] genetlink: add genlmsg_iput() API
Message-ID: <ZNUTdSE3CcQbK07D@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
 <20230809182648.1816537-8-kuba@kernel.org>
 <ZNSo3X0GeVOgPnN8@nanopsycho>
 <20230810091336.40951430@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810091336.40951430@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Thu, Aug 10, 2023 at 06:13:36PM CEST, kuba@kernel.org wrote:
>On Thu, 10 Aug 2023 11:07:41 +0200 Jiri Pirko wrote:
>> >+#ifdef __LITTLE_ENDIAN
>> >+#define __GENL_PTR_LOW(byte)	((void *)(unsigned long)(byte))
>> >+#else
>> >+#define __GENL_PTR_LOW(byte)	\
>> >+	((void *)((unsigned long)(byte) << (BITS_PER_LONG - 8)))
>> >+#endif
>> >+
>> >+/**
>> >+ * GENL_INFO_NTF() - define genl_info for notifications
>> >+ * @__name: name of declared variable
>> >+ * @__family: pointer to the genetlink family
>> >+ * @__cmd: command to be used in the notification
>> >+ */
>> >+#define GENL_INFO_NTF(__name, __family, __cmd)			\
>> >+	struct genl_info __name = {				\
>> >+		.family = (__family),				\
>> >+		.genlhdr = (void *)&(__name.user_ptr[0]),	\
>> >+		.user_ptr[0] = __GENL_PTR_LOW(__cmd),		\  
>> 
>> Ugh. Took me some time to decypher what you do here. Having endian
>> specific code here seems quite odd to me. Why don't you have this as
>> static inline initializer function instead and use struct genlmsghdr
>> pointer to store cmd where it belong?
>> 
>> static inline void genl_info_ntf(struct genl_info *info,
>> 				 const struct genl_family *family, u8 cmd)
>> }
>> 	struct genlmsghdr *hdr = (void *) &info->user_ptr[0];
>> 
>> 	info->family = family;
>> 	info->genlhdr = hdr;
>> 	hdr->cmd = cmd;
>> }
>
>Nice! The endian magic is easily the nastiest part of this series.
>I considered making genlhdr a struct (rather than a pointer) because
>it's actually smaller than a pointer on 64b. But dunno, feels kinda
>weird to have a copy of the struct and a pointer to nlh. Hence the
>magic.
>
>And I was trying to save the 2 LoC and provide the DEFINE_ style macro
>but on second thought your init helper is cleaner. I don't like the
>DEFINE_ shit myself. I'll just throw in a memset(0) in there, and maybe
>add a verb to the name - genl_info_init_nft()?

Yep, looks fine to me. Thanks!

