Return-Path: <netdev+bounces-186837-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2DFAA1BBF
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 22:03:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F9A5172350
	for <lists+netdev@lfdr.de>; Tue, 29 Apr 2025 20:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D47025486D;
	Tue, 29 Apr 2025 20:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUwSxdNY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2502A1B0435;
	Tue, 29 Apr 2025 20:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745956985; cv=none; b=T7qsPjYYHnaqDezexvxbjuuYPNYr+5vdD0jSQccZzamcvKLZQvJS8fF4uPnqHhBL/VyrA4t6RBfSBJydlOIsCjL+lGBz55WOXKFIXUGmQKBMWJUug71Ccekwhk1Ti+TxWXdWZpOd630V7T3hO0MmyHZdvCEA+fDOV5BWSPqLuCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745956985; c=relaxed/simple;
	bh=G9jDjOUe7/YZ9u2bpdanDiR08N/jF3cvT/1wan+U4Kk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YRsYzdB0c44iYY81vc9BKvmllRKps2QYKFXKA3bHqHO4ZA+KxUELwjn6xMkCwPslDZ1XGPgAg//zcLQq6gzXR3pk08WI/z3d0vcwOLmonEijkcVPjS1YHZLsGOfh1MyZVTxv84aM3EzU4BGbBBGeG44lxRKdAo8M6BAfdUApanI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUwSxdNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55030C4CEE3;
	Tue, 29 Apr 2025 20:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745956984;
	bh=G9jDjOUe7/YZ9u2bpdanDiR08N/jF3cvT/1wan+U4Kk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jUwSxdNYLShsq1EGqJ7enpEJT5ctgWkxznZXT476DrGOpcBAYN/1zqBu/Bdphpz8s
	 3cMYE8oNltGU5razVxk8KWWGHW6wxyWvH2kanFO0H8yMpOKYvha3UJsN3QgLwGCSud
	 FEb8WbLwgD8Lb6GE6+rF4HYKENvUWqh+IlxJ9crUL6RWaoX52hXYf9xb4ggore4jng
	 FzHCYK9i0BpqSOatm1Pb3LprDaltn/LyfOYb7FYb7fLgUGkmLuIXA6G9DfuPlCfVjT
	 jY16p17+beUF/ClCrPhKwo4zlTUDBpJD7wHBHFdfoNFsko6YwrknIBNE6+DBDmeB1h
	 H4t6IIuu4Cz9w==
Date: Tue, 29 Apr 2025 21:03:01 +0100
From: Simon Horman <horms@kernel.org>
To: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>
Cc: Andrew Lunn <andrew@lunn.ch>, Hans-Frieder Vogt <hfdevel@gmx.net>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	kernel test robot <lkp@intel.com>
Subject: Re: [PATCH net-next v0] net: phy: aquantia: fix commenting format
Message-ID: <20250429200301.GR3339421@horms.kernel.org>
References: <20250428214920.813038-1-aryan.srivastava@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250428214920.813038-1-aryan.srivastava@alliedtelesis.co.nz>

On Tue, Apr 29, 2025 at 09:49:20AM +1200, Aryan Srivastava wrote:
> Comment was erroneously added with /**, amend this to use /* as it is
> not a kernel-doc.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202504262247.1UBrDBVN-lkp@intel.com/
> Signed-off-by: Aryan Srivastava <aryan.srivastava@alliedtelesis.co.nz>

Thanks.

Strangely ./scripts/kernel-doc -Wall -none has nothing to say about this.

But the file is clean in that respect (both before and after this change);
I agree this is correct; And I couldn't find any other instances of this
problem under rivers/net/phy/aquantia/

Reviewed-by: Simon Horman <horms@kernel.org>

...

