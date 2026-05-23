Return-Path: <netdev+bounces-291119-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 3uRpE9fAEWpDpgYAu9opvQ
	(envelope-from <netdev+bounces-291119-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:59:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD745BF7EF
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0BF073006144
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2552EBB86;
	Sat, 23 May 2026 14:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jhsKmrQ7"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65C7921CC51
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 14:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779548370; cv=none; b=Xo+VHE0Z2V1Yza+UJoIjuOTWtMSzHMz9HAZMU32jXL8OkY4mdTk2zNGDNiCRG5kYlOaGXl8PAYtazydNOMx3BP8FbPAtVnctl0gPOZrMtRhScIrgFA/Mz+2P4RAJtaMlgGG0WsW59t+7DJKjsbix5IXk2O03zUf1/oAZ3QZ/Oy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779548370; c=relaxed/simple;
	bh=n9cxuIqsryWxOGse02HaTKbmwZgYUAilAZrEk8VkV+o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fVl+SNAN7PoY+nGRaUw1zmZ+1Ddty/pZfoEBZQkK4Xy4UyOBnxda77ra2Twcb6nezyYRNXBo5akb5eiXYcQCD6Lmn629BxOP2Lcg3ZAHmDqg+bKLz02pTOZN0YcE5RwGAJuqqU6Cjnf9h1WJbFXN+qJ2Kf8noXi4oFQhv5OPBIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jhsKmrQ7; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id A30B04E42D36;
	Sat, 23 May 2026 14:59:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 735BB60733;
	Sat, 23 May 2026 14:59:26 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 947E810811D8A;
	Sat, 23 May 2026 16:59:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779548365; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=72gvWxA6GzrHcWl4AIhgAHxqjCWLDguMeN9/+1KBCT4=;
	b=jhsKmrQ7GB9ZRURpAdDT1lR2Tv0nbSyVSvJslr0JzubFjQca3RJizJlcSTfP70aI/6Z6xk
	F6BBcZF7tcyclJuxUI0FELdBHXK1WDtGco6D9NF5bjbps73GB8Cz4EqJMhX5unUP3sAzw4
	mu0mIMGyMABR1DAq8FcuccfZDPoSr6JhQy/eoH2jlYMxozD8AKR5mQElHD9uUzvx3bCYfe
	IBmQ5qXY2yaZnIlNCJ/Pn09uL3yDPYsWFmt04bLvvDz67iEl9CsDT88nmkVYtlkuZheici
	fJrRe5o1eBxk5c6f7uo47gkCU6UqBBGAtmEUwNLvMmRkI2BDXJ5R6L08GZyjbQ==
Message-ID: <a82286c4-04cc-4a99-b74d-2f64ce04012b@bootlin.com>
Date: Sat, 23 May 2026 16:59:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 9/9] ethtool: cmis: validate fw->size against
 start_cmd_payload_size
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, danieller@nvidia.com,
 petrm@nvidia.com, o.rempel@pengutronix.de, idosch@nvidia.com, andrew@lunn.ch
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-10-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260522231312.1710836-10-kuba@kernel.org>
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
	TAGGED_FROM(0.00)[bounces-291119-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,lunn.ch:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim]
X-Rspamd-Queue-Id: DCD745BF7EF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/23/26 01:13, Jakub Kicinski wrote:
> cmis_fw_update_start_download() copies start_cmd_payload_size bytes
> from the firmware blob into the CDB LPL vendor_data[] payload without
> validating that the FW has enough data.
> 
> Since the start_cmd_payload_size can only be ~120B an image too short
> is most likely corrupted, so reject it.
> 
> Fixes: c4f78134d45c ("ethtool: cmis_fw_update: add a layer for supporting firmware update using CDB")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> CC: andrew@lunn.ch
> CC: danieller@nvidia.com
> CC: petrm@nvidia.com
> ---
>   net/ethtool/cmis_fw_update.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/net/ethtool/cmis_fw_update.c b/net/ethtool/cmis_fw_update.c
> index 16190c97e1f7..291d04d2776a 100644
> --- a/net/ethtool/cmis_fw_update.c
> +++ b/net/ethtool/cmis_fw_update.c
> @@ -130,6 +130,14 @@ cmis_fw_update_start_download(struct ethtool_cmis_cdb *cdb,
>   	u8 lpl_len;
>   	int err;
>   
> +	if (fw_update->fw->size < vendor_data_size) {
> +		ethnl_module_fw_flash_ntf_err(fw_update->dev,
> +					      &fw_update->ntf_params,
> +					      "Firmware image too small for module's start payload",
> +					      NULL);
> +		return -EINVAL;
> +	}
> +
>   	pl.image_size = cpu_to_be32(fw_update->fw->size);
>   	memcpy(pl.vendor_data, fw_update->fw->data, vendor_data_size);
>   


