Return-Path: <netdev+bounces-179854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D427A7EC24
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 21:10:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB9B2446631
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 19:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF1025F97F;
	Mon,  7 Apr 2025 18:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAuAhWCK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2BE825F97D;
	Mon,  7 Apr 2025 18:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744051080; cv=none; b=oc8OxU818gknDdzLxBEbvo0QylLLn705FhdPYv0CoNy+GinUjauUzQO+mYxBnPpyciNi1qlOa9HBSoPUn619XPZ0NZlbBtuVog/saFhqHb7EiimX5wfrwCoc+1UkBhICKgybSXttRTfHCiUiThfvS8oy6couCOeMxsoulODKsT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744051080; c=relaxed/simple;
	bh=zk8wUrlmuDMDL1PuhRcv1wh0/L1IcyraU6qKme+S0p0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bs7nlr/uiIFz6YXeNOab5xn3RB+mGHU3vTnke1y3KsIz+yJkbqt09TRAKXDonIN+cZ6mxYStmRhEClpB/2ya1WifqEBB3sshiP8gW5EYA8xw62KemZ49Lz7bY+lkLio0swAQM4RNWAmMIbozHdoYSQMe4qfiGhK1/pu8pE1xIdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAuAhWCK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F3A5C4CEDD;
	Mon,  7 Apr 2025 18:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744051079;
	bh=zk8wUrlmuDMDL1PuhRcv1wh0/L1IcyraU6qKme+S0p0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ZAuAhWCKuHgT1/ExnFqAZETSS+WPVhtKy6L/znez7KMIIeY7D4KIJhTcBAjUMi1Xs
	 iVNys8Y9yQ6d7vMo9nMZa3bBiotopWU8shZ79s8Kw+K1huZLFUTpcU5toVSn+4udU9
	 1HqUBOMv3TOK4AlAbw9Qq8AOfC7FOj6ohEBmLkyMVBfVI+igw6s48yu8YBbI5N+jMM
	 9gSVuS0ubG4a5VuVZGXaGuZ9dAy6VFSDLPZxJ8UqPe9Dx10PQvOoT52g35g9iJe28q
	 nxQWr0j1LzdE08hAU/bfnI19AhPdKyLKFqRth4yIvfblv27n1zlT1Qs2wRh4a3x7ST
	 hN1Z1WeMWURhw==
Date: Mon, 7 Apr 2025 11:37:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Roopa
 Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov <razor@blackwall.org>, Simon
 Horman <horms@kernel.org>, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
Subject: Re: [Patch v3 net-next 0/3] Add support for mdb offload failure
 notification
Message-ID: <20250407113758.2fee3e4a@kernel.org>
In-Reply-To: <af01e665-08bb-4b60-ba0b-1784dd8a5ce3@gmail.com>
References: <20250404212940.1837879-1-Joseph.Huang@garmin.com>
	<20250407102941.4331a41e@kernel.org>
	<af01e665-08bb-4b60-ba0b-1784dd8a5ce3@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 7 Apr 2025 14:15:31 -0400 Joseph Huang wrote:
> - Should the re-post be v3 (no change) or v4 (bump)?

Doesn't matter much, but probably v4 is less confusing.

> - Do I re-post after 6.15 is released? Around what time frame (so that I 
> can set a reminder)?

No, no, I mean very soon. Like tomorrow. The merge window is when
maintainers merge their tress up, rather than when we merge code
from contributors. It's a bit confusing. Merge window open ==
normal contribution closed, and vice versa.

