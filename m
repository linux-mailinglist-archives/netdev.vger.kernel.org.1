Return-Path: <netdev+bounces-12931-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68E273978B
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 08:42:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993551C21031
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2C05241;
	Thu, 22 Jun 2023 06:42:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CCA1FB4
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 06:42:50 +0000 (UTC)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9255319BE
	for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 23:42:41 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f9002a1a39so50791355e9.2
        for <netdev@vger.kernel.org>; Wed, 21 Jun 2023 23:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20221208.gappssmtp.com; s=20221208; t=1687416159; x=1690008159;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iz0Xt7IIGNoTGmHsGemzXUMAk7iZUxr4jCtMQJqOVkY=;
        b=Qol4SKMTyFXpZDWmLbic1gyiRUBX81PXncqMLbJmf/dilzivkKARkVEcFehqSMDsXa
         5y/JvBB7EITvG/8aAIRPdIkjp7Fw0nqCOLiYnsVnDYTBcfmFy+vrLrFkvhg9DaY+CJSG
         1fXNXiS/DERbNbT43qN8RR5Fb9eWSxqaXI3fBXjj3PpNmpCkUZKx0qmE9ahT3jNq1lh4
         nMM8+IbmuIqDljB2i4azNtgrC33M8M2P+lomzwq6MoEqn/RmnK32UKFt9Rxgmv93dxc3
         XifXfz4LTzGaYPuVMTa+LLW4fArOEKSy+uGZWhR9IPZR7yu9Mhzlp/4gcwElZwxIjBiH
         QhYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687416160; x=1690008160;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iz0Xt7IIGNoTGmHsGemzXUMAk7iZUxr4jCtMQJqOVkY=;
        b=dJx7r3W206k9EPCYcEk23pALEfP898aZAbWOz7hOfdZtcFZc2OZFitRLYo4fAyDrBS
         nwlboqLlQpqvSVleNTpfWD6LMv5x7nzsXRVdYaHEKM5QStVk8+oSGCXdAFr/DA8CLgf+
         QcVcF4YcPJDLY7QvYBTdsBcmxpelUA39CZ2izdI/SfEME1GZLLIv2A70FkIKHX2kTR2O
         jZyqvMuNrsflHSqBGtFzJr9kRoSQsrJY6L2lRmwpAGRU0mGh5QSroukYuaKxyDGcLtCR
         O+yQ9YifWVk9yF5zYdM++eLdTq9XSbdHS8dWcNwJRJeIYmuUiW30Q/DPSLiD/P2PJaoO
         l/qQ==
X-Gm-Message-State: AC+VfDxGEXdYFUvKSBA9oOrFs/ihv4pXrRO4f4MClx6FwSdL4PMXR+63
	x9r00B1IycCIojSt2RrdWVgdVg==
X-Google-Smtp-Source: ACHHUZ4KpZ8/rNMfN6FMvLhzepHHXPUHg4xuk+v76TsKsqQV9APWqcJ6IJpLI5VzwNaEyTxr1Pgfeg==
X-Received: by 2002:a05:600c:3641:b0:3f9:d073:8a19 with SMTP id y1-20020a05600c364100b003f9d0738a19mr1358276wmq.32.1687416159643;
        Wed, 21 Jun 2023 23:42:39 -0700 (PDT)
Received: from localhost ([86.61.181.4])
        by smtp.gmail.com with ESMTPSA id f20-20020a1c6a14000000b003f8f884ebe5sm6875791wmc.2.2023.06.21.23.42.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 23:42:39 -0700 (PDT)
Date: Thu, 22 Jun 2023 08:42:38 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Saeed Mahameed <saeed@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
	Shay Drory <shayd@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>
Subject: Re: [net-next 14/15] net/mlx5: Light probe local SFs
Message-ID: <ZJPtXis9DNHGvq0c@nanopsycho>
References: <ZIVKfT97Ua0Xo93M@x130>
 <20230612105124.44c95b7c@kernel.org>
 <ZIj8d8UhsZI2BPpR@x130>
 <20230613190552.4e0cdbbf@kernel.org>
 <ZIrtHZ2wrb3ZdZcB@nanopsycho>
 <20230615093701.20d0ad1b@kernel.org>
 <ZItMUwiRD8mAmEz1@nanopsycho>
 <20230615123325.421ec9aa@kernel.org>
 <ZJL3u/6Pg7R2Qy94@nanopsycho>
 <20230621112353.667a285d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621112353.667a285d@kernel.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Jun 21, 2023 at 08:23:53PM CEST, kuba@kernel.org wrote:
>On Wed, 21 Jun 2023 15:14:35 +0200 Jiri Pirko wrote:
>>> Did I confuse things even more?  
>> 
>> No, no confusion. But, the problem with this is that devlink port function set
>> active blocks until the activation is done holding the devlink instance
>> lock. That prevents other ports from being activated in parallel. From
>> driver/FW/HW perspective, we can do that.
>> 
>> So the question is, how to allow this parallelism?
>
>You seem to be concerned about parallelism, maybe you can share some
>details / data / calculations? I don't think that we need to hold 
>the instance lock just to get the notification but I'd strongly prefer
>not to complicate things until problem actually exists.
>
>The recent problems in the rtnl-lock-less flower implementation made me
>very cautious about complicating the stack because someone's FW is slow.

I agree 100%. That is my stand as well. Lock less devlink commands
are a simple no-go from my perspective. We got out of that mess only
recently.

I just checked mlx5 code, the SF activation does not block. It just
triggers activation of SF in FW and returns. Does not wait for
completion.

Let me figure out the devlink_port<->sf_devlink linkage and I believe
that would be enough for all needed usecases.

