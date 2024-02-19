Return-Path: <netdev+bounces-72955-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCD585A5ED
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 15:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1D671F254DD
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 14:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21CA1D684;
	Mon, 19 Feb 2024 14:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PnZuqt2t"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972051DDEC
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 14:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708353053; cv=none; b=p08xHpIVAbfdZKvC8o5XpMhcMWlId+ALIX4VhXYM12TZmBhJRsLdTV3LUaKO9jfMiMEBEaOWhYT+CN7IzxqMAxxQ68I7kCaZrJ/wm41PwDBXCdD7L9JOyzc8y6f0Xp4deDiY4rnVdJ1HWn4duCi2p0lmyW9YeqwKGRwzrNtWUVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708353053; c=relaxed/simple;
	bh=3bEKY7PxvNQiJ306R7BB/FafCVonFi6t6OTnNTdAkY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SlNfvN4NTejyTZx19Cq6e9zjmF+hhODBVmZFgAXnRfvwEjNwDQbpaSrZHKVV+S3E5Enl/rm+g2bbXuj1pPS2cU5hP6uJPpvRNnEd2iDiav/aAzTr/tCWLZUoOHo/wrc+e0BJP98VvPTfu5zi1lBB8KXNT5Wu9NG3mHxpoMUyQ5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PnZuqt2t; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=i/cN1QvSUO0qDU+HtuNP1v/fU6JA6R6yx8Vc9VVVxfc=; b=PnZuqt2totUMP/t8/6s8BMRSzd
	Pg8fdxqVGRrH5X8yvXXKm1yWEL5fr81QiUiOf+figSWAR8xaedrNJHRkHqtKSf2eXDkqnjBdjZqJf
	0inuYlohi4IlVt14TwQyNJMxiKLdWdzm9WU6/4kBP8p6MbQGzRhOmDzZp6bGID1m2l1g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rc4fX-008CQS-5z; Mon, 19 Feb 2024 15:30:55 +0100
Date: Mon, 19 Feb 2024 15:30:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Parthiban.Veerasooran@microchip.com
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, Steen.Hegelund@microchip.com,
	netdev@vger.kernel.org, Horatiu.Vultur@microchip.com,
	Woojung.Huh@microchip.com, Nicolas.Ferre@microchip.com,
	UNGLinuxDriver@microchip.com, Thorsten.Kummermehr@microchip.com,
	Pier.Beruto@onsemi.com, Selvamani.Rajagopal@onsemi.com
Subject: Re: [PATCH net-next v2 0/9] Add support for OPEN Alliance 10BASE-T1x
 MACPHY Serial Interface
Message-ID: <e819bb00-f046-4f19-af83-2529f2141fa6@lunn.ch>
References: <20231023154649.45931-1-Parthiban.Veerasooran@microchip.com>
 <1e6c9bf1-2c36-4574-bd52-5b88c48eb959@lunn.ch>
 <5e85c427-2f36-44cc-b022-a55ec8c2d1bd@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e85c427-2f36-44cc-b022-a55ec8c2d1bd@microchip.com>

> Hi Andrew,
> 
>  From Microchip side, we haven't stopped/postponed this framework 
> development. We are already working on it. It is in the final stage now. 
> We are doing internal reviews right now and we expect that in 3 weeks 
> time frame in the mainline again. We will send a new version (v3) of 
> this patch series soon.

Hi Parthiban

It is good to here you are still working on it.

A have a few comments about how Linux mainline works. It tends to be
very iterative. Cycles tend to be fast. You will probably get review
comments within a couple of days of posting code. You often see
developers posting a new version within a few days, maybe a week. If
reviewers have asked for large changes, it can take longer, but
general, the cycles are short.

When you say you need three weeks for internal review, that to me
seems very slow. Is it so hard to get access to internal reviewers? Do
you have a very formal review process? More waterfall than iterative
development? I would suggest you try to keep your internal reviews
fast and low overhead, because you will be doing it lots of times as
we iterate the framework.

	Andrew

