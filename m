Return-Path: <netdev+bounces-160155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42D88A188B7
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 01:06:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3E6169907
	for <lists+netdev@lfdr.de>; Wed, 22 Jan 2025 00:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BEF632;
	Wed, 22 Jan 2025 00:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="SjnMa6pU"
X-Original-To: netdev@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E93C110E0;
	Wed, 22 Jan 2025 00:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737504378; cv=none; b=rPRxTUrDF/kkPZiuJpZGoTyWkkUNrZPt+NAG2C974jE+syONt8eDNcY6cpdJVNanLMf1VVcBTIp5mQLmdxGlNgi5nM5z4i6nWdxzTxd3i6xVvIpv1nV9eyYaFgPtwKxgUYrTAt2wmJehev1midNU93DRMG1mrF5kl8q84bBEbEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737504378; c=relaxed/simple;
	bh=J30i1nK3az3nz8Y1V+nILJnrC19J38WNyUx3WeP7BHg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pIbNGeqbFUXPDvsvEglyzEYqwmyr3vfQPm8flrOAvlUbuy8JmxQ3xiqaj6R42VW5Gl/E14mz/F6zk21BteUXKL1ZigQyPREc6Z1hyB2Ke3ar5V4KKca3MWtnqdb9UpfxA/QM3KJFnsSk+dXa+qY3pddEn5TnVjF8i/uvgpDNqZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=SjnMa6pU; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 9D566404F3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1737504369; bh=dhfCv6b2j4Hp/HQeG+7jTdoNdOuz5vbk1tusQgfzVBg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=SjnMa6pU1o0a8HdwvOefP+STs5H/2jNN5ngMXLRx/qh8oyYvlpNelhTx5ykbxj2wZ
	 B+3B8OX2SC2RWpVYrJF6j82np9QrGpIOuFGsyVAT9nUaueuwUpCHMHXsb0477iAH2Q
	 41eeL/1i0aE41o2Fnt6qG7lzPAfUiTt0pg1x474LSEeJCYiUopTSZJLZ3APUDxBznK
	 hHBCaznpZ6MFKC/U9E9UKFW7oQW6Ker0+IZBO/h/q2EVUuUIxUHuMH7xKStrTu5LP7
	 0r0eUX5VVSMl16uaZxmRr0C4pYpTlCvJwImCGxKXYyRzavkyGm7zjS6Zlg8w+1c4Ee
	 +xKxduep28UWw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 9D566404F3;
	Wed, 22 Jan 2025 00:06:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Reyders Morales <reyders1@gmail.com>, linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, valla.francesco@gmail.com, Reyders Morales
 <reyders1@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] Documentation/networking: Fix basic node example
 document ISO 15765-2
In-Reply-To: <20250121225241.128810-1-reyders1@gmail.com>
References: <20250121225241.128810-1-reyders1@gmail.com>
Date: Tue, 21 Jan 2025 17:06:08 -0700
Message-ID: <87h65remq7.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

[CC += netdev - they may want a resend after the merge window though]

Reyders Morales <reyders1@gmail.com> writes:

> In the current struct sockaddr_can tp is member of can_addr.
> tp is not member of struct sockaddr_can.
>
> Signed-off-by: Reyders Morales <reyders1@gmail.com>
> ---
>  Documentation/networking/iso15765-2.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/networking/iso15765-2.rst b/Documentation/networking/iso15765-2.rst
> index 0e9d96074178..37ebb2c417cb 100644
> --- a/Documentation/networking/iso15765-2.rst
> +++ b/Documentation/networking/iso15765-2.rst
> @@ -369,8 +369,8 @@ to their default.
>  
>    addr.can_family = AF_CAN;
>    addr.can_ifindex = if_nametoindex("can0");
> -  addr.tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
> -  addr.tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
> +  addr.can_addr.tp.tx_id = 0x18DA42F1 | CAN_EFF_FLAG;
> +  addr.can_addr.tp.rx_id = 0x18DAF142 | CAN_EFF_FLAG;
>  
>    ret = bind(s, (struct sockaddr *)&addr, sizeof(addr));
>    if (ret < 0)
> -- 
> 2.43.0

