Return-Path: <netdev+bounces-26129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C215776E3A
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 04:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8728C1C2143D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 02:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEAE7806;
	Thu, 10 Aug 2023 02:53:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E0A7F5
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 02:53:23 +0000 (UTC)
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97050FB
	for <netdev@vger.kernel.org>; Wed,  9 Aug 2023 19:53:22 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-68783004143so335716b3a.2
        for <netdev@vger.kernel.org>; Wed, 09 Aug 2023 19:53:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691636002; x=1692240802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NqOuClL83vR2aG4PuknLi06ZbW9aXvo6a0e74j7GawQ=;
        b=ZuZLPkxIx/wq/0EYETj1ao2RzMJXF4nmF2YridU7DwVkQ5dilca1WpuLxIuNtqLNx8
         F63tpbFKVizhE0ObD06u8YieA2vyZ0t9jRIIdg+tqNKGOAau7DM2KpM5hN2O9vfWB9ST
         i6ibfbvLVZV2GJh3jhdaDyY5gb9Wf1JoQVDJQPLcP471DIAPEjROmViQXO7tAmYsn6Km
         sgUzR1UOIYBTaSraH4OQuV0AmGAmQU+k0iIsF7CLAJhnxd05QPCNHgoCeJM1j06wKHbr
         916CC4hIXAt0Zy4RgIHv+EF0yV91zpnjWpmXqTT4wu8OCC3fTrwfFzqb27k3SaYvB4TO
         IbEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691636002; x=1692240802;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqOuClL83vR2aG4PuknLi06ZbW9aXvo6a0e74j7GawQ=;
        b=QgYoEPa/W/+H8fQ3VW2JwCELPKBxgw2HB0Lno6dy4CuVl2GN0ZLQ/IAYuwGk4uHsex
         6PTYgyQ5jVv/TjiiTWg5XBPORzOOp/tph5Q6CH36zZxyeh1pJGsg/BpvK6a9LSAmK2sr
         QTRpz19qmBnLd8QNDv1aMHS5SUmT5Pi5QmM4DXOtR+kp2bIbguXkFwGbi/yJsSk0WUi3
         9jTShM4RdW/WEVwIa26XBHmpJZ8F4ze0xFhZX/LRI7N1WE5tpjK7DGVerIEVoZCIqDZ9
         SFNVkxNWR9FLNWflPmP6lot88PTDQk2wn+nZDtJxJ+huMNmmXxJtM0aZp953gC4YRGOj
         BQ1g==
X-Gm-Message-State: AOJu0YwZRnCkugJDqmxTnOwyLd5XVA1pOb3Ftq1y8fuMd4axKc0J2sPZ
	ceGT9Y+Nab8P0TI0HQsZSqc=
X-Google-Smtp-Source: AGHT+IFShjo/T/BYDxv4FeRTpY7ka0FBdrL/QzgiMWKOJK0m0fjl3wovRclSJgnANInBrP4+XOejkA==
X-Received: by 2002:a05:6a00:13a5:b0:67b:f249:35e3 with SMTP id t37-20020a056a0013a500b0067bf24935e3mr1397498pfg.26.1691636001997;
        Wed, 09 Aug 2023 19:53:21 -0700 (PDT)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id y12-20020aa7804c000000b006732786b5f1sm301993pfm.213.2023.08.09.19.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Aug 2023 19:53:20 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:53:10 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Zhengchao Shao <shaozhengchao@huawei.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, j.vosburgh@gmail.com,
	andy@greyhouse.net, weiyongjun1@huawei.com, yuehaibing@huawei.com
Subject: Re: [PATCH net-next 2/5] bonding: remove warning printing in
 bond_create_debugfs
Message-ID: <ZNRRFny6lQmRYd+F@Laptop-X1>
References: <20230809124107.360574-1-shaozhengchao@huawei.com>
 <20230809124107.360574-3-shaozhengchao@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809124107.360574-3-shaozhengchao@huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 09, 2023 at 08:41:04PM +0800, Zhengchao Shao wrote:
> Because debugfs_create_dir returns ERR_PTR, so warning printing will never
> be invoked in bond_create_debugfs, remove it. If failed to create
> directory, failure information will be printed in debugfs_create_dir.
> 
> Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
> ---
>  drivers/net/bonding/bond_debugfs.c | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/net/bonding/bond_debugfs.c b/drivers/net/bonding/bond_debugfs.c
> index 94c2f35e3bfc..e4e7f4ee48e0 100644
> --- a/drivers/net/bonding/bond_debugfs.c
> +++ b/drivers/net/bonding/bond_debugfs.c
> @@ -87,9 +87,6 @@ void bond_debug_reregister(struct bonding *bond)
>  void __init bond_create_debugfs(void)
>  {
>  	bonding_debug_root = debugfs_create_dir("bonding", NULL);
> -
> -	if (!bonding_debug_root)

debugfs_create_dir() does not print information for all failures. We can use
IS_ERR(bonding_debug_root) to check the value here.

Thanks
Hangbin
> -		pr_warn("Warning: Cannot create bonding directory in debugfs\n");
>  }
>  
>  void bond_destroy_debugfs(void)
> -- 
> 2.34.1
> 

