Return-Path: <netdev+bounces-191346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD82DABB0A9
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 17:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EBC918964DB
	for <lists+netdev@lfdr.de>; Sun, 18 May 2025 15:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 397D41DD877;
	Sun, 18 May 2025 15:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="AOCYjY/E"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFF9610B;
	Sun, 18 May 2025 15:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747581844; cv=none; b=L9RWoVz8y/T1nYGyHb+w+3rBUOdcoDiLzhO4CI1cH0Ecew36xtrUX3Q8inn2qGKWDhClD4ZGyXxKWdUVl7naLGvh7fKSvRt1CBvbh+D3Qo6uNssmvAXy4BdGvU4RQWL/+KRCw9N58FBC3epO+DPFHfNxDWZPKgd+uRytn24ignQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747581844; c=relaxed/simple;
	bh=mA5qQuJQLAcro2vZxBNo6TniIdRazAHJd+dKe7jRx/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NldNjDKr0KM8YSEhqqsfURFtB4nzQgSMvZuKjfmeRp/+PuPCP0MbwhjDYMKuW3p6T/OzBpjNqqgfclpaxYFadIc2hmC2hmddy2vVShdv9uLAbRUcca9pLs461TS9EakmEb1saMOhZN7CnYpfmceosgNnGSQk4iNcGcaamsnmgRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=AOCYjY/E; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RqGz4jmLw49/KAEoCTsNsCNBUVqB9Q8hkq+7cfJELDc=; b=AOCYjY/EKXnr6o6xc1hx49/EJr
	4A1itY69D3PnaUZmXJsrGSlhwOsjIRGF97zJErsBG/nYi9FU5ecPz8xYQzxcTG78GA3VIQIjgWYcS
	ZXE3TIgPXMIWWU9WLq6Xz75fKUq7r3/+btZKuJZ/5WZLW2oQ4d9OqwS4mFtrBdq/n9Eo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1uGfra-00Cvey-By; Sun, 18 May 2025 17:23:42 +0200
Date: Sun, 18 May 2025 17:23:42 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Damien =?iso-8859-1?Q?Ri=E9gel?= <damien.riegel@silabs.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Silicon Labs Kernel Team <linux-devel@silabs.com>,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>,
	Alex Elder <elder@kernel.org>, greybus-dev@lists.linaro.org
Subject: Re: [RFC net-next 00/15] Add support for Silicon Labs CPC
Message-ID: <cbfc9422-9ba8-475b-9c8d-e6ab0e53856e@lunn.ch>
References: <20250512012748.79749-1-damien.riegel@silabs.com>
 <6fea7d17-8e08-42c7-a297-d4f5a3377661@lunn.ch>
 <D9VCEGBQWBW8.3MJCYYXOZHZNX@silabs.com>
 <f1a4ab5a-f2ce-4c94-91eb-ab81aea5b413@lunn.ch>
 <D9W93CSVNNM0.F14YDBPZP64O@silabs.com>
 <2025051551-rinsing-accurate-1852@gregkh>
 <D9WTONSVOPJS.1DNQ703ATXIN1@silabs.com>
 <2025051612-stained-wasting-26d3@gregkh>
 <D9XQ42C56TUG.2VXDA4CVURNAM@silabs.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D9XQ42C56TUG.2VXDA4CVURNAM@silabs.com>

> I think Andrew pulled Greybus in the discussion because there is some
> overlap between Greybus and CPC:
>   - Greybus has bundles and CPorts, CPC only has "endpoints", which
>     would be the equivalent of a bundle with a single cport
>   - discoverability of Greybus bundles/CPC endpoints by the host
>   - multiple bundles/endpoints might coexist in the same
>     module/CPC-enabled device
>   - bundles/endpoints are independent from each other and each has its
>     own dedicated driver
> 
> Greybus goes a step further and specs some protocols like GPIO or UART.
> CPC doesn't spec what goes over endpoints because it's geared towards
> radio applications and as you said, it's very device/stack specific.

Is it device specific? Look at your Bluetooth implementation. I don't
see anything device specific in it. That should work for any of the
vendors of similar chips to yours.

For 802.15.4, Linux defines:

struct ieee802154_ops {
        struct module   *owner;
        int             (*start)(struct ieee802154_hw *hw);
        void            (*stop)(struct ieee802154_hw *hw);
        int             (*xmit_sync)(struct ieee802154_hw *hw,
                                     struct sk_buff *skb);
        int             (*xmit_async)(struct ieee802154_hw *hw,
                                      struct sk_buff *skb);
        int             (*ed)(struct ieee802154_hw *hw, u8 *level);
        int             (*set_channel)(struct ieee802154_hw *hw, u8 page,
                                       u8 channel);
        int             (*set_hw_addr_filt)(struct ieee802154_hw *hw,
                                            struct ieee802154_hw_addr_filt *filt,
                                            unsigned long changed);
        int             (*set_txpower)(struct ieee802154_hw *hw, s32 mbm);
        int             (*set_lbt)(struct ieee802154_hw *hw, bool on);
        int             (*set_cca_mode)(struct ieee802154_hw *hw,
                                        const struct wpan_phy_cca *cca);
        int             (*set_cca_ed_level)(struct ieee802154_hw *hw, s32 mbm);
        int             (*set_csma_params)(struct ieee802154_hw *hw,
                                           u8 min_be, u8 max_be, u8 retries);
        int             (*set_frame_retries)(struct ieee802154_hw *hw,
                                             s8 retries);
        int             (*set_promiscuous_mode)(struct ieee802154_hw *hw,
                                                const bool on);
};

Many of these are optional, but this gives an abstract representation
of a device, which is should be possible to turn into a protocol
talked over a transport bus like SPI or SDIO.

This also comes back to my point of there being at least four vendors
of devices like yours. Linux does not want four or more
implementations of this, each 90% the same, just a different way of
converting this structure of operations into messages over a transport
bus.

You have to define the protocol. Mainline needs that so when the next
vendor comes along, we can point at your protocol and say that is how
it has to be implemented in Mainline. Make your firmware on the SoC
understand it.  You have the advantage that you are here first, you
get to define that protocol, but you do need to clearly define it.

You have listed how your implementation is similar to Greybus. You say
what is not so great is streaming, i.e. the bulk data transfer needed
to implement xmit_sync() and xmit_async() above. Greybus is too much
RPC based. RPCs are actually what you want for most of the operations
listed above, but i agree for data, in order to keep the transport
fully loaded, you want double buffering. However, that appears to be
possible with the current Greybus code.

gb_operation_unidirectional_timeout() says:

 * Note that successful send of a unidirectional operation does not imply that
 * the request as actually reached the remote end of the connection.
 */

So long as you are doing your memory management correctly, i don't see
why you cannot implement double buffering in the transport driver.

I also don't see why you cannot extend the Greybus upper API and add a
true gb_operation_unidirectional_async() call.

You also said that lots of small transfers are inefficient, and you
wanted to combine small high level messages into one big transport
layer message. This is something you frequently see with USB Ethernet
dongles. The Ethernet driver puts a number of small Ethernet packets
into one USB URB. The USB layer itself has no idea this is going on. I
don't see why the same cannot be done here, greybus itself does not
need to be aware of the packet consolidation.

	Andrew

