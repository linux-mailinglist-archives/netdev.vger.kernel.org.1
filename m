Return-Path: <netdev+bounces-41772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 198B57CBE12
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 10:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77377B20FDF
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 08:49:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 817C43C6AB;
	Tue, 17 Oct 2023 08:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwreSMny"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64661BE6D
	for <netdev@vger.kernel.org>; Tue, 17 Oct 2023 08:49:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F31C433C7;
	Tue, 17 Oct 2023 08:49:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697532591;
	bh=kh4JXDpLOdRErLuoLtVHfTZr4SeqQGMlNrjg8Zdxqfc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iwreSMnye06gZ/DOlJ5YvmOFaO07FYeYUmP2Z+w9bm1jt2ageZjvcbcaX9C+xPAPy
	 J15zVvNQ8+5a15vFxVy4eKFO2nhO8xauaAXxn+vMy0kisj0FTS3Xh+vklsizlVQ5ul
	 9ChGYwHuEnCZq/YW6cGDHSnrdjI9JfajXExMMXvRtZsgOGHoFtGZqeR9JhdrHDF6q9
	 mJGEzEoRLPPa9arJEHpaMigUfpv6qVXWsMDSARUa2t4Ymw2/2eQT/nXrpbpiEb+XEs
	 bRWVgcmZb5Bp63D2pCfb/AoXGl+52Jp/9bDG+QfHP5UVKGwjqfochxUFTKKT13xN/V
	 hqK5cs0TzlnIQ==
Date: Tue, 17 Oct 2023 10:49:47 +0200
From: Simon Horman <horms@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	davem@davemloft.net, edumazet@google.com
Subject: Re: [patch net-next v3 1/7] net: treat possible_net_t net pointer as
 an RCU one and add read_pnet_rcu()
Message-ID: <20231017084947.GI1751252@kernel.org>
References: <20231013121029.353351-1-jiri@resnulli.us>
 <20231013121029.353351-2-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013121029.353351-2-jiri@resnulli.us>

On Fri, Oct 13, 2023 at 02:10:23PM +0200, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Make the net pointer stored in possible_net_t structure annotated as
> an RCU pointer. Change the access helpers to treat it as such.
> Introduce read_pnet_rcu() helper to allow caller to dereference
> the net pointer under RCU read lock.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Simon Horman <horms@kernel.org>


