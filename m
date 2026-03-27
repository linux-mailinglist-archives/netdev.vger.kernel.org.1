Return-Path: <netdev+bounces-272594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SGrUCreYxmnrMQUAu9opvQ
	(envelope-from <netdev+bounces-272594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:48:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF0E3464EC
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 15:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 588E530517C8
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 14:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B87903F8E0D;
	Fri, 27 Mar 2026 14:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="2vByoiUz"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF20B3F87E6;
	Fri, 27 Mar 2026 14:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774622847; cv=none; b=PELyEmEwd5cK2RpeB/CWCIn+O+Yc9yjIz2+YVr9ySdmzN38C3Xge/v5Sr3I3NHc2UoF1ziDeW11FkRgUKNqXf32dL7/ec7nuAzdv9Ajq4fDPalRKhyBQrziNurvSqFxdj12bJecIFM1LiKH0QyW9v/QXCcvbrEaRCrvxK0BMp8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774622847; c=relaxed/simple;
	bh=mv50InzxGmrH/dwP6GxECiBQQLiAGey6qxvdpRhNokk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qOZyUn28yBwSoJimiSfByLO5muKPUuCBWBENkGWTVSiQJlEc/27UC/2Xy0JAxvFiFnSGcrzqJRHihN82dd2d58YZX7/aAR80CGX7QfXaiBdw5ceSg2ogGYZqOItD0EnHjpf/jOmi1/Xqsi05LDOctzgaOraP7abiLOeaZDs+2rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=2vByoiUz; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 0DA9CC58746;
	Fri, 27 Mar 2026 14:47:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4F9AE60230;
	Fri, 27 Mar 2026 14:47:24 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C99471045138A;
	Fri, 27 Mar 2026 15:47:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1774622843; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=KT8q+a1H6pXhdT5WL17Gq3UEkkAXi2qzZCZkmYxjylw=;
	b=2vByoiUz6mG3CAaErP7kEjeSdkD4QI6FX/KBSqZ42DHCamxYP+sfFHSaINePBIaC/SRWyI
	dFoldWu6CFt07LX0A5PiQrK9pvF0ZDPBgO+pccoIbBVvsAFEif+t45mynU9mzqW+t9xAaf
	41w68mQYIPmWSqYg9hnx9ojzOpRXoR5jZO70pfEYJZ2niNB1A+pRpYax7j4KU+K3d18aZ+
	veXt3F1Iqo8ksCGa25hJvQLeo1MC/VjkRZG+9SpKGEfz4hlFPkQa+mc4N5MdwtoiNaV68F
	N0DVLISjTTUXV+zp1ZThR9iytf9vQcK7+3468T69B6lpVvRsFrBAucPTB0B0iQ==
Message-ID: <2848158c-a807-4d26-be87-248d4107c5b4@bootlin.com>
Date: Fri, 27 Mar 2026 15:47:18 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] net: dsa: microchip: implement KSZ87xx Module 3
 low-loss cable errata
To: Vladimir Oltean <olteanv@gmail.com>,
 Fidelio Lawson <lawson.fidelio@gmail.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-0-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
 <20260326-ksz87xx_errata_low_loss_connections-v1-3-79a698f43626@exotec.com>
 <20260326094211.hdaf4tz7lbjyjznn@skbuf>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20260326094211.hdaf4tz7lbjyjznn@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272594-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.957];
	TAGGED_RCPT(0.00)[netdev,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid,exotec.com:email]
X-Rspamd-Queue-Id: 8DF0E3464EC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Vladimir, Hi Fidelio

