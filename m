Return-Path: <netdev+bounces-74219-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8FD860846
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 02:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1CE51C21D70
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 01:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018AD947A;
	Fri, 23 Feb 2024 01:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T/9MXMvq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0252C9E
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 01:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708652028; cv=none; b=KPIbZnHLq0KXbKrqhYAqKMRrUI6WzYMdjK3JjPUKl4bnCXVGdNs3HSaHRlGwOGniCOoT6tqLHswEH5N/B0ZqO23I/8nx7PF77vLMuEN2gepxOLwY4HHOBQPxacRURr3DSGwP/P7Oa3bOujCjLW6LAaqGRGcgg2Sb3XYl8ZBmdYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708652028; c=relaxed/simple;
	bh=8eN5mZ2LCf+HJbWgyeqDRvmNc5bYhMr0wjoDejhz28Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWIz3oCsLb2BjW8OH1f1yk3zSsRqS2XzWV2p24ioJ8gh5QlhO0LlP7I5RMlrq9Sru788NHGW1sKhcwqwueEjdq/7YCg7SsVXGDa3/Gu0R50ABdtlkDMK2/a4OFXCTZePHPjTnJ7+aqSu5jG0Wu04oMRFqR9uSPg3G2jEmFX10Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T/9MXMvq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C6BC433F1;
	Fri, 23 Feb 2024 01:33:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708652027;
	bh=8eN5mZ2LCf+HJbWgyeqDRvmNc5bYhMr0wjoDejhz28Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=T/9MXMvqPgvjDAozzIjN9JoFCq2MzHdG5TO9HZTvRYsCjuev5rEO8dFjol3o3YLQC
	 Iub9eVhjRs3CT11FRyXNt0ncpG0kS84SUItdVouP1nARJM6cmp7kqExjl86x7nIHFG
	 H9jK/diCrtjcA58PQ+RruYWH7nJ/1zFlge+K1Iw3gja822HxglrjGzRH3rlpOwiQzL
	 fWmGib/1FdrRlcRUblCySf/MsHj2av48lY51yzkbkO9c3YBcNEaj6LJiyJOYzTJLEx
	 dTz5zahY4BFmLe8VPkmgFcHQjIFtvnP5WWpzHj9y0mPTnkhjtF6xKJagwVcweaUhZD
	 MsqoYS3tMJ8VQ==
Date: Thu, 22 Feb 2024 17:33:45 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Nambiar, Amritha" <amritha.nambiar@intel.com>
Cc: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
 <pabeni@redhat.com>, <danielj@nvidia.com>, <mst@redhat.com>,
 <michael.chan@broadcom.com>
Subject: Re: [RFC net-next 3/3] eth: bnxt: support per-queue statistics
Message-ID: <20240222173345.518d32fc@kernel.org>
In-Reply-To: <7d89adc1-2d2d-4681-b6a8-166221639997@intel.com>
References: <20240222223629.158254-1-kuba@kernel.org>
	<20240222223629.158254-4-kuba@kernel.org>
	<7d89adc1-2d2d-4681-b6a8-166221639997@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Feb 2024 16:29:15 -0800 Nambiar, Amritha wrote:
> So, with projection: 0, the counters would remain unchanged after 
> reconfiguration ?

Yes, device level stats (projection 0) should maintain history across
reconfig - some form of explicit ethtool --reset $ifc or devlink reload
may reset them but not changing ring count, attaching XDP or alike.

Queue level stats (projection 1 or "queue") can be reset when queue is
recreated, for some drivers doesn't matter but probably better if
reconfigs reset them.

I mentioned this in a kdoc comment on struct netdev_stat_ops - the
justification for different reset regimes is (1) to make driver
implementations easier but also (2) because the main (only?) known use
case for queue stats is to check if traffic is balanced. If we run with
4 queues and then bump to 8, and stats are not reset, the first 4 queues
will have much higher counters. So it's hard to tell from a snapshot if
traffic is balanced or not.

