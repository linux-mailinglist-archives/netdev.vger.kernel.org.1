Return-Path: <netdev+bounces-232092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 795F4C00C51
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 13:34:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA6F23B2BD6
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 11:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6F6530BB82;
	Thu, 23 Oct 2025 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HmQniJf6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0E62ECD3F;
	Thu, 23 Oct 2025 11:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219073; cv=none; b=YccUGX2y1ljHEi7O8J84uS6fxpHVuwah35T6qHQxZBCj2eW+TYFIsCUHruCa0Lra12i6afO8ZgnjAnc/yqGx2YIakwCE48DcLaWvp/wHdZ0hDAYFJkhNvlLgbQ8hItE9OWj3bSoBBeQC0GSZapogC9GSTeUykL/fQX7Ifu7THPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219073; c=relaxed/simple;
	bh=ARRC88WkJJjPqGQVjd2vob6eGn9St1j7rknF1fJ82N0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AC/JmDRBFk8fW9nRVrBTpptlJcjossd3m7GeDnGTaE4wHbWk9YMBtrOaMqeqPO/3lM6mVI+EidVFdWI0HwlWNWSYGaP3yaHLij12x9XGuEGhw/JyZbOhENyC3KOv3CCkRkfVnkmTDlVpbT6uQM2L05hF6s31YV3aGeZnztVTmVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HmQniJf6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DE70C4CEE7;
	Thu, 23 Oct 2025 11:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761219073;
	bh=ARRC88WkJJjPqGQVjd2vob6eGn9St1j7rknF1fJ82N0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HmQniJf68vsKJSwbMC61UqGNxCcmsJbxY8s0x9InapF38RFtMmBFYOhZqxv8kbNyR
	 0w9xj7J8vJt9vxd3Oqz+CP9XxW6QuFATzVOVN5OzIL0y6MkHBOuFq6SPRO9tYJZnbp
	 tAmOdNU2A2ZbGszYzK9h1JFd4YvuDpSA4bWthHNyTjCvMypP1mw4zAaIjyivCx/DGL
	 oNmUiTLjizWArrkalSaboq4jX4hNzn1Z4YouanCcmSHrVHaAyE/k5KE0PlfglmaxPa
	 Qf7fI0EXuNK35Q3bj6C/zDTf7T+GE4YQdi5PY49Of30kLbobPSMOFOXVa1gKjeoOgF
	 UmjpKxqt7PBlg==
Date: Thu, 23 Oct 2025 12:31:08 +0100
From: Simon Horman <horms@kernel.org>
To: Dmitry Skorodumov <skorodumov.dmitry@huawei.com>
Cc: netdev@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, andrey.bokhanko@huawei.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH net-next 1/8] ipvlan: Implement learnable L2-bridge
Message-ID: <aPoR_HWEgmrs97Qd@horms.kernel.org>
References: <20251021144410.257905-1-skorodumov.dmitry@huawei.com>
 <20251021144410.257905-2-skorodumov.dmitry@huawei.com>
 <aPjo76T8c8SbOB04@horms.kernel.org>
 <58174e6d-f473-4e95-b78e-7a4a9711174e@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <58174e6d-f473-4e95-b78e-7a4a9711174e@huawei.com>

On Thu, Oct 23, 2025 at 01:21:20PM +0300, Dmitry Skorodumov wrote:
> On 22.10.2025 17:23, Simon Horman wrote:
> > On Tue, Oct 21, 2025 at 05:44:03PM +0300, Dmitry Skorodumov wrote:
> >> Now it is possible to create link in L2E mode: learnable
> >> bridge. The IPs will be learned from TX-packets of child interfaces.
> > Is there a standard for this approach - where does the L2E name come from?
> 
> Actually, I meant "E" here as "Extended". But more or less standard naming - is "MAC NAT" - "Mac network address translation". I discussed a bit naming with LLM, and it suggested name "macsnat".. looks like  it is a better name. Hope it is ok, but I don't mind to rename if anyone has better idea

I was more curious than anything else. But perhaps it would
be worth providing some explanation of the name in the
commit message.

...

