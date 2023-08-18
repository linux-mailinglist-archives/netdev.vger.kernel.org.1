Return-Path: <netdev+bounces-28681-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 331DD7803D8
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 04:34:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1D852822C8
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 02:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CC9398;
	Fri, 18 Aug 2023 02:34:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3A6380
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 02:34:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFB9BC433C8;
	Fri, 18 Aug 2023 02:34:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692326061;
	bh=Jit2iBJ4BNzRU3skxq3T6hpxaHNcdhICAiZQt175AHY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ihqR8ljnhsJYVkfUVrQ9HavnkFPqWj7j7Rz1uoVMQVZsDKlXKIgOMruwA13bynKu4
	 QNuA5MxDrmZRkqKvv2/FwxSTQA28PdBpiZE69cHpLAd0ctEGwz+OsTRc363xY+uYyf
	 jDC4wG8vJ6lkyVZABb/9oGKJ505foAtHnPOJ5BSFwpi7BgaqUuK/KvNMuJr1J6ltu0
	 67dwbOfEOvX98L+fLcH4hnZ7RKAvPQZOiENcMV7dTZG4ezhcEGArHla2W+35NswoiM
	 JSJ07BrB9lbFQLCHTRl4r4tVK+r8nRNANB0JORH7ZZz1H12eLt+BLNhDIJ7YuVvc5f
	 /wSeSCc0pTFZw==
Date: Thu, 17 Aug 2023 19:34:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com, shayd@nvidia.com,
 leon@kernel.org
Subject: Re: [patch net-next 0/4] net/mlx5: expose peer SF devlink instance
Message-ID: <20230817193420.108e9c26@kernel.org>
In-Reply-To: <20230815145155.1946926-1-jiri@resnulli.us>
References: <20230815145155.1946926-1-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Aug 2023 16:51:51 +0200 Jiri Pirko wrote:
> Currently, the user can instantiate new SF using "devlink port add"
> command. That creates an E-switch representor devlink port.
> 
> When user activates this SF, there is an auxiliary device created and
> probed for it which leads to SF devlink instance creation.
> 
> There is 1:1 relationship between E-switch representor devlink port and
> the SF auxiliary device devlink instance.
> 
> Expose the relation to the user by introducing new netlink attribute
> DEVLINK_PORT_FN_ATTR_DEVLINK which contains the devlink instance related
> to devlink port function. This is done by patch #3.

The devlink instance of the SF stays in the same network namespace 
as the PF?

