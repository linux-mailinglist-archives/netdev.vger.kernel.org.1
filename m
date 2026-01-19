Return-Path: <netdev+bounces-251136-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3813D3AC8A
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 607F0307521F
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 14:26:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466FE3803D4;
	Mon, 19 Jan 2026 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TTI43zyr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241B83803D1
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 14:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768832738; cv=none; b=sIJYs8wdugvGoeB93XM7UlA6vtV9zUyC4RDslU+KHnVA+hEpKJdunGeS2QLH0UJ0osXlNs5hqXH5mGKGRvv1JGzkPDPBYSWqF2mFej3ntbKIhryPWXdPMsCcAeMeFge16Yhcx4khVe4ywBfsM3zA0mRrOfXAge7HB9kOAWs4yXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768832738; c=relaxed/simple;
	bh=/ER5iS0uk9Jn1K4b37O66soNnZ0w9ZKXJGHhyHdR1bI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GzXRY79l9xHBmmsNR5o8sU3a2UA6atnpyDGkigtDQ5S8Z+erQnJ+NmDyephtDEWdjO5D8VSyzmc7/UH9aPvHSiOS/uIRei7dH8SJg+9QfcpWVjXwWt4jL4sYv0no6gCRsU0nUYx6vUjdSvpEzahG+MQXM7I0F5HpiIxnuNrmM6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TTI43zyr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FD5C116C6;
	Mon, 19 Jan 2026 14:25:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768832738;
	bh=/ER5iS0uk9Jn1K4b37O66soNnZ0w9ZKXJGHhyHdR1bI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TTI43zyrcPhynM60Zwkwsn1NGqAiNMUNssUWkeyuEebZy3lJz7+to2kczo3D6KaSe
	 SWDaTSim3U9Am8Rgc1tvU07Y4pKur2+daWQwZaDwzJqnXuLev7EiePKVwE1l4u34hv
	 0ZY+oRib+DPv0WiOFu/1D0DpOGRJdxI2If5jW/SvxJcOWDxkrosMJlt1VYpOnFoEQc
	 voAAU2CM3X6gJII+n9QFl/12EFqHxr3pWRJntMAHVk97JXxoCVf05rrb0sgMpW9cvJ
	 68aokBcVHOpmFJeCQXrlP4QJu6xMdIvnBE5SCDk6F0e+4JKRopmhoH3cMZDmnZwOmA
	 RVgZXo2AoyViw==
Date: Mon, 19 Jan 2026 19:55:19 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Wen Gu <guwen@linux.alibaba.com>
Subject: Re: PTP framework for non-IEEE 1588 clocks
Message-ID: <2r55e3ohmijdubdwrwagmvfwhehocdqwmmbpmwz4owxpxtenwf@fgzrm3pvve4w>
References: <vmwwnl3zv26lmmuqp2vqltg2fudalpc5jrw7k6ifg6l5cwlk3j@i7jm62zcsl67>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <vmwwnl3zv26lmmuqp2vqltg2fudalpc5jrw7k6ifg6l5cwlk3j@i7jm62zcsl67>

On Mon, Jan 19, 2026 at 02:59:02PM +0530, Manivannan Sadhasivam wrote:
> Hi Jakub et al.,
> 
> This is a follow-up of the recent discussion [1] around using PTP framework for
> device clocks which doesn't the follow IEEE 1588 standard, but just provide the
> high precision clock source to the host machine for time synchronization.
> 
> Jakub raised the concern on exposing these kind of high precision clocks as PTP
> clocks during the referenced patch review and also during [2]. I agree that the
> concern is technically valid as these clock are not following the IEEE 1588
> standard.
> 
> I then looked into the existing PTP drivers and noticed that many drivers like
> ptp_kvm, ptp_vmclock, and ptp_s390 fall into the above category. But that could
> be because no one cared about them being non-conformant so far. So I'm not using
> them as an excuse.
> 
> Then I looked into creating a new framework which just registers as a simple
> posix clock and supporting posix_clock_operations::clock_getres operation as a
> start. However, it feels like it would be a stripped down version of PTP
> framework, with a new class, and chardev interface.
> 
> Creating such new interfaces means, we should also teach the tools like phc2sys
> (for -a option) to learn about this new interface/class.
> 
> So my question is, is it really worth the effort to create a new framework for
> providing a subset of the existing framework's functionality? Even if such
> framework gets introduced, should the existing non-IEEE 1588 drivers be
> converted? I personally think it is not a good idea since that will break the
> userspace tooling, but leaving them as is could also induce confusion.
> 
> I'm looking for other suggestions as well, thanks!
> 

Just found this thread which discusses the same problem:
https://lore.kernel.org/all/0afe19db-9c7f-4228-9fc2-f7b34c4bc227@linux.alibaba.com/

I'll chime into it and this thread can be ignored, thanks!

- Mani

-- 
மணிவண்ணன் சதாசிவம்

