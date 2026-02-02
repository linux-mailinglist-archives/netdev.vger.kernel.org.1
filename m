Return-Path: <netdev+bounces-255934-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2H1HCDfTgGmFBwMAu9opvQ
	(envelope-from <netdev+bounces-255934-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 17:39:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F2CCF122
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 17:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CCA330BD867
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 16:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A91B37998C;
	Mon,  2 Feb 2026 16:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="d+IoEgWb"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E54137E311
	for <netdev@vger.kernel.org>; Mon,  2 Feb 2026 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770049902; cv=none; b=RlBCgew86QiWlJDUr6prIjJ+3Y0oXVSsdh0nJsrsoAj/o8Xi70awHCQeBWJ7kuaq4POJphJwrpihywAVM+MC0wzJaJLYrgQPrcx2Hcx1E5cnemXKxIOraay1ja8pt8thXkF6+UOdHnjnXgUUkcirLU/GqPq5M9YYcVunneA8qfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770049902; c=relaxed/simple;
	bh=413oQ1pA+ghDm27uyMKwVnhPru1httjLl76oqinDZzY=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=iNN6NIaOtrsxX2QJ9Zda+PMWbFARRBp4sgB+5o08pVdQkQ0SyqBKegjFCcMui0avnhl+1gcekdOr1onDch6/hCBGQYu8rvSJO7gwtbnzeIHK33XKpSJ52ADukLB+X+V0UamGyROAtcCSMa35jjlYN2QFBVdAfbDLEXFgBT0mA8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=d+IoEgWb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id E1C864E423C0;
	Mon,  2 Feb 2026 16:31:31 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B735A60767;
	Mon,  2 Feb 2026 16:31:31 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id A4503119A8888;
	Mon,  2 Feb 2026 17:31:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770049890; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=7CeNhPr4e3aFJUKI9v6nEOJHXDh8xH/mqoPMi6dzBUY=;
	b=d+IoEgWbxWenExIz2LoHJQu+KCkw19PrARD9xkzR8UoFmEG1BTF43EYDcB1SShadnfvFCM
	l5ytqT3zgkPXOIlUrTXb+wwbTRkSFEMUEET1TclFExviMSwEdj+cduu8Np4T2U6v6bDlig
	hX9vcPyeLfdoIaj1zfBFWooVYSdj6vTcMIstofg9NYMieVWzZqNkVqwhFAHfXWoPAOpNJK
	yrRgnUH+4KGjJ/+AuoQ8KnAT4rC6UpUmabEutiFlIEg52vLXFRsVE+ne8ZgMFSaX1fm7vY
	J5C7VwbSOd/9j6FwaDS9DJgkksYFXP9r/vDnL59AF0gQa7Vh6xb/nlq1AFpVDQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 02 Feb 2026 17:31:25 +0100
Message-Id: <DG4MBFXG7GGG.3GFLWBUKH087T@bootlin.com>
From: =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>
Subject: Re: [PATCH net-next 0/8] net: macb: Add XDP support and page pool
 integration
Cc: "Nicolas Ferre" <nicolas.ferre@microchip.com>, "Claudiu Beznea"
 <claudiu.beznea@tuxon.dev>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Lorenzo Bianconi" <lorenzo@kernel.org>, =?utf-8?q?Th=C3=A9o_Lebrun?=
 <theo.lebrun@bootlin.com>, =?utf-8?q?Gr=C3=A9gory_Clement?=
 <gregory.clement@bootlin.com>, "Thomas Petazzoni"
 <thomas.petazzoni@bootlin.com>
To: "Paolo Valerio" <pvalerio@redhat.com>, <netdev@vger.kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260115222531.313002-1-pvalerio@redhat.com>
In-Reply-To: <20260115222531.313002-1-pvalerio@redhat.com>
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255934-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[theo.lebrun@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 84F2CCF122
X-Rspamd-Action: no action

On Thu Jan 15, 2026 at 11:25 PM CET, Paolo Valerio wrote:
> Paolo Valerio (7):
>   net: macb: rename rx_skbuff into rx_buff
>   cadence: macb: Add page pool support handle multi-descriptor frame rx
>   cadence: macb: use the current queue number for stats
>   cadence: macb: add XDP support for gem
>   cadence: macb: make macb_tx_skb generic
>   cadence: macb: make tx path skb agnostic
>   cadence: macb: introduce xmit support
>
> Th=C3=A9o Lebrun (1):
>   net: macb: move Rx buffers alloc from link up to open

`net: macb:` is the right prefix for MACB. Two commits use it but not
the other ones. Sending this one-off comment as I just noticed it
(while generating the XSK series).

Thanks,

--
Th=C3=A9o Lebrun, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


