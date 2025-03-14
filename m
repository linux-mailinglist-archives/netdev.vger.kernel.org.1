Return-Path: <netdev+bounces-174891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B40A61252
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 14:16:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BAD9882040
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 13:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87D0A1EE00A;
	Fri, 14 Mar 2025 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JR5cM9OR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V7ai00Ht"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4311EB5B
	for <netdev@vger.kernel.org>; Fri, 14 Mar 2025 13:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958210; cv=none; b=tsZIBgMwovB/oGB/AMSEkhZP17N86nbk/TwGjTUs92XHLbAh4TfJK3XPifxICDU0cwjYeEH/ives8ZFyN/jeN1osKOV7O9W5weKsTBVcGjcxRSG1MWmcktjBDGdUKc5z+uQgoT8OWbFheepX7DWhsIxqqSAc29QXliSBWeiKWn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958210; c=relaxed/simple;
	bh=6+rz3BmT0AgacH2FmIvbRq6TlS0E35xWSPG/ltHBt6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7l7mUNV0DND3wbpGXyEiAPvwmaeNnlhsoSCnQHTcxY0zBEPotSyImxWPjld/zftPupQZViOEfk+2qYe5kp/sSxgTnHOwKOYCWdUvnV+9syPsPU81+Mq2DPvnq3m4wuAISsyE/M8pvmDjCZDpL+2xNMZcfiETko3Eu37+UPvLok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JR5cM9OR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V7ai00Ht; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 14:16:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741958206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oumrGbwDvXAcmZx4C7Uh/ssk/QQ4ux59KUig3E4kMMI=;
	b=JR5cM9OR5T9K7CekeKiJhKbV9YlufOhKOGwFYTZH9O0wni7oa5bLqiPLhJI4YInkHBy0fF
	EB0EjW4pwbN86TTN+v7iZ3QGfK5/XObse/p2J3JF9XE7YwGLT368C16Z6k9L0ISKX3e/++
	4ZB5ZZopoYSJH1e5bGyjwfsj6vHO/FhiY97D1Yu3NgdjvIOgIejJp4RKxbn/v8nqzRUw29
	KhE7VkmYaRT1geMy/JXN+/ffVc50jOe9QfYyQoATU6tXSEBkkU2pyHteGQ0lRA4t/mS4O2
	TzmS3nNRJgLOGVdgKfOVauBLc+zfoKPbDz3ZRlkRNtChM+adJk9awZx/ihgARg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741958206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oumrGbwDvXAcmZx4C7Uh/ssk/QQ4ux59KUig3E4kMMI=;
	b=V7ai00HtojN05Kr5qMOWTio43S7fCmJl7XKjN2I7UAvNlQtOnszQ+/1ksedLU2oIEhFVuW
	P0GROvUxB4Fic/DQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, rostedt@goodmis.org,
	clrkwllms@kernel.org, jgarzik@redhat.com, yuma@redhat.com,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
Message-ID: <20250314131645.1S4dYLPv@linutronix.de>
References: <20250206115914.VfzGTwD8@linutronix.de>
 <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
 <20250212151108.jI8qODdD@linutronix.de>
 <CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
 <20250212152925.M7otWPiV@linutronix.de>
 <mtmm2bwn3lrsmsx3evzemzjvaddmzfvnk6g37yr3fmzb77bpyu@ffto5sq7nvfw>
 <20250219163554.Ov685_ZQ@linutronix.de>
 <kwmabr7bujzxkr425do5mtxwulpsnj3iaj7ek2knv4hfyoxev5@zhzqitfu4qo4>
 <20250220113857.ZGo_j1eC@linutronix.de>
 <CAAq0SUkMXDaSvDRELYQn9+Pk-kBjx2BWc7ucme54XPXD97_kkg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <CAAq0SUkMXDaSvDRELYQn9+Pk-kBjx2BWc7ucme54XPXD97_kkg@mail.gmail.com>

On 2025-03-14 09:12:20 [-0300], Wander Lairson Costa wrote:
> On Thu, Feb 20, 2025 at 8:39=E2=80=AFAM Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> >
> > On 2025-02-20 08:35:17 [-0300], Wander Lairson Costa wrote:
> > > > You confirmed that it works, right?
> > > >
> > >
> > > Do you mean that earlier test removing IRQF_COND_ONESHOT? If so, yes.
> >
> > I mean just request_threaded_irq() as suggested in
> >         https://lore.kernel.org/all/20250206115914.VfzGTwD8@linutronix.=
de/
> >
>=20
> I forgot to answer, sorry. The answer is yes.

Are you going to post this a patch or want me doing it?
=20
Sebastian

