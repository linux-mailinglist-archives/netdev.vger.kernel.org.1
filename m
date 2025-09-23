Return-Path: <netdev+bounces-225645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D50B964AA
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 16:35:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 269757B8065
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 14:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDF0E323F78;
	Tue, 23 Sep 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vQCgbZOt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA092475C2;
	Tue, 23 Sep 2025 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758637690; cv=none; b=kuLLCr074C2upHXfC0xgvMvUlO+6iTez7aaU2o3Towb5juvdAAxICzAsoNizD8LylCCk9D463gwG/MVQjZP3EuvPehAsOgQ+PgQSi7JLjrwc/KTiSxafjxlFGT2mMqd+N9TlDr+IGnIMD9CTEwwnRdrhjmO4gkp+s5PHC4/EgQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758637690; c=relaxed/simple;
	bh=cCAvArKYI9+1fdw3oMSRIGwzyIqwiRWzr2uSM38P/0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lmONpzLaq0fv4cidUc96CdlNGCeAEW0hjne+lZuDSefzWiIT6ZVPrQcstM2lzSbxx2+gFP9nXdqlwjf1ndl5rho8tAbM0o6RxrD8bk9lc6eUGGHESKtLHHAqVterHr6f0yYmb2I5d5/N2mF3Mqq8Dk9uG68dqmAbrfx0KPgi75Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vQCgbZOt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE700C4CEF5;
	Tue, 23 Sep 2025 14:28:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758637690;
	bh=cCAvArKYI9+1fdw3oMSRIGwzyIqwiRWzr2uSM38P/0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vQCgbZOtZ5oeh//BAVBmA+97HegAbwdDGCSSP0v1UxIR3NPYx2UP2cV0PKKro9FGC
	 vy/pFbHvzrZI4hx4FRzjcqW805+1xo8ImbsbA8VE2F9tzQFazOzrwY0cjTBsys5NU6
	 9/fqE58/81Up+s0CSAJxCaHmWcEwRGBpAyjAmvsa2OvIi/XJOAiD3EmjUmqE9Bvukf
	 sA0DFpnauMGQLqGkYAAq69B3owHwwxIt7CXPl5F0W4Bth7s6UcQEe3NWVedE484cQ4
	 wq/y2F3LBU31fOG8KWSyRbcM45w8yp4mUcd7wDKkqdCKlOODn6oaqMZtYQtmDBVmz3
	 SqE7gDi8hBqRQ==
Date: Tue, 23 Sep 2025 07:28:09 -0700
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
Message-ID: <20250923072809.1a58edaf@kernel.org>
In-Reply-To: <20250923094711.200b96f1.michal.pecio@gmail.com>
References: <83171a57-cb40-4c97-b736-0e62930b9e5c@lunn.ch>
	<20250920181852.18164-1-viswanathiyyappan@gmail.com>
	<20250922180742.6ef6e2d5@kernel.org>
	<20250923094711.200b96f1.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Sep 2025 09:47:11 +0200 Michal Pecio wrote:
> On Mon, 22 Sep 2025 18:07:42 -0700, Jakub Kicinski wrote:
> > On Sat, 20 Sep 2025 23:48:52 +0530 I Viswanath wrote:  
> > > rtl8150_set_multicast is rtl8150's implementation of ndo_set_rx_mode and
> > > should not be calling netif_stop_queue and notif_start_queue as these handle 
> > > TX queue synchronization.
> > > 
> > > The net core function dev_set_rx_mode handles the synchronization
> > > for rtl8150_set_multicast making it safe to remove these locks.    
> > 
> > Last time someone tried to add device ID to this driver was 20 years
> > ago. Please post a patch to delete this driver completely. If someone
> > speaks up we'll revert the removal and ask them to test the fix.  
> 
> These were quite common, I still have one.
> 
> What sort of testing do you need?

Excellent, could you check if there is any adverse effect of repeatedly
writing the RCR register under heavy Tx traffic (without stopping/waking
the Tx queue)? The driver seems to pause Tx when RCR is written, seems
like an odd thing to do without a reason, but driver authors do the
darndest things.

