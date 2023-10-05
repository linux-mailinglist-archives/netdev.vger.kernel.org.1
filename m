Return-Path: <netdev+bounces-38149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 332317B992D
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:13:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 567901C208F4
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22BE719F;
	Thu,  5 Oct 2023 00:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFOywzI/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049CC7F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:13:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 805A7C433C7;
	Thu,  5 Oct 2023 00:13:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696464831;
	bh=YNf0JoKsTfqki2hNU9Gihm0zv52ROUXPMlEiNrs0/p4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dFOywzI/AYjtnqcVWWpCioYyCRIk8uZmeP0gQJEKjnEBd4Vs+WuSkpj2QBKNZ6FyD
	 LB6d2qoyGICe3vXlkr1gcOd6xLkSTRBSXChMZao6YCJn2mMQmujP8Ey3XOQk7TMkcl
	 BcF+tFwOaz0YQVBXK/UmLG6jE7bCgpiM20BgLxwn8/1czJBg6y0H9w6902En3gXWqe
	 9Q0wO0D0wqquvuJ4JGsts1XB1Lo5uOnbT1VmQoS9ZHAYPCdXK6DGL/Ju3QlgelCsre
	 5dt4d4qhJNvyKHOURti1WNDfxCc5/doMDycUrVD8LqnLZ1cgj/WC5TOjEqr3xyZL9h
	 B25ptdktWNVVw==
Date: Wed, 4 Oct 2023 17:13:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, donald.hunter@gmail.com
Subject: Re: [patch net-next v2 3/3] tools: ynl-gen: raise exception when
 subset attribute contains more than "name" key
Message-ID: <20231004171350.1f59cd1d@kernel.org>
In-Reply-To: <20230929134742.1292632-4-jiri@resnulli.us>
References: <20230929134742.1292632-1-jiri@resnulli.us>
	<20230929134742.1292632-4-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Sep 2023 15:47:42 +0200 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> The only key used in the elem dictionary is "name" to lookup the real
> attribute of a set. Raise exception in case there are other keys
> present.

Mm, there are definitely other things that can be set. I'm not fully
sold that type can't change but even if - checks can easily be adjusted
or nested-attributes, based on the parsing path.

