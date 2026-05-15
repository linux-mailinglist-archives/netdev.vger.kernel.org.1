Return-Path: <netdev+bounces-288350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QArsN8hDB2oCvAIAu9opvQ
	(envelope-from <netdev+bounces-288350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:03:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B5475529E3
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 18:03:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E58B7303860B
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 15:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE6DD3E0082;
	Fri, 15 May 2026 15:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IB8jXbVt"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6F183B27EA;
	Fri, 15 May 2026 15:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778859939; cv=none; b=likc7qFIn2MmeP0J03XdOF7MaQ26FPAEa+0A5kvkQyzY4EnSRUl5li23uHBI2VZcK4uMBwfXenNz9d21HPk5IecwnZaRX69PegQcH8ZTa8cDwi8U3Qehy/haprtTodp+IxEexzIOzb9PdZbQyqo3LI5rkCSbcaLdERY0Tn94+Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778859939; c=relaxed/simple;
	bh=vtSjz5p5A911BGAxbJB3v+m+MYtuLj5cd0rq0Thr1/M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YZ0GL55CMXlgPu83iiLeVMUOrbFiLYf8ro7ev5QWnLlALqD+742JqVTq7fH0HxBVHrSPyK6Bt+zV+cW8bhSUHLDw3kaiMH+6j5dfdkSTxTgjbkGOPUgzKkcKBS6ejJZnQ1WkyKl0otZWjb07qUur3boLWMLPj0z6kIK03IcOKew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IB8jXbVt; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 2A57CC2B9C5;
	Fri, 15 May 2026 15:46:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9414E606FD;
	Fri, 15 May 2026 15:45:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 28BF711AF82F1;
	Fri, 15 May 2026 17:45:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1778859932; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=knt26lqT6LwhBS04wTRHGc1JT/AC9IuOf4RNZJ7n/vA=;
	b=IB8jXbVt0CC3pnMgm/cCdgCT7FMBCO/4ysgLd8slW4wyCvbiDvLxjwEinG+SCwN9tloriw
	/rwMN63wGB9Lj2mTxOJUvmezHsYH9cBc/Bcr5JeurmqUtbHlbQDsL6GMQQJoTuzPWL39HR
	QMWQMIo/7oFF83sefNEsGziupE75Fa1vlBYbWvLzJ6kXOFyW+ZaYJWZGF7C55chxBSAkh8
	ps9x8RrzQ+vD4CpmD1ePoA+HbLYvnuis1ARYC8UUjUcwMDY4eg/COHlyAUFza9GMe6r9f1
	ibbExl3KvDePHD42irrtcPbwdL4Q4JRnyD+1VSY6dH8QiIKAJceLg1WzadA0lA==
Message-ID: <9616afb9-a506-4d5a-94ca-269e78fb6a0e@bootlin.com>
Date: Fri, 15 May 2026 17:45:24 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3 net-next] net: mdio: mscc-miim: Remove some redundant
 code
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <cover.1778856199.git.christophe.jaillet@wanadoo.fr>
 <11209c6c6485656cc9a841c495381c540783798a.1778856199.git.christophe.jaillet@wanadoo.fr>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <11209c6c6485656cc9a841c495381c540783798a.1778856199.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Rspamd-Queue-Id: 7B5475529E3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288350-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[wanadoo.fr,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com];
	DKIM_TRACE(0.00)[bootlin.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi,

On 5/15/26 16:50, Christophe JAILLET wrote:
> *pbus is assign twice with the same value. Remove one of the redundant
> assignment.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

> ---
>   drivers/net/mdio/mdio-mscc-miim.c | 2 --
>   1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/net/mdio/mdio-mscc-miim.c b/drivers/net/mdio/mdio-mscc-miim.c
> index 259944d37fbd..03878bd9091d 100644
> --- a/drivers/net/mdio/mdio-mscc-miim.c
> +++ b/drivers/net/mdio/mdio-mscc-miim.c
> @@ -233,8 +233,6 @@ int mscc_miim_setup(struct device *dev, struct mii_bus **pbus, const char *name,
>   
>   	miim = bus->priv;
>   
> -	*pbus = bus;
> -
>   	miim->regs = mii_regmap;
>   	miim->mii_status_offset = status_offset;
>   	miim->ignore_read_errors = ignore_read_errors;


