Return-Path: <netdev+bounces-104114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2E90B457
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 17:30:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7441F27D72
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 15:30:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5253713A409;
	Mon, 17 Jun 2024 15:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CJDWjegn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AAAB13A404;
	Mon, 17 Jun 2024 15:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718636554; cv=none; b=SXl97V7NcNjfyeyUEjaxa3b08S3Y//22qlnnVSywUtOZPbrCkZCGr6oT7htdHrvf/rG3YDhJkQTUxEkxxqTy09ZMdYOncE0/XlowWGq84g12qMBgf1g6SUjvtIkEKMd1jUehC0AnG4q6nBqwsxfjKyXS2iy076KHxEWW5eul0bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718636554; c=relaxed/simple;
	bh=7tMtBsozJ4vfFPoqkmk5Y+AG0DM1FQ9OaHqRv+mSHEo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXzz73RFiIFx4he1nmz5eyBT24qbnSQS6Is3kXfMtOGzteO0ierE438ytPr14qRmsTqUJ/G7wCl9esr6voau5EMDMnGkGCHggaoFRrxbnANVTjRvcjRp/99sfTuMUvtWdDKetdRFkdO6nLLV90oFn+vwHYbnyJCuU5OLO7orFbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CJDWjegn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18575C2BD10;
	Mon, 17 Jun 2024 15:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718636553;
	bh=7tMtBsozJ4vfFPoqkmk5Y+AG0DM1FQ9OaHqRv+mSHEo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CJDWjegn35aeMTxpDeMLqnbflARfS0mJhpNldjJXrC416QpGefF9xW4/2IFDXdODg
	 UEDeqfU7kN2hrsAF81Wi3yjJe2XeEILzwHzYYdZC0aD7084n5o+e0RwCEITHF8p1PA
	 AaqDQl1ipTJreeJd3uyLOe5wgIUzQIWwwlbog8q4p9j0wg46RVUciEubh3Kitez22V
	 5RtRi1YwfLMWWVNy93eu+aEC7rbimePwFXs79aNCvMos43L922zEY5oFxn2QsTlE7+
	 xEoscNEU/uNtl7HEtUiyFXibf9WqAVoL2NlsZkRGk6oaqHur8Ro9XTnvqcb1k2/+DB
	 bMhHXyHYFW7yA==
Date: Mon, 17 Jun 2024 08:02:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Justin Lai <justinlai0215@realtek.com>
Cc: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
 <edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "andrew@lunn.ch"
 <andrew@lunn.ch>, "jiri@resnulli.us" <jiri@resnulli.us>, "horms@kernel.org"
 <horms@kernel.org>, "rkannoth@marvell.com" <rkannoth@marvell.com>, "Ping-Ke
 Shih" <pkshih@realtek.com>, Larry Chiu <larry.chiu@realtek.com>
Subject: Re: [PATCH net-next v20 07/13] rtase: Implement a function to
 receive packets
Message-ID: <20240617080232.620a2452@kernel.org>
In-Reply-To: <5115e5398ce742718a24ec31a0beaff5@realtek.com>
References: <20240607084321.7254-1-justinlai0215@realtek.com>
	<20240607084321.7254-8-justinlai0215@realtek.com>
	<20240612174311.7bd028e1@kernel.org>
	<5115e5398ce742718a24ec31a0beaff5@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Jun 2024 06:44:55 +0000 Justin Lai wrote:
> > > +             /* make sure discriptor has been updated */
> > > +             rmb();  
> > 
> > Barriers are between things. What is this barrier between?  
> 
> At the end of this do while loop, it fetches the next descriptor. This
> barrier is mainly used between fetching the next descriptor and using
> the next descriptor, to ensure that the content of the next descriptor is
> completely fetched before using it.

What does it mean to "fetch the next descriptor"? The prefetch?
Prefetches are not ordered at all.

