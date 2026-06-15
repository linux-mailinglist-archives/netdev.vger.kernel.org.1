Return-Path: <netdev+bounces-299607-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rTDhLhhjMGq2SQUAu9opvQ
	(envelope-from <netdev+bounces-299607-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:39:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AB377689F62
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 22:39:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ceijp5wK;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299607-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299607-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EA8323001CD6
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 20:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39A53B531A;
	Mon, 15 Jun 2026 20:39:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D241F3B5DEE
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 20:39:46 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781555987; cv=none; b=eBSKmXnVIWeAMPMrWgnvSk8YYXBC4sZNGky/OMCG1jcfoahNJ2lJ62774aRGMJDnx60bfv1fwr1XFRcgQD1vuy5j7uFUAI1V30BSx78xDJwmzbOWYFdnOxAAW926pp2/JOKHQ4O7CLVjn8wLpza7k5XL3w6hZrj0WSGGsh32coU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781555987; c=relaxed/simple;
	bh=CXn1z1gPeSrZCNbtHq24gR5WRMNrngE9ogf/o3qz4fQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TJewYXs3g4/F6v+NZW23qWfK3k8aDnwnDIyasRbWPMYqsfv+iSN6YFfG56nozk9zrqdZWwUyq+Z39oXKqBBPvqQJYdopAg3/PmbdY/ganJV0NxfTAUDr8DAKTaNbaCPNjKSVUsqeWG2DBdrOwfYgxBW+3wUO1TlLcJfP+Z26NmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ceijp5wK; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEEC01F000E9;
	Mon, 15 Jun 2026 20:39:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781555986;
	bh=/Zml9Z4FF9aHVytLRahfWrVDKVXZ5Lp7aUpoDTgcOl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ceijp5wKhtLCVqq3vVflxkEX/viU/9AEH/GwD8gQaP7Kj5/gbOUPa3D3Gj4H//PpZ
	 PKQFO5zY7ZGcAzvgf72hLyCID7ucYNX4RKk/njmW25rppqKrCeITljQ5AHSGQzyTGH
	 MAN33FtJwZO5H/oO2vJeJZ8GXvErPrdFq0h24FRkKS+6q+hDa+YjLS2n1Xa9EfH++D
	 jflrTe741rynWzO7m/3UrALgqEdQUWtPM25sWxSRTz02pYJvNTdXxe4TKIqctSaYIg
	 lzid3yTHCp+0YBSCzihYXXcdxnw7zHbTuUlNmJKSbsh55ezzzhO8S3PPKFy5xrfJ80
	 wCUbEy8UcEauA==
Date: Mon, 15 Jun 2026 13:39:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Wongi Lee <qw3rtyp0@gmail.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, Ido Schimmel
 <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, asml.silence@gmail.com, dhowells@redhat.com,
 willemb@google.com, Jungwoo Lee <jwlee2217@gmail.com>
Subject: Re: [PATCH net v3 2/2] ipv6: account for fraggap on the paged
 allocation path
Message-ID: <20260615133945.6e94c2d9@kernel.org>
In-Reply-To: <aiq5VQknt1QHcvio@DESKTOP-19IMU7U.localdomain>
References: <aiq3f7UZGFp0F3MV@DESKTOP-19IMU7U.localdomain>
	<aiq5VQknt1QHcvio@DESKTOP-19IMU7U.localdomain>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-299607-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:qw3rtyp0@gmail.com,m:netdev@vger.kernel.org,m:dsahern@kernel.org,m:idosch@nvidia.com,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:asml.silence@gmail.com,m:dhowells@redhat.com,m:willemb@google.com,m:jwlee2217@gmail.com,m:asmlsilence@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,nvidia.com,davemloft.net,google.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB377689F62

On Thu, 11 Jun 2026 22:34:13 +0900 Wongi Lee wrote:
>  			copy = datalen - transhdrlen - fraggap - pagedlen;
> -			/* [!] NOTE: copy may be negative if pagedlen>0
> -			 * because then the equation may reduces to -fraggap.
> -			 */
>  			if (copy < 0 && !(flags & MSG_SPLICE_PAGES)) {

You remove the comment because copy can never be negative with
pagedlen>0 now, can we not remove "!(flags & MSG_SPLICE_PAGES)"
as well then?

