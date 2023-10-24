Return-Path: <netdev+bounces-43729-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0B247D4525
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0E661C2048F
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F27FD6FA5;
	Tue, 24 Oct 2023 01:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IBC9ySoF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D14BC20E3
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 01:52:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C97FCC433C7;
	Tue, 24 Oct 2023 01:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698112343;
	bh=FbA3kbFjjDVuh57fCZqykHjH+Ku4YvHw9Cgw9uAsT4M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=IBC9ySoFq2An4uYU54Q0y/1m+rXFynXkRFfPs/T7jqbRt63FOQJp0TwO5MpTFxtAw
	 5smS9TbQIzL9RevrDH/NnGQP5e3IHVCm39i3E3yzYyJ4IdwYlWDafhgjCO4Vk57qjO
	 fJNgyVEnB71PFGfL8Qo4lbi42J04ZM1dCrU700oe8gSQ0xQXTZ1eTyO6juxOJo/olY
	 ab1aogVQQJkN4LiElXX57Y30HQjk+AJT792sl/aKI//4wlkHcDeQ6UD4Y3VmDlaJpT
	 KiJKRe8tcEsBTaK+QZnDa3H3vYH0OzMVFuD2MRd836fWZiH2eH5TrnzPmyMGRFp6+z
	 F3eS98fzmM5zg==
Date: Mon, 23 Oct 2023 18:52:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Networking <netdev@vger.kernel.org>, Loic Poulain
 <loic.poulain@linaro.org>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 Johannes Berg <johannes@sipsolutions.net>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Subject: Re: [PATCH net v2 1/2] MAINTAINERS: Move M Chetan Kumar to CREDITS
Message-ID: <20231023185221.2eb7cb38@kernel.org>
In-Reply-To: <e1b1f477-e41d-4834-984b-0db219342e5b@gmail.com>
References: <20231023032905.22515-2-bagasdotme@gmail.com>
	<20231023032905.22515-3-bagasdotme@gmail.com>
	<20231023093837.49c7cb35@kernel.org>
	<e1b1f477-e41d-4834-984b-0db219342e5b@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 07:11:12 +0700 Bagas Sanjaya wrote:
> > 14 patches authored and 15 signed off?
> > Let me be more clear this time - nak, please drop this patch.  
> 
> Or maybe as well drop INTEL WWAN IOSM DRIVER entry (and let
> WWAN subsystem maintainers handle it)? I don't want
> people get their inboxes spammed with bounces against
> his addresses, though.

Right, sorry, still delete him from the MAINTAINERS.
Just don't add him to the CREDITS.

> He's now in a state of limbo. He has significant contribution
> (and gets listed by get_maintainer script with (AFAIK) no way
> to filter him out), yet emails to him bounces. What will be
> the resolution then?

Yes :( Not much we can do about that (even if we drop him from
maintainers all fixes will CC him based on the sign-off tags).

