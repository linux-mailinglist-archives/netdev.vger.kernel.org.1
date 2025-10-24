Return-Path: <netdev+bounces-232558-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E6DAC06908
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 15:47:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DC3394F2B08
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 13:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB3231DDA9;
	Fri, 24 Oct 2025 13:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UtY9lXNM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wNxRshpR"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 271EE2566DF
	for <netdev@vger.kernel.org>; Fri, 24 Oct 2025 13:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761313628; cv=none; b=DyjJwW35UL/SAdhkpLwN0uURUiA6AtKVOh7zsIaigiZ76gVhWYe8qd40M7hovDHJEji2RFCuGja1mIWAT3CUChu7BV2j2WUQEPJd5LpGewSMoz5FNZ/yO/fmkC4F66XaO8OC7DZ3MLCjRg/h+g9CMdJsQFcLUM+mjU/lQsYsZlc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761313628; c=relaxed/simple;
	bh=pYWO1HBFHakJNFxicVjqjrnq8jQYDv2o2vJ3LG/QbcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pSt9vNhvTDXlbBa4GJHtZAEwwRyMHLhEKZgwlh6FiWHrIfJBrB7HP/XH9hMGCW7psKk8UURUNH1oqbDOdeRPgeRyXN1RX4EIGCcTLZu2cxoproMc0s9R/Cx1+JU1TAiK6tEmOn12iMlkQ0KBcYpOhWvyrFsdEZkJ8VKY0nB2KNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UtY9lXNM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wNxRshpR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 15:47:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761313624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pYWO1HBFHakJNFxicVjqjrnq8jQYDv2o2vJ3LG/QbcQ=;
	b=UtY9lXNMWasBZxmz3XUpXBiBuXrMEuEiD+FYnQMqpXW6I/jy2Bwh1Hb+e9N4T18bbHPfN+
	+vOqNr4osBwEKcc2uFXGIa5BE5VqrNa4fnuIn0ujaBR/oXo5WuEc3a5JREkkyQrgmPfmZC
	t02SYDm21WF0rmZ9OUBgEvOmxRdKkiPiHspa7/BKHkWlf6Ey/7/WskKSWzFxG9xd3HKy6N
	hBBC0h4Qjg+Sd4odQLlJ6WIsSiVxVWUG/LfCPyjtVeGePPFlc54UlcHVHl/ZicJiBy1p0p
	mzhGxMWlRjiRnez+pGk2gd1KpVUs7Q3YOYP63eBLcW5x2c23O8t9eNph3By6oQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761313624;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pYWO1HBFHakJNFxicVjqjrnq8jQYDv2o2vJ3LG/QbcQ=;
	b=wNxRshpRhUPTUxwE2Plh3DvSc6XuLmhPn1LWk6B3usaGMDQO35N/SAmXkzztTb3VJ7nLpI
	zaPaBLRXjyddsGAg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com,
	syzbot+f9651b9a8212e1c8906f@syzkaller.appspotmail.com
Subject: Re: [PATCH net] net: gro_cells: fix lock imbalance in
 gro_cells_receive()
Message-ID: <20251024134703.mER1deGv@linutronix.de>
References: <20251020161114.1891141-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251020161114.1891141-1-edumazet@google.com>

On 2025-10-20 16:11:14 [+0000], Eric Dumazet wrote:
> syzbot found that the local_unlock_nested_bh() call was
> missing in some cases.

Thank you Eric.

> Given the introduction of @have_bh_lock variable, it seems the author
> intent was to have the local_unlock_nested_bh() after the @unlock label.

Indeed that was the intention. It is even noted in the diffstat that
this the reason the variable.

Sebastian

