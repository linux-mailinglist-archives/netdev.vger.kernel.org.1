Return-Path: <netdev+bounces-259292-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qDpKFCuUlWk1SgIAu9opvQ
	(envelope-from <netdev+bounces-259292-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:27:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E32A1556DF
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 11:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8DDD2302A9F5
	for <lists+netdev@lfdr.de>; Wed, 18 Feb 2026 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8312B27F754;
	Wed, 18 Feb 2026 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="23ZszNET"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727202797B5
	for <netdev@vger.kernel.org>; Wed, 18 Feb 2026 10:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771410186; cv=none; b=gRwwI6GxTmonj9JSlnVERBc5eihSAnAtLbjHO2YiELEqG17vinR+IEaDhSKnXrS7lp4WnZQeWOTEAL05gXfIlTfBy73r3oM/KbWFMnXz4JMfqe7/uMSm53LG9dvs/OPvlig+7LCr8ZLP6Fmcpy7KrUb/MaEI4SwH0xfMpfaGVLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771410186; c=relaxed/simple;
	bh=KXSxsS0KS5sBzF7hZf88JgsOaLg0aESnpZNXnxV4Cr0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HZW45pqBOmaLoJbzQMDXex6qh69Llg6po0Ror8rMvr+esCuBOAby3ayC2R3ZsriBi8eO9pfFzvOD6q7MzsqSvw9CDv6r+y3+QdzjpDuRcUcEYzzD7whvI7vnOh2zYNS8fEoqV34SXjdcdhlf3YrPb4LBtuPJi7CIjlpk5YIj1P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=23ZszNET; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id AA93D1A108B;
	Wed, 18 Feb 2026 10:23:02 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 7EB5060738;
	Wed, 18 Feb 2026 10:23:02 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 33CCC10368710;
	Wed, 18 Feb 2026 11:22:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1771410181; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=C09t4/Z5sG0k/xsZ9ftcPSXBPXf0UGwyK04jlPmA92I=;
	b=23ZszNET6ENPp0U6ZyqUlUPV77VJjyEMEWpYziu6RiaVWnA+gtvIAdYRUAF+mx40Q9oiEy
	piqHbMGUEUl5oBOHY0Vw4lZawH/3RkvMSagXn/jZxuuh5/edrN0PpUPihvMqGPh4nIvcsq
	jPcodvFWIFIvzdGoYjsRU6XN7n7DI1x0hPWoVn/3zIe4o2+aan7KEFfuKGk/AotaUQcqTX
	/p5yIDbAvDe0pSCazwavLVA3OaEu7MSG4D1Ovz4Or+vCjuo0rso1nEMVYz+c+yF/IUbRTT
	i5LKS+dd3wdf0eCFjsk50DsA6May1S9dUS3Su+9mnzMwgcRf0YTJ5jd3CQuJ/w==
Message-ID: <90af3964-e2d1-41a1-b731-91de05085730@bootlin.com>
Date: Wed, 18 Feb 2026 11:22:56 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4 6/8] net: dsa: microchip: Enable Ethernet PTP
 detection
To: Tristram.Ha@microchip.com, kuba@kernel.org
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, richardcochran@gmail.com, horms@kernel.org,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260127-ksz8463-ptp-v4-0-652e021aae86@bootlin.com>
 <20260127-ksz8463-ptp-v4-6-652e021aae86@bootlin.com>
 <20260129201720.0a63447b@kernel.org>
 <DM3PR11MB873640D9FA5A1CEC9EA36B2EEC9FA@DM3PR11MB8736.namprd11.prod.outlook.com>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <DM3PR11MB873640D9FA5A1CEC9EA36B2EEC9FA@DM3PR11MB8736.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,se.com,bootlin.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259292-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0E32A1556DF
X-Rspamd-Action: no action

Hi,

On 1/30/26 6:16 AM, Tristram.Ha@microchip.com wrote:
>> On Tue, 27 Jan 2026 10:06:48 +0100 Bastien Curutchet (Schneider
>> Electric) wrote:
>>> KSZ8463 needs to enable the Ethernet PTP detection to fire the
>>> interrupts when a timestamp is captured.
>>
>> Is it worth stating our expectation WRT other switches given this
>> is a shared function (not advocating to add a condition to be clear,
>> just document).

The PTP_ETH_ENABLE bit added here is already set by default on the 
'second generation' switches Tristram mentioned but not on the KSZ8463. 
I'll add details to the commit log.

> 
> KSZ8464 uses the first generation of PTP engine while KSZ9477/KSZ9567 and
> LAN937X use the second generation.  Most of their basic operations like
> transmitting are the same.  KSZ8463 enables 1-step E2E TC operation by
> default while the newer switches need to enable the function manually.
> Because of that the PTP function in KSZ8463 is disabled after driver
> starts until the Linux PTP stack wants to enable the feature.
> 

I think that here you refer to the PTP_ENABLE bit. It's indeed unset at 
init in ksz8_config_cpu_port() but it's then set back by 
ksz_ptp_enable_mode() when needed.

PTP_ETH_ENABLE (bit 5) enables detection of L2 PTP frames
PTP_ENABLE (bit 6) enables the full PTP feature.


Best regards,
Bastien

