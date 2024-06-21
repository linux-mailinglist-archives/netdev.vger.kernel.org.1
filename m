Return-Path: <netdev+bounces-105502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A21891186E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:26:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B0811C21D89
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 02:26:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A979983CD4;
	Fri, 21 Jun 2024 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ldwhucw/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 854C782886
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 02:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718936767; cv=none; b=Vpqs1uFXJBi2NvooWhSH+qe+EZKItOayt4/qY2JajcmKSIqpzOwAFaWXadQPZRq1l66dcRfQbskhdcj/wMlp67YY44dmnABJ/c+4fa40MC++FLOpwOre3fvobfDtLxRmICgNgni3SQFG1WwGWgpm8Yx43wUNJVbOpiQulb1y0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718936767; c=relaxed/simple;
	bh=j3oGACMXaGA9SUsJK1N8ZxQmLFW96pmCnYnvGI4X+pg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIp4nS2i6jF0yV3Rhy+/EDERzeQKvMRTGyB35CVb7s2nkH7lNkDCbQ6Mi5haicVjVr0vhyIlpQzpCAdsGZj2hbFS7+SzDHXXhC8RA2HYphjEccVdX/7q3mLCRwZ1iP2u2ATEUhVI4DJSRZW389TNlrasnXLbEvckZ41Z9iwFyyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ldwhucw/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D868C2BD10;
	Fri, 21 Jun 2024 02:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718936767;
	bh=j3oGACMXaGA9SUsJK1N8ZxQmLFW96pmCnYnvGI4X+pg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ldwhucw/Z9gORfjrdP2IqdGJhkaV8vtc4SfxZbtVESJrONINdbhlIXmc1yZFtYitR
	 3pDom1lXFNB2/IC2XonH3PjCa9S0YB6PNIIbG8KpokjDrDf//PhM3e0NxGJMLTCdoy
	 bHKzS8KPpHIIT+HEiA+gEm65Ncr1BX2u08HS3yqCLsGG/eRq7GOw1FX8nXBK/tt4eH
	 43hqHgtYpXUrryA7WLK3ja7K5cLMvA/vWstDeZv7FOKgGEB9veiubpx8cpqxey3umr
	 hE0NVMUwI0Xs13ONA8u6V/ZAaAB3dr/Yu0QT7H+u9+/+B0DNsnfFgTE1B1WwVwJpue
	 4ewwrRxRReTWw==
Date: Thu, 20 Jun 2024 19:26:05 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, willemdebruijn.kernel@gmail.com, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next 4/4] selftests: drv-net: rss_ctx: add tests for
 RSS configuration and contexts
Message-ID: <20240620192605.3ddba920@kernel.org>
In-Reply-To: <fc0b5d42-0ab6-4ce1-b0ee-2345b4ae9b2f@davidwei.uk>
References: <20240620232902.1343834-1-kuba@kernel.org>
	<20240620232902.1343834-5-kuba@kernel.org>
	<fc0b5d42-0ab6-4ce1-b0ee-2345b4ae9b2f@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Jun 2024 18:52:21 -0700 David Wei wrote:
> On 2024-06-20 16:29, Jakub Kicinski wrote:
> > +def get_rss(cfg):
> > +    return ethtool(f"-x {cfg.ifname}", json=True)[0]  
> 
> At this point I think json=True can be the default.

for ethtool specifically I'm constantly annoyed by how many sub-commands
don't support JSON. I don't think we'll win much, and the grand plan
is to have a netlink API for all of this, and switch to YNL calls.

> > +    cnts = _get_rx_cnts(cfg)
> > +    GenerateTraffic(cfg).wait_pkts_and_stop(20000)
> > +    cnts = _get_rx_cnts(cfg, prev=cnts)
> > +    # First two queues get less traffic than all the rest
> > +    ksft_ge(sum(cnts[2:]), sum(cnts[:2]), "traffic distributed: " + str(cnts))  
> 
> Do you need to check the number of queues? If it's 3 then would this
> check potentially fail?

Yeah, I lazy'd out, because ethtool -l doesn't support JSON! Ugh.
At least on my machine. I'll add the check base on qstat, like I did
in one of the later tests.

> > +        for i in range(ctx_cnt):
> > +            cnts = _get_rx_cnts(cfg)
> > +            GenerateTraffic(cfg, port=ports[i]).wait_pkts_and_stop(20000)
> > +            cnts = _get_rx_cnts(cfg, prev=cnts)
> > +
> > +            ksft_lt(sum(cnts[ :2]), 10000, "traffic on main context:" + str(cnts))  
> 
> What if the host is getting significant traffic during the test?

Then IDK how to write a reasonable RSS test :) Hopefully 10k compared
to the 20k of iperf is pretty safe, but we'll find out...

> > +            ksft_ge(sum(cnts[2+i*2:4+i*2]), 20000, f"traffic on context {i}: " + str(cnts))  
> 
> Is this exactly 20000?

Not sure I follow but ge means >=, iperf will probably do some more
before we manage to stop it.

> > +
> > +def test_rss_context_overlap2(cfg):
> > +    test_rss_context_overlap(cfg, True)  
> 
> Add a test case for other_ctx=0?

context 0 (i.e. the main one) will get tested when called directly.
Annoyingly ethtool userspace is a bit picky about using context 0
as an id on the command line, hence the special handling in the test.

