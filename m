Return-Path: <netdev+bounces-116147-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A410E949463
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 17:22:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63AE7288627
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567ED1799B;
	Tue,  6 Aug 2024 15:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RofHcO+1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE22AE90
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 15:22:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722957723; cv=none; b=T2F1haN+Y7ePmMow4XY5b7SPuv8ad8nYaZqFVQR/NcZnJVGTilomLu46eRYD+hINtgUU6ydpV8+jXdc7MagXKhBtQDyWK/XGjedUsz9jNNTBty5rHf/jZTxnXJkRoJQtYSxYSbOilPUyOVjusvmaM3OcNdERIa8uHgFu2SNF5WQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722957723; c=relaxed/simple;
	bh=CBb0eaN4TE+QDnqSpzr0kfw6IPFa55GuKRu5iD9ELuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a88URS71YPUKygo7pFoI6upRnuuz2WvejH4YUyyfRYWO6SjVAYkYYwD387XEivBu8K0vVH+eJFfPEsD3n00CzcROsN4NtGgaCLPiAqAGJD72zwH0gzUwF83g10wlpwEaMmthib4SDXBvIHSgBmU+82HRqzzx6SyBfgDTleVje8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RofHcO+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0E19C32786;
	Tue,  6 Aug 2024 15:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722957722;
	bh=CBb0eaN4TE+QDnqSpzr0kfw6IPFa55GuKRu5iD9ELuI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RofHcO+1WA2wm1J1tSftUpoc8OP5fJSMvsxtKuaKC32Fdm6WWz4fcsr23hUPXEv7+
	 aLUDd33ICbr0UWwXO1Syl6BTitTEg9pIKQddHuAXx6HIgd40iP5WbC+5eHzJxqjqcg
	 po3OTPBjfwOFFfDo50xRXYnO4zJkLckkjnvvcOkNqYVqZuSmjm1lZOtl77aP7XvjwN
	 kO2sLGMpbvAn7yAGpwMkBnNkM7Og0NcPZObHtMXEgCeitvPI0xs3kmgxN+THk/BAFs
	 UvdSIYYGM+Elcyii4GtFexRjcStl6EJAxz1ytNqo3BOKTolP5/kX7f+HEUGeq9DPKR
	 nQfaV0qzJXiNg==
Date: Tue, 6 Aug 2024 16:21:58 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	Jiri Pirko <jiri@resnulli.us>,
	Madhu Chittim <madhu.chittim@intel.com>,
	Sridhar Samudrala <sridhar.samudrala@intel.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Sunil Kovvuri Goutham <sgoutham@marvell.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>
Subject: Re: [PATCH v3 08/12] testing: net-drv: add basic shaper test
Message-ID: <20240806152158.GZ2636630@kernel.org>
References: <cover.1722357745.git.pabeni@redhat.com>
 <75fbd18f79badee2ba4303e48ce0e7922e5421d1.1722357745.git.pabeni@redhat.com>
 <29a85a62-439c-4716-abd8-a9dd8ed9e60c@redhat.com>
 <20240731185511.672d15ae@kernel.org>
 <20240805142253.GG2636630@kernel.org>
 <20240805123655.50588fa7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240805123655.50588fa7@kernel.org>

On Mon, Aug 05, 2024 at 12:36:55PM -0700, Jakub Kicinski wrote:
> On Mon, 5 Aug 2024 15:22:53 +0100 Simon Horman wrote:
> > On Wed, Jul 31, 2024 at 06:55:11PM -0700, Jakub Kicinski wrote:
> > > On Wed, 31 Jul 2024 09:52:38 +0200 Paolo Abeni wrote:  
> > > > FTR, it looks like the CI build went wild around this patch, but the 
> > > > failures look unrelated to the actual changes here. i.e.:
> > > > 
> > > > https://netdev.bots.linux.dev/static/nipa/875223/13747883/build_clang/stderr  
> > > 
> > > Could you dig deeper?
> > > 
> > > The scripts are doing incremental builds, and changes to Kconfig
> > > confuse them. You should be able to run the build script as a normal
> > > bash script, directly, it only needs a small handful of exported
> > > env variables.
> > > 
> > > I have been trying to massage this for a while, my last change is:
> > > https://github.com/linux-netdev/nipa/commit/5bcb890cbfecd3c1727cec2f026360646a4afc62
> > >   
> > 
> > Thanks Jakub,
> > 
> > I am looking into this.
> > So far I believe it relate to a Kconfig change activating new code.
> > But reproducing the problem is proving a little tricky.
> 
> Have you tried twiddling / exporting FIRST_IN_SERIES ?
> 
> See here for the 4 possible exports the test will look at:
> 
> https://github.com/linux-netdev/nipa/blob/6112db7d472660450c69457c98ab37b431063301/core/test.py#L124

Thanks, I will look into that.

