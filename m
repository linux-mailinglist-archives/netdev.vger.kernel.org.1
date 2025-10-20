Return-Path: <netdev+bounces-230923-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 46EF7BF1D53
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 16:27:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2653F4E1DB0
	for <lists+netdev@lfdr.de>; Mon, 20 Oct 2025 14:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6872F8BCB;
	Mon, 20 Oct 2025 14:27:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from angie.orcam.me.uk (angie.orcam.me.uk [78.133.224.34])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB65F2A1B2;
	Mon, 20 Oct 2025 14:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.133.224.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760970428; cv=none; b=bpHFCdcU7Oiev6w5SOIQAK5Q7ZnjYQx4ZHrhf8EUnTPRnIPqorhy1mOKEiV+1tCXa4MxYl6mVv9zh6uHjhxMUTnaKGGw1PIL4E3t/SXiEeJFyi1OK/zXEB/Lh0K3F8Oqu8pUJF9VWwBQd89nFp3RAoXIsktP4xpzAsrqcuCAC8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760970428; c=relaxed/simple;
	bh=pYq1JavfYitI+ssl6RYRoZSzLuV7OwqWcBa6ttivJrY=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=JEIU8bEpwc5aTxs/vxMsMNvY6U9/q3mSn5D0pd4OHmSJ1FcrGswwLHtW20UBXb36mYnWnFke1WEmXIuu1QIG2/UCf9N39WjPZXpm56pa3LPu4U5sxUQxr/msBpdj71RxbqMOFh5TQ1IEXLe9fdHaEjZvT1D+rTFDxaIdAOSYWSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk; spf=none smtp.mailfrom=orcam.me.uk; arc=none smtp.client-ip=78.133.224.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=orcam.me.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=orcam.me.uk
Received: by angie.orcam.me.uk (Postfix, from userid 500)
	id B2E0E92009C; Mon, 20 Oct 2025 16:27:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by angie.orcam.me.uk (Postfix) with ESMTP id AB90F92009B;
	Mon, 20 Oct 2025 15:27:03 +0100 (BST)
Date: Mon, 20 Oct 2025 15:27:03 +0100 (BST)
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
To: Ido Schimmel <idosch@idosch.org>
cc: g.goller@proxmox.com, "David S. Miller" <davem@davemloft.net>, 
    dsahern@kernel.org, edumazet@google.com, kuba@kernel.org, 
    pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org, 
    linux-kernel@vger.kernel.org
Subject: Re: Wrong source address selection in arp_solicit for forwarded
 packets
In-Reply-To: <aPZB33C-C1t1z7Dk@shredder>
Message-ID: <alpine.DEB.2.21.2510201524210.8377@angie.orcam.me.uk>
References: <eykjh3y2bse2tmhn5rn2uvztoepkbnxpb7n2pvwq62pjetdu7o@r46lgxf4azz7> <aPZB33C-C1t1z7Dk@shredder>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 20 Oct 2025, Ido Schimmel wrote:

> > I have the following simple infrastructure with linux hosts where the ip
> > addresses are configured on dummy interfaces and all other interfaces are
> > unnumbered:
> > 
> >   ┌────────┐     ┌────────┐     ┌────────┐    │ node1  ├─────┤ node2
> > ├─────┤ node3  │    │10.0.1.1│     │10.0.1.2│     │10.0.1.3│    └────────┘
> > └────────┘     └────────┘
> 
> The diagram looks mangled. At least I don't understand it.

 It's been broken by:

Content-Type: text/plain; charset=utf-8; format=flowed

Cf. Documentation/process/email-clients.rst.  Raw message contents look 
good.

 HTH,

  Maciej

