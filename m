Return-Path: <netdev+bounces-208532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA0EFB0C073
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 11:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBC5C3BF716
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 09:38:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B271128C2B8;
	Mon, 21 Jul 2025 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eLPT8l9i"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E8F228C854
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 09:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753090755; cv=none; b=rQzblBhM4EiHBFCW91d9r5UCku+JDYnzx+Ru4hXI52xY9IFZB0Cn7o3thQHZlIAFkM94CgKi/cmCOhWTA7r5VG1YoWiCT/aOXqpTI1De6sHc3KxRN+T625ezRMxWiOdwm9K9st92w/505EpckxQH/+9e1ZujdAJONILEVGip/1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753090755; c=relaxed/simple;
	bh=OlZl/zO2qagDh7aujMFDDE1DMBrJKAlMlxurAt+3uyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N1UF4FOIm9OdWWiuo3/74T9cHWIxg6AaA+HH+T3o+KX3lWNwfPve5jiNNSLNgmGKiL27thYFSrwgLpPtXEhbmhijalzDwrNv7br5ECv15d77KhAU+okerDWHP5pjrGQMlnQieFGbmKvhIBvgqmi1WNDv8a7GPEYWqv+vHxN7wDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eLPT8l9i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8632C4CEF4;
	Mon, 21 Jul 2025 09:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753090755;
	bh=OlZl/zO2qagDh7aujMFDDE1DMBrJKAlMlxurAt+3uyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eLPT8l9iHpBlXjE5b1eK9IUl2BHCElOKY7xbp96QoMErk4ATcjeH1EHFqyg+iiriX
	 +LBs1LkV0LDcwcTVL//8q7qEvMb5LVSJpKT+mDeT+1KJzVmlggHKMFV+xSnfXu8xy2
	 /fKg3aMpf5NZtU1HxC0oPDJSEhYmR+T7qjV59KcflCtFUMz9kul3y9UHVnMfvOaDU4
	 o5B5TKz4IP5oENAGRRDbuIkAlD2FkcW8LJuXHPVriFqrhAi0c7xBaMqAB1rAc7K9mi
	 qfqFBSMyTXvlob90cciYluaSl/N8UdA23YQUO+50UVA0YvsQML6ddhbqhlAnOwK51p
	 8d4AA7C5zUAoQ==
Date: Mon, 21 Jul 2025 10:39:11 +0100
From: Simon Horman <horms@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: Kconfig: add endif/endmenu comments
Message-ID: <20250721093911.GA2459@horms.kernel.org>
References: <20250721020420.3555128-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250721020420.3555128-1-rdunlap@infradead.org>

On Sun, Jul 20, 2025 at 07:04:20PM -0700, Randy Dunlap wrote:
> Add comments on endif & endmenu blocks. This can save time
> when searching & trying to understand kconfig menu dependencies.
> 
> The other endif & endmenu statements are already commented like this.
> 
> This makes it similar to drivers/net/Kconfig, which is already
> commented like this.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>


