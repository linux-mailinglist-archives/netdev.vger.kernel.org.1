Return-Path: <netdev+bounces-26213-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF08E7772D4
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 10:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A80528208E
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 08:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7898D1DDC1;
	Thu, 10 Aug 2023 08:26:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DB3120E3
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 08:26:27 +0000 (UTC)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18EDEED
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:26:26 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so5263785e9.1
        for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 01:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1691655984; x=1692260784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MR+5PFugPovCt/ZI4txJmfCVwmNkCdr2Q2Ayqtgi6o=;
        b=WdVTRiGcf7KWGdovrZhaYzLlwUVf9l8MODnlO7thvaEU+sC0Cza6ueuUU76mU8Yg74
         0Rfo3A/G1LS/Qpxbw/kebtdiDnffZ1PK1Mx5ni/vhp3Ox7JYgNyro81tJz49qyjI1pOK
         nXuUDwV0PAqZUQNv4nlVTSbu3x2EUPBXuiF4vH/71+DABd10ENZekJgw0hYnm8/PwMEF
         i5p1L6KLu2lJzaH3F6JrSSNIBk9oWL7DxAe5ybu6qlCzdOL0mloNb9GsVjRy3Bnos7vy
         72nD56tdS3xUOhovArpb5gjat/Vw/j1shREx+OLuLKoXGr320YfTYLqIq7zmUj50GZX1
         N8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691655984; x=1692260784;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MR+5PFugPovCt/ZI4txJmfCVwmNkCdr2Q2Ayqtgi6o=;
        b=Sd9Uz6LNpFQu/r9r4oE/CR/Bu6qGS63QBOSEZp6XiyHHNSaLvIOaGk+YwvrxWvve0k
         Zjj+oUrfGkdyoJny/GvZGq1DiH9wg79jvMoqxpKG++uozCARtWqjjuPBhXfZJxY0WNTI
         pN+e3mt7aldftyEK8TMQ6DiCVCR5NCf7cola9MiSaK0Sqqcp0zPJBAngx6H9dxGQxguh
         4iBEyzZyE/BRGN/cTjsFoUEDW7CODNCYaCXeHbtbgAHkjQXT0BAf3++kI4Ja7e8xt9vf
         bLYBE4dZnnMpw1RImfmjbw550lyHYVWStj/zCYHqXShNN2OGa7nlUw7bvIgcHT5Bi2m2
         9tsQ==
X-Gm-Message-State: AOJu0YyQEJcS5rGR8QDAwmq1Iq4ZTn4/L4RvPjQP70TSiHN2ZhfRnjf4
	sJginLAVPiCUDwGlhQE6IgPSSA==
X-Google-Smtp-Source: AGHT+IED5EvUAbIPy9tMLOguRqy1DoclqnEEVwX479WbGpTt1LpbY1tJy4NuoGcxJzNG8xckTlf9Gw==
X-Received: by 2002:a7b:cd0d:0:b0:3fa:98c3:7dbd with SMTP id f13-20020a7bcd0d000000b003fa98c37dbdmr1240929wmj.41.1691655984457;
        Thu, 10 Aug 2023 01:26:24 -0700 (PDT)
Received: from localhost ([212.23.236.67])
        by smtp.gmail.com with ESMTPSA id o10-20020a1c750a000000b003fe2b6d64c8sm4321899wmc.21.2023.08.10.01.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:26:23 -0700 (PDT)
Date: Thu, 10 Aug 2023 10:26:22 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, johannes@sipsolutions.net,
	philipp.reisner@linbit.com, lars.ellenberg@linbit.com,
	christoph.boehmwalder@linbit.com, axboe@kernel.dk, pshelar@ovn.org,
	jmaloy@redhat.com, ying.xue@windriver.com, jacob.e.keller@intel.com,
	drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
	dev@openvswitch.org, tipc-discussion@lists.sourceforge.net
Subject: Re: [PATCH net-next 03/10] genetlink: remove userhdr from struct
 genl_info
Message-ID: <ZNSfLomTSZy/4b8W@nanopsycho>
References: <20230809182648.1816537-1-kuba@kernel.org>
 <20230809182648.1816537-4-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809182648.1816537-4-kuba@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Aug 09, 2023 at 08:26:41PM CEST, kuba@kernel.org wrote:
>Only three families use info->userhdr and fixed headers
>are discouraged for new families. So remove the pointer
>from struct genl_info to save some space. Compute
>the header pointer at runtime. Saved space will be used
>for a family pointer in later patches.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

I'm fine with the existing message, but what Johannes suggests is also
ok.

