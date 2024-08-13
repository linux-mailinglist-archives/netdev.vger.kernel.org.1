Return-Path: <netdev+bounces-117936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64B6994FF21
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 09:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0F8D51F239A3
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 07:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1384374063;
	Tue, 13 Aug 2024 07:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEibMMuV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB04E6A8CF;
	Tue, 13 Aug 2024 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723535696; cv=none; b=TudOAy0KgnyN4TWgNsAz2xLjwDWQMkO3vJ/arptRHgrZxnQdVPf3Zctejy/+d7JIHZZxMMoE90DHK8HdXbsHF84yRrBlOBhWbqqLOjHRJ0qNE+to49Lf/jGEY6QHj2vmZ3JfWaqwmha80ReGR8DDV4zG8Pn3u0m+z05wC5Mmp98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723535696; c=relaxed/simple;
	bh=JMexyEjzpDVP3exsaAJ7lAArphW213MfMgEoG6MQDyc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DbGwVBVRXYaJAEP1yAhrMDMm6VO/VfJlNuI4hjO7eLNnPAi24kgRFR4t8UGSpAMTSRBQt0WWuvbFVba47s5VKXo8FbuOvLaWsp11/EuHnETDDot6yZPSux9Jzy4kCLNu20VVTsakJWwuF+17wU78KYd2FajuuWFo+c2o2dH4aDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEibMMuV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2139FC4AF09;
	Tue, 13 Aug 2024 07:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723535695;
	bh=JMexyEjzpDVP3exsaAJ7lAArphW213MfMgEoG6MQDyc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KEibMMuVG0HpUTL9TZEXMSKoFKpxdYXJ43R1VDH+jzu+9mi2eo5GcgFQD2t9XwoBM
	 K1oXzrjGePzxlYgjEWiY4WM/CiCbUaP1KBQsGaH6IQ7IlfuoW5lYrar1RklxNG9kB6
	 JZJTYoDuwIgios4Exh1wm40wtlyvDVuN9C1u/5XLHKtD8tvHlpfwhIpF5cFhIvTCNS
	 wqgTFskxlvMLrZZ9jtt4FTJ+4qOzIIyNCsWJWwCL4buFamHhtHRj3xWWsz+2oZzzhu
	 4DCseTtgL3ivxFp89l2FSCa70DnJugyz3aWqop4d3ERL2NS6OQPaRHfTL4p4ed00QO
	 zigBTP0QIs+dw==
Date: Tue, 13 Aug 2024 08:54:50 +0100
From: Simon Horman <horms@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, vburru@marvell.com, sedara@marvell.com,
	srasheed@marvell.com, sburla@marvell.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: octeon_ep_vf: use ethtool_sprintf/puts
Message-ID: <20240813075450.GD44433@kernel.org>
References: <20240809044738.4347-1-rosenp@gmail.com>
 <20240812124224.GA7679@kernel.org>
 <CAKxU2N-m7SSTxuWQUuMH6E8FnF0RXGUMPepA=DunoZsvzJ-ahg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKxU2N-m7SSTxuWQUuMH6E8FnF0RXGUMPepA=DunoZsvzJ-ahg@mail.gmail.com>

On Mon, Aug 12, 2024 at 10:04:51AM -0700, Rosen Penev wrote:
> On Mon, Aug 12, 2024 at 5:43 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Thu, Aug 08, 2024 at 09:47:27PM -0700, Rosen Penev wrote:
> > > Simplifies the function and avoids manual pointer manipulation.
> > >
> > > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> >
> > Thanks,
> >
> > The code changes look good to me and my local testing shows that it compiles.
> > So, from that point of view:
> >
> > Reviewed-by: Simon Horman <horms@kernel.org>
> >
> > But I do have a few points about process, which I hope you will
> > give due consideration:
> >
> > 1. It would be good if the patch description was a bit more verbose.
> >    And indicated how you found this problem (by inspection?)
> >    and how it was tested (compile tested only?).
> Right. This is just an API change. There should be no actual change in
> functionality.

Right, but adding this kind of information to the commit message
is useful.

> >
> >    This helps set expectations for reviewers of this patch,
> >    both now and in the future.
> >
> > 2. You have posed a number of similar patches.
> >    To aid review it would be best to group these, say in batches of
> >    no more than 10.
> I plan to do a treewide commit with a coccinelle script but would like
> to manually fix the problematic ones before doing so. Having said that
> I still need to figure out how to do a cover letter...

I suggest using at b4.
Else git format-patch (to prepare) + git send-email (to send).

FWIIW, I was not suggesting a large tree-wide patchset.
But rather, groups of related patches, in batches of 10 or less.

> >
> >    F.e. Point 1, above, doesn't just apply to this patch.
> >
> > 3. Please do review the Networking subsystem process document
> >
> >    https://docs.kernel.org/process/maintainer-netdev.html
> >
> > ...
> 

