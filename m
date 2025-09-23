Return-Path: <netdev+bounces-225731-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8450B97CDF
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 01:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 985BF2E2D2F
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 23:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379FF30C0FD;
	Tue, 23 Sep 2025 23:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBmKkQwR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14A117A5BE;
	Tue, 23 Sep 2025 23:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758670650; cv=none; b=i+LMOePRCSDkxZH4ohKp14s9EJbtZYkK2imfO3ArM7v+Ytzxi/3ScxxbWYDYTxAe7e0IlnAm0VVakm6mPnPORzlK5/3rEzm8qzQZtIcn8IuKT7jq0wFh+SMECx8lurs4SoPu51VkIDdFIrRMDbp7jOCPpfP/T51KvSucYaWANsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758670650; c=relaxed/simple;
	bh=x2oIkf/wqVXdqXEmFjopZYbSnwaDoqrJINY8rvjWOVY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxWIiSPLAcJeshHcxs9YZSrV0EzRS6MLH9nL/j/yqHP4hGue/7lJwhj9qU/r7ftcJ1gf+5/MpfTRyKsBZnJtas2JODQIYPNNlBXc9E2YMNgfJQtAFuyPdB+djU14P420vg58C4TzRpmJAeuWWxN1COLj2ntMXxg/8b67eAiuFXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBmKkQwR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF9DDC4CEF5;
	Tue, 23 Sep 2025 23:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758670649;
	bh=x2oIkf/wqVXdqXEmFjopZYbSnwaDoqrJINY8rvjWOVY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jBmKkQwRKMcZLRN8J15vBjTDB8GP9MfHuPufNarhtwwET0Dur/jq3DidBgT5UmJMS
	 9jLas1fCUrorvG5uVxf/MS0FWpxHDCRBZ87ulmnOjOdX5ZQqFLLd0pWB66oKm8Lz6X
	 Y4jw3MQOvS5ZkvQzVZKmqyozAV9LAmEE4RKrGp3j3XzRREvOmtKW/NO/WeQDrHM/p+
	 Y3GcQGG2TGCOO3fMh5yYF1V+eG94pEaBH/YS0WCi3Ke8MM0VTJJgPOyns68n5Bk0rt
	 TZjVpnJ7J6abkuwna73JTZS52uHTrJe7BzFnj4/s+lnOHomRWfMnsSgjM2+vGg0eNH
	 Ohex8td6/JVRw==
Date: Tue, 23 Sep 2025 16:37:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michal Pecio <michal.pecio@gmail.com>
Cc: I Viswanath <viswanathiyyappan@gmail.com>, andrew@lunn.ch,
 andrew+netdev@lunn.ch, davem@davemloft.net, david.hunter.linux@gmail.com,
 edumazet@google.com, linux-kernel-mentees@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, petkan@nucleusys.com,
 skhan@linuxfoundation.org,
 syzbot+78cae3f37c62ad092caa@syzkaller.appspotmail.com
Subject: Re: [PATCH net v2] net: usb: Remove disruptive netif_wake_queue in
 rtl8150_set_multicast
Message-ID: <20250923163727.5e97abdb@kernel.org>
In-Reply-To: <20250924012039.66a2411c.michal.pecio@gmail.com>
References: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch>
	<20250920181852.18164-1-viswanathiyyappan@gmail.com>
	<20250922180742.6ef6e2d5@kernel.org>
	<20250923094711.200b96f1.michal.pecio@gmail.com>
	<20250923072809.1a58edaf@kernel.org>
	<20250924012039.66a2411c.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 01:20:39 +0200 Michal Pecio wrote:
> With the patch, it all goes away and doesn't show up even after a few
> minutes. I also tried with two TCP streams to a real machine and only
> observed a 20KB/s decrease in throughput while the ifconfig allmulti
> loop is running, probably due to USB bandwidth. So it looks OK.

Excellent, could you send an official Tested-by tag?

> But one annoying problem is that those control requests are posted
> asynchronously and under my test they seem to accumulate faster than
> they drain. I get brief or not so brief lockups when USB core cleans
> this up on sudden disconnection. And rtl8150_disconnect() should kill
> them, but it doesn't.
> 
> Not sure how this is supposed to work in a well-behaved net driver? Is
> this callback expected to return without sleeping and have an immediate
> effect? I can't see this working with USB.

The set_rx_mode callback is annoying because it can't sleep.
Leading to no end of issues in the drivers.

The best way to deal with this IMHO is to do the confirm from a work
item. Don't try to kick off the config asynchronously, instead schedule
a work which takes a snapshot of the config, and then synchronously
configs the device. The work give us the dirty tracking for free 
(if a config change is made while work is running it will get
re-scheduled). And obviously if there's only one work we can't build
up a queue, new request before work had a chance to run will do nothing.

We have added a todo to do something along these lines in 
the core 3+ years ago but nobody had the time to tackle this.
The work and taking a snapshot of the rx config are not driver-specific,
so it could all be done in the core and then call a (new) driver NDO.

