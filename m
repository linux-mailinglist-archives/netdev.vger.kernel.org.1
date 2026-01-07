Return-Path: <netdev+bounces-247516-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A0654CFB76A
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 01:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54710309670F
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 00:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 280441C8626;
	Wed,  7 Jan 2026 00:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLnpJWkv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0287317C21C
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 00:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767745499; cv=none; b=T5DcJJ1KOQjCNlVGMMsIjyaw14/WeeMOFwa7JVYFVVD32DrFiKIg0wG/V/MTWwd9dFitBTHca6tugNjcFqrpLZ59gjz8yPf9Tf0VfzdukyqjBxbVnGHU0bYP82u7zmqVTltDb/EaJeW5MimeUhhf6HJND++qi00YMvYfp9dzfy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767745499; c=relaxed/simple;
	bh=4yz7SAZrElr31jPuxI5ovVwFRh6NpkT8Na1DC4XZbAk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RWjQxbaonBLfeL2E3BbfB+hW/tDlKvtCPnugS/6feZC6HHRuKEh3En+NnjmHEqAZ4/XhiXZUPhqu655UegRaY/E8M/sTPy7/yTH9rFItSUkbUJN9XYegUrYrDt5JbDJiJGNX3+SINhQwFxCN/CTzrBc+a9Nb5iCceUV2mFlOmog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLnpJWkv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1212FC116C6;
	Wed,  7 Jan 2026 00:24:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767745498;
	bh=4yz7SAZrElr31jPuxI5ovVwFRh6NpkT8Na1DC4XZbAk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QLnpJWkvCGS3gNuPVIHaeBUXAL9gAl9YwgDNvg5h2EieseWFiVImnICybM70+Vmvu
	 kecxKALB8LmDva4uFcnJOwprm0fNhuB5iWUye59HarJj0rjc8Xe5WrLZGuoH7Dbcw9
	 A1hNztroM6IsAL797E240F7tk/0i6sA6mCLe+v24vk3X+yc+Uu/UdTpbA0GBgWgVVm
	 fQI9HBJpAu1gCk6tJjcZYloA0iMiNSFNgDwr2+DSY3y6BSGipsF/NB8MSPzCOrYhu2
	 lmH+me/mNhQaWr1/lENtW7dOcePs6hN9A6+rRuP0YWa2lGCRaa5sEb6lFMzpJJmtNo
	 kjZIm1P9Yfzbg==
Date: Tue, 6 Jan 2026 16:24:56 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Tonghao Zhang <tonghao@bamaicloud.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jonathan Corbet
 <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>, Nikolay Aleksandrov
 <razor@blackwall.org>, Hangbin Liu <liuhangbin@gmail.com>, Jason Xing
 <kerneljasonxing@gmail.com>
Subject: Re: [PATCH RESEND net-next v4 0/4] A series of minor optimizations
 of the bonding module
Message-ID: <20260106162456.6158d8be@kernel.org>
In-Reply-To: <cover.1767000122.git.tonghao@bamaicloud.com>
References: <cover.1767000122.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  3 Jan 2026 17:49:42 +0800 Tonghao Zhang wrote:
> These patches mainly target the peer notify mechanism of the bonding module.
> Including updates of peer notify, lock races, etc. For more information, please
> refer to the patch.

FTR this patch series was marked as Deferred by someone, not clear 
to me who and why. Please wait a day to see if anyone speaks up
and repost.

