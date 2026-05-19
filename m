Return-Path: <netdev+bounces-289355-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6I/DKFEvDGq0XwUAu9opvQ
	(envelope-from <netdev+bounces-289355-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:37:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B20C57B673
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 11:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0E6FD30F0E0B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 09:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C343FE348;
	Tue, 19 May 2026 09:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UcgSaNJf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943D33FF1A9;
	Tue, 19 May 2026 09:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182991; cv=none; b=QuxyM3I66U60aqHj/0qxFxKzkngQX65Upb998GwzwV6adPx5h14kJDMo3/iJX3qTj23RQQcecaauyv7vHzHo+xUYgrBCzS8h5TP49qmMtKIwfMODwubePMnKeNdpDGQfdcWrLVdSfBqjN3/BCeQGo5eVPhiCEShAUJtNRr669aE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182991; c=relaxed/simple;
	bh=1u7x2hlE1dD/7VNDsuaAqteW7Dvl6KAE1OwpAj3bWZM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nL2Qqx3jyRzR8IFs71kG/JvA97XI4nBTz8ciqZZfFx3iUO9N0EiL8O2UDaedmyHmhh0snztUkhxieLdSGzQaS79GTtS5tzfhEAKqdvdsPAF+AvkNYdX8ErPfE3MsUWKKkfJssxKq/LBFwSQH9/om35UUujMAPULhPHQDdH1aRO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UcgSaNJf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93E6BC2BCB3;
	Tue, 19 May 2026 09:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1779182991;
	bh=1u7x2hlE1dD/7VNDsuaAqteW7Dvl6KAE1OwpAj3bWZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UcgSaNJfftqqNGafZk/wOGANnlNQ+Zq9rbMz/nu6+16otToOJCyfq7+P6h1A+BEoc
	 DQ6AS4piw7VJJi0q1o/QGMKwrPHdQXaO5T2uEsJOJUWXIw0cduUjlQR0I7nSlW3yMS
	 yUQ4awMS80NZ3aoOlD9V7nZsfmvm5KvVYbw3/sJI=
Date: Tue, 19 May 2026 11:29:03 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Ivanl S <shaoxul@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Add power management op for RNDIS host
Message-ID: <2026051950-tacky-dexterity-e7a4@gregkh>
References: <CANwjiYaL1WLBoPxy6QrhpXOUef_P6q-RHwE5EvFHU0AdPUs+cA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANwjiYaL1WLBoPxy6QrhpXOUef_P6q-RHwE5EvFHU0AdPUs+cA@mail.gmail.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289355-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 1B20C57B673
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 03:28:14PM +0800, Ivanl S wrote:
> >From bf417c9c1c22f8d335ec361d6fb5759fd167733a Mon Sep 17 00:00:00 2001
> >From bf417c9c1c22f8d335ec361d6fb5759fd167733a Mon Sep 17 00:00:00 2001
> From: Shaoxu Liu <shaoxu.liu@telit.com> Date: Tue, 19 May 2026
> 13:49:06 +0800 Subject: [PATCH] Add power management op for RNDIS host
> RNDIS host does not manage the USB power, and it will cause more power
> consumption even when no data transferring. Adding the power
> management operator will make the USB enter suspend mode when no data
> transferring. --- drivers/net/usb/rndis_host.c | 16 ++++++++++++++++ 1
> file changed, 16 insertions(+) diff --git
> a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c index
> 7b3739b29..76eb65fd5 100644 --- a/drivers/net/usb/rndis_host.c +++
> b/drivers/net/usb/rndis_host.c @@ -630,6 +630,17 @@ static const
> struct driver_info zte_rndis_info = { .tx_fixup = rndis_tx_fixup, };
> +static const struct driver_info rndis_info_lowpower = { +
> .description = "RNDIS device", + .flags = FLAG_ETHER |
> FLAG_POINTTOPOINT | FLAG_FRAMING_RN | FLAG_NO_SETINT, + .bind =
> rndis_bind, + .unbind = rndis_unbind, + .status = rndis_status, +
> .rx_fixup = rndis_rx_fixup, + .tx_fixup = rndis_tx_fixup, +
> .manage_power = usbnet_manage_power, +}; +
> /*-------------------------------------------------------------------------*/
> static const struct usb_device_id products [] = { @@ -657,6 +668,11 @@
> static const struct usb_device_id products [] = { /* RNDIS is MSFT's
> un-official variant of CDC ACM */ USB_INTERFACE_INFO(USB_CLASS_COMM, 2
> /* ACM */, 0x0ff), .driver_info = (unsigned long) &rndis_info, +}, { +
> /* RNDIS for Telit Cinterion low power LTE cat1biz modules LE310X1*/ +
> USB_DEVICE_AND_INTERFACE_INFO(0x1bc7, 0x7030, +
> USB_CLASS_WIRELESS_CONTROLLER, 1, 3), + .driver_info = (unsigned
> long)&rndis_info_lowpower, }, { /* "ActiveSync" is an undocumented
> variant of RNDIS, used in WM5 */ USB_INTERFACE_INFO(USB_CLASS_MISC, 1,
> 1), -- 2.25.1 Signed-off-by: Shaoxu Liu <shaoxul@gmail.com>
> 

Hi,

This is the friendly patch-bot of Greg Kroah-Hartman.  You have sent him
a patch that has triggered this response.  He used to manually respond
to these common problems, but in order to save his sanity (he kept
writing the same thing over and over, yet to different people), I was
created.  Hopefully you will not take offence and will fix the problem
in your patch and resubmit it so that it can be accepted into the Linux
kernel tree.

You are receiving this message because of the following common error(s)
as indicated below:

- Your patch is malformed (tabs converted to spaces, linewrapped, etc.)
  and can not be applied.  Please read the file,
  Documentation/process/email-clients.rst in order to fix this.

If you wish to discuss this problem further, or you have questions about
how to resolve this issue, please feel free to respond to this email and
Greg will reply once he has dug out from the pending patches received
from other developers.

thanks,

greg k-h's patch email bot

