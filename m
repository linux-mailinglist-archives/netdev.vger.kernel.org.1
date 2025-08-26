Return-Path: <netdev+bounces-216921-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3390EB360AB
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 15:03:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5721B1BA60F0
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 12:59:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 556071FBCB1;
	Tue, 26 Aug 2025 12:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M9vhwE/+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1tuaFlXA"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C8D17A2EA
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213159; cv=none; b=ayi6uNmqa4zfS6zU7KZTr60lB7Rne+GA1xgJrZ90tTECv0f+ggRYDfTvEf7AjjSk5FT+u8zO6jfqK4z9i9sXRZlFoVzPJ94qzgXupXlTp/S9GRvmUFIm6C+Wdty0PAT3qQ99/+rSIl1ypUNam8CP0fWDxxMtgHdj8FnUsanb7KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213159; c=relaxed/simple;
	bh=3BwyOtPSvJCm0E/N8haTtUX23b6Pk2juPRC99MeVgAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8UdMCubBUaeLdkkTFNKlWB0e/XiN6orP1m2G8NJMnN27UTLdpupsUgC+9BkOCMvtWkzx8bX/79ZDscCr8sOhcqQ9/qI9Qs+dARYGdDSmFs/0rqmFzlN8kYzlpn2dJUF5OG+HRuJRGvEERWQMjHXOY6rRPfqCbTMfjjOcUzn0F8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M9vhwE/+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1tuaFlXA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 26 Aug 2025 14:59:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756213155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MPc1xQ3MG9F8V4FvVInAEdZJbomL1gv6VNdFmefEsRA=;
	b=M9vhwE/+EXdNr5po3h6bwj/jPS5CcELKATe9TkamzTdl8MoUWC+UX0eqKmHdU6LKb54utp
	cm1+d9wiQjIuHXbZSZhzL4P13j1M4be2Q+tVw5RPzsmkzgwAJKMcqVp1cFOsMq53HE4Ve6
	b6STfFBnGXSXJv6IQf+jbWYL1EfRfRth+sngAc2DvOVzm9hmKlLyldkmE4TG2eemCSOT6I
	9ZXxc3N7bqHgrmJxbTyg1ihGIu+O33ZBV4vkrGYRZHL4DSd4YaHq50mzMiXpffk7yY+Gz1
	IWFZuhXvdlsM5eXazJlZRYjAOqYTzZABspEbQcop4Jw9FKTQ+Qaf1AsUPHzvSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756213155;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MPc1xQ3MG9F8V4FvVInAEdZJbomL1gv6VNdFmefEsRA=;
	b=1tuaFlXAmr7mfqnmj3swHVz+vSwSFM6qmSV+2tcjOkPGrxmZWGlh68qlM+DK+5DqB1rL0r
	mmw2pL7TCzlmScCw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
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
	Miroslav Lichvar <mlichvar@redhat.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [PATCH iwl-next v2] igb: Convert Tx timestamping to PTP aux
 worker
Message-ID: <20250826125912.q0OhVCZJ@linutronix.de>
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <20250822075200.L8_GUnk_@linutronix.de>
 <87ldna7axr.fsf@jax.kurt.home>
 <02d40de4-5447-45bf-b839-f22a8f062388@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <02d40de4-5447-45bf-b839-f22a8f062388@intel.com>

On 2025-08-25 16:28:38 [-0700], Jacob Keller wrote:
> Ya, I don't think we fully understand either. Miroslav said he tested on
> I350 which is a different MAC from the I210, so it could be something
> there. Theoretically we could handle just I210 directly in the interrupt
> and leave the other variants to the kworker.. but I don't know how much
> benefit we get from that. The data sheet for the I350 appears to have
> more or less the same logic for Tx timestamps. It is significantly
> different for Rx timestamps though.

From logical point of view it makes sense to retrieve the HW timestamp
immediately when it becomes available and feed it to the stack. I can't
imagine how delaying it to yet another thread improves the situation.
The benchmark is about > 1k packets/ second while in reality you have
less than 20 packets a second. With multiple applications you usually
need a "second timestamp register" or you may lose packets.

Delaying it to the AUX worker makes sense for hardware which can't fire
an interrupt and polling is the only option left. This is sane in this
case but I don't like this solution as some kind compromise for
everyone. Simply because it adds overhead and requires additional
configuration.

> > Also I couldn't really see a performance degradation with ntpperf. In my
> > tests the IRQ variant reached an equal or higher rate. But sometimes I
> > get 'Could not send requests at rate X'. No idea what that means.
> > 
> > Anyway, this patch is basically a compromise. It works for Miroslav and
> > my use case.
> > 
> >> This is also what the igc does and the performance improved
> >> 	afa141583d827 ("igc: Retrieve TX timestamp during interrupt handling")
> >>
> 
> igc supports several hardware variations which are all a lot similar to
> i210 than i350 is to i210 in igb. I could see this working fine for i210
> if it works fine in igb.. I honestly am at a loss currently why i350 is
> much worse.
>
> >> and here it causes the opposite?
> > 
> > As said above, I'm out of ideas here.
> > 
> 
> Same. It may be one of those things where the effort to dig up precisely
> what has gone wrong is so large that it becomes not feasible relative to
> the gain :(

Could we please use the direct retrieval/ submission for HW which
supports it and fallback to the AUX worker (instead of the kworker) for
HW which does not have an interrupt for it?

> > Thanks,
> > Kurt

Sebastian

