Return-Path: <netdev+bounces-38140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0E77B98BD
	for <lists+netdev@lfdr.de>; Thu,  5 Oct 2023 01:39:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 87C471C208DE
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 23:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82D4D31A92;
	Wed,  4 Oct 2023 23:39:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ygx4Czz/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 623B9266A0
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 23:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B741C433C8;
	Wed,  4 Oct 2023 23:39:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696462770;
	bh=XcrEHh7VURvqf+a/pDJhVah/wclnCHtLqyJgoKS2JRw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Ygx4Czz/3hK4v/b+Kq43HLoPDxlzdl1EcIydhNPn3vplsq00Otzn0ARDzFbb5H8Kw
	 BVmkSE8EXwl7JdzUdUTTVK5g5vQkx8fwCVIT164+OgUvA30IBN0lkN+kXYgd6tDan3
	 M1/R+B8onwi7+t6QbAG7z+hJmRk2sVE3rPXFqpreiMXUh7Fb/w8XmIHsvdeHzUyBTd
	 39mYAdQ47fawhUW6ZK0XwoByt8XS+ZXgCbNoc0XFvQwpAhWUBuYgL67s/60xDgEfXn
	 aVPVrrXVfgOF/+rSSRaQVuT7KgRy68KCDQEwPMWWIklrHPUKmM6j2PipWaCUBTIkNV
	 jGJsySgr4alnQ==
Date: Wed, 4 Oct 2023 16:39:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Moshe Shemesh <moshe@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>, Jiri
 Pirko <jiri@nvidia.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] devlink: Hold devlink lock on health reporter dump
 get
Message-ID: <20231004163929.70977d05@kernel.org>
In-Reply-To: <1696173580-222744-1-git-send-email-moshe@nvidia.com>
References: <1696173580-222744-1-git-send-email-moshe@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 1 Oct 2023 18:19:40 +0300 Moshe Shemesh wrote:
> Devlink health dump get callback should take devlink lock as any other
> devlink callback. Add devlink lock to the callback and to any call for
> devlink_health_do_dump().
> 
> As devlink lock is added to any callback of dump, the reporter dump_lock
> is now redundant and can be removed.

I love the change but it needs more info in the commit message :)

 1. what exact / example but real problem are you solving?
 2. some words of reassurance that you checked all the drivers
    and the locking change should be safe (none of them take
    instance locks in reporter callbacks etc)
-- 
pw-bot: cr

