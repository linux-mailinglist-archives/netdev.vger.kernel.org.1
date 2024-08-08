Return-Path: <netdev+bounces-116963-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49AEE94C36F
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 19:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 782C61C21C39
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 17:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4160190668;
	Thu,  8 Aug 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="huI7wj+C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCD9F82C7E
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 17:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723137292; cv=none; b=iOBdLIBb4w5Q0R1TVUNE/zC/avN9pjXLpzZWZgpIzGRbjQjXBpJ909j8vYNPqtxwuR6+Ga4eH4gYjoz2ra8End1HKLwB64EVYTLV4BTrdwgCLgkkl1kzLUngkZT2IUG0QYHkVuNoH+LCS0GABuJ53gUit9RJu731NJXpw5Vjt4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723137292; c=relaxed/simple;
	bh=BSxPKokXifqXAuuNytqdmWeR4R/9ka4tJRnP9HmGaME=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Na9jAP31d+ZTDBRSe/GqzrOUhPR6cubinLVVrXhmEEaK4ABbfBJQ0kjMIpaL3wH8T7kREZFVW3vS39kVeAq24znTmbHBHb/jEaBfHpsC5LAze1l8/qU7XWJ6BaoduHpHMkpENkeKfOcn7OGpOKNIjiqUybC3gcA9z2DfnSL8WsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=huI7wj+C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09D27C32782;
	Thu,  8 Aug 2024 17:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723137292;
	bh=BSxPKokXifqXAuuNytqdmWeR4R/9ka4tJRnP9HmGaME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=huI7wj+CQakz1JpPumPeG0Kl8vWuCGpyo0yb+zY4u21GRerkA6gorhUpYQZ7iqf6s
	 2ZKGmzBMH36O6gDCWRzl31WFYOqmp3Sj4Z6OUd46ypfBEitH/4tBuok6jyCQiesmst
	 kUu4gRsE5QoFAyGlKQc8K0sEoz+6rf8BgeHSkhlJ3/ykUDE6fnUQIuSndoEhD4gqn5
	 iuwf3XIcJYQoW9VSxDj0SZGou7huW2ISF62wBJ2MiTLKJ5jmHGKeqboN8e6FmqfzkO
	 GhFcTjw/WQWtgGk0fqoQE7/V8Ye6Gzq1AaclQmF5qyckanGb9AEg6BumGhYgFS/K7x
	 vvZDLabAhnIzw==
Date: Thu, 8 Aug 2024 10:14:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 alexanderduyck@fb.com, jdamato@fastly.com
Subject: Re: [PATCH net-next v2 1/2] eth: fbnic: add basic rtnl stats
Message-ID: <20240808101451.705d2ec0@kernel.org>
In-Reply-To: <20240808170915.2114410-2-kuba@kernel.org>
References: <20240808170915.2114410-1-kuba@kernel.org>
	<20240808170915.2114410-2-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  8 Aug 2024 10:09:14 -0700 Jakub Kicinski wrote:
> +struct fbnic_queue_stats {
> +	u64 packets;
> +	u64 bytes;
> +	u64 dropped;
> +	struct u64_stats_sync syncp;
> +};

Ugh, I missed init for the syncp..
-- 
pw-bot: cr

