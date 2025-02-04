Return-Path: <netdev+bounces-162438-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 94308A26E93
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 10:35:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A143166534
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 09:35:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35749207676;
	Tue,  4 Feb 2025 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I2s9RH5y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0566E19C54B;
	Tue,  4 Feb 2025 09:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738661732; cv=none; b=MhjY+ekjqzIoLOyZly9fxuAcqUZ1nhOgfYhkdP62ZBTRPYW99/TFcHy+WqN+AavOOEUxwui4Syvzd/p2S2R+JAQ84yDyooTuwcj8rspPdCQrOXe9EkJ+D006e9MYUg0OGZXQC/xmb0LLgh7lNA9g5RUsAvX7uy8uOsqMBOfmhsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738661732; c=relaxed/simple;
	bh=XsdL0HyKzrkFPB8QhC4PtBlbmqD9wYUifbbufUXba/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=joSV/tiiWIxPdST+hb7AS2uWIrAf89wBHLVMqypKj87gxW4XalYaBjUA5M+uq4csAtzU7Cv0shG+PDn5mF7B3ToQghdzuHA7bF7aNodQZIuNdc9IX2gMH2oshTlnuoiZFGmSAbIOp8WunwtDBStPvPgvIYujfxurbEx2FK3lDUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I2s9RH5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05744C4CEDF;
	Tue,  4 Feb 2025 09:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738661731;
	bh=XsdL0HyKzrkFPB8QhC4PtBlbmqD9wYUifbbufUXba/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I2s9RH5yZFpv1QBN20aPw2+outg8LNoMSK7WLSyvS99Tf+wZvHpW1D79nuqzCnR4x
	 v8aBVzyK97Z0T5TD8rQCAtyWDrpyiaV9TXaCImvytpqvyMtxt9/WEzRYTfJdKQrfzu
	 am96RSoYSZqVP8bjndCnoY5F67szg+8AYhaE59iWo/1MZ/w+ktbGgLbKaCAfAN3usD
	 KpftbGirkiv4ESOQECdFdH/x2+ofBFR3ipHo4+0hG30ZhxBMnsQwgLSXQNdvIjoKfa
	 ffwC3cg6OrEYbZOs2Z+NbTjPCmjaNhhNjWtBB/EjF0w5TOp5ffpYRP5fkClmvVv74n
	 Ln/+1w9FG7piQ==
Date: Tue, 4 Feb 2025 09:35:26 +0000
From: Simon Horman <horms@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Alexandre Ferrieux <alexandre.ferrieux@gmail.com>,
	netdev@vger.kernel.org, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH net] docs: netdev: Document guidance on inline functions
Message-ID: <20250204093526.GK234677@kernel.org>
References: <20250203-inline-funk-v1-1-2f48418e5874@kernel.org>
 <a2ae1cda-8210-4e6c-86ea-0ee864e13b23@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a2ae1cda-8210-4e6c-86ea-0ee864e13b23@lunn.ch>

On Mon, Feb 03, 2025 at 04:10:24PM +0100, Andrew Lunn wrote:
> >  Conversely, spelling and grammar fixes are not discouraged.
> >  
> > +Inline functions
> > +----------------
> > +
> > +The use of static inline functions in .c file is strongly discouraged
> 
> I don't think 'static' is relevant here. They probably are static, if
> they are inline, and to avoid warnings about missing declarations. But
> we just prefer not to have any sort of inline functions without good
> justifications within a .c file.
> 
> A nit pick, so:
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Thanks Andrew,

I agree that static is not helpful here, I'll drop that in a v2.

