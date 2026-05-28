Return-Path: <netdev+bounces-292835-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cISbM/afGGpAlggAu9opvQ
	(envelope-from <netdev+bounces-292835-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:05:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AA75F7CD7
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 22:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 036E93049713
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DBE740FDA2;
	Thu, 28 May 2026 20:04:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QxqrKBO3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C33339866;
	Thu, 28 May 2026 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779998679; cv=none; b=Oafhe4Ep1P83uZ3Lgvvxi+aPtZ0vg4y+mFuHch1tTXp4TdzvfmBehL5lvEHQc/8q2eBkEzXxNSuXfmz9+VpppclkWsRSSyaJgeMZBTm3KL3j6SipCQ++ac8VDQFbeHkCJB1lozQVniDRAV/LcrQOm45Syxtqppf8Wxc9p1LhsaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779998679; c=relaxed/simple;
	bh=wvzVzBiNNc7pSSiktZyRp3DeDJsrIozwR7fOSJytmMw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s5WwBQtTPbDlX63vwePExr5z1NjdbdvzrwLwAF7aMHbYQuytIjFfCFHJ785sOv1ISDS0x0frr4wi1t927oqA1OUisJtqdOQ8iCDs9c9O98RbSIpI4m+AWg92AYaYIsAtCSVD+KYv7BoWg9n0nBUDRTmv2btAX7jXYkPNtLvjg94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QxqrKBO3; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A9321F00A3A;
	Thu, 28 May 2026 20:04:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779998677;
	bh=WVjZ77WKanlIoER/YuUvLPXIh6A2toQ/kFAdLdwWH6g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QxqrKBO33zRwgngfe8npfS0gioZ/JnMOqrQXJ9uTbSeOiWR0B7dfSKyNf6utog185
	 U+a4fjR18dzGBLffCbtljBwGoaM4XPEI2rb8r16jyV39pNEC9aVSBkiTePpo8bcJWt
	 CAoVXWuNiSNo3ayxqYFIjs5T5uAlz5WU+ovW4pY7XRr0rXWkeSpAIcEtsTs6lMt/Iz
	 2iOYSWlyLEQNscHrctet8rTA7Xd4K9cBACAbXNGkpl9K/Kj/qeMlED2tzOanbcGzL9
	 XCzXRiOp2/OKqYsAwksQx8c258b8CXvGHCdxVmMHpEuvC1jvBJZ4xe7ZtUN0pDcGMC
	 Wyiv24TDeqW3g==
Date: Thu, 28 May 2026 13:04:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>, Lucien Jheng
 <lucienzx159@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, David Miller <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Networking <netdev@vger.kernel.org>, Linux
 Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux Next Mailing List
 <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
Message-ID: <20260528130436.450720f9@kernel.org>
In-Reply-To: <ahhlcK0ufJn0VEzM@sirena.org.uk>
References: <ahhlcK0ufJn0VEzM@sirena.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292835-lists,netdev=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[collabora.com,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B3AA75F7CD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 28 May 2026 16:55:28 +0100 Mark Brown wrote:
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.
> 
> diff --cc drivers/net/phy/air_en8811h.c
> index a86129ce693c2,a42898ae41358..0000000000000
> --- a/drivers/net/phy/air_en8811h.c
> +++ b/drivers/net/phy/air_en8811h.c
> @@@ -260,218 -229,6 +245,31 @@@ static const unsigned long en8811h_led_
>   					      BIT(TRIGGER_NETDEV_RX)          |
>   					      BIT(TRIGGER_NETDEV_TX);
>   
> - static int air_phy_read_page(struct phy_device *phydev)
> - {
> - 	return __phy_read(phydev, AIR_EXT_PAGE_ACCESS);
> - }
> - 
> - static int air_phy_write_page(struct phy_device *phydev, int page)
> - {
> - 	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
> - }
> - 
>  +static int __air_pbus_reg_write(struct mdio_device *mdiodev,
>  +				u32 pbus_reg, u32 pbus_data)
>  +{
>  +	int ret;
>  +
>  +	ret = __mdiobus_write(mdiodev->bus, mdiodev->addr, AIR_EXT_PAGE_ACCESS,
>  +			      upper_16_bits(pbus_reg));
>  +	if (ret < 0)
>  +		return ret;

Unclear to me why this is using __mdiobus_write() instead of __phy_write
when the callers have access to the phydev..

Our PR to Linus is now out, hopefully he pulls soon.
The AIR_EXT_PAGE_ACCESS define is no longer visible in air_en8811h.c

Louis, I'm going to move the define to the header to keep the merge
simple. Could you follow up with a cleanup once Linus pulls and I push
out the merge? Or if you prefer another resolution just show me a diff.
If I get it before Linus pulls I'll use it.

