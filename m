Return-Path: <netdev+bounces-58688-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5203F817D36
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 23:24:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBA53284CC9
	for <lists+netdev@lfdr.de>; Mon, 18 Dec 2023 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D54D740B0;
	Mon, 18 Dec 2023 22:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYfW+woI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1454371470
	for <netdev@vger.kernel.org>; Mon, 18 Dec 2023 22:24:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5038CC433C7;
	Mon, 18 Dec 2023 22:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702938266;
	bh=ANYkOI2y+y0ieA3uw4Cj7QxgqGQuSFlxWwFAdyD6ZSs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AYfW+woIPc25C8ojuCBOElQgB6PuY6b1QdygEMABSEZFyULnih7QisrEpdzl7frHO
	 4eBz+4qSWh5b0QnoVs8hvSZQH5Ma7hn/V7YyWqDY0lWKi94Twnvqp/Qj3og66LJheF
	 TUjdnk0/jV/9XVLaktJkhXFt0yZSHpDVBZ70pwiT67xhWlNiOB9/eet2q4OargG4Ee
	 tr7HHE/rTXYlKGKr/2ts5JkT20EmFN6A1yH9A2/TuDn9MkrvlbDo9UrWBfXsmBUgAs
	 aGZOZZQ5C3ytWKra1micrCLzLK1062JPnb/Ixn4cZM4rVAKhDvO+4abt/lAjwXWSdx
	 21dDg64nT+uwQ==
Date: Mon, 18 Dec 2023 14:24:25 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, Davide Caratti
 <dcaratti@redhat.com>
Subject: Re: [PATCH net-next 3/3] netlink: specs: use exact-len for IPv6
 addr
Message-ID: <20231218142425.257a049f@kernel.org>
In-Reply-To: <ZX1kQQKZ7BdTAG15@Laptop-X1>
References: <20231215035009.498049-1-liuhangbin@gmail.com>
	<20231215035009.498049-4-liuhangbin@gmail.com>
	<20231215180911.414b76d3@kernel.org>
	<ZX1kQQKZ7BdTAG15@Laptop-X1>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 16 Dec 2023 16:48:01 +0800 Hangbin Liu wrote:
> On Fri, Dec 15, 2023 at 06:09:11PM -0800, Jakub Kicinski wrote:
> > On Fri, 15 Dec 2023 11:50:09 +0800 Hangbin Liu wrote:  
> > > We should use the exact-len instead of min-len for IPv6 address.  
> > 
> > It does make sense, but these families historically used min-len..
> > Not sure if it's worth changing this now or we risk regressions.  
> 
> The addr6 in mptcp.yaml also use exact-len. I don't think the IPv6 address
> could be larger than 16 bytes. So the min-len check looks incorrect.

I understand, what I'm saying is that the nla_policy before we started
using specs was buggy, so we kept the bugginess in the conversion.
But it should be fine, so we can change it now and hope for the best..

