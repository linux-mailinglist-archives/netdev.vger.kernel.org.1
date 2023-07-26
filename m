Return-Path: <netdev+bounces-21248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C11C6762FD4
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 10:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 067591C210E5
	for <lists+netdev@lfdr.de>; Wed, 26 Jul 2023 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56B3AD32;
	Wed, 26 Jul 2023 08:28:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B994CA959
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 08:28:21 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8432555B6
	for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:28:19 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5227799c224so390401a12.0
        for <netdev@vger.kernel.org>; Wed, 26 Jul 2023 01:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1690360098; x=1690964898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BNQhgI3bztXsDKLKL9Y51hRanaV6IoqzrzInBKdjpB4=;
        b=EskMqoHcrf+I1oDvZ7vE+vwdKapI2s4EtPHSd2O6GRmPDAQgEnsg4w2DuFGlJBZkYw
         ocIssKw1G5HEEK48lpLYg7iG3fHlvnxlherMdtpBvVhh5v4Ga8lpe+w5OLop13ui6ixn
         AwWFvow+tkZvLjq6RfGsOPqdzy24w//lZGjr0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690360098; x=1690964898;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BNQhgI3bztXsDKLKL9Y51hRanaV6IoqzrzInBKdjpB4=;
        b=Hty+xf9t6U1gAtyFibJhbCj+12jftHXbN6KlAjqYiSL4e4ePIyTbxXPvDrtzMun+4F
         xngxpMBBWZPHrOU5a+ry2NZXtWtc5yygTrFxe60wfC58Emm0pAUBf0CwxudwVsLJPpsw
         gaZi1n1tPo5+RKpBBU8eLV8vcUFTBsGLTZ5Mk3SQcAue8WfIBgEL10wtAMziYnfU6Dv9
         iyWe87zoEzr2tfOe0Yun4hRkqin3igBC2qqpfn9whGwZHtfbUy+o8GjLA9CLA2fqEClU
         z8G8BkyMyPktuFXVqOwNzhWKUvjfRGJVbuf8v/rE65bO0j+e0dU2UEJXyQxTnu9eFDof
         Loqw==
X-Gm-Message-State: ABy/qLaeNvpv/EtxFQKdhrPCrypi622UXlkXkja/y9Sb6GK0RthUAiDP
	eNw1v9PB29UkxfyBaG7G+iBFR9p5lYDCmNceb66HNw==
X-Google-Smtp-Source: APBJJlGd15R95sOTqLbRdv7fFyc+q6u6i0ZUzRxw/mCnaiFn/PjKBrTza/CNFkF+qTar8yZLD+EHTg1UeDSvSqGEe6o=
X-Received: by 2002:a05:6402:129a:b0:522:4d1b:3acf with SMTP id
 w26-20020a056402129a00b005224d1b3acfmr841200edv.37.1690360097943; Wed, 26 Jul
 2023 01:28:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230723150658.241597-1-jdamato@fastly.com> <20230723150658.241597-3-jdamato@fastly.com>
 <d950f4f6-6581-a99f-3375-c0359d45c9f5@gmail.com>
In-Reply-To: <d950f4f6-6581-a99f-3375-c0359d45c9f5@gmail.com>
From: Joe Damato <jdamato@fastly.com>
Date: Wed, 26 Jul 2023 11:28:06 +0300
Message-ID: <CALALjgwVj4ZQ351djbSTqbzVDWPrmJxX7yXweYKXbTtLz0aZ9w@mail.gmail.com>
Subject: Re: [net 2/2] net/mlx5: Fix flowhash key set/get for custom RSS
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, ecree@solarflare.com, 
	andrew@lunn.ch, kuba@kernel.org, davem@davemloft.net, leon@kernel.org, 
	pabeni@redhat.com, arnd@arndb.de, linux-kernel@vger.kernel.org, 
	Tariq Toukan <tariqt@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 25, 2023 at 12:59:32PM +0300, Tariq Toukan wrote:
>
>
> On 23/07/2023 18:06, Joe Damato wrote:
> >mlx5 flow hash field retrieval and set only worked on the default
> >RSS context, not custom RSS contexts.
> >
> >For example, before this patch attempting to retrieve the flow hash fields
> >for RSS context 1 fails:
> >
>
> Hi,
>
> You are adding new driver functionality, please take it through net-next.

Thanks for reviewing the code I sent; I made the changes you requested and
sent a v2, but through net-next this time.

