Return-Path: <netdev+bounces-219990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ABBCAB44108
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 17:52:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D3405878E3
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A1B123A98E;
	Thu,  4 Sep 2025 15:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nf5SLnQ1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15672C8F0
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 15:52:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757001163; cv=none; b=Q4aTtSgUJkxHCYcYQ4oyaToAO9cJtbisJOvS0BvQQzsjQI+prQER4HB6QZ1gby66eUvIRMH6W+uGni54awZbgxiQuyEWbUnf5Msibvt5MVa/+6oFYd4au/gwvZB48ntsB+g/SA016Vv/JCHLbpfLewQ3RznkMRfKaBtgEFxAOpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757001163; c=relaxed/simple;
	bh=2iW9s/TQgZ24CsnIt2T0BwO4FuOQheoKJX4h1ii2/iM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tzH6vMzkLOUlyAbM0/xWQqPg/ap7/7EbDAfQbD+loLa1kuSOiP1dfXe8oPx4iH3VOAd6L1LI+vxjZZFsotcN/dro4lIcuoLfoGT4D0ObiM1uHPAxwi44R8Fca7D8GolbuTmheilgRO1Vsgu3pTi3pSYO1818+U1OUck7oIr+crI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nf5SLnQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 377DBC4CEF0;
	Thu,  4 Sep 2025 15:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757001162;
	bh=2iW9s/TQgZ24CsnIt2T0BwO4FuOQheoKJX4h1ii2/iM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nf5SLnQ1gpboYm8t0SEHWPmTKlW5B+sQKVXd0/ymtNc7Vq+BqwquKEX1wjKKZcncl
	 2V/ZSX5cke0Ltyel0yvu5zOQ3bbVk+FcmYYR/ZxFaBvc12d7RVOd0D6xXY6hF4YK+J
	 B6DhnKnoIutnu1vuxYGPFRBtkNN5iebMRpO4kX/ITtpfvZL9BVVQqfI69K/PllBLYp
	 3GxdsXanyXDtMJhnqKeA80BCm833tbMfxHhrKpMxyt8m08KdTsUCYTt6m5epGU8Z3L
	 z0CsuSTbj9aZ7SgJMX0nyUGv1IiuGdte8GOg8OtswjxXtJHrcY+RIEMxace+ShykKt
	 H3K3Lb6gvtw+Q==
Date: Thu, 4 Sep 2025 08:52:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: ALOK TIWARI <alok.a.tiwari@oracle.com>
Cc: Simon Horman <horms@kernel.org>, dsahern@kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org
Subject: Re: [External] : Re: [PATCH net-next] udp_tunnel: Fix typo using
 netdev_WARN instead of netdev_warn
Message-ID: <20250904085241.3bd40e33@kernel.org>
In-Reply-To: <f45be394-9130-4452-afec-c441f6857708@oracle.com>
References: <20250903195717.2614214-1-alok.a.tiwari@oracle.com>
	<20250904091832.GC372207@horms.kernel.org>
	<e022df33-8759-4fa5-a694-d0d16c51d575@oracle.com>
	<20250904072845.045a162b@kernel.org>
	<f45be394-9130-4452-afec-c441f6857708@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 Sep 2025 20:11:36 +0530 ALOK TIWARI wrote:
> In this case, udp_tunnel_nic_register() returning an error is
> just a failed operation, not a kernel bug. So a simple warning
> message is appropriate, and netdev_warn() should be used
> instead of netdev_WARN().

The distinction should be that WARN is only used in cases which
author of the code expects never to occur.

