Return-Path: <netdev+bounces-285338-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJtmDPaX/Gn4RgAAu9opvQ
	(envelope-from <netdev+bounces-285338-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:47:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 824964E98D5
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 15:47:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1B7E3065696
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 13:45:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92FE53BED23;
	Thu,  7 May 2026 13:45:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="WAztdomc"
X-Original-To: netdev@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [185.244.194.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AADD826AF4;
	Thu,  7 May 2026 13:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.244.194.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778161543; cv=none; b=sr8oZo5G1auM16n1X6M4c/8IQgfnC2fgvu6fFglczdFAorNbdBJ8gRQOaD02B8wucwGrI7+oL1smi7vP/Zz4zw/FWloD7nIndZY4dz1SkASa7ShdQ2TmGPAdg1Tsiu9NSl5uAgESr8onDy3JNAHdpd1ekrekRXYt53ppyiWwpPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778161543; c=relaxed/simple;
	bh=iahk48ROHqEubuzP/daBlbyZpbAXB6goRutnC/S6tvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MN8VKI8Pt9S89eyIRZxNbSUPk/maf4/IWvZfzB2V5pfZmagPeNl+Zfko+Wz+NfOI+zUTb42lUPFQm1wskNaGsvCjK1Cf220yIai3alUqsTTYEw299H/eVyu4PHJlqVRd8Y/KSJ2MQoj0z1ukOeJXL5IgWqcobS5Jx1TZh1qc6bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=WAztdomc; arc=none smtp.client-ip=185.244.194.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from relay01-mors.netcup.net (localhost [127.0.0.1])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4gBCT93mLWz8trZ;
	Thu,  7 May 2026 15:16:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1778159821;
	bh=iahk48ROHqEubuzP/daBlbyZpbAXB6goRutnC/S6tvo=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WAztdomcU3bGdVVYxKQ7Xv5salF0mGYCKTw0BHeuCVIUb6v4A7o6q0A/JheCKvqoi
	 4/wXvWHeoo0jO0OGe3IpDd7Kr8hFyaCdzu+x16GX7PcPJ7EqLuI1BB/l5DEoVs40CG
	 aOShkamkKYorCkE9UVl3qaNJxDuC0g6hoZX2yE49GfVUpkjHDAw4Fpu/TrpgpgFVA5
	 sn1NicWqtkG8Hou0t+pSSaIBtPPDnYLIpTv1wbuQRygtLy5tWb3DFYJ5XGdFFuibyM
	 2YN6Nv1zER/cstsNW7N43CGHPpT25kAVF1lysv/QracEPOFeXH+0B2zqkZN/6hagaT
	 8TdAHdBnvZHfw==
Received: from policy01-mors.netcup.net (unknown [46.38.225.35])
	by relay01-mors.netcup.net (Postfix) with ESMTPS id 4gBCP95jpyz7w8s;
	Thu,  7 May 2026 15:13:30 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at policy01-mors.netcup.net
X-Spam-Flag: NO
X-Spam-Score: -2.898
X-Spam-Level: 
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy01-mors.netcup.net (Postfix) with ESMTPS id 4gBCNq5YRJz8tdv;
	Thu,  7 May 2026 15:13:15 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 3254D5FBF7;
	Thu,  7 May 2026 15:13:14 +0200 (CEST)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <5308c658-7d4c-4292-b091-a51546ea4d23@leemhuis.info>
Date: Thu, 7 May 2026 15:13:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] stmmac: Random DMA reset failure on RK3399 since
 v6.18
To: Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Jensen Huang <jensenhuang@friendlyarm.com>
Cc: Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 regressions@lists.linux.dev, netdev@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>
References: 
 <CAMpZ1qEwNOqR-KQD4kEqd93aB-TpHnG6WdQc2tXUF0aXMmw_SA@mail.gmail.com>
 <198e2ce4-07e1-46c0-818d-1eb18645aca0@leemhuis.info>
 <CAMpZ1qGEOiPj7cApnWJnojSyEpDmXfco=No5n1VfyTCoNyCyFQ@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: 
 <CAMpZ1qGEOiPj7cApnWJnojSyEpDmXfco=No5n1VfyTCoNyCyFQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-PPP-Message-ID: <177815959488.33597.6466634683394731939@mxe9fb.netcup.net>
X-NC-CID: IBN/mSWKxNoJwMBcFpQeKstCk/dAkTAf0eUmoE0TLKkEBHFk3lA=
X-Rspamd-Queue-Id: 824964E98D5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,gmail.com,lunn.ch,lists.linux.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-285338-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,leemhuis.info:email,leemhuis.info:mid,leemhuis.info:dkim];
	DMARC_NA(0.00)[leemhuis.info];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

