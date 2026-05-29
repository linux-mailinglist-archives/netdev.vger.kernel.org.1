Return-Path: <netdev+bounces-292922-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHQ0ItXpGGruoggAu9opvQ
	(envelope-from <netdev+bounces-292922-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:20:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA825FBF48
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 03:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 446C93037DFB
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 01:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D043F352039;
	Fri, 29 May 2026 01:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="32FPv2Mb"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94BEA1C5F1B;
	Fri, 29 May 2026 01:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780017361; cv=none; b=efdla5unTmzJBhLWbebhu37ib6TvL+kAdeJd8y3L1ezq52tiOfbZemkukiuaVtcObzfIrDXE+E3Ald9wxlP/cNZ1Gg40lxf4RE27ZJ4fX4tjQ5gnwWy9OPzzr8liwWtaP9OHfiFcb6S1FZT0Xd1GOZoXfK1RdK7l93id57NY8Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780017361; c=relaxed/simple;
	bh=rb4w63BwoSYmi89J6103rq64I2/SR34d+lAC1H3gZPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pOmyrQLxVLscggPEd1e+gF2Zh8D1Pg9nV2rqvxriOXI7r6ubHZXplmRWU7rbZX9hETJMLZDJWH46yG8DUaJgDoTvG54eHe8E1GgdFQtgTCsxkgSpuEg+2SfyfMeQ99u8LNV9mptBUO5AM/TSC4xb11MqRY4pv+yO8oeAWRxxsgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=32FPv2Mb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y8Lvg/k5gcIsBpvvvdWQHmEfBgOI5AD8qfR2wVx8SVY=; b=32FPv2MbHJzYrPQF5ThDuQJ74s
	o5a9VpplTNI+JIxwgZYaqAWth7LipwU/IFemJtFWNrSn/B2WlQA9agjSpJVKYsxvSvB4y7UQ0U0r6
	hLLYtzpWSzof4WRsCe88xnqsoe/3MtNKorxg4Ayhedog8+V9+SF9gv8hNdaBG5bcJEHo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wSlpF-004zPk-Ee; Fri, 29 May 2026 03:15:49 +0200
Date: Fri, 29 May 2026 03:15:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: John Crispin <john@phrozen.org>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 1/4] net: dsa: mxl862xx: store firmware
 version for feature gating
Message-ID: <51871650-19c0-4108-a461-82ed5821ea4b@lunn.ch>
References: <cover.1779849840.git.daniel@makrotopia.org>
 <de7b70b32aea5ec4a2715fd5c3d72a768672d06e.1779849840.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <de7b70b32aea5ec4a2715fd5c3d72a768672d06e.1779849840.git.daniel@makrotopia.org>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[phrozen.org,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-292922-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,lunn.ch:email,lunn.ch:mid,lunn.ch:dkim,makrotopia.org:email]
X-Rspamd-Queue-Id: DBA825FBF48
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 03:47:58AM +0100, Daniel Golle wrote:
> Query the firmware version at init (already done in wait_ready),
> cache it in priv->fw_version, and provide MXL862XX_FW_VER_MIN()
> for version-gated code paths throughout the driver.
> 
> MXL862XX_FW_VER() packs major/minor/revision into a u32 with
> bitwise shifts so that versions compare with natural ordering,
> independent of host endianness.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

