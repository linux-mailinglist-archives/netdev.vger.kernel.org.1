Return-Path: <netdev+bounces-17825-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41078753241
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 08:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 484D71C204E8
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 06:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB706AB3;
	Fri, 14 Jul 2023 06:48:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD17B1C35
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 06:48:58 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C8D1993
	for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 23:48:56 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-98de21518fbso213604666b.0
        for <netdev@vger.kernel.org>; Thu, 13 Jul 2023 23:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1689317335; x=1691909335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FQQW8GAQA9pOKPwWwqdNITi/jwsebaBcC1R0yG2LAbE=;
        b=dmrcB46PtgOlUXq1ZuB5PBk1kRbzgKKcf5rFPZ8WPMxeCVWIJrc3PbfqhHC5vcUcus
         01gSQ5w4HaIqKRcxf7s6ABTEdyZ8KwiYrecdcgkHEz6SL9yugsr0rnUVJT89Uv+JtusK
         YuRjqSRxIXUiRITnowuik15yHrPOPH6TuwYBji7YY7RvhZCFLTjaNJo5AOyoA8w9G8ng
         5LLLv31hcuOFnLZc0l8wxp2vQPdC28a5AoFAhxNVX2ylDv2z9Wd526qCQG3GRyzgl14x
         OPZ6cBieRngm7qBil8LX4iqBRiIepkzZRQ467BmRNx1FzzARbIyaGzxluiCmDI4YEayh
         fhqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689317335; x=1691909335;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FQQW8GAQA9pOKPwWwqdNITi/jwsebaBcC1R0yG2LAbE=;
        b=MRvurcbh4qNyMe6p5Mfdpz8fdvykmRZ50WCeFjBGeyVHarIO27uCtgXULDvxZtUqts
         yRnR8xnvM2cSsOgF2rNYTSXemsJYWoXwEOxsEROuIEGHDoXrIiqW0A9FQZSyFL4jmkDH
         3Ga+N2kEQX8yqQXuwiqljkLJgC+BHgefQ0bxpNhs+z6kPdva9UFADZTvIypMPaH4H1Qi
         nzrLqYU9iX1tzsq8Ij2QlfYqgykESpCblPX8TqC61EerulR0c1Qz+RMO17XSNCdjt4D4
         sUZssYWo/r14Vqbq7E/S51r2xjhJVCQ4Nm0k8pI8Z+03BwyFfRS64WPqx7as9eY4YFP1
         2RRg==
X-Gm-Message-State: ABy/qLZOcEnEVZv5tD2IRFr8fxYJoVcv68pF0coxexadfD7eckXynlW1
	SHIXao3y3S/DemfnlHNGNumCkA==
X-Google-Smtp-Source: APBJJlELsUncEJG60AGsjpedzeYKF3DAPJS7ajpo+APkVL1OxsZ2QVtts64bYGpyNsl8VstFMW9ymA==
X-Received: by 2002:a17:907:1b05:b0:994:b53:77fc with SMTP id mp5-20020a1709071b0500b009940b5377fcmr4132218ejc.12.1689317334654;
        Thu, 13 Jul 2023 23:48:54 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id d24-20020a170906175800b009928b4e3b9fsm4942253eje.114.2023.07.13.23.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jul 2023 23:48:53 -0700 (PDT)
Date: Fri, 14 Jul 2023 08:48:52 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>, Liang Li <liali@redhat.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net 2/2] team: reset team's flags when down link is P2P
 device
Message-ID: <ZLDv1E4LAuL0SDac@nanopsycho>
References: <20230714025201.2038731-1-liuhangbin@gmail.com>
 <20230714025201.2038731-3-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714025201.2038731-3-liuhangbin@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Fri, Jul 14, 2023 at 04:52:01AM CEST, liuhangbin@gmail.com wrote:
>When adding a point to point downlink to team device, we neglected to reset
>the team's flags, which were still using flags like BROADCAST and
>MULTICAST. Consequently, this would initiate ARP/DAD for P2P downlink
>interfaces, such as when adding a GRE device to team device.
>
>Fix this by remove multicast/broadcast flags and add p2p and noarp flags.
>
>Reported-by: Liang Li <liali@redhat.com>
>Links: https://bugzilla.redhat.com/show_bug.cgi?id=2221438
>Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
>Signed-off-by: Hangbin Liu <liuhangbin@gmail.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

