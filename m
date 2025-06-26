Return-Path: <netdev+bounces-201701-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DC071AEAAC4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 01:41:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EEEFD3A5ED5
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 23:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC8E225785;
	Thu, 26 Jun 2025 23:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WJ/QpE2B"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E11C84A5;
	Thu, 26 Jun 2025 23:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750981281; cv=none; b=VxveBqEVGur+RYQPUWig1JwEnIWgVYSMMhg2k6EGwaKGMcT87u9o0PX0mI+DwFNGOdNT5j5DANZLGZAF6HRfiS2IHfkQVSznVzjDbDmQMrq63FEi++saWLWIK+ZHEx062MPISKSK+2zHAdqZyFNGxl34tpESSVe7XM2EWxCViGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750981281; c=relaxed/simple;
	bh=nufpK4Nake12iu3u9jfr0M9zStpbPBpxmbakfnPf704=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBV/LZDonKHjIvSFQqOmW/hXeVDGdrKHxi5YpmAIZNY0OGjoV4aIwrqJMlnyBOWYMmShXStyI/27skTI66CIiDR1dWxeGsE+GHZ2HgWUmzMOpUK878Q7OkzmjyifY85b6al73KFsUM0ayXrV1slsb4UqHDuvbRbccaksZuZsSpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WJ/QpE2B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4146C4CEEB;
	Thu, 26 Jun 2025 23:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750981280;
	bh=nufpK4Nake12iu3u9jfr0M9zStpbPBpxmbakfnPf704=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WJ/QpE2B/GzkordjchYV5m/4fLjACW4smPYxkk8ImwOTXwMWGGPxz6uEiv3PwbUZH
	 V6GWQdR82jvw+2fXaBrODv6QK/cP/lMIAlUy9JXcZjzyhPGnmTMX7JBirCVLcKUflN
	 eAy65iQfvYpkokLNo60qeAO3rBrRyvIwTgytXObbPOdp4xpPKNxFEYIMSo7TwxurzX
	 BmRRkjlFrEJP52q/9YP+wqHGvDPwVXkrPuXIY1jAg1BYrTHelcaf/EvbgJl3WWzbSH
	 7dCCdwMmerDHMV5pk3XxH6VZcv1URgGmeMOBE5T6hKw2MxUHTBuUx4rbpJkWqMWPmG
	 V9gfwJKXzXpEA==
Date: Thu, 26 Jun 2025 18:41:19 -0500
From: Rob Herring <robh@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: krzk+dt@kernel.org, conor+dt@kernel.org,
	Matthew Gerlach <matthew.gerlach@altera.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, richardcochran@gmail.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Mun Yew Tham <mun.yew.tham@altera.com>
Subject: Re: [PATCH v6] dt-bindings: net: Convert socfpga-dwmac bindings to
 yaml
Message-ID: <20250626234119.GA1398428-robh@kernel.org>
References: <20250613225844.43148-1-matthew.gerlach@altera.com>
 <20250623111913.1b387b90@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250623111913.1b387b90@kernel.org>

On Mon, Jun 23, 2025 at 11:19:13AM -0700, Jakub Kicinski wrote:
> On Fri, 13 Jun 2025 15:58:44 -0700 Matthew Gerlach wrote:
> > Convert the bindings for socfpga-dwmac to yaml. Since the original
> > text contained descriptions for two separate nodes, two separate
> > yaml files were created.
> 
> Hi DT Maintainers! Thanks for reviewing the IPQ5018 bindings!
> In case my pings are helpful, this is the next oldest patch in netdev
> queue. The v4 seem to have gotten some feedback:
> https://lore.kernel.org/all/20250609163725.6075-1-matthew.gerlach@altera.com/

No need to ping us. Like netdev, you can check the PW queue:

https://patchwork.ozlabs.org/project/devicetree-bindings/list/

In any case, we're a bit behind ATM.


It looks like we have 2 competing conversions of this binding. This one 
and this one which I reviewed:

https://lore.kernel.org/all/20250624191549.474686-1-dinguyen@kernel.org/

Looks like there are some differences which need resolving, so I revoke 
my review. Will follow-up separately on both.

Rob

