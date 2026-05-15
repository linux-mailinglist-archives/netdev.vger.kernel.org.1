Return-Path: <netdev+bounces-288502-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJKNBASmB2rP/QIAu9opvQ
	(envelope-from <netdev+bounces-288502-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:02:28 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 800815592EA
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 01:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B849300A513
	for <lists+netdev@lfdr.de>; Fri, 15 May 2026 23:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C21233A9EB;
	Fri, 15 May 2026 23:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SzIikISo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 499E2175A9A
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 23:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778886145; cv=none; b=I7LDRNyKch/VUJMo5cTITS4MHZ8Nh9VPNJyG+8oIoq51L/uiQTthOS+HbxVhdg+xrIHubMCFugCTdItXyxJN4YzHLi/Tfqd2ADT/i4ongZ7IdF7zcrhdbmFVBQD3Ba7oJER/TS+7HkRwFB3F2VW6M3w/oeQ3yShf4OGyKzqoqwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778886145; c=relaxed/simple;
	bh=1DUODArNbaH8yEbiFJ9EDpD31sJYNQmjl95D66fLDBs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dQ8SPzvxOhxBgjeTIv/6L4lcvRKLGQbXjAU5haAl9BnZCxXLTyjBnJO26I49qGefwXIoJvTqsFgfyKlQqLhhBRtrg1yKB6P7if8E7vtTXs4vCq6zgUdwPH19TH9RjikV1VRcWZzA33mOgJuCkAFPl1JrXpocNpEe99tM/Msrf10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SzIikISo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B093C2BCB0;
	Fri, 15 May 2026 23:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778886144;
	bh=1DUODArNbaH8yEbiFJ9EDpD31sJYNQmjl95D66fLDBs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=SzIikISoEhqbUbuw1EOSIxYKfi98AkJsQmJ7Vu+B/qn8wADW1pJFSMcI+ymNTz7/m
	 Gde0jVmCIo3Oin6c6hAglBc1lfEto44YtgDS7q5Tbuk+7PyTnDS9Jpe8FVN/6r7CLl
	 yIZ/CUQxfGSq7q7Pz5H1SfA4cVWnjPsalWg4e8yAH1x4vdZ0d4TP+q9r4RIsUKcffN
	 NWK2OA5n7pxGhoUu1Te81UJmVe1GUvONbMaVhnsVwIsDYWvph+Z4iJTeTDdD1NmS24
	 tREb11hG+mKGAyvJGnvhk7O4sIy0ZNWjSPx13xqGYRrdTG/QTYxDgSImO52qT/IY2x
	 ngRmXPqM4rMZw==
Date: Fri, 15 May 2026 16:02:23 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Eric Joyner <eric.joyner@amd.com>
Cc: netdev@vger.kernel.org, Brett Creeley <brett.creeley@amd.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next v3 5/5] ionic: Add .get_fec_stats ethtool
 handler
Message-ID: <20260515160223.1a6b62ea@kernel.org>
In-Reply-To: <8fb773c1-411a-4b61-915f-5111210abe1f@amd.com>
References: <20260512224421.25236-1-eric.joyner@amd.com>
	<20260512224421.25236-6-eric.joyner@amd.com>
	<20260514183209.48fa771a@kernel.org>
	<8fb773c1-411a-4b61-915f-5111210abe1f@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 800815592EA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-288502-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Fri, 15 May 2026 12:59:04 -0700 Eric Joyner wrote:
> On 5/14/2026 6:32 PM, Jakub Kicinski wrote:
> > On Tue, 12 May 2026 15:44:21 -0700 Eric Joyner wrote:  
> >> This includes 802.3ck FEC histogram data that some newer
> >> hardware collects.  
> > 
> > Ah. "Some newer hardware"? As Sashiko points out the standard stats
> > are designed trying to avoid "does 0 mean unsupported or 0" ambiguity.
> > You need to figure out if the device reports them and if not - don't
> > set ranges.  
> 
> Unfortunately, there's no proper/good way to do this. A stopgap measure
> would be to use a rough proxy measure like checking the ASIC generation; and
> then we can implement a better way in the firmware/driver following that.

The FW definitely knows, so it's a SMOC.
Could you respin just patch 2 for now, or does it suffer from the same
shortcoming?

