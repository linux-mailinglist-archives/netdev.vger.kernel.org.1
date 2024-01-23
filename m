Return-Path: <netdev+bounces-65129-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 092E28394C9
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 17:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B54DC1F2AAA1
	for <lists+netdev@lfdr.de>; Tue, 23 Jan 2024 16:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0A4A6A01D;
	Tue, 23 Jan 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bgb3t6oN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F99481C7;
	Tue, 23 Jan 2024 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706027719; cv=none; b=Bqc37FsS/YpbYxWjvZl3cIcOQEsmmKkF6Yp3QCcfur7tRDM1Qt3rVCM0vCTFziEaYq/BM6JACq0wFGX2VXPT16WZiH5mBCTeDCb5bF/fnDkaezserwhOYxt7kWaH+NB0zIQA6Gs0zAyO97xs/qndKgLk+dGr1jApXcjTXSinlKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706027719; c=relaxed/simple;
	bh=dirBhJb++RfdMmFcy8NH21TggXMpcKpGnGyZJmfGj2w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ctjif3y2c61Ct9LMxmS8Y4DCe5a8PJh0XTzWO4GSlpsA5hNP2h/ZA+Uej9Q0WHP74McG6Pb6ZtuzKrD5MO9r1MBZUp/JSg+jtcuAAVZWB7zVc+xKCaPCfawZGi+BEjCiErlirnUbk/ywi+QsYTw2IDE6VVf6t6hr7Od+nnNXipQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bgb3t6oN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CDC8C433F1;
	Tue, 23 Jan 2024 16:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706027719;
	bh=dirBhJb++RfdMmFcy8NH21TggXMpcKpGnGyZJmfGj2w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Bgb3t6oNqQklxoS3kD9UsjIAU2xSqLc74I3cUzAkvRGKDyhcBObvVOvIb1Cp8SajF
	 nXb6rjRLkIVVagcMwnUXoSIK3c9H8gqCtrNtdAKqKYAFWiGvwsxzXMouaRg1ixAvrQ
	 iifQtGdcoKTE7nggh9XGVPW5FVkbBJmjfRqmq4bBHM3T2rft2tfeoAee56NMo/CY6X
	 KwyMowS1Cjm1LrZznAGWwEFDZ0xDWjtQPy964hbNR7YrzGmE/QayW+b2nf83QzMjuA
	 hs08ZEFUPOLAmoRFX7iryd2gPGRUK7rYI3c3+PzfHrgI2w/EAmcfG1yOVvM0PJgGaD
	 kjanORY4L6Cfg==
Date: Tue, 23 Jan 2024 08:35:17 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, abeni@redhat.com, edumazet@google.com,
 dsahern@kernel.org, weiwan@google.com, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next 00/22] Fix MODULE_DESCRIPTION() for net (p2)
Message-ID: <20240123083517.2982c483@kernel.org>
In-Reply-To: <Za/oeIjnMoqqp4Tt@gmail.com>
References: <20240122184543.2501493-1-leitao@debian.org>
	<20240122105708.52d33fa0@kernel.org>
	<Za/oeIjnMoqqp4Tt@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 23 Jan 2024 08:25:28 -0800 Breno Leitao wrote:
> > When you repost:
> >  - please send these 3 to linux-wireless as a separate series
> >  - make sure mailing lists are CCed on the cover letter
> >    (yes, get_maintainer is embarrassingly bad at its job)
> >  - please send 10 at-a-time, it's probably a good tradeoff
> >    between series size and reposting risk
> >  - please target net, I hope I convinced Paolo that it's okay :)  
> 
> Sure. I will split this series in 3 and target `net`.

The wireless ones need to target wireless, just to be clear.
The rest should fit into 2 series.

> I suppose it is OK to send the patchsets in parallel, instead of waiting
> for the first patchset to be reviewed/accepted before sending the second
> part. Is this correct?

The rate limit is to avoid having to give the same feedback to multiple
series, among other things. it'd be better to send one part at a time..
it won't take that long :)

