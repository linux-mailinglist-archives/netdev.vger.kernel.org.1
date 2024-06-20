Return-Path: <netdev+bounces-105414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2202D911034
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 20:09:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B88951F22526
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 18:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948C71D0F53;
	Thu, 20 Jun 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcR1Gq6L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0F41D0F51;
	Thu, 20 Jun 2024 17:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718906339; cv=none; b=lxpgXtmFxleRrguQyAE+60XhwQSn7/9hagYua/BG2p8ChSDN5t0ebJg6PXxMRm65dFeKe0iBmdthUN6CCfwvLHn3NABES3hUxfQwwKwdzCWzk4D1/b5nCyDDKg/vyweCO+rhlPnbrGPn7UL3bB/ZS71ZWjdbQ+PStdjsGsjfp8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718906339; c=relaxed/simple;
	bh=LZhd2+jaTKE4bQB4FEE8bOAJAef95drMqeg1UrQCcKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m2PNb9EFqyhxSFVC3JHy9ifLp6C9ZfoAAMI8NJqUSX51EHYtkI6PFFIjO3OON2CFfRAyxMx9bW6S7hBGlA3ddb9nijRJmZwskIlhgUMGLxZJPDhZzmwnLnBIITLw8lIMRr/0o1pr+UB/g6oJ9cxzVc0NDXAqCjpmdo9Pa96CAOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcR1Gq6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C57DC4AF0B;
	Thu, 20 Jun 2024 17:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718906339;
	bh=LZhd2+jaTKE4bQB4FEE8bOAJAef95drMqeg1UrQCcKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=IcR1Gq6LzQ1F7d5f3B040sU5P5mOcvOm7FMdX6T5nnwzupJZzdN7It43+mVaQ/INC
	 LnN20Uf2wlPRJCoOIxmJN/ZV2YKVLzwpLGKnZAPZ2qAc9CEcczSQK/ZPderzs9TywO
	 yh0DZ9oPmnXWSavGUkjrdlF8GEF5WrexYVyDN+n6DUG/5l6smHarSdqKohHfxZ27yH
	 MbNhDMCfpOrCnl2CSny7q61E8wp7KmX5PFVjdFZa8EDzu/huOXoIawTKbntCBNgnoA
	 MkXek2MFp+Qr5ZvGQqJpK54DZ38EahaQd/gVl12BBxXky/DtOzsYysqJNkOcsXIRFh
	 OSkaw8563N35A==
Date: Thu, 20 Jun 2024 18:58:55 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, corbet@lwn.net, rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next v2] docs: net: document guidance of implementing
 the SR-IOV NDOs
Message-ID: <20240620175855.GR959333@kernel.org>
References: <20240620002741.1029936-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240620002741.1029936-1-kuba@kernel.org>

On Wed, Jun 19, 2024 at 05:27:41PM -0700, Jakub Kicinski wrote:
> New drivers were prevented from adding ndo_set_vf_* callbacks
> over the last few years. This was expected to result in broader
> switchdev adoption, but seems to have had little effect.
> 
> Based on recent netdev meeting there is broad support for allowing
> adding those ops.
> 
> There is a problem with the current API supporting a limited number
> of VFs (100+, which is less than some modern HW supports).
> We can try to solve it by adding similar functionality on devlink
> ports, but that'd be another API variation to maintain.
> So a netlink attribute reshuffling is a more likely outcome.
> 
> Document the guidance, make it clear that the API is frozen.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Thanks Jakub,

This is as was discussed at the public netdev call the other day [1].
And a change I supported in that meeting.

Reviewed-by: Simon Horman <horms@kernel.org>

[1] https://lore.kernel.org/netdev/20240617083955.1039b2e3@kernel.org/

