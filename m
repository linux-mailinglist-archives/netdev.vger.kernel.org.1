Return-Path: <netdev+bounces-255270-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iAhWLZw/fWmoRAIAu9opvQ
	(envelope-from <netdev+bounces-255270-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 00:32:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1945ABF617
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 00:32:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C926B300AB1E
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 23:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D698378829;
	Fri, 30 Jan 2026 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I0kgEyb9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562D4376BD9
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 23:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769815961; cv=none; b=ct2ZcYvOL5pBm7D+4LY6KajO39HBAJO9+IZORV4ZLBtqKiRb78IW/5fYn2hAswg15RNBQhy4Jh6173KAquIuIkS8fkjzXXgqvskPoYF+STdZtJuYmcbkCS6/cVlrzsjbeKIClPlmfUd96m/dV2XV+RZbymZx//JbkWSo1CeJ+Ek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769815961; c=relaxed/simple;
	bh=UMLue4W8ZNYefF9L/wUPKA6mcmOaNbBOTPer8fN6xNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYxwuV1gvSyxl0bQC3a/soAnlgqFQfwvv748hbARVocWTnCRA+BZnlh9D4masft7VbjHRqfApXA8hkvna+G0a0ra2RLpvsFB4fEGc2pHsoYRETfx8jbKa2eGbsorsETRTizYRLXqCjKV+VYFe+bt0su0KK73wo2+B25+m8WESo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I0kgEyb9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476F1C4CEF7;
	Fri, 30 Jan 2026 23:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769815961;
	bh=UMLue4W8ZNYefF9L/wUPKA6mcmOaNbBOTPer8fN6xNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=I0kgEyb9jL91RfoG+AVAsqvm2vBnWYgcKB6CgHteYPNXhRuOFkiKR3V/hgki98O5C
	 ZLPPP8zUww9dPjfa9HqcAsb6H6HjTRWG/wuxGIhCoyy42hcE18pGbGF+G39CAkxZGQ
	 tAYPhApzxiNWswu2K39HlPUxhk0Ynm6hm+ZzPuLjj8YjHSkAxDQ1bzgkHHmja7YkjT
	 0c9ll/0k0arOO0CM/phhCfeRrzjXPL9QoFLdQvyEKU/KMiphCXmXgf2xy4VJiLpTO6
	 ntbE+JksK8xhRiqQHVXiXNm5sK09JXBMdK14WepvHaGsFDF401k9RjGh/jx/Oaokv/
	 fqtLOtCYK+H7Q==
From: Jakub Kicinski <kuba@kernel.org>
To: xuanzhuo@linux.alibaba.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	lorenzo@kernel.org,
	andrew+netdev@lunn.ch,
	hkallweit1@gmail.com,
	dust.li@linux.alibaba.com,
	edumazet@google.com,
	davem@davemloft.net,
	pabeni@redhat.com,
	lulie@linux.alibaba.com,
	andrew@lunn.ch,
	netdev@vger.kernel.org,
	guwen@linux.alibaba.com,
	dong100@mucse.com,
	lukas.bulwahn@redhat.com,
	vadim.fedorenko@linux.dev,
	enelsonmoore@gmail.com
Subject: Re: [net-next,v24,1/6] eea: introduce PCI framework
Date: Fri, 30 Jan 2026 15:32:38 -0800
Message-ID: <20260130233238.923339-1-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130093412.98407-2-xuanzhuo@linux.alibaba.com>
References: <20260130093412.98407-2-xuanzhuo@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,gmail.com,linux.alibaba.com,google.com,davemloft.net,redhat.com,vger.kernel.org,mucse.com,linux.dev];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[17];
	TAGGED_FROM(0.00)[bounces-255270-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 1945ABF617
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
eea: introduce PCI framework

Add basic driver framework for the Alibaba Elastic Ethernet Adapter(EEA).
This commit implements the EEA PCI probe functionality.

> diff --git a/drivers/net/ethernet/alibaba/Kconfig b/drivers/net/ethernet/alibaba/Kconfig
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/Kconfig
> @@ -0,0 +1,28 @@
> +#
> +# Alibaba network device configuration
> +#
> +
> +config NET_VENDOR_ALIBABA
> +	bool "Alibaba Devices"
> +	default y
> +	help
> +	  If you have a network (Ethernet) device belonging to this class, say Y.
> +
> +	  Note that the answer to this question doesn't directly affect the
> +	  kernel: saying N will just cause the configurator to skip all
> +	  the questions about Alibaba devices. If you say Y, you will be asked
> +	  for your specific device in the following questions.
> +
> +if NET_VENDOR_ALIBABA
> +
> +config EEA
> +	tristate "Alibaba Elastic Ethernet Adapter support"
> +	depends on PCI_MSI
> +	depends on 64BIT
> +	select PAGE_POOL
> +	help
> +	  This driver supports Alibaba Elastic Ethernet Adapter"
                                                                 ^
This isn't a bug, but the help text ends with an unmatched trailing quote.
This should likely be a period instead.

[ ... ]

> diff --git a/drivers/net/ethernet/alibaba/eea/eea_pci.c b/drivers/net/ethernet/alibaba/eea/eea_pci.c
> --- /dev/null
> +++ b/drivers/net/ethernet/alibaba/eea/eea_pci.c

[ ... ]

> +static int eea_init_device(struct eea_device *edev)
> +{
> +	int err;
> +
> +	err = eea_device_reset(edev);
> +	if (err)
> +		return err;
> +
> +	eea_pci_io_set_status(edev, BIT(0) | BIT(1));
> +
> +	err = eea_negotiate(edev);
> +	if (err)
> +		goto err;
> +
> +	/* do net device probe ... */
> +
> +	return 0;
> +err:
> +	eea_add_status(edev, EEA_S_FAILED);
> +	return err;
> +}
> +
> +static int __eea_pci_probe(struct pci_dev *pci_dev,
> +			   struct eea_pci_device *ep_dev)
> +{
> +	int err;
> +
> +	pci_set_drvdata(pci_dev, ep_dev);
> +
> +	err = eea_pci_setup(pci_dev, ep_dev);
> +	if (err)
> +		return err;
> +
> +	err = eea_init_device(&ep_dev->edev);
> +	if (err)
> +		goto err_pci_rel;

If eea_init_device() fails here, can this create a use-after-free issue?

The function sets pci_set_drvdata() at the beginning, then if
eea_init_device() fails, the error path jumps to err_pci_rel which
calls eea_pci_release_resource() but doesn't clear the driver data.
Control then returns to eea_pci_probe():

eea_pci_probe()->__eea_pci_probe():
    pci_set_drvdata(pci_dev, ep_dev);     // sets driver data
    err = eea_init_device(&ep_dev->edev);
    if (err)
        goto err_pci_rel;                 // jumps on failure

err_pci_rel:
    eea_pci_release_resource(ep_dev);     // doesn't clear driver data
    return err;                           // returns to eea_pci_probe

Back in eea_pci_probe:
    err = __eea_pci_probe(pci_dev, ep_dev);
    if (err)
        kfree(ep_dev);                    // frees memory, driver data
                                          // still points to freed memory

Would it make sense to either move pci_set_drvdata() after successful
initialization, or add pci_set_drvdata(pci_dev, NULL) in the error path?

> +
> +	return 0;
> +
> +err_pci_rel:
> +	eea_pci_release_resource(ep_dev);
> +	return err;
> +}

[ ... ]

> +static int eea_pci_probe(struct pci_dev *pci_dev,
> +			 const struct pci_device_id *id)
> +{
> +	struct eea_pci_device *ep_dev;
> +	struct eea_device *edev;
> +	int err;
> +
> +	ep_dev = kzalloc(sizeof(*ep_dev), GFP_KERNEL);
> +	if (!ep_dev)
> +		return -ENOMEM;
> +
> +	edev = &ep_dev->edev;
> +
> +	edev->ep_dev = ep_dev;
> +	edev->dma_dev = &pci_dev->dev;
> +
> +	ep_dev->pci_dev = pci_dev;
> +
> +	err = __eea_pci_probe(pci_dev, ep_dev);
> +	if (err)
> +		kfree(ep_dev);
> +
> +	return err;
> +}
-- 
pw-bot: cr

