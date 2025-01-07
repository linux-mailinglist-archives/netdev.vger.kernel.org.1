Return-Path: <netdev+bounces-155863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B421CA04136
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 14:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9C8A1654AC
	for <lists+netdev@lfdr.de>; Tue,  7 Jan 2025 13:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170911F1928;
	Tue,  7 Jan 2025 13:51:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IOhx86Es";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4knpNCMX"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604F51EB9EF;
	Tue,  7 Jan 2025 13:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736257872; cv=none; b=PxHyQeqVugLQGaYhwFMI4A2jgKCyJJIpgTjj/99++YT1yhd/W9m1RYdqpi/xoJ4royUHmTTk1XLyCEVsGzxPP+i2OSfQtk/p7WE/fVy52T6n097VkHZgkt3ZdTDHye6l4uWGLjQOeVQsN1nRs8YVWPOfdZcDrgqwpFqOWiTrqs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736257872; c=relaxed/simple;
	bh=6xhSH58IgPuaGdcyPOHs9NHJISG3uPmS1Ge9S3ppjAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWl0h+Wz4uJGtsjoLMjiHVq48KS3luuqRwrmj4QJ+a0HT/mglyDIuFr1E8EuxYtLeBu4wWDZyOAgqw78wuoSgY73NJ7xNJWxRtjKPdktLFdLTuAOog0Farnh/dKPquFBVAUWcu8HLqqsRTuyXBwuehU/0sH8vHLm8QpZ008XJww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IOhx86Es; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4knpNCMX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 7 Jan 2025 14:51:06 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736257868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cct8mjPuTS2g1hERdmr1jNSJDlrhhPaqQc2wki1mp24=;
	b=IOhx86Esibh8T7Uq3RkbLHC3DioF3Wrh98RsmTDbQA8S6DEUvMNyR/rkleXX1Xa0xSoIg0
	Im2GF8dgr0/ARtD0+n7GCXUlzUnLgHzIQCOOa3hlf8ac8o516KXrFXZgM5C1FkQYUIMTQo
	P55DAIuAcWvJWRM0E2l/P6BRp+G2ojoxa7EJvpVB36U+F/wBmf19Bv5PZOnlUfmk7sfoSz
	cDd6XqNhYXvLZ8IA93UgD71FLqojCGw7UHxDDqunXbdIV2so0ORCOuz4HI85NrJcgvkrlE
	mTsMtG6d5pUg2OpqOIEI7LYtT+dICn+rRUKML3cZNUqGNR4fYaW3yQJw9Q/PIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736257868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cct8mjPuTS2g1hERdmr1jNSJDlrhhPaqQc2wki1mp24=;
	b=4knpNCMXSS+IFvgXhM12tf4YO5sC0sRyfIuWp2PqSEy+zyUrQ/71+LYqqZSEEv8ZQ886yE
	q5lFR933wlWa/ODw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Jeff Garzik <jgarzik@redhat.com>,
	Auke Kok <auke-jan.h.kok@intel.com>,
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:Real-time Linux (PREEMPT_RT):Keyword:PREEMPT_RT" <linux-rt-devel@lists.linux.dev>
Subject: Re: [PATCH iwl-net 0/4] igb: fix igb_msix_other() handling for
 PREEMPT_RT
Message-ID: <20250107135106.WWrtBMXY@linutronix.de>
References: <20241204114229.21452-1-wander@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204114229.21452-1-wander@redhat.com>

On 2024-12-04 08:42:23 [-0300], Wander Lairson Costa wrote:
> This is the second attempt at fixing the behavior of igb_msix_other()
> for PREEMPT_RT. The previous attempt [1] was reverted [2] following
> concerns raised by Sebastian [3].
> 
> The initial approach proposed converting vfs_lock to a raw_spinlock,
> a minor change intended to make it safe. However, it became evident
> that igb_rcv_msg_from_vf() invokes kcalloc with GFP_ATOMIC,
> which is unsafe in interrupt context on PREEMPT_RT systems.
> 
> To address this, the solution involves splitting igb_msg_task()
> into two parts:
> 
>     * One part invoked from the IRQ context.
>     * Another part called from the threaded interrupt handler.
> 
> To accommodate this, vfs_lock has been restructured into a double
> lock: a spinlock_t and a raw_spinlock_t. In the revised design:
> 
>     * igb_disable_sriov() locks both spinlocks.
>     * Each part of igb_msg_task() locks the appropriate spinlock for
>     its execution context.

- Is this limited to PREEMPT_RT or does it also occur on PREEMPT systems
  with threadirqs? And if this is PREEMPT_RT only, why?

- What causes the failure? I see you reworked into two parts to behave
  similar to what happens without threaded interrupts. There is still no
  explanation for it. Is there a timing limit or was there another
  register operation which removed the mailbox message?

> Cheers,
> Wander

Sebastian

