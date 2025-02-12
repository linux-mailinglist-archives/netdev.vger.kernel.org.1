Return-Path: <netdev+bounces-165583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD3DA32A08
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 16:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA9953A7918
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46798214A86;
	Wed, 12 Feb 2025 15:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I0sV1FXW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zlQZvA2Y"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2724212F92
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739374170; cv=none; b=CF3h0yvuC/ZrEe6IWO0zGsV/04a6LeS4GBgvpC7N3QQAXuPbxK6WElkRbiJtql/JpbmeBSqNft9/HW0bHdi5ruMhz5C3ZxaWfYCqnyHfYEzJvd+2yGldNrWzxQwliF0pvMOG33Gd1QKFnB3tzQ80J8dCWZJvZrr+7xR/MgLlwp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739374170; c=relaxed/simple;
	bh=dz79Uibn00L/vdneWJViKbFneEO31WJSqsnjcocQf+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aTb6J9GeN2/X6ACTGL5bz0LlPLVx1Ejlu0DBBDv3lC+H9ChYjldDyYAhNah40fhOCvY3fwobvM0L5aQ8VhHCJQB3jPCzrzQOJ7K5FF9SL13l2OXLJw7BExpQo+UeBQO6v6sQbVeqPtApw5SbWi/bbMxtOszu5Aza990x36y99Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I0sV1FXW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zlQZvA2Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Feb 2025 16:29:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739374167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dz79Uibn00L/vdneWJViKbFneEO31WJSqsnjcocQf+A=;
	b=I0sV1FXWNSr4ROylZ57cprSVx1NUuQ2K6YCwg6Oz55JHQ4geezdc8tx6mewku6kRzOWh4O
	+rC1RwjC3+u21WFj5cRKY2zhw8taTKUCGFC8UTq3u0XCmPZy4gfneEc5WrKd/tAyoxpHli
	WAShBS7o4v92o6SzDovh+ReqlZK+gTfduuz6KSiMh8euLCqOc3kqYZKUC+d7QldVu3UKG1
	bxVkYmFlp/jNfwCB9G0z24TVBaWRwCS7cULM9lcNPf6VF4fVKdvpnJKSAtbhPrsZVB29HW
	939mu5qRivg6qieYKfOKMR5EAjnFPI0yWHfUHYfwVKr1m6ZpeskiZjXzO+/zUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739374167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dz79Uibn00L/vdneWJViKbFneEO31WJSqsnjcocQf+A=;
	b=zlQZvA2YBmNJWERb3o3eGbEu3qvXG4RvYLbeJWUq0w3O8B8GyEpa/WjGC2dE33rGmYL8PZ
	8b0Tvk46NpkkPvBA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Wander Lairson Costa <wander@redhat.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, davem@davemloft.net,
	kuba@kernel.org, pabeni@redhat.com, edumazet@google.com,
	andrew+netdev@lunn.ch, netdev@vger.kernel.org, rostedt@goodmis.org,
	clrkwllms@kernel.org, jgarzik@redhat.com, yuma@redhat.com,
	linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH net 0/4][pull request] igb: fix igb_msix_other() handling
 for PREEMPT_RT
Message-ID: <20250212152925.M7otWPiV@linutronix.de>
References: <20250204175243.810189-1-anthony.l.nguyen@intel.com>
 <20250205094818.I-Jl44AK@linutronix.de>
 <mrw3tpwsravsaibkcpptdkko3ff6qtk6w6ernqvjisk4l7owok@q6hmxkzcdkey>
 <20250206115914.VfzGTwD8@linutronix.de>
 <zy3irjybyc32hnow3ckhkfsrtfm5nev44aeovinlkkfc6tyyjv@gcblibp5ng3o>
 <20250212151108.jI8qODdD@linutronix.de>
 <CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAq0SU=aU=xpw0bDwaanFh_-r5tts0QNCtSmoteP3dM8-K6BFA@mail.gmail.com>

On 2025-02-12 12:21:04 [-0300], Wander Lairson Costa wrote:
> > "eventually fails". Does this mean it passes the first few iterations
> > but then it times out? In that case it might be something else
> >
> Yes. Indeed, might be due something else. I will perform further investigation
> when I get the machine back.

Okay. Then I consider this series not going to be applied, I have an
idea what is happening and I wait until you get back.

Sebastian

