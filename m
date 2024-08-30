Return-Path: <netdev+bounces-123845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18815966A8B
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 22:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B6E4C1F23470
	for <lists+netdev@lfdr.de>; Fri, 30 Aug 2024 20:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6EB166F0D;
	Fri, 30 Aug 2024 20:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKPNrnSC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796315B117;
	Fri, 30 Aug 2024 20:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725049874; cv=none; b=tBPhFAv/mOg+gr244Mu+CHv5Htm4rrrkKUcrrLrI4Ewzdt8o8LuN2gT7dvd3v+B71dU7RUnNLMdodEv7FEJ3Pf6wAOzoxTGsQT3+cgPaGWpVfc26aSs/jyYDL/YwLsGNJCTYJjt7zOSdYetdEIhuaLpKmcAJQwtuyT5X1To65WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725049874; c=relaxed/simple;
	bh=6/QJQq/wo6bKhi/v2PTeaA2XWegYPFmMNRq6DCv/16g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JIjkB5tQurGeeH9cTquD3OyzpSCQxFe+GH8PA+HPmIN9+Fja1k6sUGJYTYsdymcSCBkRIZu6X6flUPIqXPnrvutvAf7ff/vtoQbNK3B53mKlPLmE0oaQIAcuxlSrSYUhDDPjWa0ISqSObAk1EgjBT6teiGD3AtNoSCn3FWsiqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKPNrnSC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2509C4CEC2;
	Fri, 30 Aug 2024 20:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725049873;
	bh=6/QJQq/wo6bKhi/v2PTeaA2XWegYPFmMNRq6DCv/16g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BKPNrnSConZF4hl7mGPyWW/scsyTFwGJ8j4JAUsh+x0WBaoz/uI1YUlB/sZoRpzQo
	 EsnKdLT4ESzMll1wNhLkg4Faa+gB/259IYKRSQOiT26kZd/2oVhgikboCkf4cRI89H
	 7IjBma9t+QPjtsUvN4V9cAEu/0OoKU/icGkgg6nA0jRGYCA/DHrdo0JUJCC6l6g3rW
	 ZlghD8Qxjvyzzf9m2A3wrUCVYc+sKnpT6da4UhFP7KJdkPl9227zJnboakxVbF7ZGG
	 AZ6QdtOwOfySpH2UwgkkkFahM896c93xrJ+KNs6JoaM873tED6Q1LzZm5wX+mI17Nk
	 phN6MVicmbcoQ==
Date: Fri, 30 Aug 2024 21:31:09 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, Nikolay Aleksandrov <razor@blackwall.org>,
	Andrew Lunn <andrew@lunn.ch>, corbet@lwn.net,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2] docs: netdev: document guidance on cleanup.h
Message-ID: <20240830203109.GB4063074@kernel.org>
References: <20240830171443.3532077-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240830171443.3532077-1-kuba@kernel.org>

On Fri, Aug 30, 2024 at 10:14:42AM -0700, Jakub Kicinski wrote:
> Document what was discussed multiple times on list and various
> virtual / in-person conversations. guard() being okay in functions
> <= 20 LoC is a bit of my own invention. If the function is trivial
> it should be fine, but feel free to disagree :)
> 
> We'll obviously revisit this guidance as time passes and we and other
> subsystems get more experience.
> 
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: horms@kernel.org
> CC: corbet@lwn.net
> CC: linux-doc@vger.kernel.org
> 
> v2:
>  - add sentence about revisiting later to commit msg
>  - fix spelling
> v1: https://lore.kernel.org/20240829152025.3203577-1-kuba@kernel.org

Thanks. I think this patch has enough tags, so I won't add another.
But, FTR, this version looks good to me.

...

