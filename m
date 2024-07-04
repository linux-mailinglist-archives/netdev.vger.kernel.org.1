Return-Path: <netdev+bounces-109072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5923F926CB6
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 02:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1414D280F84
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 00:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0AB802;
	Thu,  4 Jul 2024 00:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CiZHXJHl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D1D4A31;
	Thu,  4 Jul 2024 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720052441; cv=none; b=myIlcWs9oObAda/qmnUn6FaAq0vhQyg6SDJEuv+JFGBPi7L7qGUlKAIQ/Wzeavl1MDCQ5bKc1sUcFh/hafZe8GtVqG/1F09MDG61b+FwdoMJu8rj7up9TKtUvl3FSAga4egulkK371KWBPaIKECGKkvXth5bnNSHS3UJ1C6E9cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720052441; c=relaxed/simple;
	bh=HtvX69u2dZnkpAacbwaUxn58MEjLTovr/iw+lmlZ6bs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RTcq+43XYB6CUhRXAInnxQVN8NCbYHUElPJ4dJt6pUJvPi5NZbwSwffqTrPlMSAiKGiQc1jcHPkzWDNug16KpzdItXUNY5BMfiphlucsL18nmUU57fYYFae0O/4QkXNd39NHHTkvGR1TBFCJt6A93Zb8uQrLcS+r9JvBnh7Qu70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CiZHXJHl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37996C2BD10;
	Thu,  4 Jul 2024 00:20:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720052440;
	bh=HtvX69u2dZnkpAacbwaUxn58MEjLTovr/iw+lmlZ6bs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CiZHXJHlgzKnOC1TCafa+AT97gNltwm/YFLwvrs2EaL5bvjBkzZlEQtq55fUmATXJ
	 MQUuqK3Vhzp4Xn53y2z7ByrXdqg6yhN8h3RluOH872+3ezBdXC3cZQm2mtzjat26vi
	 hBdgr//FHL9pX8wGWMENUXY0/kLjjBaYp4g8LzO2HJDZ6CwZHDdzxK+hAiXe+aPnez
	 vdDGEvSNS+yiPpyHqceUfvqfc9bgOHaYDMcua2V0tmN8Z8SN4xafvvuuqa+qtWRENg
	 gEr5bEbeObuBBDozKZloYeXIR8HNrrz3w1Jy6wE7m9DlzCXrYLbp1+/RkEvhiFUCPv
	 nOUj/trSRHfRA==
Date: Wed, 3 Jul 2024 17:20:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alexander Lobakin <aleksander.lobakin@intel.com>
Cc: =?UTF-8?B?QXNiasO4cm4=?= Sloth =?UTF-8?B?VMO4bm5lc2Vu?=
 <ast@fiberby.net>, <netdev@vger.kernel.org>, Davide Caratti
 <dcaratti@redhat.com>, "Ilya Maximets" <i.maximets@ovn.org>, Jamal Hadi
 Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko
 <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Ratheesh Kannoth
 <rkannoth@marvell.com>, Florian Westphal <fw@strlen.de>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next 1/9] net/sched: flower: define new tunnel flags
Message-ID: <20240703172039.55658e68@kernel.org>
In-Reply-To: <b501f628-695a-488e-8581-fa28f4c20923@intel.com>
References: <20240703104600.455125-1-ast@fiberby.net>
	<20240703104600.455125-2-ast@fiberby.net>
	<b501f628-695a-488e-8581-fa28f4c20923@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 3 Jul 2024 12:59:54 +0200 Alexander Lobakin wrote:
> >  enum {
> >  	TCA_FLOWER_KEY_FLAGS_IS_FRAGMENT = (1 << 0),
> >  	TCA_FLOWER_KEY_FLAGS_FRAG_IS_FIRST = (1 << 1),
> > +	/* FLOW_DIS_ENCAPSULATION (1 << 2) is not exposed to userspace */  
> 
> Should uAPI header contain this comment? FLOW_DIS_ENCAPSULATION is an
> internal kernel definition, so I believe its name shouldn't leak to the
> userspace header.

Also since it's internal, can avoid the gap in uAPI and make
ENCAPSULATION be something like "last uAPI bit + 1" ?

