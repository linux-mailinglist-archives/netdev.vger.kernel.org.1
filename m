Return-Path: <netdev+bounces-202421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CC08AEDCDA
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 68A36162FBB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72A55272E7E;
	Mon, 30 Jun 2025 12:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c006OUHD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F50427055E
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751286828; cv=none; b=AF+kLMES35Akq/iuRs58NWymNKnofJKqcX4SySDEG7vudh7FLUx8iB+647QZemI2Sm/FpePsIyI6ocrrH2hX4ay92/k7w1hwDuii1HkqW7UcuvACMfn+SH4u89cxvuUNiBx7xYuzaSm7a7KdmEhyLJy36+K1D+1IJGR8vjO3FXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751286828; c=relaxed/simple;
	bh=lWx477b3aS/bCZ80oR6WdG0Z7UZ3/L6XDp8iWXWoT2k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E0HgpmFRFmZDY/csFIrQbGHwIEutp/qX8mvHI3FX5ULz8dZgqoMp0S0dgjQgUswD9tHKYx1QTIlip1LHYOdk/oVFkTgJPZyUoxjcd+QWo3PyMFCY5E0Y6DSf48Zt32NevYKqZ2OsjnTWtdrkiVglWLO6NELOTInb3y4IRHAwYiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c006OUHD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1863BC4CEE3;
	Mon, 30 Jun 2025 12:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751286827;
	bh=lWx477b3aS/bCZ80oR6WdG0Z7UZ3/L6XDp8iWXWoT2k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=c006OUHDe15HrTQomI81/5Q7Yh/YkcmevtwrQIBZABK0skKqtI11mISDjBjYJnxDF
	 hKJ1M6KlhDkd2Zc5TtIKhhlNj5AVYNmoglHJuWqeZFLKnZ285dTQnrba7OhXNitZT1
	 q/hhIPoxblGxx9AoFR61QMGzqSfSe2DToQW2eh38c71gFF3uXmxgmDHpqNQ++sYD0o
	 s9q0VSjFb9z9syKKRX2S+7EDS81wj7KrFOm+9e3rhjTe90NZWQXt0Etk9/sWxeBV88
	 K8mYmk9twGchrH1T0tA58z6DYsXVu8qNfyXYWELy/5oG7WZxYFooP4L1WXA/FqU1/D
	 g/bBc3F6akpTQ==
Date: Mon, 30 Jun 2025 13:33:42 +0100
From: Simon Horman <horms@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: Igor Russkikh <irusskikh@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexander Loktionov <Alexander.Loktionov@aquantia.com>,
	David VomLehn <vomlehn@texas.net>,
	Dmitry Bezrukov <Dmitry.Bezrukov@aquantia.com>,
	Pavel Belous <Pavel.Belous@aquantia.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: atlantic: Rename PCI driver struct to end in _driver
Message-ID: <20250630123342.GF41770@horms.kernel.org>
References: <20250627094642.1923993-2-u.kleine-koenig@baylibre.com>
 <20250627194752.GE1776@horms.kernel.org>
 <kkqutqwaydubjuypkxsa52ynljn5av3zkrgn7tix3fleql7mbk@ltk4dqtbaltt>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <kkqutqwaydubjuypkxsa52ynljn5av3zkrgn7tix3fleql7mbk@ltk4dqtbaltt>

On Fri, Jun 27, 2025 at 11:18:45PM +0200, Uwe Kleine-König wrote:
> Hello Simon,
> 
> On Fri, Jun 27, 2025 at 08:47:52PM +0100, Simon Horman wrote:
> > On Fri, Jun 27, 2025 at 11:46:41AM +0200, Uwe Kleine-König wrote:
> > > This is not only a cosmetic change because the section mismatch checks
> > > also depend on the name and for drivers the checks are stricter than for
> > > ops.
> > > 
> > > However aq_pci_driver also passes the stricter checks just fine, so no
> > > further changes needed.
> > > 
> > > Fixes: 97bde5c4f909 ("net: ethernet: aquantia: Support for NIC-specific code")
> > 
> > From a Networking subsystem point of view
> > this feels more like an enhancement than a bug fix.
> > Can we drop the Fixes tag?
> 
> I think it's right to include it, but I won't argue if you apply the
> patch without it.

For Networking we generally use Fixes tags for bug fixes,
which in general address some adverse user-visible behaviour,
e.g. a panic.

Of course there is always room for interpretation. But based
on my understanding of this patch I would lean towards it
not being a bug fix. Again, in the sense that bug fix is usually
used for networking patches.

So I would suggest:

1. Target the patch (and others like it) at net-next

   Subject: [PATCH net-next] ...

2. Don't include a Fixes tag

3. Optionally refer to the patch that introduced the problem by
   using the following in the commit message.

   commit 97bde5c4f909 ("net: ethernet: aquantia: Support for NIC-specific
   code")

Thanks in advance for taking my opinion into consideration.

