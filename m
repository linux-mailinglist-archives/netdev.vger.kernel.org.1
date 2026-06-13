Return-Path: <netdev+bounces-298981-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TlMOFgiELWprhAQAu9opvQ
	(envelope-from <netdev+bounces-298981-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:23:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3281467F0CA
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 18:23:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dnxKrZ1P;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298981-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-298981-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 355B83002D11
	for <lists+netdev@lfdr.de>; Sat, 13 Jun 2026 16:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890E337E2E4;
	Sat, 13 Jun 2026 16:23:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F4D2EA73D;
	Sat, 13 Jun 2026 16:23:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781367808; cv=none; b=Ho0z3neQx+tdRE+eU9xcD1hNzVg61+2SfgAfHlg3OOdelUX9ItpkTSUaV4WtXUCgyjBHF1pm1jLflabvn028GKkZ0lIoykyDIju2Bxl1by5d8HGmUSjXRO1JyXEZgS2zRqSZTPobzSlCOT2o0vmeP8RUTJRCzdzTBC0N1Pk4/MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781367808; c=relaxed/simple;
	bh=ByqZdMR/5WyvyL12Y4HS3kvzcraQ4HFRtEgf2pzJt1w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ASOtUC/YFseJQZfeVJWGpP0eGpMyCw1iPqYk81Uew4dAzb1IYaNpfyWFSdiHsr62JWQerT2iAkR4shV2Jn8EBGTqML9jP8AX8JwSnWgqIcyXvGeqR0y4flf74IEnLZXnURpfvFMNCGC7+R8PkaUBT2IcW4o8eXYO2vrdyPSRkQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dnxKrZ1P; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7A4E1F000E9;
	Sat, 13 Jun 2026 16:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781367807;
	bh=8L2EOix+XLbzjEmmLbO6ehfNIZrFhGz9IlY3mcLL6LA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=dnxKrZ1P5q5UZ6zt5Nvs/4TCGcP8yHWWFLK/j/5h7545D9gB6mtxCw5co8LC0ga7+
	 +/KFloOiAtSbeH7ymKQ6dsRxn18rZeu36LZ0/jUU5YzX7y7zqV68sXpuSg7KpQGZbD
	 04+9hxv1TuQ9Y6Y5czK1MyF2TjS2lhT0MhBW8sVuabNTJKgaciUIFgCXxELnFrF1yT
	 6y7z6BUKPVTu4q90wSAr0d++vp2x9gBpRiaIX9/Kk9lQXYaLsj5K83b1fyjDOicF+G
	 tq1LnJgSa7QpMKTKh5Rti4y0mikJ/aAj3ySHNCOq01Utvzx75zxV1O1NHwF0hDBhJe
	 +0yoqD3hmPN5g==
Date: Sat, 13 Jun 2026 09:23:21 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Laika Price <laikabcprice@gmail.com>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH net v2 0/2] ip_tunnel: fix PMTU ICMP reply routing
Message-ID: <20260613092321.402921e7@kernel.org>
In-Reply-To: <CAL=tPgjhj0+8voK40ZPdsKyQ0Pn4vwnSg-JVqRK3qRSXLLB4Kw@mail.gmail.com>
References: <20260613-master-v2-0-061b70fd45dd@gmail.com>
	<CAL=tPgjhj0+8voK40ZPdsKyQ0Pn4vwnSg-JVqRK3qRSXLLB4Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:laikabcprice@gmail.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-298981-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3281467F0CA

On Sat, 13 Jun 2026 16:38:27 +0100 Laika Price wrote:
> Disregard v2 of this series.
> 
> Apologies, I'm new to kernel development as did not realise that I should
> squash commits that would cause the kernel to not build / fail tests. I am
> sending in a v3 with these squashed.
> 
> Sorry for the noise.

I'm not sure what build failure you're talking about.
Please observe the 24h cooldown between submitting new versions 
of a patch.

