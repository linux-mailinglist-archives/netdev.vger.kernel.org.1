Return-Path: <netdev+bounces-69552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C49DA84BA73
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 16:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F196A1C21253
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 15:59:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0766134728;
	Tue,  6 Feb 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LhDpF+G0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD01413341F
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 15:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235192; cv=none; b=D0dp9U+cr5WNRS8B/ROmyCOHuQjjIPGJ55NBKU8c6RKXTUxVaA/qk+afjDXlG5HhTm46x8ZS1i0H0jSruAoB4eN/KlqNv+JcFf6D4Zyemxr5zVdbr8byG93s+HFULbsCw+XdfTKsbyi6uv4t9WL2+7X8QbmQfJn4DjwBaUR7vQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235192; c=relaxed/simple;
	bh=32KB6u1MvBiIQXwa7L+IVb9iuiu9qY6aj1TsFQ1vchw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nctUY3PE3uhiaj9zNKnPxxBRLsOoGjFCQTBcSTIfpZAq1Opjq1Mdt7U1IiDKrKN/ZTyL523ClEiqe3aqGNAxK6MZ4sov/AU6Mm33mpPKNnwEEoJRN147LqeWq941+BKafl0UL6rWkqPYa2wERttcwnoBJFSNOUPiBLjvXkdw5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LhDpF+G0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEA74C433F1;
	Tue,  6 Feb 2024 15:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707235192;
	bh=32KB6u1MvBiIQXwa7L+IVb9iuiu9qY6aj1TsFQ1vchw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=LhDpF+G0OC8iBlGD8HjZbAF0XKxWTc8TZhugPP1J9C1thM7xC51s6AltlEQQgarGl
	 B9mYQSaiFsm1KOyCwNh08JAvYSnzqBal+7KULBUYGasVzhw52baZgwv8g+H8Ceug6z
	 CihK3vpvVpVZrQCsxyotZis5yLVGBKi9ltOUgaY82v7QQ08GneQqku4iIuJslZcVrW
	 +w9sSOVbYbFoPWUK1JwlwVpDCxzz18vp6RrXv4Lpo/umgzLeTArXQ2t1i5yZr1Li8u
	 aHj7XHJBeTw6fVbXxTnApwSkKKML8shiva8suB99kW3HeB/IopECFFMyVEM2R4r9i4
	 lXURpfOTwOrRA==
Date: Tue, 6 Feb 2024 07:59:50 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Victor Nogueira <victor@mojatatu.com>
Cc: jhs@mojatatu.com, xiyou.wangcong@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
 kernel@mojatatu.com, pctammela@mojatatu.com
Subject: Re: [PATCH net-next] selftests: tc-testing: add mirred to block tdc
 tests
Message-ID: <20240206075950.47d0bdc7@kernel.org>
In-Reply-To: <4342ac71-105f-4ed4-83b7-ede3ab7255f2@mojatatu.com>
References: <20240202020726.529170-1-victor@mojatatu.com>
	<20240202210025.555deef9@kernel.org>
	<b45bdefe-ee3b-4a07-a397-0b2f87ca56d3@mojatatu.com>
	<20240204083325.41947dbd@kernel.org>
	<4342ac71-105f-4ed4-83b7-ede3ab7255f2@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 5 Feb 2024 13:28:22 -0300 Victor Nogueira wrote:
> > We merge iproute2 into iprout2-next locally and build the combined
> > thing, FWIW. I haven't solved the problem of pending patches, yet,
> > tho :( If the iproute2-next patches are just on the list but not
> > merged the new tests will fail.  
> 
> In this case both were merged into -next trees. It's just the executor
> that needed fixing.
> For features merged into net-next but not yet in iproute2-next perhaps
> nipa can be used to catch such issues?
> Should I resend the patch now that the executor is fixed?

Sorry for the delay, I spent too much time migrating workers yesterday
to look at the list.

No need to resend, I'll revive it in patchwork. At least for now contest
keeps retesting the patches so we'll see in ~4h if all is good now.

About catching iproute - yes, we could so something similar to what we
do with netdev patches. Gather everything up from the list. Do basic
sanity checking of the patches. And make a "testing" version of
iproute2. A matter of having the time to do it :( Maybe the iproute2
maintainers would be willing to help?... :)

