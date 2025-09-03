Return-Path: <netdev+bounces-219407-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1455EB4128A
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 04:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9801B61C35
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 02:47:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C568145346;
	Wed,  3 Sep 2025 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K9YSYUdk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A713594B
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 02:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756867634; cv=none; b=lrCZ8qf2rfybJpURHG/u6gImvHoBh7gYbq18nba2IH3qkTzVMmYqjrEOhD2z/+Wq0G+B3tk6UklFmZmLyTSTDL3N54MNLi0cowwdGvQPwCA/BVcnQEmvoN5l+Pl2BTqTj6FS1PdmxGwoee49X5uVw45nNhg7FXpj9r2Wn26spmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756867634; c=relaxed/simple;
	bh=ugXp/xE+PZId6xfnkYzdeAQULy/s5lZbg9lJ7p5Gqfk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pLZJNja6UpjZmeafOglxbL/nzIArw5on9uBGm477J50eluWAc/ge57ha/Durkzfl7kn/jG+RhfodxtCO73nQOQ/6zSHiFGlWx8viTa+Uda9mSYRoLP//vDKyep90mMElpNMdpvMTHkSAslvDt0K/5fG8x3y6+rv3+VNlVOL03q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9YSYUdk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96FE7C4CEED;
	Wed,  3 Sep 2025 02:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756867633;
	bh=ugXp/xE+PZId6xfnkYzdeAQULy/s5lZbg9lJ7p5Gqfk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=K9YSYUdkENbOhex2p1NPxh3U8La0l0XqSVCw2yVuwgGQ+bu0ZK0s5q9KqywCqcN+E
	 5Y/z8/e1G07Iurz2OcAeUTChHiXam/Qm2u/3h3G7Q6VtI6NA/WEd4OXijKN7yLqJi4
	 5BaJ4qOR8UYSHh+tf0tuEm5LexEE0puz/rIRaKr+EmkgMaQ5b+aZERxEfmpZnzEUPg
	 ZvKWphkmugZ0DhAWhQMHWZNcBoIKQKWVA4QgLKRCeU5sM0LuEtxJrBW0zWn90AU9kF
	 7o+FprMCz9tpgz1K4EgFI1ReosCkHWak1pvon2T23uo3dD+FMwciZv7wT14EWcjBFz
	 Oqz6CknaY1fKw==
Date: Tue, 2 Sep 2025 19:47:12 -0700
From: Saeed Mahameed <saeed@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Daniel Zahka <daniel.zahka@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Boris Pismenny <borisp@nvidia.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>, Jianbo Liu <jianbol@nvidia.com>,
	Dragos Tatulea <dtatulea@nvidia.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Kiran Kella <kiran.kella@broadcom.com>,
	Jacob Keller <jacob.e.keller@intel.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v10 00/19] add basic PSP encryption for TCP
 connections
Message-ID: <aLesMHHTHWtbbugi@x130>
References: <20250828162953.2707727-1-daniel.zahka@gmail.com>
 <aLdIUZbwF83DbUiv@x130>
 <20250902130836.65e4af41@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20250902130836.65e4af41@kernel.org>

On 02 Sep 13:08, Jakub Kicinski wrote:
>On Tue, 2 Sep 2025 12:41:05 -0700 Saeed Mahameed wrote:
>> Also As Jakub pointed out on V7, mlx5_ifc changes need to be separated into
>> own patch, "net/mlx5e: Support PSP offload functionality" need to split at
>> the point where we cache ps caps on driver load, so main.c and mlx5_if.c in
>> that patch have to go into own patch and then pulled into mlx5-next branch
>> to avoid any conflict. Let me know if you need any assistance.
>
>Could you take the ifc.h changes as one patch into mlx5-next and send
>a PR, ASAP?

Sure, later tonight, if not, then tomorrow morning.

