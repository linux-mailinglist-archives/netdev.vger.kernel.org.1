Return-Path: <netdev+bounces-239169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id AF714C64DC7
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 16:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 441BA4E87E6
	for <lists+netdev@lfdr.de>; Mon, 17 Nov 2025 15:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8024533B6D4;
	Mon, 17 Nov 2025 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="1IKduW8G"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05523385B1
	for <netdev@vger.kernel.org>; Mon, 17 Nov 2025 15:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763393053; cv=none; b=Is50+Nia3LLoYZUdL7HHD5iUnDCWcbfUdqcqxLNQZD0VbBmQfms8zPdQNf1PzH/nwAjQ5g1EqUogDnnzl/WNnQp3Upl5f9pl8Z+8TQK/TzBAQiivTjM3jChmjRGEgQ9H8IwZafAu3OFTuKHghINhhLIM/dLohjm7xGPEbrI2DSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763393053; c=relaxed/simple;
	bh=nImvHgHuh8U26+QS6hPu+na/IKrfgHgn7vvEmmjh7Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KqTdYtpAvUUBBJmKS+KGE7O8J6mSOD/j8Xnv3DPwWTz77SqFLGsYqUK/SN3R3sCEnPqi/xFxSsGUgD3iY75KwonuIOA+XNoW6aIA8A96kU5TlFrbtGFqZbxS0hcQ/nJqeNm8cKeUPwKxVol5hb/2BGO3fDeSIOPZlM8NX2io+JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=1IKduW8G; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 14223C1265B;
	Mon, 17 Nov 2025 15:23:45 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 25D71606B9;
	Mon, 17 Nov 2025 15:24:07 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5115510371D02;
	Mon, 17 Nov 2025 16:24:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1763393046; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=TiJUeO+1mFIQ8q0hDazDlQagCI2bQhPorMuM+JhSBt0=;
	b=1IKduW8GwGYQRbLYRwwSK2q2dN3ei2wB4vn92P9PoiTdzpvdR2+izoDNUrb2UmzJpLelGa
	BanXTbQvSbmDQmwgrpgnAA/VmGZrFfd6brJBfqw+jXbebOqP8eR7BLhtSBQYy1jmNdrLIw
	8+CAQuFsaw6YxN++hEyUzl5+mgxZPJ3e+sv9lgUqOei+xiG9TZ/90g2zZasx1ujTiVwLhE
	F7XwRP0nOsmGlTpCosM7oEhXmkeE248b3s1AMAppn6Yx2QrCp0KhN7tPlHb1hI3k/Nyn+K
	JqQXjIA5Szax0eIDY9KzUzD90FqGB48hu93sXIdzUj3oa0NcxVuQ9C3o0JZN8w==
Message-ID: <0baed1d4-65f0-409e-8284-d6af44bf7beb@bootlin.com>
Date: Mon, 17 Nov 2025 16:24:01 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] net: phylink: add missing supported link modes for the
 fixed-link
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Wei Fang <wei.fang@nxp.com>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, eric@nelint.com,
 imx@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20251116023823.1445099-1-wei.fang@nxp.com>
 <aRs8gMOyC9ZbqMfe@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aRs8gMOyC9ZbqMfe@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 17/11/2025 16:17, Russell King (Oracle) wrote:
> On Sun, Nov 16, 2025 at 10:38:23AM +0800, Wei Fang wrote:
>> Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
>> initialized, so these link modes will not work for the fixed-link. This
>> leads to a TCP performance degradation issue observed on the i.MX943
>> platform.
>>
>> The switch CPU port of i.MX943 is connected to an ENETC MAC, this link
>> is a fixed link and the link speed is 2.5Gbps. And one of the switch
>> user ports is the RGMII interface, and its link speed is 1Gbps. If the
>> flow-control of the fixed link is not enabled, we can easily observe
>> the iperf performance of TCP packets is very low. Because the inbound
>> rate on the CPU port is greater than the outbound rate on the user port,
>> the switch is prone to congestion, leading to the loss of some TCP
>> packets and requiring multiple retransmissions.
>>
>> Solving this problem should be as simple as setting the Asym_Pause and
>> Pause bits. The reason why the Autoneg bit needs to be set is because
>> it was already set before the blame commit. Moreover, Russell provides
>> a very good explanation of why it needs to be set in the thread [1].
>>
>> [1] https://lore.kernel.org/all/aRjqLN8eQDIQfBjS@shell.armlinux.org.uk/
>>
>> Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link configuration")
>> Signed-off-by: Wei Fang <wei.fang@nxp.com>
>> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> 
> Even though discussion is still going on, we do need to fix this
> regression. So:
> 
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

I already reviewed the patch, but I agree with Russell. Being the author
of the blamed commit, I can say that this change in behavior was not
intentional :(

Maxime


