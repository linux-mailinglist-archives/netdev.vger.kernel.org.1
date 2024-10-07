Return-Path: <netdev+bounces-132765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 68E7F993113
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FC981F22581
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1301D89E6;
	Mon,  7 Oct 2024 15:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sCnt3dxZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 103611D88A0;
	Mon,  7 Oct 2024 15:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728314673; cv=none; b=iZLAtGz5Lkd/vLCClZLu+xdxRzCnkvG9hQ8udv8ymuNmTWqy4g1N08p/34QFgc9heFf2JdFTlNd+HL00/gVGMIWBrf+jyZ/IotaXNMSHFFEP5tiZzmV+bEwC6AiRHoQav+L3Y7Nbgof4edVcCHN47THTFaqcEHg6r8YqgApJTrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728314673; c=relaxed/simple;
	bh=TVuCt0qwnEPcydariZZBtobhPmzaUn8ER/x+RkqX4+A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cIeT+BhpY7Hf3FgVD3RJf888l6pq8nkbzp6NvHPGT0yNhs3c7Id5qbOEgELNHP+oD8TRYfN0RCdIR8TVtA1bo+aXAvsvBhLZ7gMxok2QckUMjHDlLyR7IZwe66HdBjIJRtXGXw8pFtqjk2lLc9JJP0OumqB7sIJf9OGynzIVRWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sCnt3dxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40241C4CEC6;
	Mon,  7 Oct 2024 15:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728314671;
	bh=TVuCt0qwnEPcydariZZBtobhPmzaUn8ER/x+RkqX4+A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sCnt3dxZJCQ7uEkg34+5KBKkFC+woj4zhHnAxOCA57C9CC8q14XDMAUIDt1LJ+9aM
	 knS168yVmCjdcLnDeC8TTi4ZsKwLcIYKQUBXG71CFRlAoCIKAvIbj0IoAPXytatZxI
	 78IkwKTvf1B8lbomZewt/vh60s81KjfURNNL0n98DKhKLRpyMcbdcikRUm30xiI0Q7
	 sNMUClNblUq1dprMBGodhsmHFsFmjKwz8MajIQ/1fAj/YfEvykFSmitqN0WNK58ZfA
	 erZZfV76wy5WKyjP9J7SDo+tFGl9QJwVCOcmGjOExfIVw3BEtblx4peyJNGxIzlfW3
	 32ELPhy8n50Xg==
Date: Mon, 7 Oct 2024 08:24:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
 <corbet@lwn.net>, netdev@vger.kernel.org, workflows@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH RFC net] docs: netdev: document guidance on cleanup
 patches
Message-ID: <20241007082430.21de3848@kernel.org>
In-Reply-To: <20241004-doc-mc-clean-v1-1-20c28dcb0d52@kernel.org>
References: <20241004-doc-mc-clean-v1-1-20c28dcb0d52@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 04 Oct 2024 10:49:53 +0100 Simon Horman wrote:
> The purpose of this section is to document what is the current practice
> regarding clean-up patches which address checkpatch warnings and similar
> problems. I feel there is a value in having this documented so others
> can easily refer to it.
> 
> Clearly this topic is subjective. And to some extent the current
> practice discourages a wider range of patches than is described here.
> But I feel it is best to start somewhere, with the most well established
> part of the current practice.
> 
> --
> I did think this was already documented. And perhaps it is.
> But I was unable to find it after a quick search.

Thanks a lot for documenting it, this is great!
All the suggestions below are optional, happy to merge as is.

> +Clean-Up Patches
> +~~~~~~~~~~~~~~~~

nit: other sections use sentence-like capitalization (only capitalizing
the first word), is that incorrect? Or should we ay "Clean-up patches"
here?

> +Netdev discourages patches which perform simple clean-ups, which are not in
> +the context of other work. For example addressing ``checkpatch.pl``
> +warnings, or :ref:`local variable ordering<rcs>` issues. This is because it
> +is felt that the churn that such changes produce comes at a greater cost
> +than the value of such clean-ups.

Should we add "conversions to managed APIs"? It's not a recent thing,
people do like to post patches doing bulk conversions which bring very
little benefit.

On the opposite side we could mention that spelling fixes are okay.
Not sure if that would muddy the waters too much..

