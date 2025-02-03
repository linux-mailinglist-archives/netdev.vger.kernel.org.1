Return-Path: <netdev+bounces-162049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A407AA25777
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 11:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31472166D21
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 10:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094C1201258;
	Mon,  3 Feb 2025 10:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n0e5b9Kk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CA0200BA9
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 10:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738580210; cv=none; b=i7wJKwgEMjtmV1wgbADO+B6d9c0MY7Iog03GoZ3iCGLNBOUWRGipEULDndWCNmHcjiU6qgKjWzPvjpY8laV3s3vWSbi/G/ujmM0TOkfr/BNoIIWxdi8vNRIYGbHbZrzJxcBDE2tv56NEkLX7kgEfC0OnN8qBD24qpK3Q+UN8MnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738580210; c=relaxed/simple;
	bh=9FFOFGTLILoN+cAudwTBk0us7mw/9A3hYbv0QeN7jHM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k200nsNyjBAtT2j1dsvy680OatQqfs3TOCRvFwRNXNhgMqgXm0HSrzdeXacDxEtS1UA4k/L+lzz32gIE2wSUGBQync7uykV54u5fZMycnFt7RYtHBtseWoA6Aqdn4w4GqYY5fXSaOs5iV+1Z914CopgVue/I2IPhm+CSIe6y8OM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n0e5b9Kk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C01C4CED2;
	Mon,  3 Feb 2025 10:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738580210;
	bh=9FFOFGTLILoN+cAudwTBk0us7mw/9A3hYbv0QeN7jHM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0e5b9KkkxAKFQo6E8fbxyZbKFTa5cGu259X+ISooYCPFo/Im3Drelbc70aXMHtkw
	 MYRmLaIv/0eLIzzIJ5pkuMRkltalSQty8AqV7H4syXPr1FRodkSE31vV9vsbY0lTy1
	 h1El5B9bDfMcU1+D4NR7rV7FxTYvfz18IPqknXX5MDrbyJ5gtqI+y/mx5r/X0wAKAO
	 LPJ9R20XJdp1ji2NHTHWXZB5vFNNZURpeR/6vcn+/5gMKN3BGtIkcqy9Nf3R9FQ2e5
	 zeh3iGu5aEipggDPN72pEGrKLmVyJpaRApxU8Gr7pirN7WBfBVV4znja6SxK7G+xCn
	 Du86L2nIe+fXg==
Date: Mon, 3 Feb 2025 10:56:47 +0000
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch
Subject: Re: [PATCH net 2/2] MAINTAINERS: add a sample ethtool section entry
Message-ID: <20250203105647.GG234677@kernel.org>
References: <20250202021155.1019222-1-kuba@kernel.org>
 <20250202021155.1019222-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250202021155.1019222-2-kuba@kernel.org>

On Sat, Feb 01, 2025 at 06:11:55PM -0800, Jakub Kicinski wrote:
> I feel like we don't do a good enough keeping authors of driver
> APIs around. The ethtool code base was very nicely compartmentalized
> by Michal. Establish a precedent of creating MAINTAINERS entries
> for "sections" of the ethtool API. Use Andrew and cable test as
> a sample entry. The entry should ideally cover 3 elements:
> a core file, test(s), and keywords. The last one is important
> because we intend the entries to cover core code *and* reviews
> of drivers implementing given API!
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> This patch is a nop from process perspective, since Andrew already
> is a maintainer and reviews all this code. Let's focus on discussing
> merits of the "section entries" in abstract?

In the first instance this seems like a good direction to go in to me.
My only slight concern is that we might see an explosion in entries.
Do we think so? Do we mind if that happens?

