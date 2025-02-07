Return-Path: <netdev+bounces-163773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DD407A2B832
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 02:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B90B61889EE8
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 01:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E0B16EB4C;
	Fri,  7 Feb 2025 01:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVehmyMe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F289A7DA67;
	Fri,  7 Feb 2025 01:41:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738892501; cv=none; b=ClGxjKtFZnotbYJIC4u8HVV29hvg+ZleEH3Ful/ynav/1DeUH5CwX6rSr8ScymX59ahdEqNUM78gDm0vD5qqyt2uymWCYrWpbPAd9KTT4YGIAHH/YJjFMxIjNt/2P669WkTdUYmY6KBLuitmBQaW86D3/07t/WdRes//nXYbZOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738892501; c=relaxed/simple;
	bh=4MYCSeWOeC/n09U6Y4pwICxXXDIOpe/sHpaXbAh27DA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHrZbHQONyanbvEDXk6KPKUf6XRglPPQvy4lOau+YTWu+cSuk6dkFB+a5KeFes/SDjkNoNs638wjRdLnf4aNb1vsHC08Vi78PqynqOXVnLMqJlCVxp3BXn0UXaYqx2oGHCs67GtgPd41lKrYBVL5RGTvCjRtXCsmtnMj5NDqLo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVehmyMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D648CC4CEDD;
	Fri,  7 Feb 2025 01:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738892500;
	bh=4MYCSeWOeC/n09U6Y4pwICxXXDIOpe/sHpaXbAh27DA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sVehmyMe4AwT3JnHO+tTy8hSF7t8a3knageIm70y4hnVYi1jTF3bXfMwxh4qYB98v
	 sp5Bepsdz3m7BHeclmQDkY7OjKsvidqW4GOrLPEWj16r2Z5VgiASQtyPTMzTgUV9P8
	 ulXg3ONnlqKOlVZ43YfDwF6G2GQBOrTzQ33gPVmuayStM/rS0jCzDdU82qb2UHI4vt
	 27CUNXfyIXehkH5ZVpQkRSc409i23PAizkLrcJDwtVbTG88GKhxNORNII4Bzlm/vMT
	 vD8iR4lsm9MxPfP4rmSn8tLf3Gn/oPsdxRXASLnzlOWecb5XmraEMZD3Guy/qp9S6f
	 rv3m0Ptm8x7KQ==
Date: Thu, 6 Feb 2025 17:41:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Joe Damato <jdamato@fastly.com>
Cc: netdev@vger.kernel.org, Donald Hunter <donald.hunter@gmail.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Stanislav
 Fomichev <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, Daniel
 Jurgens <danielj@nvidia.com>, Martin Karsten <mkarsten@uwaterloo.ca>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 1/2] netdev-genl: Add an XSK attribute to
 queues
Message-ID: <20250206174138.7de4580d@kernel.org>
In-Reply-To: <Z6Vig04c-a46WScr@LQ3V64L9R2>
References: <20250204191108.161046-1-jdamato@fastly.com>
	<20250204191108.161046-2-jdamato@fastly.com>
	<20250206165746.7cf392b6@kernel.org>
	<Z6Vig04c-a46WScr@LQ3V64L9R2>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 17:31:47 -0800 Joe Damato wrote:
> > nla_nest_start() can fail, you gotta nul-check the return value.
> > You could possibly add an nla_put_empty_nest() helper in netlink.h
> > to make this less awkward? I think the iouring guys had the same bug  
> 
> Ah, right.
> 
> I'll see what a helper looks like. Feels like maybe overkill?

Yeah, not sure either. Technically nla_nest_end() isn't required here,
but that's not very obvious to a casual reader. So a helper that hides
that fact could be useful:

static inline int nla_put_empty_nest(struct sk_buff *skb, int attrtype)
{
	return nla_nest_start(skb, attrtype) ? 0 : -EMSGSIZE;
}

But totally unsure whether it's worthwhile. Just don't want for someone
to suggest this on v4 and make you respin once again.

