Return-Path: <netdev+bounces-306103-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WZLyLP5lT2rjfwIAu9opvQ
	(envelope-from <netdev+bounces-306103-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:12:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE3F72EC06
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 11:12:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=fritz.com (policy=quarantine);
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306103-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306103-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E5BB31BDAA2
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 08:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704833FF892;
	Thu,  9 Jul 2026 08:55:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.avm.de (mail.avm.de [212.42.244.120])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B3E402BBA;
	Thu,  9 Jul 2026 08:55:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783587308; cv=none; b=UisqT73ad7GeiWXyWYfvWngvAywQ5TG57Tcl3wEhL/THxXMPuc6QchpbAH2TmzdC4XbRkW/3Pu2lo46AN61vL7tfcmfbeqBE5Zck4WIaADXU9ox0vDYZcj9JU8epB5Rq2RuM6YECe0hm1V29lwbvLMooEBGOhp7KS+Ml0Srudqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783587308; c=relaxed/simple;
	bh=HsuRVWPza98hL7cbpxlihrTiFz6Ps4mJBPN4fAvD5YM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WV5jbuc3Kh8+xdH4EJUnhbuY9OWn1CdEXdrDNuTkYkQ5ygwJNHqt5T2cY3yzaz5iSh7vUETmJTiQ6YVM3FVmft8JGMA9FJM9fZ6sqBPqREnGmsAR5A9k6v3sCYFhKy3IMQhO8eWStc4Dor8jUkyN9L8Ju3LfTD+q1i4wBSQZWC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fritz.com; spf=pass smtp.mailfrom=fritz.com; arc=none smtp.client-ip=212.42.244.120
Received: from [2001:bf0:244:244::71] (helo=mail.avm.de)
	by mail.avm.de with ESMTP (eXpurgate 4.57.1)
	(envelope-from <t.martitz@fritz.com>)
	id 6a4f60a0-7cb1-7f0000032729-7f000001873a-1
	for <multiple-recipients>; Thu, 09 Jul 2026 10:49:36 +0200
Received: from mail-auth.avm.de (dovecot-mx-01.avm.de [IPv6:2001:bf0:244:244::71])
	by mail.avm.de (Postfix) with ESMTPS;
	Thu,  9 Jul 2026 10:49:36 +0200 (CEST)
Message-ID: <4ffe7fe8-fdbb-42a1-b2b1-d11a351b2e16@fritz.com>
Date: Thu, 9 Jul 2026 10:49:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH RESEND 1/1] macvlan: allow source mode devices along with
 passthru
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260702065642.1783764-2-t.martitz@fritz.com>
 <20260708164350.1513604-1-horms@kernel.org>
Content-Language: de-DE
From: Thomas Martitz <t.martitz@fritz.com>
In-Reply-To: <20260708164350.1513604-1-horms@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-purgate-ID: 149429::1783586976-6FE921B0-166D5650/0/0
X-purgate-type: clean
X-purgate-size: 3755
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[fritz.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306103-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:horms@kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[t.martitz@fritz.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[t.martitz@fritz.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,fritz.com:from_mime,fritz.com:email,fritz.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0DE3F72EC06

Hi Simon,

Am 08.07.26 um 18:43 schrieb Simon Horman:
> This is an AI-generated review of your patch. The human sending this
> email has considered the AI review valid, or at least plausible.
> Full review at: https://sashiko.dev

Thanks for feedback. The remarks are valid, I agree. I also begin to better
understand the macvlan code so I'm a bit more confident now about which of
the existing "macvlan_passthru" checks need treatment. I'll send an updated
patch.

General question though: The initial posting triggered an AI review (I see
that now, I didn't know about https://sashiko.dev before). But it did not
trigger an email. Can you explain why? Because I accidentally dropped the RFC
tag from the mail subject?

Best regards.


> ---
> macvlan: allow source mode devices along with passthru
> 
> This allows for configurations where there are a few
> known senders in the system (e.g. multiple SoCs on the same
> board) along with unlimited external senders.
> 
>> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
>> index c40fa331836bb..d28f9d905a84d 100644
>> --- a/drivers/net/macvlan.c
>> +++ b/drivers/net/macvlan.c
> 
> [ ... ]
> 
>> @@ -1523,10 +1514,30 @@ int macvlan_common_newlink(struct net_device *dev,
>>  	if (data && data[IFLA_MACVLAN_FLAGS])
>>  		vlan->flags = nla_get_u16(data[IFLA_MACVLAN_FLAGS]);
>>  
>> +	/* Only 1 macvlan device can be created in passthru mode. There may be
>> +	 * additional source mode devices but nothing else at the moment.
>> +	 *
>> +	 * First check if adding a source mode device to an existing passthru vlan.
>> +	 */
>> +	if (macvlan_passthru(port) && vlan->mode != MACVLAN_MODE_SOURCE) {
>> +		/* The macvlan port must be not created this time,
>> +		 * still goto destroy_macvlan_port for readability.
>> +		 */
>> +		err = -EINVAL;
>> +		goto destroy_macvlan_port;
>> +	}
> 
> [Severity: High]
> While macvlan_common_newlink() prevents creating non-SOURCE devices on a
> passthru port, macvlan_changelink() does not seem to have a similar check.
> 
> Can a user bypass this restriction by creating a SOURCE device and then using
> changelink to modify its mode to VEPA, bypassing MAC isolation?
> 
> [Severity: High]
> With source devices and passthru devices now coexisting on the same port,
> functions like macvlan_open(), macvlan_stop(), and macvlan_sync_address()
> check the port-wide macvlan_passthru(vlan->port) flag instead of the device
> mode.
> 
> If a user brings down a SOURCE device on a passthru port, will macvlan_stop()
> incorrectly take the passthru teardown path? This appears to skip dev_uc_del()
> and call dev_set_promiscuity(..., -1) for a device that never incremented it.
> 
>> +
>> +	/* Now check if adding a passthru device to an existing set of source mode
>> +	 * devices.
>> +	 */
>>  	if (vlan->mode == MACVLAN_MODE_PASSTHRU) {
>> -		if (port->count) {
>> -			err = -EINVAL;
>> -			goto destroy_macvlan_port;
>> +		struct macvlan_dev *p;
>> +
>> +		list_for_each_entry(p, &port->vlans, list) {
>> +			if (p->mode != MACVLAN_MODE_SOURCE) {
>> +				err = -EINVAL;
>> +				goto destroy_macvlan_port;
>> +			}
>>  		}
>>  		macvlan_set_passthru(port);
> 
> [Severity: High]
> If a PASSTHRU device is deleted while SOURCE devices still exist on the port,
> macvlan_uninit() decrements port->count but does not clear MACVLAN_F_PASSTHRU.
> 
> Does this leave the port in a permanently broken state where new PASSTHRU
> devices cannot be created, and remaining SOURCE devices continue to be
> mistakenly treated as passthru?
> 
>>  		eth_hw_addr_inherit(dev, lowerdev);
> 


-- 
Thomas Martitz <t.martitz@fritz.com>
FRITZ! Technology GmbH, Berlin (Germany)

