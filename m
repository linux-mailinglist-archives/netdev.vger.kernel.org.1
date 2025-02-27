Return-Path: <netdev+bounces-170395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADEE3A487DD
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 19:33:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9F3AA3B533F
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 18:33:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3824B1A238B;
	Thu, 27 Feb 2025 18:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pqi+TuBz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F417482EF;
	Thu, 27 Feb 2025 18:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740681199; cv=none; b=ZIw3FR9CjzGivkJEhIMxywrE62yzmgzWGjdscahmIGM3ilPZ6OEVlkBMm0GQ0wKQoL3/ruzQjVL7lriPvFh9tkDdzRvLbq47Gc4nene6MJrLCTclztsIMdH+wlGUpXO8evwWZq0mvmUg6w/aHLx7LA/Yeeo9t+ZYnqLKqVH7NTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740681199; c=relaxed/simple;
	bh=5zO2sMUdww/0PKQQ7XQWZwl6TO6ANuKajBElPGQjDBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XSUx5cdmWMmI6wVBpqoDTlMFw5wpOK6vIg4vvJ19gmOLhhrMF6AWZBtX0gpFvznGET1NBMPmxEh2rkDLW0McSLcqQq+X5yOeSbeNLYRCU2+T55P3Xr9artoYrkXA4ij5ftF5sfoVZ+svT66T2IYK4oXYxrqbUJpOBZAS0uN99BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pqi+TuBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80AD4C4CEDD;
	Thu, 27 Feb 2025 18:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740681198;
	bh=5zO2sMUdww/0PKQQ7XQWZwl6TO6ANuKajBElPGQjDBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pqi+TuBzc+S4O3hORmYchi60tjrW+Izypmmq1KSnh5v8vdSXpuFzzW5u8q2VvXBUs
	 uYZbra9I14sk3x3FVfDW57vW17UlSObe8FLiCvUhgHagGJr5R1mswAQLvRRykoovBO
	 1qvqSWbVtI47CPr7QjpjxRonJfwglPmq6DMfIfLZNBiDYCViPFipRnTorIEyiHlq0G
	 7TbPnV5BVo1M/7K6EGMFxWgs0kyeiemo6fUsbt+wJC5EACx/nmD0Jrd+mBbib2DzM3
	 DEMtiXT1dx5zJa4iC+nQMfQ4SYY2YxQKNgJhxhBUeQ9C5hbL/8veh1Ta1nf+BEG9uV
	 XeTXzoHBjQckw==
Date: Thu, 27 Feb 2025 18:33:14 +0000
From: Simon Horman <horms@kernel.org>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Manish Chopra <manishc@marvell.com>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: qed: make 'qed_ll2_ops_pass' as __maybe_unused
Message-ID: <20250227183314.GJ1615191@kernel.org>
References: <20250225200926.4057723-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250225200926.4057723-1-arnd@kernel.org>

+ Andrew, Dave, Eric, Jakub, and Paolo

On Tue, Feb 25, 2025 at 09:09:23PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc warns about unused const variables even in header files when
> building with W=1:
> 
>     In file included from include/linux/qed/qed_rdma_if.h:14,
>                      from drivers/net/ethernet/qlogic/qed/qed_rdma.h:16,
>                      from drivers/net/ethernet/qlogic/qed/qed_cxt.c:23:
>     include/linux/qed/qed_ll2_if.h:270:33: error: 'qed_ll2_ops_pass' defined but not used [-Werror=unused-const-variable=]
>       270 | static const struct qed_ll2_ops qed_ll2_ops_pass = {
> 
> This one is intentional, so mark it as __maybe_unused to it can be
> included from a file that doesn't use this variable.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

This is marked as being not a local patch in netdev patchwork.
That doesn't seem right to me and perhaps this will address that.

pw-bot: under-review

Possibly this because is because while qed_rdma_if.h is
included in the QLOGIC QL4xxx ETHERNET DRIVER section
of MAINTAINERS, it is not included in the NETWORKING DRIVERS section.

I will plan to submit a patch to address that.

