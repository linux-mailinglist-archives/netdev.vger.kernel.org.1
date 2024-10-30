Return-Path: <netdev+bounces-140374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B57B9B63AF
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 14:06:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F561282130
	for <lists+netdev@lfdr.de>; Wed, 30 Oct 2024 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6A1F1E767D;
	Wed, 30 Oct 2024 13:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="WA0gKVp6"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75EFA1E511
	for <netdev@vger.kernel.org>; Wed, 30 Oct 2024 13:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730293596; cv=none; b=r8h9zt28kL5zqOVKuBuoNxz7U2KB4yz/SXNMFQu1gTQLfiexU7cckyhYu4FRNTbdHS8mKA09DEbJ3brCxvx/L3g4VrWzbywhO8NiLpzG1ei/fXF7grRUiqVBH8HHXsj+5htuqLMDIUV8aIqvpv/4RwNFqJ8KOVKwX8rcNnFSwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730293596; c=relaxed/simple;
	bh=GOZZd972aAtGvzx8Z2x6vKXbfJb0PHKy2+ANp5toEnk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Hx6kHQsXolme9xxtU71tJsspLkgFzWpfxVLBvwm+BpbFoRF6k0zzg9fWhTMTr6wF/cQYJSCjN18iHqrFr/+UZ4YSYl3yL2ryfmkUlSAqH3Qyq/Z+tDHpVc3FS8yFQVq0/wuJBPH6JKbqy9cWg7RC8ArALJ1B5QaUM9xrO4uQIXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=WA0gKVp6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1DqnMG17CDak+79OPwAR8/F6bSc7wgpP46vWsH0K/zQ=; b=WA0gKVp6WQfVPmEGsPLmouzj6n
	W84ilinDrH6zyA3pT96cYEx3F8fOrbiADKZ1jgLcbkq/MkBui90ewFGur2bDX9B7symbGLhWMRz9v
	Xpu/vppQ8ZG8hDc4GwP1iajpXx66Ju5CvncH12A7EURzDQ2X3l/1JuHrZc1PH6FVfU90=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1t68PA-00Bgmy-Nk; Wed, 30 Oct 2024 14:06:32 +0100
Date: Wed, 30 Oct 2024 14:06:32 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: John Ousterhout <ouster@cs.stanford.edu>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next 08/12] net: homa: create homa_incoming.c
Message-ID: <471a65c1-2ddd-4dc3-a241-fd5bdf28ce55@lunn.ch>
References: <20241028213541.1529-1-ouster@cs.stanford.edu>
 <20241028213541.1529-9-ouster@cs.stanford.edu>
 <1ec74f2a-3a63-4093-bea8-64d3d196eac6@lunn.ch>
 <CAGXJAmwaqMs12YtHMZRN5bbqOor2gVe+cCo=JqduaoXsErCY=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGXJAmwaqMs12YtHMZRN5bbqOor2gVe+cCo=JqduaoXsErCY=w@mail.gmail.com>

> BTW, I did some experiments with tracepoints to see if they could
> replace timetraces. Unfortunately, the basic latency for a tracepoint
> is about 100-200 ns, whereas for tt_record it's about 8-10 ns.

This is good to know, and you will need it for justification if you
decide to try to get tt_record merged.

However, once you get homa merged, you will find it easier to reach
out to the tracepoint Maintainers and talk about the issues you
have. If working together you can make tracepoints a lot faster,
everybody benefits.

	Andrew

