Return-Path: <netdev+bounces-276943-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IPBKBCmL12k3PggAu9opvQ
	(envelope-from <netdev+bounces-276943-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 13:19:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8093D3C993D
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 13:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 42289301600B
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 11:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD1CE39FCBF;
	Thu,  9 Apr 2026 11:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="FfnQa4fk";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="WJBSuPXy"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4502D7817;
	Thu,  9 Apr 2026 11:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775733541; cv=none; b=uolBZGgufUIlm8X0ks9w9kv4CNQafyikanubTgSxfgMOcLPVhAb8x2MS6WPiobS6gkwuiMzxJzsfQqRfDUzqB/38QZI9hpS9xf8EPTVEL8lVdrNtanVSuXfuJeSTF6C3FOs5A5/p84PxN1OiGWfeVum4eP1M6sDLJXMPfGEzo2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775733541; c=relaxed/simple;
	bh=RaylboLt+2kt0iTcQEcDH12AkIlD/VlYZsyMMZTSzPQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvsRCFCwhZ9Cw74baxg+klTBcZayAsoAZrpiP49VNyLDVKVR3YH6IHAtptS/wdNzo4I6S+cB+mhEINsoR4TUswFjUvDr4mtR7brqejulabJLiCOIqv4MDVscuWMBPHNxEZp46Rwse41hWAH9J0PYmrEctV5lwJ1uETseUpHTGaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=FfnQa4fk; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=WJBSuPXy; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775733533;
	bh=RaylboLt+2kt0iTcQEcDH12AkIlD/VlYZsyMMZTSzPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FfnQa4fkuas3RBsgYjJjEVhy6WKHdmKIkb5m7D4X6rYA63No5Jd7VsnyOveyN/sWu
	 L/XrqdRKWvw0OWRCJEb+wE6Z7Luo5UcOwLXdEu9SsL9W/G01TUIffL8tq4fpkOlyIO
	 9BJWQHrAfu52mCoIo3pXmSuSzcpM9nq02sQzZ46Bv2QTaJLMHEB+PnnIDYC4ApC5YD
	 yANiM63e6DEe9ie0jQ6Sw7royiLigpjj14jiLUm+magvIZgLfVb5nh6WbCYgkaCU2T
	 5UBhCYOnMjNEYmR/Xsw0c5ZvmBXGkSU5QWXySf6eyuLP1J4ItfXKE/BA6n+6ayWRpT
	 Sn8oMJFNxHpxg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 127624095C; Thu,  9 Apr 2026 11:18:53 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1775733531;
	bh=RaylboLt+2kt0iTcQEcDH12AkIlD/VlYZsyMMZTSzPQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WJBSuPXyuYEyMaBLj5dAGl9BLRT6KKZjfn4Yb1q6Eg/qn50Xykk/WUEkPXY+37lfK
	 XBsP7B7z12tyDo9uouzsaIgVWvvRbyT3rZ3F4J+U2DjOyoF10X3LGm4JXIFepCyG6E
	 toPFkxxt/jn6qOrey4neM6sw3EsckwF9K1NNV6JtxvgpITQ6+vHCMXoDNd9mu7C6wj
	 KFmGp2Po+v47mD7hlbWp1EurvSuuP2rHWcnPHXTYf9/lxxLKWPj/7aLH8JbDWzfaXk
	 NNpwbxJ9MUl6NC8hCKGeiOrc3BzDkWQ34gGFV0ZHO053HUdR5OGb2rGrVuJy57lytd
	 KsWNlegMQ3JYA==
Received: from [IPV6:2003:c6:9f04:eb00:1f3b:df64:6f4d:f66b] (p200300c69f04eb001f3bdf646f4df66b.dip0.t-ipconnect.de [IPv6:2003:c6:9f04:eb00:1f3b:df64:6f4d:f66b])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id BC373408EC;
	Thu,  9 Apr 2026 11:18:50 +0000 (UTC)
Message-ID: <4b0b1179-5840-412c-b4d9-a2d068e89dfd@birger-koblitz.de>
Date: Thu, 9 Apr 2026 13:18:49 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 2/2] r8152: Add support for the RTL8157
 hardware
To: Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Chih Kai Hsu <hsu.chih.kai@realtek.com>
References: <20260404-rtl8157_next-v7-0-039121318f23@birger-koblitz.de>
 <20260404-rtl8157_next-v7-2-039121318f23@birger-koblitz.de>
 <8b324f8c-f4f8-4e90-b5d6-9b87ec3daf2b@redhat.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <8b324f8c-f4f8-4e90-b5d6-9b87ec3daf2b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-276943-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: 8093D3C993D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 09/04/2026 12:16, Paolo Abeni wrote:
> On 4/4/26 9:57 AM, Birger Koblitz wrote:
>> @@ -6534,8 +6842,11 @@ static void rtl8156_up(struct r8152 *tp)
>>   	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3,
>>   			  PLA_MCU_SPDWN_EN);
>>   
>> -	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
>> -			  RG_PWRDN_EN | ALL_SPEED_OFF);
>> +	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
> 
> AI review notes that the above leads to 2 consecutive:
> 
> 	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);
> 
> with slightly different formatting, likely C&P error?!?
> 
> I think this is better handled with a follow-up, if needed, as I don't
> see any possible issue out of it.
> 
> Other AI comments look not relevant.
Thanks a lot, Paolo!
I will follow up on this for sure, there is also the RTL8159...
I also contacted the Realtek devs, but have not heard back so far, probably needs
internal escalation...

Birger

