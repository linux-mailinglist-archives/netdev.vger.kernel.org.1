Return-Path: <netdev+bounces-292108-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOUzLvGSFmrqnQcAu9opvQ
	(envelope-from <netdev+bounces-292108-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:45:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5718E5DFF7E
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B38530651F8
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 06:41:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E930235AC27;
	Wed, 27 May 2026 06:41:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d9s0Bidi"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0152039902B;
	Wed, 27 May 2026 06:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779864095; cv=none; b=hKTAPGp0SY29893D6+59Q+lKgod8D9e/Wp2fB2j6I4FVzy7mvHLBX08KmR+s7snPv7pezRKU5IblC9tNLEbLTNoUYPxDEpsQ+HH2XJATWZw26KRJLH42dPQFjDshTRQLxoGUr8m2ZVWFiKM1JpGsyw2QuO1QnhEgwjrQ5wqsjZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779864095; c=relaxed/simple;
	bh=EUWO9pcOg2aJxIzaHagl0pNX57Jt+u5NNryqDjS6kCI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MzmfD4/2zTLzmeJV6OCNvWUyA3uJ0G/CvcIBIBod//cRAEJhKgAlWQhQWLn4+KcWMPXhh8uPDTsX6E1yLH4/M932ufTMdxmjuj9FhdNcvdJDYSQmErIQ1r74wShAIAkBlw64tS8dvoyZq929O+p82iD4JIOXpuUrHAqOuB0OBdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d9s0Bidi; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 108ACC2C643;
	Wed, 27 May 2026 06:41:28 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 4DBD1601A1;
	Wed, 27 May 2026 06:41:28 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED6AF1088803C;
	Wed, 27 May 2026 08:41:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779864087; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=0U9YjNb6qykmV1QDXMiTogNVN1srvz5mIIvwxZKo4c4=;
	b=d9s0BidiuVgyHW4VnvauhXhDpkd+Ys8Qq1JCB9/mMf+0+GhFTUDqpdyTcc/Gr/Dqlvfwgz
	oXGoo+GDx0cBcacVGOdAzO1vK48A/4r6RXxLe1fuFiG4c3JWNTmYC8Uf90F/1YGMjSgjgY
	SLyFfJmR5oKbiw7wdgMJE6dp5ikcXVNwjKemWnRVyG/kQcKHmX8W+OJlKGmFy+KxdfHgWx
	+JKroRQwGHTKKq7RVDccqRR2x0Bu0NiqagpE4CxZ6DPEE6Cl8Z3potgfNv/z+8GtOZUGYM
	oeFbvMd9+LpcKBnsfTDa3yzNMOZFVztWdQE2ZGCXzetDPM7qpoTKTk54+4sLvg==
Message-ID: <43569bb0-98c1-4fc5-8b3e-c199d0c68250@bootlin.com>
Date: Wed, 27 May 2026 08:41:16 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] Documentation: networking: Add a test plan for
 ethtool pause validation
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Vladimir Oltean <vladimir.oltean@nxp.com>,
 Florian Fainelli <f.fainelli@gmail.com>, thomas.petazzoni@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
References: <20260522175109.198059-1-maxime.chevallier@bootlin.com>
 <20260526172447.10ca4b9e@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260526172447.10ca4b9e@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292108-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,gmail.com,lwn.net,linuxfoundation.org,pengutronix.de,nxp.com,bootlin.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 5718E5DFF7E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On 5/27/26 02:24, Jakub Kicinski wrote:
> On Fri, 22 May 2026 19:51:06 +0200 Maxime Chevallier (Netdev
> Foundation) wrote:
>>   Documentation/networking/pause_test_plan.rst | 556 +++++++++++++++++++
> 
> It'd be great to hear from others but IMHO in the current form this is
> not suitable for Documentation/networking/ We can commit the "knowledge"
> part but enumerating the test cases seems odd for Documentation/.

I think the same, I wasn't sure exactly how/where to send that to, so at 
least in this form you can generate that as a nicer to read html form, 
but this will likely change given Andrew's feedback

Maxime

