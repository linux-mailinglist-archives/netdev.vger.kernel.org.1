Return-Path: <netdev+bounces-263447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id vFEKHfZap2kfhAAAu9opvQ
	(envelope-from <netdev+bounces-263447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:04:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E681F7D7E
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 23:04:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 390DC3060AE8
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 22:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810C13382C5;
	Tue,  3 Mar 2026 22:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="ng5mtV73"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A94361653;
	Tue,  3 Mar 2026 22:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772575475; cv=none; b=nSalterLeaFdh2NWEaHUqmBAGgv/iKCx+ikaBdgYdk532awxt+59QRJImsk6z57dAXAxEotETh6Zjsz6PuqAXOS47Oa/hws3mb6kAErXIbUn0SqDF1+vz4xQkr+OxzrruyhDDUAn5b2BfuO6U7KOJ+aOGCMI0FESW6g6Vu6obMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772575475; c=relaxed/simple;
	bh=L6txYkgfm/sj0Wa7CYT1lCpX5MtTL/9MidzCZIs2Jn4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=os2520XUsSOrMgUUI4SPpJdtKePgbC3fACgJyB8f7utmrV7NDByNqEicUIGpr5MhLJTZjK3t1sOH7qnX0OesOLrqD6iJeirZx15UaJE2sUqPy37P6nrXVNqEwgSeGwWofef/f1+RLrRJLvkdWmGFJkN6UXkWcOuiCb1pI3gsoO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=ng5mtV73; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1772575473; x=1804111473;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=L6txYkgfm/sj0Wa7CYT1lCpX5MtTL/9MidzCZIs2Jn4=;
  b=ng5mtV73G3xWUUKFu5rzZ7t/wjZ6qlHbsOxshptYDuVhb1zzweIsZKP6
   EAMuj4TTv9LJ6CgdO4kWYUjc3nUJn4UJSSsr6cWLEHajbipCPo9EAwuB/
   1I2RRQXdCjTfY/0CsD1Zn97AkvCsdNy+wahFt4utIUzNLEDIpc9Ghgs0m
   qval5x8+pKnMWjw72zqGNpgRMVLB74eFwaNZZZBZouyYlOAg+LNaQnqpE
   9Hy1w82HRxJZzxTQf/GJZBicJWForLJflyTyEo15u9WeCJxMVKG82g8NK
   Q6WCm9bkwCBL0iqBxSzbP35ABES/b/JCmLFkDGqSITjA58pNMtE3EKlms
   g==;
X-CSE-ConnectionGUID: +BWnAaG9T/O8uk21TrJGag==
X-CSE-MsgGUID: m12QdKZVRWm+5NKHDMRuaQ==
X-IronPort-AV: E=Sophos;i="6.21,322,1763449200"; 
   d="scan'208";a="221446285"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 15:04:32 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex3.mchp-main.com (10.10.87.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.35; Tue, 3 Mar 2026 15:04:14 -0700
Received: from [10.10.179.162] (10.10.85.11) by chn-vm-ex02.mchp-main.com
 (10.10.85.144) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Tue, 3 Mar 2026 15:04:14 -0700
Message-ID: <1d35173d-b364-4c4a-a083-388d3bd27ce5@microchip.com>
Date: Tue, 3 Mar 2026 15:04:19 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v2,2/8] net: macb: rename macb_default_usrio to
 at91_default_usrio as not all platforms have mii mode control in usrio
To: Conor Dooley <conor@kernel.org>
CC: Jakub Kicinski <kuba@kernel.org>, <andrew+netdev@lunn.ch>,
	<richardcochran@gmail.com>, <abin.joseph@amd.com>, <robh@kernel.org>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, <theo.lebrun@bootlin.com>,
	<pjw@kernel.org>, <Valentina.FernandezAlanis@microchip.com>,
	<krzk+dt@kernel.org>, <sean.anderson@linux.dev>, <aou@eecs.berkeley.edu>,
	<linux-kernel@vger.kernel.org>, <alex@ghiti.fr>,
	<devicetree@vger.kernel.org>, <palmer@dabbelt.com>,
	<nicolas.ferre@microchip.com>, <vineeth.karumanchi@amd.com>,
	<claudiu.beznea@tuxon.dev>, <samuel.holland@sifive.com>,
	<daire.mcnamara@microchip.com>, <conor+dt@kernel.org>,
	<dave.stevenson@raspberrypi.com>, <linux-riscv@lists.infradead.org>,
	<davem@davemloft.net>, <conor.dooley@microchip.com>,
	<narmstrong@baylibre.com>, <pabeni@redhat.com>
References: <20260226-enjoyer-shock-e17f9dc7cbdb@spud>
 <20260228232600.4187398-1-kuba@kernel.org>
 <20260228-shopping-april-a8c4d2481cbe@spud>
 <a1e36563-0e74-48b2-ae02-813cb28fc931@microchip.com>
 <20260303-stardust-shaky-c8a757ec149d@spud>
From: Ryan Wanner <ryan.wanner@microchip.com>
Content-Language: en-US
In-Reply-To: <20260303-stardust-shaky-c8a757ec149d@spud>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: C7E681F7D7E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[microchip.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[microchip.com:s=mchp];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[30];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-263447-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,amd.com,google.com,vger.kernel.org,bootlin.com,microchip.com,linux.dev,eecs.berkeley.edu,ghiti.fr,dabbelt.com,tuxon.dev,sifive.com,raspberrypi.com,lists.infradead.org,davemloft.net,baylibre.com,redhat.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.wanner@microchip.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[microchip.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:dkim,microchip.com:mid]
X-Rspamd-Action: no action

On 3/3/26 11:01, Conor Dooley wrote:
> On Tue, Mar 03, 2026 at 10:35:05AM -0700, Ryan Wanner wrote:
>> On 2/28/26 17:06, Conor Dooley wrote:
>>> Yo,
>>>
>>> On Sat, Feb 28, 2026 at 03:26:00PM -0800, Jakub Kicinski wrote:
>>>> This is an AI-generated review of your patch. The human sending this
>>>> email has considered the AI review valid, or at least plausible.
>>>>
>>>> For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
>>>> ---
>>>> net: macb: rename macb_default_usrio to at91_default_usrio as not all
>>>> platforms have mii mode control in usrio
>>>>
>>>> This patch renames macb_default_usrio to at91_default_usrio to better
>>>> reflect that the usrio configuration is platform-specific, and
>>>> introduces a new capability flag (MACB_CAPS_USRIO_HAS_MII) to gate MII
>>>> mode configuration code for platforms that actually support it.
>>>>
>>>>> diff --git a/drivers/net/ethernet/cadence/macb.h b/drivers/net/ethernet/cadence/macb.h
>>>>> --- a/drivers/net/ethernet/cadence/macb.h
>>>>> +++ b/drivers/net/ethernet/cadence/macb.h
>>>>> @@ -779,6 +779,7 @@ #define MACB_CAPS_DMA_64B			BIT(21)
>>>>>  #define MACB_CAPS_DMA_PTP			BIT(22)
>>>>>  #define MACB_CAPS_RSC				BIT(23)
>>>>>  #define MACB_CAPS_NO_LSO			BIT(24)
>>>>> +#define MACB_CAPS_USRIO_HAS_MII			BIT(25)
>>>>>
>>>>>  /* LSO settings */
>>>>>  #define MACB_LSO_UFO_ENABLE			0x01
>>>>> diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
>>>>> --- a/drivers/net/ethernet/cadence/macb_main.c
>>>>> +++ b/drivers/net/ethernet/cadence/macb_main.c
>>>>> @@ -4614,13 +4614,15 @@
>>>>>
>>>>>  	if (!(bp->caps & MACB_CAPS_USRIO_DISABLED)) {
>>>>>  		val = 0;
>>>>> -		if (phy_interface_mode_is_rgmii(bp->phy_interface))
>>>>> -			val = bp->usrio->rgmii;
>>>>> -		else if (bp->phy_interface == PHY_INTERFACE_MODE_RMII &&
>>>>> -			 (bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
>>>>> -			val = bp->usrio->rmii;
>>>>> -		else if (!(bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
>>>>> -			val = bp->usrio->mii;
>>>>> +		if (bp->caps & MACB_CAPS_USRIO_HAS_MII) {
>>>>> +			if (phy_interface_mode_is_rgmii(bp->phy_interface))
>>>>> +				val = bp->usrio->rgmii;
>>>>> +			else if (bp->phy_interface == PHY_INTERFACE_MODE_RMII &&
>>>>> +				 (bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
>>>>> +				val = bp->usrio->rmii;
>>>>> +			else if (!(bp->caps & MACB_CAPS_USRIO_DEFAULT_IS_MII_GMII))
>>>>> +				val = bp->usrio->mii;
>>>>> +		}
>>>>>
>>>>>  		if (bp->caps & MACB_CAPS_USRIO_HAS_CLKEN)
>>>>>  			val |= bp->usrio->refclk;
>>>>
>>>> Can bp->usrio be NULL here? The new MACB_CAPS_USRIO_HAS_MII capability
>>>> gates the MII-related dereferences of bp->usrio, but bp->usrio is also
>>>> dereferenced when MACB_CAPS_USRIO_HAS_CLKEN is set.
>>>>
>>>> With the change to default_gem_config later in this patch:
>>>>
>>>> static const struct macb_config default_gem_config = {
>>>> 	...
>>>> 	.usrio = NULL,
>>>> 	...
>>>> };
>>>>
>>>> A device that matches the generic 'cdns,macb' compatible string (without
>>>> specific .data) will get bp->usrio = NULL during probe. If the device
>>>> tree then has 'cdns,refclk-ext', macb_configure_caps() adds
>>>> MACB_CAPS_USRIO_HAS_CLKEN without checking if bp->usrio is valid:
>>>>
>>>> macb_configure_caps() {
>>>> 	...
>>>> 	if (of_property_read_bool(np, "cdns,refclk-ext"))
>>>> 		bp->caps |= MACB_CAPS_USRIO_HAS_CLKEN;
>>>> 	...
>>>> }
>>>>
>>>> Then in macb_init(), the code would dereference bp->usrio->refclk with
>>>> bp->usrio being NULL, causing a crash.
>>>>
>>>> The MACB_CAPS_USRIO_HAS_MII gate only protects the MII-related
>>>> dereferences above, not the CLKEN dereference.
>>>
>>> AI makes a good point here, but in one way this isn't even a problem
>>> with the patchset, it's actually another example of the sort of thing
>>> that I am trying to get rid of from the driver. As far as I can tell,
>>> this was added very recently, for the emac on sama7g5. The sama7g5-emac
>>> sets this cap in its match data, as do several other devices, so this
>>> code that sets the cap based on the dt property isn't needed.
>>>
>>> I would like to get rid of setting the cap based on the dt property,
>>> because it is inherently tied to how at91 have their USRIO set up.
>>> Other platforms that want to use this external refclk might use a
>>> different mechanism for the selection, or only support an external
>>> source. What USRIO does is very platform specific, so it should be
>>> something that is opted in to explicitly. I didn't ask for the property
>>> to be bound to only the at91 devices that use it when I reviewed the
>>> binding, because I figured other platforms might be able to reuse the
>>> property and that's also why I didn't ask for a microchip prefix on the
>>> property. For the driver to reflect that general use, it shouldn't then
>>> do at91-specific things when the property is present.
>>>
>>> Ryan, how does this property actually work now, given your removal
>>> of the cap from match data was reverted? I feel like it just doesn't do
>>> what you want it to do anymore? Before the revert, having the property
>>> meant that the value in sama7g5_usrio.refclk would be written to the
>>> hardware and not having the property meant that the bit would remain
>>> unset. You then had to revert to avoid breaking old devices, because
>>> your property changed the default behaviour for the emac, so now having
>>> the property means that the value in sama7g5_usrio.refclk is written to
>>> the hardware, but that also happens without the property because the cap
>>> is set in the match data.
>>
>> So even with the revert the patch still does what it is intended to do,
>> mainly for the sama7g5_gem and the newer SAM devices, sam9x75 and sama7d65.
> 
> Oh, the gems actually have this, but with the default the other way to
> the emacs? I had figured that only the emacs actually had it, given they
> were all added prior to your change. Obviously the property then cannot
> be removed if the gems need it.

Yes that is correct, I am not sure why this was left out in the initial
implementation of the gems maybe others can give some insight. The gems
can, similar to the emacs, take an external or internal ref clock that
is decided by the usrio registers. The difference with the gems and the
emacs is the gems can have 125MHz refclk for RGMII (50Mhz for RMII)
either internal or external where as the emacs can only switch refclk
for RMII.

> 
>> Currently with the removal of the change to the emac there is no
>> functional difference. With the newer SAM devices that need this usrio
>> flexibility this patch still works.
>>
>> How this works now is for sama7g5_gmac configs, the default is to use
>> the internal clock for refclk then adding that dt property will set that
>> bit to 1 and refclk will be from an external source. For the
>> sama7g5_emac configs this has no effect due to ABI.
>>>
>>> Unless I am missing something, should we not actually revert
>>> dce32ece3bb8f ("net: cadence: macb: Expose REFCLK as a device tree
>>> property") and 1b7531c094c88 ("dt-bindings: net: cdns,macb: Add external
>>> REFCLK property"), and instead add a property like
>>> "microchip,refclk-internal", because that would actually let you
>>> override the default behaviour of the driver?
>>
>> I think this could be the better way to go as this keeps the existing
>> behavior for the legacy devices while still allowing the initial goal of
>> the patch series. Seems it would be more strait forward in the ABI sense
>> to have a "microchip,refclk-internal" property than an "refclk-ext"
>> property and having the risk of breaking older devices.
> 
> By the sounds of things, you actually need both to be functional. The
> gems default to internal, so need refclk-external and the emacs default
> to external so need refclk-internal. Maybe it'd be better to have
> "microchip/cdns,refclk-source" that can be set to a string to deal with
> both cases?

Since a dt string would need to be placed either way could the default
be setting be 1 like how the emacs is set then make a
"microchip,refclk-internal" flag, this seems to have the minimal amount
of conflicts with legacy implementation.

> I'd also like to decouple setting the USRIO_HAS_CLKEN cap from what
> direction it is set in. That way, all devices with the bit in their
> USRIO would set the cap, but the value would come from either a default
> in match data or from the dt property if set. I think that's more
> natural behaviour for the capability, since the bit is in the usrio
> register regardless of which refclk source is used.
> 
> Does that seem reasonable?

So to leave the "USRIO_HAS_CLKEN" caps flag in the existing configs for
emacs, then have this be a toggle for the gem configs, and the
"microchip/cdns,refclk-source" would be parsed to either set this bit to
1 or 0? The USRIO refclk bit will be set in the macb_init() based on if
the dt property is there rather than how it is currently implemented now
if I understand correctly?

Ryan

> 
> Cheers,
> Conor.


