Return-Path: <netdev+bounces-264586-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLZ4BaQVqmnpKwEAu9opvQ
	(envelope-from <netdev+bounces-264586-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:45:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61951219764
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 00:45:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BED5530086CC
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 23:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FDEC364E85;
	Thu,  5 Mar 2026 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HOAX+5MK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA1E35AC23;
	Thu,  5 Mar 2026 23:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772754103; cv=none; b=iIfJ8KGCgEZ06oz5ljr17EsFIqXVmW8FXN1O1ggBneVow0yWgLUEW5I3N6hc94cITipj75Zxgb3840bWYtBNmw31pb9rXF101o9vwQykP9LC2S9QFHY40qBkdt0c2UPg/s3b/AJPDZ1B3UWg3nfidD+nNmlDXQ7x5wVxd904ayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772754103; c=relaxed/simple;
	bh=3mYIpFo0Oo9G4Ia1Fic/4VIkiyuuIbuMW1gFosKJwAE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rfaQJylpF8ws7Cw1XFRyqVJk8ekvo6XQ8IR5Q3T28pXhVWPZ6qORJvzbfHPakJU0EpOPaOsj6/tcPXxw5ELVofqk8Tai2LqfO0ugiAIHL2b6NEJvwY3VEBiEk0tLgXT3i350fbHIU7UY+cpLsyTXESDYhBQVccesU4UcaKkT1bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HOAX+5MK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73B19C116C6;
	Thu,  5 Mar 2026 23:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772754103;
	bh=3mYIpFo0Oo9G4Ia1Fic/4VIkiyuuIbuMW1gFosKJwAE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HOAX+5MKIvsBrth9KtbSjUcir6c1BDkuA3jaDLHujGubMYWJvQR7VrhHaiPGJJt/V
	 004gqMMxTh8DQ1BPipczPDeypmfLZHyooXRTftyjJk6MDYANCsve/BDhVIFy0ER2+j
	 MmO9xUVyVgyeMIuNJis7CkVyl/1Vq3IrLWe1IzfJz31IRDvnY7uVBZnwQD3y5kwSMw
	 bpZ+yaCjruc+6lBBiHgTRBQZoQJ21cDTDPWAFVfyDsAFLRFw65Lj8jeNEmFVQmsc9Z
	 vL5zLLW0uiuMahVOrApe43H1SKbdbC/iJf2GhEAIxqLaSCjLjnMSOyveBRr+VjA+IA
	 edgUazaKLt0eQ==
Date: Thu, 5 Mar 2026 17:41:40 -0600
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Damien Dejean <dam.dejean@gmail.com>
Cc: linux-kernel@vger.kernel.org, edumazet@google.com, davem@davemloft.net,
	maxime.chevallier@bootlin.com, devicetree@vger.kernel.org,
	pabeni@redhat.com, kuba@kernel.org, hkallweit1@gmail.com,
	andrew@lunn.ch, krzk+dt@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v6 1/4] dt-bindings: net: ethernet-phy: add property
 enet-phy-pair-order
Message-ID: <177275410010.792767.11856213263031089510.robh@kernel.org>
References: <20260207092539.647768-1-dam.dejean@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260207092539.647768-1-dam.dejean@gmail.com>
X-Rspamd-Queue-Id: 61951219764
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264586-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,davemloft.net,bootlin.com,redhat.com,kernel.org,gmail.com,lunn.ch];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[robh@kernel.org,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action


On Sat, 07 Feb 2026 10:25:36 +0100, Damien Dejean wrote:
> Add property enet-phy-pair-order to the device tree bindings to define
> the pair order of the PHY. To simplify PCB design some manufacturers
> allow to wire the pairs in a reverse order, and change the order in
> software.
> 
> The property can be set to 0 to force the normal pair order (ABCD), or 1
> to force the reverse pair order (DCBA).
> 
> Signed-off-by: Damien Dejean <dam.dejean@gmail.com>
> ---
>  Documentation/devicetree/bindings/net/ethernet-phy.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>


