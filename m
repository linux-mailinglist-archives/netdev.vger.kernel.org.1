Return-Path: <netdev+bounces-159583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F122A15FB6
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 02:18:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F623A59DC
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 01:18:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCB7C8E0;
	Sun, 19 Jan 2025 01:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FypJzpKX"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF6C33F3;
	Sun, 19 Jan 2025 01:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737249520; cv=none; b=NnJNMHocxGIOvY0wHKy0hVf3CFefmbHihTJpxC6H/gikLkDRMnaEJATRbNEXirDQpCTwKEj4Afq0qbxwucfDO5udehr1BGl7XvDJc1nxTLz9D6bBEhn7Qlfbpls/nIaSP1AiAuQrgp5edHnW3s5M/2hY4DQNEed/O46HKYDLBuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737249520; c=relaxed/simple;
	bh=jMKpCmcqxvK3DzGSgrWoq4Cf+fLj1e49WAIOl9sn4Bw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Adc0CobJkV3OUEV6HZEaUFENqdInigx+Ku7qgEgxLj3bcj3NpthvK6Snmb+tiKhB0YjEd61Tq3QgAu01f6gUGZt8a+UbqByvshZVYfvW/7PfnXb1RG7emO+WAiUowXHATKv3Vf1qHEmWI+bZm/fbE80f5gG7wDhFvX5SXXEBFP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FypJzpKX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B37C4CED1;
	Sun, 19 Jan 2025 01:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737249519;
	bh=jMKpCmcqxvK3DzGSgrWoq4Cf+fLj1e49WAIOl9sn4Bw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FypJzpKXhRnecHOXBnK4x7g/SScCG/2nh+yqlCEizq567Kq/kBgEru/17+9uCocP5
	 eJe1BcJaoMGYagxJe6FvZZ3SPKfNzAS89vwZ5sIgR4+J6j9/NGyrEdwH2ZipmogB9Q
	 steQy6Y/gxSA64JEC69CiF+yQZrQIk5V1iINWkjpJeWcDTISTnOUZC6K5uWpcNG2Fj
	 BLe67d7mhG3sYShHECxv6zv5TR7xGKNQpYMWLfVCSbdeeYuNzjGgngxNKHKdnwA3hc
	 9i4R47cU8S/Wo/o9rIwkR58wRiyySpmHQ0XOXF45SI0ezGeuLlwTh8MDT8tLH5wfyV
	 REdq7OprwISqQ==
Date: Sat, 18 Jan 2025 17:18:38 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Radhey Shyam Pandey
 <radhey.shyam.pandey@amd.com>, netdev@vger.kernel.org, Michal Simek
 <michal.simek@amd.com>, linux-kernel@vger.kernel.org, Shannon Nelson
 <shannon.nelson@amd.com>, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next v4 5/6] net: xilinx: axienet: Get coalesce
 parameters from driver state
Message-ID: <20250118171838.215e58ec@kernel.org>
In-Reply-To: <20250116232954.2696930-6-sean.anderson@linux.dev>
References: <20250116232954.2696930-1-sean.anderson@linux.dev>
	<20250116232954.2696930-6-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 16 Jan 2025 18:29:53 -0500 Sean Anderson wrote:
> +/**
> + * axienet_cr_params() - Extract coalesce parameters from the CR
> + * @lp: Device private data
> + * @cr: The control register to parse
> + * @count: Number of packets before an interrupt
> + * @usec: Idle time (in usec) before an interrupt
> + */
> +static void axienet_coalesce_params(struct axienet_local *lp, u32 cr,
> +				    u32 *count, u32 *usec)

W=1 builds hit:

drivers/net/ethernet/xilinx/xilinx_axienet_main.c:277: warning: expecting prototype for axienet_cr_params(). Prototype was for axienet_coalesce_params() instead

I'll apply the first 2 patches, 2nd one is almost a fix..
The rest may need to wait until after the merge window, unless Linus
tags -rc8.

