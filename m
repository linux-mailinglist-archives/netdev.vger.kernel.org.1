Return-Path: <netdev+bounces-125020-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1EC796B98E
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 13:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DBBCB22F01
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EF361CF5DE;
	Wed,  4 Sep 2024 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bdh8vQjr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67CD6126C01;
	Wed,  4 Sep 2024 11:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725447781; cv=none; b=OTGPg5Wd4g9pPeJVT8CA2lNoMOoiobsYIB2ikeNZHlusbUpqLe86jExWLDwe85ALpsrSFobjhylj/ohSpYZZu44SvBRH+RlHF1fX7/kU5BObB7LzMw1EZXCUuCK5W4u+SaHQvMWdzzy+21zfa51T3B+HRzcmwZmnUzdZ/lQj+ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725447781; c=relaxed/simple;
	bh=O3P+6ooQSzr7Nu5bettKeU7yhY4pXh717w4eLMYy8xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=isJUvApDxC9OnevC3FDk0euXSIgdfXlRFLQPLOqL3J2PX0R4ct26o/bWx//yOZl/E9+kJSVJhIvQoW749ljDkOetXiEP5XkBxAkklJyIAFrd717lk6q5nJM8+jVSGRoJR74dgvR+EyokS5CLtc8czktbDHQOvUTP0S6XgQOyBRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bdh8vQjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8B7C4CEC2;
	Wed,  4 Sep 2024 11:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725447781;
	bh=O3P+6ooQSzr7Nu5bettKeU7yhY4pXh717w4eLMYy8xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bdh8vQjrWQYjvEVqm5nHSvbICbZqiU28M4uln3leirSHDb7CqrTCmq5qjoPmOWApe
	 rrd5SSd9VMuCET4mRG5OEKwKyWJV3XBNeAhbkJn6jncUWa/hWCZ1yqgf64f8QW1ayp
	 nN+X/o0yb6vEixAj3lwsh7eSs6opBRXmvjgKcP728Bvcvm3rLadXCjB6DrbF0zdkOx
	 fCVSghR9oRqZa/FpmtW1SC+HAzGCUpjqtS4iYe5sG7mOMuoNseCFhMK0HFn03sTK+k
	 1y3yzQTXFno8GtS8m4zu5WHllii0Q6q2eQM9IjPbnhcw4rzseR99aajQTabL91B5uG
	 e2nc9FmLDmjXQ==
Date: Wed, 4 Sep 2024 12:02:56 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, thepacketgeek@gmail.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, davej@codemonkey.org.uk,
	thevlad@meta.com, max@kutsevol.com
Subject: Re: [PATCH net-next 4/9] net: netconsole: rename body to msg_body
Message-ID: <20240904110256.GR4792@kernel.org>
References: <20240903140757.2802765-1-leitao@debian.org>
 <20240903140757.2802765-5-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240903140757.2802765-5-leitao@debian.org>

On Tue, Sep 03, 2024 at 07:07:47AM -0700, Breno Leitao wrote:
> With the introduction of the userdata concept, the term body has become
> ambiguous and less intuitive.
> 
> To improve clarity, body is renamed to msg_body, making it clear that

nit: the patch uses msgbody

> the body is not the only content following the header.
> 
> In an upcoming patch, the term body_len will also be revised for further
> clarity.
> 
> The current packet structure is as follows:
> 
> 	release, header, body, [msg_body + userdata]
> 
> Here, [msg_body + userdata] collectively forms what is currently
> referred to as "body." This renaming helps to distinguish and better
> understand each component of the packet.

Thanks, IMHO, clear terminology is very important:
it's hard to discuss what you can't clearly name.

> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Code changes are a mechanical update and look good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

...

