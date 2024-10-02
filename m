Return-Path: <netdev+bounces-131201-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9437498D35A
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 14:32:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 32BCEB24AEE
	for <lists+netdev@lfdr.de>; Wed,  2 Oct 2024 12:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2FF71D0405;
	Wed,  2 Oct 2024 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vL/D4sy2"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4EB1D0175;
	Wed,  2 Oct 2024 12:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727872335; cv=none; b=gZV4AlI9GFEp+h+4mwv4fZFD9dKk9oC0//QjysMcBKeX+ptgJlVNvBjat9b2NjLOiXHDBMXfE31aDdZG+yj/SmZKFErTvYzyoqipwqA4rQ2LdpnT6znGv3TTl9tEtMqIIL2Lw5R7Mhw9QlGhC1AzdANJhAZZEIBN41JYcffJtgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727872335; c=relaxed/simple;
	bh=uGCLIjkklcREWf4mtRnlZ54GgVX0jOiWVPTg888iKE8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KgxL50+J/qqx2mLDfS83/cZY8vpRtbjOksjJrOctNLTaK9dzbm4f5C0r+qJRXYPTYyt0qaZNqDTIqXxC757BWELslX3/8HnuhhyOOGkxhh+qulN9YJLl0pA7EE9N6X+JmMHbNhN//nIjqKA4EuXow5wwwfwpUtmQI2jzq+amk+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vL/D4sy2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFBCC4CECD;
	Wed,  2 Oct 2024 12:32:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727872335;
	bh=uGCLIjkklcREWf4mtRnlZ54GgVX0jOiWVPTg888iKE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vL/D4sy2+R47rhXGyY2QARJoevdy0fdpn0v6ag+DtuxfFndT7wetJpI0F41jhZCcA
	 pu5NcFaRqCysKIEbi8F8egPA0DBXfWpFlgjf9WqzZd5Bvt+yLuNA+AIDAlS3o4eDzP
	 8FulApqgooXXoVQDibC8ZCmi8R8VWlzize7/1BpQTcrjIR7/LxQ2pXmwY1Q+2H3pSu
	 1Wn/KsEu0Uzo6CSmJJvB6cgc5RwETiJLe0b0NMHMoevIILtKkp5CSrMYpYB7SfGOyX
	 4TKK+AH2No+gti4vUt27vNVtuUGxNHUGKxbPsvizVT60b1SjLBkRtfofmAk+FTSWZw
	 iC/81vM4B64Cg==
Date: Wed, 2 Oct 2024 05:32:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 steve.glendinning@shawell.net
Subject: Re: [PATCH net-next 0/8] net: smsc911x: clean up with devm
Message-ID: <20241002053214.4a05ba33@kernel.org>
In-Reply-To: <20240930224056.354349-1-rosenp@gmail.com>
References: <20240930224056.354349-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 30 Sep 2024 15:40:48 -0700 Rosen Penev wrote:
> It happens to fix missing frees, especially with mdiobus functions.

Do you have the real hardware and have you tested this on it?

Please always include such information in the commit message.
Random conversions to devm are discouraged in networking.

