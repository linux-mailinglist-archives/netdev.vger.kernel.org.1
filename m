Return-Path: <netdev+bounces-214095-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A09F9B2841D
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:46:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72D025C09B2
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 16:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 740CF30E827;
	Fri, 15 Aug 2025 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jk8kTtoj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="agMEzjxM"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD24230E0E0
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755276122; cv=none; b=hA/r65P1MFECkULvZYHHWCuvcaD0Y6691gDgL90z0LyLSnFuoFS3MtjXBB/qxl+jCrU4PJ4G7yetINDjVQUMaEVCPmTjYZeSx37VTQWLL4YpaeEE2FoDqdBS/jQ8Nhy5NuPJq+daYCWU2m7JyX/xuzrjB7qfSRrBG8OpCv1bCCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755276122; c=relaxed/simple;
	bh=nv09JT8j/RPlJ2lIWFIf6rNe2bfQWVNSFRmAOOXAF2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qZSMMMp7pMHmt2Dl0TpPb6xMkrN+RhjZZZM0Vl+Xa0YCY3oamm4puVul3Yp7lpjcTe+qj26WUSer2JRBF3DPA8BMEksClqUYTKvcA3EuSkXjcT80JDNk8ZG2/3Pmf+SbWL5FZdi1miECZncKSrYrj9CXJKbOd+shSxpjHztzZ30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jk8kTtoj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=agMEzjxM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Aug 2025 18:41:57 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755276118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SuO9hWRB2tZu87vohsl77fbUrl0oo/RQH6y79VVI59I=;
	b=jk8kTtoj0lR4im/1aitRimBk1HHrBhiokfmlw1OPnl/4eDcnsnBTFRZmlvh4fJwr6IRII7
	KbDzL1xoEaL3GT/qx5AX/4tsR522CyvqoHsoqYEVrdlxLW6f+1EzSlMddA4CEaJFg7/XMU
	HG/UiDx3R5gI9I0O1ZuHhrHLqXI+KBzlJBMB41DtGC6n7yanfbpo55f4CMkh26p+h/Z1in
	O433iMSjtJYlMdvrEXBxiSlYphug8d/yfFbiy/SfRPN6ni+ZU4pTN555RBX/GSntO6DaQw
	oHQOR/brruiWxpaALt9md0yOTCtSq1+7WCHTFJTRZY6WgTfp2QYrrEalvhZlhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755276118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=SuO9hWRB2tZu87vohsl77fbUrl0oo/RQH6y79VVI59I=;
	b=agMEzjxMF9CFD7nDwflH12aIGhmn+a7w+1cz2P9BbvK8f5GiYKADO4oVIfCABvQc4aVw1r
	pfsv5CRPSY/tYpAQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Paul Menzel <pmenzel@molgen.mpg.de>
Cc: Kurt Kanzenbach <kurt@linutronix.de>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: Retrieve Tx timestamp
 directly from interrupt
Message-ID: <20250815164157.jIKm3gdS@linutronix.de>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <a1e9e37e-63da-4f1c-8ac3-36e1fde2ec0a@molgen.mpg.de>
 <87y0rlm22a.fsf@jax.kurt.home>
 <ad66d19c-be7b-4df3-8e4c-d57a08782df4@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ad66d19c-be7b-4df3-8e4c-d57a08782df4@molgen.mpg.de>

On 2025-08-15 14:54:16 [+0200], Paul Menzel wrote:
> > > Do you have a reproducer for the issue, so others can test.
> > 
> > Yeah, I do have a reproducer:
> > 
> >   - Run ptp4l with 40ms tx timeout (--tx_timestamp_timeout)
> >   - Run periodic RT tasks (e.g. with SCHED_FIFO 1) with run time of
> >     50-100ms per CPU core
> > 
> > This leads to sporadic error messages from ptp4l such as "increasing
> > tx_timestamp_timeout or increasing kworker priority may correct this
> > issue, but a driver bug likely causes it"
> > 
> > However, increasing the kworker priority is not an option, simply
> > because this kworker is doing non-related PTP work items as well.
> > 
> > As the time sync interrupt already signals that the Tx timestamp is
> > available, there's no need to schedule a work item in this case. I might
> > have missed something though. But my testing looked good. The warn_on
> > never triggered.
> 
> Great. Maybe add that too, as, at least for me, realtime stuff is something
> I do not do, so pointers would help me.

If you ask for an explicit reproducer that you would have to have task
that does
	struct sched_param param = { .sched_priority = 1 };
	sched_setscheduler(0, SCHED_FIFO, &param);

and let it run for to exceed the ptp4l timeout. But in general it does
not require a real time task to trigger the problem. A busy CPU with a
lot of pending worker will do the trick, too. You just need "enough" CPU
work so the scheduler puts other tasks on the CPU before the kworker,
which retrieves the timestamp, is scheduled.

> Paul

Sebastian

