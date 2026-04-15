Return-Path: <netdev+bounces-278792-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EMVQESif32kEWwAAu9opvQ
	(envelope-from <netdev+bounces-278792-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:22:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A327440539D
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:22:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5F0F33081D01
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:19:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28DE63D34BB;
	Wed, 15 Apr 2026 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="PFIukb78"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2C524A06D
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262769; cv=none; b=XWOoGaKl3Wggs24JmoCXas8PqFLcI8Jyc2O6vGraDcI45qTc7TLguZ/IWCXUFO3RzJ8xX1oZESoeiJnkzOcB8Sx4cl5nlI76Phgylk009LMKe3e4lM0Wv+jRaoV414lMjudG2+j4GChNdXlJN/6jjfKiL6429s9VmRoRrJev5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262769; c=relaxed/simple;
	bh=A9/HJmOJ69OSwvl2pHbLs4KBA7n2j2nuNmKQfY0oRsk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eh9+1mtfTVUc+8Anm0Ck2A+QAIfaKvChgHYGEcoCr8qV3TQZ4AY5oa5GWbr8WAPX9iBKvMvuDc1xWOyLuwTrHJhUfQ0fRFWNGmWTxp6ze+vCvw0vFRSbP8RgX0GVTClQ6thkWcSIZ+PuBuIhdjEFnpntbWMiQjYQWV0xDPPTMqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=PFIukb78; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+EE8QyuRSmRcMm7llKJ9cfCpHASsFH3SVkHhUH7aEV4=; b=PFIukb78PhHO6VKbeeF55eY5M8
	98haQWTnDZ6SvnB8qG+jtQEU07LPsNuI/6v+mavktPeX7QNEcZTSc4Ptb2TvNtUQlSx2vumI3+Xyo
	wrd7gtrWnlSSKWeJE33DqcJYZdcYw1FYgPqNWMUUAMmW7JXgTQMUghcp8zqYYvDqx01s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wD15R-00GB9b-HF; Wed, 15 Apr 2026 16:19:25 +0200
Date: Wed, 15 Apr 2026 16:19:25 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Junyang Han <han.junyang@zte.com.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ran.ming@zte.com.cn, han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next 2/3] net/ethernet/zte/dinghai: add logging
 infrastructure
Message-ID: <fe3501da-13a7-461d-bba7-790618f067e1@lunn.ch>
References: <20260415015334.2018453-1-han.junyang@zte.com.cn>
 <20260415015334.2018453-2-han.junyang@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415015334.2018453-2-han.junyang@zte.com.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278792-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:dkim,lunn.ch:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A327440539D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> +#define dh_dbg(__dev, format, ...)                    \
> +    dev_dbg((__dev)->device, "%s:%d:(pid %d): " format,        \
> +         __func__, __LINE__, current->pid,            \
> +         ##__VA_ARGS__)
> +
> +#define dh_dbg_once(__dev, format, ...)                \
> +    dev_dbg_once((__dev)->device,                \
> +             "%s:%d:(pid %d): " format,            \
> +             __func__, __LINE__, current->pid,        \
> +             ##__VA_ARGS__)

There is a dislike for adding wrappers around the existing kernel log
functions. What value does this add?

> +int debug_print;
> +module_param(debug_print, int, 0644);

Module parameters are not liked.

> +module_param_named(debug_mask, dh_debug_mask, uint, 0644);
> +MODULE_PARM_DESC(debug_mask, "debug mask: 1 = dump cmd data, 2 =
>  dump cmd exec time, 3 = both. Default=0");
> +static bool probe_vf = 1;
> +module_param(probe_vf, bool, 0644);
> +MODULE_PARM_DESC(probe_vf, "probe_vf: 0 = N, 1 = Y");

I suggest you remove all these.

Debug code is reasonable to have during development. But once the
driver actually works, it should not be needed.

>  const struct pci_device_id dh_pf_pci_table[] = {
> @@ -39,26 +47,34 @@ static int dh_pf_pci_init(struct dh_core_dev *dev)
>      pci_set_drvdata(dev->pdev, dev);
>  
>      ret = pci_enable_device(dev->pdev);
> -    if (ret)
> +    if (ret) {
> +        LOG_ERR("pci_enable_device failed: %d\n", ret);

dev_err(dev, ..)

>          return -ENOMEM;
> +    }
>  
>      ret = dma_set_mask_and_coherent(dev->device, DMA_BIT_MASK(64));
>      if (ret) {
>          ret = dma_set_mask_and_coherent(dev->device, DMA_BIT_MASK(32));
> -        if (ret)
> +        if (ret) {
> +            LOG_ERR("dma_set_mask_and_coherent failed: %d\n", ret);

dev_err(dev, ...

And maybe it should actually be dev_err_probe() if this is a probe
function, and you need to handle -EPROBE_DEFER.

Debug logging should be limited to actual debug stuff. Please use the
standard logging primitives for anything which is not debug, so
dev_err(), dev_warn(), dev_info(). netdev_err(), netdev_warn() etc.

	Andrew

