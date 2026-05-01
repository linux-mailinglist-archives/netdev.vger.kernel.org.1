Return-Path: <netdev+bounces-283312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OKbXJoY89WnzJgIAu9opvQ
	(envelope-from <netdev+bounces-283312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:51:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F261C4B0636
	for <lists+netdev@lfdr.de>; Sat, 02 May 2026 01:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CA560301AD3B
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 23:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22DA2372ED0;
	Fri,  1 May 2026 23:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yua6v27P"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FBB34E771;
	Fri,  1 May 2026 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777679481; cv=none; b=QpktfH8V0GmNng7Ju4p8SEIWMI5YT7E3+ptTqm5g/bel678wVZzFEX5SEGsatJR6LlmG+q+Irxyjz3iJWoqFDD9RhHP1fIlNLGZTbn1er5FIjK6XbcqvSkmOQgvyKSh/ug4uEQN7qGcsmSbE2dXe6CTSuOKXUdxehpS81iC50CQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777679481; c=relaxed/simple;
	bh=z/o5SPBeNCnj8W+pPRlVdKVV1Xv4sidmA4w2XL86RwQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bPhZwYFL74UroFq9RQLPip9Ziq/t7buxGXqPLZ8FnmA+b9oA4qViQj+BPLOiq/sAJg9C/3djVn+gY6PzSQ0XbsrbLb1Nws2DWK9e3WNWCD0sdRNFwXGA1gIPsTfBJs6VwTsIKrvD+iic0L6sZj7tnL0R/8y2CIN8FvVACRb+y5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yua6v27P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C0BC2BCB4;
	Fri,  1 May 2026 23:51:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777679480;
	bh=z/o5SPBeNCnj8W+pPRlVdKVV1Xv4sidmA4w2XL86RwQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Yua6v27P4/7STHTO03XBcavxCGjeau3wgy33Z/JJ6LsqRXIsNb/MMfvYjVB7NdiNq
	 btIDV+qOedNbMiw2/Bei1DD+HnlrDZmonNdmVfCq7yaTAvH0b7WAOhYK5Fi6OefHTE
	 dojSCwTbau4+uZ6aGISeFNGmbKJ2wrivQLr/D/QXY4Ok+oPKgSrEnHhHOYrXPjraM0
	 dDezoLXc0/v868MyLnzXGqG/gV70H/LFyfXkM0DmSxFA8L78S61xh4oOmLjslYz/Ay
	 CkVLC1Twp5/8S5AnHGD1uALCCU5ZtVLWpRNC9pH+A4HHQ+7yq1HD2QvAzj3CAnlrm+
	 jhn/N6czKN7gA==
Date: Fri, 1 May 2026 16:51:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Aleksander Jan Bajkowski <olek2@wp.pl>, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 hayeswang@realtek.com, hsu.chih.kai@realtek.com, kees@kernel.org,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next] net: usb: r8152: add TRENDnet TUC-ET2G v2.0
Message-ID: <20260501165119.2622a2af@kernel.org>
In-Reply-To: <7b3d3fc6-bbed-4a75-ac19-33fa910359c9@birger-koblitz.de>
References: <20260430213435.21821-1-olek2@wp.pl>
	<7b3d3fc6-bbed-4a75-ac19-33fa910359c9@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F261C4B0636
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283312-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[wp.pl,lunn.ch,davemloft.net,google.com,redhat.com,realtek.com,kernel.org,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[birger-koblitz.de:email,wp.pl:email,lunn.ch:email]

On Fri, 1 May 2026 06:03:05 +0200 Birger Koblitz wrote:
> On 30/04/2026 11:34 pm, Aleksander Jan Bajkowski wrote:
> > The TRENDnet TUC-ET2G V2.0 is an RTL8156B based 2.5G Ethernet controller.
> > 
> > Add the vendor and product ID values to the driver. This makes Ethernet
> > work with the adapter.
> > 
> > Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> > Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> >   drivers/net/usb/r8152.c | 1 +
> >   1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> > index 7337bf1b7d6a..1ace1d2398c9 100644
> > --- a/drivers/net/usb/r8152.c
> > +++ b/drivers/net/usb/r8152.c
> > @@ -10138,6 +10138,7 @@ static const struct usb_device_id rtl8152_table[] = {
> >   	{ USB_DEVICE(VENDOR_ID_TRENDNET, 0xe02b) },
> > +	{ USB_DEVICE(VENDOR_ID_TRENDNET, 0xe02c) },
> >     
> You may also add my Reviewed-by: Birger Koblitz <mail@birger-koblitz.de>

Thanks! In the future please make sure you send the Review tags on a
separate line, otherwise our scripts don't pick them up

