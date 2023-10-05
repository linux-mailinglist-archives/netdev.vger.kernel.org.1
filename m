Return-Path: <netdev+bounces-38148-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E55AB7B9927
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 02:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 9C5F7281A6C
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 00:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9974319F;
	Thu,  5 Oct 2023 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8+glsGO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8527F
	for <netdev@vger.kernel.org>; Thu,  5 Oct 2023 00:12:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1C0CC433C7;
	Thu,  5 Oct 2023 00:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696464740;
	bh=t25H2QRvJgvk79dORhdyap9/c/i63ZTQ77vPQB+RZYA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=a8+glsGObVEThV976pX1/ODPEPeIEk9DdtShwZaaFq63u3aTiXd1vzqjlMyF0kf9K
	 Vs0sfQmphmlfzME/nZJoBB7hUVCOYhZjgojkJOWnqHl+XUF8MvlCvUvEeADVJMNj+Y
	 hV9+TCullgnN5XWoUXUqXLLf2pAWPzZXJbF5iAN22YcMp5yt4pMkjEyQ9lLCYC7EVC
	 j/1OhVvpe6QR/XnwUxDMmnQ0tu7x0pRZneY7OUkGE1Q6K84yZVCJT+FaySqY5713/g
	 PchUE2VGbghxY3Xe9d5A9dF43gezh0K9HmDKaJAQvIucdUAJXethFoq/nnw3ZW7lQs
	 va/jmo9YbHXZg==
Date: Wed, 4 Oct 2023 17:12:18 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
 edumazet@google.com, donald.hunter@gmail.com
Subject: Re: [patch net-next v2 2/3] netlink: specs: remove redundant type
 keys from attributes in subsets
Message-ID: <20231004171218.701047a2@kernel.org>
In-Reply-To: <20230929134742.1292632-3-jiri@resnulli.us>
References: <20230929134742.1292632-1-jiri@resnulli.us>
	<20230929134742.1292632-3-jiri@resnulli.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Sep 2023 15:47:41 +0200 Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> No longer needed to define type for subset attributes. Remove those.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>

Reviewed-by: Jakub Kicinski <kuba@kernel.org>

