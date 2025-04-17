Return-Path: <netdev+bounces-183797-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A1A92055
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 16:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B6A1893442
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 14:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11F4253323;
	Thu, 17 Apr 2025 14:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sY1NNLk0"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta0.migadu.com (out-182.mta0.migadu.com [91.218.175.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CA425290D;
	Thu, 17 Apr 2025 14:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744901788; cv=none; b=uuO6jBOPtAE6aQ/kCD7fcba8vm8CrPU+LYFzZ0NWhlPIbK/EXFR+gVnk5KnEWvHzc2Sz2C8mu9FQ5CmK9uWqoLodqipwUSRQTUY1ZUZIJrz7wp0es7XXF3xXSUrR8orCstlLWYRw4uGHgeotJnf7d3KLxNcjZzeGu3L32GcPUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744901788; c=relaxed/simple;
	bh=f4VpzSQyVEUlcA1+rjMRBX3EraHdMKhtBG0f6HU2uVw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mPNzq+bLmZM330qfkMUYQfXXXjJvvMF7LCJoFRYduCVaTnc/QJtWKCwmch8Us978ZuWMwk3FqNTwhjuVPb7Gr5uRpfUUjG3/F+C9SfV4KTQjex6NBgUmWlk9iMl486bY1vEHOKFrEpaccWPxfpYAetbdOGvGNwH/VVPfymW51h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sY1NNLk0; arc=none smtp.client-ip=91.218.175.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <98dbfe79-9ee7-40bc-85bd-3401310eacdd@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1744901774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vsd90iGqEiz0A9QChGUBF3bflV2hP/cb0UB54Xwa7Tw=;
	b=sY1NNLk0YIdyxJQQOgJAjXS66bA5VAnKAXwf4PoZ48Ji39UuHwbu//2Jp6SRtxHKNvuAWx
	16XuJ7HIETX5RmDsHhZkG5y74pyC7Z9obM1sHaHSnVv65OXtCsvm2vERQpk5pPkr7lb5z2
	9RvUfAz5CHoWo0jNgJzngl5KTQyV5uA=
Date: Thu, 17 Apr 2025 10:56:08 -0400
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
 <20250417083559.GA2430521@horms.kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <20250417083559.GA2430521@horms.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 4/17/25 04:35, Simon Horman wrote:
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
> Overall this looks quite clean to me.
> Please find minor some nits flagged by tooling below.
> 
>> +/**
>> + * struct pcs_wrapper - Wrapper for a registered PCS
>> + * @pcs: the wrapping PCS
>> + * @refcnt: refcount for the wrapper
>> + * @list: list head for pcs_wrappers
>> + * @dev: the device associated with this PCS
>> + * @fwnode: this PCS's firmware node; typically @dev.fwnode
>> + * @wrapped: the backing PCS
>> + */
>> +struct pcs_wrapper {
>> +	struct phylink_pcs pcs;
>> +	refcount_t refcnt;
>> +	struct list_head list;
>> +	struct device *dev;
>> +	struct fwnode_handle *fwnode;
>> +	struct phylink_pcs *wrapped;
>> +};
> 
> I think that wrapped needs an __rcu annotation.
> 
> Flagged by Sparse.
> 
> ...

Will add.

