Return-Path: <netdev+bounces-127412-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F04F697549C
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 15:52:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3CA41F224EE
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 13:52:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14B619E98B;
	Wed, 11 Sep 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5ZcVvwV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A67719E986
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062675; cv=none; b=FfZ3gqq2lC6Z89w5ADJcRxHbUcxWh6apKtgihulbKB/uQIhu+7fPM25qDslOZ0Z6wabJ92Zfj0C50lM6cPJEXBbsaeetxc33MxLIsTa1W85eMfYxIlOYHpYqmNTMs+z2ppFfL3AFqXupTDu8LzRDouj9yFdGn0DR+/Y+q1AqN+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062675; c=relaxed/simple;
	bh=oYgJX+RcXQt4Re98d95/VhY3lE789/1gGYK7VWVwX+w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IR8+D/84VUGIeWX+iB6IEc4qDYFkXvoUk0NqlZG21/BTJevqhA/HRSGhJ9dHtMj25iUpke3k7dbTdMh8YycKX+RvbQJcsc3SoeRw6v+SQg8OKpXTNxpPEY7Pvv6OAodHIp+QdbkQnY4jzQzm5LPJg+98ZeNWQE6ISfngQL65cbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5ZcVvwV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B22C4CEC0;
	Wed, 11 Sep 2024 13:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726062675;
	bh=oYgJX+RcXQt4Re98d95/VhY3lE789/1gGYK7VWVwX+w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5ZcVvwVZuAhaROcpWCpeRpPUmfhjlkw8DLLfAA1CwKI4XytjpRAJc3Q6oRo0uTj4
	 zUCHR1GrDEfGTW6krzVDQElrqSZlKwoI5GSQyLnEV4187L95h4s6+jylUKidZ+MNtE
	 LSsuU1nPqER42waizT/ADGutJCB7bisTdxhIjHTi19c/ldwJ28i7qFB21vdd9dH2CT
	 k6gNh1l2DzlJ8axE3nK7A/b7zNX3a+BuAYD6AgrGETE/gdJ8k54DqqlG29aBjzpmvl
	 VGqTTXrB/VF0EAIoLrJAsQ1h4B5v0dJGsYhQBomx2EPJjtRywXOp5C6ezxE0RuF9er
	 G8WHDSQLmue0w==
Date: Wed, 11 Sep 2024 14:51:11 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, justinstitt@google.com
Subject: Re: [PATCH net-next] net: caif: remove unused name
Message-ID: <20240911135111.GY572255@kernel.org>
References: <20240911015228.1555779-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911015228.1555779-1-kuba@kernel.org>

On Tue, Sep 10, 2024 at 06:52:28PM -0700, Jakub Kicinski wrote:
> Justin sent a patch to use strscpy_pad() instead of strncpy()
> on the name field. Simon rightly asked why the _pad() version
> is used, and looking closer name seems completely unused,
> the last code which referred to it was removed in
> commit 8391c4aab1aa ("caif: Bugfixes in CAIF netdevice for close and flow control")
> 
> Link: https://lore.kernel.org/20240909-strncpy-net-caif-chnl_net-c-v1-1-438eb870c155@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: justinstitt@google.com
> CC: horms@kernel.org
> 
> It's a bit unusual to take over patch submissions but the initial
> submission was too low effort to count :|

Reviewed-by: Simon Horman <horms@kernel.org>

