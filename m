Return-Path: <netdev+bounces-168120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB58A3D8F6
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 12:40:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BE2C73B4115
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 11:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E6C1F3FC1;
	Thu, 20 Feb 2025 11:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ou5DWVJt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FwEeoAP7"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F3C1F3D21
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 11:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740051542; cv=none; b=JlI7r3C4g9RubPYuZl1U0vt6zQzKh0r5010vdIeGGgQxLc5/QRXt2XCy2cyOyG+VVnRHO+AFmL5wD7j6hJSvdgyvKeDL3Bpw8UvCIjpiTXDFKOCOiOmt2zJuIZn/1xCJuY3O19z+qI0hwRe6QZd4Nv5FLEyPYf7PATwu2KZj3W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740051542; c=relaxed/simple;
	bh=Tf71EAsCTOQO85ybZw4+AkOYHugI6z7gLrG851hUMfY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SRIp6YNGuh/Ewis7F758GERxmv8vtUBDuc3d00VOilj227pD8QtNOKNQKv7xEQu5BBmSJvrAfpDHPqtGX4NOxnzIl/O6VJRrLef4/42W1tm2rxnivHAyofIFyw4rsu0Tfxqya28cmHu0+FF4MEq0CDALln5UNA02Z3/OLP7emhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ou5DWVJt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FwEeoAP7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Feb 2025 12:38:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740051538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vwGSV38IPnTsndryvEd9ejFAYZUwlThIj+JaDhdNpSA=;
	b=ou5DWVJt68ANpTOlfZz8PuTuZ7GpNqXTNV0IP14WTjCPoYY2EPkN4gANeg4D/ZzZy+/hfn
	XCFnpFGmXRmafkvqrgxrMJWuSQ+rx06dv4WpIQiIaVMW0WonRIdLlq7qAn+HFhn6Hlcpv9
	dW0KhyR0B+VO49pB52bL5mdDYbd44jb2D+pHJwMx+1lwRjPLsdW3YiDCKMKjqSal13Eu9C
	c1aaACRqs1/kiBAQrtJfTEGW/OlBGcc8RFtpOpPy4GtEw8MnGMfWOzcE28YcbZHpMEJwZS
	mYzJagu8Y2niBUneKZZYRJ7uZKJIKMHk2gs2yi6mslo4eT5smRFcp/yUB93VfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740051538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=vwGSV38IPnTsndryvEd9ejFAYZUwlThIj+JaDhdNpSA=;
	b=FwEeoAP7AGXLhFDOB9eDjVejPSgBEPlCkI3Hez/GadAFz40YcCZCMk+aRFZbGuH7AySHZL
	wHXNpcsOGn8u6/AQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, rostedt@goodmis.org,
	clrkwllms@kernel.org, jgarzik@redhat.com, yuma@redhat.com,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
Message-ID: <20250220113857.ZGo_j1eC@linutronix.de>
References: <20250205094818.I-Jl44AK@linutronix.de>
 <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
 <20250206115914.VfzGTwD8@linutronix.de>
 <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
 <20250212151108.jI8qODdD@linutronix.de>
 <CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
 <20250212152925.M7otWPiV@linutronix.de>
 <mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>
 <20250219163554.Ov685_ZQ@linutronix.de>
 <kwmabr7bujzxkr425do5mtxwulpsnj3iaj7ek2knv4hfyoxev5@zhzqitfu4qo4>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <kwmabr7bujzxkr425do5mtxwulpsnj3iaj7ek2knv4hfyoxev5@zhzqitfu4qo4>

On 2025-02-20 08:35:17 [-0300], Wander Lairson Costa wrote:
> > You confirmed that it works, right?
> > 
> 
> Do you mean that earlier test removing IRQF_COND_ONESHOT? If so, yes.

I mean just request_threaded_irq() as suggested in
	https://lore.kernel.org/all/20250206115914.VfzGTwD8@linutronix.de/

Sebastian

