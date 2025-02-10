Return-Path: <netdev+bounces-164905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EEC6FA2F96E
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 20:49:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F101718828EA
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 19:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2534B25C702;
	Mon, 10 Feb 2025 19:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hJwAFwln"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDFE25C6E2;
	Mon, 10 Feb 2025 19:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739216995; cv=none; b=ev6Oyo0L14iCliqDVVDlf01zD2zOhy9kK+omrtJ7kKISWHCgSSrahwlt384egetrXnXN5jfHqmw7hQ9mErEi0N9ttEVG2EsAu7KOt5lAODqjJa9NuSK/4/OUt3UvtFJZTWBTWrjFRXT8qC4CwK/WG0gMoENENjn2rXKsayp3o2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739216995; c=relaxed/simple;
	bh=oEnP3Cpzn42gkf0GTaCn8qrpLNPf2NHaaTPfjkOYeBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZhTxQY+bYjG3tuJmoK8OgbIpuiGYERMHr4BPmBv8NrBIU2EEnugJmZzJXdrdnyTcczrBh9PMLLUOyQkRl9LAUhlyN7jspP8FjeiKu/+noc6F+ym2/gqwFLrBsV6Z6NXvc3NBmpq5R3NZHjQiXxoEO4TWz1CpafJKsNuTY/IKHCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hJwAFwln; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A581C4CED1;
	Mon, 10 Feb 2025 19:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739216994;
	bh=oEnP3Cpzn42gkf0GTaCn8qrpLNPf2NHaaTPfjkOYeBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hJwAFwlnUrjfVoxHlmNOJyju6cp15lEsAehExUdpHtP/NL5PjYGnbbhpKlK6ZIeUf
	 ZOhYRfv144CHl04IIa0ipsQ0bdomfIPbml2XnRPUjIe3qXnOTwLRTjqClVOxXqbyWZ
	 BQ4yzmu8ozIVi6g92Tvm/68gnCwkNVGRXQZh8Xurh0BT66/aPa1/Y0Szd5a6YiVzew
	 nIDHpC/fBJnZR2aMnfJjFt2mb6egSdwO3FKATJiVVGPTkkljNyX140BQCd8/ZsaTDy
	 VVN4MYd9BfEVO/cqMKaF1CAsrwHmhSkQ0JktOIlfCwXynt/6CnfgcF2754HPv0jMUQ
	 X0IhhkBJivTtA==
Date: Mon, 10 Feb 2025 19:49:50 +0000
From: Simon Horman <horms@kernel.org>
To: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 02/15] mptcp: pm: userspace: flags: clearer
 msg if no remote addr
Message-ID: <20250210194950.GP554665@kernel.org>
References: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-0-71753ed957de@kernel.org>
 <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-2-71753ed957de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250207-net-next-mptcp-pm-misc-cleanup-2-v3-2-71753ed957de@kernel.org>

On Fri, Feb 07, 2025 at 02:59:20PM +0100, Matthieu Baerts (NGI0) wrote:
> Since its introduction in commit 892f396c8e68 ("mptcp: netlink: issue
> MP_PRIO signals from userspace PMs"), it was mandatory to specify the
> remote address, because of the 'if (rem->addr.family == AF_UNSPEC)'
> check done later one.
> 
> In theory, this attribute can be optional, but it sounds better to be
> precise to avoid sending the MP_PRIO on the wrong subflow, e.g. if there
> are multiple subflows attached to the same local ID. This can be relaxed
> later on if there is a need to act on multiple subflows with one
> command.
> 
> For the moment, the check to see if attr_rem is NULL can be removed,
> because mptcp_pm_parse_entry() will do this check as well, no need to do
> that differently here.
> 
> Reviewed-by: Geliang Tang <geliang@kernel.org>
> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>

Reviewed-by: Simon Horman <horms@kernel.org>


