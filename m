Return-Path: <netdev+bounces-123484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A34B99650AD
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 22:19:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F432285357
	for <lists+netdev@lfdr.de>; Thu, 29 Aug 2024 20:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A51BA88A;
	Thu, 29 Aug 2024 20:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JqJTnbE1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6741BA87A;
	Thu, 29 Aug 2024 20:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962748; cv=none; b=fu+ajN4R8EUxlhZephcX+mcL+oGAR+XrczYbCjsU07K3s4gKNqODj+I0qHrpJeLZfXIE/ZU61q2y56+KyskD01o2iMsNn5ebJkxNf6u2MxQ045DOvXUZVYUCuebk9gkNBWyarb9D41qTws266FTpWpjubYWwZJdaQE5jv3THXc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962748; c=relaxed/simple;
	bh=r1fXWi5JakawegUeBhliylMjjt31oQsl4XIZKBSiWQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qleQXia2l8QCgUyEEwwt29gY+TpYS/Izb7/Wt4xPFJmFGPc076HHQOZOTuXxTZsv2G1RvV0ugIVzPB+/nbFQfRYSPRHnK9TGm5xwpb23qpZxWg3vnX5roPzAYYjNtcz2fICrnMjP78mjSdbEBq0z9Wkt3tmyESeSn6LB6fDJu+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JqJTnbE1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E46EC4CEC1;
	Thu, 29 Aug 2024 20:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724962747;
	bh=r1fXWi5JakawegUeBhliylMjjt31oQsl4XIZKBSiWQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JqJTnbE1b6qXiaVhV5JlaBBsAmd4NKH8+2rtSW8dP5Z9121VIelVYfXxywBToheBy
	 8wZXit4eJLrpIkp3ijv/ZE7nzsbKGUVympmia7aeIcX1cmFAqtsq5fnd5urjhRgoOf
	 Wx+VM/ryw9IKNi4b2PGAfQAfZAk6slqq+/DkSttKSfBKsiyUduHGkeXNCnkQ7yH4kC
	 CuXXeLfxLun2PQRbyMewRBSTuqKnrBs91nQ0yImmSVI/qKHrQm6j3/8TlAhusakV09
	 qWAwS4lyGNVjVWv8sIr14xZbrk0OoYUsMt24w72IEgs9YpVQIfIj0sBUpVYCIcdA2r
	 zF0gJ/LXnfI7w==
Date: Thu, 29 Aug 2024 21:19:03 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, linux@armlinux.org.uk,
	linux-kernel@vger.kernel.org, o.rempel@pengutronix.de,
	p.zabel@pengutronix.de
Subject: Re: [PATCHv2 net-next] net: ag71xx: update FIFO bits and descriptions
Message-ID: <20240829201903.GZ1368797@kernel.org>
References: <20240828223931.153610-1-rosenp@gmail.com>
 <20240829165234.GV1368797@kernel.org>
 <CAKxU2N8j5Fw1spACmNyWniKGpSWtMt0H3KY5JZj5zYaA0c69kA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N8j5Fw1spACmNyWniKGpSWtMt0H3KY5JZj5zYaA0c69kA@mail.gmail.com>

On Thu, Aug 29, 2024 at 10:47:01AM -0700, Rosen Penev wrote:
> On Thu, Aug 29, 2024 at 9:52 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Wed, Aug 28, 2024 at 03:38:47PM -0700, Rosen Penev wrote:
> > > Taken from QCA SDK. No functional difference as same bits get applied.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>

...

> > Please consider a patch to allow compilation of this driver with
> > COMPILE_TEST in order to increase build coverage.
> Is that just

Of course we should test that it works, but yes, I think so.

> 
> --- a/drivers/net/ethernet/atheros/Kconfig
> +++ b/drivers/net/ethernet/atheros/Kconfig
> @@ -6,7 +6,7 @@
>  config NET_VENDOR_ATHEROS
>         bool "Atheros devices"
>         default y
> -       depends on (PCI || ATH79)
> +       depends on (PCI || ATH79 || COMPILE_TEST)

FWIIW, I would drop the () while we are here.

>         help
>           If you have a network (Ethernet) card belonging to this class, say Y.
> 
> @@ -19,7 +19,7 @@ if NET_VENDOR_ATHEROS
> 
>  config AG71XX
>         tristate "Atheros AR7XXX/AR9XXX built-in ethernet mac support"
> -       depends on ATH79
> +       depends on ATH79 || COMPILE_TEST
>         select PHYLINK
>         imply NET_SELFTESTS
>         help
> 
> >
> > --
> > pw-bot: cr
> 