>> +static int pcs_post_config(struct phylink_pcs *pcs,
>> +			   phy_interface_t interface)
>> +{
>> +	struct pcs_wrapper *wrapper = pcs_to_wrapper(pcs);
> 
> The line above dereferences pcs.
> 
>> +	struct phylink_pcs *wrapped;
>> +	int ret, idx;
>> +
>> +	idx = srcu_read_lock(&pcs_srcu);
>> +
>> +	wrapped = srcu_dereference(wrapper->wrapped, &pcs_srcu);
>> +	if (pcs && wrapped->ops->pcs_post_config)
> 
> But here it is assumed that pcs may be NULL.
> This does not seem consistent.
> 
> Flagged by Smatch.

This should be if(wrapped && ...

>> +		ret = wrapped->ops->pcs_post_config(wrapped, interface);
>> +	else
>> +		ret = 0;
>> +
>> +	srcu_read_unlock(&pcs_srcu, idx);
>> +	return ret;
>> +}
> 
> ...
> 
>> +/**
>> + * pcs_unregister() - unregister a PCS
>> + * @pcs: a PCS previously registered with pcs_register()
>> + */
>> +void pcs_unregister(struct phylink_pcs *pcs)
>> +{
>> +	struct pcs_wrapper *wrapper;
>> +
>> +	mutex_lock(&pcs_mutex);
>> +	list_for_each_entry(wrapper, &pcs_wrappers, list) {
>> +		if (wrapper->wrapped == pcs)
> 
> Assuming that rcu_access_pointer() works with srcu,
> I think that this should be:
> 
> 		if (rcu_access_pointer(wrapper->wrapped) == pcs)
> 
> Also flagged by Sparse

OK

>> +			goto found;
>> +	}
>> +
>> +	mutex_unlock(&pcs_mutex);
>> +	WARN(1, "trying to unregister an already-unregistered PCS\n");
>> +	return;
>> +
>> +found:
>> +	list_del(&wrapper->list);
>> +	mutex_unlock(&pcs_mutex);
>> +
>> +	put_device(wrapper->dev);
>> +	fwnode_handle_put(wrapper->fwnode);
>> +	rcu_replace_pointer(wrapper->wrapped, NULL, true);
>> +	synchronize_srcu(&pcs_srcu);
>> +
>> +	if (!wrapper->pcs.poll)
>> +		phylink_pcs_change(&wrapper->pcs, false);
>> +	if (refcount_dec_and_test(&wrapper->refcnt))
>> +		kfree(wrapper);
>> +}
>> +EXPORT_SYMBOL_GPL(pcs_unregister);
>> +
>> +static void devm_pcs_unregister(void *pcs)
>> +{
>> +	pcs_unregister(pcs);
>> +}
>> +
>> +/**
>> + * devm_pcs_register - resource managed pcs_register()
> 
> nit: devm_pcs_register_full
> 
>      Flagged by W=1 builds, and ./scripts/kernel-doc -none

OK

>> + * @dev: device that is registering this PCS
>> + * @fwnode: The PCS's firmware node; typically @dev.fwnode
>> + * @pcs: the PCS to register
>> + *
>> + * Managed pcs_register(). For PCSs registered by this function,
>> + * pcs_unregister() is automatically called on driver detach. See
>> + * pcs_register() for more information.
>> + *
>> + * Return: 0 on success, or -errno on failure
>> + */
>> +int devm_pcs_register_full(struct device *dev, struct fwnode_handle *fwnode,
> 
> ...
> 
>> +/**
>> + * pcs_find_fwnode() - Find a PCS's fwnode
>> + * @mac_node: The fwnode referencing the PCS
>> + * @id: The name of the PCS to get. May be %NULL to get the first PCS.
>> + * @fallback: An optional fallback property to use if pcs-handle is absent
>> + * @optional: Whether the PCS is optional
>> + *
>> + * Find a PCS's fwnode, as referenced by @mac_node. This fwnode can later be
>> + * used with _pcs_get_tail() to get the actual PCS. ``pcs-handle-names`` is
>> + * used to match @id, then the fwnode is found using ``pcs-handle``.
>> + *
>> + * This function is internal to the PCS subsystem from a consumer
>> + * point-of-view. However, it may be used to implement fallbacks for legacy
>> + * behavior in PCS providers.
>> + *
>> + * Return: %NULL if @optional is set and the PCS cannot be found. Otherwise,
>> + * *       returns a PCS if found or an error pointer on failure.
>> + */
>> +struct fwnode_handle *pcs_find_fwnode(const struct fwnode_handle *mac_node,
>> +				      const char *id, const char *fallback,
>> +				      bool optional)
>> +{
>> +	int index;
>> +	struct fwnode_handle *pcs_fwnode;
> 
> Reverse xmas tree here please.

OK

> Edward Cree's xmastree tool can be helpful:
> https://github.com/ecree-solarflare/xmastree

I wonder if we could get this into checkpatch...

Thanks for the review.

--Sean