[+Ovidiu Panait]

On 5/7/26 14:49, Jensen Huang wrote:
> On Tue, May 5, 2026 at 4:26 PM Thorsten Leemhuis
> <regressions@leemhuis.info> wrote:
>> On 4/29/26 14:53, Jensen Huang wrote:
>
>>> I'm reporting a regression on RK3399 (stmmac) observed in v6.18.24.
>>> When a network cable is connected during boot, the DMA reset
>>> occasionally fails with the error message: "Failed to reset the dma".
>>>
>>> This appears to be a timing issue related to the EEE RX clock-stop
>>> logic. Based on my investigation with the RTL8211E PHY, I monitored
>>> the PHY register PS1R (MMD device 3, address 0x01) and observed a
>>> value of 0x0f40. This indicates that the PHY is in LPI mode and the RX
>>> clock may have already stopped.
>>>
>>> While commit dd557266cf5f ("net: stmmac: block PHY RXC clock-stop")
>>
>> Just wondering: have you tried if mainline (e.g. 7.1-rc1) is still
>> affected? This is something that is always a good advisable (some people
>> would call it required). In this case even more, as it since a while
>> contains a fix for the change you mentioned, that wasn't backported:
>> c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop when VLAN is
>> enabled"). But this is not my area of expertise (and in different area
>> of the code), so that fix might be unrelated to your issue.
> 
> Thanks for the pointer.
> As you suggested, I have tested the mainline and confirmed that the
> issue is not present in v7.1-rc2, nor as early as v6.19-rc1. However,
> I verified that the issue persists in the latest stable v6.18.26.
> I performed a git bisect and the result pointed exactly to the commit
> you mentioned: c171e679ee66d7 ("net: stmmac: Disable EEE RX clock stop
> when VLAN is enabled").

Great! Could you please cherry-pick c171e679ee66d7 to 6.18.y and see if
that fixes things? It sounds like it should.

@Ovidiu Panait: c171e679ee66d7 is a commit of yours. If Jensen confirms
that cherry-picking fixed the problem, I'd say we ask Greg to pick it up
for 6.18.y -- unless you see any reasons why that might be a bad idea.

> Additionally, I tested the case where CONFIG_VLAN_8021Q is not set,
> and the DMA reset issue occurs again.

I'd say that is likely best discussed in a new thread you might want to
start. Also wondering if it was like that earlier. Or iow: if that is a
regression or not.

Ciao, Thorsten

>>> ensures the clock is running before the DMA reset, my tests suggest
>>> that the phylink_rx_clk_stop_block() call might not provide a
>>> sufficiently stable RX clock in time for the immediate DMA reset that
>>> follows.
>>>
>>> Since stmmac already sets mac_requires_rxc = true, I modified
>>> phylink_bringup_phy() to honor this flag. This avoids toggling the
>>> PHY's clk_stop_enable during the initialization sequence, ensuring the
>>> RX clock remains active and stable throughout.
>>> With the change below, I achieved 200/200 successful reboots with the
>>> cable connected (previously ~50% failure rate).
>>>
>>> --- a/drivers/net/phy/phylink.c
>>> +++ b/drivers/net/phy/phylink.c
>>> @@ -2171,7 +2171,7 @@ static int phylink_bringup_phy(struct phylink
>>> *pl, struct phy_device *phy,
>>>      /* Allow the MAC to stop its clock if the PHY has the capability */
>>>      pl->mac_tx_clk_stop = phy_eee_tx_clock_stop_capable(phy) > 0;
>>>
>>> -    if (pl->mac_supports_eee_ops) {
>>> +    if (pl->mac_supports_eee_ops && !pl->config->mac_requires_rxc) {
>>>          /* Explicitly configure whether the PHY is allowed to stop it's
>>>           * receive clock.
>>>           */
>>>
>>> Any feedback/testing on this would be appreciated.
>>>
>>> Best regards,
>>> Jensen Huang
>>>
>>


