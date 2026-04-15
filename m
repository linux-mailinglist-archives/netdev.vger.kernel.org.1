Return-Path: <netdev+bounces-278788-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2MEQMlWd32kEWwAAu9opvQ
	(envelope-from <netdev+bounces-278788-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:14:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 219A8405302
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 16:14:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EE0B303467A
	for <lists+netdev@lfdr.de>; Wed, 15 Apr 2026 14:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D86563CAE68;
	Wed, 15 Apr 2026 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rG6ak423"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0A23B2FFF
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 14:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776262265; cv=none; b=jM4X7v8b0HlHN/FkrKdS8Wb7BdLiiDr8mtfUeitBGOcFVygQOZ+kLecdOPhHrvCpvahoHcsKkjsPOZZtNRqc1D+TLaLy6yhtX7SAmYEML/LpNC03d7lqjdMa2y3Q9NG+NeP9Qek7NTNtAgx/y5GEdeYoP6plGc0g7QDP0vE9JJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776262265; c=relaxed/simple;
	bh=dpNeQ/TZ4v1JJrvvtGriqAAFjmhLydaQoUtYG18Wc28=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dlvh55dWPguv3iEFZWCRJAdRalvAUpaaEGAqCUx1lI7hFcmQCuYa1XVereECr0+PKq3oo1h0Hxj0wmd3FeRZ76CBCHRKckj1drNpL1Amy0BjaLtxc/VRcbZkukVtz1r1W7TJlXLMn7YOlRcze/02Xvou4GYfc/KfsQYiIFbjxxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rG6ak423; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+/LZqKR+uWHCsrNRniyAouEniFyPlNCQMgEazTxDHns=; b=rG6ak423QutmjSzjUrB0bms13f
	2aEidTwq1gaK0EZ1HNglPQftLS5Kl0NS4teSYtu65RGZW6GzObvW6OsLQRfYew4bCVPBS1EDV4PHr
	3vcm/oFevLzcOzhddUnhEOE3uB5tkIxTKbMb6XH+bMYWZPsM42MdlZrY47/o2eYHC7Y0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wD0xD-00GB5X-UG; Wed, 15 Apr 2026 16:10:55 +0200
Date: Wed, 15 Apr 2026 16:10:55 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Junyang Han <han.junyang@zte.com.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	ran.ming@zte.com.cn, han.chengfei@zte.com.cn,
	zhang.yanze@zte.com.cn
Subject: Re: [PATCH net-next 1/3] net/ethernet: add ZTE network driver support
Message-ID: <7cadad17-f3e7-45c7-9a3c-505f0bd9351c@lunn.ch>
References: <20260415015334.2018453-1-han.junyang@zte.com.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415015334.2018453-1-han.junyang@zte.com.cn>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-278788-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: 219A8405302
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 15, 2026 at 09:53:32AM +0800, Junyang Han wrote:
> Add basic framework for ZTE DingHai ethernet PF driver, including
> Kconfig/Makefile build support and PCIe device probe/remove skeleton.

Please take a read on

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

and

https://docs.kernel.org/process/submitting-patches.html

Please always include a patch 0/X in a patch set, explaining the big
picture.

Thanks for keeping the driver small and easy to review.

> + * ZTE DingHai Ethernet driver
> + * Copyright (c) 2022-2024, ZTE Corporation.

And the last two years?

> +#define DRV_VERSION "1.0-1"

Driver versions are generally useless. What does this actually mean
for the given very limited driver? Are you going to change the version
with each patchset?

> +#define DRV_SUMMARY "ZTE(R) zxdh-net driver"
> +
> +const char zxdh_pf_driver_version[] = DRV_VERSION;
> +static const char zxdh_pf_driver_string[] = DRV_SUMMARY;
> +static const char zxdh_pf_copyright[] = "Copyright (c)
>  2022-2024, ZTE Corporation.";

You don't need this, you have the copyright above.

> +MODULE_AUTHOR("ZTE");

Author is a person, with an email address.

> +MODULE_DESCRIPTION(DRV_SUMMARY);

Please just put the string here, not #define.

> +MODULE_VERSION(DRV_VERSION);
> +MODULE_LICENSE("GPL");
> +static int dh_pf_pci_init(struct dh_core_dev *dev)
> +{
> +    int ret = 0;
> +    struct zxdh_pf_device *pf_dev = NULL;

Reverse Christmas tree. This applies everywhere for a netdev driver.

> +static int dh_pf_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{

> +err_cfg_init:
> +    mutex_destroy(&pf_dev->irq_lock);
> +    mutex_destroy(&dh_dev->lock);
> +    devlink_free(devlink);
> +    pf_dev = NULL;

Since this is a probe function, do you really need to set pf_dev to
NULL? How is it going to keep a value over EPROBE_DEFER cycles?

> +static void dh_pf_remove(struct pci_dev *pdev)
> +{
> +    struct dh_core_dev *dh_dev = pci_get_drvdata(pdev);
> +    struct devlink *devlink = priv_to_devlink(dh_dev);
> +    struct zxdh_pf_device *pf_dev = dh_core_priv(dh_dev);
> +
> +    if (!dh_dev)
> +        return;

How does that happen?

> +    dh_pf_pci_close(dh_dev);
> +    mutex_destroy(&pf_dev->irq_lock);
> +    mutex_destroy(&dh_dev->lock);
> +    devlink_free(devlink);
> +    pci_set_drvdata(pdev, NULL);
> +}

> +static int dh_pf_suspend(struct pci_dev *pdev, pm_message_t state)
> +{
> +    return 0;
> +}
> +
> +static int dh_pf_resume(struct pci_dev *pdev)
> +{
> +    return 0;
> +}

If they do nothing, don't provide them. You can add them when you add
suspend/resume support.

> +static int __init dh_pf_pci_init_module(void)
> +{
> +    return pci_register_driver(&dh_pf_driver);
> +}
> +
> +static void __exit dh_pf_pci_exit_module(void)
> +{
> +    pci_unregister_driver(&dh_pf_driver);
> +}
> +
> +module_init(dh_pf_pci_init_module);
> +module_exit(dh_pf_pci_exit_module);

The PCI subsystem offers a wrapper to do this.

> +struct dh_core_dev {
> +    struct device *device;
> +    enum dh_coredev_type coredev_type;
> +    struct pci_dev *pdev;
> +    struct devlink *devlink;
> +    struct mutex lock; /* Protects device configuration */
> +    char priv[] __aligned(32);

That is unusual. priv is usually a void * and allocated. If you want
an actual array, you might want to have a second member indicate the
size of the array, look at all the work done recently on flexible
arrays.
	
    Andrew

---
pw-bot: cr

