Return-Path: <netdev+bounces-168242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93E45A3E3AD
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 19:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4769B7018D1
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 18:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52A1020FAAB;
	Thu, 20 Feb 2025 18:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eZyY7/W3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4D192B86;
	Thu, 20 Feb 2025 18:18:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740075505; cv=none; b=ckegTTUWR/magr0kTYk2Fyr8s8hecv56ezzw7VEHqsjkx+rnRS6GibYrx/rQZ+Qw26yH0bWvV6VItwFRlZEBND/0OMvYJda8qAVL8XvWuDj3UuFtWE7dtgeqAN07Y2ZPPJ3iSxkewt4XkxaR0c8ITgWdSRXarz797H4wxhRaPf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740075505; c=relaxed/simple;
	bh=UZJ9Fyydl3UipA8lDRj3C3aMHi3OtLR1wIV8b8u2+5s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LAD4G5CnylWjh6Jc13+o7hWXkIsYZgXlykd7zV/plADehCW9ZywolTjgpWZLhOhU0gfXKnGrCFQv5WTkCsmHaEXANjSr0DvteuT1V3Xpy1P5RkwCSXI03VUg8TqM1Y0ZPogSyzu8ZyDjWAT8rJU0WSukoZOD5+yzhbd4bT2pr3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eZyY7/W3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C028C4CED1;
	Thu, 20 Feb 2025 18:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740075504;
	bh=UZJ9Fyydl3UipA8lDRj3C3aMHi3OtLR1wIV8b8u2+5s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eZyY7/W3ttlX3NgBk4VTizQWX/rJgFtt3Tlc780mRCCyW4+7Fg+9O7LUq0XSbfrIw
	 LKWLhuPWD5Djai/6okjA5tMDtgPx5c+OHjknnLGdCv3Ptgz05tFMc1NZXu1yb4lY2b
	 FdibA/xUOb8tjYI8i1a+uMiF2UF4hNJSbKbMp7OHbVD9FbTIJ6f93BTZpudcFJgC/k
	 ZfEYgg7D4E6lAincpzQT1qvt729h9bYFCUfLYXJLxb8WHoZ1yPPJmhQ8431eCAGN4M
	 fWbvOgnorxdHcX/qFae0EVZwQzBnzaJc7ekcFOpgl6msbfNyVzmzcwS+CD4LFl4SmM
	 yAC0ZQ5bxZqCg==
Date: Thu, 20 Feb 2025 10:18:23 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: patchwork-bot+netdevbpf@kernel.org, nicolas.ferre@microchip.com,
 claudiu.beznea@tuxon.dev, netdev@vger.kernel.org, davem@davemloft.net,
 edumazet@google.com, andrew+netdev@lunn.ch, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/2] net: cadence: macb: Modernize statistics
 reporting
Message-ID: <20250220101823.20516a77@kernel.org>
In-Reply-To: <561bc925-d9ad-4fe3-8a4e-18489261e531@linux.dev>
References: <20250214212703.2618652-1-sean.anderson@linux.dev>
	<173993104298.103969.17353080742885832903.git-patchwork-notify@kernel.org>
	<12896f89-e99c-4bbc-94c1-fac89883bd92@linux.dev>
	<20250220085945.14961e28@kernel.org>
	<561bc925-d9ad-4fe3-8a4e-18489261e531@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Feb 2025 12:25:09 -0500 Sean Anderson wrote:
> >> I think this should be deferred until v2 of [1] is applied, to make
> >> backporting the fix easier.  
> > 
> > ETOOLATE :) networking trees don't rebase  
> 
> Well, I was expecting a revert and then I would resend this series once
> the linked patch was applied.
> 
> I guess I can send another patch adding locking?

Assuming the fix is applied to net:
Will the trees conflict?
If no - will the code in net still work (just lacking lock protection)?

If there is a conflict you can share a resolution with me and I'll slap
it on as part of the merge.

