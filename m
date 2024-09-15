Return-Path: <netdev+bounces-128432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80BE4979844
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 20:54:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27C692819CD
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 18:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C3751C9EAF;
	Sun, 15 Sep 2024 18:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etcimiXV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D1B72F4A;
	Sun, 15 Sep 2024 18:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726426469; cv=none; b=X/QovDyot+okOpNDVzWPGCnJf22T9CVnt6gwyzz8WChJ6sUXx+rD6V9Rl74VGgszkyIhIF/FTVeZ2ajEJVsDUPP4snZSghdUpOLbfk3aP4Ap15pXIyM2s/sM7uDstAXgjStduI4oKp38ZLP04mkQqZzyARuvjtyObTeHKsXv/FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726426469; c=relaxed/simple;
	bh=pfLZOzjVjqNtgo0760JxrtNFaBbwHp1bnKllewt8L0Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cc3bl865uSUgFOs0mBLCeLUoQM0ouBIWqLa/MpzVYuIT9Mk+X5L+Urg6uheN2pxFB4a6JrXmN5ey0qoWSCb6N/8lxJJb4h2THMtGiIY1E4eho2/d4ewpt9cIMYzQiaCYemnC3I1ArUXgot5Xv+dpGvbC7SIed4M9wZsAdLss/Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etcimiXV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 852F1C4CEC3;
	Sun, 15 Sep 2024 18:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726426468;
	bh=pfLZOzjVjqNtgo0760JxrtNFaBbwHp1bnKllewt8L0Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=etcimiXV4RRxJ9mmDkV1kNHlnJLYq2vB4Ekz46lC42WI/WT5igQdmNexcbUXXx0ZX
	 e1NlW3sdp+ZGZUTSF79EaighuEENLeY/iE8DBqqRZb+46OhRjAH85aZ8/4zaLdx49m
	 qOTlW7z5bjJXcAomuy4e3YAGn6oygvBXI49POmOQiXbEQgox6RWmluw4dLBCVPWnyP
	 PL1k7iOj2GhwdDGqOn8W2vlH4cIO3QjX9Dq5QQGsUQiOCoGBU0YCxUbPBuM17noPwH
	 hlubj1WNL8ZaT6l5iTwS4UorYDLxcRRZPupiHhkKS+hYY+sxUx0KBm2sMOt/MtZgYv
	 A39C7Gp6oPizA==
Date: Sun, 15 Sep 2024 19:54:25 +0100
From: Simon Horman <horms@kernel.org>
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: Alexander Zubkov <green@qrator.net>, pabeni@redhat.com,
	linux-kernel@vger.kernel.org, linux-newbie@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH] Fix misspelling of "accept*"
Message-ID: <20240915185425.GD167971@kernel.org>
References: <20240622164013.24488-2-green@qrator.net>
 <Zncwl4DAwTQL0YDl@gallifrey>
 <CABr+u0b-RAV9hz25O5a3Axz6s9vYLVc5shr8xAgPsykP_XRFgw@mail.gmail.com>
 <ZucKZcwmd28S_t24@gallifrey>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZucKZcwmd28S_t24@gallifrey>

On Sun, Sep 15, 2024 at 04:25:09PM +0000, Dr. David Alan Gilbert wrote:
> * Alexander Zubkov (green@qrator.net) wrote:
> > Hi,
> > 
> > I just wanted to kindly check in on the status of my patch. Please let
> > me know if any further action is needed from my side.
> > 
> > Thanks for your time!
> 
> I was only a reviewer on this; it'll need some of the netdev people
> to notice it for it to get further.

Hi,

Firstly I would suggest splitting the drivers/infiniband change into
a separate patch and sending it to the relevant Infiniband maintainers.
./scripts/get_maintainer.pl will help you find them.

And then posting what as left as a patch for net-next.
For guidance on that please see:
https://docs.kernel.org/process/maintainer-netdev.html

net-next is currently closed, as the merge window is open.
So you will need to wait until net-next reopens before posting
your patch for net-next. That will happen after v6.12-rc1
has been released, most likely a little over two weeks from now.

...

