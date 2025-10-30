Return-Path: <netdev+bounces-234460-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEB4EC20DCB
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 16:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2472D3A4699
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 15:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34DF35BDD0;
	Thu, 30 Oct 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lb8ML0A0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2AD12475CF;
	Thu, 30 Oct 2025 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761837402; cv=none; b=dX6zHkw+8YAveNPbO5xMyITf3Guc+IyNGadpCX5QevdhWwwNv5QnbMAYTadiGsTfWoHhAlmF1UOSF2IEE+1CcJU9R9GMqtEunaz3s9nTgcMsOsSUaqiNKRBMXWo+CuDXnTcFUGk4Q8RQ1FoASP6y38yVtzk4lv+sAFBD9+yCk90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761837402; c=relaxed/simple;
	bh=4+yxJdVWRUpvLUb8dzyxv1tQWFiB2p7Ngn9oUHSppMQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ya3RZvPtoy5sn65lDBMkAmAHQjvMR3omMymTS30I3/mkM3MMe0cB8uKx6qp/C4Kw4X0GKunfO2IpN1wZ+zTR9q2XaiFRuzK3a667YkgFh1WP142bMAfoMnEZAgV9GRNLi2eYXjB0iUjcaehA2p5HSUPaiamhFKd36HIT6EE1YAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lb8ML0A0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E04C4CEFF;
	Thu, 30 Oct 2025 15:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761837402;
	bh=4+yxJdVWRUpvLUb8dzyxv1tQWFiB2p7Ngn9oUHSppMQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lb8ML0A0VPc6tdgaSOSAfHmeIMSbxoDBxBwe5SoA4e/L4MmxWSoepXJizQT+H10gA
	 n5YJZfoyt8mklixtKo19fFt3x3/b0exacYD0A74wlVanDSu3i79dzz5fcl06iqNSLB
	 ehir8yadLlhCFgw9+R9r+g/AsDF2gu0eq7fjNAgw3v8Kx8fG1dVQZF+5Iw3u0p6Z7G
	 FGbxLf9pRpKEIO7ajJ4Fa2/7thXte654YlTZ20gCP47MC0iMLTkgBAo5hqQ6i/cFLM
	 Wlz/NbmidGJ67zAqJSb9l1ZftHCjfe4yHXcikALDqRBN6MkSpSnCRmMg8lW0iD0SZ+
	 SToer1BlmeBeA==
Date: Thu, 30 Oct 2025 08:16:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yibo Dong <dong100@mucse.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, andrew+netdev@lunn.ch,
 danishanwar@ti.com, vadim.fedorenko@linux.dev, geert+renesas@glider.be,
 mpe@ellerman.id.au, lorenzo@kernel.org, lukas.bulwahn@redhat.com,
 netdev@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v16 5/5] net: rnpgbe: Add register_netdev
Message-ID: <20251030081640.694aff44@kernel.org>
In-Reply-To: <24FCCB72DBB477C9+20251030023838.GA2730@nic-Precision-5820-Tower>
References: <20251027032905.94147-1-dong100@mucse.com>
	<20251027032905.94147-6-dong100@mucse.com>
	<20251029192135.0bada779@kernel.org>
	<24FCCB72DBB477C9+20251030023838.GA2730@nic-Precision-5820-Tower>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Oct 2025 10:38:38 +0800 Yibo Dong wrote:
> > >  #include <linux/types.h>
> > >  #include <linux/mutex.h>
> > > +#include <linux/netdevice.h>  
> > 
> > Why do you need to include netdevice.h here now?
> > This patch doesn't add anything that'd need it to the header.
> >   
> 
> It is for 'u8 perm_addr[ETH_ALEN];'
> Maybe I should just "#include <linux/if_ether.h>" for this patch. 

I see, that's fine. Then again, I'm not sure why you store the perm
addr in the struct in the first place. It's already stored in netdevice.

