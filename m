Return-Path: <netdev+bounces-104239-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6016290BB63
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 21:50:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17E642856D4
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 19:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC869188CDE;
	Mon, 17 Jun 2024 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kq1qgEuF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B24D53E;
	Mon, 17 Jun 2024 19:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718653798; cv=none; b=JrF9NO4wlSCos/mepmZKjRT/3QUp8jXEkMRV8wdk43bIF9SuYU8aJG+Vum9FTBgPgOjfVETOh+Jz2RR0maSrqfv55P7FQJeeZd98zZx9DqzOLs5desjyvXKNAYNk/EUaMsxecWj4SZFhsbDb4mVEi2Phju7dcUrV1XvtpbSeGZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718653798; c=relaxed/simple;
	bh=5NIgnbUFM1+PrOJ60r8IgF7BZQd0mHyp5RnS6Y72WEk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArXTJ1/KpfOpWHs04gxmvGaZz+fvUp6Krk26fqGbCx3/MwVcWYcWoAX9pmgz3TQ77ssqPrItAjx2OQ0KhBl2JGvKRsYVW4sibWbcpT4RbQwTRQSQRMNfFnUmrwcjm/PpujeauLO9xs1Sr8iSBTeXJ3aCTtNEH7YrexN2f6v7Zf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kq1qgEuF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07058C2BD10;
	Mon, 17 Jun 2024 19:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718653798;
	bh=5NIgnbUFM1+PrOJ60r8IgF7BZQd0mHyp5RnS6Y72WEk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kq1qgEuF6cLKPDMIZA2H84uNE++wSDMrqUymEpzT++7NAQmZ4vMR2nM6Vb/hm5OqB
	 EgFgFS8zB74swq8D56N5YXK7D9971IGl1zVJqtXMllIoqiUaE1S59MKKHRHQ+l/XMO
	 HNhOxa9E6rG2Ny4rifsO4RKjRJTJvf2Dt77193x3tRnQw3r0hrfTK7DwDICC6stDq3
	 1Bz+LBpNBE1fki6D0rYVZGbhhCJD5uQsa+h+FxpHqAmf52dDqf78hU2JerfqX2khxI
	 0dqR6l1rap0bjrKVLosTNS6cPL39j30/IE04U7jvLN3+eB08cRIFkUzfRvk2l88Fxn
	 ib1BoV6KQIXDg==
Date: Mon, 17 Jun 2024 20:49:53 +0100
From: Simon Horman <horms@kernel.org>
To: Markus Elfring <Markus.Elfring@web.de>
Cc: Geetha sowjanya <gakula@marvell.com>, netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Hariprasad Kelam <hkelam@marvell.com>,
	Subbaraya Sundeep Bhatta <sbhatta@marvell.com>,
	Sunil Goutham <sgoutham@marvell.com>
Subject: Re: [net-next PATCH v5 02/10] octeontx2-pf: RVU representor driver
Message-ID: <20240617194953.GA8447@kernel.org>
References: <20240611162213.22213-3-gakula@marvell.com>
 <ac47a370-99ca-4fb9-8fb0-800894d04c57@web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ac47a370-99ca-4fb9-8fb0-800894d04c57@web.de>

On Sat, Jun 15, 2024 at 05:11:53PM +0200, Markus Elfring wrote:
> > This patch adds basic driver for the RVU representor.
> …
> 
> Please improve such a change description with imperative wordings.
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/submitting-patches.rst?h=v6.10-rc3#n94
> 
> Can an adjusted summary phrase become also a bit more helpful?
> https://elixir.bootlin.com/linux/v6.10-rc3/source/Documentation/process/maintainer-tip.rst#L124
> 
> 
> …
> > +static int rvu_get_rep_cnt(struct otx2_nic *priv)
> > +{
> …
> > +	mutex_lock(&priv->mbox.lock);
> > +	req = otx2_mbox_alloc_msg_get_rep_cnt(&priv->mbox);
> …
> > +exit:
> > +	mutex_unlock(&priv->mbox.lock);
> > +	return err;
> > +}
> …
> 
> Would you become interested to apply a statement like “guard(mutex)(&priv->mbox.lock);”?
> https://elixir.bootlin.com/linux/v6.10-rc3/source/include/linux/mutex.h#L196
> 
> 
> …
> > +++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.h
> > @@ -0,0 +1,31 @@
> …
> > +#ifndef REP_H
> > +#define REP_H
> …
> 
> Can unique include guards be more desirable also for this software?

As Andrew Lunn said eleswhere [1]:

"We decided for netdev that guard() was too magical, at least for the
 moment. Lets wait a few years to see how it pans out. scoped_guard()
 is however O.K."

[1] https://lore.kernel.org/netdev/f2ddbeaa-e053-467f-96d2-699999d72aba@lunn.ch/

