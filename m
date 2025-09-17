Return-Path: <netdev+bounces-224188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BFFB821D1
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 00:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 765B7620F24
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 22:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBC130DED4;
	Wed, 17 Sep 2025 22:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8yQ/Gk+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B7230DECB;
	Wed, 17 Sep 2025 22:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758146860; cv=none; b=mAjGYJoc0YI+HZqJdUE8uw1dkdVJai5Pv4kBUn4ExHDQYuLY9bYUiesWe+E5Jy48WK/vt+QIk3hsRANK/ydN7gmm0ri7eX6mKS2jqxIbTx8CTpR9/PjYwfE2MZKRiaqgL0yqXPBAGAbwaJda7yjEq4GQ3HXgG/F+gazuob5IyM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758146860; c=relaxed/simple;
	bh=FMxIelZ1xsAYWEoxG8Awp9yBOpIhjQskhZlgQG/Iwi4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V+kYfuD8ZJaTZhpPg7ApuosbvQlcjXX26TgPeoYw5nXYq4OpEwU6UyIAmg3eDNg+FHiQyDI5vrOV/lPCP96bvxl3Odd4Dq2ABQtBHzXvPUaZH9voA0CaQoHNuRFTjDovK8LfU++Rf+dNj79ayuWoQ8Z9EZjmZN5NzOHVqTqACMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8yQ/Gk+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDF68C4CEE7;
	Wed, 17 Sep 2025 22:07:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758146860;
	bh=FMxIelZ1xsAYWEoxG8Awp9yBOpIhjQskhZlgQG/Iwi4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=X8yQ/Gk+Etzjvi78OpgbfaGLL48NWQl/6nkVB3Kaw87pdc09WxWMOMi9RaokSd9iM
	 8rf07wvoYZdfga/GmpxRSpLE5JIpcvxKhhUAlu4SS7OplSYeSyhMUnlx2RfgTfBiOk
	 p96hPtolnBRi0zOTV7NgeZ9Vo2ZxfnVLpu+BLZXsBG+5BRJDtpw9nffJRFb1FEVKum
	 9pm8grAibRiR0XNNYMDFq8eVZk4ry27n29UZcZnKmDrxap2Z4IohZlWznVgnNxPknS
	 9hQ3TvBbgtAbLnwqUJVyZKIU5NTkmV2/xfWr1UC/bGY+trUlHfeqEc3ClF+4B6eOYZ
	 ULLsXWyEpiA0Q==
Date: Wed, 17 Sep 2025 15:07:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 kernel@pengutronix.de, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC] net: selftests: Adding TX checksum offload validation
Message-ID: <20250917150739.7c40c5c0@kernel.org>
In-Reply-To: <aMkp4vGilSPbAyun@pengutronix.de>
References: <aMkp4vGilSPbAyun@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 16 Sep 2025 11:12:02 +0200 Oleksij Rempel wrote:
> While working with the smsc95xx driver, I identified a need for better
> validation of the driver and hardware TX checksum offloading capabilities. I
> believe a generic test suite for this would benefit other drivers as well.
> 
> The generic selftest framework in net/core/selftests.c seems like the ideal
> location. It already contains a test for the RX checksum path, so adding
> validation for the TX path feels like a natural extension.
> 
> Here is the list of test cases I propose to add:
> - TX csum offload, IPv4, TCP, Standard MTU Packet
> - TX csum offload, IPv4, UDP, Standard MTU Packet
> - TX csum offload, IPv4, ICMP, Standard Payload
> - TX csum offload, IPv4, TCP, Minimal Size Packet (1-byte payload)
> - TX csum offload, IPv4, UDP, Minimal Size Packet (1-byte payload)
> - TX csum offload, IPv4, UDP, Zero-Checksum Payload (Verify checksum becomes
>                               0xFFFF)
> - TX csum offload, IPv4, TCP, With Single VLAN Tag
> - TX csum offload, IPv4, TCP, With Double VLAN Tag (Q-in-Q)
> - TX csum offload, IPv6, TCP, Standard MTU Packet
> - TX csum offload, IPv6, UDP, Standard MTU Packet

The in-kernel tests are best for things which are hard to trigger from
user space. Have you seen tools/testing/selftests/drivers/net/hw/csum.py
and tools/testing/selftests/net/lib/csum.c ?

