Return-Path: <netdev+bounces-63119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B68D782B442
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 18:41:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64C3828A39F
	for <lists+netdev@lfdr.de>; Thu, 11 Jan 2024 17:41:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53822524B9;
	Thu, 11 Jan 2024 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRPCBwSd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365A315CA;
	Thu, 11 Jan 2024 17:40:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C44BC433F1;
	Thu, 11 Jan 2024 17:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704994856;
	bh=MfBc6A27Fe00cEEVrSRCH6bH1WWkTjxEjCThscGoJCc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lRPCBwSd6iDOggTLBQary/6Uk1OBLjXs7racLu2wrILi+gPhXWZPklLZw1sx/R1e0
	 vQNbqM+KUWNYK+23flW+OCzIIJSiaYgBGPETotvHJSR6XvxCZMHvfxzZyyWenCWD7c
	 z68+U38pHDCfW2Y1hYrc1gHskdX4usNtVNKCi12DxWLiWj1cYVf0NngyfnvNmbaigR
	 VYiAI5BOAgGTa/JaQpuVaux+mStU1v043AitkzugrkoTjLmm66QoVakp4NLyCdMu2T
	 85UGZSMNsow3Q3Gtcw1sCtsl1gDpPCDs6SaGRrmdMHZ/S0AhQwjzFx189S49dnnmz/
	 yXnHjEoltPeEw==
Date: Thu, 11 Jan 2024 09:40:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux
 Networking <netdev@vger.kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>
Subject: Re: What to do on MIA maintainers?
Message-ID: <20240111094055.3efa6157@kernel.org>
In-Reply-To: <ZZ_JuZd0RJUzIrgY@archie.me>
References: <ZZ_JuZd0RJUzIrgY@archie.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 11 Jan 2024 17:58:01 +0700 Bagas Sanjaya wrote:
> Earlier in late last December, I sent a patch removing Karsten Keil
> <isdn@linux-pingi.de> from MAINTAINERS due to inactivity [1], but Greg was
> unsure about that [2]. So I privately tried to reach Karsten (asking for
> confirmation), but until now he is still not responding to my outreach, hence
> IMO he is MIA.
> 
> What to do on this situation? Should he be removed from MAINTAINERS?

Well. I'm not sure you should do anything about it.. In an ideal world
with properly set up maintainer structure it should be up to the next
level maintainer to decide when to do the cleanups. Random people
initiating that sort of work can backfire in too many ways. IDK what
a good analogy would be here, but you wouldn't for example come up
to an employee in a store, when you think they aren't doing anything,
and tell them to go stock shelves.

If there are patches on the list that needs reviewing and the person
is not reviewing them, or questions being asked / regressions being
reported and they go unanswered - the upper level maintainer can act.
But trust me, it's impossible for someone who is not an upper
maintainer to judge the situation.

