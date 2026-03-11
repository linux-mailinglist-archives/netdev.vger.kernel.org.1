Return-Path: <netdev+bounces-266670-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAhnGpKEsWmjCwAAu9opvQ
	(envelope-from <netdev+bounces-266670-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:04:50 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C6589265FA3
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 16:04:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C307430465DF
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 14:57:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B26F1F5834;
	Wed, 11 Mar 2026 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="UdiClr4B"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F34326951;
	Wed, 11 Mar 2026 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773241057; cv=none; b=LcYVVFxVaRagyhbRTdn/P4ua37z/kGugdB35qXgeqesbObdbMqZwTfmWphd3gfv/Bzyk8QKZb7piGjV1iUoVU8Ziu00IPE6KcOkXAlmKPQkxSuAojKinpMoKzUuZGoNS1FGTN+BFI9HWnNoOPpX3MclCriwktQq/7b0lCdr9MdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773241057; c=relaxed/simple;
	bh=e6enH1SvGt9bS3H8vRRyGYsOxul1Geog8kvixxnLT3I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pVVd7FNFx3DsBy6tJEWqraCXUZQqHp0pSJr3TkZINfw7UuAlEd2VO29hCbRfk7K+/mt6TqBmbuTbGRVnu1PMm7hy5aOQmtJ/5yMDhEzr+LHrND5VZP4LciHuom2JEJRJtmgpQ7n868n+2wqi76h+BmGPt/tFP+uuWiemVTA+rtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=UdiClr4B; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=nbMjDz6Ajv6xSvXYmB456HfPgEAht61nTIyuU/EkImg=; b=UdiClr4B7nCGlOQl4Plk5yGbwh
	zLGbdnOhrmCBrYOnpSnvesRGPAm7kU9izji71GHSO8OAQjna54BNJi37ckHcIAH6rMiP434SBvXqI
	3AK3r+dmsGw1OQFIwG3lPvnmyD00/I0hhOM341kBvWZaiBQEc/kepNApG4N1/Wp2HJcg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w0Kzp-00BCD4-GF; Wed, 11 Mar 2026 15:57:13 +0100
Date: Wed, 11 Mar 2026 15:57:13 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: Re: [PATCH net-next 02/15] net: stmmac: helpers for filling
 tx_q->tx_skbuff_dma
Message-ID: <98307b59-c22d-43a6-83a6-ff551941898e@lunn.ch>
References: <abE7LWj04-JNxgS2@shell.armlinux.org.uk>
 <E1w0GEg-0000000CiSj-2CVA@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1w0GEg-0000000CiSj-2CVA@rmk-PC.armlinux.org.uk>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266670-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[lunn.ch:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,kernel];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]
X-Rspamd-Queue-Id: C6589265FA3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 09:52:14AM +0000, Russell King (Oracle) wrote:
> Add helpers to fill in the transmit queue metadata to ensure that all
> entries are initialised when preparing to transmit. This avoids clean
> up code running into surprises.
> 
> For example, stmmac_clean_desc3() (which calls clean_desc3() in
> chain_mode.c or ring_mode.c) looks at the .last_segment, and in the
> latter case, .is_jumbo members.
> 
> stmmac_tso_xmit() was also a problem. If the metadata is not fully
> cleared when cleaning dirty entries (or, in the case of resume,
> freeing all entries) then .last_segment may be left set, which then
> causes:
> 
>         stmmac_prepare_tso_tx_desc(priv, first, 1, proto_hdr_len, 0, 1,
>                                    tx_q->tx_skbuff_dma[first_entry].last_segment+,
>                                    hdr / 4, (skb->len - proto_hdr_len));
> 
> to mark the

That sentence appear to be unfinished.

	Andrew

