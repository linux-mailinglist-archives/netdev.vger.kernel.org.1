Return-Path: <netdev+bounces-268632-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFb5IhZnuWmZDwIAu9opvQ
	(envelope-from <netdev+bounces-268632-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:37:10 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CD8C2AC1A1
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 15:37:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2A2883046D34
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 14:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593723E3DA7;
	Tue, 17 Mar 2026 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fU9HzRrT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35841301016
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 14:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773757906; cv=none; b=eDweLVxo0iXiCqEskZUjl9kWuz/xZUaqrtf1G0eecD9nCIRY/BO3vToF/cU5IqaEifNQF1W/90eT/oj3xVaVydIGzaIMfFkJ0VqP27bGnCFI9yOlUOq8TiMBbYVVjVVWUAsMpomKQdHA/IyGAVTqA0tAnCNPCBsjoo8lfTi/37g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773757906; c=relaxed/simple;
	bh=FB0uLOtKw+Ms4Y4cq/DdYMe4SYVdJKlookY5qKPtMyE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dZPT82uC/TJvgWHJqBpv7n5RspvW/9USvnZhQOZPjGf3KaMcPqirJpzD1jxRgC4TX+fUoWH8ZxvjwV25StteYtK8RLZv3E0tRd5JCWG6+JXT6DUewAahiTTS0zyTu31vybcUSTq8MzgD7pqzTYo+44x1us1zO5YHkiAo5RvKXcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fU9HzRrT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10C06C2BCAF;
	Tue, 17 Mar 2026 14:31:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773757905;
	bh=FB0uLOtKw+Ms4Y4cq/DdYMe4SYVdJKlookY5qKPtMyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fU9HzRrTPqZ7cl634CR6s0CEwBEj6S6ljyyq/9cWDIpAP7mafFPvyu6MLv0Yjvk4X
	 hH7zRs254F428Isd7Tps7rp0Gdit+XOWkPlNeD36C0WjrRNQOqKrl2+6ba0RDwqy2O
	 autJJ03bhMv1gF5QzXhABFo6xNjQcUltP9KJttLKtgk/tbgjA4tXLekseVbM8nh3Qf
	 WOxfl+VS4vlSuuL/wZuQJmfvibYTCmAKLV7XESCVE56RNGw7nyghnnZJ98CK9roXJK
	 7z/mEXRm5Dzsr3yBMCn2FHvftMLpVHuJlooiGb4O2ldOmGA9XXJ/TbD1GfVmT+SXNq
	 OyJrCOYfBIQjA==
Date: Tue, 17 Mar 2026 14:31:41 +0000
From: Simon Horman <horms@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: airoha: select QDMA block according
 LAN/WAN configuration
Message-ID: <20260317143141.GA1710951@horms.kernel.org>
References: <20260313-airoha-qdma-lan-wan-mode-v2-1-7d577db6e40c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313-airoha-qdma-lan-wan-mode-v2-1-7d577db6e40c@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268632-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 3CD8C2AC1A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 05:28:36PM +0100, Lorenzo Bianconi wrote:
> Before this patch even GDM ports were assigned to QDMA0 while odd GDM
> ports were using QDMA1, so, based on the DTS configuration, both QDMA0
> and QDMA1 can theoretically receive traffic destinated to the host cpu
> from LAN or WAN GDM ports.
> Airoha folks reported the hw design assumes the LAN traffic destinated
> to the host cpu is be forwarded to QDMA0 while traffic received on WAN
> GDM port is managed by QDMA1. For this reason, select QDMA block according
> to the GDM port LAN or WAN configuration:
> - QDMA0 is used for GDM LAN devices
> - QDMA1 is used for GDM WAN device
> 
> Assuming a device with three GDM ports, a typical configuration could be:
> - MT7530 DSA switch -> GDM1 (eth0) -> QDMA0 (LAN traffic)
> - External PHY      -> GDM2 (eth1) -> QDMA1 (WAN traffic)
> - External PHY      -> GDM3 (eth2) -> QDMA0 (LAN traffic)
> 
> We can then bridge eth0 DSA port (lanX) with eth2 since they all tx/rx
> LAN traffic.
> 
> Please note this patch introduces a change not visible to the user since
> airoha_eth driver currently supports just the internal phy available via
> the MT7530 DSA switch and there are no WAN interfaces officially supported
> since PCS/external phy is not merged mainline yet (it will be posted with
> following patches).
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
> Changes in v2:
> - Update commit log.
> - Link to v1: https://lore.kernel.org/r/20260310-airoha-qdma-lan-wan-mode-v1-1-64ec74dea872@kernel.org

Thanks for the update.

Reviewed-by: Simon Horman <horms@kernel.org>


