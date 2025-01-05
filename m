Return-Path: <netdev+bounces-155277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 466DAA01A99
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 17:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 264D4163848
	for <lists+netdev@lfdr.de>; Sun,  5 Jan 2025 16:33:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23A014A4CC;
	Sun,  5 Jan 2025 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hpqIWWae"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E4E146D45;
	Sun,  5 Jan 2025 16:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736094789; cv=none; b=uVWPgvftxWxe4X7A7g/+TfRVH/RnhprCUg+umCqG6gnlTOn5Eav1GPyAwPM0QVO/AWSbG9jDVUNJrl2V9R/jOOqjuEM6xkymZPGOSwFgeH0ti800jvFLVMLuSI+g0ycdjYUADrrehBWZW7lsVYzP/a4zN6jKzPLk6W1xw4fo2vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736094789; c=relaxed/simple;
	bh=1TT9MFzG8y8zLjlA7kz6VyX27X5YGdCoe1/DBy9rf8w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ibzbYd9zNVN9sPh9lDUkpPmvjOUoLpe5ycFGuh2up4oi6c+Gdi/H3RSb38EkpmzywxD7OvM3GR4t0Uu64wX6C0MWuvejW54+na8bSdgkUgETnUAMe9jsCInxVJV1oziid0PnrTFKMcKSCIcV9oFfpAufQm7ATfA3zmGpK6Qj26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hpqIWWae; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1IPdA5NHIbkiQpFN/Tqj7vE6y9ublZ/bcEZ8rd8gF10=; b=hpqIWWaemeKQjK++tPxayQhlPK
	rRBgHIcC4Odwss42UrP9Xp8goXLZxR4OxLXXiYS/18Dojl8WkEdMMXL0XcG88fi4b6+XBOgpD/bPP
	WHXeqzHhJIDXEmJjgg+FojFqBCBF+aRTA0LPTpFhzaErLXdJZA/AfLdAKOL+Whj7a6aw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1tUTYf-001cPf-Iq; Sun, 05 Jan 2025 17:32:57 +0100
Date: Sun, 5 Jan 2025 17:32:57 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Gur Stavi <gur.stavi@huawei.com>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"Gongfan (Eric, Chip)" <gongfan1@huawei.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	"Guoxin (D)" <guoxin09@huawei.com>,
	shenchenyang <shenchenyang1@hisilicon.com>,
	"zhoushuai (A)" <zhoushuai28@huawei.com>,
	"Wulike (Collin)" <wulike1@huawei.com>,
	"shijing (A)" <shijing34@huawei.com>,
	Meny Yossefi <meny.yossefi@huawei.com>
Subject: Re: [PATCH net-next v03 0/1] net: hinic3: Add a driver for Huawei
 3rd gen NIC
Message-ID: <9bf9c069-9a7a-4c43-b6c1-58dccd2d29f4@lunn.ch>
References: <cover.1735735608.git.gur.stavi@huawei.com>
 <20250102085351.3436779b@kernel.org>
 <a8b81321186545708b8babf1805ae7ef@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8b81321186545708b8babf1805ae7ef@huawei.com>

On Sun, Jan 05, 2025 at 07:30:26AM +0000, Gur Stavi wrote:
> > On Wed, 1 Jan 2025 15:04:30 +0200 Gur Stavi wrote:
> > 
> > :(
> > 
> > This two docs are required reading:
> > 
> > https://docs.kernel.org/next/maintainer/feature-and-driver-
> > maintainers.html
> > https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
> > 
> > Please read the mailing list. You posted the patches when net-next was
> > closed.
> 
> OK. Sorry.
> But torvalds/linux.git was at rc5.
> And now it is indicated as open: https://netdev.bots.linux.dev/net-next.html
> Was net-next closed for the holidays?

That suggests you are not subscribed to the netdev mainline list and
reading emails sent to the list. It was announced a couple of times
that it would be closed over the holidays.

But more importantly, if you are not subscribed to the list, you are
likely not reading review comments other drivers similar to your gets,
and so you are likely making the same errors, wasting both reviewer
and your own time. Please send at least 15 minutes a day reading
emails sent to the list. You should easily get the time back from what
you learn.

	Andrew



