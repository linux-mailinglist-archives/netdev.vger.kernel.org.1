Return-Path: <netdev+bounces-252345-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCPAKhEncmmadwAAu9opvQ
	(envelope-from <netdev+bounces-252345-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:33:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 180D967540
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 14:33:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D7A42964AE5
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 13:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68BE2F3C26;
	Thu, 22 Jan 2026 12:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HCh6vqEM"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B53FC2E1EE5;
	Thu, 22 Jan 2026 12:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086771; cv=none; b=IA8V5wX2/PRSs7p9zDQDClCj/kaPLrZgujjsx78+nT8coSF1Bb5haCqCbEL5ipf1mApsc9vj+ulg23Pm1+RNXN7rPYvG+pqkhxqHbRmRXo+CghADu6vJ6jGS32bgXwNmh8FNOvR0isBdGIgpXNTluEO8jacPD+8T033JUHdAk1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086771; c=relaxed/simple;
	bh=MWDw3AAVSvk/MYFg4ztfWp+iwoesgHv3MAG6GsmRKXw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gA7XK/dzDXYEwmBvnDU6Ve24DghrhAIF5qs3aIJdafWQQWEJyaQZ0qt5gYnflr0kJetmZFmo3qTF16lqZup1YdTDSNG9uJfYT5dC0B5oSV4+dPb1/7sQUwYWwAGifcoUqvR1WFAvVm5H94J0PJyl2TRxa1hD+M/77jmcwS/HvgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HCh6vqEM; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 035351A2A6F;
	Thu, 22 Jan 2026 12:59:27 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CCD36606B6;
	Thu, 22 Jan 2026 12:59:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 152F8119B81C8;
	Thu, 22 Jan 2026 13:59:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769086766; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=3OR/GLNTFE1Tsft1kZ2J5pKm0XV/jBEkGEJyzuLP8NY=;
	b=HCh6vqEMD92RMRqKguliV8WxOie4E78A3WqJsDpHKbZlL298Gzejj+Tp3fwb6pjZaYPhOh
	HHO7s9VrNu/NQCgClHXJcI9lxrb6TvNr1Xeq4RsgxnpJ6ID6YAwcH94GApienBBD34ceXY
	E0OftTLrgPKwAG6HMYhM+9KYSoj8LDs0bZ1RpjBjESbBCS7uHFkPenvckPACc+PY5+g0fb
	rPg9IK7TEfhxsIvNh5QzfEZTb0m7HCVfd7XteYTiS7WIiKcpjfWj7h6p8FH+3fjNXRZYPE
	nB1+i5gVNu6o//kTIU5MMaHbEpOXp5zpqakjDJMaG2buA+CzNLp6kdrRAz6Ztw==
Message-ID: <4f36ca91-9749-4502-bc30-838238d24ba3@bootlin.com>
Date: Thu, 22 Jan 2026 13:59:21 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 5/8] net: dsa: microchip: Add KSZ8463 tail tag
 handling
To: Simon Horman <horms@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260115-ksz8463-ptp-v1-0-bcfe2830cf50@bootlin.com>
 <20260115-ksz8463-ptp-v1-5-bcfe2830cf50@bootlin.com>
 <aW-4qgp0mGNPNiau@horms.kernel.org>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <aW-4qgp0mGNPNiau@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,se.com,bootlin.com,vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[bootlin.com,reject];
	TAGGED_FROM(0.00)[bounces-252345-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	RCPT_COUNT_TWELVE(0.00)[15];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 180D967540
X-Rspamd-Action: no action

Hi Simon,

On 1/20/26 6:17 PM, Simon Horman wrote:
> On Thu, Jan 15, 2026 at 04:57:04PM +0100, Bastien Curutchet (Schneider Electric) wrote:
>> KSZ8463 uses the KSZ9893 DSA TAG driver. However, the KSZ8463 doesn't
>> use the tail tag to convey timestamps to the host as KSZ9893 does. It
>> uses the reserved fields in the PTP header instead.
>>
>> Add a KSZ8463-specifig DSA_TAG driver to handle KSZ8463 timestamps.
>> There is no information in the tail tag to distinguish PTP packets from
>> others so use the ptp_classify_raw() helper to find the PTP packets and
>> extract the timestamp from their PTP headers.
>>
>> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
> 
> ...
> 
>> diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
>> index 9170a0148cc43b4213ec4bd8e81d338589671f23..635679402f8a96b29536a91988346a8825bae976 100644
>> --- a/net/dsa/tag_ksz.c
>> +++ b/net/dsa/tag_ksz.c
>> @@ -16,6 +16,7 @@
>>   #define KSZ9477_NAME "ksz9477"
>>   #define KSZ9893_NAME "ksz9893"
>>   #define LAN937X_NAME "lan937x"
>> +#define KSZ8463_NAME "ksz8463"
>>   
>>   /* Typically only one byte is used for tail tag. */
>>   #define KSZ_PTP_TAG_LEN			4
>> @@ -383,6 +384,108 @@ static const struct dsa_device_ops ksz9893_netdev_ops = {
>>   DSA_TAG_DRIVER(ksz9893_netdev_ops);
>>   MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9893, KSZ9893_NAME);
>>   
>> +#define KSZ8463_TAIL_TAG_PRIO		GENMASK(4, 3)
>> +#define KSZ8463_TAIL_TAG_EG_PORT_M	GENMASK(2, 0)
>> +
>> +static void ksz8463_xmit_timestamp(struct dsa_port *dp, struct sk_buff *skb)
>> +{
>> +	struct ksz_tagger_private *priv;
>> +	struct ptp_header *ptp_hdr;
>> +	unsigned int ptp_type;
>> +	u32 tstamp_raw = 0;
>> +	s64 correction;
>> +
>> +	priv = ksz_tagger_private(dp->ds);
>> +
>> +	if (!test_bit(KSZ_HWTS_EN, &priv->state))
>> +		return;
>> +
>> +	if (!KSZ_SKB_CB(skb)->update_correction)
>> +		return;
>> +
>> +	ptp_type = KSZ_SKB_CB(skb)->ptp_type;
>> +	ptp_hdr = ptp_parse_header(skb, ptp_type);
>> +	if (!ptp_hdr)
>> +		return;
>> +
>> +	correction = (s64)get_unaligned_be64(&ptp_hdr->correction);
>> +
>> +	if (correction < 0) {
>> +		struct timespec64 ts;
>> +
>> +		ts = ns_to_timespec64(-correction >> 16);
>> +		tstamp_raw = ((ts.tv_sec & 3) << 30) | ts.tv_nsec;
>> +
>> +		ptp_hdr->reserved2 = tstamp_raw;
> 
> I think that you need to assign a be32 rather than a u32 to reserved2.
> 

Indeed. By testing this back, I realize that this is only needed by the 
one-step mode. This series only adds support for two-step so I'll just 
remove this part.


Best regards,
Bastien



