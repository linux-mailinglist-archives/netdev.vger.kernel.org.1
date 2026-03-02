Return-Path: <netdev+bounces-262557-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kC9DIIhKpWn17wUAu9opvQ
	(envelope-from <netdev+bounces-262557-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 09:30:00 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 036EB1D4A55
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 09:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 81098300C9A6
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 08:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838A3379EFB;
	Mon,  2 Mar 2026 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fXBo/Dig"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60178350D74;
	Mon,  2 Mar 2026 08:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772440150; cv=none; b=QUHhC0Hx1Y816TfWFJ/zIi2EY2tNNh+cqdr6RarkXKhyhYaJ4J6zAznXGi+D/8jbqJr81vb06FlpfbuIQrmu4Y0AJSzDdDjrJ/P1ZdJWJ90trcFa4vT25Eeo0g3sseufcvxuECxGAO15ds90dOcG9U2U4UgeLSht5T6ltEQPodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772440150; c=relaxed/simple;
	bh=XgmEFlrgoVM5GMVUfVwni7U+ozETMqLPAUtrEhHKUlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DrpCgwViu/3IJ9QXfuV339hWiICLymZvtvNxDJKyynyVg1ji6Hy6YaDt5oOtH7KzTeGIy2jUP8nEI9zDAiRRCn9tDKyk1+GG0nZInjeMau3Pk2iWBx3H5yIaTo3n2PZ7evCLpb5xImMzZsygkRFT2AkB1N7uRdYgg9DZBTo5Ok4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fXBo/Dig; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7F0C19423;
	Mon,  2 Mar 2026 08:29:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772440150;
	bh=XgmEFlrgoVM5GMVUfVwni7U+ozETMqLPAUtrEhHKUlg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fXBo/DigZu51VHzi2LFmo685MmuAj62mJplY7NnjAVeOMa8YFM+xe3BF49g2gCzXF
	 33uHVS6tcWYQUpips0r9N0PoCgGFxV+T8bDd/12fwPFJvYzM3r//mGnKLc3Uux0Zml
	 Wj7MBPazyYZ1B1/qbnlxRP+oajV/QzuV1vH6ZQzaqTcBGCBXia2gW4qW5L1FYOMkiP
	 E4+rj78K10ii+E7D0VEtSSjDVbQuiMgfTOVJZSjYBpUQNN5JtmQA1laMpEsTYyF5N1
	 cMwY9zJoIlDfT2sIhwPN4VhgkbJjrWnmxkswgx7O4uuUbuK3omFLaqXDxLOz9n4Kb9
	 5hleWfv6hGlIg==
Date: Mon, 2 Mar 2026 08:29:06 +0000
From: Simon Horman <horms@kernel.org>
To: tobgaertner <tob.gaertner@me.com>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, oneukum@suse.com, bjorn@mork.no
Subject: Re: [PATCH] net: usb: cdc_ncm: add ndpoffset to nframes bounds check
Message-ID: <aaVKUp4pDjfo5EYm@horms.kernel.org>
References: <20260227072241.566212-1-tob.gaertner@me.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260227072241.566212-1-tob.gaertner@me.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262557-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[me.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[me.com:email,horms.kernel.org:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 036EB1D4A55
X-Rspamd-Action: no action

On Thu, Feb 26, 2026 at 11:22:41PM -0800, tobgaertner wrote:
> From: Tobi Gaertner <tob.gaertner@me.com>
> 
> cdc_ncm_rx_verify_ndp16() and cdc_ncm_rx_verify_ndp32() validate that
> the NDP header and its DPE entries fit within the skb. The first check
> correctly accounts for ndpoffset:
> 
>   if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp16)) > skb_in->len)
> 
> but the second check omits it:
> 
>   if ((sizeof(struct usb_cdc_ncm_ndp16) +
>        ret * (sizeof(struct usb_cdc_ncm_dpe16))) > skb_in->len)
> 
> This validates the DPE array size against the total skb length as if
> the NDP were at offset 0, rather than at ndpoffset. When the NDP is
> placed near the end of the NTB (large wNdpIndex), the DPE entries can
> extend past the skb data buffer even though the check passes.
> cdc_ncm_rx_fixup() then reads out-of-bounds memory when iterating
> the DPE array.
> 
> Add ndpoffset to the nframes bounds check in both the NDP16 and NDP32
> verification functions.
> 
> Found by coverage-guided fuzzing with QEMU system-mode emulation.
> 
> Fixes: ff06ab13a4cc ("net: cdc_ncm: splitting rx_fixup for code reuse")

Hi Tobi,

I think the tag above covers the ndp16 case.
But that it would be appropriate to also have the following tag
for the ndp32 case.

Fixes: 0fa81b304a79 ("cdc_ncm: Implement the 32-bit version of NCM Transfer Block")

Which does make me lean towards a patchset with two patches.

> Signed-off-by: Tobi Gaertner <tob.gaertner@me.com>
> ---
>  drivers/net/usb/cdc_ncm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/usb/cdc_ncm.c b/drivers/net/usb/cdc_ncm.c
> index 5d123df0a..39d2ad95d 100644
> --- a/drivers/net/usb/cdc_ncm.c
> +++ b/drivers/net/usb/cdc_ncm.c
> @@ -1675,7 +1675,7 @@ int cdc_ncm_rx_verify_ndp16(struct sk_buff *skb_in, int ndpoffset)
>  					sizeof(struct usb_cdc_ncm_dpe16));
>  	ret--; /* we process NDP entries except for the last one */
>  
> -	if ((sizeof(struct usb_cdc_ncm_ndp16) +
> +	if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp16) +
>  	     ret * (sizeof(struct usb_cdc_ncm_dpe16))) > skb_in->len) {

Perhaps out of scope for a strict bug fix. But I think this can be
expressed more succinctly using struct_size_t and fewer parentheses.
(compile tested only!)

	if (ndpoffset + struct_size_t(struct usb_cdc_ncm_ndp16,
				      dpe16, ret) > skb_in->len) {


>  		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);
>  		ret = -EINVAL;
> @@ -1711,7 +1711,7 @@ int cdc_ncm_rx_verify_ndp32(struct sk_buff *skb_in, int ndpoffset)
>  					sizeof(struct usb_cdc_ncm_dpe32));
>  	ret--; /* we process NDP entries except for the last one */
>  
> -	if ((sizeof(struct usb_cdc_ncm_ndp32) +
> +	if ((ndpoffset + sizeof(struct usb_cdc_ncm_ndp32) +
>  	     ret * (sizeof(struct usb_cdc_ncm_dpe32))) > skb_in->len) {

Likewise here.

>  		netif_dbg(dev, rx_err, dev->net, "Invalid nframes = %d\n", ret);
>  		ret = -EINVAL;
> -- 
> 2.43.0
> 
> 

