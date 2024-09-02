Return-Path: <netdev+bounces-124300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD221968E16
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 21:02:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AF72B2141F
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 19:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266EC10F1;
	Mon,  2 Sep 2024 19:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cj4pbsmW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F07B31547DB;
	Mon,  2 Sep 2024 19:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725303752; cv=none; b=B58ks/wzog6N/2RV5LNk2N0RLWp1yZ5MSUeMyoG3KNsHxUjs8dOLfUZpQvnLm+Omy0tlozFiwyVec+E8cAb7zGjdkVIh4lwCAWOgU6PXsi7l4dPEW2i6dEfQ8hPQHPiCVpItJLoTtcMuXJXRfu2rJrPdLR1ms6zTTpYTxE2p/Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725303752; c=relaxed/simple;
	bh=LF5bMNk7r4yrrsDeD9mfifZM7UnUsW089VwHXfiKHtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jcJGj8Ty7qcT1N12zWZJWEOZJYeMxdRasecSg7KVO55pINmIRg4g0cFbTaXuhbHH3U4QMt/uyqKpMGQeOZIeos+7kRe9GKoMI8CspdZW1QhMXgHNpZlzqJnzpHnRbWaXbACoaOmp4DdHC50ziCRkvWI6Hjc4gHxX2kDzB2LGIGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cj4pbsmW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B311C4CEC2;
	Mon,  2 Sep 2024 19:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725303750;
	bh=LF5bMNk7r4yrrsDeD9mfifZM7UnUsW089VwHXfiKHtg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Cj4pbsmWPI2Bmazu0bV0AZtplh4OrUjbgkJwkMoQTIkfjoHbnbTRPEhllFDyDQ48u
	 3aCpHMyYObIZemV7EKz3SiOieBCGb7oZ8208QlYS4mcwYmuBqtv32Mc0qJf0yYen12
	 IRsIsRaf94iCLRDfmPtlpz1p+cLPFBYPGkPxWkZ4S52CwELFUtAGl28WHRPTEYb/Al
	 Pi7HImkdsvNaF8pjzPkMoLw0spMm25Bt9veNIOc2Mrnp0CpkNPXTx79BYz4ljY1UQE
	 UUHIXjtbABgKogqAd6+3j3z23dSjnlg8bqs9kur3RDoHXheBTszRm18CUSzA2Bx++l
	 9keC8u/EypAbQ==
Date: Mon, 2 Sep 2024 20:02:26 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	leit@meta.com, kernel test robot <lkp@intel.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jamie Bainbridge <jamie.bainbridge@gmail.com>,
	"open list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: dqs: Do not use extern for unused dql_group
Message-ID: <20240902190226.GL23170@kernel.org>
References: <20240902101734.3260455-1-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902101734.3260455-1-leitao@debian.org>

On Mon, Sep 02, 2024 at 03:17:30AM -0700, Breno Leitao wrote:
> When CONFIG_DQL is not enabled, dql_group should be treated as a dead
> declaration. However, its current extern declaration assumes the linker
> will ignore it, which is generally true across most compiler and
> architecture combinations.
> 
> But in certain cases, the linker still attempts to resolve the extern
> struct, even when the associated code is dead, resulting in a linking
> error. For instance the following error in loongarch64:
> 
> >> loongarch64-linux-ld: net-sysfs.c:(.text+0x589c): undefined reference to `dql_group'
> 
> Modify the declaration of the dead object to be an empty declaration
> instead of an extern. This change will prevent the linker from
> attempting to resolve an undefined reference.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202409012047.eCaOdfQJ-lkp@intel.com/
> Fixes: 74293ea1c4db ("net: sysfs: Do not create sysfs for non BQL device")
> Signed-off-by: Breno Leitao <leitao@debian.org>

Thanks,

I see this with gcc-13.2.0 but, curiously, not 14.2.0.

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

