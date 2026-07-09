Return-Path: <netdev+bounces-306169-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id mODEMrx6T2pKhwIAu9opvQ
	(envelope-from <netdev+bounces-306169-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:41:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A3F72FC05
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 12:41:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GAJrzgbh;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306169-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-306169-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3DAFD30055D1
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 10:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B663F1670;
	Thu,  9 Jul 2026 10:19:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D4F3AC0F8;
	Thu,  9 Jul 2026 10:19:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783592391; cv=none; b=nQEDrr8Urrl8hXCMOlyfp9cOGy2cDVyMdbU57duCjo1ZZqNidIhT7XeMsTS/TkZWBYE5LraBbijs+KhBREJxQor7yQ3abtfOLPbizd4FFo8fq3liKbA/OrcD8+SV3FxyVYoxFeGyTxgnu0NKs3QF8AsDyC9Xm+ch+tA6rtY47u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783592391; c=relaxed/simple;
	bh=k0WxY44bViKPKJV2fFpbLUr3vDX4uDmDyZMfSnRsp2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jg0SUwJml4Azw4TvdBy8DmrxYUL7kv+V9u4zndWGP7F61/CNKlKiwEO/qx0hTk/Yj2XeK0dNfG/dGjDdpFt7VMMSW5WwJgAhx3Etsp7I9/EuH5bb9TGSAcOwjR7IUsXo7GcDktGV7x0BSej98zejutKJAzOFmsPCY8CumUu+vd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAJrzgbh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E8081F000E9;
	Thu,  9 Jul 2026 10:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783592390;
	bh=aF2CMomHFWjL6Tfy5jqtVAF0h5mjxtbhqa0/VbfaaCw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=GAJrzgbhwmKvgp+Gnnksoqc0H2Kea90UeX1xdd68bZHdNa8Ujsi4eYH+0nXt1RsHw
	 hk+OUF+NLC8LAjRONvGy++B2l/fp1yP9DBkrgLK+FE59GM6bBNP//n011x4/AvG9T4
	 WL3KwmbHMHMQvbthgc2pjtLde5z9Dyw56Z3m8z2BliKSbdgCiGsnaxb5PPhDqeFSMv
	 GhZLVRIusFfcRZPfY65SIk/ukz3iQEhsnsoE0HdW0UnS2VU1bdij3bWdW/ZqutC3TJ
	 hlwF3qPisCUnrthbprD0Y/BeA/Eeepj2shF4XPvd5b5gyEnfTCH0/iZjpim+tSJyw0
	 +daYT4dttxk/g==
Date: Thu, 9 Jul 2026 11:19:45 +0100
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org,
	asantostc@gmail.com, gustavold@gmail.com,
	linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next v2 0/8] netconsole: stop charging netpoll users
 for netconsole-only data
Message-ID: <20260709101945.GN1364329@horms.kernel.org>
References: <20260702-netconsole_move_more-v2-0-1ebedd921dcb@debian.org>
 <akuUkNgyjVOTHMuz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akuUkNgyjVOTHMuz@gmail.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-306169-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:leitao@debian.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:andrew+netdev@lunn.ch,m:netdev@vger.kernel.org,m:asantostc@gmail.com,m:gustavold@gmail.com,m:linux-kernel@vger.kernel.org,m:kernel-team@meta.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,lunn.ch,vger.kernel.org,gmail.com,meta.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 14A3F72FC05

On Mon, Jul 06, 2026 at 04:55:35AM -0700, Breno Leitao wrote:
> On Thu, Jul 02, 2026 at 05:19:44AM -0700, Breno Leitao wrote:
> > This work continue to untangle netconsole and netpoll, improving
> > memory usage for netpoll users that are not netconsole.
> 
> Quick follow up on the sashiko findings. most of them are assuming that
> netconsole_write is called locklelly, which is not the case, except
> on panic (CON_NBCON_ATOMIC_UNSAFE). 
> 
> 
> There are in order as they appear in
> https://sashiko.dev/#/patchset/20260702-netconsole_move_more-v2-0-1ebedd921dcb%40debian.org
> 
> Tl;DR: There are two pre-existing issue that I will get fixed, but
> I don't think they are blockers for this series (IMO).

Thanks, I agree.

For the series:

Reviewed-by: Simon Horman <horms@kernel.org>

I did notice that patch 2/8 now applies with some fuzz, which trips up git am.
You may want to consider a rebase.

