Return-Path: <netdev+bounces-183648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C26DA91688
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 10:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 966F63AABD1
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 08:35:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EECF2185BE;
	Thu, 17 Apr 2025 08:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6TjEa+W"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24E9184E;
	Thu, 17 Apr 2025 08:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744878965; cv=none; b=ZAL1jLp/q4XBdmsdQeC2774+R8VFfc0baWAjU3EZbWiwJSuNWqv1KiXWFWGLmjoTPr0wkVZ8ZGMfNLnOmC0me7bRewto5sMpr5SI0of9jhhDceyZmB23JxPDivY/8shpg3zsTqYxE6Z67TdNF8c9AZshgClMCgRZ5ME6NiuEYNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744878965; c=relaxed/simple;
	bh=s2y/8+X4byijBsMJhdGFgV9G5Ctuj92CsBaLWWFN71A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nzIfb3xO+otfsUskv6XfI9Vdck1oHopiuZA68i9QDUSs2a8ev3Lpg4GqQhIw/WRd+SvVIEU2IVi0TxW4X5plkSlQ/IzC2x3WtGuU/u68SkTDzU239DQoYPEJocS7qzyR/i5gACrA07rphD9YyX6S8oXTFpNDINnzJKpwa7ihbXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6TjEa+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E264C4CEE4;
	Thu, 17 Apr 2025 08:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744878964;
	bh=s2y/8+X4byijBsMJhdGFgV9G5Ctuj92CsBaLWWFN71A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O6TjEa+WFy2S09KaAMFKRDF6Z5a4jwkvLna42rnYi2b3nD1w+j9N53hy48xnuq1Iv
	 x9pegG6ClmcDBD8lmw3+lUv3JaHQcy6V++AF4VyfZL/YKKCxTa/IrIeDkxseklmwVZ
	 m9JCcTTZQz30DwkqGOiI5aoT1a3frAKU3tFJc8WiHj5GTcuYyptBMm7IgXJvpyRJvT
	 /FLzieSpDgmTZv4HzEo5ZlXzHeQKu/fZilcvxkf5eTpCWAsJZvKaU9Rh/AjowKGhMt
	 nMRJBqD1BoIK9mPsLoX7kHE4ljb/K57LzNG9NcAzl6yJDJibRwTvXcKUnc20a03c2V
	 Uv8KhFHsvLkGA==
Date: Thu, 17 Apr 2025 09:35:59 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, upstream@airoha.com,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-kernel@vger.kernel.org,
	Kory Maincent <kory.maincent@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: Re: [net-next PATCH v3 03/11] net: pcs: Add subsystem
Message-ID: <20250417083559.GA2430521@horms.kernel.org>
References: <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-4-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250415193323.2794214-4-sean.anderson@linux.dev>

On Tue, Apr 15, 2025 at 03:33:15PM -0400, Sean Anderson wrote:
> This adds support for getting PCS devices from the device tree. PCS
> drivers must first register with phylink_register_pcs. After that, MAC
> drivers may look up their PCS using phylink_get_pcs.
> 
> We wrap registered PCSs in another PCS. This wrapper PCS is refcounted
> and can outlive the wrapped PCS (such as if the wrapped PCS's driver is
> unbound). The wrapper forwards all PCS callbacks to the wrapped PCS,
> first checking to make sure the wrapped PCS still exists. This design
> was inspired by Bartosz Golaszewski's talk at LPC [1].
> 
> pcs_get_by_fwnode_compat is a bit hairy, but it's necessary for
> compatibility with existing drivers, which often attach to (devicetree)
> nodes directly. We use the devicetree changeset system instead of
> adding a (secondary) software node because mdio_bus_match calls
> of_driver_match_device to match devices, and that function only works on
> devicetree nodes.
> 
> [1] https://lpc.events/event/17/contributions/1627/
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

Hi Sean,

Overall this looks quite clean to me.
Please find minor some nits flagged by tooling below.

> +/**
> + * struct pcs_wrapper - Wrapper for a registered PCS
> + * @pcs: the wrapping PCS
> + * @refcnt: refcount for the wrapper
> + * @list: list head for pcs_wrappers
> + * @dev: the device associated with this PCS
> + * @fwnode: this PCS's firmware node; typically @dev.fwnode
> + * @wrapped: the backing PCS
> + */
> +struct pcs_wrapper {
> +	struct phylink_pcs pcs;
> +	refcount_t refcnt;
> +	struct list_head list;
> +	struct device *dev;
> +	struct fwnode_handle *fwnode;
> +	struct phylink_pcs *wrapped;
> +};

I think that wrapped needs an __rcu annotation.

Flagged by Sparse.

...

> +static int pcs_post_config(struct phylink_pcs *pcs,
> +			   phy_interface_t interface)
> +{
> +	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);

The line above dereferences pcs.

> +	struct phylink_pcs *wrapped;
> +	int ret, idx;
> +
> +	idx = srcu_read_lock(&pcs_srcu);
> +
> +	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
> +	if (pcs && wrapped->ops->pcs_post_config)

