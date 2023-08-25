Return-Path: <netdev+bounces-30564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 521277880B9
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 09:15:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6ADE2816EE
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 07:15:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 949B4377;
	Fri, 25 Aug 2023 07:15:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8720317FC
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 07:15:55 +0000 (UTC)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF3F3E6B
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 00:15:52 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-31c615eb6feso450739f8f.3
        for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 00:15:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1692947751; x=1693552551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0xJiGAjIKXwz+H3cs3MO6Yx2ztRUV/b4KTIvxKHtco4=;
        b=xnBL56nl5MdJxwSJvEOdr+0ZH+mcZQDt2qWiSI72QKZuLMnKDerl0ZTjZzbWAxYGmX
         2+JN3lgNC0uF4uM0pWTpG1GLyfaPC356EKNxA4PtdT8MjXA9ZfqGdACQPPLQcTVsLOf2
         OAS4guApSVvSab5cwLMiV47hqxYIGv+DAXBpRzBizhRZbqFsQ1sxQt0SVS4+ttYBxFHT
         ehOFhHOseAH9hEEZDc4jX8wdStG0sa8biKUsmtXElXmt1BmNmuTwGQTACsW3OYeUl44P
         35UOMdCQxtFyhcqf0t1C5O6QqTnRJO60IDlFhFrNHTI2bcQylTHnVQu6bj8ppjP/cbtV
         V12g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692947751; x=1693552551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xJiGAjIKXwz+H3cs3MO6Yx2ztRUV/b4KTIvxKHtco4=;
        b=fV4IhKargtSWaTQsg43pl047boEnmfypWLLZrDYJTKRuBaQcgT2YmNLG2IAulZ/Ucy
         6tQl0F/6e1k0aMTdvCmkoFuiQ1NjrVMrkG2cDADt9KXk2S+EnXmQG1ulozyPvyvCSrqQ
         GdMOWwAqAquMkI6Eu4JA88F5hFS9J0aoA5P6z/UI0DOnG1K6No4osgk/ixfA5s8kGTMk
         TL25m54U3UBw5cNHkP+uCpYY5Dnk4xD1hi4PwzsL3lkz9zgTzVCupMHbE8TBTX5O30Ra
         /j6iEtb7Z7ZSh+33twjLHbbXBXzfpCQ1pb4rBqV5LtX1VkMA982XSEVEeeNzEUFOO4rs
         6fCA==
X-Gm-Message-State: AOJu0YxLmJS8m+Qjb/hmsgEw/MMj2CvSl6av+mnxqbhklTbadVckGMud
	o/irn6pSYmwhS11XForZOJd07iBz9jUcr6QEAY7qYnzu
X-Google-Smtp-Source: AGHT+IHTB+JFzj016hfGBp7pgTUXIpOgXx+EFk4NpFB2AnpadZ4gtMUIym11THK/YlUeEtOLdmD5MA==
X-Received: by 2002:a5d:4a50:0:b0:315:adf3:67db with SMTP id v16-20020a5d4a50000000b00315adf367dbmr13376019wrs.59.1692947751316;
        Fri, 25 Aug 2023 00:15:51 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id f22-20020a5d58f6000000b0031981c500aasm1348083wrd.25.2023.08.25.00.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 00:15:50 -0700 (PDT)
Date: Fri, 25 Aug 2023 09:15:49 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Saeed Mahameed <saeedm@nvidia.com>, netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	Dima Chumak <dchumak@nvidia.com>
Subject: Re: [PATCH net-next V4 1/8] devlink: Expose port function commands
 to control IPsec crypto offloads
Message-ID: <ZOhVJdkzx/TaQa4w@nanopsycho>
References: <20230825062836.103744-1-saeed@kernel.org>
 <20230825062836.103744-2-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825062836.103744-2-saeed@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Aug 25, 2023 at 08:28:29AM CEST, saeed@kernel.org wrote:
>From: Dima Chumak <dchumak@nvidia.com>
>
>Expose port function commands to enable / disable IPsec crypto offloads,
>this is used to control the port IPsec capabilities.
>
>When IPsec crypto is disabled for a function of the port (default),
>function cannot offload any IPsec crypto operations (Encrypt/Decrypt and
>XFRM state offloading). When enabled, IPsec crypto operations can be
>offloaded by the function of the port.
>
>Example of a PCI VF port which supports IPsec crypto offloads:
>
>$ devlink port show pci/0000:06:00.0/1
>    pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
>        function:
>        hw_addr 00:00:00:00:00:00 roce enable ipsec_crypto disable
>
>$ devlink port function set pci/0000:06:00.0/1 ipsec_crypto enable
>
>$ devlink port show pci/0000:06:00.0/1
>    pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
>        function:
>        hw_addr 00:00:00:00:00:00 roce enable ipsec_crypto enable
>
>Signed-off-by: Dima Chumak <dchumak@nvidia.com>
>Signed-off-by: Leon Romanovsky <leonro@nvidia.com>
>Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

