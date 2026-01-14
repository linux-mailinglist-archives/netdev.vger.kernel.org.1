Return-Path: <netdev+bounces-249661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 294AAD1BF1F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 02:34:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E75E33011A4E
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 01:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68FC82DC764;
	Wed, 14 Jan 2026 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCLHM8vU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F4A2BE647;
	Wed, 14 Jan 2026 01:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768354496; cv=none; b=u8ccdbLRdbDDkVaPw6Xo/o0UFjsExWToCL8ca0SPBhs7Pzkiv3ayG1K7PP0yTlq82i50DapOuB68CZbzhoJoJLaHX5Qle9sUjkf7GMSN2ANHZAqbadiTV7J5mJeKa4F+465LOIFP8lMy6DsebZvAGkQodIwYfTGZXPKBVcofQNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768354496; c=relaxed/simple;
	bh=XkMgpfEJT768LmocN+/6PFDvzRNBErn+j+xO5bWs1q8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TqGizdB+UbI6qpJgdej+GTF8c1W1X/8gqowypiv5WgEStRDZVckjXXASBcRpjZXBQn5McUbEKQ+j8VGTF24Et5APgyMYqMH6oennXDj/92bTI15ZR5lua2BXQ10HAJr9cUPVa38XcF/Y4K/3fpcdxuwR69xHBzaikA0l8VzIJI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCLHM8vU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF58FC116C6;
	Wed, 14 Jan 2026 01:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768354496;
	bh=XkMgpfEJT768LmocN+/6PFDvzRNBErn+j+xO5bWs1q8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pCLHM8vU4qNfLeJM0L6K1mibE56Ydf7eWbKlFb4BfCxIBnXV4WacDdGHY80CPqlF6
	 P3FsjZDIGyYl9aUiQDW33nEbBqdK3PDWlFuolwlsuDGJhwNc5uCqJVMX8C85f2sz5V
	 h6twdwf0DgyrsvvUbtUgg2T2KCUccpiHjqxrowcBM8/Fe2C9UYb1uwstMZ4AnKgmJQ
	 5pL/EH1eDK1t1p2qbF+HwY48NtB9YjnS1LC1SchD07SLU4wCWt0d2p9qkLr0or0BY/
	 NxKcqxlqtkllijioClr7pmFE+SnO0i/lQ6n7KOyRcNpmD1VrTySYFu64O4hsWOkbHa
	 Ayd4Rl3OYa+Dw==
Date: Tue, 13 Jan 2026 17:34:54 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, netdev@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: netdev: refine 15-patch limit
Message-ID: <20260113173454.55a995cc@kernel.org>
In-Reply-To: <20260113-15-minutes-of-fame-v1-1-0806b418c6fd@kernel.org>
References: <20260113-15-minutes-of-fame-v1-1-0806b418c6fd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Jan 2026 17:47:15 +0000 Simon Horman wrote:
> +Limit patches outstanding on mailing list
> +-----------------------------------------
> +
> +Avoid having more than 15 patches, across all series, outstanding for
> +review on the mailing list. This limit is intended to focus developer
> +effort on testing patches before upstream review. Aiding the quality of
> +upstream submissions, and easing the load on reviewers.

Thanks for adding this.

In practice I think the limit is also per tree (net vs net-next)
to avoid head of line blocking fixes.

