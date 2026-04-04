Return-Path: <netdev+bounces-275323-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lC1iCk2v0Gnm+wYAu9opvQ
	(envelope-from <netdev+bounces-275323-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 08:27:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DC139A1F7
	for <lists+netdev@lfdr.de>; Sat, 04 Apr 2026 08:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6C813018BDB
	for <lists+netdev@lfdr.de>; Sat,  4 Apr 2026 06:27:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2444B37702B;
	Sat,  4 Apr 2026 06:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="eS25IqI7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00583376490;
	Sat,  4 Apr 2026 06:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775284042; cv=none; b=SHklDf4hLms4vkxU8b1REJM+n67VYmJt8fx5X6VB1RNY9lCMt468osKTdU0sHhFWp1HVTeF0MI0FFVql6332xYBhEJcI2xaG9nnYanY0o5KMbRwlsFBHh0UivhPgJWm2aUfJndhDhR65+y14v0vBf363qaKdJb2TPqLWv7fHCgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775284042; c=relaxed/simple;
	bh=bunaKKoOIroUL7wg9Yyer32hEEY8Vk14GWbxkhxtkKY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J15CShSkvXqME1NuUy+2vNiqUW9aPBOHXUe5VdNNe+A0M2eVaohn8bJJIlh+HAA4XmJYgAqxCgEH8sbA0KdDmTRWu7kejUJdFn1xSHy9q9QugYC17UXHGjMWEeIwJRjs1FigtkDrOwxAsPjbUES8Aghj+vn8w3SdAhKfvQHvfD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=eS25IqI7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FE2C19423;
	Sat,  4 Apr 2026 06:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775284041;
	bh=bunaKKoOIroUL7wg9Yyer32hEEY8Vk14GWbxkhxtkKY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eS25IqI783pq1ol1St7L0uP2C2mQd6sEUhM291Qca3BVJS8aCOnBZPLI6TmgkY+TE
	 Vg+t/AhhKerwKSpgT5AZgmrLCqnqBgH0HgLCe+s8gvtbMjZ59I2x+jgnzWam1TXJ8A
	 QeoeBZ+adfVKZ7Ni3O2uP8WXB4AFFBDKfwLbSAr0=
Date: Sat, 4 Apr 2026 08:27:18 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Jakub Kicinski <kuba@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-usb@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chih Kai Hsu <hsu.chih.kai@realtek.com>
Subject: Re: [PATCH net-next v6 0/2] r8152: Add support for the RTL8157 5Gbit
 USB Ethernet chip
Message-ID: <2026040421-kite-ethanol-2e28@gregkh>
References: <20260402-rtl8157_next-v6-0-a9b77c0931ef@birger-koblitz.de>
 <20260403160608.04f2408b@kernel.org>
 <741bde66-45b7-49e4-88be-7fb1ca8a92df@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <741bde66-45b7-49e4-88be-7fb1ca8a92df@birger-koblitz.de>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-275323-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 65DC139A1F7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 04, 2026 at 05:54:43AM +0200, Birger Koblitz wrote:
> On 04/04/2026 01:06, Jakub Kicinski wrote:
> > On Thu, 02 Apr 2026 10:28:12 +0200 Birger Koblitz wrote:
> > > Add support for the RTL8157, which is a 5GBit USB-Ethernet adapter
> > > chip in the RTL815x family of chips.
> > 
> > no longer applies, please rebase & repost
> It looks like you are letting me play out the story of the hare and the
> hedgehog. If there is no interest in this patch series or you would like
> it to look different, please let me know instead of playing games.

"Does not apply" is not a game, you just need to rebase and resubmit as
others are also doing work on the same driver at the same time, so there
can be some conflicts that it is up to the submitter to resolve.

This is normal kernel development, has always been this way.

thanks,

greg k-h

