Return-Path: <netdev+bounces-288497-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKpaD96jB2rP/QIAu9opvQ
	(envelope-from <netdev+bounces-288497-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:53:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D44CE5591D0
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 00:53:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2FCC03018762
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 22:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99CA8340282;
	Fri, 15 May 2026 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD35Xbkd"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A79405C5F;
	Fri, 15 May 2026 22:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778885151; cv=none; b=CU6WNkv6HakS5I77St0FUDYKCAAROiAZzuu9tC4CbRrBj+ODvyxbbVxwbKgAznjaXM1aO1fvWQgntLETsRfZHCvy522KGU0qo5Xeq2DZn+y9hBOqL1tPryzPL1cw5K0s9roxemwpm/SFSPxaScitbJZnc+8Hbiyi6vcEFxkwLII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778885151; c=relaxed/simple;
	bh=uIau35s5bIEmw6EC+X8vEmauWXOWouZDyj8O9Ysx4Hk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gfs35Bu/oFSau7RDUq/KiZMz7CEh841CyWh552TPe86QI+N/862zl35O87JRlgW6DD+rjvJWQrgoG01WW8Di97+EpGxZfewE5SU0hk88Uyt2q1kgmoDtSvByEgZL4lsjj7eplR2rKGTeUsizbR87XCj0dxs5ibDtqQadhxPVSEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD35Xbkd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7ADC2BCB0;
	Fri, 15 May 2026 22:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778885151;
	bh=uIau35s5bIEmw6EC+X8vEmauWXOWouZDyj8O9Ysx4Hk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YD35XbkdraLWjjJF2eEmG679oOXznOFhFTUbO22eWOAv+RcE5jaOG88AVtGZOTRMP
	 IhCEyRF9n/eGWG+qyLbiD0vYaR7gMD5pEJSeUmt1O+iOsUYbnR8gBcOd1Stg1YSHmX
	 yXRFgoyiaN9FNSW9lkkzqTDFxtCsFfry5wd1kVoD4vmuoFTgCDfkOk5vGYCj8V9Ht9
	 mlE4X8XB3A/vrs4eyC5cNlE+FO2XSou29VPAn5fK5SLMop6FAPudTzfpUytVaRUhTn
	 Ohf8V7fQu3HNerYfEzmlmEN81nbzdExymFP3urjmBU6fjeihQT8UK9JT9HnIAykGqk
	 hHuzNg0wjETRQ==
Date: Fri, 15 May 2026 15:45:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Frank Wunderlich" <frank.wunderlich@linux.dev>
Cc: "Mason Chang" <mason-cw.chang@mediatek.com>, "AngeloGioacchino Del
 Regno" <angelogioacchino.delregno@collabora.com>, netdev@vger.kernel.org,
 "Russell King" <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
 "Andrew Lunn" <andrew+netdev@lunn.ch>, "Eric Dumazet"
 <edumazet@google.com>, linux-mediatek@lists.infradead.org, "Daniel Golle"
 <daniel@makrotopia.org>, "Matthias Brugger" <matthias.bgg@gmail.com>,
 "Paolo Abeni" <pabeni@redhat.com>, "Lorenzo Bianconi" <lorenzo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org, "Felix Fietkau" <nbd@nbd.name>,
 "Frank Wunderlich" <linux@fw-web.de>
Subject: Re: [net-next v8 2/3] net: ethernet: mtk_eth_soc: Add RSS support
Message-ID: <20260515154549.307a61cd@kernel.org>
In-Reply-To: <935a73a6e458b2d4fed2e59192e725483ca62126@linux.dev>
References: <20260509190938.169290-1-linux@fw-web.de>
	<20260509190938.169290-3-linux@fw-web.de>
	<20260513185625.48e69837@kernel.org>
	<935a73a6e458b2d4fed2e59192e725483ca62126@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D44CE5591D0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288497-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[mediatek.com,collabora.com,vger.kernel.org,armlinux.org.uk,lunn.ch,google.com,lists.infradead.org,makrotopia.org,gmail.com,redhat.com,kernel.org,davemloft.net,nbd.name,fw-web.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, 15 May 2026 11:13:05 +0000 Frank Wunderlich wrote:
> > >  We can adjust SMP affinity with the following command:
> > >  echo [CPU bitmap num] > /proc/irq/[virtual IRQ ID]/smp_affinity,
> > >  with interrupts evenly assigned to 4 CPUs, we were able to measure
> > >  an RX throughput of 7.3Gbps using iperf3 on the MT7988. Further
> > >  optimizations will be carried out in the future.
> > >   
> > Would be great to split this up a little more for ease of review.  
> 
> you mean splitting the code into more separate patches or the commit description?

The code, seemed like it should at the very least be split into
multi-queue/napi support (mostly driver changes) vs RSS programming
and config.

