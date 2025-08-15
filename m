Return-Path: <netdev+bounces-213998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A9DEB27AAB
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 10:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA541CE8A3E
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 08:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6697D2BDC0F;
	Fri, 15 Aug 2025 08:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="20SJ5Xwd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qwPsL+1p"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB22BEC3F
	for <netdev@vger.kernel.org>; Fri, 15 Aug 2025 08:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755245423; cv=none; b=UCvp9JLk5hh1iWhr/w9GhUntM601Fue1eyr0rEqFdVyF6GrAtma8hKgcK0E+t5u0QwdLXMm1xRBLchDCCtanREtiu2/z2M7Da7EehKWS32fPwhBF0Iz5llQ9+pVnJlcqKvDTuDwUQmHOsffZbUu0N64+Laz97rn8WSxfFovi+WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755245423; c=relaxed/simple;
	bh=jjA4Dwi/dLkSUMwyCcP3XH6H56c2l+ytlOAoK7/vcoo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2JmeddWhjT/bLd+k3Ix6FVfVF9BkhiZwEqx17JrKkZmL2hM4czT8WFa3CJ/bueviIF5rKzJEXi3KO8KR1snto/1bvFmio2XAvIst8HFOOsVpnyO8mvXpbi61ZkNS7aMbprGiRuhaB85H3zkf2aXZO+ORVBAZVnHM557fJj3xkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=20SJ5Xwd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qwPsL+1p; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 15 Aug 2025 10:10:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755245414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J7VKaM9iJKH34FxzXiIc1+Fd96YeVYMts3Y8mchScHA=;
	b=20SJ5Xwdh4qUHhCvZ+SaAOEbWaXwbV385A0CQQ30n0Drk9EFB0h+NjrmnxXYtUeVJBCho0
	VJh0iHScKX9aPI61BwgNItGDXGXVaRVyq0oNXtQXqdTIB/CGVylMBKC98xbzuSjg7nHpE+
	9+hpxTsVcYJ86omUc1WcCSLmzoFE2K9xSE51kFbtpLZHCtpZftJRetKe0UqCkQC6zkFPFK
	q/qNEXcB4gXPBrraPwJP2ztxghp0UACzoTbn4Rk62eJX7zwRMJdsMpKfehgbguFGsJJ7+n
	Z1zT6wX2DJO9DxQ+HDA5jsvaDfpArX5vbmr2j7mq9Z0LzAWAGkBQ4LuOWLfD+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755245414;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=J7VKaM9iJKH34FxzXiIc1+Fd96YeVYMts3Y8mchScHA=;
	b=qwPsL+1pUwSufHmEQ7kN/yo1DLLp9VPztXweW8OCLeablSkiimeUm6yLsPIk+BLLJakb8g
	OZ1MQH83Dif77oCA==
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
Message-ID: <20250815081012.gpD_tW0X@linutronix.de>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <a1e9e37e-63da-4f1c-8ac3-36e1fde2ec0a@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a1e9e37e-63da-4f1c-8ac3-36e1fde2ec0a@molgen.mpg.de>

On 2025-08-15 09:55:00 [+0200], Paul Menzel wrote:
> > Therefore, fetch the timestamp directly from the interrupt handler.
> > 
> > The work queue code stays for the Intel 82576. Tested on Intel i210.
> 
> Excuse my ignorance, I do not understand the first sentence in the last
> line. Is it because the driver support different models? Why not change it
> for Intel 82576 too?

The 82576 does not have an interrupt event for this as far as I
remember.

> Do you have a reproducer for the issue, so others can test.

The issue is that the workqueue can be delayed and ptp starts
complaining. If the timestamp can be retrieved directly, there is no
reason for the delay.

Sebastian

