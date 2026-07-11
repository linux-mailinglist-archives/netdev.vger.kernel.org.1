Return-Path: <netdev+bounces-306884-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yykCNXRtUmrFPgMAu9opvQ
	(envelope-from <netdev+bounces-306884-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 18:21:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 285C474227D
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 18:21:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ehevbJDq;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306884-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306884-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE43E301113B
	for <lists+netdev@lfdr.de>; Sat, 11 Jul 2026 16:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555972BE621;
	Sat, 11 Jul 2026 16:21:06 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1B1D7E41;
	Sat, 11 Jul 2026 16:21:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783786866; cv=none; b=IjDfl/BWd7VInKmWyGka5esD2Qk8PN0lGcLfPEYCX54wGIVDVJd6MHFTqY1GdMWPbiE1gPFc2aqt+sPX9y7IOSjaY7B3ZNcfjpUVzW8eB4+bpr4JkwBilkpHO3ef4dagRjPedYYs4ehuVjtLC4aybuWjcGvHyqdxM8QZJ8RqJlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783786866; c=relaxed/simple;
	bh=ptqNvbnjadKO/it9/uNI/Q1LaVWpPh0kSaWonlaf0IY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T/vlclP0QegBsI75yacuxbtLKSeRUdsbVB2JJPQHrfl8wQJ26RZ0mOYMhVh0tAPuAJ6bCIMXr0auY63m684DCimDoaqnGUdtexxRKMEaOw1VSFyPXok75jitiP40ScCxFj291b0zE7xGisxQ1nqDL1S9LxVwQVTXzu1TOY4vBBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ehevbJDq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C681F000E9;
	Sat, 11 Jul 2026 16:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783786865;
	bh=TpNp4fC/CFDZGuIDC1qx/7A45V515bUjmbTcUWbRRoU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ehevbJDqsI/hGy0w+X7dKucmrlrIy7JW6/dL8xX85mak5tnIHpnUPxzsPA6cKJt+g
	 Z4WRkgHtSQzrjIbVPyVV1MhiBwgo4WAvEedsZvaDDKaKALdd8xhllYAObBx0zfoppS
	 i7yHVKhjazkZjX8bKxmV2ZPKIT4gOO5vul6UDz8RytERDWyl2QK+KJN8OHE81pa9Vj
	 kd/dXOBZx2Nsp8Wr2HjBWeJi9jWWb3iOfEsSClCcXWV43wpigcDlKVswjn0gLH2R+g
	 2jM6ZpajQ+qO11fpdAXUay8BRXBu3UK+ahDeObdQC+c02kR6Ulbzu/fstxkSu/oOCH
	 kwl/1t7pJ0XzA==
Date: Sat, 11 Jul 2026 17:21:00 +0100
From: Simon Horman <horms@kernel.org>
To: Pengpeng Hou <pengpeng@iscas.ac.cn>
Cc: Cai Huoqing <cai.huoqing@linux.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hinic: validate firmware image section bounds
Message-ID: <20260711162100.GB1364329@horms.kernel.org>
References: <20260706093455.81168-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706093455.81168-1-pengpeng@iscas.ac.cn>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-306884-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:pengpeng@iscas.ac.cn,m:cai.huoqing@linux.dev,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,iscas.ac.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 285C474227D

On Mon, Jul 06, 2026 at 05:34:55PM +0800, Pengpeng Hou wrote:
> The firmware update path copies each section from the image with an offset
> and length supplied by the firmware header. The image validator only
> checked the sum of section lengths and used fw_len + header_size to check
> the file size, but it did not prove that each section offset and length
> fits in the firmware payload.
> 
> Reject images with a truncated header, avoid the fw_len plus header-size
> addition, validate each section type before it is used as a bit index, and
> prove every section range with offset <= fw_len and len <= fw_len - offset.
> 
> Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
> ---
>  .../net/ethernet/huawei/hinic/hinic_devlink.c | 57 ++++++++++++++++---
>  1 file changed, 49 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
> index c977c43e5d5a..0c06fbdadad3 100644
> --- a/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
> +++ b/drivers/net/ethernet/huawei/hinic/hinic_devlink.c
> @@ -20,14 +20,25 @@
>  #include "hinic_devlink.h"
>  #include "hinic_hw_dev.h"
>  
> +static bool hinic_fw_section_valid(u32 fw_len, u32 offset, u32 len)
> +{
> +	return offset <= fw_len && len <= fw_len - offset;
> +}
> +
>  static bool check_image_valid(struct hinic_devlink_priv *priv, const u8 *buf,
> -			      u32 image_size, struct host_image_st *host_image)
> +			      size_t image_size, struct host_image_st *host_image)
>  {
> -	struct fw_image_st *fw_image = NULL;
> +	const struct fw_image_st *fw_image;

I don't think the const update is strictly related to this patch,
and thus doesn't belong in this patch.

>  	u32 len = 0;
>  	u32 i;
>  
> -	fw_image = (struct fw_image_st *)buf;
> +	if (image_size < UPDATEFW_IMAGE_HEAD_SIZE) {
> +		dev_err(&priv->hwdev->hwif->pdev->dev,
> +			"Wrong image size read from file\n");
> +		return false;
> +	}
> +
> +	fw_image = (const struct fw_image_st *)buf;
>  
>  	if (fw_image->fw_magic != HINIC_MAGIC_NUM) {
>  		dev_err(&priv->hwdev->hwif->pdev->dev, "Wrong fw_magic read from file, fw_magic: 0x%x\n",
> @@ -41,14 +52,44 @@ static bool check_image_valid(struct hinic_devlink_priv *priv, const u8 *buf,
>  		return false;
>  	}
>  
> +	if (fw_image->fw_len != image_size - UPDATEFW_IMAGE_HEAD_SIZE) {
> +		dev_err(&priv->hwdev->hwif->pdev->dev,
> +			"Wrong data size read from file\n");
> +		return false;
> +	}
> +
>  	for (i = 0; i < fw_image->fw_info.fw_section_cnt; i++) {
> -		len += fw_image->fw_section_info[i].fw_section_len;
> -		host_image->image_section_info[i] = fw_image->fw_section_info[i];
> +		const struct fw_section_info_st *section =
> +			&fw_image->fw_section_info[i];
> +
> +		if (section->fw_section_type >= FILE_TYPE_TOTAL_NUM) {
> +			dev_err(&priv->hwdev->hwif->pdev->dev,
> +				"Wrong section type read from file: %u\n",
> +				section->fw_section_type);
> +			return false;
> +		}
> +
> +		if (!hinic_fw_section_valid(fw_image->fw_len,
> +					    section->fw_section_offset,
> +					    section->fw_section_len)) {
> +			dev_err(&priv->hwdev->hwif->pdev->dev,
> +				"Wrong section size read from file\n");
> +			return false;
> +		}
> +
> +		if (section->fw_section_len > fw_image->fw_len - len) {
> +			dev_err(&priv->hwdev->hwif->pdev->dev,
> +				"Wrong data size read from file\n");
> +			return false;
> +		}
> +
> +		len += section->fw_section_len;
> +		host_image->image_section_info[i] = *section;
>  	}
>  
> -	if (len != fw_image->fw_len ||
> -	    (fw_image->fw_len + UPDATEFW_IMAGE_HEAD_SIZE) != image_size) {
> -		dev_err(&priv->hwdev->hwif->pdev->dev, "Wrong data size read from file\n");
> +	if (len != fw_image->fw_len) {
> +		dev_err(&priv->hwdev->hwif->pdev->dev,
> +			"Wrong data size read from file\n");

Likewise, the update to the dev_err() call, as distinct from the update
to the condition that precedes it, appears to be a whitespace cleanup.
If so, it doesn't belong in this patch.

>  		return false;
>  	}
>  

-- 
pw-bot: changes-requested

