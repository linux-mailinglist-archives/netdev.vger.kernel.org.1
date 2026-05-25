Return-Path: <netdev+bounces-291426-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uBKcDEyeFGoLPAcAu9opvQ
	(envelope-from <netdev+bounces-291426-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:09:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84FC05CDEF7
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 21:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8ACF300F50A
	for <lists+netdev@lfdr.de>; Mon, 25 May 2026 19:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC4D237AA6C;
	Mon, 25 May 2026 19:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CPDpUGdU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D83305684;
	Mon, 25 May 2026 19:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779736135; cv=none; b=YbI/EFsQ0yV9YpmoNO9RwLWKWiB4G9IYUWAXgMgkK7FFN9uMu3bkGtppsjXEmROZGG5sFPrT6Trt/RRhkNw83vVLIgsVvjiKBPmbS2Wj/fRLxwYMMwKhjKcuEIyR4JgLHdzmonnCsFnTqN+jEojW+h3kGoldqsuGmhnFlYzl3Rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779736135; c=relaxed/simple;
	bh=psWr5Ra3S1+T0qmP+j1ZT22j2o4RvkP48ItcuQ1y11c=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dWuFyL8O9BhQrEWltbLeQTMLZh9ecFmiY8i4mt5K4ElPdB0Pok7iqVqpvqZpemu4XBO7KPQ97EXtlURCa4hBK0KjI+fgzzuXVol9NYR6BV0LlTrSHUxxkqRNq3Cy6QhIaLZZvHe7NbuVxjlMlSNHWIEVClUHYRLiDiWB96nWLSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CPDpUGdU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40DE1F000E9;
	Mon, 25 May 2026 19:08:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779736134;
	bh=JlLnJwu/Ox/kDjl4MFqofOdgURhg0UQ3j5uHccDwMdw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CPDpUGdUVo1EqJVpz2hEmNSYUdaSvaWO2zvPWStcPpL39GG03nTZcv5xCGI+FC7rw
	 DzxG63QDQUk5SFBXUiZkUeaf/8zi7oX38mNeMYpWkVzns6X5kMPDEQQP6P4TBRIldQ
	 In1Df2uTawaeIVy/J5+JVHGyYK2ia+lQtfkwkKIpvnulCPV3wqsBe3Byh0AlFYfvud
	 cbmkFm7HrUn9CVmXcHm7OOR2hlu2la3tTsitWxo+IaLqBPXdtQZcbuNaenCnBDLI1d
	 Tl1On7HBVtouGSmsiyUlfeMYTYyPQFgdeaE4JwP4cn/RDsUzEIjyyiOeaMUjUGH0vC
	 jZIYFf/RtWxZQ==
Date: Mon, 25 May 2026 12:08:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: sashiko-reviews@lists.linux.dev, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 10/10] net: airoha: Support multiple LAN/WAN
 interfaces for hw MAC address configuration
Message-ID: <20260525120853.7157bc9a@kernel.org>
In-Reply-To: <ahFkG32jFRJ7W_cv@lore-desk>
References: <20260519-airoha-eth-multi-serdes-v8-10-6bd70e329df6@kernel.org>
	<20260520085934.54AD01F00894@smtp.kernel.org>
	<ag2t4eVe4DcfU2yZ@lore-desk>
	<20260522112514.1ad6e947@kicinski-fedora-PF5CM1Y0>
	<ahCtsVA1VhYmhZq-@lore-desk>
	<20260522165820.04839729@kernel.org>
	<ahFkG32jFRJ7W_cv@lore-desk>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-291426-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 84FC05CDEF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 23 May 2026 10:23:55 +0200 Lorenzo Bianconi wrote:
> > If the MACs are not provided something is obviously wrong with the
> > device. We should try to provide enough functionality for the user
> > to be able to troubleshoot. For an AP perhaps that means SSH / remote
> > logs? So switching/routing doesn't have to work, I'd think. 
> > 
> > Will the user be able to log in when REG_FE_LAN_MAC_H does not match
> > the MAC of a port?  
> 
> REG_FE_LAN_MAC_H and REG_FE_WAN_MAC_H regs are used by the FE module to
> hw accelerate forwarded traffic and does not prevent the user to log into
> the device even if they are set to a different values with respect to the
> configured mac addresses (just hw acceleration will not work properly).
> To prove it, I set to 0 REG_FE_WAN_MAC_H, REG_FE_WAN_MAC_LMIN and
> REG_FE_WAN_MAC_LMAX and I still able to ping the device via the WAN
> interface.
> I guess the easiest solution is to neglect errors from airoha_set_macaddr()
> in airoha_dev_init() (as it is in the current codebase) in order to allow
> the device to probe successfully and provide a warning message to the user
> regarding the mac address misconfiguration. What do you think?

Maybe we should also enter some sort of error mode where bridging and
forwarding offloads are rejected? Either way, sounds orthogonal enough
to this series.

