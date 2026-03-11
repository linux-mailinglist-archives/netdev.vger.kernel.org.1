Return-Path: <netdev+bounces-266641-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNKmBfNlsWnsugIAu9opvQ
	(envelope-from <netdev+bounces-266641-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:54:11 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 2801E263E4C
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 13:54:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 24A5B300844F
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 12:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B90522A1D4;
	Wed, 11 Mar 2026 12:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Jr41CUrh"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4771929B8E8
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773233634; cv=none; b=DbYi3VEy4nV/eSqa5pNgq7yS9/WSCLAiNCg9AZaTU9piYQlsVUmfDHGr0+uiEsPFK45lzF8zOcwGYR5RSVDzB5hITPCSmgY7AyWc98KR8RjS1vdSMmGUhF2wbOJOSp7k4+MsGxn3uAYw0L3jei9Bnkc3/M/TCfEmMLtZixrgOTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773233634; c=relaxed/simple;
	bh=IjEo71rZSBKqNqnSG9WknMH/egRoyQ6kAb1SbqI91HQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=h7BAKwfEMhhfmnRWUGbZ6Akj1UpegCZPUUpB2Gfb/H8TYNl9/l4A8c3JaJwQs9as2qN+EMp29ZevEAxTaqX+p5EDG3NFA+tS2echiGi0Rs0eVk5fv1WpMlyH/kxbLbMoD25UlN7b1IlsK2oyYdCR6/sNaBhknBwqJejRgUN0bO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Jr41CUrh; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id CC00B4E42603;
	Wed, 11 Mar 2026 12:53:44 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 980CB60004;
	Wed, 11 Mar 2026 12:53:44 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FB3610369D06;
	Wed, 11 Mar 2026 13:53:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773233623; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=6N94Twge3mXySXHJqsx8WmhOq9gUNWTF43pzlXy/32k=;
	b=Jr41CUrhKqP19XasiQPV9NeUaM0AhUnZQ8C4UxaL34Cy3Jmv1D2DSzYoyqRlW8SVkWhoxU
	MIfKpqOjd/qLVum7WzGSqWVT6RDmlLoORpE0w0eWPEAIpRavnqCCFcnETT8tSfTuYIAjrA
	2YPxvZdXD7lTOSHNYFUfkRbEJNCWWNBRtDnbLC5PxQJoG2jSBy5xcPwbjwwLGT3n+08xBM
	cVqvXVgplUEzstL5zUl+lwQcZWmbkO7Ljk4h2pAeWANUgwM7YC4QGjIMlHl2vDHkt/vCB7
	WYO3Qm74D8XiOF1RF6/fCzc3u0Wb10+fh0Ik4vqXDbZRu+i45PbBpWywVxYa0w==
Message-ID: <c3812b1f-50b7-4663-92f5-14c5c6b483a2@bootlin.com>
Date: Wed, 11 Mar 2026 13:53:38 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 1/9] net: dsa: microchip: Add support for
 KSZ8463 global irq
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Woojung.Huh@microchip.com, UNGLinuxDriver@microchip.com, andrew@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, richardcochran@gmail.com, horms@kernel.org,
 pascal.eberhard@se.com, miquel.raynal@bootlin.com,
 thomas.petazzoni@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, maxime.chevallier@bootlin.com,
 Tristram.Ha@microchip.com
References: <20260304-ksz8463-ptp-v6-0-3f4c47954c71@bootlin.com>
 <20260304-ksz8463-ptp-v6-1-3f4c47954c71@bootlin.com>
 <20260305095656.vlyaztv6nbdqrmil@skbuf>
 <98944cef-0877-4fb9-83a0-92bbd3852f66@bootlin.com>
 <20260305125149.ejju5ptrkviqi3sm@skbuf>
 <a3a915af-5190-4582-a3e6-4ebf92a7e35d@bootlin.com>
 <DM3PR11MB87364DB5439A20F44AEB690DEC7AA@DM3PR11MB8736.namprd11.prod.outlook.com>
 <0658868d-671c-46a2-8daa-26420cdd2975@bootlin.com>
 <20260309205401.bk5fpw6kqnmlktbu@skbuf>
 <dde60639-af13-4653-9a34-38c4bd98b149@bootlin.com>
 <20260311115356.windefb3j4kkuslg@skbuf>
From: Bastien Curutchet <bastien.curutchet@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260311115356.windefb3j4kkuslg@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 2801E263E4C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266641-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,se.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bastien.curutchet@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Action: no action

On 3/11/26 12:53 PM, Vladimir Oltean wrote:
> On Wed, Mar 11, 2026 at 11:02:35AM +0100, Bastien Curutchet wrote:
>> I, more or less, managed to fit this PTP support in the current framework,
>> but the next series I prepared to add periodic output support is full of
>> is_ksz8463() branches. So I think that I'll go with what you suggested and
>> try to move the KSZ8463 support in the ksz8995.c driver. It will probably be
>> cleaner this way.
>>
>> TBH I'm a bit lost with all these KSZ variants but IIUC KSZ8463 and KSZ8995
>> both belong to the 'old generation' of the hardware. Maybe a good split
>> would be to have these old switches in the ksz8995.c driver and keep the
>> rest under ksz_common infra.
> 
> Wait, to make sure I understand, you said you're going to rebase this
> series onto the ksz8995 driver?


Well I'll first add basic support for the KSZ8463 in the ksz8995 driver 
and then add interrupt and PTP support on top of it yes. Did I 
misunderstand you're suggestion ?

