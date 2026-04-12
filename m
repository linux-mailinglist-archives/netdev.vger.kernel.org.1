Return-Path: <netdev+bounces-277789-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGROHu2W22n1DgkAu9opvQ
	(envelope-from <netdev+bounces-277789-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:58:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 216063E3E56
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 14:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0EB03300F5E3
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 12:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597DA37755D;
	Sun, 12 Apr 2026 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9evnTpp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E182F851;
	Sun, 12 Apr 2026 12:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775998680; cv=none; b=KfPNi3m/p0s4bUQO1ijQ3IUnBxFPP7NJ79wNvINK8j/9Z//2A4Efc0tG/elR5yUI0eMhrF3y3NlMKbnkI7lODegQpyYJKS6Ey3JwEleSeIdw0L+2XctPySzCtLW0N3rfRejLKDFRwVvq+0SmVnkQNfSkAM61162Z+6el6N79OA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775998680; c=relaxed/simple;
	bh=Ee+jKZp59THUfckcsOQAbuB5rC+gguWA5jU1b9EJA0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOtNHBIBXGQqSprudKzVb3dGlf/wKX0HG2GI3djN+Bc/ErhKVO/9oPuDnVeKQM6Z3yRCNl5yw5q05loDVhLEq0/dIvydhPlI8qFy6pAvsQ0fcVJ8ru7ZoREX8afoR+shKylgOy2m9GeevxJc8Pxs4QiQWJI6GBRSUxtXIbP5GDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9evnTpp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8897EC19424;
	Sun, 12 Apr 2026 12:57:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775998680;
	bh=Ee+jKZp59THUfckcsOQAbuB5rC+gguWA5jU1b9EJA0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=V9evnTppWGRyitvjURDj7zv5hujNnjA3tHqnJTNsBacGF5GLa2gG45pXPZEefoeNt
	 2DI7v0yCqX4CXIingpTZIfwJONz0ZVYPbpOCwV9FbeHJO3jopbMMci36x6mZGlI1JC
	 a4lxU8Ls+1xbw5ulxlVUKTBaeIL7TzzuIKA8Y6EaX5eCU9FPwAc+IqlDG5Ey3qTY2K
	 RVYlj8lcVVi2NUg5kvvCQDVWTralidn2O5ubh/pBhYkRoy63mZYeNmZqi9ecz6sEUu
	 x46nDH7Z0WuIJJ+tpZBQg469zntQhNyc8UCekOM5pKWmFVSqRcQuXkV36DArSQz3/h
	 FaiYo4EiLlf7A==
From: Simon Horman <horms@kernel.org>
To: illusion.wang@nebula-matrix.com
Cc: Simon Horman <horms@kernel.org>,
	enelsonmoore@gmail.com,
	alvin.wang@nebula-matrix.com,
	linux-doc@vger.kernel.org,
	hkallweit1@gmail.com,
	edumazet@google.com,
	lukas.bulwahn@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org (open list),
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	sam.chen@nebula-matrix.com,
	corbet@lwn.net,
	vadim.fedorenko@linux.dev,
	lorenzo@kernel.org,
	dimon.zhao@nebula-matrix.com,
	skhan@linuxfoundation.org,
	andrew+netdev@lunn.ch
Subject: Re: [PATCH v11 net-next 02/11] net/nebula-matrix: add our driver architecture
Date: Sun, 12 Apr 2026 13:57:28 +0100
Message-ID: <20260412125728.662867-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408093739.56001-3-illusion.wang@nebula-matrix.com>
References: <20260408093739.56001-3-illusion.wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,nebula-matrix.com,vger.kernel.org,google.com,redhat.com,lwn.net,linux.dev,linuxfoundation.org,lunn.ch];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[19];
	TAGGED_FROM(0.00)[bounces-277789-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,nebula-matrix.com:email,illusion.wang:url]
X-Rspamd-Queue-Id: 216063E3E56
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net/nebula-matrix: add our driver architecture

