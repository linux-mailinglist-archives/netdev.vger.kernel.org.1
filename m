Return-Path: <netdev+bounces-227861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89127BB8F96
	for <lists+netdev@lfdr.de>; Sat, 04 Oct 2025 18:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DDCD189EBEE
	for <lists+netdev@lfdr.de>; Sat,  4 Oct 2025 16:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9356246BD7;
	Sat,  4 Oct 2025 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esHF4gR4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD41CA5E;
	Sat,  4 Oct 2025 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759594143; cv=none; b=dODjAeKBRiIxvvDsI7L8jT6TFFcwhP0QWg/dMoqClgWt992KrZdWzDpunARWCx1YbDyWxNGzQjX7ePLSKPvRjmlSf6MZ2NXMlvZuEMk6I6UNmU5r+NzHAtBE2QAtNF0y0LGwJuqkofZRzgITcGwV7qN25dLAjTL+BqWxtwgy5Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759594143; c=relaxed/simple;
	bh=DA/ogNVt++/9Cpu/0AEEut4iEJojZJ9kHBttFA9WmSA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWVboQI/HTD7OFhtdq79d0lsyaihIG1pV1P5ttmlmfxpDhxcRmCI1zyI5qq9HiRzhBZb8rLP6E0ODqNOydBc4nk33clgD4v8wyfSPF9dz8ryYqrP6fz7E7finbUqhpVWgo0gG1misjaqFkYcZNs8ZPKV7Bcg8+h31MUq8zJnlGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esHF4gR4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8FEC4CEF1;
	Sat,  4 Oct 2025 16:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759594143;
	bh=DA/ogNVt++/9Cpu/0AEEut4iEJojZJ9kHBttFA9WmSA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=esHF4gR4wccm0VYwCROaFUWYvRXWPRYs64Hdgyrb+dCvjZPj01yP886U4WGm0SmT/
	 LFYn7PjD8Rom0v0ZoaKQovc6qtQLtonIbCLkqEP+QUXH99I27rQp0VZVKhRRKxgOYF
	 T6xTAZQ6+fYw8i0IQCG13Hx6Mcl5Xgu+wcXkZJ2Q2Wrae9957U15gALHHhKaK3PAFF
	 OLTjYqIetUsj1417W+siogAWBXIj5ZryC2AofcHgPSbIj3+HWs0HUHTxn3E0DFvV7o
	 ei8Ezr0P6ZAA6zFS7ZApurJHdIjvelzfHeIt6P1J/sdn60pMvJQtaSYR0Pk9QhcanY
	 BPAwRgPaNyqOQ==
Date: Sat, 4 Oct 2025 17:08:58 +0100
From: Simon Horman <horms@kernel.org>
To: Denis Benato <benato.denis96@gmail.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH] eth: fealnx: fix typo in comment
Message-ID: <20251004160858.GD3060232@horms.kernel.org>
References: <20251004125942.27095-1-benato.denis96@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251004125942.27095-1-benato.denis96@gmail.com>

On Sat, Oct 04, 2025 at 02:59:42PM +0200, Denis Benato wrote:
> There is a typo in a comment containing "avilable":
> replace it with "available".
> 
> Signed-off-by: Denis Benato <benato.denis96@gmail.com>

Thanks Denis,

I agree this is a good change, but could you also
fix the spelling of mutlicast in this file?

Please do consider tagging patches for Networking for their target tree.
In this case I assume net-next, as this doesn't seem to be a bugfix for net.

Also, net-next is currently closed for hte merge window.
And will reopen once v6.18-rc1 has been released, I expect on or after
the 13th October. So please post any patches for net-next after then.

See: https://docs.kernel.org/process/maintainer-netdev.html

-- 
pw-bot: changes-requested

