Return-Path: <netdev+bounces-223313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C4ECB58B45
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 550241627D3
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9977D1E379B;
	Tue, 16 Sep 2025 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJxQfBNS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74E961C84B8
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 01:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986399; cv=none; b=vA5BYHmZTKRAxfp+g7OzJfRL0w0MI2uUpIVMjUSG5Hcy6pT9RJNT/y6FCTKy+LtSzV9MBW3TZrZ7YBDbakG0HDVff8FtJ/zgNJ3wUtrCuMrB2wBdh3J/GjNGX2LGigcKERbrjz6qUYXUOkupv/e+IElsQkxLU3CHNWhm/zZw+rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986399; c=relaxed/simple;
	bh=8BeD75Ur25XeewP1A8ohq7ewBj/Hxd74u49vcALJgVc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BJISwJw7+nIgULISv2L2pypu+WkzQHGIcQl1Aym9KQ6iWn9orZiLqmV5dvVdbFWv2AK+FES7tWFg+DKH5arNPQvP2voKbWjiWLbnPqZeMM+SoX7wsxvZktJDdxWsZ5BNGcONsM5AQjhIdG0qe+UYNORAzglftLwKHYd9m6AQaRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJxQfBNS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D551C4CEF1;
	Tue, 16 Sep 2025 01:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757986399;
	bh=8BeD75Ur25XeewP1A8ohq7ewBj/Hxd74u49vcALJgVc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UJxQfBNSeD4k2bRLsheE4O9c797Qy20dbVQJHVky3fUVRRCdVniBCgo9gEo9WVIpn
	 a9F0VHChzmQMzSl19HOUN1wneAIDuhpy6J89UjsuE5TgtR/C5VCAXPK9KuE0WjSTAW
	 Va5TPUtohJQfxXtKJlAF5iN9BE4a1NkKyX5vUSYEnYf/VDLx2BTkdSyvvU5b/Ac8DG
	 gbbqK0SASU7ylzMpyyPcIs9CRJp+iPMrq6Ux549Sq9SAvEoyoa6dDq73RY52mvkhy8
	 rBmeIaf6/i/QGxhndpWc2EqgL52zJjVfZDpPOqT9sSS8cbZ2Q1FLsWulyzQVZjLQYk
	 S49EAliQIjLaA==
Date: Mon, 15 Sep 2025 18:33:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alok Tiwari <alok.a.tiwari@oracle.com>
Cc: kuniyu@google.com, sdf@fomichev.me, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: rtnetlink: fix typos in comments
Message-ID: <20250915183317.53f37f3c@kernel.org>
In-Reply-To: <20250913105728.3988422-1-alok.a.tiwari@oracle.com>
References: <20250913105728.3988422-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 13 Sep 2025 03:57:26 -0700 Alok Tiwari wrote:
> - Fixed typo "bugwards compatibility" -> "backwards compatibility"

This is an intentional portmanteau. It means something which was
initially introduced unintentionally (bug) but we need to maintain
it due to backwards compatibility.
-- 
pw-bot: cr

