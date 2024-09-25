Return-Path: <netdev+bounces-129842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0CA986769
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 22:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E6881C21E2C
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:08:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65450143C7E;
	Wed, 25 Sep 2024 20:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mh2/rh7b"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F30A13DDDD
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 20:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727294880; cv=none; b=Brs3r0u+9CiyCNg6lapPbdqdQ3Ee5EbwKdYvTU8SHQeLuH4wzvvEz4keathxCPE+sHTbMJre7n098iR/pXQvRb+AOYjKg99bj85CndWIOh8djmWDyIcQbwonIuVNJmzAr/+XJELpsAdVgE2gE/Kue4yJLDBmHMyO8pEA6PymcwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727294880; c=relaxed/simple;
	bh=XS86+x9lqDEpFzu44ISj10AQbHEKIW/dHTQWJ9dhy5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s6dn7hw3jQD2+qcMZO5UHW/ZSLr9el9kPgJ7J9buXq31tRJ0RBnKUg8oVuHVK9tJ/hHwGXZHG99bDwZlafcOe8VabKmK9hpOLC6Wi9BycTpI4BK/FvandBjrO0YVi5NW6jJyQCGflwbNVusvWQlxZ7Vziw+GMGTGHrjpwirQfRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mh2/rh7b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D260C4CEC3;
	Wed, 25 Sep 2024 20:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727294879;
	bh=XS86+x9lqDEpFzu44ISj10AQbHEKIW/dHTQWJ9dhy5o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Mh2/rh7blDBd60R5hvmOMlQmpnY3qxqwAUoCZa/lanmF0J3JqKtt4tv8Y615zNhhV
	 oK0Tru5ybX+F6dhHur7P116CxzwtUY8ikJBgPOj/YGHag3ZZBHaFRMl57mGmtGwXxK
	 YkD7ednvUtPNpCBdFYSPC2IzaPeSL7+Y3tn4Lx01Lb3e9f6GPhCmmm0SZftiqetOHt
	 xfXJiN84uuUeD3F30O1wldRFvMCqNncQGYMceE0V6LNWR1ETBb6N9QwFQ08OHRaQjQ
	 hn2jtxGm+BN9kv4oyefAdkfwJyD1ShF1QRGLK1TeW8fLCUl0ISxKQBEm0MpjwXzZzn
	 6+OMLfL9SdClQ==
Date: Wed, 25 Sep 2024 21:07:56 +0100
From: Simon Horman <horms@kernel.org>
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: ethernet: Switch back to struct
 platform_driver::remove()
Message-ID: <20240925200756.GB4029621@kernel.org>
References: <20240923162202.34386-2-u.kleine-koenig@baylibre.com>
 <20240924072937.GE4029621@kernel.org>
 <3y5dni2ey2hnzie4evmklqcu4uhr72fr64m47uwzo7nnhbqzsz@7igypikspxpm>
 <20240924125347.GI4029621@kernel.org>
 <2og4furukr5fndyx3receaxr2rgao27lcuzofcvanyrt543p5p@5ckfz4373vhm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2og4furukr5fndyx3receaxr2rgao27lcuzofcvanyrt543p5p@5ckfz4373vhm>

