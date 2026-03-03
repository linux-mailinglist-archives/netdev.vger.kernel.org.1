Return-Path: <netdev+bounces-263225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFXiIOjtpmlKaQAAu9opvQ
	(envelope-from <netdev+bounces-263225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:19:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 132011F1516
	for <lists+netdev@lfdr.de>; Tue, 03 Mar 2026 15:19:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BEDFE30B9C98
	for <lists+netdev@lfdr.de>; Tue,  3 Mar 2026 14:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B800B3AE703;
	Tue,  3 Mar 2026 14:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="SPWntByS"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EA935CBC4;
	Tue,  3 Mar 2026 14:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772547221; cv=none; b=lM4MrWZty0Oz4h8qwccTUHKv+lpHy3WKd4SmpRVCl9SPQaU9C+lN8PpSDIQUR685DYoqaQ7DwwlQMAlu3WBoD9jBmyMfLi9f2gea/FfiS4xM2MLHnfGLbOd0I6BuS++WupRirTxsTnkDfGYdRrsSlmIUCxPbMOJTtu3ork2WLmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772547221; c=relaxed/simple;
	bh=yVMnKaxqCc7XaVuRhPyqAU+dppHnR2+MIEE7iUM0kwE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iepl+VLM0QLK3S/2Izc66wxDJQiqgo/jaqxt35XspgVz08RTMLpAQLKZ4wd/Jjw4jMHglAbTMRAnbdV80cejRS1t58dK4C7HWihJI4jqsQNWuTo68AS5KP8fHGmpCfrJ64EsNymlJQn1DcOj4XTf3XutQLDH0vgZ+gdzW65XQhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=SPWntByS; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=wmyUrmwYhbtal84M9nOqbwniUVXZJpfDSjJfxgS0ia0=; b=SPWntBySpHYG3MS+zt4ArDyMt9
	b2JUQqZwIxUgyL7Bx4g23ZlhpghbpJfkZrmRsMdmSBd1YZOQSccFlYuz6CZ4+zioZBALAY1c4yebE
	T9xGOvKhQat90UPAC/TSQ78CzBT/mb6Ipa9KOZfPb6hcK7rhANlvztMXEwXXnNdwe0R8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vxQV5-009ruN-NS; Tue, 03 Mar 2026 15:13:27 +0100
Date: Tue, 3 Mar 2026 15:13:27 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jens Emil Schulz =?iso-8859-1?Q?=D8stergaard?= <jensemil.schulzostergaard@microchip.com>
Cc: UNGLinuxDriver@microchip.com, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 1/8] net: dsa: add tag driver for LAN9645X
Message-ID: <c0213890-ef36-435c-aa73-869ee5e849d5@lunn.ch>
References: <20260303-dsa_lan9645x_switch_driver_base-v1-0-bff8ca1396f5@microchip.com>
 <20260303-dsa_lan9645x_switch_driver_base-v1-1-bff8ca1396f5@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-dsa_lan9645x_switch_driver_base-v1-1-bff8ca1396f5@microchip.com>
X-Rspamd-Queue-Id: 132011F1516
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-263225-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_TWELVE(0.00)[18];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

> +#define LAN9645X_VALIDATE_FIELD(_fld, _fld_sz)				\
> +do {									\
> +	BUILD_BUG_ON_MSG((_fld_sz) > 32, "IFH field size wider than 32.");\
> +	BUILD_BUG_ON_MSG((_fld_sz) == 0, "IFH field size of 0.");	\
> +	BUILD_BUG_ON_MSG((_fld) + (_fld_sz) > LAN9645X_IFH_BITS,	\
> +			 "IFH field overflows IFH");			\
> +} while (0)
> +
> +#define LAN9645X_IFH_GET(_ifh, _fld) \
> +({ \
> +	LAN9645X_VALIDATE_FIELD(_fld, _fld##_SZ);\
> +	lan9645x_ifh_get((_ifh), (_fld), _fld##_SZ); \
> +})
> +
> +#define LAN9645X_IFH_SET(_ifh, _fld, _val) \
> +({ \
> +	LAN9645X_VALIDATE_FIELD(_fld, _fld##_SZ);\
> +	lan9645x_ifh_set((_ifh), (_val), (_fld), _fld##_SZ); \
> +})

If you change the BUILD_BUG_ON_MSG() to static_assert(), you can do
the checks in global scope, rather than in a function call.  You can
then call lan9645x_ifh_set() directly, without the macro.

> +static inline void lan9645x_ifh_set(u8 *ifh, u32 val, size_t pos, size_t length)

These functions are big enough i would place them into the .c file.
Then, normally, i would say, please don't use inline in a C file. But
here we are in the fast path. Have you tried this with and without the
inline? How does it change the object size and performance?

> diff --git a/net/dsa/Kconfig b/net/dsa/Kconfig
> index 5ed8c704636d..8592cccde7ff 100644
> --- a/net/dsa/Kconfig
> +++ b/net/dsa/Kconfig
> @@ -211,4 +211,14 @@ config NET_DSA_TAG_YT921X
>  	  Say Y or M if you want to enable support for tagging frames for
>  	  Motorcomm YT921x switches.
>  
> +config NET_DSA_TAG_LAN9645X
> +	tristate "Tag driver for Lan9645x switches"
> +	help
> +	  Say Y or M if you want to enable NPI tagging for the Lan9645x switches.
> +	  In this mode, the frames over the Ethernet CPU port are prepended with
> +	  a hardware-defined injection/extraction frame header.
> +	  On injection a 28 byte internal frame header (IFH) is used. On
> +	  extraction a 16 byte prefix is prepended before the internal frame
> +	  header. This prefix starts with a broadcast MAC, to ease passage
> +	  through the host side RX filter.

The sorting in DSA is a bit hit and miss. The Kconfig file is however
sorted. Please insert before the Lantiq tag driver.

>  endif
> diff --git a/net/dsa/Makefile b/net/dsa/Makefile
> index bf7247759a64..dddcd85c81ce 100644
> --- a/net/dsa/Makefile
> +++ b/net/dsa/Makefile
> @@ -42,6 +42,7 @@ obj-$(CONFIG_NET_DSA_TAG_TRAILER) += tag_trailer.o
>  obj-$(CONFIG_NET_DSA_TAG_VSC73XX_8021Q) += tag_vsc73xx_8021q.o
>  obj-$(CONFIG_NET_DSA_TAG_XRS700X) += tag_xrs700x.o
>  obj-$(CONFIG_NET_DSA_TAG_YT921X) += tag_yt921x.o
> +obj-$(CONFIG_NET_DSA_TAG_LAN9645X) += tag_lan9645x.o

Also sorted.

	Andrew

