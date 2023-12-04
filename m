Return-Path: <netdev+bounces-53574-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2B6803CA0
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 19:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 342E61F2129D
	for <lists+netdev@lfdr.de>; Mon,  4 Dec 2023 18:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3382EAFD;
	Mon,  4 Dec 2023 18:17:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EY6Wg9CF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011052F535
	for <netdev@vger.kernel.org>; Mon,  4 Dec 2023 18:17:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF95EC433C7;
	Mon,  4 Dec 2023 18:17:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701713826;
	bh=O9jMoH3GgbqP+5VSbExuDAb4FSVdJm/9DpXRc5gVWGE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EY6Wg9CFZsn6usr2KQGr4VQNMAlAkH+LUidLzu9YX1AyGy9kxQzkoino1KKpT/jbD
	 uRvD/4NAOWlZIp3ECAUn2/f2MMa8haRnC2pifjFzjHDxtybYKORRhhwpNGwSZZBx3k
	 cjvykgwkvu6MBc0cNMwEgIPRiRg9doUuU6y5ce6GP0OI+ElSNE8uq7hcRTGi8U6pz9
	 QlJ7iO/dSDt6O5e2EV9B+o0CX3l4wCNgaUPuwsncH+P4EIl4H0cXi8vpED/stKPi78
	 zc3xncb00mFI3UCXzK4490UeWwQsG1hHdsvSP0FH8w/3QCa4Kb+RWxdJRAB1d5Kqq6
	 kIVprKL4X+/Uw==
Date: Mon, 4 Dec 2023 10:17:05 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: "Austin, Alex (DCCG)" <alexaust@amd.com>, Alex Austin
 <alex.austin@amd.com>, netdev@vger.kernel.org, linux-net-drivers@amd.com,
 ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, richardcochran@gmail.com,
 lorenzo@kernel.org, memxor@gmail.com, alardam@gmail.com,
 bhelgaas@google.com
Subject: Re: [PATCH net-next 1/2] sfc: Implement ndo_hwtstamp_(get|set)
Message-ID: <20231204101705.1f063d03@kernel.org>
In-Reply-To: <20231204110035.js5zq4z6h4yfhgz5@skbuf>
References: <20231130135826.19018-1-alex.austin@amd.com>
	<20231130135826.19018-2-alex.austin@amd.com>
	<20231201192531.2d35fb39@kernel.org>
	<ca89ea1b-eaa5-4429-b99c-cf0e40c248db@amd.com>
	<20231204110035.js5zq4z6h4yfhgz5@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 4 Dec 2023 13:00:35 +0200 Vladimir Oltean wrote:
> If I may intervene. The "request state" will ultimately go away once all
> drivers are converted. I know it's more fragile and not all fields are
> valid, but I think I would like drivers to store the kernel_ variant of
> the structure, because more stuff will be added to the kernel_ variant
> in the future (the hwtstamp provider + qualifier), and doing this from
> the beginning will avoid reworking them again.

Okay, you know the direction of this work better, so:

pw-bot: under-review

Report-bugs-to: Vladimir Oltean <olteanv@gmail.com>

:P

