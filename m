Return-Path: <netdev+bounces-78243-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A654D87477E
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 05:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D535B1C20432
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 04:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81EFF63CF;
	Thu,  7 Mar 2024 04:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rKaFtA8r"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5F91FDD
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 04:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709787218; cv=none; b=kNrEi7nycz0PckcxXDZsOJoTGeovzCzyQp0HGtoFFnnYP2ukY/nPwxcxVVyoz5NfBdvw8EEn1c5jEk/zX7HdnfGaCpO3qG5fi8yghd3tzqqyhCgRNveufLRpP2d5PryW/qZkqcpkSHFafv/qnUCM7OkgzeLTbiKvc2t3Ih2S0Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709787218; c=relaxed/simple;
	bh=ciW4Y2BvJYakxgezeAq5o25RGJSVSjCoSl7n9EIC/XE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Grb8RaDEA/IIJDcDE66CeGO+erwrj+Nh4cG301RCB4hztSg9k5Ky8X5re6e1JgE3vY9Ym464WyRPjsfg1lCug2isU5j5zOu1B7u1irPuxoxMLDf8ucWr/s3SU0b3aP06pHfVt0DSO+UxapG5RRZCuk9UQmXWeIvD3pG4JdOsW/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rKaFtA8r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 895D3C433F1;
	Thu,  7 Mar 2024 04:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709787218;
	bh=ciW4Y2BvJYakxgezeAq5o25RGJSVSjCoSl7n9EIC/XE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rKaFtA8rDLLB0TrE/YqaZnY7iEDc9joCONeej9ooaiO9nJo+jX+hgAszgd3BSSnXi
	 UxDvVdeHotf4/9GSyGuVqoGu1OFi55pNVRQiPFnYrePlbc4vnlNGtT9TMWIIUO+ppO
	 SurWiL7j79zuP8NojQ8Xql0OQWRyOmqx3SAYgX3gk6p7ki3ARqYO8iWoZtGjV1OYR8
	 Xb5Tx66+D11Wjst9liU8EeXV8WO8pKrYLGy1xSIJi1vMPLWMfURK2MSAkOC9ntyobd
	 9wuKuaUjYnNS8fZmI+Z2TncjvgWngtHlZ3S94VDUELk+kNst1tVziSmKbryrtL/YVh
	 NiZaru+5ud06g==
Date: Wed, 6 Mar 2024 20:53:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Saeed Mahameed <saeed@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Paolo Abeni
 <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, Saeed Mahameed
 <saeedm@nvidia.com>, netdev@vger.kernel.org, Tariq Toukan
 <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>, Leon Romanovsky
 <leonro@nvidia.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: Re: [net-next V5 15/15] Documentation: networking: Add description
 for multi-pf netdev
Message-ID: <20240306205336.41a3b90f@kernel.org>
In-Reply-To: <20240306030258.16874-16-saeed@kernel.org>
References: <20240306030258.16874-1-saeed@kernel.org>
	<20240306030258.16874-16-saeed@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 Mar 2024 19:02:58 -0800 Saeed Mahameed wrote:
> +one netdev instance. It is implemented in the netdev layer. Lower-layer instances like pci func,
> +sysfs entry, devlink) are kept separate.

There's a missing opening bracket in this sentence.

> +$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml --dump queue-get --json='{"ifindex": 13}'

while respinning could you also change this...

> +[{'id': 0, 'ifindex': 13, 'napi-id': 539, 'type': 'rx'},
> + {'id': 1, 'ifindex': 13, 'napi-id': 540, 'type': 'rx'},
> + {'id': 2, 'ifindex': 13, 'napi-id': 541, 'type': 'rx'},
> + {'id': 3, 'ifindex': 13, 'napi-id': 542, 'type': 'rx'},
> + {'id': 4, 'ifindex': 13, 'napi-id': 543, 'type': 'rx'},
> + {'id': 0, 'ifindex': 13, 'napi-id': 539, 'type': 'tx'},
> + {'id': 1, 'ifindex': 13, 'napi-id': 540, 'type': 'tx'},
> + {'id': 2, 'ifindex': 13, 'napi-id': 541, 'type': 'tx'},
> + {'id': 3, 'ifindex': 13, 'napi-id': 542, 'type': 'tx'},
> + {'id': 4, 'ifindex': 13, 'napi-id': 543, 'type': 'tx'}]
> +
> +$ ./cli.py --spec ../../../Documentation/netlink/specs/netdev.yaml --dump napi-get --json='{"ifindex": 13}'

..and this to assume we're in the main kernel source directory?

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml --dump queue-get --json='{"ifindex": 13}'

and

$ ./tools/net/ynl/cli.py --spec Documentation/netlink/specs/netdev.yaml --dump napi-get --json='{"ifindex": 13}'

