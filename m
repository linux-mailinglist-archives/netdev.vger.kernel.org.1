Return-Path: <netdev+bounces-303495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id f5rtAQu+RGoU0AoAu9opvQ
	(envelope-from <netdev+bounces-303495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:13:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E38B66EA88A
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 09:13:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=bootlin.com header.s=dkim header.b=KNJmXBzA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303495-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303495-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=bootlin.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AF4E9304D972
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 07:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26FC437F8AD;
	Wed,  1 Jul 2026 07:07:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645ED345734
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 07:07:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782889634; cv=none; b=m0wbYo61+W53wrHtSbMkIibaeDe6yAvyh+y4tBpAbx/1aflTOve4by0KsEO9PcScir8I2L5UXO07eor+UKg+R4H/6Sl4oQSTtecFvpQA7XQXQYEfrOdOE3ysHhJ20DKIZ9G7/CZsx1Be7j5x3gF5Ej/dcYsXoNrCouyZOwrh5i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782889634; c=relaxed/simple;
	bh=XuMZ8+mFbgR9j8LA7OKE+uxnbtH8pM4ZCfuc4rtF80I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEKux6HVLJaWakFLBp56XQTcn+cF+ixwvBRASbgEfZgqvo16qDvtaz2gZ9akmOosnZuGQQBbvNJBdsrpTmEHmoZFUkNhFCtwR2dk8BYxiDcUBc5DP8KumUvZEHr+CPjJMmTXne1VMUqaXBl8nrzd8Fendu/bnP2H5NJXY7AWhMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KNJmXBzA; arc=none smtp.client-ip=185.171.202.116
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 666D1C79AB6;
	Wed,  1 Jul 2026 07:07:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B368860288;
	Wed,  1 Jul 2026 07:07:00 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 50DE3104C9988;
	Wed,  1 Jul 2026 09:06:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1782889619; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=U7DRiFuAOAPDhfStcuT1pgWpZEWoqx8/JuiW2Ab02S8=;
	b=KNJmXBzAV5oMriNpY7tRZVFbdkSTntSE8dAGH82Vc7aQasX7rPbs3F7S/sN4dJgZNorKnw
	Pu9XHEz3DHU70wRTjFTcZxTmi5IyQIEWz/j7deRIWMPyiPSycneu4lurtXshpUOTI/snQm
	FRt36V4f8m5oNYu4gmNfa/mF2jLy1kZqXYV/mI03wWM4QlX4h32WG7B6DNM0n94Q9/riwn
	DdLu3kp/hRjNn3D8j2N3h/4co7R7Qm0Vfq+JX0jBEEqHtC9btntQdC0qmoWm1CW9YlDU0H
	6p+gJXSBxDz/TFjcw7rFoEc89BdfJ2boBZGfj1H7E/XtrXvNl+Ae+lLlRuFrqw==
Message-ID: <7a861f08-6bfc-4ed8-b8ca-9f4317dde630@bootlin.com>
Date: Wed, 1 Jul 2026 09:06:54 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] net: stmmac: L3/L4 filter bug fixes
To: muhammad.nazim.amirul.nazle.asmade@altera.com, netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, rmk+kernel@armlinux.org.uk,
 Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org
References: <20260630115622.9426-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260630115622.9426-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	DKIM_TRACE(0.00)[bootlin.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-303495-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:rmk+kernel@armlinux.org.uk,m:Jose.Abreu@synopsys.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:email,bootlin.com:dkim,bootlin.com:mid,bootlin.com:from_mime,vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E38B66EA88A

Hi,

On 6/30/26 13:56, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> This series fixes three bugs in the stmmac L3/L4 TC flower filter
> implementation for the XGMAC2 core. All three patches target net.

A quick note on that, I noticed all your recent series on stmmac are
missing the tree tag in the subject line. It should be something like

 [PATCH net v3 0/3] net: stmmac: L3/L4 filter bug fixes

you can add it when generating patches with :

git format-patch --subject-prefix='PATCH net-next' start..finish

cf https://docs.kernel.org/process/maintainer-netdev.html#indicating-target-tree

You can also use b4 for this.

Thanks,

Maxime


