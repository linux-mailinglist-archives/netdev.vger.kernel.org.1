Return-Path: <netdev+bounces-247952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 986D0D00DDD
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 04:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D35303015EEE
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 03:25:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B99219C546;
	Thu,  8 Jan 2026 03:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A6cXgZ9g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E0FCA6B
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 03:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767842713; cv=none; b=WA4nGoV6wX8aigEhcEeA7uiNEiJdl/efErPf6RiDlk3eK0OP7A2ofE+FVGIw3OCNoth3GuRSbu/HblzcB4qkXUe4sfHrJEMIVK0fzoabNg/PwXt5YgkQuJ/u4msL6EeIFrEVItEOBpnhPwAnIO6fwIqbfLpWVMu3bsHTb9ps31Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767842713; c=relaxed/simple;
	bh=l6bN91X2DSVBOPicQ24dGdWUQRFvPPXfvT8/S7OVgys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A9GbNyOBX1ANx97+D2R3rRUnXyfIlfX0e88z6UMzOXSHabriodJV5loVDq1Sz3o+tCJAVCE9QVvBe4vPQJ0AehPLZLO11nO/k7EQrVq+GiF7FGOo7H/+QawtcTRDWvO5tQ0wXYDiqPNvaG9pq04kVlyuVyOjvT31FpuKsuKSfno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A6cXgZ9g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5214DC116C6;
	Thu,  8 Jan 2026 03:25:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767842712;
	bh=l6bN91X2DSVBOPicQ24dGdWUQRFvPPXfvT8/S7OVgys=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=A6cXgZ9g7E8oGdyzxwXg7BfwKJ0Bb3ZZPj69ZBy/hV9wSlwaFBycYi5xH19YhIqOs
	 3Kg1M1KeZw64FIY5kR37Q9pKNpn57ttsXVKRNIrLk87W3bAXJQCgx9zRQ9JYd9/15H
	 UPk2nf/NkV6JOTn2m7u/m0CrAzBl+yIFNcwr2lhr+ZVgGkzW1OAKz2aRGEt3NeCea0
	 ISkscfXOX/blG86ZwkLtsSLLRWPu0VTXKYm7Yl9Lpu1F4wRCTXjDQc9by78xb+BTX1
	 zNbz2Vw4AHlWVQE+t03xBhBtNZjurHBpvODMQ+Te/jtZn593bARnthCkuNM1vwh2Ej
	 Mi8TZ7v91hC6Q==
Date: Wed, 7 Jan 2026 19:25:11 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Willem de Bruijn <willemb@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [TEST] txtimestamp.sh pains after netdev foundation migration
Message-ID: <20260107192511.23d8e404@kernel.org>
In-Reply-To: <willemdebruijn.kernel.276cd2b2b0063@gmail.com>
References: <20260107110521.1aab55e9@kernel.org>
	<willemdebruijn.kernel.276cd2b2b0063@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Thanks for investigating!

On Wed, 07 Jan 2026 19:19:53 -0500 Willem de Bruijn wrote:
> 17 out of 20 happen in the first SND-USR calculation.
> One representative example:
> 
>     # 7.11 [+0.00] test SND
>     # 7.11 [+0.00]     USR: 1767443466 s 155019 us (seq=0, len=0)
>     # 7.19 [+0.08] ERROR: 18600 us expected between 10000 and 18000
>     # 7.19 [+0.00]     SND: 1767443466 s 173619 us (seq=0, len=10)  (USR +18599 us)
>     # 7.20 [+0.00]     USR: 1767443466 s 243683 us (seq=0, len=0)
>     # 7.27 [+0.07]     SND: 1767443466 s 253690 us (seq=1, len=10)  (USR +10006 us)
>     # 7.27 [+0.00]     USR: 1767443466 s 323746 us (seq=0, len=0)
>     # 7.35 [+0.08]     SND: 1767443466 s 333752 us (seq=2, len=10)  (USR +10006 us)
>     # 7.35 [+0.00]     USR: 1767443466 s 403811 us (seq=0, len=0)
>     # 7.43 [+0.08]     SND: 1767443466 s 413817 us (seq=3, len=10)  (USR +10006 us)
>     # 7.43 [+0.00]     USR-SND: count=4, avg=12154 us, min=10006 us, max=18599 us

Hm, that's the first kernel timestamp vs the timestamp in user space?
I wonder if we could catch this by re-taking the user stamp after
sendmsg() returns, if >1msec elapsed something is probably wrong 
(we got scheduled out before having a chance to complete the send?)

> These are just outside the bounds of 18000. So increasing the
> tolerance in txtimestamp.sh will probably mitigate them. All 17
> would have passed with the following change.
> 
> -        local -r args="$@ -v 10000 -V 60000 -t 8000 -S 80000"
> +        local -r args="$@ -v 10000 -V 60000 -t 8000 -S 100000"
> 
> Admittedly a hacky workaround that will only reduce the rate.
> 
> It's interesting that
> 
> - every time it is the first of the four measurements that fails.
> - it never seems to occur for TCP sockets.

FWIW:
https://netdev-ctrl.bots.linux.dev/logs/vmksft/net/results/449080/13-txtimestamp-sh/stdout
but that could be related to some bad patch..