> >> +static void ipvlan_addr_learn(struct ipvl_dev *ipvlan, void *lyr3h,
> >> +			      int addr_type)
> >> +{
> >> +	void *addr = NULL;
> >> +	bool is_v6;
> >> +
> >> +	switch (addr_type) {
> >> +#if IS_ENABLED(CONFIG_IPV6)
> >> +	/* No need to handle IPVL_ICMPV6, since it never has valid src-address */
> >> +	case IPVL_IPV6: {
> >> +		struct ipv6hdr *ip6h;
> >> +
> >> +		ip6h = (struct ipv6hdr *)lyr3h;
> >> +		if (!is_ipv6_usable(&ip6h->saddr))
> > It is preferred to avoid #if / #ifdef in order to improve compile coverage
> > (and, I would argue, readability).
> ..
> > In this case I think that can be achieved by changing the line above to:
> >
> > 		if (!IS_ENABLED(CONFIG_IPV6) || !is_ipv6_usable(&ip6h->saddr))
> >
> > I think it would be interesting to see if a similar approach can be used
> > to remove other #if CONFIG_IPV6 conditions in this file, and if successful
> > provide that as a clean-up as the opening patch in this series.
> >
> > However, without that, I can see how one could argue for the approach
> > you have taken here on the basis of consistency.
> >
> 
> Hmmmm.... this raises a complicated for me questions of testing this refactoring: 
> 
> - whether IPv6 specific functions (like csum_ipv6_magic(), register_inet6addr_notifier()) are available if kernel is compiled without CONFIG_IPV6
> 
> - ideally the code should be retested with kernel without CONFIG_IPV6
> 
> This looks like a separate work that requires more or less additional efforts...

Understood, I agree this can be left as future work.

> 
> > static int ipvlan_xmit_mode_l2(struct sk_buff *skb, struct net_device *dev)
> >>  {
> >> -	const struct ipvl_dev *ipvlan = netdev_priv(dev);
> >> -	struct ethhdr *eth = skb_eth_hdr(skb);
> >> -	struct ipvl_addr *addr;
> >>  	void *lyr3h;
> >> +	struct ipvl_addr *addr;
> >>  	int addr_type;
> >> +	bool same_mac_addr;
> >> +	struct ipvl_dev *ipvlan = netdev_priv(dev);
> >> +	struct ethhdr *eth = skb_eth_hdr(skb);
> > I realise that the convention is not followed in the existing code,
> > but please prefer to arrange local variables in reverse xmas tree order -
> > longest line to shortest.
> I fixed all my changes to follow this style, except one - where it seems a bit unnatural to to declare dependent variable before "parent" variable. Hope it is ok.

I would lean towards reverse xmas here too.
But I understand if you feel otherwise.
And given the current state of this file, I think that is ok.

> >> +	    ether_addr_equal(eth->h_source, dev->dev_addr)) {
> >> +		/* ignore tx-packets from host */
> >> +		goto out_drop;
> >> +	}
> >> +
> >> +	same_mac_addr = ether_addr_equal(eth->h_dest, eth->h_source);
> >> +
> >> +	lyr3h = ipvlan_get_L3_hdr(ipvlan->port, skb, &addr_type);
> >>  
> >> -	if (!ipvlan_is_vepa(ipvlan->port) &&
> >> -	    ether_addr_equal(eth->h_dest, eth->h_source)) {
> >> -		lyr3h = ipvlan_get_L3_hdr(ipvlan->port, skb, &addr_type);
> >> +	if (ipvlan_is_learnable(ipvlan->port)) {
> >> +		if (lyr3h)
> >> +			ipvlan_addr_learn(ipvlan, lyr3h, addr_type);
> >> +		/* Mark SKB in advance */
> >> +		skb = skb_share_check(skb, GFP_ATOMIC);
> >> +		if (!skb)
> >> +			return NET_XMIT_DROP;
> > I think that when you drop packets a counter should be incremented.
> > Likewise elsewhere in this function.
> The counter appears to be handled in parent function - in ipvlan_start_xmit()

Thanks, I see that now.

> >> +	addr = ipvlan_addr_lookup(port, lyr3h, addr_type, true);
> >> +	if (addr) {
> >> +		int ret, len;
> >> +
> >> +		ipvlan_skb_crossing_ns(skb, addr->master->dev);
> >> +		skb->protocol = eth_type_trans(skb, skb->dev);
> >> +		skb->pkt_type = PACKET_HOST;
> >> +		ipvlan_mark_skb(skb, port->dev);
> >> +		len = skb->len + ETH_HLEN;
> >> +		ret = netif_rx(skb);
> >> +		ipvlan_count_rx(ipvlan, len, ret == NET_RX_SUCCESS, false);
> >>
> >> This fails to build because ipvlan is not declared in this scope.
> >> Perhaps something got missed due to an edit?
> Oops, really. Compilation was fixed in later patches.

Stuff happens :)

...

