Return-Path: <netdev+bounces-221032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C21CB49EAD
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 03:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5BF4E67EB
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 01:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2113320013A;
	Tue,  9 Sep 2025 01:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UuAKSTDe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0C351B4236
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 01:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757381291; cv=none; b=RhVKaquaRDNj6CkXxUlY1SseUFk24d/ZBrhxP6kQLxG5q+cpEZMCbnvX48QHrsJgy4n/28rOKI0/pUHr+DSyEtXn4o6I+m2f3XCB3e7IO1Qyv5FAbUJe8UtJQ6CArCrK1EFBQ5bPBfmF5PdNLyEv+bvlJLpTNp6pkxnVh6qn/Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757381291; c=relaxed/simple;
	bh=8QrCi0hmWQf8wqacpkyagQTgitA/qW7966oaWJzXvq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lxM/2VICxi/NvsvH9GmO8D3PyQuILle9CpXxyT2R4Z0XRPhSvaQFdQKB0qMa9/xrWbU1sx2BCf8PEnTj61no41ThRfQ1gusbTgszjGLS6+ECXPXCOtKIfhHi+EwSCKDGFaClGJOwmpS3OIxRxSuxfE+cLFmfb9l/CNHSSysSHZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UuAKSTDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239BBC4CEF1;
	Tue,  9 Sep 2025 01:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757381290;
	bh=8QrCi0hmWQf8wqacpkyagQTgitA/qW7966oaWJzXvq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UuAKSTDeFkcve0mTiXuXSblTOLwS4PN3o5HcfXiWKUYmKij8ttNEb5s+l9HniCNyV
	 AH5hk2y/Pyod+uK4Mgoj4v23ku0lbUn2gvKrJHAE5IQFrxN71eOXY6573Nx1jHD99z
	 4347T3C27oRMp72Kegz22sAy4qGhfpddMgqMmqL9TrMDnkwYJocRKipJQZXG7aBRlb
	 Onq+6C6b82hLG+yy2YEZs/M+g2aeBpzxUlGT+5j4aN33GdExnxYyBul6+iiBSYQY+E
	 rDOU2WDZ39+uZrZJQJvNirVTp6fhAsaPzA8d9WT+pYGm6+XJ+bdaTCpCBYku6riqrz
	 aY9MuvhrZMXeA==
Date: Mon, 8 Sep 2025 18:28:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: dsahern@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 net-next] udp_tunnel: use netdev_warn() instead of
 netdev_WARN()
Message-ID: <20250908182809.3e5a9fdf@kernel.org>
In-Reply-To: <20250905055927.2994625-1-alok.a.tiwari@oracle.com>
References: <20250905055927.2994625-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Sep 2025 22:59:22 -0700 Alok Tiwari wrote:
> netdev_WARN() uses WARN/WARN_ON to print a backtrace along with
> file and line information. In this case, udp_tunnel_nic_register()
> returning an error is just a failed operation, not a kernel bug.

This still lacks specificity. Take a look at the code and list
the code path which can ordinarily fail.

> A simple warning message is sufficient, so use netdev_warn()
> instead of netdev_WARN().
> 
> The netdev_WARN use was a typo/misuse.
-- 
pw-bot: cr