On 3/26/26 10:42 AM, Vladimir Oltean wrote:
> On Thu, Mar 26, 2026 at 10:10:23AM +0100, Fidelio Lawson wrote:
>> Implement the "Module 3: Equalizer fix for short cables" erratum from
>> Microchip document DS80000687C for KSZ87xx switches.
>>
>> The issue affects short or low-loss cable links (e.g. CAT5e/CAT6),
>> where the PHY receiver equalizer may amplify high-amplitude signals
>> excessively, resulting in internal distortion and link establishment
>> failures.
>>
>> Depending on the selected workaround (1 or 2), the driver writes a
>> specific value to the indirect PHY register
>> using the 6E/6F/A0 indirect access mechanism.
>>
>> The errata fix is applied during global switch initialization when
>> enabled via device tree.
>>
>> Signed-off-by: Fidelio Lawson <fidelio.lawson@exotec.com>
>> ---
>>   drivers/net/dsa/microchip/ksz8.c | 46 ++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 46 insertions(+)
>>
>> diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microchip/ksz8.c
>> index 78b42cf50ce2..b6f3a1ce85fc 100644
>> --- a/drivers/net/dsa/microchip/ksz8.c
>> +++ b/drivers/net/dsa/microchip/ksz8.c
>> @@ -1901,6 +1901,41 @@ void ksz8_phylink_mac_link_up(struct phylink_config *config,
>>   		ksz8_phy_port_link_up(dev, port, duplex, tx_pause, rx_pause);
>>   }
>>   
>> +static int ksz8_handle_module3_errata(struct ksz_device *dev)
>> +{
>> +	int ret = 0;
> 
> "ret" does not need to be zero-initialized. It is unconditionally
> overwritten by ksz_write8().
> 
> And please sort lines with variable declarations in decreasing line
> length order. Netdev calls this "reverse Christmas tree" ordering and is
> the preferred coding style.
> 
>> +	const u16 *regs = dev->info->regs;
>> +	u16 indir_reg = 0x0000;
>> +	u8 indir_val = 0x00;
>> +
>> +	switch (dev->low_loss_wa_mode) {
>> +	case KSZ_LOW_LOSS_WA_1:
>> +		indir_reg = 0x3C;
>> +		indir_val = 0x15;
>> +		break;
>> +	case KSZ_LOW_LOSS_WA_2:
>> +		indir_reg = 0x4C;
>> +		indir_val = 0x40;
> 
> Do the 3c and 4c registers have any associated documentation? Do we know
> what they are or what they do? We should have some macros for them,
> instead of magic numbers.
> 
>> +		break;
>> +	default:
>> +		break;
> 
> Is it expected that in the default case (no workaround), the code flow
> writes indir_val = 0x00 to indir_reg = 0x0000? Or would it be better to
> just exit early without making any change?
> 
>> +	}
>> +
>> +	mutex_lock(&dev->alu_mutex);
>> +
>> +	ret = ksz_write8(dev, regs[REG_IND_CTRL_0], 0xA0);
>> +
>> +	if (!ret)
>> +		ret = ksz_write8(dev, 0x6F, indir_reg);
>> +
>> +	if (!ret)
>> +		ret = ksz_write8(dev, regs[REG_IND_BYTE], indir_val);
> 
> Is this sequence better suited for ksz8_ind_write8()? Perhaps wrapped in
> another layer similar to ksz8_pme_write8(), once we know what the magic
> numbers represent in terms of indirect table?
> 
>> +
>> +	mutex_unlock(&dev->alu_mutex);
>> +
>> +	return ret;
>> +}
>> +
>>   static int ksz8_handle_global_errata(struct dsa_switch *ds)
>>   {
>>   	struct ksz_device *dev = ds->priv;
>> @@ -1915,6 +1950,17 @@ static int ksz8_handle_global_errata(struct dsa_switch *ds)
>>   	if (dev->info->ksz87xx_eee_link_erratum)
>>   		ret = ksz8_ind_write8(dev, TABLE_EEE, REG_IND_EEE_GLOB2_HI, 0);
>>   
>> +	/* KSZ87xx Errata DS80000687C.
>> +	 * Module 3: Equalizer fix for short cables
>> +	 * The receiver of the embedded PHYs is tuned by default
>> +	 * to support long cable length applications.
>> +	 * Because of this, the equalizer in the PHY may amplify
>> +	 * high amplitude receiver signals to the point that
>> +	 * the signal is distorted internally
>> +	 */
>> +	if (!ret && dev->low_loss_wa_enable && ksz_is_ksz87xx(dev))
>> +		ret = ksz8_handle_module3_errata(dev);
>> +
>>   	return ret;
>>   }
>>   
>>
>> -- 
>> 2.53.0
>>
> 
> FYI, the driver is in a restructuring process. The ksz88xx_switch_ops
> will be split out of the common ksz_switch_ops. This will conflict with
> your series, so you should rebase on top of that much larger set.
> You can coordinate with Bastien Curutchet to see what is the status:
> https://lore.kernel.org/netdev/20260313153849.qkfzv5c2u6fepjku@skbuf

Indeed, I'm currently polishing a first iteration for it. I'll send it 
ASAP.


Best regards,
Bastien

