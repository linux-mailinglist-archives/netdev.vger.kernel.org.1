Return-Path: <netdev+bounces-157886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55AFA0C25F
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 21:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82A303A4E7E
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 20:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60DBB1C8FD7;
	Mon, 13 Jan 2025 20:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PF2u6aAz"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02FB1C1753
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 20:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736798798; cv=none; b=Ow5f4vEge1DrTs68oeq6BQgyw4ARM/TeUEs++ch2naaR2okkJdSh1l+bzNBilB96Y5bdGLk3evKVEtDjkqYvkf2Qf4i3LfxiocDSDafwU2BK9vuuw2SP2vDkJaNUPB1vRXq6opi+qKm8SaxnIdqNRzMQLvF+QW1IFEJA/D8sHpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736798798; c=relaxed/simple;
	bh=rBbK/vc8kj569FnWErFb1h0lt4wL8D343+/Rk+vw8TE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mPMvtcQc2ao16wC7ZSD8D6hcsgof2UAg4IZL667+k2z5UGgCswUHxKBjbXMs8ZWN5kndtN+s/REwOgD+6k38nvjlchhaGDTTth5VUuTBr4ClH01hhOuOFZxfY9joCHE+XmTGQl2KQhwBWAxYJBWQr6v0aE77oSPSblv0edcRc4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PF2u6aAz; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=8PJq72lib6ovyT7RUHKcd3RXJNI+GpK8fB9GCRYcFyg=; b=PF2u6aAz5BHw8Gr1ka9vXZvNLp
	slMshnk/3R5t++x22LD0Vl358YthSJsjxKHpRorJn0Fs/sFE5ENcTrGF3f8UWGrVZFYe53a47M/nM
	W9Id2wMNoqGDwO95+dUVR8dHgsKyo/uBVICvql5gV915/NWZrpYs0bPolWoOruukxBic=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tXQhj-004ClA-Qx; Mon, 13 Jan 2025 21:06:31 +0100
Date: Mon, 13 Jan 2025 21:06:31 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org
Subject: Re: [PATCH net-next v5 00/12] Begin upstreaming Homa transport
 protocol
Message-ID: <24e75641-ad78-4ceb-a42a-c61c1ea5b367@lunn.ch>
References: <20250106181219.1075-1-ouster@cs.stanford.edu>
 <CAGXJAmxyNRfJp9UemEdVpxegf1bnK5eBMYe5etmUoS-kZd98vg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXJAmxyNRfJp9UemEdVpxegf1bnK5eBMYe5etmUoS-kZd98vg@mail.gmail.com>

On Mon, Jan 13, 2025 at 09:27:34AM -0800, John Ousterhout wrote:
> The Patchwork Web page for this patch set
> (https://patchwork.kernel.org/project/netdevbpf/list/?series=922654&state=*)
> is showing errors for the "netdev/contest" context for each of the
> patches in the series. The errors are the same for each patch, and
> they seem to be coming from places other than Homa.

Hi John

The tests take too long to run for each patchset, so i _think_ all
patches in a 3 hour window are tested in a batch. So it could well be
some other patchset in the batch broke something.

You should be able to run the test yourself, on your own build.
https://netdev-3.bots.linux.dev/vmksft-net-dbg/results/937341/60-bpf-offload-py/stdout
shows you the command line. However, the test environment, what tools
you need installed etc, is less clear.

To me, it does seem unlikely that HOMA would cause:

cat: /sys/kernel/debug/netdevsim/netdevsim20347//ports/0//queue_reset:
Invalid argument

So i would not worry about it too much. However, if the next
submission has the same issues....

	Andrew

