Return-Path: <netdev+bounces-269580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aKJCHJEzvGl3uwIAu9opvQ
	(envelope-from <netdev+bounces-269580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:34:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E704D2D012F
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 18:34:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AAFA322272A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 17:27:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2C5E3ECBE1;
	Thu, 19 Mar 2026 17:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="OxeUfd3i";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="OxeUfd3i"
X-Original-To: netdev@vger.kernel.org
Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E3538AC96;
	Thu, 19 Mar 2026 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773941257; cv=none; b=vFsAVxJbtMlund4ncrtCRE3BRKLpRs1D2ha9swkhl/7gSqgQK9YYVaCYcPizZTbKD0QMZKJWtANeSEg/+q1ccFK4tUNz77IMws25yIhx2oldxzLTifgVWrolL8I//11yRqEf6hgoreOpZWt3JhymcYzGatLpM5uoOljSYknDz3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773941257; c=relaxed/simple;
	bh=ZKbw9FWJvXWeOQB5rUrkA/ki/dPVf/T9wGpjTwUjMZg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=iDNMp97lAtICFcXPHpJGYqEUhK/IOC7JDa6FrMvtjwlNzaQDHPKtzSpK9ObVCFp7SOO85Ae+uYvFArd4gSep/aTzAwd+uJ0ZZTGpxqaFiyS7SHW6YIF4/zDBRty3ol2tcjXbFKWQKUi5mRwEFi8FlWmv9n5R0cpbN9vK8PI8EHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=OxeUfd3i; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=OxeUfd3i; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773941254;
	bh=ZKbw9FWJvXWeOQB5rUrkA/ki/dPVf/T9wGpjTwUjMZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OxeUfd3i+Ag6Xm1/EpFAFx+BT2tJuVWyltiX3GJEX2sOnBkD7gatf8x81DslIK1H7
	 mEywZZHJK1ilgi30shBtFGOk38K+rCburnW1a1FLNcZnjmkOJR9J3mBIrtAl6lbc+F
	 Xb3lqrsII0FQcO3ENkEyHxm2GVBH5KnrJTfg2kt0c0fKZHWaWHLMQ4IcmH1bUF4o0/
	 y6z68AzarpSDoQGUEQTIhyZrZkRK6uVplmrfpKs+DQPyvJfDEnf8zM4tzQLi5pmkeB
	 RZYu4iFvzkfPp0vpehlNLK3pVEcEh3xec93s1eCZams7dbiPKGc5+omhwLakt9clh3
	 496af2U0YAVzQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 8D3CA3FEBE; Thu, 19 Mar 2026 17:27:34 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1773941254;
	bh=ZKbw9FWJvXWeOQB5rUrkA/ki/dPVf/T9wGpjTwUjMZg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OxeUfd3i+Ag6Xm1/EpFAFx+BT2tJuVWyltiX3GJEX2sOnBkD7gatf8x81DslIK1H7
	 mEywZZHJK1ilgi30shBtFGOk38K+rCburnW1a1FLNcZnjmkOJR9J3mBIrtAl6lbc+F
	 Xb3lqrsII0FQcO3ENkEyHxm2GVBH5KnrJTfg2kt0c0fKZHWaWHLMQ4IcmH1bUF4o0/
	 y6z68AzarpSDoQGUEQTIhyZrZkRK6uVplmrfpKs+DQPyvJfDEnf8zM4tzQLi5pmkeB
	 RZYu4iFvzkfPp0vpehlNLK3pVEcEh3xec93s1eCZams7dbiPKGc5+omhwLakt9clh3
	 496af2U0YAVzQ==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id C552C3FC74;
	Thu, 19 Mar 2026 17:27:33 +0000 (UTC)
Message-ID: <70284a5d-7f93-45b0-a953-683c4c42ddcd@birger-koblitz.de>
Date: Thu, 19 Mar 2026 18:27:33 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 2/2] r8152: Add support for the RTL8157
 hardware
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260317-rtl8157_next-v2-0-10ea1fa488d1@birger-koblitz.de>
 <20260317-rtl8157_next-v2-2-10ea1fa488d1@birger-koblitz.de>
 <4522d3e9-217f-4fd1-962b-1f009ee6d9f7@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <4522d3e9-217f-4fd1-962b-1f009ee6d9f7@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[birger-koblitz.de:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[birger-koblitz.de:+];
	TAGGED_FROM(0.00)[bounces-269580-lists,netdev=lfdr.de];
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
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,birger-koblitz.de:dkim,birger-koblitz.de:mid]
X-Rspamd-Queue-Id: E704D2D012F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 19/03/2026 5:42 pm, Andrew Lunn wrote:
>> +static int wait_cmd_ready(struct r8152 *tp, u16 cmd)
>> +{
>> +	int i, ret = 0;
>> +
>> +	for (i = 0; i < 10; i++) {
>> +		u16 ocp_data = ocp_read_word(tp, MCU_TYPE_USB, cmd);
>> +
>> +		if (!(ocp_data & ADV_CMD_BUSY))
>> +			break;
>> +		usleep_range(1000, 2000);
>> +	}
>> +
>> +	if (i == 10)
>> +		ret = -ETIMEDOUT;
>> +
>> +	return ret;
> 
> It is better practice to use one of the helpers from linux/iopoll.h.
Will do. I think poll_timeout_us should work nicely. Thanks for the pointer!

> 
>> -static int r8152_tx_csum(struct r8152 *tp, struct tx_desc *desc,
>> +static int r8152_tx_csum(struct r8152 *tp, void *d,
>>   			 struct sk_buff *skb, u32 len)
>>   {
>> +	struct rx_desc *desc = d;
>>   	u32 mss = skb_shinfo(skb)->gso_size;
>>   	u32 opts1, opts2 = 0;
>>   	int ret = TX_CSUM_SUCCESS;
> 
> Reversed Christmas tree is already messed up here, but please don't
> make it worse. Add desc after mss.
Will do.

> 
>> +static void r8157_rx_vlan_tag(void *desc, struct sk_buff *skb)
>> +{
>> +	struct rx_desc_v2 *d = desc;
>> +	u32 opts1 = le32_to_cpu(d->opts1);
> 
> And here you need to move the assignment into the body in order to
> keep to reverse Christmas tree.
Will do.

Thanks for your review, Andrew!

Birger

