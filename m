Return-Path: <netdev+bounces-226132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC93B9CD34
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 02:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 236441BC3642
	for <lists+netdev@lfdr.de>; Thu, 25 Sep 2025 00:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171AACA6B;
	Thu, 25 Sep 2025 00:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aR47Mr5y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60651367
	for <netdev@vger.kernel.org>; Thu, 25 Sep 2025 00:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758759192; cv=none; b=JCuQbtLQ1qwPgK6qvJOzhhpVaYwwKDvLaCzPCdpZfzPJ5PKArNCoZP88+Zmq37SoUlsjd4+cggxGRAfz//WW4NcfhjRGaIb8pvlic6G6nt8nBgAfUlJZ1FpX4We8mQgcH8afjJ5B+swsegTcC7MJjrSGBtl0T1VEJ0OVRkfzo5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758759192; c=relaxed/simple;
	bh=sW8vai8cLqCuJNlckvlwYKDPP+r8sd3F+nJz8pNH7fc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CylbBXfK3ReT23Kk5kscsq33ySyJGp/0YCwYnSQ67vPIyvg0NLgpeH83RKHmO9BaXAk+QVWQ6XzGjrIuKbD7FwzYcXlZpNjJFYy/AM8G+7JiK0yDd5cz1Wq4tqiMv5phYObeJvHVwlOwef90+z0qKl3uWGNt6FquGmyjDjT5iQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aR47Mr5y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0E56C4CEE7;
	Thu, 25 Sep 2025 00:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758759191;
	bh=sW8vai8cLqCuJNlckvlwYKDPP+r8sd3F+nJz8pNH7fc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aR47Mr5ymRr5Qh9aVnCH6aoIfGsn2xTpnpBx4NECKNg4kcKrRzPYnOSDBN6HxcJml
	 dLnzGCPeNUy/5k1RnjgntLIoNzq7hW0+gh6l6pnANIsrGWTBQKh8t9HXYsRQYhd+Uq
	 0bzIjmmFAo9Qik6Z1rFkBJ+G0SLMNogWE9nSRxnqbKsl9U3ZBsvQHXUL/dfJIAo63I
	 RSY0nde//L2eDXCM1EuErQqEi5Iup9EOWHD1eKIoHy/vof9DKlVFD7ovrTLpN0qYfa
	 aeE3lV+mQq2g6rjgAqO81GshfqjAFrlh2hIh/ijencrCAWPlqRPjXc3lcj36pvTunE
	 d2cZWrsi6qJfA==
Date: Wed, 24 Sep 2025 17:13:09 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Shuah Khan
 <shuah@kernel.org>, Willem de Bruijn <willemb@google.com>, Breno Leitao
 <leitao@debian.org>, Petr Machata <petrm@nvidia.com>, Yuyang Huang
 <yuyanghuang@google.com>, Xiao Liang <shaw.leon@gmail.com>, Carolina Jubran
 <cjubran@nvidia.com>, Donald Hunter <donald.hunter@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next 3/9] selftests: drv-net: base device access API
 test
Message-ID: <20250924171309.1101709e@kernel.org>
In-Reply-To: <20250924194959.2845473-4-daniel.zahka@gmail.com>
References: <20250924194959.2845473-1-daniel.zahka@gmail.com>
	<20250924194959.2845473-4-daniel.zahka@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 24 Sep 2025 12:49:49 -0700 Daniel Zahka wrote:
> --- a/tools/testing/selftests/drivers/net/config
> +++ b/tools/testing/selftests/drivers/net/config
> @@ -5,3 +5,4 @@ CONFIG_NETCONSOLE=m
>  CONFIG_NETCONSOLE_DYNAMIC=y
>  CONFIG_NETCONSOLE_EXTENDED_LOG=y
>  CONFIG_XDP_SOCKETS=y
> +CONFIG_INET_PSP=y

nit: when you respin could you move this up a little?
so that the config options are in (some approximation) of alphabetical
order?

