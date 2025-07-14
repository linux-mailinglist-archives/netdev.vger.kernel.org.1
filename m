Return-Path: <netdev+bounces-206628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B56CB03CD1
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 13:04:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F45E188A472
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 11:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0C8B244668;
	Mon, 14 Jul 2025 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TwybnVY7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1BE1DDC2B;
	Mon, 14 Jul 2025 11:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752491060; cv=none; b=pTh2OVDrWhvvMKH7Ei/v+Gpc++H9m3uwT//vhHQ9gEP/+jHTaGZqmJv5zMKkn6/hbWQpQmVq5Hf1d3a50B8KM7HPP8e3F/80jPHqkAVnGqmxWducUCvlTJdfv5c0123+jJTbQuKW3jSG2HGmdRkecr1xPGnK3GlBQ3x36tKdbJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752491060; c=relaxed/simple;
	bh=q9HpEtIRrkZdELTtCWPL3gkg5Ju4mFgBx8v63a7Nwic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KGZZpbufC+yXsLxLkxtA08i0/uyH7HEbAS/PcFKi2VbLj2b2q3bkRsTYTpYUU2aZqMbgMmgmHLSKnxkKvzE3Fn/Fm3etRxxUx8e5mAQnHMdy6IEn1Q5v9XVx7xbMrJccQBMg8Ychahq9TPWBOAo0uKBQuDh16R6RrKpIAgpIPxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TwybnVY7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A384BC4CEED;
	Mon, 14 Jul 2025 11:04:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752491059;
	bh=q9HpEtIRrkZdELTtCWPL3gkg5Ju4mFgBx8v63a7Nwic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TwybnVY71wPexuyymf214H8oWLShebFIFCnA495WvSllztFcYYaOPi7yMbthCIMLU
	 RxiPYIIrLlhmaYVQS2JIQ+ECeXO22MUj55LLIGEQb4C8QfxTE9JnRm8QpfdDGpdPhU
	 ddeKZdVcOi9zxlT/wNvdJLIQZ285J+lJ1QEWA//Qi2kqQB6sYORQTgP5YJWU5zfvnK
	 U9eDSYOg5TA9MlpSZz4lStDf47IaO6s0hE0bSHV5jVmZuLaEDtiwWEy6VR3kVhbUGe
	 E7Etcrc5wnn2kw5nmJVGkVWqdnt+C1Uig8PY2/3zUqkbykAQ9SMjn66f2LmjTR2vvu
	 i4CAGd4CSH6RA==
Date: Mon, 14 Jul 2025 12:04:13 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	liuyonglong@huawei.com, chenhao418@huawei.com,
	jonathan.cameron@huawei.com, shameerali.kolothum.thodi@huawei.com,
	salil.mehta@huawei.com, arnd@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net-next 00/11] net: hns3: use seq_file for debugfs
Message-ID: <20250714110413.GJ721198@horms.kernel.org>
References: <20250711061725.225585-1-shaojijie@huawei.com>
 <20250712121920.GX721198@horms.kernel.org>
 <df1c269a-085a-47cc-83ef-294ea84b98a2@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df1c269a-085a-47cc-83ef-294ea84b98a2@huawei.com>

On Mon, Jul 14, 2025 at 09:04:56AM +0800, Jijie Shao wrote:
> 
> on 2025/7/12 20:19, Simon Horman wrote:
> > On Fri, Jul 11, 2025 at 02:17:14PM +0800, Jijie Shao wrote:
> > > Arnd reported that there are two build warning for on-stasck
> > > buffer oversize. As Arnd's suggestion, using seq file way
> > > to avoid the stack buffer or kmalloc buffer allocating.
> > > 
> > > ---
> > > ChangeLog:
> > > v1 -> v2:
> > >    - Remove unused functions in advance to eliminate compilation warnings, suggested by Jakub Kicinski
> > >    - Remove unnecessary cast, suggested by Andrew Lunn
> > >    v1: https://lore.kernel.org/all/20250708130029.1310872-1-shaojijie@huawei.com/
> > > ---
> > > 
> > > Jian Shen (5):
> > >    net: hns3: clean up the build warning in debugfs by use seq file
> > >    net: hns3: use seq_file for files in queue/ in debugfs
> > >    net: hns3: use seq_file for files in tm/ in debugfs
> > >    net: hns3: use seq_file for files in tx_bd_info/ and rx_bd_info/ in
> > >      debugfs
> > Thanks for the update, but unfortunately I don't think this is enough.
> > 
> > W=1 builds with bouth Clang 20.1.7 and GCC 15.1.0 warn that
> > hns3_dbg_fops is unused with the patch (10/11) above applied.
> > 
> > >    net: hns3: remove the unused code after using seq_file
> > I suspect this patch (11/11) needs to be squashed into the previous one (10/11).
> > 
> > ...
> 
> Yes, it looks like so...
> 
> However, in this case, the operation of patch10 is not singular.
> It modified a debugfs file through a patch while also removing unused code frameworks.
> 
> In fact, this warning was cleared in patch 11...
> 
> ...
> 
> I will merge patch 11 into patch 10 in v3.

Thanks, I agree that looks like a good approach.

