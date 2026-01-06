Return-Path: <netdev+bounces-247274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A44B9CF6651
	for <lists+netdev@lfdr.de>; Tue, 06 Jan 2026 02:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2985C300954E
	for <lists+netdev@lfdr.de>; Tue,  6 Jan 2026 01:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E2520C00A;
	Tue,  6 Jan 2026 01:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dq5WVvS5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3A71A3166
	for <netdev@vger.kernel.org>; Tue,  6 Jan 2026 01:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767664448; cv=none; b=K/J8A9Mab8dBVlyKHJtN6q18slFhClKCchgvTd0k021gGXbEPR7tkhHa3/mXeXKNrYnBSv3MFKbVAo6O/ImozHW6JBS1H6j42zHcnY9o5zdc/zk/8SQaQQFQmnQc8GCQ3Ur2codOm13QvB4lJnzEF/UYF1XWhIkCwhCGDgKJRH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767664448; c=relaxed/simple;
	bh=Iexa5sCPpxJeHFD9yI1C6QGcgUlkkIjKf4Ey8fLD4aE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOTiX4q1H7Nx0K6AEYN+XY62dtGFnBdOgEqg2PTY9CdyGtWBNaTOHz0LMXV5CzKT5pkZNFk31DVAJ8OH3f0LUojQ/9fIwtyqw+BC/DUe5WxzHQ+94w10Ak5DJZVe5bne9hQhOQL9ggdYdZN/V1ZOi1tWVJfQ2YECHJ6GMx9hmXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dq5WVvS5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8932BC116D0;
	Tue,  6 Jan 2026 01:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767664448;
	bh=Iexa5sCPpxJeHFD9yI1C6QGcgUlkkIjKf4Ey8fLD4aE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Dq5WVvS5Qccyi4Jv/i6X0tK43mfggiPBhWtFVpDan0fWoy/M4TaenMi/mf75/IsrA
	 9cWzCtj4Yjtu8QBziUeXM6gR+x+kqU/c3JRCTlSCnRvIYeUdp4+yZcV2OXxEOkcyka
	 C+GipFLkn5qr3vrBK4sQOtVXafql9RkDrWphIeFSy0D+CNsCY+0vZP7UhziV2D9jt7
	 0ThiWVu71bMhke+rkHpjweV4Edh9WJFVU9qUN2POArO57BpjNjRZ36MYf5CFpwTBNa
	 K4EE/Fh6+BoEQLg6CnhgzsHSoVShuxf+KUStjOQt2cG7MXjW0//PMHJT5noMoAsOA5
	 4wgohHNzFWYCg==
Date: Mon, 5 Jan 2026 17:54:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Mahdi Faramarzpour <mahdifrmx@gmail.com>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next] udp: add drop count for packets in
 udp_prod_queue
Message-ID: <20260105175406.3bd4f862@kernel.org>
In-Reply-To: <20260105114732.140719-1-mahdifrmx@gmail.com>
References: <20260105114732.140719-1-mahdifrmx@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  5 Jan 2026 15:17:32 +0330 Mahdi Faramarzpour wrote:
> This commit adds SNMP drop count increment for the packets in
> per NUMA queues which were introduced in commit b650bf0977d3
> ("udp: remove busylock and add per NUMA queues").

You must not submit more than one version of a patch within a 24h
period.

