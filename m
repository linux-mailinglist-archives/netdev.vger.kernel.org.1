Return-Path: <netdev+bounces-291112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLw/BQK8EWo5pQYAu9opvQ
	(envelope-from <netdev+bounces-291112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:38:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F9E5BF6DD
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 16:38:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BC32B30156CC
	for <lists+netdev@lfdr.de>; Sat, 23 May 2026 14:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD5A2D94A0;
	Sat, 23 May 2026 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QWgADDgv"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8402DA76C
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 14:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779547126; cv=none; b=LspgpR7lRj9rYb4T3435WyoaTpd008EWrb7zPoSZuLSdT/g5Cj2qv3RpbPNFzpdIPWV8Svk6iV5HJFrk+890cD8P+cTaJWPL/WAN0Bm265n3XUATJ/S9pEJy4uh+MPKcf8as8sa7LwNCcTGSx1UMPLs9sueXDI4k+slMFdQBB48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779547126; c=relaxed/simple;
	bh=tRrvJBKOEBkdccRzhAjYgkildSCpKTIRySaJUR81nlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PofyGtW/7P4JExRJDLNyLzVtW6A9xOvxpLQcm9vKg6aRNtShMk0/qQhE4wDfMIAQTA5nBm0YRiR6bT+KuIrRH95H6k++AG6+gFgZvxWFZg0uo+CrEWpH8UsqM6+dxAk4jyQLHUYciuGPC1G8xDFhSLKe33GzZsfKDX24deALKSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QWgADDgv; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E69B6C2C663;
	Sat, 23 May 2026 14:39:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BAC9060733;
	Sat, 23 May 2026 14:38:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 2A15010811D8A;
	Sat, 23 May 2026 16:38:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1779547120; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ddFRcA+O9W2Uto6DriotJyHR7FQDKv1K4PA8XhsjtVk=;
	b=QWgADDgv4Gv/1hP9IpotoA/W7we728U+dt1fCbE9vbNcV2V66FaGKY/6v0F3LfTFapFPJl
	dmrdmOA11A4KpEWdWbh8pddqsXciYSCeHYOEP71/FVwVfpGwl7hS0c8sIRqe81/g3PFzob
	bev6Suvc+bJRfIhzKG9wWvvQY/I4R0jHbBl7pleHpuXm7qLTv3ElBSlwPiaeCyLCTal0tt
	aGk5C5LLcoxLljBaLACO5jw3/yJBc64TuUcGsaS1ecMQYeZT7UgaY+zClCPdnSfGPC0cks
	kZRkpoPt+i/xmlmVr5OUwXTaVN37BDfbSU8xsV+m1TZYV1BrIHlZ9T4mDwQdVg==
Message-ID: <1736d16f-ee77-44b2-94a0-33b8f14c4885@bootlin.com>
Date: Sat, 23 May 2026 16:38:37 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/9] ethtool: module: avoid racy updates to
 dev->ethtool bitfield
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, danieller@nvidia.com,
 petrm@nvidia.com, o.rempel@pengutronix.de, idosch@nvidia.com, andrew@lunn.ch
References: <20260522231312.1710836-1-kuba@kernel.org>
 <20260522231312.1710836-4-kuba@kernel.org>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260522231312.1710836-4-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291112-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[bootlin.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,bootlin.com:email,bootlin.com:mid,bootlin.com:dkim,lunn.ch:email,nvidia.com:email]
X-Rspamd-Queue-Id: 84F9E5BF6DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi,

On 5/23/26 01:13, Jakub Kicinski wrote:
> When reviewing other changes Gemini points out that we currently
> update module_fw_flash_in_progress without holding any locks.
> Since module_fw_flash_in_progress is part of a bitfield this
> is not great, updates to other fields may be lost.
> 
> We could use a bool and sprinkle some READ_ONCE/WRITE_ONCE here
> but seems like the issue is rather than the work is an unusual
> writer. The other writers already hold the right locks. So just
> very briefly take these locks when the work completes.
> 
> Note that nothing ever cancels the FW update work, so there's
> no concern with deadlocks vs cancel.
> 
> Fixes: 32b4c8b53ee7 ("ethtool: Add ability to flash transceiver modules' firmware")
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> CC: andrew@lunn.ch
> CC: petrm@nvidia.com
> CC: danieller@nvidia.com
> ---
>   net/ethtool/module.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ethtool/module.c b/net/ethtool/module.c
> index 392c03935e5e..cdb85e19a23b 100644
> --- a/net/ethtool/module.c
> +++ b/net/ethtool/module.c
> @@ -221,14 +221,22 @@ static void module_flash_fw_work_list_del(struct list_head *list)
>   static void module_flash_fw_work(struct work_struct *work)
>   {
>   	struct ethtool_module_fw_flash *module_fw;
> +	struct net_device *dev;
>   
>   	module_fw = container_of(work, struct ethtool_module_fw_flash, work);
> +	dev = module_fw->fw_update.dev;
>   
>   	ethtool_cmis_fw_update(&module_fw->fw_update);
>   
>   	module_flash_fw_work_list_del(&module_fw->list);
> -	module_fw->fw_update.dev->ethtool->module_fw_flash_in_progress = false;
> -	netdev_put(module_fw->fw_update.dev, &module_fw->dev_tracker);
> +
> +	rtnl_lock();
> +	netdev_lock_ops(dev);
> +	dev->ethtool->module_fw_flash_in_progress = false;
> +	netdev_unlock_ops(dev);
> +	rtnl_unlock();
> +
> +	netdev_put(dev, &module_fw->dev_tracker);
>   	release_firmware(module_fw->fw_update.fw);
>   	kfree(module_fw);
>   }


