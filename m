Return-Path: <netdev+bounces-267239-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGgDKNxYs2kRVQAAu9opvQ
	(envelope-from <netdev+bounces-267239-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:22:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F14E427B90B
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 01:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9566E3061AEA
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 00:22:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA7828DB49;
	Fri, 13 Mar 2026 00:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gq9nHXeu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEAC52853EE
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 00:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773361369; cv=none; b=g57gGa6jX5btOqMkuhIliVq9OfscR+2YUhz5/LVCyAFasgZ5zqWLLS6QhoBnFGuoZA3i8R5emyUfct7nuW1xmT8bDD4AN4g4IGAJkPl756zp6rngA2MC82j2ys8ctox2Wo0uYFldE9cItblf3arZV2VaEg8OfTRh4bpA9J2LElc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773361369; c=relaxed/simple;
	bh=wI1M2N3RZJ2ZGEFBVZ0oz+Ohx1k+qHSBfOqMj5JSSV4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mu+Bb+iLqI9m72uWGiqfjK+VfMV2gNSpEt2YmBmzfY+50o178KKaRRFElTp/MeuBOSOrAmKoF810gX257IFjtYoGHZGyuZAmPKZFOnl7WldM4q3ujnKBrqkdiEnM6A50+1OrgOwlZ/Q8Z3/9Z09S/7jMthWGIHj1KQSvwMnzMuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gq9nHXeu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2455FC4CEF7;
	Fri, 13 Mar 2026 00:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773361369;
	bh=wI1M2N3RZJ2ZGEFBVZ0oz+Ohx1k+qHSBfOqMj5JSSV4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gq9nHXeu+kEHaXkEFRtydIr1EtZQSG7QgbgG215lIgYebbhnpVIuXvY1VhlnK1bDq
	 IzZIR4Poy9LRkeBH7U2Eb6vXo6G6XYXQailY5puZOY9d+Byq07nfffRyh6bLSOaE1D
	 dYHVmdANm2v8xvZQhLo+zOMjQP6u0SXElZcDvyMVZROyKlL808xB1sPvUjHxyszUBY
	 t4bQSmaYWFIdLKiosStIwC+v/s9xbpeAgKayhr7jwPM6CAptO4X3Ljbkhfcg+hvL0E
	 I0EfKtAbFFaCxNK3+gvCbb2NT9LhrpLg4LHmGTtXHuvi35BCOg3J2dyiv89ubWAAhW
	 SoLtBjMKvVM4Q==
Date: Thu, 12 Mar 2026 17:22:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: airoha: select QDMA block according
 LAN/WAN configuration
Message-ID: <20260312172248.68742f98@kernel.org>
In-Reply-To: <abMsvOMnnuTdoG-9@lore-desk>
References: <20260310-airoha-qdma-lan-wan-mode-v1-1-64ec74dea872@kernel.org>
	<20260312172430.GA1267298@kernel.org>
	<abMsvOMnnuTdoG-9@lore-desk>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267239-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: F14E427B90B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 22:14:36 +0100 Lorenzo Bianconi wrote:
> > Is this a bug fix?
> > If so, perhaps it is for net with a fixes tag.  
> 
> I guess we do not need to target net tree since airoha_eth driver currently
> supports just the LAN interface via the MT7530 DSA switch connected to GDM1
> and there are no WAN interfaces officially supported (PCS/external phy is not
> merged mainline yet, it is only available in OpenWrt).
> 
> > 
> > And at any rate, could you add some description of the before and after
> > behaviour?  
> 
> Theoretically, before this patch, GDM ports were equally distributed between
> QDMA0 and QDMA1 while this patch assigns LAN interfaces to QDMA0 and WAN
> interface to QDMA1. However, for the reason explained above, this change is
> not currently visible to the user.

Please update the commit message. And please try harder to explain 
the patches, this happens a lot with your submissions..

