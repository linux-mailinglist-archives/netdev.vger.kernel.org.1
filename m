Return-Path: <netdev+bounces-270609-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMxFDF52wWkQTQQAu9opvQ
	(envelope-from <netdev+bounces-270609-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:20:30 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C0C72F9BE5
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 18:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 01FBD301CC41
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FDDC3BE64A;
	Mon, 23 Mar 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UFA+rLkV"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E13BE63F;
	Mon, 23 Mar 2026 16:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283216; cv=none; b=Sp7DvINyvCs2wMfUFzYrZyQM+oTBcvHvjJViAUln21Or1xHJpTsudnLwO0DjhOORbox3yGX1E/mNBEv25AMsczyvSzZp79E66GWiTRfhNrwBFY8p7CqWshspjOfBrcQhujL/f1OzN0TB8VoQHzfMAl2aRT3E4O1nhRW+gFWvNS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283216; c=relaxed/simple;
	bh=yvvnk8L0cI2hlcKK9JJuYOByfrm/Vw6Bgw9bTa2StmI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/UzXSG09/Sz7p+FJe1UnCYbw8zEv/VxLCsfIEXEOqpfRdKBdeRiZ9QdvYZntEfYA6lXDb6j2aYylUBynFS076R7M8zj3Cy0F+8Zg3LDZYTJ+ATvDB/IFCwdtfa0u0ejtXkv9VB4g0OqRGAMPnFxKeLbzoZx0NzqIY04PrWYwNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UFA+rLkV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF8CC4CEF7;
	Mon, 23 Mar 2026 16:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774283216;
	bh=yvvnk8L0cI2hlcKK9JJuYOByfrm/Vw6Bgw9bTa2StmI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UFA+rLkVyf1DBRjVyHsPafKbt0kPko9jZSKOWidKNXiKnS/MKoiCdayFijUomdfk8
	 aEaVGjeY4qxDaQcBAb6HRBkg3E4/V2z7VeMXqH27FdbP05xhb3qvx5Y0gyfSgk1Nnp
	 m3gDq6RWw9ouOCrI6epPjo02pdgOxoX2kzKr/gkyYeCNvMGMM8J3uUUjGFTa9u9NBe
	 Jz2709JhHURsIJ9gpQt6cuMIt5rXpqjq9UGawLFhhju8v1z4vq7QWU2XQfURMsEWVK
	 dmyJH5L9zBVkFvpIMHtN9q+KXCX6PqHOm2MthPo9E0eLPXqy7Th3XWrHFImLGJ2Mdg
	 Ok/ZhlKzCZb1g==
Date: Mon, 23 Mar 2026 09:26:52 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Cosmin Ratiu <cratiu@nvidia.com>
Cc: <netdev@vger.kernel.org>, Sabrina Dubroca <sd@queasysnail.net>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Shuah
 Khan <shuah@kernel.org>, <linux-kselftest@vger.kernel.org>, Dragos Tatulea
 <dtatulea@nvidia.com>
Subject: Re: [PATCH net v5 2/3] selftests: Add MACsec VLAN propagation
 traffic test
Message-ID: <20260323092652.417b1bc8@kernel.org>
In-Reply-To: <20260323123633.756163-3-cratiu@nvidia.com>
References: <20260323123633.756163-1-cratiu@nvidia.com>
	<20260323123633.756163-3-cratiu@nvidia.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-270609-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3C0C72F9BE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 23 Mar 2026 14:36:32 +0200 Cosmin Ratiu wrote:
> Add macsec_traffic.py using NetDrvEpEnv to verify VLAN filter
> propagation through offloaded macsec devices via actual traffic.
> 
> Test creates macsec tunnels with matching SAs on both endpoints,
> stacks VLANs on top, and verifies connectivity with ping. Covers:
> - Offloaded macsec with VLAN (filters propagate to HW)
> - Software macsec with VLAN (no HW filter propagation)
> - Toggle offload on/off and verify traffic still works
> 
> On netdevsim this is a smoke test (stub offload, no real encryption).
> On real hardware this validates actual VLAN filter propagation.

CONFIG_VLAN_8021Q (and possibly other things) are missing from
 tools/testing/selftests/drivers/net/config
-- 
pw-bot: cr


