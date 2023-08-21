Return-Path: <netdev+bounces-29287-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2C17827BD
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 13:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6743F1C20443
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 11:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B9FF5243;
	Mon, 21 Aug 2023 11:16:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 300755231
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 11:16:57 +0000 (UTC)
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A44FE4
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 04:16:56 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id 2adb3069b0e04-4ff9abf18f9so4669171e87.2
        for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 04:16:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692616615; x=1693221415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uOsBZjxiTnPd7j79SxlkA7+OnNP1GbyGBFmdFQj/l+M=;
        b=QRFN8b9Lhlw6eqtcI9ru6J2ioAbV+LUhtSjjUHX6NdWAYy3HJdjSDsJPGjr/X/DRCO
         afTHCtzyfCzR2QIokBqyWhXvCc1d6knjrJpE0DSbdbVoHirlMvQQ7ha4x14OYpq99hP8
         s7R7/kC5O4/9Or+qU23jTIO2qiZmjggJb5vP9OcYuNF/ono9mO/q0wtEVzIg0MBcctQT
         mOiFEqZzBuY2Q4hMx2hIPa3txIkf0F8DhnMYqJ39eTefsP0UVn/vkNqKDULeFD0AFaoH
         7IZzidOuzgrSUcwUCRXvs2fiPBCTllfaU4aFy6jTUnrmTK1c+6mcY9xXUaPjHekzTyqB
         pd7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692616615; x=1693221415;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uOsBZjxiTnPd7j79SxlkA7+OnNP1GbyGBFmdFQj/l+M=;
        b=RXLUVVUiFOq3VXUELmrpS24nDu4wDO5ibQPHZVyJzxSYtAQhNURAxWe4d3CJ6Gv9Tc
         Y69HTbpuJheBX7MvGnVhPU05sxE/dqOwRSXrogfkL+z9HNjOl7Rk05vtDRZM/wyn2rKI
         onvXmVrmXUkNeStkapRb5+HEtKryAofKTW0741omWLWCwGFR1/zQo/+6A0gcWvdMNb+F
         Rb4mSVti4PAWqBvwFi/U8EbWSOk7LTn5rEis7xP+U24GtSTAOLve/UEi78nii22Mo3Ze
         To33YFsT+uu394RaPCwVE3mf8CGto0jS1tIyr2EaNp9csFFWRgFCsoy7FiWNszsRw0uA
         a9kg==
X-Gm-Message-State: AOJu0YwcyaS6vNkjcJIMWsP6DXcEKajZ6PUs93gXMCCcrpRWDHczf0Ox
	b6f6JoGzTgAbwRT738eYpxehjg==
X-Google-Smtp-Source: AGHT+IGcEhYo4qXoMJgWMUZTXTYv7Hv5zJYWFW9G7S8ybsVckHWhbHOtUuJRoL4SB0mytQUp3aWqKQ==
X-Received: by 2002:a19:4f19:0:b0:4ff:afa5:9c0f with SMTP id d25-20020a194f19000000b004ffafa59c0fmr3023358lfb.34.1692616614561;
        Mon, 21 Aug 2023 04:16:54 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id p25-20020a170906839900b0098884f86e41sm6366767ejx.123.2023.08.21.04.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 04:16:54 -0700 (PDT)
Date: Mon, 21 Aug 2023 13:16:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org
Subject: Re: ynl - mutiple policies for one nested attr used in multiple cmds
Message-ID: <ZONHpD7CPEWoQEq2@nanopsycho>
References: <ZM01ezEkJw4D27Xl@nanopsycho>
 <20230804125816.11431885@kernel.org>
 <ZN8tv9bH1Bq8s7SS@nanopsycho>
 <20230818085535.3826f133@kernel.org>
 <ZN+0RCxWBL74Ff+C@nanopsycho>
 <20230818132447.32d32df6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230818132447.32d32df6@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 18, 2023 at 10:24:47PM CEST, kuba@kernel.org wrote:
>On Fri, 18 Aug 2023 20:11:16 +0200 Jiri Pirko wrote:
>> Okay, you don't have good solution, do you have at least the least bad
>> one? :)
>
>I was pondering this for the recent pp work:
>https://lore.kernel.org/all/20230816234303.3786178-13-kuba@kernel.org/
>search for NL_SET_ERR_MSG_ATTR.
>
>I ended up hand-rejecting the attrs which I didn't want.
>It's not great because the policy (netdev_page_pool_info_nl_policy)
>is shared so if someone adds stuff there they'll need to know
>to update all the rejects :[
>
>I guess a better way to code up the same idea would be to check if tb[]
>is NULL outside of expected attrs.

The problem is that with devlink, there no nostrict parsing. So the
like-to-be-ignored attrs if passed might error out during validation.

>
>Option #2 is to not use the auto-generated policy, and write the policy
>by hand in the kernel with the right members.

I'll go with this option for now I think.

>
>Option #3 is to add support for this to the YAML. With the existing
>concepts we would have to redefine all levels as subsets, and then
>we can override nested-attributes. A lot of typing. The YAML is really
>just a slightly decorated version of the policy tables. The policy
>tables in this case have to be separate.

Yeah. But eventually, I think this would be needed anyway to make yaml
to handle all the cases. Relying on the developer to do option #1 or #2
kinda defeats the inital yaml goal to avoid people mistakes, I think.

