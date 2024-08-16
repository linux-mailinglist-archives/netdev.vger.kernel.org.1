Return-Path: <netdev+bounces-119051-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1671D953EF1
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 03:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 399DE1C20C16
	for <lists+netdev@lfdr.de>; Fri, 16 Aug 2024 01:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE1EC17BA1;
	Fri, 16 Aug 2024 01:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vIUkb9l/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F7A1AC8BA
	for <netdev@vger.kernel.org>; Fri, 16 Aug 2024 01:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723772213; cv=none; b=ZXz/vBo4whnmSfajy6c/p+GYwL3mReE1JXcDyIv8CMzJOiFjqAC9dZAE64NG+zCCp/hMQLIJY9YMWQVpSq30P/1rNKjOwPQ1CBFOx5xzHKGzyqjI1c1ogYXUm/gkccIGTVbqZNT9GfGgqXPiDBGsyGJSiIm8c07bw0j1MFd3KNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723772213; c=relaxed/simple;
	bh=rYJTkxDLB8TDVnYX+SO9kxh/awCb5QXSJj/HKWnjxUQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=luOkN98w++cZZIMh7KT/vREUEA4EKByltHRDhzyvnvEs+OUDNtwq3cb0CxcNciqPYy+Iy5T47ZVmgKr5cM4xz1EMHnzrmxXApmeko7KwbNg54G1f9xoKd/a4/coZHp0Rim2ATlhEmvUGALm4/I4BrbDuvKzFMShAflwPcaGMxjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vIUkb9l/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F546C32786;
	Fri, 16 Aug 2024 01:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723772213;
	bh=rYJTkxDLB8TDVnYX+SO9kxh/awCb5QXSJj/HKWnjxUQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=vIUkb9l/nDmjLs94Nj0HQnIDUUPESX2MDpVBYuUtTFgokA3NDpWxEoRBeD1rLdCiV
	 pkT2vohCDrCxwgH0Qz2NFXguielp3BtqRnPqlAPl60r5QdZQ2XbVVRIjRjXa4TW4Wn
	 Tu7roM0+rPYCkePJaW9AF1/HHBRs0HRRa1YxQwVSh84f7VPj+onwBMFqksnacDXSeP
	 XBSyrjyY0jbvgMHdRH2rnTk2hoo08/+6jC1t3M/hPKf/AUI1n6YJMUAwEaQpoKBY7b
	 ETKQZT5GGiVm+rA8dCaZoYEeBd12Eteav+ub9T3XTFHr547JLYdygNJW4MrJvLm/vb
	 a1ixoKXbOueoQ==
Date: Thu, 15 Aug 2024 18:36:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, David Ahern
 <dsahern@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
 <razor@blackwall.org>, Kuniyuki Iwashima <kuni1840@gmail.com>,
 <netdev@vger.kernel.org>
Subject: Re: [PATCH v1 net-next 0/2] net: Clean up
 af_ops->{get_link_af_size,fill_link_af}().
Message-ID: <20240815183651.7692863f@kernel.org>
In-Reply-To: <20240815211137.62280-1-kuniyu@amazon.com>
References: <20240815211137.62280-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 15 Aug 2024 14:11:35 -0700 Kuniyuki Iwashima wrote:
> Since commit 5fa85a09390c ("net: core: rcu-ify rtnl af_ops"),
> af_ops->{get_link_af_size,fill_link_af}() are called under RCU.
> 
> Patch 1 makes the context clear and patch 2 removes unnecessary
> rcu_read_lock().

Tests violently disagree.

https://netdev.bots.linux.dev/contest.html?branch=net-next-2024-08-16--00-00&pw-n=0&pass=0
-- 
pw-bot: cr

