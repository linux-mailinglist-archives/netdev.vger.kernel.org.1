Return-Path: <netdev+bounces-258306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEzhLrCtjGl/sAAAu9opvQ
	(envelope-from <netdev+bounces-258306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:26:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E3BA126162
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CEBB3300D61C
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCE9D33A9DF;
	Wed, 11 Feb 2026 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nWBIOReD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C8B1E9B3F
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 16:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770827181; cv=none; b=IBItWRen0dXT0ztpbl4L1XZyX0sj2rQ4C5qiraTbo1G/RHq9SrlHP00+JKWjVP0zrEUQYHtcrRar9NW8mmQjS7c73HRYnIxHsNVVaE16wddDVwMk8ue/ujrMVimWacqb26+YPh+y3BnXXIrfDjNaE0wHfnlyI7d0ZpUNohXUTEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770827181; c=relaxed/simple;
	bh=mCWtPE9gnBMrzM8S/tFxpYDnP3SU/+oGWJ6SD/M0GUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tklmJIxPMyM+bSpoM9+tMywswqbPqs9vPPqENub3xukQKHYs1WQ7uLHj/DZeKiyYC3VtHEC9R9e74caFfQ+RDVZCWDF6CTJ+3vvipzPdg9F0I/DcU8hnH8s/IrsALao7ZEaEYC9h6Y3BrRPIunhqfm7kA65gfePHHdHe6P/HbEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nWBIOReD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCA81C4CEF7;
	Wed, 11 Feb 2026 16:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770827181;
	bh=mCWtPE9gnBMrzM8S/tFxpYDnP3SU/+oGWJ6SD/M0GUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nWBIOReDXe/ddBd95F1rWUDR/68Bg7vHLGO7hpyEjuY9aeTi/O5SqjkynxrrMu8Hy
	 fuLsuo2eECLJ336wZpsthr1qpYRA+uesxX1BKXQMzwAGzOtmy0OSH3xQn0yatlc3a6
	 eQpvRD6v5+ZC12gGV+hstmPNF/nR992GszKR59KXNZK2D+XofZ4aQ2IKsUJs10SiYb
	 /MWuqRy/ffokM2ZKnzkOj2lpWzOzTSpmdg1MoWUXY/1OvBYTKobUarzn034go1KbjS
	 sFLqG0Ju1hdsuj6rJgmc9O84IXBjnbOmA/KT1CXQHjuw4xh5F+bNZaJU5wYFoBuL4b
	 10Uj9cnUE4Yag==
Date: Wed, 11 Feb 2026 08:26:19 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Pielech, Adrian" <adrian.pielech@intel.com>
Cc: <netdev@vger.kernel.org>, <przemyslaw.kitszel@intel.com>,
 <intel-wired-lan@lists.osuosl.org>, <anthony.l.nguyen@intel.com>,
 <pabeni@redhat.com>, <davem@davemloft.net>, <edumazet@google.com>,
 <horms@kernel.org>, <andrew+netdev@lunn.ch>, <krzysztof.galazka@intel.com>
Subject: Re: [ANN] intel's netdev-ci for i40e
Message-ID: <20260211082619.229a4486@kernel.org>
In-Reply-To: <54e57b6a-8cd6-4e2f-8ced-0cbb41c99e4e@intel.com>
References: <b5446385-1f51-4359-b484-6dfccb50dad0@intel.com>
	<20260203190811.1f9e7530@kernel.org>
	<a29bc22b-a1e3-4a9e-a63c-5d1c71a6f08b@intel.com>
	<20260204174033.5aa7dc6a@kernel.org>
	<54e57b6a-8cd6-4e2f-8ced-0cbb41c99e4e@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258306-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 1E3BA126162
X-Rspamd-Action: no action

On Wed, 11 Feb 2026 10:17:52 +0100 Pielech, Adrian wrote:
> > Looks good now, thanks!
> > 
> > One more note, the "driver metadata" is currently reported as:
> > 
> > {"devlink":{"driver":"i40e", ...
> > 
> > looks like you have some extra nests there. That's perfectly fine,
> > but we need there to be a "driver" key in the outmost object.
> > Right now our UIs show "undefined" for the drivers here:
> > https://netdev.bots.linux.dev/devices.html  
> 
> I have moved position of "driver" from device.devlink.driver to
> device.driver. Regenerated current and past results. You can refresh
> your dashboard as well to wipe duplicated entries.

Please don't regenerate past results in the future.
It's a pain to have to clean up the DB.

