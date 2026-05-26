Return-Path: <netdev+bounces-291864-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFFGLdvZFWpYdAcAu9opvQ
	(envelope-from <netdev+bounces-291864-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:35:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6065E5DAC11
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 19:35:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5A92F30355EE
	for <lists+netdev@lfdr.de>; Tue, 26 May 2026 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0639C40B6D0;
	Tue, 26 May 2026 17:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="aaqGH2Tb"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C751409134
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779816621; cv=none; b=XGQozjQRNOEf11IqjLgQ9gNAKpBVPXZb4i+VHA8EK2qiL1nnhippGKcaPPPI6dJyYXa3Gu6+QE0soz0VfXbgQIIpsNoxI/btawSGquDDKEyaaui4z+WRfewzMedxJo+hlpS8YWxSKEm1mGvrfj1bLWs1U+ODh79b+aVDxtd8VSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779816621; c=relaxed/simple;
	bh=Dv5uPsCAT/1j1WstcpocTP7TcL21F91ECEcH4+6Ny3g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hA1bBYrbPmhxE1FK+I1LJvPTNYU6KaUtu0Zzd1GUooVwvCNhsnzhQ+xlopnPfePwlMscQ9x1ofjqrpksVVxacAKXXnw733ICULtbhtBPUC0nqDNMTCg6u4I5FjlloiklHEworexDINEBrGUvAwF3MFTyupfmA3v8p0Hiu82/zfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=aaqGH2Tb; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DF4A94E42D61;
	Tue, 26 May 2026 17:30:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 99E596011D;
	Tue, 26 May 2026 17:30:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BFD27108889CC;
	Tue, 26 May 2026 19:30:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779816616; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Ix6O67LPhQjcw0qkAU/4CFtYmXqn5WjrGZujIJogIOM=;
	b=aaqGH2TbqtjPP8Cw+wNKbeFmVjacNlu4RLja4Jwv8PVCl+9qsTzx+7IgMGDjMgdUiC36KC
	h7zGMOnTOVMofKNJPp7tQh0N+87QV6XknVqUspBoB2vZKiXhpeAIP0fe4bOc/Pd3wmCCar
	AmCp9W0D4perHtb1bxgHSqjMKE2pROLL+7rMePOIJF81RYfySlowiBy5m7y2FoAvU7NVg6
	s08587mH+SpPH4zTLjZWQ92Y561Ns5jCVnLaD6ZZOvmOAIPfwjljk7hkvyW9ssilNfAhqB
	1Pr3SWFK7ARF/1uLrhIjOM4Sj5cKqNdqGd5mKElnp/wjE6BLe/hVUJLGIWWFlg==
Message-ID: <ab46e47a-bb95-44c9-a43a-c5f208607a6c@bootlin.com>
Date: Tue, 26 May 2026 19:30:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 10/10] ethtool: eeprom: add more safeties to EEPROM
 Netlink fallback
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, o.rempel@pengutronix.de,
 kory.maincent@bootlin.com, haiyangz@microsoft.com, andrew@lunn.ch,
 vladyslavt@nvidia.com
References: <20260526153533.2779187-1-kuba@kernel.org>
 <20260526153533.2779187-11-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260526153533.2779187-11-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291864-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,lunn.ch:email,nvidia.com:email,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: 6065E5DAC11
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/26/26 17:35, Jakub Kicinski wrote:
> The Netlink fallback path for reading module EEPROM
> (fallback_set_params()) validates that offset < eeprom_len,
> but does not check that offset + length stays within eeprom_len.
> The ioctl equivalent (ethtool_get_any_eeprom() in ioctl.c) has
> always enforced both bounds:
> 
>    if (eeprom.offset + eeprom.len > total_len)
>        return -EINVAL;
> 
> This could lead to surprises in both drivers and device FW.
> Add the missing offset + length validation to fallback_set_params(),
> mirroring the ioctl.
> 
> Similarly - ethtool core in general, and ethtool_get_any_eeprom()
> in particular tries to zero-init all buffers passed to the drivers
> to avoid any extra work of zeroing things out. eeprom_fallback()
> uses a plain kmalloc(), change it to zalloc.
> 
> Fixes: 96d971e307cc ("ethtool: Add fallback to get_module_eeprom from netlink command")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> CC: andrew@lunn.ch
> CC: maxime.chevallier@bootlin.com
> CC: vladyslavt@nvidia.com
> ---
>   net/ethtool/eeprom.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ethtool/eeprom.c b/net/ethtool/eeprom.c
> index 836316df3092..0b8cfeddb014 100644
> --- a/net/ethtool/eeprom.c
> +++ b/net/ethtool/eeprom.c
> @@ -44,6 +44,9 @@ static int fallback_set_params(struct eeprom_req_info *request,
>   	if (offset >= modinfo->eeprom_len)
>   		return -EINVAL;
>   
> +	if (length > modinfo->eeprom_len - offset)
> +		return -EINVAL;
> +
>   	eeprom->cmd = ETHTOOL_GMODULEEEPROM;
>   	eeprom->len = length;
>   	eeprom->offset = offset;
> @@ -69,7 +72,7 @@ static int eeprom_fallback(struct eeprom_req_info *request,
>   	if (err < 0)
>   		return err;
>   
> -	data = kmalloc(eeprom.len, GFP_KERNEL);
> +	data = kzalloc(eeprom.len, GFP_KERNEL);
>   	if (!data)
>   		return -ENOMEM;
>   	err = ethtool_get_module_eeprom_call(dev, &eeprom, data);


