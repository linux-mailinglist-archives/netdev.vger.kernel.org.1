Return-Path: <netdev+bounces-29687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A96EA78457C
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 17:28:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551F7281071
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 15:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505D01D315;
	Tue, 22 Aug 2023 15:28:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2727A18AE5
	for <netdev@vger.kernel.org>; Tue, 22 Aug 2023 15:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33BFDC433C7;
	Tue, 22 Aug 2023 15:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692718114;
	bh=uij0V2vp0HZMswMEiF44MNNzcqJVPcStsg9AOCzR+VY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M699uUWnfwYoY9cKwUDH3mojAKM0hUZS+cxxy83Y1YTfqxGinVZ6Nm/Pe2BBHKexK
	 2k85ixH+h9+aIh7m/EOMhh/Ff+w0lBILflqpeCctBoKKXvgaC4k6XUi7NIzH3AsVPZ
	 jYejNB9sHIXm5dw0EDMsp+YCWu+XZhcfTSPgs+IxTJfVp5OdhNhS71SMlqUVXeofds
	 nOpLjsRIJ8p5CVoCt8w9IZ+SMmE0jIZK+lKkigW0KNlIrgkmQJTmSNrg74Yh4Qnyb1
	 90MU9wEOYXZ/X2O4A6zJb0h3OIpv/V+hlWuvrxv4PCR8Nh+uiFOrgvQXfXN1kdrMlm
	 hMrbNOPc7PPOA==
Date: Tue, 22 Aug 2023 08:28:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com, shayd@nvidia.com,
 leon@kernel.org
Subject: Re: [patch net-next 0/4] net/mlx5: expose peer SF devlink instance
Message-ID: <20230822082833.1cb68ef7@kernel.org>
In-Reply-To: <ZORXVr4bcTlbstj8@nanopsycho>
References: <20230815145155.1946926-1-jiri@resnulli.us>
	<20230817193420.108e9c26@kernel.org>
	<ZN8eCeDGcQSCi1D6@nanopsycho>
	<20230818142007.206eeb13@kernel.org>
	<ZONBUuF1krmcSjoM@nanopsycho>
	<20230821131937.7ed01b55@kernel.org>
	<ZORXVr4bcTlbstj8@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Aug 2023 08:36:06 +0200 Jiri Pirko wrote:
> >I'm thinking about containers. Since the SF configuration is currently
> >completely vendor ad-hoc I'm trying to establish who's supposed to be
> >in control of the devlink instance of an SF - orchestrator or the
> >workload. We should pick one and force everyone to fall in line.  
> 
> I think that both are valid. In the VF case, the workload (VM) owns the
> devlink instance and netdev. In the SF case:
> 1) It could be the same. You can reload SF into netns, then
>    the container has them both. That would provide the container
>    more means (e.g. configuration of rdma,netdev,vdev etc).
> 2) Or, your can only put netdev into netns.

Okay, can you document that?

> Both usecases are valid. But back to my question regarding to this
> patchsets. Do you see the need to expose netns for nested port function
> devlink instance? Even now, I still don't.

It's not a huge deal but what's the problem with adding the netns id?
It's probably 50 LoC, trivial stuff.

