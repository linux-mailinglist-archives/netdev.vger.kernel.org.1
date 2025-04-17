Return-Path: <netdev+bounces-183799-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9651DA920C8
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 17:05:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 583CC7B11A6
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 15:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C472475C7;
	Thu, 17 Apr 2025 15:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Gx2EOvec"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81CF2512E1
	for <netdev@vger.kernel.org>; Thu, 17 Apr 2025 15:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902344; cv=none; b=HG1n87On+agMP4IxPeOFa7hmb5a2wLJj0IEbfrYWdZIiDwq9AXl/Cg+3TNhU7I/dEzZ/CwsAUoc1JAtFK3JxgRxG0zKUHCelCB3H+ByvCv/n31rNaVCUaAcjKkTO3Fj4Elh8kZirosUKco0z/SEHIYgq/0CQPEFnrGl2c6l5fXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902344; c=relaxed/simple;
	bh=mYnYDBhB4iVZK8o+WurggM8h518uosFxtFofEwgMFJk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OmZTpJ0X2btuSx/4o3kljo49ZqP8e4ItfdYQx1CixlxP2oAV3U5N2bXSBZGiGRP9ZndRJPATDmXHBSrQ1P0i+PuUMuQG87eBsM7h4rMb5x2LTt7adtr/JHQLOd8aj4JxJhu1ONLpWqwOWNTbiP5aVyusRoL7JtfTT3+WKpUHuVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Gx2EOvec; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0bd8a9c0-4824-4c1f-bf32-ac1e57e2bea0@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744902330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Bc/VJlIB1nkTBkSY664JrQaUk9ZbIGdSI77xWP1fgzk=;
	b=Gx2EOvecFX1YSCE2w7PHZ/6VtyfbUSI5OUa3vxOiUi2wmTDB7y24xmHILDDJG6cZ8JHhv/
	a4tsWC+uc5kUBai1CA+GAeMimVvW43hXMvp/hW1AtbJHuxntjNYOMuLM/0sLl0GFKbSvCD
	P6/I3yDf5FUW2PZlKNnoiNXbDlu3IPE=
Date: Thu, 17 Apr 2025 11:05:24 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [net-next PATCH v3 03/11] net: pcs: Add subsystem
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, upstream@airoha.com,
 Christian Marangi <ansuelsmth@gmail.com>, linux-kernel@vger.kernel.org,
 Kory Maincent <kory.maincent@bootlin.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org
References: <20250415193323.2794214-1-sean.anderson@linux.dev>
 <20250415193323.2794214-4-sean.anderson@linux.dev>
 <20250417091936.GB2430521@horms.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250417091936.GB2430521@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/17/25 05:19, Simon Horman wrote:
> On Tue, Apr 15, 2025 at 03:33:15PM -0400, Sean Anderson wrote:
>> This adds support for getting PCS devices from the device tree. PCS
>> drivers must first register with phylink_register_pcs. After that, MAC
>> drivers may look up their PCS using phylink_get_pcs.
>> 
>> We wrap registered PCSs in another PCS. This wrapper PCS is refcounted
>> and can outlive the wrapped PCS (such as if the wrapped PCS's driver is
>> unbound). The wrapper forwards all PCS callbacks to the wrapped PCS,
>> first checking to make sure the wrapped PCS still exists. This design
>> was inspired by Bartosz Golaszewski's talk at LPC [1].
>> 
>> pcs_get_by_fwnode_compat is a bit hairy, but it's necessary for
>> compatibility with existing drivers, which often attach to (devicetree)
>> nodes directly. We use the devicetree changeset system instead of
>> adding a (secondary) software node because mdio_bus_match calls
>> of_driver_match_device to match devices, and that function only works on
>> devicetree nodes.
>> 
>> [1] https://lpc.events/event/17/contributions/1627/
>> 
>> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> 
> Hi Sean,
> 
> I noticed a few build problems after sending my previous email.
> 
> I was able to exercise them using variants of the following to
> generate small configs. I include this here in case it is useful to you.
> 
> make tinyconfig
> 
> cat >> .config << __EOF__
> CONFIG_MODULES=y
> CONFIG_NET=y
> CONFIG_NETDEVICES=y
> CONFIG_PCS=y
> CONFIG_PHYLIB=m
> __EOF__
> 
> cat >> .config << __EOF__
> CONFIG_OF=y
> CONFIG_OF_UNITTEST=y
> CONFIG_OF_DYNAMIC=y
> __EOF__
> 
> yes "" | make oldconfig
> 
> ...
> 
>> diff --git a/drivers/net/pcs/core.c b/drivers/net/pcs/core.c
> 
> ...

Thanks, I was able to reproduce/fix these issues.

How did you find these? By inspection?

I often end up missing build issues like this because I mostly
test with everything enabled.

--Sean

