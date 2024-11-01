Return-Path: <netdev+bounces-140856-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DDDA9B8813
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 02:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 008EC281D5A
	for <lists+netdev@lfdr.de>; Fri,  1 Nov 2024 01:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8164F1AAC4;
	Fri,  1 Nov 2024 01:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q2O1Hr1W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4795C22615;
	Fri,  1 Nov 2024 01:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730422907; cv=none; b=ZGOWTbZqpc5vYsx+OiYX0hHxhjgy2DZTY/pLs4y6QXCW84c/2oMjLJ7w0sKSXypMBby9AGxN0rARVY8YLtx1Db1xKoVZ+QZb0m7AqL5R60z6Ewmwom0Jf1sIObdc0CS5Jlvfe1x8NO2Eyouunk8uPyRy671csGt+Rm7lBUhvzMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730422907; c=relaxed/simple;
	bh=g9AJo+IRyva5UjfrrunnTm56/Yysi7JItCsP262Jt0o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RrvzTKrfQ5nfATXSftrJ1yxoPvghbEg67V+pqmqbGZNPxnHAcmHC6lskfXmL/gjUaNtlREXun/QJP9kwxN9csprbufgOB4sPxy/N+j2KTr1gDqWGK1AvF8mHntpTdsQ6CqKzyTK4lxEn/V5q9BZ3j1uRsP6mOqLmegztAWrqfBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q2O1Hr1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48FA1C4CEC3;
	Fri,  1 Nov 2024 01:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730422906;
	bh=g9AJo+IRyva5UjfrrunnTm56/Yysi7JItCsP262Jt0o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q2O1Hr1WU75GypbCn1riww821dleef8Cc/Vva/PRFM7MLO40c1beyJsxpZkTlHUHH
	 OuXZufPeJy4TjVJYaFkIMZ9Gk8BkmtEkE5kNPtiac2xDVjBBHtul9hElUVusVBACnY
	 yGDUg5WJItiIgHB0+zeJrJU47wubtqylP+uvZUSY4gsi0Qn2Wx3zZjxz5DKfEO0TNp
	 95+ped56WEDgAWPs4ln9o1XOIAv+B3kHi+uzly8QpvtfNJPNyx1nuF9PiqRuGZWYLt
	 L4/OIt592oRxZMl6xd4eTHaqtusL50Qaz3/0wUl/5BQSqJixJWPMH83IRzAIwkESTo
	 ZWot1b74nM23g==
Date: Thu, 31 Oct 2024 18:01:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Johannes Berg
 <johannes@sipsolutions.net>, David Ahern <dsahern@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, Kees Cook
 <kees@kernel.org>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH v2 1/4][next] uapi: socket: Introduce struct
 sockaddr_legacy
Message-ID: <20241031180145.01e14e38@kernel.org>
In-Reply-To: <23bd38a4bf024d4a92a8a634ddf4d5689cd3a67e.1729802213.git.gustavoars@kernel.org>
References: <cover.1729802213.git.gustavoars@kernel.org>
	<23bd38a4bf024d4a92a8a634ddf4d5689cd3a67e.1729802213.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 15:11:24 -0600 Gustavo A. R. Silva wrote:
> + * This is the legacy form of `struct sockaddr`. The original `struct sockaddr`
> + * was modified in commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible
> + * array in struct sockaddr") due to the fact that "One of the worst offenders
> + * of "fake flexible arrays" is struct sockaddr". This means that the original
> + * `char sa_data[14]` behaved as a flexible array at runtime, so a proper
> + * flexible-array member was introduced.

This isn't spelled out in the commit messages AFACT so let me ask..
Why aren't we reverting b5f0de6df6dce, then?
Feels like the best solution would be to have a separate type with
the flex array to clearly annotate users who treat it as such.
Is that not going to work?

My noob reading of b5f0de6df6dce is that it was a simpler workaround
for the previous problem, avoided adding a new type (and the conversion
churn). But now we are adding a type and another workaround on top.
Sorry if I'm misunderstanding. No question that the struct is a mess,
but I don't feel like this is helping the messiness...

