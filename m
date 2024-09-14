Return-Path: <netdev+bounces-128292-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D14C978D5E
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 06:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8A9F286287
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 04:43:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63797199B8;
	Sat, 14 Sep 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pBhW3tE8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D2624;
	Sat, 14 Sep 2024 04:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726289019; cv=none; b=c4bBYelwmn+aG/Yw014DwiTwwnlY97g5fZ7AnU9mGFOWvozmD1TEmM8FKzeRA7lAgKoGUGP2ThZ5lVJyAS7G/293ymqn/1xrV3pN+JEM/BgEbCSx0wwgLf0SnuKSbMzTgzcNPOXnsw5e5TP9YFj48xU8Ig875FI72TdyL3E6V4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726289019; c=relaxed/simple;
	bh=Lc9X/JDwAfiwtNg165Y0s3jQ75PoLNHgU3So6uQijnk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MGO6G2YI/qbVG95xuzeqRBO7vLxf4dLW8SRkkzr72YvpK014186P3Rw6Sjhl+aNpyJ3nIdw5hdYCzfWiSgJjXPw1qm8g+XW4mqS2EFcIKA05f3WNdfW+b8KfAEOzadsnrwfW4tOV7MpiGLpnmHimDSf3pK7tQHrI1oLUDmwzN3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pBhW3tE8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353AEC4CEC0;
	Sat, 14 Sep 2024 04:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726289018;
	bh=Lc9X/JDwAfiwtNg165Y0s3jQ75PoLNHgU3So6uQijnk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pBhW3tE8/+UDsk05wlrVxxE/XG5GrOB1bJlSjQ2OV9Rc/EJIbT5MJV1+VtRqhsBty
	 0F0ZEwNhYLoaHLDuFMz7Dl1u/d/nmhYgEcqbH04Y6Un5HuXw1FVQdZ27ZPVE9DXOV8
	 dZFUlZzRNSLe74GRa/q0ReUdIMsQ0ul5qPcvriyZ7af2twpiGBKklQDAfMyRgFrDMr
	 lfs2QnKIDLe1upWQIHVMGnPVmu5lDsS9oLzs/Kd/A2jgbuom9gAV9fHNeRT9LNPD1J
	 wwFoU7zBhIbSP1NDqzDEL6CZ0yuTQAjUdv77SVd9trB9YTEjRIkXeJRyiUlqvkxHmG
	 AodtL7bxD+4VA==
Date: Fri, 13 Sep 2024 21:43:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Linu Cherian <lcherian@marvell.com>
Cc: <davem@davemloft.net>, <sgoutham@marvell.com>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <gakula@marvell.com>, <hkelam@marvell.com>,
 <sbhatta@marvell.com>, <edumazet@google.com>, <pabeni@redhat.com>
Subject: Re: [PATCH v2 net-next 0/2] octeontx2: Few debugfs enhancements
Message-ID: <20240913214337.50c18fad@kernel.org>
In-Reply-To: <20240912161450.164402-1-lcherian@marvell.com>
References: <20240912161450.164402-1-lcherian@marvell.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 21:44:48 +0530 Linu Cherian wrote:
> Patch 1 adds a devlink param to enable/disable counters for default
> rules. Once enabled, counters can be read from the debugfs files 
> 
> Patch 2 adds channel info to the existing device - RPM map debugfs files  

We're closing up the 6.12 release, there isn't enough time to think
thru patch 1, but patch 2 looks fairly straightforward so I'll apply
just that. Please repost patch 1 when net-next reopens.