>> +/**
>> + * _pcs_get() - Get a PCS from a fwnode property
>> + * @dev: The device to get a PCS for
>> + * @fwnode: The fwnode to find the PCS with
>> + * @id: The name of the PCS to get. May be %NULL to get the first PCS.
>> + * @fallback: An optional fallback property to use if pcs-handle is absent
>> + * @optional: Whether the PCS is optional
>> + *
>> + * Find a PCS referenced by @mac_node and return a reference to it. Every call
>> + * to _pcs_get_by_fwnode() must be balanced with one to pcs_put().
>> + *
>> + * Return: a PCS if found, %NULL if not, or an error pointer on failure
>> + */
>> +struct phylink_pcs *_pcs_get(struct device *dev, struct fwnode_handle *fwnode,
>> +			     const char *id, const char *fallback,
>> +			     bool optional)
>> +{
>> +	struct fwnode_handle *pcs_fwnode;
>> +	struct phylink_pcs *pcs;
>> +
>> +	pcs_fwnode = pcs_find_fwnode(fwnode, id, fallback, optional);
>> +	if (IS_ERR(pcs_fwnode))
>> +		return ERR_CAST(pcs_fwnode);
>> +
>> +	pcs = _pcs_get_tail(dev, pcs_fwnode, NULL);
>> +	fwnode_handle_put(pcs_fwnode);
>> +	return pcs;
>> +}
>> +EXPORT_SYMBOL_GPL(_pcs_get);
>> +
>> +static __maybe_unused void of_changeset_cleanup(void *data)
>> +{
>> +	struct of_changeset *ocs = data;
> 
> Code in pcs_get_by_fwnode_compat is conditionally compiled
> based on CONFIG_OF_DYNAMIC. I think that is needed here too,
> because of_changeset_revert() doesn't exist unless CONFIG_OF_DYNAMIC is set.
> 
>> +
>> +	if (WARN(of_changeset_revert(ocs),
>> +		 "could not revert changeset; leaking memory\n"))
>> +		return;
>> +
>> +	of_changeset_destroy(ocs);
>> +	kfree(ocs);
>> +}
>> +
>> +/**
>> + * pcs_get_by_fwnode_compat() - Get a PCS with a compatibility fallback
>> + * @dev: The device requesting the PCS
>> + * @fwnode: The &struct fwnode_handle of the PCS itself
>> + * @fixup: Callback to fix up @fwnode for compatibility
>> + * @data: Passed to @fixup
>> + *
>> + * This function looks up a PCS and retries on failure after fixing up @fwnode.
>> + * It is intended to assist in backwards-compatible behavior for drivers that
>> + * used to create a PCS directly from a &struct device_node. This function
>> + * should NOT be used in new drivers.
>> + *
>> + * @fixup modifies a devicetree changeset to create any properties necessary to
>> + * bind the PCS's &struct device_node. At the very least, it should use
>> + * of_changeset_add_prop_string() to add a compatible property.
>> + *
>> + * Note that unlike pcs_get_by_fwnode, @fwnode is the &struct fwnode_handle of
>> + * the PCS itself, and not that of the requesting device. @fwnode could be
>> + * looked up with pcs_find_fwnode() or determined by some other means for
>> + * compatibility.
>> + *
>> + * Return: A PCS on success or an error pointer on failure
>> + */
>> +struct phylink_pcs *
>> +pcs_get_by_fwnode_compat(struct device *dev, struct fwnode_handle *fwnode,
>> +			 int (*fixup)(struct of_changeset *ocs,
>> +				      struct device_node *np, void *data),
>> +			 void *data)
>> +{
>> +#ifdef CONFIG_OF_DYNAMIC
>> +	struct mdio_device *mdiodev;
>> +	struct of_changeset *ocs;
>> +	struct phylink_pcs *pcs;
>> +	struct device_node *np;
>> +	struct device *pcsdev;
>> +	int err;
>> +
>> +	/* First attempt */
>> +	pcs = _pcs_get_tail(dev, fwnode, NULL);
>> +	if (PTR_ERR(pcs) != -EPROBE_DEFER)
>> +		return pcs;
>> +
>> +	/* No luck? Maybe there's no compatible... */
>> +	np = to_of_node(fwnode);
>> +	if (!np || of_property_present(np, "compatible"))
>> +		return pcs;
>> +
>> +	/* OK, let's try fixing things up */
>> +	pr_warn("%pOF is missing a compatible\n", np);
>> +	ocs = kmalloc(sizeof(*ocs), GFP_KERNEL);
>> +	if (!ocs)
>> +		return ERR_PTR(-ENOMEM);
>> +
>> +	of_changeset_init(ocs);
>> +	err = fixup(ocs, np, data);
>> +	if (err)
>> +		goto err_ocs;
>> +
>> +	err = of_changeset_apply(ocs);
>> +	if (err)
>> +		goto err_ocs;
>> +
>> +	err = devm_add_action_or_reset(dev, of_changeset_cleanup, ocs);
>> +	if (err)
>> +		return ERR_PTR(err);
>> +
>> +	mdiodev = fwnode_mdio_find_device(fwnode);
> 
> fwnode_mdio_find_device() is unavailable for linking if PHYLIB is a module
> (and PCS is built-in).
> 
>> +	if (mdiodev) {
>> +		/* Clear that pesky PHY flag so we can match PCS drivers */
>> +		device_lock(&mdiodev->dev);
>> +		mdiodev->flags &= ~MDIO_DEVICE_FLAG_PHY;
>> +		device_unlock(&mdiodev->dev);
>> +		pcsdev = &mdiodev->dev;
>> +	} else {
>> +		pcsdev = get_device(fwnode->dev);
>> +		if (!pcsdev)
>> +			return ERR_PTR(-EPROBE_DEFER);
>> +	}
>> +
>> +	err = device_reprobe(pcsdev);
>> +	put_device(pcsdev);
>> +	if (err)
>> +		return ERR_PTR(err);
>> +
>> +	return _pcs_get_tail(dev, fwnode, NULL);
>> +
>> +err_ocs:
>> +	of_changeset_destroy(ocs);
>> +	kfree(ocs);
>> +	return ERR_PTR(err);
>> +#else
>> +	return _pcs_get_tail(dev, fwnode, NULL);
>> +#endif
>> +}
>> +EXPORT_SYMBOL_GPL(pcs_get_by_fwnode_compat);
> 
> ...


