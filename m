Return-Path: <netdev+bounces-22502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60016767C09
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 06:05:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 780871C216A1
	for <lists+netdev@lfdr.de>; Sat, 29 Jul 2023 04:05:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2441515A2;
	Sat, 29 Jul 2023 04:05:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D62138E
	for <netdev@vger.kernel.org>; Sat, 29 Jul 2023 04:05:49 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF5A49CA
	for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 21:05:48 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-686b9920362so2048874b3a.1
        for <netdev@vger.kernel.org>; Fri, 28 Jul 2023 21:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20221208.gappssmtp.com; s=20221208; t=1690603547; x=1691208347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIOnNzQ5QSvfWmmqe4+khqWn6IWa6n7XmBtlsC5UWLw=;
        b=KtcbTNnAMPovggt65Y5c7Spfc0N4VIzwiDpGOkf2HAFDPVSr0YQR+2FHgIsMom5O0t
         eF9qSK8TTjMMsK8Eh6E4MbtJfCipJrCAAJnjEH8ySr4g5Ryjpo4gN2XEJa5WcPjFozOe
         uR0LSfNxD0c74BJw3R9NTD9Dgtef0KAsd9xH1CxLw+VzFesjrisBX2UhMfKIQRg0zE+k
         LxFuOSHymHBvp0Zuzfl0OdpZpRtBY3i6D/qYKV5gCUTaY/C8V9BP0W5IiEcWKQhA8lW2
         LxpaukeuZnnzLMIAtDaxgapDsAZx3fTian/Tz4RbPcmESO+EuAz5WUYcAlwEA2MsWQkQ
         VKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690603547; x=1691208347;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AIOnNzQ5QSvfWmmqe4+khqWn6IWa6n7XmBtlsC5UWLw=;
        b=i+L6hpihToD0wDI8XItXxtv1q+e1QhJr5qgEiI+1tYjxNshq84hfkVHYIg6LHdS8rs
         LEvMKrc1bl3H3tL1Unap6Q1d7SU5zZSL6/+QhFE5E5Rm4VZfX2ghntqztRJBuPCAUMmp
         DCwMpgPDT/W6V6/qikGmm/wRbN6Pm2wXqHQBZsGzWdAiKqJSfLBkps8wykRA7L1qup3E
         K2hQKzFwykwkVnphjVcefEW9MMgYgeh4ZFw2UpczXW2c37JpACHVobXyHQMI7MLW9KrM
         IEAwAgXn5UHLv32/w1cHtNfJ6x/g4mCmHaKuxOBZR1NpIYva3jqFSiyf4t6BgmVVKjWA
         rvkw==
X-Gm-Message-State: ABy/qLZPRDcaqWuavpRMJ4HT7WuepjzPYi++NmxeHnxvY8Ehvw3WUC2J
	OrHPnPwyibiwZifct1yTf/+UrNn5kTWSf/ow52XO+g==
X-Google-Smtp-Source: APBJJlEaEUhZGWabPuChPbrVEKvY78Ta+G9tM/lWrS+YuoCdlX0zpbl5pxh3JsY1PW5+gSVDCAhLYA==
X-Received: by 2002:a05:6300:8001:b0:130:835b:e260 with SMTP id an1-20020a056300800100b00130835be260mr3432300pzc.52.1690603547526;
        Fri, 28 Jul 2023 21:05:47 -0700 (PDT)
Received: from hermes.local (204-195-127-207.wavecable.com. [204.195.127.207])
        by smtp.gmail.com with ESMTPSA id w29-20020a63935d000000b005533b6cb3a6sm4189803pgm.16.2023.07.28.21.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 21:05:47 -0700 (PDT)
Date: Fri, 28 Jul 2023 21:05:45 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Amritha Nambiar <amritha.nambiar@intel.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 sridhar.samudrala@intel.com
Subject: Re: [net-next PATCH v1 7/9] net: Add NAPI IRQ support
Message-ID: <20230728210545.279f092b@hermes.local>
In-Reply-To: <169059164799.3736.4793522919350631917.stgit@anambiarhost.jf.intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
	<169059164799.3736.4793522919350631917.stgit@anambiarhost.jf.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 28 Jul 2023 17:47:28 -0700
Amritha Nambiar <amritha.nambiar@intel.com> wrote:

> Add support to associate the interrupt vector number for a
> NAPI instance.
> 
> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> ---
>  drivers/net/ethernet/intel/ice/ice_lib.c |    3 +++
>  include/linux/netdevice.h                |    6 ++++++
>  net/core/dev.c                           |    1 +
>  net/core/netdev-genl.c                   |    4 ++++
>  4 files changed, 14 insertions(+)
> 
> diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
> index 171177db8fb4..1ebd293ca7de 100644
> --- a/drivers/net/ethernet/intel/ice/ice_lib.c
> +++ b/drivers/net/ethernet/intel/ice/ice_lib.c
> @@ -2975,6 +2975,9 @@ int ice_q_vector_add_napi_queues(struct ice_q_vector *q_vector)
>  			return ret;
>  	}
>  
> +	/* Also set the interrupt number for the NAPI */
> +	napi_set_irq(&q_vector->napi, q_vector->irq.virq);
> +
>  	return ret;
>  }

Doing this for only one device seems like a potential problem.
Also, there are some weird devices where there may not be a 1:1:1 mapping
between IRQ, NAPI, and netdev.