On Wed, Sep 25, 2024 at 01:07:25PM +0200, Uwe Kleine-König wrote:
> Hello,
> 
> On Tue, Sep 24, 2024 at 01:53:47PM +0100, Simon Horman wrote:
> > On Tue, Sep 24, 2024 at 09:48:53AM +0200, Uwe Kleine-König wrote:
> > > On Tue, Sep 24, 2024 at 08:29:37AM +0100, Simon Horman wrote:
> > > > However, touching so many files does lead to a substantial risk of
> > > > conflicts. And indeed, the patch does not currently apply cleanly
> > > > to net-next (although it can trivially be made to do so). Perhaps
> > > > the maintainers can handle that, but I would suggest reposting in
> > > > a form that does apply cleanly so that automations can run.
> > > 
> > > I based it on plain next in the expectation that this matches the
> > > network tree well enough. I agree that the conflicts are not hard to
> > > resolve, but it's totally ok for me if only the parts of the patch are
> > > taken that apply without problems. I expect that I'll have to go through
> > > more than one subsystem a second time anyhow because new drivers pop up
> > > using the old idioms.
> > > 
> > > Also note that git can handle the changes just fine if you use
> > > 3-way merging:
> > > 
> > > 	uwe@taurus:~/gsrc/linux$ git checkout net-next/main 
> > > 	HEAD is now at 151ac45348af net: sparx5: Fix invalid timestamps
> > > 
> > > 	uwe@taurus:~/gsrc/linux$ b4 am -3 https://lore.kernel.org/all/20240923162202.34386-2-u.kleine-koenig@baylibre.com/
> > > 	Grabbing thread from lore.kernel.org/all/20240923162202.34386-2-u.kleine-koenig@baylibre.com/t.mbox.gz
> > > 	Analyzing 3 messages in the thread
> > > 	Analyzing 0 code-review messages
> > > 	Checking attestation on all messages, may take a moment...
> > > 	---
> > > 	  ✓ [PATCH] net: ethernet: Switch back to struct platform_driver::remove()
> > > 	    + Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com> (✓ DKIM/gmail.com)
> > > 	  ---
> > > 	  ✓ Signed: openpgp/u.kleine-koenig@baylibre.com
> > > 	  ✓ Signed: DKIM/baylibre-com.20230601.gappssmtp.com (From: u.kleine-koenig@baylibre.com)
> > > 	---
> > > 	Total patches: 1
> > > 	Preared a fake commit range for 3-way merge (77e0c079ace8..198dd8fb7661)
> > > 	---
> > > 	 Link: https://lore.kernel.org/r/20240923162202.34386-2-u.kleine-koenig@baylibre.com
> > > 	 Base: using specified base-commit ef545bc03a65438cabe87beb1b9a15b0ffcb6ace
> > > 	       git checkout -b 20240923_u_kleine_koenig_baylibre_com ef545bc03a65438cabe87beb1b9a15b0ffcb6ace
> > > 	       git am -3 ./20240923_u_kleine_koenig_net_ethernet_switch_back_to_struct_platform_driver_remove.mbx
> > > 
> > > 	uwe@taurus:~/gsrc/linux$ git am -3 ./20240923_u_kleine_koenig_net_ethernet_switch_back_to_struct_platform_driver_remove.mbx
> > > 	Applying: net: ethernet: Switch back to struct platform_driver::remove()
> > > 	Using index info to reconstruct a base tree...
> > > 	M	drivers/net/ethernet/cirrus/ep93xx_eth.c
> > > 	M	drivers/net/ethernet/marvell/mvmdio.c
> > > 	M	drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > > 	Falling back to patching base and 3-way merge...
> > > 	Auto-merging drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> > > 	Auto-merging drivers/net/ethernet/marvell/mvmdio.c
> > > 	Auto-merging drivers/net/ethernet/cirrus/ep93xx_eth.c
> > 
> > Understood, I agree the conflicts can trivially be resolved.
> > But as things stand the CI stopped when it couldn't apply
> > the patchset. And, IMHO, that is not the best.
> 
> So there is some room for improvement of said CI. It could use -3, or
> alternatively honor the "base-commit:" line in the footer of the mail.
> 
> (And yes, using net-next directly and getting the patch applied quickly
> works, too. And I understand that is most comfortable for your side. For
> my side however plain next is better as this is usually a good middle
> ground for all trees. And given that I have to track not only the 130+
> network drivers from this patch but also the 2000+ other drivers in the
> rest of the tree using net-next doesn't work so well.)

Yes, there is always room for improvement :)

Some input from the maintainers regarding their preferences would be welcome,
but I'll see about proposing something like that as patches for the CI.


