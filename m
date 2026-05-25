Return-Path: <netdev+bounces-291354-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kD+aGO1qFGoTNQcAu9opvQ
	(envelope-from <netdev+bounces-291354-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:29:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C676D5CC47E
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 17:29:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D27D3028134
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 15:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCFE3F4117;
	Mon, 25 May 2026 15:28:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J7d9Nt7d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB51A2C21EE;
	Mon, 25 May 2026 15:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779722934; cv=none; b=ODcVaV45Bit+x4SPcJRUYo3RpSkVTGWsdjVrN+/ph/bWa+voGfVY4PqfFXbyjpy0v9MU69u8wALWizikvNTZ09Iu2iOC5jWgTLf3zaj1oNtB8ohUaAHuOqQ3J6tlRyGnpvgI6nmqpVrxeUw4ZeqaTJPZ4ziG20BxmG8RCbHrG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779722934; c=relaxed/simple;
	bh=eUM6zTmqs8wyeJJuZAB2rN9RZeqoVBWYgWNLEpArwVo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FIM0L1oF4G+b2FUm/uMYrW4AOPLfwjG7f3v847asdFRfQAVdCJNtl45huwvIcZjpIvFMOJJB1tL5g+07JzrBCEqSV18t2V/R7V0mysG02+5Gw0AMoWTpykUq/RcfcjecVUrlm+oWLyCOef9e3MnIHj4ytPGl1/jT/a8fO0xt93c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J7d9Nt7d; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E3F81F000E9;
	Mon, 25 May 2026 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779722932;
	bh=L7Os4s2IEuxuriK9SstbnqCyxryE75fG4oDhRKfyRQ0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J7d9Nt7deToD+0JArcSe6D/WQ30cExBmwO8G+hjU4HwPlMuidVbSufI2Q9q0Tl3g6
	 XUP1tarwDa2XAR8KEydzGbSJDVoXMjXTDxrHa5mpQkmdP8RfMSZ3g1xSNTu3uq3FFV
	 3Dnmc136VKn/fBnRkjaZIVZTK59mEO3CZ9iI2uOd6/i4f7adZKl3W23JUfWWUQRoPy
	 5pqwai6cS3O22Tx8y3G1TBBih4lpnnr6T6gnoOr+zQ1y6ARiFMfJ9j6XNrQiBGQIeb
	 weTLvh2zz4OTMRb4qDrBxBjvQ2KwXXIiWh5YgMzejn5cJrE01VUJQITdAP2BlVaMff
	 Ac1nMwk3xdc6A==
Date: Mon, 25 May 2026 08:28:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Frank Wunderlich (linux)" <linux@fw-web.de>
Cc: Vladimir Oltean <vladimir.oltean@nxp.com>, Alexander Couzens
 <lynxis@fe80.eu>, Daniel Golle <daniel@makrotopia.org>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Matthias
 Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
 <angelogioacchino.delregno@collabora.com>, Frank Wunderlich
 <frank-w@public-files.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org
Subject: Re: [RFC net PATCH v1] net: pcs: pcs-mtk-lynxi: fix bpi-r3 serdes
 configuration
Message-ID: <20260525082851.6840b4dd@kernel.org>
In-Reply-To: <64b40fbee19dc108752574419a38bcfc@fw-web.de>
References: <20260409133344.129620-1-linux@fw-web.de>
	<20260409215509.si2dy63seo4iaspa@skbuf>
	<64b40fbee19dc108752574419a38bcfc@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-291354-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nxp.com,fe80.eu,makrotopia.org,lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,redhat.com,collabora.com,public-files.de,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,public-files.de:email]
X-Rspamd-Queue-Id: C676D5CC47E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 25 May 2026 12:07:33 +0200 Frank Wunderlich (linux) wrote:
> Am 2026-04-09 23:55, schrieb Vladimir Oltean:
> > On Thu, Apr 09, 2026 at 03:33:42PM +0200, Frank Wunderlich wrote:  
> >> From: Frank Wunderlich <frank-w@public-files.de>
> >> 
> >> Commit 8871389da151 introduces common pcs dts properties which writes
> >> rx=normal,tx=normal polarity to register SGMSYS_QPHY_WRAP_CTRL of 
> >> switch.
> >> This is initialized with tx-bit set and so change inverts polarity
> >> compared to before.
> >> 
> >> It looks like mt7531 has tx polarity inverted in hardware and set 
> >> tx-bit
> >> by default to restore the normal polarity.
> >> 
> >> Till this patch the register write was only called when 
> >> mediatek,pnswap
> >> property was set which cannot be done for switch because the fw-node 
> >> param
> >> was always NULL from switch driver in the mtk_pcs_lynxi_create call.
> >> 
> >> Do not configure switch side like it's done before.
> >> 
> >> Fixes: 8871389da151 ("net: pcs: pcs-mtk-lynxi: deprecate 
> >> "mediatek,pnswap"")
> >> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
> >> ---  
> > 
> > Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>  
> 
> just a gentle ping as i still not see this in torvalds/master.
 
You posted it as RFC, patchwork treats RFC as "no action required".
Since the posting is now >1mo old, please resend without the RFC tag?