This commit introduces a layered architecture for the nebula-matrix
driver, consisting of Device, Dispatch, Resource, Hardware, Channel, and
Common layers. It adds initialization and cleanup functions for each layer
with struct-based operation registration.

Signed-off-by: illusion.wang <illusion.wang@nebula-matrix.com>

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index 10c3536b327b..db035136e09c 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c

[ ... ]

> +struct nbl_adapter *nbl_core_init(struct pci_dev *pdev,
> +				  struct nbl_init_param *param)
> +{
> +	struct nbl_product_base_ops *product_base_ops;
> +	struct nbl_common_info *common;
> +	struct nbl_adapter *adapter;
> +	int ret;
> +
> +	adapter = devm_kzalloc(&pdev->dev, sizeof(*adapter), GFP_KERNEL);
> +	if (!adapter)
> +		return NULL;
> +
> +	adapter->pdev = pdev;
> +	common = &adapter->common;
> +
> +	common->pdev = pdev;
> +	common->dev = &pdev->dev;
> +	common->has_ctrl = param->caps.has_ctrl;
> +	common->has_net = param->caps.has_net;
> +	common->pci_using_dac = param->pci_using_dac;
> +	common->function = PCI_FUNC(pdev->devfn);
> +	common->devid = PCI_SLOT(pdev->devfn);
> +	common->bus = pdev->bus->number;
> +	common->product_type = param->product_type;
> +
> +	product_base_ops = nbl_core_setup_product_ops(adapter, param);
> +
> +	/*
> +	 *every product's hw/chan/res layer has a great difference,
> +	 *so call their own init ops
> +	 */
> +	ret = product_base_ops->hw_init(adapter);
> +	if (ret)
> +		goto hw_init_fail;
> +
> +	ret = product_base_ops->chan_init(adapter);
> +	if (ret)
> +		goto chan_init_fail;
> +
> +	ret = product_base_ops->res_init(adapter);
> +	if (ret)
> +		goto res_init_fail;
> +
> +	ret = nbl_disp_init(adapter);
> +	if (ret)
> +		goto res_init_fail;
> +
> +	ret = nbl_dev_init(adapter);
> +	if (ret)
> +		goto res_init_fail;

Does the error path correctly clean up all initialized layers?

The initialization order is:
  1. hw_init
  2. chan_init
  3. res_init
  4. nbl_disp_init
  5. nbl_dev_init

When nbl_disp_init() or nbl_dev_init() fails, control jumps to the
'res_init_fail' label, which only tears down the channel and hardware
layers:

> +res_init_fail:
> +	product_base_ops->chan_remove(adapter);
> +chan_init_fail:
> +	product_base_ops->hw_remove(adapter);

However, res_init has already succeeded at this point and is never cleaned
up. Looking at nbl_product_base_ops, there is no res_remove callback
defined, and nbl_core_remove() also shows the same asymmetry:

> +void nbl_core_remove(struct nbl_adapter *adapter)
> +{
> +	struct nbl_product_base_ops *product_base_ops;
> +
> +	product_base_ops = adapter->product_base_ops;
> +	nbl_dev_remove(adapter);
> +	product_base_ops->chan_remove(adapter);
> +	product_base_ops->hw_remove(adapter);
> +}

This function calls nbl_dev_remove(), chan_remove(), and hw_remove(), but
never tears down the resource layer or the dispatch layer.

Currently, all allocations in res_init (nbl_res_init_leonis) and
nbl_disp_init use devm_kzalloc, so resources are auto-freed.  However, the
error path structure is concretely wrong: if res_init or disp_init ever
needs non-devm resources (as nbl_hw_init_leonis already uses ioremap and
pci_request_selected_regions), the missing cleanup will cause resource
leaks.

Should the init/remove paths be symmetric, with every successful init
having a corresponding remove in both the error cleanup path and
nbl_core_remove()?

