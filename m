Return-Path: <netdev+bounces-134409-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 652209993D3
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 22:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0880D28411F
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 20:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 038661E104F;
	Thu, 10 Oct 2024 20:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tAmHir6g"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCA21C9B93;
	Thu, 10 Oct 2024 20:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728592847; cv=none; b=g1bzSkr89eB9DDzSmCKS0SydSl0Ze0wahmHU/qE5xoEmSXex9+GWatykehWA0t7sWEQQ2IMuCDoNdI7baAfGd2pB/TbBQev2heg4LgM9LdawuQzJmbkLtjlaI8MiwtAD8xl+ZzY3Sgjod78UH2+zRz2miNwn+vOIGBjjhbp/Tc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728592847; c=relaxed/simple;
	bh=BcpI+KFsnF+bvLEe/UsXzNEHQvoi4ZFKsMZjHNcyklE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L/mPKOd/fsFdNrPvnOLXUimfSDgDkNhJdYvnO4MLXNWMdSt+3dfXpY9GzsMZUjZex3fxP2hFeChZEKAPJk12R8wrbsBK7zI75Li7ow8TXWPHu9I6AnP2R/77JHuhOF+3RemDLi6mcTwSEhZ5CvGe36uFyg5QrjcPeqUPV4Jofx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tAmHir6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2110C4CECC;
	Thu, 10 Oct 2024 20:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728592847;
	bh=BcpI+KFsnF+bvLEe/UsXzNEHQvoi4ZFKsMZjHNcyklE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tAmHir6gGqR8F/Pte7RF6jMGYOxp9eRDT21jmKgNGolrsgUQuRWy7Yjgtyl75/WjD
	 PVfaIGZxN5kQ+aHgGMvU/Ztg8r6Ktu3DwUJMxUsJdUmxltax7YdrOrFOUWcWA4xniI
	 qgEwefLUM56KHX1TRrLPLrgkPhf0PHVubjdXQXYJGbbahBWu3hjW/PYNRhEeQYpY5i
	 193ioweLUJJ9x3SL6fc0FaKMVtvcFYpvYfxaZEfd77HR/jD44rrD7jUm1vtNspNijg
	 WrRmBQ8K1zxu2vqrj/d//+IRzmkVJ1EfB2L/FirBkZQwvT6+ec7vmeLWLy3fqd7Dbf
	 bJaxY1zqJtQuw==
Date: Thu, 10 Oct 2024 13:40:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew@lunn.ch>, Simon Horman <horms@kernel.org>, Uwe =?UTF-8?B?S2xlaW5l?=
 =?UTF-8?B?LUvDtm5pZw==?= <u.kleine-koenig@baylibre.com>, Breno Leitao
 <leitao@debian.org>, Jeff Johnson <quic_jjohnson@quicinc.com>, Christian
 Marangi <ansuelsmth@gmail.com>, linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCHv5 net-next 0/7] ibm: emac: more cleanups
Message-ID: <20241010134045.20e3e72f@kernel.org>
In-Reply-To: <20241010174424.7310-1-rosenp@gmail.com>
References: <20241010174424.7310-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 10 Oct 2024 10:44:17 -0700 Rosen Penev wrote:
> v2: fixed build errors. Also added extra commits to clean the driver up
> further.
> v3: Added tested message. Removed bad alloc_netdev_dummy commit.
> v4: removed modules changes from patchset. Added fix for if MAC not
> found.
> v5: added of_find_matching_node commit.

net was not merged into net-next, yet, when you posted this.
So the build system wasn't able to apply it.
Please repost tomorrow, again, after waiting the customary 
24h cool off.

