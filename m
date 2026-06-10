Return-Path: <netdev+bounces-297359-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N/GrAhyuKGqZIAMAu9opvQ
	(envelope-from <netdev+bounces-297359-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:21:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 45900664F17
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 02:21:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mFtZ89aW;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297359-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297359-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 66BA030B32CF
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 00:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D628D3B2A0;
	Wed, 10 Jun 2026 00:17:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD04226ACC;
	Wed, 10 Jun 2026 00:17:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781050672; cv=none; b=k9evkQa/2VCuu7kK6dMZkpFM/90Pm+l+XE3B3OGusai8sb+EJw+3pLJoE+0ST9WtVNi/NdTk7XVlLsebuopUNZK2fTYVwnaqTvdg/AdnYbdCL9n6irY5zveXk3BGncDSrk1RP6gQZhYZAfEqDrWEl3MMWGkhJgb6Xo0kgp1+jyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781050672; c=relaxed/simple;
	bh=2X3adUZBt/OsiwFj67H2fjX+z3gaGYoliU4kJoBwcMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7+OJMK0ozv/jQuAdvGM1vSxoFOQx1mePi7hCaTAeO2Vgf3Rl/Oo9Y90JiMVCqK8PTlCvir9s2J42N0/gFDfCdXPTfEeZZ8ci7OqrcInUvmpdFfV7asSlSkzZxul5PDn2r8NojfowZX0daYsx2yztNgNjGxVlz/4njyf2Qb+stE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFtZ89aW; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3991F00893;
	Wed, 10 Jun 2026 00:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781050671;
	bh=kpEtiFrBEIM+OcxmfyVtuRseNKwhQK6Li7jNDIkmsk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mFtZ89aWwYePdEMSZCIYhqOArs44ygPvWB3tdzkh33PvIxn5Aam8KArGCmpQYJplW
	 HK3TYSwyj6Nqzpz/JWe2UWE4n65n/MThJmxsCGFn4Yz8au7hPcaTj5q/6TXHd4101o
	 xtp2nGMRpzqEkkB6785g2Knv4wZz4PI7L0g88up0xmcdA3tyuf6b8Z2OdmlDBftHej
	 U3vxKyg1ajRId2ejVTWRY1/M5g8qcFPR+VjCrSmvBzcLDnh7IrGg/qE9DVqo9XzqHo
	 oRcFiGsy7O/BUyLdAvV6rl8HGAJq6LNbG6QisoQu4CsYbBc8blhbCBtlkPtHxkrNrR
	 wY3sVt13NilkA==
Date: Tue, 9 Jun 2026 17:17:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethtool: mm: Increase FPE verification retry count
Message-ID: <20260609171750.7c5709ac@kernel.org>
In-Reply-To: <20260605025631.2872-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260605025631.2872-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297359-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:muhammad.nazim.amirul.nazle.asmade@altera.com,m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:mcoquelin.stm32@gmail.com,m:alexandre.torgue@foss.st.com,m:rmk+kernel@armlinux.org.uk,m:maxime.chevallier@bootlin.com,m:linux-stm32@st-md-mailman.stormreply.com,m:linux-arm-kernel@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,m:mcoquelinstm32@gmail.com,m:rmk@armlinux.org.uk,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com,foss.st.com,armlinux.org.uk,bootlin.com,st-md-mailman.stormreply.com,lists.infradead.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev,kernel];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[altera.com:email,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 45900664F17

On Thu,  4 Jun 2026 19:56:31 -0700
muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> The current FPE verification retry count is set to 3. However,
> the IEEE 802.3br standard does not specify a fixed value for this.
> A retry count of 3 may be insufficient when the remote device is
> slow to respond during link-up. Increase the retry count to 20 to
> improve robustness.

You need to CC the author / expert on this code, please repost
with the CC fixed.
-- 
pw-bot: cr

