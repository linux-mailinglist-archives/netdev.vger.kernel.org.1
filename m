Return-Path: <netdev+bounces-43727-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 506307D4518
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 03:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8FA6CB20CE5
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 01:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEBFA6D18;
	Tue, 24 Oct 2023 01:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SOyH7efY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C84F10F9;
	Tue, 24 Oct 2023 01:44:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4E4C433C8;
	Tue, 24 Oct 2023 01:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698111853;
	bh=/7ntvOk9KP3fgp3YkJ+a78kzReT49ZO9GN9THWghNYU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SOyH7efY0sQcMyJJwYeTeF9H9n1EMKg7/X/X3D7Ov1phG7QhqdHJZ/zuaxXJHNvut
	 /cJVLvSNmbi3GqT6gWvF7oZVppHOYtoJgawYUtGjROQVxLU1jsTv49urQpTDmk6Y8E
	 n6gmEi10ZN6xj5FprY1R4dRRsc737b8Nj4SAk21YSZc8a6iyJ6Vrm3MJkW3oRSBI3l
	 clnWna1cnjKnbVXiLItzazRvmoSKVg+tZAMx22hXo/IWVMZ7TSj0DlrHGkCOTkr2cD
	 V6OvL5BxMlNgSKQA4nx+HLOzNMDSUbExW292koCZojLVzoiO5orVG6p9q8LThW1g6m
	 J0isg+8LmC/nw==
Date: Mon, 23 Oct 2023 18:44:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Philip Li <philip.li@intel.com>
Cc: "Nambiar, Amritha" <amritha.nambiar@intel.com>,
 <oe-kbuild-all@lists.linux.dev>, kernel test robot <lkp@intel.com>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>
Subject: Re: [net-next PATCH v5 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Message-ID: <20231023184411.73919423@kernel.org>
In-Reply-To: <ZTcXtklgqYXfoSce@rli9-mobl>
References: <169767396671.6692.9945461089943525792.stgit@anambiarhost.jf.intel.com>
	<202310190900.9Dzgkbev-lkp@intel.com>
	<b499663e-1982-4043-9242-39a661009c71@intel.com>
	<20231020150557.00af950d@kernel.org>
	<ZTMu/3okW8ZVKYHM@rli9-mobl>
	<20231023075221.0b873800@kernel.org>
	<ZTcXtklgqYXfoSce@rli9-mobl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Oct 2023 09:02:46 +0800 Philip Li wrote:
> > I understand and appreciate the effort. 
> > 
> > I think that false positive has about a 100x the negative effect of a
> > true positive. If more than 1% of checkpatch warnings are ignored, we
> > should *not* report them to the list. Currently in networking we fully
> > trust the build bot and as soon as a patch set gets a reply from you it
> > gets auto-dropped from our review queue.  
> 
> Thanks for the trust. Sorry I didn't notice the false checkpatch report leads
> to trouble. From below info, may i understand networking already runs own
> checkpatch? Also consider the checkpatch reports from bot still contains quite
> some false ones, probably we can pause the checkpatch reporting for network
> side if it doesn't add much value and causes trouble?

Yes, correct, we already run checkpatch --strict on all patches.

If you have the ability to selectively disable checkpatch for net/ and
drivers/net, and/or patches which CC netdev@vger, that'd be great!


FWIW we have a simple dashboard reporting which checks in our own
local build fail the most: https://netdev.bots.linux.dev/checks.html
Not sure if it's of any interest to you, but that's where I got the
false positive rate I mentioned previously.

> > And the maintainer is not very receptive to improvements for false
> > positives:
> > https://lore.kernel.org/all/20231013172739.1113964-1-kuba@kernel.org/  
> 
> I see. We got this pattern as well, what we do now is to maintain the pattern
> internally to avoid unnecessary reports (some are extracted below). I'm looking
> for publishing these patterns later, which may get more inputs to filter out
> unnecessary reports.
> 
> == part of low confidence patterns of checkpatch in bot ==

Interesting!

> __func__ should be used instead of gcc specific __FUNCTION__

This one I don't see failing often.

> line over 80 characters

This one happens a lot, yes.

> LINUX_VERSION_CODE should be avoided, code should be for the version to which it is merged

This is very rare upstream.

> Missing commit description - Add an appropriate one

Should be rare upstream..

> please write a help paragraph that fully describes the config symbol

This check I think is semi-broken in checkpatch.
Sometimes it just doesn't recognize the help even if symbol has it.
So yes, we see if false-positive as well.

> Possible repeated word: 'Google'

Yes! :)

> Possible unwrapped commit description \(prefer a maximum 75 chars per line\)

This one indeed has a lot of false positives. It should check if
*majority* of the commit message lines (excluding tags) are too long,
not any single line. Because one line can be a crash dump or a commit
reference, and be longer for legit reasons..

Every now and then I feel like we should fork checkpatch or start a new
tool which would report only high-confidence problems.

> > > But as you mentioned above, we will take furture care to the output
> > > of checkpatch to be conservative for the reporting.  
> > 
> > FWIW the most issues that "get through" in networking are issues 
> > in documentation (warnings for make htmldocs) :(  
> 
> Do you suggest that warnings for make htmldocs or kernel-doc warning when building
> with W=1 can be ignored and no need to send them to networking side?

No, no, the opposite! Documentation is one part we currently don't test,
even tho we should.

Do you run make htmldocs as part of kernel build bot? As you allude to -
W=1 checks kdoc already, and scripts/kernel-doc can be used to validate
headers even more easily. But to validate the ReST files under
Documentation/ one has to actually run make htmldocs (or perhaps some
other docs target), not just a normal build.

