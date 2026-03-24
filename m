Return-Path: <netdev+bounces-271188-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WGWyA9PDwmmjlQQAu9opvQ
	(envelope-from <netdev+bounces-271188-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:03:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B213199C2
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:03:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6321A3047E17
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 16:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AB1C3FA5ED;
	Tue, 24 Mar 2026 16:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="mIvM3wwW";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="HfkNgt2Z"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41043EB800;
	Tue, 24 Mar 2026 16:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774371348; cv=none; b=tMoP1CRaSN/FXUhoqVlghDGLw6Dxuefzn6xhxoBOsm/JGJ6DS0TSE4Hfz7gBN5KQtmECXoTSMfDfcFQJcdDdEew17bV412NfrB8GUFKeyUqToZwSGBWEVZBbJdHcNK4c7ZMRgmBwB+sbVUdCTpDs5tbZiFeyKzDC7KyGpCaYbfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774371348; c=relaxed/simple;
	bh=Z5WdEVfQog12XFzp4663rcBOjLi87oQ1DWIdsTTjxdQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VFd7L6eLVbYnSK7dGMK6gBwkux/wyqEttZZBt0/yhgOI47d3MQlfTRhKdoINrp1tFZnJ/+CT1H/8jcGzhMwUJOhw2HUoMCG8lVuxvFxK0mAD5GlA3T+g8G1/6RHGteRaPM8a55hADjfqcVSjogEa6WOZNjyF2/OvzBjWapL7F20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=mIvM3wwW; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=HfkNgt2Z; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774371345;
	bh=Z5WdEVfQog12XFzp4663rcBOjLi87oQ1DWIdsTTjxdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mIvM3wwWHt4YiJ/DvwRdH3EtK6BLaQsuGrf48QD0eLlZuPSgGe1fKqXOLb4E65kiE
	 WsxFkHZrk7KpriJItQXrWgeRSxUWqxaCBVRUlw1JDNFolHjFCtG3uoS9iyFamCw30y
	 uIpR4JCpjasn/wkPQEHwr/Cr+bAF+av+FtL7Kc6rnbgnsYXjxRI6yW4sU6qkmNtvKg
	 qkgxQnKj3i0O7pCiUQk6MjoDZQHGaY49BQb90KyiiN2lSMSkhFTBVmk6pGOaZcc6KI
	 mx9CHkb3rBzUCIY97JNkX3CQRbZx8tXOCPDo9cCI+WjFcYYPDmw73pKxco4Cxa0DWg
	 w6L6h9nLdlI0w==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 117C04006A; Tue, 24 Mar 2026 16:55:45 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1774371344;
	bh=Z5WdEVfQog12XFzp4663rcBOjLi87oQ1DWIdsTTjxdQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=HfkNgt2ZM3zje0nGZvshmd0KruyPwE9Zt5yvpCnIoBL4jx16aNxH4FrzKaeN0fGBK
	 5t6FVmqhmWppJcC4k7YGhV24d7qjCVJmmu5SRCCoWk8K7W5YFtcRIZ/IELiF13Iqki
	 HltDUcwFQIcJzyFXQxvVaFygBaE0gIqRaSu1Uw+68SjG7xgYfjID0d+TD4uRn4yxMl
	 i9cYtsKPsmGgzBtYmobrQpvFehFn+59Tt+b6fJ+6xfb9gJbYJh8UFlcrQHIInvqD7/
	 1T6JMDbS5fUmuHQizx4iMyCzIL8ryAMLHVACSgSRcaI8/T2vDOmvb4I1g5/NdbeESO
	 qxilxagDL1I2w==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id DC66B40052;
	Tue, 24 Mar 2026 16:55:43 +0000 (UTC)
Message-ID: <9b0d4b74-0992-41b4-b495-5212c6d70966@birger-koblitz.de>
Date: Tue, 24 Mar 2026 17:55:43 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next,v3,2/2] r8152: Add support for the RTL8157 hardware
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 netdev@vger.kernel.org, edumazet@google.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, kuba@kernel.org
References: <20260320-rtl8157_next-v3-2-1aefeca7fda7@birger-koblitz.de>
 <20260324105537.385457-1-pabeni@redhat.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20260324105537.385457-1-pabeni@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-271188-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lkml.org:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: 79B213199C2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 24/03/2026 11:55 am, Paolo Abeni wrote:
