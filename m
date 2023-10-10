Return-Path: <netdev+bounces-39399-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C857BF012
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 03:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4C481C20A17
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 01:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C700F38E;
	Tue, 10 Oct 2023 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjnXfl4q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1F4377
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 01:09:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6E3DC433C8;
	Tue, 10 Oct 2023 01:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696900179;
	bh=rpZwfgLhvy5NqjoH11+XB5hus1b0cemlPwEivuy1gFc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bjnXfl4qyuPsS3baHqQuOCAT9FK00axcKnBdFMKqr5qve0gkvhIWLMx8mu/1iw7BN
	 qfday0BuLRKe5KHd3HgjQ+sWFY4KKatOiBh6GVZkeAzcdHUEKU8Z1UudPoSJs8He1+
	 hQ9avKm296g5+eZr2rFN/3O9RVsguAzz/q6COyj7kuREWtBmwr8BqJWsIp0X0PByrW
	 uQthIrcDvxGkDY+Y0FSxn0j3nL6T8rDSjjrDXRwC/gHOQ1aH3DR6fe8r78IfW4AtpQ
	 LytbcKENjMPJ5sz/ZKsoKamVp1gWxob3/ETRSCItZNG7L3AeNXWFIP4X15RKQd5NJ3
	 Rtsy8TBg4kXmQ==
Date: Mon, 9 Oct 2023 18:09:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, Wander Lairson Costa <hawk@kernel.org>
Subject: Re: [PATCH net-next 0/2] net: Use SMP threads for backlog NAPI (or
 optional).
Message-ID: <20231009180937.2afdc4c1@kernel.org>
In-Reply-To: <20231007155957.aPo0ImuG@linutronix.de>
References: <20230929162121.1822900-1-bigeasy@linutronix.de>
	<20231004154609.6007f1a0@kernel.org>
	<20231007155957.aPo0ImuG@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Oct 2023 17:59:57 +0200 Sebastian Andrzej Siewior wrote:
> Apologies if I misunderstood. You said to make it optional which I did
> with the static key in the second patch of this series. The first patch
> is indeed not what we talked about I just to show what it would look
> like now that there is no "delay" for backlog-NAPI on the local CPU.
> 
> If the optional part is okay then I can repost only that patch against
> current net-next.

Do we have reason to believe nobody uses RPS?

