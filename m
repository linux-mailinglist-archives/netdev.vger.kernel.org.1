Return-Path: <netdev+bounces-198997-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D63ADE9D6
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 13:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48D9717BB41
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 11:21:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2697C2BD580;
	Wed, 18 Jun 2025 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gy3OeSTf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F35C82857C2;
	Wed, 18 Jun 2025 11:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245708; cv=none; b=lR4BKvo+r8lsVRFQC76+L1Z0cBKEGRqKrAbo//CeJQ8H0enE7N6uQzYfx6veAZL6Gw6tRsMvae+aAdBwXYPZfyQu5jwRfPL2xezqCBCfaDr47UGxQIXlCS4wNgV6nmrRZfMJjFy3ZTPBz4gFzJmri61lX05eLiW0u5MxRcw6zwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245708; c=relaxed/simple;
	bh=JBhbYXMeGTA7g8O07kQuVdwgRJ3LsrpzRh4KaFM7qyA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aGTkqISotM3xh5kFpHvYZXIEhGFmW5Sm+bmTT/lLxir4K665AEwJNrTanSp7tj/JxewZc3kEEW1N1yQ0zsoJls/bl1xdariepc9P7/6ysQHh+F0LcFaWYGGhuoL7iZ3QijZ1kGqRL6c1XLoVl3MGhKfycjJ5XPL9hObmnJyFKgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gy3OeSTf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914E7C4CEE7;
	Wed, 18 Jun 2025 11:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750245707;
	bh=JBhbYXMeGTA7g8O07kQuVdwgRJ3LsrpzRh4KaFM7qyA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gy3OeSTfn3yK5mVvA+fPivyVQFhG3i5GnJDSrmztHVAFkei5TL2GPYH+QwrtRu6pl
	 3cR30KSXOy9jJVx5GHQVmnIhsjXYFd28WpdQ9HER+TIqVRwXZFKDNJM4Y7gIbkESOx
	 +ymX7bjJ4g0O0qn6YhGrJs3gIRD/FeYOSNI6hbjYmX6Dloq/N6ArU7rdfzh6uqBFQ3
	 5T+eLzFriIUWbIXALriI1emDbfGA/MzZBohF3gAQ/Rielsh+cbFf+P8W/J/LjYjwQo
	 fOkJ+KTOXJK8xBSssFaq4X8OSBzsUgt36nJAsGW2NXINNKcIp0oOmsoPtxqyetsPJi
	 c8xRR6QCmsi/g==
Date: Wed, 18 Jun 2025 12:21:42 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, andrew+netdev@lunn.ch, shenjian15@huawei.com,
	wangpeiyang1@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, jonathan.cameron@huawei.com,
	shameerali.kolothum.thodi@huawei.com, salil.mehta@huawei.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	michal.swiatkowski@linux.intel.com
Subject: Re: [PATCH V2 net-next 7/8] net: hns3: add complete parentheses for
 some macros
Message-ID: <20250618112142.GK1699@horms.kernel.org>
References: <20250617010255.1183069-1-shaojijie@huawei.com>
 <20250617010255.1183069-8-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617010255.1183069-8-shaojijie@huawei.com>

On Tue, Jun 17, 2025 at 09:02:54AM +0800, Jijie Shao wrote:
> Add complete parentheses for some macros to fix static check
> warning.
> 
> Signed-off-by: Jijie Shao <shaojijie@huawei.com>

Reviewed-by: Simon Horman <horms@kernel.org>


