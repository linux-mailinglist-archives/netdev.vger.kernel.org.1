Return-Path: <netdev+bounces-212889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BE4B2269B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 14:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 458BE1B61A5D
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05F6F78F51;
	Tue, 12 Aug 2025 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="0gg6VJuZ"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DF3A930;
	Tue, 12 Aug 2025 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755001064; cv=none; b=OwZHo5yUitlr8JotA7W3o9jDMdXpMMpCA+MO0A/vSO/V2J7RxBS/1L1hwTZawXMK81sy45nQrrFOoyJOTDTiOK70TpWbiwziTEahvpKvzGer5Qp4lznlUXgg+BZ2FpfkKQf+qnSUOaJY2X9EmLgfZFpAovn3LbmPJP0kKBpph5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755001064; c=relaxed/simple;
	bh=ql2eiy9WW2A7j0whgh0cHFCNgdY36PvAET4wwdLslhc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aVyrSifNjAgAeorjr1FNx0YNt5WNECZgUW8yXfEBNE0exYYmPrqdxABGleU4lydAYIr9g2RXKQF4bijQ6QRRf3QLk4T8/RQ7rt87sxdaa3XRtpGdegExdbKAWc4zsUB/2Q8IER9+kOAbT06iDXu7Le4i/de76eRdQsf0uCXygUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=0gg6VJuZ; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:In-Reply-To:
	References; bh=YFD6SFhAr+B8aSYU1jg4PN5C+z8ECT4Cn654J2jkvdA=; t=1755001062;
	x=1755433062; b=0gg6VJuZw1p+iY2AYQ0YtyLHdr6vp6Xe/6YQbhpUUMsnRJ35mvG4V1/sUNV2u
	7+yY86HsYxs+g9P0sjmmi04TLyAwkd5jfKpiWWC7gkSAx9vkYPJpztAUE+boimW7re03df4HZl+CL
	zZ8wdgetaGTEp85mvItL2sTRXnHTkmSI6zrJBLzObQ5G0a5r1QDj+sPCKPk/H9qZVQvr0FohddbX5
	amjjQRSM/xgAi8GJWO3qlNDBSVFa9zUllJjfFGODwozgIAoPT9nx9tWgEmNNoZuSJWuRCzik80x7V
	HwqjlHV/dWKfOr8r0Pt1HmD9XF+/RD3LsQqYDxbpCpl+Fm/Q9g==;
Received: from [2a02:8108:8984:1d00:a0cf:1912:4be:477f]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128)
	id 1ulnwi-003lHj-1u;
	Tue, 12 Aug 2025 14:17:40 +0200
Message-ID: <6455123a-6785-4173-b145-3a1a3eb48175@leemhuis.info>
Date: Tue, 12 Aug 2025 14:17:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] net: pcs-lynx: 10G SFP no longer links up
To: Mathew McBride <matt@traverse.com.au>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev
References: <Z1F1b8eh8s8T627j@shell.armlinux.org.uk>
 <E1tJ8NM-006L5J-AH@rmk-PC.armlinux.org.uk>
 <025c0ebe-5537-4fa3-b05a-8b835e5ad317@app.fastmail.com>
 <aAe94Tkf-IYjswfP@shell.armlinux.org.uk>
 <f7eac1d6-34eb-4eba-937d-c6624f9a6826@app.fastmail.com>
 <2d709754-3d4a-4803-b86f-9efa2a6bf655@app.fastmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <2d709754-3d4a-4803-b86f-9efa2a6bf655@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1755001062;37485743;
X-HE-SMSGID: 1ulnwi-003lHj-1u

Lo!

On 10.07.25 07:29, Mathew McBride wrote:
> Hi Russell,
> 
> On Wed, Apr 23, 2025, at 7:01 PM, Mathew McBride wrote:
>>
> [snip]
> 
> Just following up on this issue where directly connected SFP+ modules stopped linking up after the introduction of in-band capabilities.
> 
> The diff you provided below[1] resolved the issue. 
> Were you planning on submitting it as a patch? If not, I'd be happy to send it in.

I might be missing something, but from here it looks like it fall
through the cracks on Russell's side. This is nothing bad, this can
happen, especially during summer and thus vacation time. I'd thus say:
wait two or three days if this reminds him of the patch, otherwise go
ahead and submit it yourself to get the regression fixed.

Ciao, Thorsten

> [1] https://lore.kernel.org/all/aAe94Tkf-IYjswfP@shell.armlinux.org.uk/
>> Thanks Russell!
>>
>> The diff below does fix the problem, 10G SFP's now link up again.
>>
>> I should note that Alex Guzman was the one who originally reported the issue to me, he has also confirmed this diff resolves the issue.
>> Link: https://forum.traverse.com.au/t/sfp-ports-stop-working-with-linux-6-14-in-arch-linux/1076/4
>>
>>> Please try the diff below:
>>>
>>> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
>>> index 1bdd5d8bb5b0..2147e2d3003a 100644
>>> --- a/drivers/net/phy/phylink.c
>>> +++ b/drivers/net/phy/phylink.c
>>> @@ -3624,6 +3624,15 @@ static int phylink_sfp_config_optical(struct phylink *pl)
>>> phylink_dbg(pl, "optical SFP: chosen %s interface\n",
>>>     phy_modes(interface));
>>>  
>>> + /* GBASE-R interfaces with the exception of KR do not have autoneg at
>>> + * the PCS. As the PCS is media facing, disable the Autoneg bit in the
>>> + * advertisement.
>>> + */
>>> + if (interface == PHY_INTERFACE_MODE_5GBASER ||
>>> +     interface == PHY_INTERFACE_MODE_10GBASER ||
>>> +     interface == PHY_INTERFACE_MODE_25GBASER)
>>> + __clear_bit(ETHTOOL_LINK_MODE_Autoneg_BIT, config.advertising);
>>> +
>>> if (!phylink_validate_pcs_inband_autoneg(pl, interface,
>>> config.advertising)) {
>>> phylink_err(pl, "autoneg setting not compatible with PCS");
>>>
>>> -- 
>>> RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
>>> FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
>>>
>>
> 
> 


