Return-Path: <netdev+bounces-255667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MA4Gj6df2nquQIAu9opvQ
	(envelope-from <netdev+bounces-255667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 19:36:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA7FC6F37
	for <lists+netdev@lfdr.de>; Sun, 01 Feb 2026 19:36:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5BAFA300103F
	for <lists+netdev@lfdr.de>; Sun,  1 Feb 2026 18:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19FB227FB3A;
	Sun,  1 Feb 2026 18:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="NBNAV/Wq"
X-Original-To: netdev@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24326FA6F;
	Sun,  1 Feb 2026 18:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769971002; cv=none; b=e3ttjWsjlyaTVlArFI/SJ2eOKjxVLL/U70uYqCr8sJtvkxIR+hTRh0iSPZuLk1WAYGiab1wSWuUMYzjcPggZagtpsvzlK0uC1trwnN+l4QqX+HRyO57qrki4A1r2L67iG0lO5FNS1IQ83KdqIBDLTs6UsDBb1fgRUB9fHRjMKrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769971002; c=relaxed/simple;
	bh=FKQ+iMI50ehFmBlFkW5r/p6X/TrPjJq5F3z6fG9hjE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UPei46GbmbRUiQRKB9hwcAZkJ0zRp5ELxFxWQ2RCJf6qsAl3MPI+lNimE6PJ74JfHeL7AjqdxeP1qwMtOmZ/ZXgelgpJIFV3CoQJJkJ3OkGZVomIPVgW2MTrkI0MbNf0qZMzUvNHQYFYFzMBNMuJtCn/HviEsT1PmGaNerW8Kjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=NBNAV/Wq; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 5F55C109D9D;
	Sun,  1 Feb 2026 19:36:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1769970991;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=LARm2Y3oL9MqfVRvr87lH7jEV+ZHtuB87P+3QLUsfN8=;
	b=NBNAV/WqTMJCNSC3XKmzFMaQg50nfqsgqNjohQWgTwz2cl63bw7bslLiPdI7BHXhL/Czq7
	FOeJO9GgdbK7MVeCHC8R7tilL8fqzmPLqNh7TiJcxRp4BoaYI+6CqlY4d5fe55jho6HQEU
	9tmHj3kpUwsKNhQyYMYrmdRHKPQi8atOhn9uj6n20dGBsqoGFybPwDpSmRiN7iH3p3qKH2
	NDZhfrvRzkRz33AokZ7yITLhWf6B3ysRdf2lk+rQHg44Uyg84JbZH3lXJYWoPZTMlM6bV0
	SMEcPVnREi3xMMEgNGgiz/oGwm9csACAkFjfxPSV3MJXaH6JRgYbT0cVtc8tWw==
Message-ID: <35d31893-2a28-410f-a1c7-038b4167e265@nabladev.com>
Date: Sun, 1 Feb 2026 19:20:09 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,PATCH] net: stmmac: stm32: Do not suspend downed
 interface
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>,
 Christophe Roullier <christophe.roullier@st.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Krzysztof Kozlowski <krzk@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 kernel@dh-electronics.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com
References: <20260114081809.12758-1-marex@nabladev.com>
 <aWfEXX1iMHy3V5sK@shell.armlinux.org.uk>
 <aWfOYf_YmJFUakvP@shell.armlinux.org.uk>
 <6c9cadc2-67b7-4bfe-9cf7-2b102a0a3c21@nabladev.com>
 <aXzT1UCpG4kN-dQv@shell.armlinux.org.uk>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <aXzT1UCpG4kN-dQv@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[nabladev.com,reject];
	R_DKIM_ALLOW(-0.20)[nabladev.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-255667-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,foss.st.com,lunn.ch,st.com,google.com,kernel.org,gmail.com,redhat.com,dh-electronics.com,lists.infradead.org,st-md-mailman.stormreply.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marex@nabladev.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nabladev.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nabladev.com:mid,nabladev.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EFA7FC6F37
X-Rspamd-Action: no action

On 1/30/26 4:52 PM, Russell King (Oracle) wrote:
> On Thu, Jan 15, 2026 at 12:27:05AM +0100, Marek Vasut wrote:
>> On 1/14/26 6:12 PM, Russell King (Oracle) wrote:
>>> I think I'm going to start over, trying to figure out what happened.
>>>
>>> c7308b2f3d0d net: stmmac: stm32: convert to suspend()/resume() methods
>>>
>>> Did the conversion, and it always called stm32_dwmac_clk_disable() and
>>> where it exists, dwmac->ops->suspend() on suspend, provided
>>> stmmac_suspend() returns zero (which it will do, even if the interface
>>> is down. On resume, it always calls dwmac->ops->resume() and
>>> stm32_dwmac_init() before calling stmmac_resume().
>>>
>>> The conversion added hooks into ny new ->suspend() and ->resume()
>>> methods to handle the stm32_dwmac_clk_disable(), dwmac->ops->suspend(),
>>> dwmac->ops->resume() and stm32_dwmac_init() steps.
>>>
>>> However, in 07bbbfe7addf I failed to realise that, in order to keep
>>> things compatible with how stuff works, we need to call
>>> priv->plat->suspend() even if the interface is down. This is where
>>> the bug is, not in your glue driver.
>>>
>>> Please try this:
>>>
>>> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> index a8a78fe7d01f..2acbb0107cd3 100644
>>> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>>> @@ -8066,7 +8066,7 @@ int stmmac_suspend(struct device *dev)
>>>    	u32 chan;
>>>    	if (!ndev || !netif_running(ndev))
>>> -		return 0;
>>> +		goto suspend_bsp;
>>>    	mutex_lock(&priv->lock);
>>> @@ -8106,6 +8106,7 @@ int stmmac_suspend(struct device *dev)
>>>    	if (stmmac_fpe_supported(priv))
>>>    		ethtool_mmsv_stop(&priv->fpe_cfg.mmsv);
>>> +suspend_bsp:
>>>    	if (priv->plat->suspend)
>>>    		return priv->plat->suspend(dev, priv->plat->bsp_priv);
>> This works too, thank you.
>>
>> Will you send this fix ?
> 
> Sorry, I appear to have dropped this patch on the floor, and just
> tripped over it. I'm just build testing it and will send it later
> today.
> 
> This problem affects every user of the platform ->suspend/resume()
> stuff, so is not just a stm32 issue.
ACK, thank you.

