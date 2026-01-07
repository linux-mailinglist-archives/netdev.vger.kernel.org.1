Return-Path: <netdev+bounces-247854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 44AE8CFF90B
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 19:53:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2BCF931522B9
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3B67218EB1;
	Wed,  7 Jan 2026 18:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="JOA6VlzY"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BDC3A0B34
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 18:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767809145; cv=none; b=Eb7wgbacEGOFFRoP011/RPyZwWjkHAp3aTjamjt1HaTUeX4R0NOU/73ANoXgG9ADT1BJKebMuFtOTwsE8DWiwqiqaI7lUlA0NmxYWWrDMzLIuv75UXuObjHGnQHcv6WpzBBBkjbTBaobYB0B3htODxkSnw7AITRbAf/sKR4IHoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767809145; c=relaxed/simple;
	bh=GMdKGL+lo1Wiol5KwHzz4EVn6GJ27q8g8RTKuQBJJQw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q0uzkx/xXrXscHuOuccAl1bxvBQow/YkiMcr2tO5YKRgUSDTFYP1XT6SsDzs6KXPwssyQkG7EM6nqy+P8Uu1mwbrBYQoUM+AfwTHoXASeKcmn/JXGmy379fEst6lrWy0x5/I/xog1l53/AFQHBt3NNXaFpVZu5wjEqGauLmbVa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=JOA6VlzY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=KNAt+G50h7LCM6qE2xYH/Hc2M/YQ/I0AgBbeH0GsyRA=; b=JO
	A6VlzYHXgB4JBrYcNnzf1L6bJP/n9cQIZkpZy2T7bkiWCrclfAY9M6IZz1/HFA6B52gRlK4g1dZhG
	nbtJ8fQWk3THWgX3pJNljiE0jOjRl6L0j+3Y2j4UNcWufL10dywSZ2AKTMfRKBTvspMqNeOmAQ1+w
	Ti80HG4nyw8DSIA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vdXuf-001q90-FL; Wed, 07 Jan 2026 19:05:41 +0100
Date: Wed, 7 Jan 2026 19:05:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH RFC net-next] atp: drop ancient parallel port Ethernet
 driver
Message-ID: <de684fcb-0520-4e02-a49e-4e422ea13eae@lunn.ch>
References: <20260107072949.37990-1-enelsonmoore@gmail.com>
 <bb532bad-8b3b-44da-868a-5d42b45a45fd@lunn.ch>
 <CADkSEUgmpZ4z+erh_VENH0Hp8shF4xUF+Frszfj0Q4YsUnt16g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADkSEUgmpZ4z+erh_VENH0Hp8shF4xUF+Frszfj0Q4YsUnt16g@mail.gmail.com>

On Wed, Jan 07, 2026 at 09:59:53AM -0800, Ethan Nelson-Moore wrote:
> On Wed, Jan 7, 2026 at 9:47 AM Andrew Lunn <andrew@lunn.ch> wrote:
> > Please slow down. Get one patch correctly merged to learn the
> > processes. Then move onto the next. All you submissions are broken, so
> > you are just wasting everybody's time.
> 
> Hi, Andrew,
> 
> Sorry about that. Next time I will run get-maintainer and make cover
> letters for my patch series.
> Is there anything broken about the content/commit messages of my
> patches, or just the way in which I sent them?

Please take a look at:

https://docs.kernel.org/process/submitting-patches.html
https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

> What should my next steps be regarding these patches?

Work on just one patch. Worth through those two documents, fixup what
you got wrong and submit that one patch.

'b4 prep' is a good tool to use for handling patches.

    Andrew

