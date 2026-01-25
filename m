Return-Path: <netdev+bounces-253190-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id fPaDE2lHdmmJOgEAu9opvQ
	(envelope-from <netdev+bounces-253190-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 17:40:09 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9E5781737
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 17:40:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A26FC30031D2
	for <lists+netdev@lfdr.de>; Sun, 25 Jan 2026 16:40:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B05533218BA;
	Sun, 25 Jan 2026 16:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="uurLsTpP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5439C185E4A;
	Sun, 25 Jan 2026 16:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769359205; cv=none; b=USR7iRF0fO+BzdVqUNZpxriny9+AqShHnHgDcfBRkzXyPxqNzZF34o0WMNP6MQOHLTJTyho6M4Kyx0iJQ1K2xFuXC5hHhamZgoUMQJXGVylLBvx/Tt7BjpSo50aRD6wIeevQY615T8Wufzy/LDpQ6zeGDRXCBU1za54uTvmUuH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769359205; c=relaxed/simple;
	bh=MHnITMVP7Sfcel4frgN9QZiW2SP9ou9OepNpEKtV9mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GrN1M9Lj4BI98HuyzXrdjX1jr5Sp3eod5PSYwPhQsZAsI34r+72Z4n+luPebh8hHyYFbb64O6sxHhqePQSXLWueXsQgmCP36Tox7qF/Z/wvxzdO2guLFpV3V1lD1CHO39sWuC5x7x891Dj8QP054wRjVaFPzv5wqY9IlumKk9MA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=uurLsTpP; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ETakwsD/yUOCLBYkKp02ZSmmBkp8bIPwozTwYuTxeso=; b=uurLsTpPnNCvWH/Y/DhJDr8Op3
	rH6yKrBH4YI4CY1Gcwza5nuwlb75dfUEBEYy5SmSP3Wg5CKw/OXH0kvfqVFPXrWhUVxyu0KEyxTIX
	lFRQjWr6ofVEFFS7emGW6VDzlwMyKfggH4o6YOwqePIJzz5RusJV1q4ForioNFjfnjbE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vk39c-004cui-HP; Sun, 25 Jan 2026 17:40:00 +0100
Date: Sun, 25 Jan 2026 17:40:00 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] net: usb: rtl8150: remove rtl8150_t typedef
 for struct rtl8150
Message-ID: <dd46b4ed-f0bb-4b69-938a-90237761673d@lunn.ch>
References: <20260125083501.34513-1-enelsonmoore@gmail.com>
 <20260125083501.34513-2-enelsonmoore@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260125083501.34513-2-enelsonmoore@gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253190-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A9E5781737
X-Rspamd-Action: no action

On Sun, Jan 25, 2026 at 12:34:55AM -0800, Ethan Nelson-Moore wrote:
> It violates kernel code style guidelines to define typedefs for
> non-opaque types. Update rtl8150 to conform to these guidelines by
> expanding the rtl8150_t typedef. Also remove a few extra spaces after
> the * in pointer declarations to adhere to kernel code style.
> 
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> ---
>  drivers/net/usb/rtl8150.c | 68 +++++++++++++++++++--------------------
>  1 file changed, 33 insertions(+), 35 deletions(-)
> 
> diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
> index e40b0669d9f4..142bd468b2a3 100644
> --- a/drivers/net/usb/rtl8150.c
> +++ b/drivers/net/usb/rtl8150.c
> @@ -144,8 +144,6 @@ struct rtl8150 {
>  	u8 phy;
>  };
>  
> -typedef struct rtl8150 rtl8150_t;
> -
>  struct async_req {
>  	struct usb_ctrlrequest dr;
>  	u16 rx_creg;
> @@ -158,14 +156,14 @@ static const char driver_name [] = "rtl8150";
>  **	device related part of the code
>  **
>  */
> -static int get_registers(rtl8150_t * dev, u16 indx, u16 size, void *data)
> +static int get_registers(struct rtl8150 *dev, u16 indx, u16 size, void *data)

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#clean-up-patches

  Netdev discourages patches which perform simple clean-ups, which are
  not in the context of other work. For example:

  Addressing checkpatch.pl, and other trivial coding style warnings

  Addressing Local variable ordering issues

  Conversions to device-managed APIs (devm_ helpers)

  This is because it is felt that the churn that such changes produce
  comes at a greater cost than the value of such clean-ups.

These patches are getting into this territory. If you have these
devices in your hand, and are going to add new features, when we might
accept them as part of a bigger patchsets. Otherwise we are likely to
reject them, they are just pointless churn.

     Andrew


