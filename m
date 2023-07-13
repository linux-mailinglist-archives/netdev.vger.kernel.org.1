Return-Path: <netdev+bounces-17421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B212751862
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 07:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BCAE1C21277
	for <lists+netdev@lfdr.de>; Thu, 13 Jul 2023 05:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4627C5672;
	Thu, 13 Jul 2023 05:56:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36F61566E
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 05:56:22 +0000 (UTC)
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E8661FD8
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:56:21 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b741cf99f8so3796381fa.0
        for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 22:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689227780; x=1691819780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Z28waPMMcML4FxoCgp2g5KyfqzPG+MLJOa6/wcRK7uU=;
        b=bO+N6KPY0vpCtdeu7jj+uZ4+2yeYFGnQL2Jnzboq8IiPSfPKVkRgLPPaP+SXIKDwJM
         TRBT2eCk8ZZPvUvPJ78DvzT5/mm2T3N+JHX9En6rzou7fRVG9YX2mT8LuBp9bgjDew72
         bTueo75T0uCD6fJDhaDMTKgxH4/6GAOn+WfRQV/uIPUUdEnaqHxcfuHQditZH5SLrwdN
         kVaQahwsvx/XlqDOykkVBTsNbXOuig+aRozCvwkGKs1Jhpvq+s5+ekdD1vnjDbcecu3H
         rG1f8MMr6Bdib3QVlmmG5Sip1tyYhA6aifHqhoG/qENuqlRlL8rabwViV8czM/BzBbXf
         w5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689227780; x=1691819780;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z28waPMMcML4FxoCgp2g5KyfqzPG+MLJOa6/wcRK7uU=;
        b=D3RisaGTmarV+unL7khj+Fkv3ERl6dPvyTvu2dCs8VvVtyTNnKy7FZgU5ZyVlw18+J
         nJnwNbhTQrRFUOXUXzUVhyPWGWasm0jc4/W1lLJisQsDRimh5guOCbujj8tNx1xsA1nB
         +0FnHxDftGU/CJXtdFGy0qzxnWWXzNuGViOZ6wRgmrT4ltTry888/Iui1tO0eeBbNJjV
         4crjjE8MgzzN/tEzIaADqwRSTLDaR9b7DcvANdkIMYfh5xmZq2dv8Uw3L2azx72BgtMX
         MgUUf/AmGkBJTUJqBp5UgrCUFz34GcV2R5ZKsGtjTxHyU26hqJ2h9DpyvyTCp4qpMiM+
         T09Q==
X-Gm-Message-State: ABy/qLYnRAeOMtL/LpZ4Gbd9n3mjPAhrnTh91WmKXdo0+mfDZpoLj9tU
	46t5s4mOiwuYe5zcTjy51yU4kw==
X-Google-Smtp-Source: APBJJlFLVxyJe1Fgg/t322tKLr9Egq9wOZ4YCi+x7AaVR7Q8Q8xc6dIUgyfsVpSerCmTRFG9LkKLHQ==
X-Received: by 2002:a05:6512:68c:b0:4f8:711b:18b0 with SMTP id t12-20020a056512068c00b004f8711b18b0mr441810lfe.3.1689227779717;
        Wed, 12 Jul 2023 22:56:19 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id t12-20020a5d6a4c000000b00314329f7d8asm6871477wrw.29.2023.07.12.22.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 22:56:17 -0700 (PDT)
Date: Thu, 13 Jul 2023 08:56:14 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@mellanox.com>, netdev@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] devlink: uninitialized data in
 nsim_dev_trap_fa_cookie_write()
Message-ID: <3f07832b-a595-4d3b-b4d3-b9256bdd1fd0@kadam.mountain>
References: <7c1f950b-3a7d-4252-82a6-876e53078ef7@moroto.mountain>
 <20230712124806.5ed7a1eb@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230712124806.5ed7a1eb@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 12, 2023 at 12:48:06PM -0700, Jakub Kicinski wrote:
> On Tue, 11 Jul 2023 11:52:26 +0300 Dan Carpenter wrote:
> > Subject: [PATCH net] devlink: uninitialized data in  nsim_dev_trap_fa_cookie_write()
> 
> We usually reserve the "devlink: " prefix for net/devlink/ changes
> rather than driver changes, so I adjust the subject when applying.

Thanks!  I should have seen that, sorry.

regards,
dan carpenter