>> +static u32 ocp_adv_read(struct r8152 *tp, u16 cmd, u16 addr, u32 *data)
>> +{
>> +	int ret;
>> +
>> +	ret = wait_cmd_ready(tp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ocp_write_word(tp, MCU_TYPE_USB, USB_ADV_ADDR, addr);
>> +
>> +	ocp_write_word(tp, MCU_TYPE_USB, USB_ADV_CMD, cmd);
>> +
>> +	ret = wait_cmd_ready(tp);
>> +	if (ret)
>> +		return ret;
>> +
>> +	ret = ocp_read_dword(tp, MCU_TYPE_USB, USB_ADV_DATA, data);
>> +
>> +	return ret;
>> +}
> 
> Should ocp_adv_read() return int instead of u32? The function returns
> 'int ret' which can be 0 or -ETIMEDOUT from wait_cmd_ready(), but the
> function signature declares u32. The companion function ocp_adv_write()
> and all callers (rtl_bmu_read, rtl_ip_read) correctly use 'int ret' and
> check 'ret < 0' for errors.
This is a clear mistake. I will change the return type to "int" and 
submit a new patch version. As a side remark, however, the patch-code 
you refer to, here, is not what I submitted. My submission can be found 
here:
https://lkml.org/lkml/2026/3/20/831

It reads:
+
+static u32 ocp_adv_read(struct r8152 *tp, u16 cmd, u16 addr, u32 *data)
+{
+	int ret;
+
+	ret = wait_cmd_ready(tp, USB_ADV_CMD);
+	if (ret < 0)
+		goto out;
+
+	ocp_write_word(tp, MCU_TYPE_USB, USB_ADV_ADDR, addr);
+
+	cmd |= ADV_CMD_BUSY;
+	ocp_write_word(tp, MCU_TYPE_USB, USB_ADV_CMD, cmd);
+
+	ret = wait_cmd_ready(tp, USB_ADV_CMD);
+	if (ret < 0)
+		goto out;
+
+	*data = ocp_read_dword(tp, MCU_TYPE_USB, USB_ADV_DATA);
+
+out:
+	return ret;
+}

Note that the call parameters of ocp_read_dword are different. It 
appears that the AI is mixing the patch I submitted with the out-of-tree 
driver the patch is based on.

>> +static int r8152_tx_csum(void *d, struct sk_buff *skb, u32 len)
>>   {
>>   	u32 mss = skb_shinfo(skb)->gso_size;
>> +	struct rx_desc *desc = d;
> 
> Is this the correct descriptor type? r8152_tx_csum() casts the void *d
> parameter to 'struct rx_desc *desc' but this function handles TX
> descriptors. The sibling TX functions (r8152_tx_vlan_tag, r8152_tx_len)
> use 'struct tx_desc *'. The bug is latent because both struct tx_desc
> and struct rx_desc have opts1 and opts2 at identical offsets.
This is a typo. I will fix it to tx_desc.

> 
>> @@ -2923,13 +3283,14 @@ static netdev_features_t rtl8152_features_check(struct sk_buff *skb,
>>   						 netdev_features_t features)
>>   {
>>   	u32 mss = skb_shinfo(skb)->gso_size;
>>   	int max_offset = mss ? GTTCPHO_MAX : TCPHO_MAX;
>>
>>   	if ((mss || skb->ip_summed == CHECKSUM_PARTIAL) &&
>>   	    skb_transport_offset(skb) > max_offset)
>>   		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>>   	else if ((skb->len + sizeof(struct tx_desc)) > agg_buf_sz)
>>   		features &= ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
>>
>>   	return features;
>>   }
> 
> Does this match the RTL8157 limits? rtl8152_features_check() uses
> TCPHO_MAX (0x7ff = 2047) for non-GSO checksummed packets on all chip
> versions, but the new RTL8157 (RTL_VER_16) hardware has a smaller limit
> TCPHO_MAX_2 (0x3ff = 1023) as checked in r8157_tx_csum(). For RTL8157,
> packets with transport offsets between 1024 and 2047 will pass
> features_check, but r8157_tx_csum will reject them and fall back to
> r8152_csum_workaround, producing netif_warn messages.
I do not have any further information on the TCPHO_MAX value for the 
RTL8157 other than what is found in the out-of-tree driver. However, if 
this is explicitly changed, it must be assumed the lower limit is 
correct. I will fix this to read:

static netdev_features_t
rtl8152_features_check(struct sk_buff *skb, struct net_device *dev,
		       netdev_features_t features)
{
	struct r8152 *tp = netdev_priv(dev);
	u32 mss = skb_shinfo(skb)->gso_size;
	int max_offset;

	if (tp->version < RTL_VER_16)
		max_offset = mss ? GTTCPHO_MAX : TCPHO_MAX;
	else
		max_offset = mss ? GTTCPHO_MAX : TCPHO_MAX_2;

	if ((mss || skb->ip_summed == CHECKSUM_PARTIAL) &&
	    skb_transport_offset(skb) > max_offset)

in order to be on the safe side.

> 
> [ ... ]
> 
>> @@ -8252,25 +8711,27 @@ static void r8156b_init(struct r8152 *tp)
>>   	u16 data;
>>   	u8 speed;
>>
>> +	tp->coalesce = 15000;	/* 15 us */
>> +	data = r8153_phy_status(tp, 0);
>> +
>>   	if (test_bit(RTL8152_UNPLUG, &tp->flags))
>>   		return;
>>
>> -	tp->coalesce = 15000;	/* 15 us */
>>   	r8153b_u1u2en(tp, false);
>>
>>   	r8156_fc_parameter(tp);
>> -	rtl_tally_reset(tp);
>>
>> +	if (tp->version < RTL_VER_13)
>> +		r8156_mdio_force_mode(tp);
> 
> [ ... ]
> 
>> +	if (tp->version >= RTL_VER_13 && tp->version <= RTL_VER_15)
>> +		ocp_word_set_bits(tp, MCU_TYPE_USB, USB_U2P3_CTRL, RX_DETECT8);
> 
> Are the version guards correct for RTL8156B? When merging r8156b_init into
> r8156_init, the condition 'tp->version >= RTL_VER_13 && tp->version <=
> RTL_VER_15' excludes RTL_VER_12. Before this patch, RTL_VER_12 was handled
> by r8156b_init which executed these code paths unconditionally. The commit
> message states VER_12 is RTL8156B hardware.
> 
> Three specific behavioral changes for RTL_VER_12: (1) RX_DETECT8 is no
> longer set on USB_U2P3_CTRL (shown above), (2) the flow control
> initialization block (SLOT_EN clear, FLOW_CTRL_EN set, FC_TIMER, FW_CTRL,
> FW_TASK) is skipped later, and (3) the PHY_STAT_EXT_INIT path
> ocp_reg_clr_bits(tp, 0xa466, BIT(0)) is skipped because 'tp->version >=
> RTL_VER_13' excludes VER_12.
> 
> Should these be 'tp->version >= RTL_VER_12' instead to preserve the old
> r8156b_init behavior for RTL_VER_12 hardware?
> 
> [ ... ]
> 
Indeed, it appears that I had excluded RTL_VER_12 incorrectly for the 
RTL8156b. I will replace RTL_VER_13 in the comparisons with RTL_VER_12.

Again, the AI appears to refer to code that I did not submit. The patch 
I submitted does no longer have a r8156b_init function, however it is 
mentioned as present in the patch you cite.

B.

