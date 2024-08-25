Return-Path: <netdev+bounces-121712-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3375195E299
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 10:12:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C27A9282435
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 08:12:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B0C52F70;
	Sun, 25 Aug 2024 08:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jV39yAUr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F202AEAD2;
	Sun, 25 Aug 2024 08:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724573539; cv=none; b=lv52tgyUbVqTm4qLPuwi0YwhWKK2pQJU8Wrw+6ZeNOKFi3ryRbGs/HD7fKSWCBKT6H/ZXVs9G+MfyWI1RrZ3nCDxyeIq2oVbPl4Ly0nvsj6/VzfOmZVJdSM0fL42xLg9Va3BplKRcaxSgSqrrwqsK1TAMUPWqFqjbJNHBSSd3yA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724573539; c=relaxed/simple;
	bh=UBJg/iM7uY+1hECYggabeakTTuQ/H8eQYbeWh2Ylcbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dJ3NFufP4RYgkArcAOwC2ryJsIutKTy3/2JLRIxTIhT9st+m1PfuzrjFozBDwyAAfoTcS1hJUxcsQ4FF33UL2hBq8zQqAtln8+NMN8KfmBkAlkCI7jiAWPyAnBY4bS3TLCwL/zfBB1eDmeohWkAWbWDc5TK68fsbi3Io2iPt8NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jV39yAUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3C75C32782;
	Sun, 25 Aug 2024 08:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724573538;
	bh=UBJg/iM7uY+1hECYggabeakTTuQ/H8eQYbeWh2Ylcbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jV39yAUr3oj5PCWyeXwTH1jEb/cp3DHkw6dy8KQjpxF0xQzV+gTM4P6xaHpEA6aPk
	 LKxl/q1+HM914asIfNrm8/eiuSXBk4gcW2JyzBRubcBzK1asPpmGjLnpeRVEwo6baZ
	 VAhhcALmxzOqywCHYEwg/xvAx0ke8DdhocYKCtFZi1m30vPmcyy4tln+9lUw5Ij547
	 iMtqygSr7pqyhiFRCzM/jXHPJmCzR0GWsGFmX+3daOykVEILZkLya4lXO2uqNQnZt3
	 kJygI6d3WGSL2YnoVOgXlaCm62Vpew6OEkRa1i46CDB6NtPyGzkvOAwlSvzcEjJ81E
	 SD6RqF9TqGFFw==
Date: Sun, 25 Aug 2024 09:12:14 +0100
From: Simon Horman <horms@kernel.org>
To: Yue Haibing <yuehaibing@huawei.com>
Cc: sgoutham@marvell.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: thunderx: Remove unused declarations
Message-ID: <20240825081214.GV2164@kernel.org>
References: <20240824082754.3637963-1-yuehaibing@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240824082754.3637963-1-yuehaibing@huawei.com>

On Sat, Aug 24, 2024 at 04:27:54PM +0800, Yue Haibing wrote:
> Commit 4863dea3fab0 ("net: Adding support for Cavium ThunderX network
> controller") declared nicvf_qset_reg_{write,read}() but never implemented.
> 
> Commit 4863dea3fab0 ("net: Adding support for Cavium ThunderX network
> controller") declared bgx_add_dmac_addr() but no implementation.
> 
> After commit 5fc7cf179449 ("net: thunderx: Cleanup PHY probing code.")
> octeon_mdiobus_force_mod_depencency() is not used any more.

Maybe not so important, but perhaps it is worth mentioning that the
implementation of octeon_mdiobus_force_mod_depencency was subsequently
removed from the tree in commit 791e5f61aec5 ("net: phy: mdio-octeon:
Cleanup module loading dependencies").

> Signed-off-by: Yue Haibing <yuehaibing@huawei.com>

I checked and all these symbols are indeed neither used nor implemented as
described above. And, my comment above notwithstanding, the cited commits
also look correct to me.

Reviewed-by: Simon Horman <horms@kernel.org>

