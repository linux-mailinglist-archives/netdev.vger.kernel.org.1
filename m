Return-Path: <netdev+bounces-305942-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M9EEFqOTTmomPwIAu9opvQ
	(envelope-from <netdev+bounces-305942-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:14:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B85F729761
	for <lists+netdev@lfdr.de>; Wed, 08 Jul 2026 20:14:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZDkaFnp1;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305942-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-305942-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A56D6301B4CB
	for <lists+netdev@lfdr.de>; Wed,  8 Jul 2026 18:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D283CF68F;
	Wed,  8 Jul 2026 18:14:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A872B2E5429
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 18:14:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783534487; cv=none; b=SMlPA6ugnHSzQifAYjiGoVmnGQvXmDejHy7aYsBoBskAMPPkErAijQAWkgq2AWnPPJC7BKPNQ1w7rQLhbzrfLzZM7JP/3N7F+DzZ5YHiXT2tBbTw2MDtCRI5yJFbVeRy00wXAsIppi25oRE41Ue9FoGNUvYKIemNwx3EfMgJsJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783534487; c=relaxed/simple;
	bh=9tk5JyeN1VTakSoxEasMWuBTErbH4kCHxCdpMWWddFo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tbsGrjb1Po0mU8QTdG4Q34I8g807923trqCktN983YqFNqvp3LRRUS64fWwgk7XfV4z+8dEduafeA3S+5UNit1UHd2FBhBGnxJgPu6ZW8e6BEvXg14NLKvrEj2iQg7Xe/1BIQutZt5YRNPS0LrcXCRmeQaUtixe2Di+hn9sHNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZDkaFnp1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 221441F000E9;
	Wed,  8 Jul 2026 18:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783534486;
	bh=iUkrHSz8Ezd5fMP+tqv5ucQ9ghunKrX/1hL+15NhiF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ZDkaFnp1/7wgI7ns5YMTf8j6sYDXrrYq4BskZnTVtVmKbpkwsdKqZl/OZQDR3I4Ex
	 XVsTjmE70rgjsq3t5zIkocSOUPVpsXsTXbPS/C3cq9zmz+YQEOnU9Qtu1cx3lZkcx1
	 u9XSbEb+kyTkBrJooLq4BeXLlm2UAPtajD6OebwsYYryTJt+rOB9jCM1seXZ1ESamq
	 UkkQ164Sgu/mCu9UlW2TPlUTB5mwhv0CJHz704ul5posFOZpEVVka2iDJL0CiEXdlM
	 YrNzhdgbm33EREjlFYkQiM3WB/f7ZnvXvvaRKcQof4rDwO8/hBJbBpjrM8+CT5RFW8
	 PTgna238r11kA==
Message-ID: <123e086e-ee0f-4c1a-bf65-2b8cfb0fd9f5@kernel.org>
Date: Wed, 8 Jul 2026 12:14:45 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH iproute2-next] ip: add OVPN device mode support
Content-Language: en-US
To: Antonio Quartulli <antonio@openvpn.net>, Marco Baffo
 <marco@mandelbit.com>, netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
References: <20260703111419.842059-1-marco@mandelbit.com>
 <95c5e510-34c3-4ba3-9173-3d3954628948@kernel.org>
 <39bbffbc-3a33-4458-a0ba-424942ed5e25@openvpn.net>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <39bbffbc-3a33-4458-a0ba-424942ed5e25@openvpn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-305942-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:antonio@openvpn.net,m:marco@mandelbit.com,m:netdev@vger.kernel.org,m:stephen@networkplumber.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B85F729761

On 7/8/26 11:11 AM, Antonio Quartulli wrote:
> Actually that already works out of the box, without teaching iproute2
> about 'ovpn'.
> 
> You can go with "ip link add ovpn0 type ovpn" and the interface will
> nicely show up.
> 
> However, the ovpn device mode is set to the default value, hence this
> patch enhances that part.

ok, thanks for the clarification.

