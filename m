Return-Path: <netdev+bounces-258475-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBFhMXkJjmkT+wAAu9opvQ
	(envelope-from <netdev+bounces-258475-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 18:10:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BB4112FD17
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 18:10:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DA78230038CC
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 17:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1608E32936C;
	Thu, 12 Feb 2026 17:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZKQbf7L"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64D924BD1A;
	Thu, 12 Feb 2026 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770916188; cv=none; b=l1MZcVVGufbsmYoinMM79BEX2U8yZWmejY/perjLyzNSyfCqr50gUhnJ3QL4A+edvGePvJK8mC5cFcW3P0LsATOEiDpTJc8c1FiPAD7vR4ErCBHRRXn2Fosq2PpTKlyYzTzW+DWUwBY6KQv1F0qvpI1mhR+EIPbXkmxWWCYv0rE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770916188; c=relaxed/simple;
	bh=XvL3bszcWKQAGzpg+r7vSmv4YSDYnRLiIs+rKNEaoFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EwNacetyrqHcJPVjdFUOa/yljcFDLUkLaWJ3/Cio7JNbwnG4rGhNvh45YdM2E+zIXzhgjL34HdoO+EXLGikR+c62/VfRN4+yWbZk4TjeZfuGFnREtguT6BwI2z9KK/ZuwYwC63mmOTxLHd7M0bmx7XDORvvLeRFqEMF3VukPmSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZKQbf7L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A657AC4CEF7;
	Thu, 12 Feb 2026 17:09:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770916187;
	bh=XvL3bszcWKQAGzpg+r7vSmv4YSDYnRLiIs+rKNEaoFM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iZKQbf7LJrxqemTGrNcsVQio51TXqmm4PzjQUfS56BRbXt9NLhp2w1gOac7lALRu/
	 191GuNrLyzzTqbef/pN6DU449TUDrxaP/OK0YVmEQx0sl3gHOf9Kv6dEVxjMRR70/r
	 Rp7itJy/NfWMfPH0bRgacZkXzNkMi4O93tnaHF0QSDsFmK+mw8I7kVjwDTD99Yq/Wm
	 VRqZoT95PQufRxeyJcGm1gIgFqqcq1tNxnLNrxSrK8w4eCx6zfl2groK3ZTjfjdc8E
	 S5hMGIlqjXdoo6NIHNfh0xfxxeftG1WzaZNIe9ZPq22e5E3sofE8GkFE/SB8HxOz6F
	 EhewRzIItYwxQ==
Date: Thu, 12 Feb 2026 17:09:43 +0000
From: Simon Horman <horms@kernel.org>
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: usb: catc: enable basic endpoint checking
Message-ID: <aY4JV-aEInRDHYqW@horms.kernel.org>
References: <20260210024341.3216007-1-n7l8m4@u.northwestern.edu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210024341.3216007-1-n7l8m4@u.northwestern.edu>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258475-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid,northwestern.edu:email]
X-Rspamd-Queue-Id: 4BB4112FD17
X-Rspamd-Action: no action

On Tue, Feb 10, 2026 at 02:43:41AM +0000, Ziyi Guo wrote:
> catc_probe() fills three URBs with hardcoded endpoint pipes without
> verifying the endpoint descriptors:
> 
>   - usb_sndbulkpipe(usbdev, 1) and usb_rcvbulkpipe(usbdev, 1) for TX/RX
>   - usb_rcvintpipe(usbdev, 2) for interrupt status
> 
> A malformed USB device can present these endpoints with transfer types
> that differ from what the driver assumes.
> 
> Add usb_check_bulk_endpoints() and usb_check_int_endpoints() calls
> after usb_set_interface() to verify endpoint types before use, rejecting
> devices with mismatched descriptors at probe time.
> 
> Similar to
> - commit 90b7f2961798 ("net: usb: rtl8150: enable basic endpoint checking")
> which fixed the issue in rtl8150.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
> ---
>  drivers/net/usb/catc.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/net/usb/catc.c b/drivers/net/usb/catc.c
> index 6759388692f8..e92773cbf5f9 100644
> --- a/drivers/net/usb/catc.c
> +++ b/drivers/net/usb/catc.c
> @@ -770,6 +770,13 @@ static int catc_probe(struct usb_interface *intf, const struct usb_device_id *id
>  	struct net_device *netdev;
>  	struct catc *catc;
>  	u8 broadcast[ETH_ALEN];
> +	static const u8 bulk_ep_addr[] = {
> +		USB_DIR_OUT | 1,	/* EP 1 OUT (TX) */
> +		USB_DIR_IN | 1,		/* EP 1 IN  (RX) */
> +		0};
> +	static const u8 int_ep_addr[] = {
> +		USB_DIR_IN | 2,		/* EP 2 IN  (interrupt) */

Hi,

I think that it would be good to use an enum instead of the magic
numbers 1 and 2, even if documented inline.

I'm suggesting something similar to what was done in the cited commit.

> +		0};
>  	u8 *macbuf;
>  	int pktsz, ret = -ENOMEM;
>  
> @@ -784,6 +791,14 @@ static int catc_probe(struct usb_interface *intf, const struct usb_device_id *id
>  		goto fail_mem;
>  	}
>  
> +	/* Verify that all required endpoints are present */
> +	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
> +	    !usb_check_int_endpoints(intf, int_ep_addr)) {
> +		dev_err(dev, "Missing or invalid endpoints\n");
> +		ret = -ENODEV;
> +		goto fail_mem;
> +	}
> +
>  	netdev = alloc_etherdev(sizeof(struct catc));
>  	if (!netdev)
>  		goto fail_mem;
> -- 
> 2.34.1
> 
> 

