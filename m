Return-Path: <netdev+bounces-289772-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KHAjOmlTDWrAwAUAu9opvQ
	(envelope-from <netdev+bounces-289772-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:23:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 159AF5881A0
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 08:23:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 313BA3006D5C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 06:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 024F737268B;
	Wed, 20 May 2026 06:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="HCgskJps"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 934472E9ED6
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 06:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779258211; cv=none; b=ne/C4cjHTA5ymxMv2MdeplOH0DdixBxASln/nrAwgftXfC0VTfQ6h7xC+WX65kYfmnkgo/XTK6hLMfB+6DECnk0oUgrVAlddYMMGBfiArxWVORYoKa43iAn3oUVyrsrmpc7TJn/YBEj1OR8Y/UgYsnLDkP8aXO5dxFsf4l97mUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779258211; c=relaxed/simple;
	bh=7Q4R3furNO4h7Yab4Zal4eqQik4zrrk78QCoGOUHkXo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WKc7oB5h+ExJygCvkiMsUwD1J29T8NMxW8LUq2sOPnvPsvvorSasCSaU0BXZsRRPyXj5gRyZfEF8VT/iUgCTmDKj8KAnVoV2O9Vqv3NpJF5CRp7En672szVaG8FGo9zlCxdQv5b93kzMLKe5+Lflk/1HSPfR1YAbg/f8Rzrm9BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=HCgskJps; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id D084E1A363B;
	Wed, 20 May 2026 06:23:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 92FA26070E;
	Wed, 20 May 2026 06:23:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C18E107E9C49;
	Wed, 20 May 2026 08:23:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779258205; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=rOjeYYdRzTDpwvWM8Id5nwUl+GQuplW0764wBAzrADA=;
	b=HCgskJpsQG8gVXl9+SoAB/vz+1ZCE4A/g7IhpEWm8/f9oQkUwG8VKMQkOML4lNgjkXfeoX
	mCBOGBiXzTg/FAF3nkVINXZE6TNVJ4GVDHF6Q0xsZOvcdpaiSYj/UnsdFCo9M46YG3IrQS
	QNCJGN79f8H/94dxfb+iSWNeVKeERPgcj7XFXp6nv3KmHv2r6Z2c1kkiLoSWWg2cQWGrFV
	m6jRWKJGncBKVl3B7i7XsNDL2/sQarb+fARZi2fcdOimMjCD43bDhBARPDWcj9zhpCl0Vp
	ZvphHVhb+vFPVAKXT+zOudfER/Cowypdjax6OB9GIZZ0sMy9A1MN5RmIaVxU7w==
Message-ID: <ab7cfbf2-2491-4a18-b0fe-e245dc48b761@bootlin.com>
Date: Wed, 20 May 2026 08:23:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/8] net: dsa: microchip: don't reset on
 shutdown or driver removal
To: Jakub Kicinski <kuba@kernel.org>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>,
 Richard Cochran <richardcochran@gmail.com>,
 Pascal Eberhard <pascal.eberhard@se.com>,
 =?UTF-8?Q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tristram Ha <tristram.ha@microchip.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Vladimir Oltean <vladimir.oltean@nxp.com>
References: <20260515-clean-ksz-2nd-series-v2-0-35a968a739f6@bootlin.com>
 <20260515-clean-ksz-2nd-series-v2-1-35a968a739f6@bootlin.com>
 <20260519191006.01f83aed@kernel.org>
Content-Language: en-US
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
In-Reply-To: <20260519191006.01f83aed@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,armlinux.org.uk,se.com,bootlin.com,vger.kernel.org,nxp.com];
	TAGGED_FROM(0.00)[bounces-289772-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 159AF5881A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

On 5/20/26 4:10 AM, Jakub Kicinski wrote:
> On Fri, 15 May 2026 10:38:36 +0200 Bastien Curutchet wrote:
>> @@ -4170,16 +4170,15 @@ int ksz_set_wol(struct dsa_switch *ds, int port,
>>    * the wol_enabled flag accordingly to reflect whether WoL is active on any
>>    * port.
>>    */
>> -static void ksz_wol_pre_shutdown(struct ksz_device *dev, bool *wol_enabled)
>> +static void ksz_wol_pre_shutdown(struct ksz_device *dev)
> 
> this needs a kdoc update, did I not report it on v1?
> Maybe I forgot. scripts/kernel-doc is buggy, unfortunately
> and doesn't catch it. The fix is on the way.

Ok, I'll fix it in v3. I don't think that you reported it on v1.


Best regards,
Bastien


