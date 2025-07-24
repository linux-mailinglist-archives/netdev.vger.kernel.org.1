Return-Path: <netdev+bounces-209718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B010B10915
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 13:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91DCC189AF73
	for <lists+netdev@lfdr.de>; Thu, 24 Jul 2025 11:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D9B26CE38;
	Thu, 24 Jul 2025 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wfh+Z05S"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4722202C5D;
	Thu, 24 Jul 2025 11:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753356125; cv=none; b=L6MbyS9+ofF7pgjyyOgS+vWCpf0EMl8DBqkINuAVND75y5dYPDl9PO3Ao4Inp1TSOAemqaJ0G6NtdL8kZa0OxYzE9CD9MfCwNx77OkVmv+u67r/g7imcmcCLO13jpvKZFNr0QADfpo8GMHAGKKFSkFPM94MSJJm0BZv7DZapfds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753356125; c=relaxed/simple;
	bh=3QoIcUL4Kf7Vw5WmCfJMtddC89Ny21lxl3kdlyVYPi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZH2OfFb1MOc1REhUwi0sCvBzgAr4F7q69amLn+HISP8OhPPqRDe7L8rgTelCHP0DkvwhDXkae2AOOTtiDYr9VvsmeEkxMS8dF29/RuD552sWZi0b8Kh0WQkzqWzTc3P7Ikbnq3VlneHJFmGdamjUHwjcgVIbxykjofCfSO9nOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org; spf=none smtp.mailfrom=idosch.org; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wfh+Z05S; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=idosch.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=idosch.org
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 907057A0120;
	Thu, 24 Jul 2025 07:22:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 24 Jul 2025 07:22:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1753356122; x=1753442522; bh=zL2seUE5Fc4Dd5Pi/1e7LNXGUzc9Yu49pe0
	qXMhuH2s=; b=Wfh+Z05SAmNacjQjAeWBtQzLFG/lLni+3DsYwbS38Dm4QbeNjjx
	PnTNSYQCPhzDLj5afJ1vemJ0UjqxILvVMhV1fj8LmbgvWMubUkdeJOW2aD7SZSE0
	e26AK6tVwmKspDOoeuvqjDLWwHHqjDbjU6ztb3M+TT5TqmIW0CMLve64eLXkmVfJ
	5s6OISswPEiwq/T90M30uCrcQxyjXD9lcZT/4yTqiJ4tHRReiF0sF99h7zN8RW4m
	+AKrE8BqU9lIHkU1BCiJbUHUHcqdr8TGq/82hZ0uWriRF0jRyGeKg/joo81QDx7w
	2kEbIAmXjl2phQ6a4ZY0jprAEdojuI190uw==
X-ME-Sender: <xms:WReCaKO7pPO_V6jDcIqxx9ApE4Nd9Ai-WG1usdPbr0b5_CSZn0Ac3Q>
    <xme:WReCaDmGfJNnMCojJ0hliQfC4urfBQbySpKSbfRtcJRyDnuems2UHK1D0Di351943
    qAwOdN_VLJUa50>
X-ME-Received: <xmr:WReCaHQSyuj2v3R4W77MWy3-2SV-oRyI6MVEjr00_Jkhd2E2sxK_u2Qcu-lmM4tG3MJwLS9Q3nuNd83JTuQ8GWHp1b-0iQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdektdehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesthdtredttd
    dtvdenucfhrhhomhepkfguohcuufgthhhimhhmvghluceoihguohhstghhsehiughoshgt
    hhdrohhrgheqnecuggftrfgrthhtvghrnhepvddufeevkeehueegfedtvdevfefgudeife
    duieefgfelkeehgeelgeejjeeggefhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrghdpnhgspghrtg
    hpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshgufhesfhhomhhi
    tghhvghvrdhmvgdprhgtphhtthhopehnvghtuggvvhesvhhgvghrrdhkvghrnhgvlhdroh
    hrghdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofhhtrdhnvghtpdhrtghpthht
    ohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkuhgsrgeskh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdp
    rhgtphhtthhopegushgrhhgvrhhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrnh
    gurhgvfidonhgvthguvghvsehluhhnnhdrtghhpdhrtghpthhtoheplhhinhhugidqkhgv
    rhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WReCaKUPlQ6OD2NUhmdZLi9yidAKHBakaXHE4a2tUpM8FBsGVK3hig>
    <xmx:WReCaDLObRt8S6Hx0Ca-KTQr1myYWGOCVNTGi1s_UODjiWdz5Iqfqw>
    <xmx:WReCaC3wvzoK4yUV5B-qlniQZeuVU5pcHv4uEdLWuZd5zo2GtK_XFA>
    <xmx:WReCaIKychUQXhYKUs1LC5DHiifbsodJRUTsByQJcQ56yTqJqDTpKg>
    <xmx:WheCaHYnWLEeYbFwrvmb-Gn90riqRwThv3iM13pBAGExBpMNKT4BhnG2>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 24 Jul 2025 07:22:00 -0400 (EDT)
Date: Thu, 24 Jul 2025 14:21:38 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, dsahern@kernel.org,
	andrew+netdev@lunn.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] vrf: Drop existing dst reference in
 vrf_ip6_input_dst
Message-ID: <aIIXQiu5i_ABjqA9@shredder>
References: <20250723224625.1340224-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723224625.1340224-1-sdf@fomichev.me>

On Wed, Jul 23, 2025 at 03:46:25PM -0700, Stanislav Fomichev wrote:
> Commit 8fba0fc7b3de ("selftests: tc: Add generic erspan_opts matching support
> for tc-flower") started triggering the following kmemleak warning:

Did you mean

ff3fbcdd4724 ("selftests: tc: Add generic erspan_opts matching support for tc-flower")

?

[...]

> vrf_ip6_input_dst unconditionally sets skb dst entry, add a call to
> skb_dst_drop to drop any existing entry.
> 
> Cc: David Ahern <dsahern@kernel.org>
> Fixes: 9ff74384600a ("net: vrf: Handle ipv6 multicast and link-local addresses")
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

