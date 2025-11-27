Return-Path: <netdev+bounces-242385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C21FC8FFED
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 20:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3E32D4E0669
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 19:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA9F303C97;
	Thu, 27 Nov 2025 19:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2c+Cy9lj"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71D223EAB6
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 19:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764270979; cv=none; b=mCWUiF9S5AB18mHicJWJxr3qDCVmLTYZ3Jw0LrRnbUYxgffYBd9wITRGmvrMjMk4adBJulqW7JB55TIYJDZvtii2mL9PbDTUM/7Ky1hYucgWS9zETx/JdIkCcxZFry3xKlUH5hfplp0/fuSWswRAjkUy4Q6i8SQvJ/o3iSR0IwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764270979; c=relaxed/simple;
	bh=jYfQPFzH6p9KrvjX5e/03kxE8pxvNa2LR3hFqv22gA4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WgeH+vPyGHeQ5ViSTdmpCdye5KjWwGJ5BsdOU9bgqbi7AFRQlfJvdJiqxhWSTvgfgqNEUzK7uLU+mCRyBSOi9XFTq59/VjgKdGhTnZlPNXhZ/qymF8fo8Ram9VilULawqsBIBI0rdHfPg8XWntfnAUYQLdLeFxgZkE5No88epxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2c+Cy9lj; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=sjaer9btj6sR9ubObLyn7KI3Hi5THUZqw6tidbbYp70=; b=2c+Cy9ljqZcwDdKNdZncjQJfKD
	l4Dz6VszHv6n7bciYX3yWcd/at6GcW2JbIw09suAyEOcprfsEgzTeCZgMUXzuEE4zz0U+a11TgRc7
	YTNNiwneG2gXfbeTM1JyendATfW1i74cYcQxtVd0g+ivv5zO8dx8D3YXuOIcxSAh1bsY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vOhTO-00FI6i-2x; Thu, 27 Nov 2025 20:16:10 +0100
Date: Thu, 27 Nov 2025 20:16:10 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Vitaly Lifshits <vitaly.lifshits@intel.com>
Cc: intel-wired-lan@osuosl.org, netdev@vger.kernel.org,
	andrew+netdev@lunn.ch, horms@kernel.org, kuba@kernel.org,
	edumazet@google.com, davem@davemloft.net, pabeni@redhat.com
Subject: Re: [PATCH iwl-next v1 1/1] e1000e: introduce private flag to
 override XTAL clock frequency
Message-ID: <a60a2c81-658a-4bfc-a0dd-59941676bf00@lunn.ch>
References: <20251127043047.728116-1-vitaly.lifshits@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251127043047.728116-1-vitaly.lifshits@intel.com>

On Thu, Nov 27, 2025 at 06:30:47AM +0200, Vitaly Lifshits wrote:
> On some TGP and ADP systems, the hardware XTAL clock is incorrectly
> set to 24MHz instead of the expected 38.4MHz, causing PTP timer
> inaccuracies. Since affected systems cannot be reliably detected,
> introduce an ethtool private flag that allows user-space to override
> the XTAL clock frequency.

Why cannot it be reliably detected? The timer is running at 62% the
expected speed. Cannot you read it twice with a 1ms sleep in the
middle and see the difference?

>  #define FLAG2_DFLT_CRC_STRIPPING          BIT(12)
>  #define FLAG2_CHECK_RX_HWTSTAMP           BIT(13)
>  #define FLAG2_CHECK_SYSTIM_OVERFLOW       BIT(14)
> -#define FLAG2_ENABLE_S0IX_FLOWS           BIT(15)
> -#define FLAG2_DISABLE_K1		   BIT(16)
> +
> +#define PRIV_FLAG_ENABLE_S0IX_FLOWS	   BIT(0)
> +#define PRIV_FLAG_DISABLE_K1		   BIT(1)
> +#define PRIV_FLAG_38_4MHZ_XTAL_CLK	   BIT(2)

Please split this up. Rename of FLAG2_ENABLE_S0IX_FLOWS and
FLAG2_DISABLE_K1 in one patch, 24MHz in another patch. That will make
review easier.

       Andrew

