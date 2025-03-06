Return-Path: <netdev+bounces-172579-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B27FA55709
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 20:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EC993A3FE4
	for <lists+netdev@lfdr.de>; Thu,  6 Mar 2025 19:43:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 224A31A83EE;
	Thu,  6 Mar 2025 19:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjYl6z7O"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F282C6F31E
	for <netdev@vger.kernel.org>; Thu,  6 Mar 2025 19:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741290238; cv=none; b=YNNcna8tIIYmZbrbBibUtABnDmP/9DLxOjf/3YUOjox33E/6637kFX6o8MyDsNAR+CF7OPgXp+aUkAD3gmSNHv/BwOjeNph7ZaiBzqgZQJZ4CPTXYN4qw/PrX/aJ9gLbJO46gtw3Afqh5obW2ZHWTsdpube1su8SlKCtXQ/97Bo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741290238; c=relaxed/simple;
	bh=I9lDSkPbJZJ6bUq+lRfv7GkcEU/3r/U9SmbOeqLd4LY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=btMwNcue1sOV2/ouyvbaXqVwG/3snodzTKMA5vGpoVWRKahPsN0XWgPJ1pXaRbLOy974QOhgIZZSGomZEBjfdJLUI8aGw3YcApfDu4P/IBP1NuDJ7+KIqTDkS4n9h2iOp5zk8yICP1eFuu2vGP9UXbM2lDH7fcJ5cNjmrpsvGEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjYl6z7O; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7903C4CEE0;
	Thu,  6 Mar 2025 19:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741290236;
	bh=I9lDSkPbJZJ6bUq+lRfv7GkcEU/3r/U9SmbOeqLd4LY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FjYl6z7OcCjSxYRhB06QwYSnB8gKJfKqLUw1dAcXzdEJQaNWFZvrQdQWOssIRrVSM
	 3D8+FLDOhixVU/Iua0YBbHyktPqSrFEI4rNBD7lnudVbq5fgxwwfh50YeUg0lVsM66
	 nSHRQDYU2lOBBVfBLBRxrz8ClNSnyPOglEiln5o2v4fv30+q7UOk+3KcHeLQo0Mjm/
	 0ypvxoc5/QYXsKn9gQYOgM9ABrNOaTGqsa7BuSS/BJruMpn3prO6OPdffxRzCntXqn
	 pWxkYGIPJywGCmpSJwA52ut+ZCvfuXjm/zHbgzP3cMFzmtHX0UXWsJi/A6wbW9STQZ
	 /zDnrKrIewRhA==
Date: Thu, 6 Mar 2025 11:43:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 saeedm@nvidia.com, leon@kernel.org, tariqt@nvidia.com,
 andrew+netdev@lunn.ch, Gal Pressman <gal@nvidia.com>
Subject: Re: [PATCH net] net/mlx5: Fill out devlink dev info only for PFs
Message-ID: <20250306114355.6f1c6c51@kernel.org>
In-Reply-To: <7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
References: <20250303133200.1505-1-jiri@resnulli.us>
	<53c284be-f435-4945-a8eb-58278bf499ad@gmail.com>
	<20250305183016.413bda40@kernel.org>
	<7bb21136-83e8-4eff-b8f7-dc4af70c2199@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Mar 2025 21:20:58 +0200 Tariq Toukan wrote:
> It's pretty obvious for everyone that responding within 24h cannot be 
> committed, and is not always achievable.

On the occasion that you are too busy to look at the list on a given
day you can just take the patch via your own tree. It's not like we're
marking the patch as Rejected, we're marking it as Awaiting Upstream.

nvidia's employees patches should go via your tree, in the first place.
What are you even arguing about. Seriously.