But here it is assumed that pcs may be NULL.
This does not seem consistent.

Flagged by Smatch.

> +		ret = wrapped->ops->pcs_post_config(wrapped, interface);
> +	else
> +		ret = 0;
> +
> +	srcu_read_unlock(&pcs_srcu, idx);
> +	return ret;
> +}

...

> +/**
> + * pcs_unregister() - unregister a PCS
> + * @pcs: a PCS previously registered with pcs_register()
> + */
> +void pcs_unregister(struct phylink_pcs *pcs)
> +{
> +	struct pcs_wrapper *wrapper;
> +
> +	mutex_lock(&pcs_mutex);
> +	list_for_each_entry(wrapper, &pcs_wrappers, list) {
> +		if (wrapper->wrapped == pcs)

Assuming that rcu_access_pointer() works with srcu,
I think that this should be:

		if (rcu_access_pointer(wrapper->wrapped) == pcs)

Also flagged by Sparse

> +			goto found;
> +	}
> +
> +	mutex_unlock(&pcs_mutex);
> +	WARN(1, "trying to unregister an already-unregistered PCS\n");
> +	return;
> +
> +found:
> +	list_del(&wrapper->list);
> +	mutex_unlock(&pcs_mutex);
> +
> +	put_device(wrapper->dev);
> +	fwnode_handle_put(wrapper->fwnode);
> +	rcu_replace_pointer(wrapper->wrapped, NULL, true);
> +	synchronize_srcu(&pcs_srcu);
> +
> +	if (!wrapper->pcs.poll)
> +		phylink_pcs_change(&wrapper->pcs, false);
> +	if (refcount_dec_and_test(&wrapper->refcnt))
> +		kfree(wrapper);
> +}
> +EXPORT_SYMBOL_GPL(pcs_unregister);
> +
> +static void devm_pcs_unregister(void *pcs)
> +{
> +	pcs_unregister(pcs);
> +}
> +
> +/**
> + * devm_pcs_register - resource managed pcs_register()

nit: devm_pcs_register_full

     Flagged by W=1 builds, and ./scripts/kernel-doc -none

> + * @dev: device that is registering this PCS
> + * @fwnode: The PCS's firmware node; typically @dev.fwnode
> + * @pcs: the PCS to register
> + *
> + * Managed pcs_register(). For PCSs registered by this function,
> + * pcs_unregister() is automatically called on driver detach. See
> + * pcs_register() for more information.
> + *
> + * Return: 0 on success, or -errno on failure
> + */
> +int devm_pcs_register_full(struct device *dev, struct fwnode_handle *fwnode,

...

> +/**
> + * pcs_find_fwnode() - Find a PCS's fwnode
> + * @mac_node: The fwnode referencing the PCS
> + * @id: The name of the PCS to get. May be %NULL to get the first PCS.
> + * @fallback: An optional fallback property to use if pcs-handle is absent
> + * @optional: Whether the PCS is optional
> + *
> + * Find a PCS's fwnode, as referenced by @mac_node. This fwnode can later be
> + * used with _pcs_get_tail() to get the actual PCS. ``pcs-handle-names`` is
> + * used to match @id, then the fwnode is found using ``pcs-handle``.
> + *
> + * This function is internal to the PCS subsystem from a consumer
> + * point-of-view. However, it may be used to implement fallbacks for legacy
> + * behavior in PCS providers.
> + *
> + * Return: %NULL if @optional is set and the PCS cannot be found. Otherwise,
> + * *       returns a PCS if found or an error pointer on failure.
> + */
> +struct fwnode_handle *pcs_find_fwnode(const struct fwnode_handle *mac_node,
> +				      const char *id, const char *fallback,
> +				      bool optional)
> +{
> +	int index;
> +	struct fwnode_handle *pcs_fwnode;

Reverse xmas tree here please.

Edward Cree's xmastree tool can be helpful:
https://github.com/ecree-solarflare/xmastree

> +
> +	if (!mac_node)
> +		return optional ? NULL : ERR_PTR(-ENODEV);
> +
> +	if (id)
> +		index = fwnode_property_match_string(mac_node,
> +						     "pcs-handle-names", id);
> +	else
> +		index = 0;
> +
> +	if (index < 0) {
> +		if (optional && (index == -EINVAL || index == -ENODATA))
> +			return NULL;
> +		return ERR_PTR(index);
> +	}
> +
> +	/* First try pcs-handle, and if that doesn't work try the fallback */
> +	pcs_fwnode = fwnode_find_reference(mac_node, "pcs-handle", index);
> +	if (PTR_ERR(pcs_fwnode) == -ENOENT && fallback)
> +		pcs_fwnode = fwnode_find_reference(mac_node, fallback, index);
> +	if (optional && !id && PTR_ERR(pcs_fwnode) == -ENOENT)
> +		return NULL;
> +	return pcs_fwnode;
> +}
> +EXPORT_SYMBOL_GPL(pcs_find_fwnode);

...

