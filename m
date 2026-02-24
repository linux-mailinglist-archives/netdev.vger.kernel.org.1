Return-Path: <netdev+bounces-260610-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONXpOjvinWnpSQQAu9opvQ
	(envelope-from <netdev+bounces-260610-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:39:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4497A18AA14
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 18:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 89F6330137A3
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BA593A9DA6;
	Tue, 24 Feb 2026 17:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="guWzQ438";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="YVWiHeC1"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A5BEE555;
	Tue, 24 Feb 2026 17:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771954617; cv=none; b=Bki5hnBBIaNQeYGxqmaT6ueT5dQOVsMUpMofriKZXP0Cf5IsR4gXjsp64Oa3499fJVv1GawiLaDESPbEwxX9cfMm8+YCbAUMKwamrgSYZyFSZeCUTr6mwl3jGGyq0vBjbhgUCQRJTUewe2S1YOARDwMsC8GRxRyFiRMajvuQzFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771954617; c=relaxed/simple;
	bh=Pa7gcsXUX8kC66t2OFtJ8weGd+JjeILfY7sYMo5s5Yo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=juCeZU+AnY3jCSSrQGXSLfuEPuSJCGPnu2FoTsfUW3ZBf40nfYob/6k/hKUlVbR/shbqC/uRM3yeNpiMdgn6gBUXkxDWZ3vR6/rWZ8jh+p9EY+YiHuaj1gAI7HAqqce8bQ2+W6N46ES8auMjVR1BPFobAv8UORwCSX9gF6pXaFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=guWzQ438; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=YVWiHeC1; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1771954614;
	bh=Pa7gcsXUX8kC66t2OFtJ8weGd+JjeILfY7sYMo5s5Yo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=guWzQ438v30tlEe6ZGWW1nWJJSqQrysxOC3AR5Ch0NlapQfzzLKfWICdrNp6Vv0On
	 wN+f03lEkCZAuGGdXRvuTtz20RRll8e2AomL1kQhpJjQ9dKS+XESuCu4nKsW4a4x/1
	 nSlBr5gsCPgT+oRBtQulxySGPqwqOAHttOizyjg7gUE3qVSSOvuX71cqXFqLWs2eXl
	 ysz09vRh1rfYxQBXpkEgTjiC5MEHj82PaLQNg/PQJEOEfiNJax/U5i3en/ErBw4FV9
	 tUcD9dniVHnJgCmcjJcf25EFEcvXgRIrf/yNz34tv+bvNgParjE3wJvejEqbGaLZBa
	 3c12ecIj2g89A==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 9D8F53F779; Tue, 24 Feb 2026 17:36:54 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1771954613;
	bh=Pa7gcsXUX8kC66t2OFtJ8weGd+JjeILfY7sYMo5s5Yo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=YVWiHeC1c/PloLT9aSYlPB6Jg4dsAVcLC7l8bY+24JtY7qoV4RP3BHgNQzesHOrA6
	 7cbBTRI4A8ODi3BQwiuv/abPCFHLOnPex0eSuWsaK6VQq+HORrYE92FUxzxDfs7gY0
	 aqZIKelaonhmClYkuMO6CW/gmVKTdu4CiPUFnE+7kNDxVScuMz9ial6f+Cg/364PdZ
	 FdcwAzEP3Wp+qMMKsuKHIZVOFGfVN/cAfCKC5+GbLoOTI99hFGTSC0Xpj7YzNqu9lG
	 H0r8+SRSVC0Pb+QFobpTMEStKsmIft0cOzLdpE0W3IDFugjnnQESxV4pkewBuVTiKm
	 P1graHUE5ny0g==
Received: from [IPV6:2a00:6020:47a3:e800:94d3:d213:724a:4e07] (unknown [IPv6:2a00:6020:47a3:e800:94d3:d213:724a:4e07])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 37A263F0B3;
	Tue, 24 Feb 2026 17:36:53 +0000 (UTC)
Message-ID: <21ea58b9-fcb5-42c3-9a7b-23285f110909@birger-koblitz.de>
Date: Tue, 24 Feb 2026 18:36:52 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next] r8152: Add 2500baseT EEE status/configuration support
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, opensource@vdorst.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, pabeni@redhat.com,
 kuba@kernel.org, edumazet@google.com, davem@davemloft.net
References: <20260223-b4-eee2g5-v1-1-7006b537b144@birger-koblitz.de>
 <20260224170206.146491-3-horms@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260224170206.146491-3-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-260610-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[birger-koblitz.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mail@birger-koblitz.de,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:mid,birger-koblitz.de:dkim]
X-Rspamd-Queue-Id: 4497A18AA14
X-Rspamd-Action: no action

Hi Simon,

On 24/02/2026 6:02 pm, Simon Horman wrote:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> 
> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
> ---
> r8152: Add 2500baseT EEE status/configuration support
> 
> The r8152 driver supports the RTL8156, which is a 2.5Gbit Ethernet
> controller for USB 3.0, for which support is added for configuring and
> displaying the EEE advertisement status for 2.5GBit connections. The
> patch also corrects the determination of whether EEE is active to include
> the 2.5GBit connection status and make the determination dependent not on
> the desired speed configuration (tp->speed), but on the actual speed used
> by the controller.
> 
>> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
>> index 8d36162f36df..a831acd385cd 100644
>> --- a/drivers/net/usb/r8152.c
>> +++ b/drivers/net/usb/r8152.c
> 
> [ ... ]
> 
>> @@ -8924,6 +8926,7 @@ static int r8152_get_eee(struct r8152 *tp, struct ethtool_keee *eee)
>>   {
>>   	__ETHTOOL_DECLARE_LINK_MODE_MASK(common);
>>   	u16 val;
>> +	u16 speed = rtl8152_get_speed(tp);
> 
> Simon says: please declare local variables in reverse xmas tree order -
>              longest line to shortest.
Will fix in v2.

> Does this code read uninitialized memory? The 'common' bitmap is declared
> via __ETHTOOL_DECLARE_LINK_MODE_MASK(common), which expands to
> DECLARE_BITMAP -- an uninitialized stack array:
I will fix this in v2 by initializing common to an empty bitmask.

> [Simon says: I note that Daniel Golle flagged this issue already]
This was forgotten in the edited patch and will be part of v2.

> The same uninitialized memory issue exists here in r8153_get_eee. The
> 'common' bitmap declared via __ETHTOOL_DECLARE_LINK_MODE_MASK is never
> zeroed before individual speed bits are conditionally set with
> linkmode_set_bit(). Then linkmode_and() reads the uninitialized garbage
> bits.
> 
> This function affects RTL_VER_03 through RTL_VER_15, which is the majority
> of supported devices.
I will fix this in v2.

Birger

