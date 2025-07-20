Return-Path: <netdev+bounces-208390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07DB7B0B42E
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 10:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF2E51893F70
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 106361A4F12;
	Sun, 20 Jul 2025 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otYFuESw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7B3FC7;
	Sun, 20 Jul 2025 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752999432; cv=none; b=PVe+ae1Er7xtLHbljwiL8CxpWNzTpPUbdjFwiw8jaeD1thOZedfiDlOyEZgjCaX0YgW16ckj/oIRb3ue/Vyl+Mt04R5xUKnWPOFElZ4/ogCVRmqQ+RjyC+nrzoN9r/C5lgAzoZPfD4szv+8HbNXJDpKkVhbzOScFLtcHff0cUh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752999432; c=relaxed/simple;
	bh=uz+9uwg5GzsKa58Af9yysdJmmc/CEhLqyfvKNBmM2Y0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EPB7UFIC5H//tqHIjoi1Jp+onFHhX3yt4mWIaEUlnwBCTEaaCgZ+CVuEocqWnKqrV7DFY4qhbQyoa1wIj1fi/kZm2CQPVED8Jb7hrSOx9TBj2MGk9zP+OrLQNm+Epgbl27LVz045FgXj6LlCnhrSsP2lpiDweFK/BiSw1I2fT1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otYFuESw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A046C4CEE7;
	Sun, 20 Jul 2025 08:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752999431;
	bh=uz+9uwg5GzsKa58Af9yysdJmmc/CEhLqyfvKNBmM2Y0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=otYFuESwe3oz6MhxHNte9zld6+C9v6bkFJFgXopq1hRRzIkjZXyzbuaAwRLoxMO2Y
	 SDfl+sadjw3MG5m9iO3OI9qeasqWg8j0C9jXaPGgJEjf/NLAeNpq4Q7u6AMGclU5Tw
	 PEmSz/RqowOJi5T+a/4nXVMnnsCXmvdNc59jE9bjDEVS0wKeMZuOsjbtLr1lYeMzS9
	 WGS5UhowiasmktVQ/Nf/ngB0lSdc6ObVu+v6fPM/UpcxuxvZyFIP/4aaMbaNNudgRA
	 O4N9k8aaFdcIvPTEtq2Gd30+gwdFatsEt1bKDKx14GKfPGrzAr5XjAxjVwTS3lRFEJ
	 xOYiuQNt0vWcA==
Date: Sun, 20 Jul 2025 11:17:05 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Dave Ertman <david.m.ertman@intel.com>,
	Saravana Kannan <saravanak@google.com>,
	linux-kernel@vger.kernel.org, Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Ira Weiny <ira.weiny@intel.com>
Subject: Re: [PATCH net v2 1/4] auxiliary: Support hexadecimal ids
Message-ID: <20250720081705.GE402218@unreal>
References: <20250716000110.2267189-1-sean.anderson@linux.dev>
 <20250716000110.2267189-2-sean.anderson@linux.dev>
 <2025071637-doubling-subject-25de@gregkh>
 <719ff2ee-67e3-4df1-9cec-2d9587c681be@linux.dev>
 <2025071747-icing-issuing-b62a@gregkh>
 <5d8205e1-b384-446b-822a-b5737ea7bd6c@linux.dev>
 <2025071736-viscous-entertain-ff6c@gregkh>
 <03e04d98-e5eb-41c0-8407-23cccd578dbe@linux.dev>
 <2025071726-ramp-friend-a3e5@gregkh>
 <5ee4bac4-957b-481a-8608-15886da458c2@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ee4bac4-957b-481a-8608-15886da458c2@linux.dev>

On Thu, Jul 17, 2025 at 01:12:08PM -0400, Sean Anderson wrote:
> On 7/17/25 12:33, Greg Kroah-Hartman wrote:

<...>

> Anyway, if you really think ids should be random or whatever, why not
> just ida_alloc one in axiliary_device_init and ignore whatever's
> provided? I'd say around half the auxiliary drivers just use 0 (or some
> other constant), which is just as deterministic as using the device
> address.

I would say that auxiliary bus is not right fit for such devices. This
bus was introduced for more complex devices, like the one who has their
own ida_alloc logic.


> Another third use ida_alloc (or xa_alloc) so all that could be
> removed.

These ID numbers need to be per-device.

Thanks

> 
> --Sean

