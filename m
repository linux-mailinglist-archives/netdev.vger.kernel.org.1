Return-Path: <netdev+bounces-177309-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39EFFA6EDFE
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 11:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20BAF3A93A7
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 10:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A1C254AED;
	Tue, 25 Mar 2025 10:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ll7LLZFj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Gdo7Xpq"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF1325487D
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 10:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742899468; cv=none; b=cLZv992gIk7gBLyMCv8zZCqyFc+l/7pnxjPmMsNJZOjS1FJ9E2+CWUAiRcD3O5A6OBQDnRKaStn5h9tLO9hCi8c8hLxOUBqOsFty0H26oR81kufGHx3oBoQ9oY2wSquIigFjSw9tpX6EE7p0wt0qW4Eb+VzizgGdCa5trt6BWnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742899468; c=relaxed/simple;
	bh=N6hRMYy+MK85vVzpO/DUY6jOdzgjRqCiLpk8t7pXv0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oXu07cbtgojSfOSvTq2vDDMuPh3xZet0bE1Q0Y8NeGozy8dfXqzK88H3WnikpmBLhTD78suEKcNpjbkStK7VZZEuzx6yZ+vHEr/S/WQizY8YwLXOE9lEMArlC6Vy2biYb8ELM0RWORg3LWOFB4VdLDL95ispulVmKPQqsnVDHDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ll7LLZFj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Gdo7Xpq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 11:46:11 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742899464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6xB2BErYVm3L4Qmt0N4AMI9m5or0sB4d/bwn8BYc7g=;
	b=ll7LLZFjSBxx6ZPOBQfxIP2GkHNsDVkuwQCC15nIUEnZxghTyZ4zODPzOvFtcNmB5w4xhi
	cdOl8GJBa/xbwdPFnCwzKEK5zbT747nY/RLeUsTASXd7NDzUCwq9e5k8xkB7cEYu76IrgQ
	Vg2kEWUxTrtMJorksZAZIPZxMTluOgB2o1myBVBtgpIbEPNxRINxXX+2H0w041QESKxOL0
	Bgu3HjgtKSyGfZV8nYT52PBoFLZHLpbH8inYoSOtTG9GPAOnUrlMTV0rwCrTXvzt10C2rg
	9eM5FrLENffTG3jCXvd14cP0g7YGLonTf4CwGEcIxY89WFHZUM3aI8K0uHHBwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742899464;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a6xB2BErYVm3L4Qmt0N4AMI9m5or0sB4d/bwn8BYc7g=;
	b=3Gdo7XpqYK9h0Ql+elvHd2RaL5gAgUhMNEMfJLAseXkUbsHtMbgdJ187rfdxZszvxgVC2J
	TeW0kqC/0wCThrBA==
From: Benedikt Spranger <b.spranger@linutronix.de>
To: Roger Quadros <rogerq@kernel.org>
Cc: netdev@vger.kernel.org, MD Danish Anwar <danishanwar@ti.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH] net: ti: icssg-prueth: Check return value to avoid a
 kernel oops
Message-ID: <20250325114611.4ac846b6@mitra>
In-Reply-To: <3bd78b6a-3c6d-4130-b086-36f2f728bc3e@kernel.org>
References: <20250322143314.1806893-1-b.spranger@linutronix.de>
	<89f81b99-b505-48ad-b717-99e5d4d8e87b@kernel.org>
	<20250323161826.5bcd9cf8@mitra>
	<3bd78b6a-3c6d-4130-b086-36f2f728bc3e@kernel.org>
Organization: Linutronix GmbH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 24 Mar 2025 16:44:20 +0200
Roger Quadros <rogerq@kernel.org> wrote:

> On 23/03/2025 17:18, Benedikt Spranger wrote:
> > On Sun, 23 Mar 2025 09:19:35 +0200
> > Roger Quadros <rogerq@kernel.org> wrote:
> >   
> >> Did you actually get a kernel oops?  
> > Yes. And I would like to attach the kernel output, but I do not have
> > access to the board ATM.
> >   
> >> If yes, which part of code produces the oops.  
> > I get an NULL pointer dereference in is_multicast_ether_addr().
> > It happens here:
> > 
> >     u32 a = *(const u32 *)addr;  
> 
> But this should not happen. Because ndev->addr (pointer) should not
> be zero. Driver allocated ndev with alloc_etherdev_mq() which
> allocates memory for ndev->addr using dev_addr_init(dev)).
Emphasis on *should* :)
OK, got your point. Dig deeper into that.

> >> Even if it fails we do set a random MAC address and do not return
> >> error. So above statement is false.  
> > I doubt that. of_get_ethdev_address() do not set a random MAC
> > address in case of a failure. It simply returns -ENODEV. Since
> > is_valid_ether_addr() fails with a NULL pointer dereference in
> > is_multicast_ether_addr() on the other hand, no random MAC address
> > is set.   
> 
> What I meant was we set random address using eth_hw_addr_random().
But that happens after the failing check. So evaluating the return of
of_get_ethdev_address() seem to be a good thing in the first place.

I my understanding (for now) it is nessesary to check both: the return
of of_get_ethdev_address() *and* !is_valid_ether_addr(). If any of these
checks fail eth_hw_addr_random() should be called and therefore a
random MAC address be set.

Regards
    Bene

