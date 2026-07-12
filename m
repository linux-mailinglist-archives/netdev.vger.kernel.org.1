Return-Path: <netdev+bounces-306955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +QB7IcipU2prdAMAu9opvQ
	(envelope-from <netdev+bounces-306955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 16:50:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6E0174506F
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 16:50:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=freeshell.de header.s=s2025 header.b=e1f+qC+L;
	dmarc=pass (policy=reject) header.from=freeshell.de;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306955-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306955-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 54DEA300DA7C
	for <lists+netdev@lfdr.de>; Sun, 12 Jul 2026 14:50:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D03F323C368;
	Sun, 12 Jul 2026 14:50:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0E25B092;
	Sun, 12 Jul 2026 14:50:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783867841; cv=none; b=LEN8RSrvY0Fg8sxPae6vKx+IJTiNktBgSr/mnuFXqAYvT3sE9MJfAp2c3yjBgVGovjo2DRbOOZCcZ9M9pPPsBEKjJvEVdvX2d22EsOkER7ZKRElkh4GMnQRXwrQXsXklMEAzDkW83DTdHRKRMIo1AU62oOkzY5U7yzTAc9Op3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783867841; c=relaxed/simple;
	bh=RRavhV5FIeJDdP7Im3Ubg5sj2lE53nE/4lMGo3DPKUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXaoDsVuOT9H7h/vmit7JeaooaGTHG8md+kKORmkbSDhVVj/Bpz9bPpMXCYI+SBII5cKr5xQJie5z5+oHS29m3LvDpZ/rNEBAVgEt+yzKwavYo5ZFmyiOGmddwqEz2T62mm1ook6eQkqJjT9VLnshKJ7vp8hoPiPrbekmDP/070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b=e1f+qC+L; arc=none smtp.client-ip=116.202.128.144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=s2025; t=1783867767;
	bh=Rgbu6YiDUX9kznSJSlo+OHz7QKMcuRkPsGR/yA4U/Cc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e1f+qC+L/WnrDmmFa5VDmWfCQGJJmU9bOVHt5snbPF8fi/BKsz3/qb1GkPUE0p/3+
	 M2KLArFP9AgM+wzed/pgadxFOk3u4quiCcXHV+X24rR6A9PwmtC3ieuuiW3K5gsMKj
	 14cSfFjUJ9Q+9MPOpdj9frQWqoxI7TAs/e9hKriXEqerM733L5CwqAVqwBJ0kbBVM8
	 P7/aowqXTgMMcCah3k1GJYwucCF4Ild3dlLv/bcCa24dRK9+bK4QJgmoAiKzut1sC9
	 tZhstVazyV3ZN6Rtp7UT837VBE+896rjsA33YVVLfM6o0cNetHLRZuGPa8ueBTwJXy
	 l7eKaYLWxXNkw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 11F2EB2214E1;
	Sun, 12 Jul 2026 16:49:23 +0200 (CEST)
Message-ID: <203fffef-bef1-4d56-a6f0-a2fe482821db@freeshell.de>
Date: Sun, 12 Jul 2026 07:49:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failed to reinit phy of spacemit-dwmac when reset-gpio is present
To: Andrew Lunn <andrew@lunn.ch>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yixun Lan <dlan@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Han Gao <gaohan@iscas.ac.cn>
References: <20260712045233.800748-1-inochiama@gmail.com>
 <bc78469c-3f45-4234-88b0-49f050d651db@bootlin.com>
 <8689bf7d-e00d-4097-bd3c-4d7d7844d1d2@lunn.ch>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <8689bf7d-e00d-4097-bd3c-4d7d7844d1d2@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[freeshell.de,reject];
	R_DKIM_ALLOW(-0.20)[freeshell.de:s=s2025];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306955-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[e@freeshell.de,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	FORGED_RECIPIENTS(0.00)[m:andrew@lunn.ch,m:maxime.chevallier@bootlin.com,m:inochiama@gmail.com,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:dlan@kernel.org,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:netdev@vger.kernel.org,m:linux-riscv@lists.infradead.org,m:spacemit@lists.linux.dev,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:gaohan@iscas.ac.cn,m:mcoquelinstm32@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,google.com,davemloft.net,kernel.org,redhat.com,foss.st.com,vger.kernel.org,lists.infradead.org,lists.linux.dev,st-md-mailman.stormreply.com,iscas.ac.cn];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[e@freeshell.de,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[freeshell.de:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,freeshell.de:from_mime,freeshell.de:email,freeshell.de:mid,freeshell.de:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6E0174506F


On 7/12/26 06:49, Andrew Lunn wrote:
>>> --- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
>>> +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
>>> @@ -196,7 +196,8 @@ &eth0 {
>>>
>>>  	mdio {
>>>  		phy0: phy@1 {
>>> -			compatible = "ethernet-phy-ieee802.3-c22";
>>> +			compatible = "ethernet-phy-id001c.c916",
>>> +				     "ethernet-phy-ieee802.3-c22";
>>
>> Indeed that's merely a workaround :(
> 
> Despite is being a workaround, there has not been much progress on a
> generic framework for dealing with clocks, resets, regulators etc,
> before probing PHYs. So this is probably what you want to do.
> 
>        Andrew

Aside for my participation in reporting and testing here, I confirm that
the above addition to 'compatible' node does not itself resolve what I
observed to be a problem for debian-installer, however it does itself
resolve the rmmod/modprobe cycling issue of the eventual installed
Debian system as I described and what I am quoted as having reported
from dmesg output.

So the other report of increasing de-assert from 10ms to 50ms is needed
for success of the debian-installer hwprobe detection, and this here
issue of adding to the 'compatible' is needed for success of
rmmod/modprobe cycling. In concert together both fixes resolve all of
the trouble I observed and reported, tested and verified on Sipeed K3
Pico ITX.

Thanks for tracking this down it is very much appreciated :)

With that,

Tested-by: E Shattow <e@freeshell.de>

