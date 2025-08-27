Return-Path: <netdev+bounces-217306-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 230F3B3847D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:10:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C63F5681F2D
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F0435A286;
	Wed, 27 Aug 2025 14:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jv2w2fcL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bPgclxat"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558462FDC56
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 14:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756303853; cv=none; b=ZgFGS9EkmKilCabrCXRndmKJ3It+D39ul833l50hKXwZ99ZYOrd49L3nPFNiJmEbxxu1eCkBXEub7wp/hcI8JbsZ2HI8e6HlXeZsf6xK9hf0guBUJ3yGbcHz0Zvt2c3bj73wi2QYx8unxctL8I7KSYRvNcQUbgIpHhAu4M3VrPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756303853; c=relaxed/simple;
	bh=LB1IyQx+3mPB03OfGtCk52cNsIBa7id6Q2h8soWz5LY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mss9wFTa3nx/BjQPEA+SKv1viPPS1cZsRJMsG3fQ7EdSM11uwaxsL1HRtwVRzO12fV2UriPxKWsPb/l/7DAOaEE0pf/Xaspc+lml+zANM5j309qmeuX0IbBlfWZmr1WqczZw0yyCCzN46LhZeHwlsgDSNOOJX6VvRnr17IJfjbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jv2w2fcL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bPgclxat; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 16:10:47 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756303849;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1/rB36gFRz4cGhzwVkpuf1gnit+WsPGgV7ZUSfXYlQ=;
	b=jv2w2fcLRUeeqildzoVNn9P1lzXx9cze3i9Y45mv8LPoir3FsafXsViwFO6kGZQbGXPy2w
	ekYv7VCmE3yX4LyUCAPWyJ0hyH0kRKcN0JaeicnUeyFJvWyXrqvIB7aAr+/QpQgErc6sKD
	GpfbmOrQiQakQPq+YhZyBoMdEUathcp2q6614ASavFhygC9kbHJWwehE17dC/gCSqcANhH
	1BsqsCmcP47dyT1rcbfCr4DzbTk2NSTQuN1M2wspiQ4llSJqOJDKTYkxgYIqQaZ41zLUTz
	1Fr4KqFYL2KNIdjPkViaQvBOkShCXsVhEMu2umM67u/RNDQRvnWSR3WsrWX8yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756303850;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1/rB36gFRz4cGhzwVkpuf1gnit+WsPGgV7ZUSfXYlQ=;
	b=bPgclxatJ1QrCdAS+TVvNgo5bkUBCdpCjmgm/i8Ly/gBLuBHL5UupaQ3egaj+aqK6k9DYo
	24OXid91KGppigBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux
 worker
Message-ID: <20250827141047.H_n5FMzY@linutronix.de>
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <20250822075200.L8_GUnk_@linutronix.de>
 <87ldna7axr.fsf@jax.kurt.home>
 <02d40de4-5447-45bf-b839-f22a8f062388@intel.com>
 <20250826125912.q0OhVCZJ@linutronix.de>
 <aK8OrXDsZclpSQzF@localhost>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aK8OrXDsZclpSQzF@localhost>

On 2025-08-27 15:57:01 [+0200], Miroslav Lichvar wrote:
> On Tue, Aug 26, 2025 at 02:59:12PM +0200, Sebastian Andrzej Siewior wrote:
> > The benchmark is about > 1k packets/ second while in reality you have
> > less than 20 packets a second.
> 
> I don't want to argue about which use case is more important, but it's
> normal for NTP servers to receive requests at much higher rates than
> that. In some countries, public servers get hundreds of thousands of
> packets per second. A server in a local network may have clients
> polling 128 times per second each.

There might be a misunderstanding here. You can't receive 1k packets a
second and each one with a HW timestamp for PTP. This does not work.
SW timestamps more likely.

> Anyway, if anyone is still interested in finding out the cause of
> the regression, there is a thing I forgot to mention for the
> reproducer using ntpperf. chronyd needs to be configured with a larger
> clientloglimit (e.g. clientloglimit 100000000), otherwise it won't be
> able to respond to the large number of clients in interleaved mode
> with a HW TX timestamp. The chronyc serverstats report would show
> that. It should look like the outputs I posted here before.

How does this work with HW timestamps vs SW? I can't believe that 1k
packets are sent and all of them receive a HW timestamp.

Sebastian

