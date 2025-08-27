Return-Path: <netdev+bounces-217332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A95B3B3857A
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 21E937B5913
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 14:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27902219A7E;
	Wed, 27 Aug 2025 14:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="saZsgGmD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="miQ70fyc"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B51C8472
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 14:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756306360; cv=none; b=VVanvwDKWh0PVHO8+cCKlNHEOADBMsa+JYlFdoh7K06KlFBVMp0kokwah1NrqD654ES4pwnPAGol6oWQBkpkeeXW32faMHeqXgZfxxG90BlNa9XeCsG6FlCvl949cRBOdIuPf7gsZ3DJF22mUxOoLzYy6GUTxHmS2mZ7tIrBgXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756306360; c=relaxed/simple;
	bh=MxRCCkSRqJcngS/slXYCxgTJdRxKJD1cF5L2xZWjfZ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C+B586oaxUU+IQbmv6kEu/0TvYD/gFd6dm/7fWqzYTOWIFx9UJ3gv4iwlr2xISWu1J1lfo6Xfd4v97Et1rbdwBewNR/C7tXeYJS+wX/AGlQD920242Ut/+opQRcO0/cEeQMoXfkDEsi5HuAvKmOInkIjNa8P2GtcbxOeq+M5iI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=saZsgGmD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=miQ70fyc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 27 Aug 2025 16:52:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756306356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MxRCCkSRqJcngS/slXYCxgTJdRxKJD1cF5L2xZWjfZ4=;
	b=saZsgGmD9mDwgub5tAXABac82czs1gY48hcYT0+m0FTGgLmwtj/T6dQ2XwT7sLXJDTS0U8
	ZgYMWlHCoTHOmMqGcwlLgTirYou++kyohmhXCaEqZj/cIm+5mDCUZwL2guoU8zoqfVcFs5
	2CvEf4IG5zJXhYtr1MpAqza06jjc9370YuXWLvensjcXMhGpTLA9FXKHHtqVnSbu/gttpx
	072VzDY3YS+V8gV1iV+ulzDLrdRH+8JDYWHuW7Hnoi/QyzPugrE3kDn5naOp+U2M0NesNe
	ZEkw1m6DIqRwX125f53h2qbtEtWoAn4lIar3zXfQ2eedqX26hOETIp6ah7xIdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756306356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MxRCCkSRqJcngS/slXYCxgTJdRxKJD1cF5L2xZWjfZ4=;
	b=miQ70fycbgi+MmREHUINC3TBuRSbJ/r5WImarMVu/vuQaowb0u3ACOKJwZUiujxCC3vvo2
	SCgF/xDg7zPoWKDQ==
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
Message-ID: <20250827145235.6ph_Wzn8@linutronix.de>
References: <20250822-igb_irq_ts-v2-1-1ac37078a7a4@linutronix.de>
 <20250822075200.L8_GUnk_@linutronix.de>
 <87ldna7axr.fsf@jax.kurt.home>
 <02d40de4-5447-45bf-b839-f22a8f062388@intel.com>
 <20250826125912.q0OhVCZJ@linutronix.de>
 <aK8OrXDsZclpSQzF@localhost>
 <20250827141047.H_n5FMzY@linutronix.de>
 <aK8ZBWokfWSNBW70@localhost>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aK8ZBWokfWSNBW70@localhost>

On 2025-08-27 16:41:09 [+0200], Miroslav Lichvar wrote:
> From the results I posted before, the machine (CPU Intel E3-1220) with
> the I350 NIC can provide about 59k HW TX timestamps per second without
> any of the patches, about 41k with the original patch, and about 52k
> with this patch and pinned aux worker.

I might have similar hardware with a i350 to give it a try.
The old worker approach and the pinned AUX worker are identical from
software design (or: I am not aware of any significant differences worth
to mention here). Therefore I don't understand why the one had 59k and
the other 52k.

Sebastian

