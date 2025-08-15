Return-Path: <netdev+bounces-214149-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B29B285D3
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 286E41CC8118
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 271681DE8A3;
	Fri, 15 Aug 2025 18:30:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b="bTH84N8W"
X-Original-To: netdev@vger.kernel.org
Received: from mail.fris.de (mail.fris.de [116.203.77.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82EC131771D;
	Fri, 15 Aug 2025 18:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.77.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755282635; cv=none; b=Pu4WVRJ2+5Bz03HCiui6/g3pKF+TfPPszWl4bJrshiPUrNZ0uXVEpzokbVmfZY3hjSlSAge6FDqM0qwfvORtq6Cy6Hqe8/O6MaHvlCNQYlTvm14nS0/gTF3wFPr/N3K7sMrTMtfuPCBM7WRJEhe/qP3oOn4zrOytoQvegDVXYp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755282635; c=relaxed/simple;
	bh=QVPAKAEDY5Ajw6vI4+xPvTyy6Pi156iwUX91UxHQKiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IkJCiayfqZH0fsjODtcByAhPRrZvLQeAQXOsjyB7POvg+tjz34QqcH3zE3Hnjr/5jp8yXitLJKy5yufh7bw0eB8dl6U6A7l7LqR+m7tLPiBRSO+m4HKEiwpUn+wDTdYKwYV/CGLCw6w6bl2K9AynbXf3UfwFjNecjU/h+dxB/HU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de; spf=pass smtp.mailfrom=fris.de; dkim=pass (2048-bit key) header.d=fris.de header.i=@fris.de header.b=bTH84N8W; arc=none smtp.client-ip=116.203.77.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fris.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1B99EC986D;
	Fri, 15 Aug 2025 20:30:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fris.de; s=dkim;
	t=1755282622; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references:autocrypt;
	bh=i1lM1c2T06TGk0j3EQmUfchgEN5b1nCTvTTZHPiR7MI=;
	b=bTH84N8W2L0LLMwMKnxQHa4i3HFrLehG8HejeImbQSCq44bHy25E0TCKFSfAgjfSOCIVkt
	Y1ZX4gaBXPXMZbstz96ULAPSSXlkN4gtRmwDtn50CKE7AZpKtMczimbVWz+kBHrynzbczw
	tppMiMAaBuYlRX9ssaCoAQx53gNufaTK2JFgKwk9OnPXZmRMAn60flHdXrtvW6VRexGEcP
	Mxye7HbiniSLyHW6NqnuOPQC055Z53h95HbPDuAGhziKMVOs6l0ryPkMJrjqG+POT/nuPP
	I0iBBb5nCOpTqX/SLa04UBhM91m+2od9T4VzT47hveQ9TTfVkjpTxQR+nnlgGg==
Message-ID: <27ccf5c4-db66-491c-aa7c-29b83ebfca3a@fris.de>
Date: Fri, 15 Aug 2025 20:30:13 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] net: dsa: microchip: Prevent overriding of HSR port
 forwarding
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 linux-kernel@vger.kernel.org, Lukasz Majewski <lukma@denx.de>,
 Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
 Vladimir Oltean <olteanv@gmail.com>, Woojung Huh
 <woojung.huh@microchip.com>, Frieder Schrempf <frieder.schrempf@kontron.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Jesse Van Gavere <jesseevg@gmail.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Pieter Van Trappen <pieter.van.trappen@cern.ch>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Simon Horman <horms@kernel.org>, Tristram Ha <tristram.ha@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>
References: <20250813152615.856532-1-frieder@fris.de>
 <d7b430cf-7b28-49af-91f9-6b0da0f81c6a@lunn.ch>
Content-Language: en-GB, de-DE
From: Frieder Schrempf <frieder@fris.de>
Autocrypt: addr=frieder@fris.de; keydata=
 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
 BnPajIeNAvjJFMw88/I=
In-Reply-To: <d7b430cf-7b28-49af-91f9-6b0da0f81c6a@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Am 15.08.25 um 00:59 schrieb Andrew Lunn:
> On Wed, Aug 13, 2025 at 05:26:12PM +0200, Frieder Schrempf wrote:
>> From: Frieder Schrempf <frieder.schrempf@kontron.de>
>>
>> The KSZ9477 supports NETIF_F_HW_HSR_FWD to forward packets between
>> HSR ports. This is set up when creating the HSR interface via
>> ksz9477_hsr_join() and ksz9477_cfg_port_member().
>>
>> At the same time ksz_update_port_member() is called on every
>> state change of a port and reconfiguring the forwarding to the
>> default state which means packets get only forwarded to the CPU
>> port.
>>
>> If the ports are brought up before setting up the HSR interface
>> and then the port state is not changed afterwards, everything works
>> as intended:
>>
>>    ip link set lan1 up
>>    ip link set lan2 up
>>    ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
>>    ip addr add dev hsr 10.0.0.10/24
>>    ip link set hsr up
>>
>> If the port state is changed after creating the HSR interface, this results
>> in a non-working HSR setup:
>>
>>    ip link add name hsr type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
>>    ip addr add dev hsr 10.0.0.10/24
>>    ip link set lan1 up
>>    ip link set lan2 up
>>    ip link set hsr up
> 
> So, restating what i said in a different thread, what happens if only
> software was used? No hardware offload.

Sorry, I don't understand what you are aiming at.

Yes, this issue is related to hardware offloading. As far as I know 
there is no option (for the user) to force HSR into SW-only mode. The 
KSZ9477 driver uses hardware offloading up to the capabilities of the HW 
by default.

Yes, if I disable the offloading by modifying the driver code as already 
described in the other thread, the issue can be fixed at the cost of 
loosing the HW acceleration. In this case the driver consistently 
configures the HSR ports to forward any packets to the CPU which then 
forwards them as needed.

With the driver code as-is, there are two conflicting values used for 
the register that configures the forwarding. One is set during the HSR 
setup and makes sure that HSR ports forward packets among each other 
(and not only to the CPU), the other is set while changing the link 
state of the HSR ports and causes the forwarding to only happen between 
each port and the CPU, therefore effectively disabling the HW offloading 
while the driver still assumes it is enabled.

This is obviously a problem that should be fixed in the driver as 
changing the link state of the ports *after* setup of the HSR is a 
completely valid operation that shouldn't break things like it currently 
does.

