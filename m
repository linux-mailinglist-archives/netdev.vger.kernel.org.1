Return-Path: <netdev+bounces-23846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B6FBB76DDA9
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 03:55:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8AE341C21018
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 01:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC651FBC;
	Thu,  3 Aug 2023 01:55:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7DA7F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:55:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5AB3C433C8;
	Thu,  3 Aug 2023 01:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691027701;
	bh=Do3YTtjmi20v0DE5QZloYvTABQwfIFcfm3L+aOjIZYg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tCbi2tusEdFzvHoajmxkWi8IL+9cMrnxqVecvLhszxaClBN/QyNC96zUbB1eb2TKy
	 Lri/JK5O2ZfDb1hK3618LaQLPVjxZluDt+JJeu/OxBAcFDSgUa8EZunOVi/L7gP51t
	 yvwfxziA/CSiFmHLZ0UniqBZIoS4RyMDIAtt7Tvx5jma91DZ4gsswKQmff2ydJoTpk
	 GglY9e51Fs+kyl88b6lleMNWRSsnowprb0xt6DuOCYZiGy7zd0zSA1p8OMrHIJJ2Up
	 xBR8Nangmku9ETKRDiX1yfCDiFfGPymMRfNWFpPr1eqGtBhZHNjWB/JYKtLuHsJacM
	 jOe40w09S0/Tw==
Date: Wed, 2 Aug 2023 18:54:59 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, moshe@nvidia.com, saeedm@nvidia.com,
 idosch@nvidia.com, petrm@nvidia.com
Subject: Re: [patch net-next v2 03/11] ynl-gen-c.py: allow directional model
 for kernel mode
Message-ID: <20230802185459.675dd18c@kernel.org>
In-Reply-To: <20230802152023.941837-4-jiri@resnulli.us>
References: <20230802152023.941837-1-jiri@resnulli.us>
	<20230802152023.941837-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Aug 2023 17:20:15 +0200 Jiri Pirko wrote:
>      supported_models = ['unified']
> -    if args.mode == 'user':
> +    if args.mode in  ['user', 'kernel']:

nit: double space after "in"

>          supported_models += ['directional']

