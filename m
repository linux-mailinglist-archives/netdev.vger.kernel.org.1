Return-Path: <netdev+bounces-296000-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pYVFLjlhI2pPrwEAu9opvQ
	(envelope-from <netdev+bounces-296000-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 01:52:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CA6364BDF0
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 01:52:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NKKHMZzM;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296000-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296000-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E504C3041A5D
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 23:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C816340281;
	Fri,  5 Jun 2026 23:50:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E2912EC081;
	Fri,  5 Jun 2026 23:50:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780703413; cv=none; b=SXRrIxIz2IqsYDJrqHoJtrCHUeWAhBbjVLuC4dCsYa8NKDuSstv55Ortl66fb8REC3VbYZ1EoO7ibO3JuVuzEasmfMXzkTFdRzGeNyIjrpUz+aaTrHd2/p+pPhm/YG388fvKLA2VC8dlqcSCfuKih9UeqJCAx2koDpKfPMn1ves=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780703413; c=relaxed/simple;
	bh=dATWYwolmKE+cEyfQk/QayfKYLVrZZWQJ74ik/ybTKk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lsfX8H/LYT+kfybMaIY/5toZ+HAt0H+XO+n5zVy9xO4A7GtDBs1GdZCYciZZzJRNaQq8qVZ97FMLSpWHvDjaYk6yopC1kmyyeLSvvOh26EQV3Dm7S4VYJciqQ4f4N9qsvg12JWDUPJJQV5zXSVl4M0GXUVd9qglxhIqGj1iKj2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NKKHMZzM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02EA61F00893;
	Fri,  5 Jun 2026 23:50:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780703412;
	bh=dATWYwolmKE+cEyfQk/QayfKYLVrZZWQJ74ik/ybTKk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NKKHMZzMYTZdb9c/jm0GgtAJAukZ8Nil2YHaFC5SgNAmMWYHdFaNphEg9V8trlNm+
	 nlPyQ4jwyabu5c3j5cYSIVn1jzXgXqGGOg4GjXoPDT/8/9qKaaagLiThHQCsqaGuII
	 9SxEYMaKyZHDPPLeZ7LdZvE67p6DgtZuy4efbFRyVwCInAj7tDKxcDlDoSW43rlAKC
	 oSQvZn6xW2/DamovcubIqm3X7Gwl+S+OS+LofU0EIujqOmtxC/NlVYBJGh2VO5HCWB
	 o6BNvTVjYIy4QuY+bU/FraZ6hccBql7a8j+DF1Hh1MvJIOe4AQGsP39rsfR96EM7am
	 pMcYn4iHoZTkw==
Date: Fri, 5 Jun 2026 16:50:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?5L6v5pWP54aZ?= <houminxi@gmail.com>
Cc: Aaron Conole <aconole@redhat.com>, Adrian Moreno via dev
 <ovs-dev@openvswitch.org>, netdev@vger.kernel.org, Adrian Moreno
 <amorenoz@redhat.com>, "open list:OPENVSWITCH" <dev@openvswitch.org>, Paolo
 Abeni <pabeni@redhat.com>, Pravin B Shelar <pshelar@nicira.com>, Ilya
 Maximets <i.maximets@ovn.org>, open list <linux-kernel@vger.kernel.org>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Jarno
 Rajahalme <jrajahalme@nicira.com>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [ovs-dev] [PATCH net] net: openvswitch: fix possible kfree_skb
 of ERR_PTR
Message-ID: <20260605165010.59e7ec8b@kernel.org>
In-Reply-To: <CAJ0BgHcpo68Cx0tL_rRFFzZm8vNpDagF-hfy9KgUhPh4maGfFQ@mail.gmail.com>
References: <20260604121946.942164-1-amorenoz@redhat.com>
	<f7tzf1agvwv.fsf@redhat.com>
	<CAJ0BgHcpo68Cx0tL_rRFFzZm8vNpDagF-hfy9KgUhPh4maGfFQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:houminxi@gmail.com,m:aconole@redhat.com,m:ovs-dev@openvswitch.org,m:netdev@vger.kernel.org,m:amorenoz@redhat.com,m:dev@openvswitch.org,m:pabeni@redhat.com,m:pshelar@nicira.com,m:i.maximets@ovn.org,m:linux-kernel@vger.kernel.org,m:edumazet@google.com,m:horms@kernel.org,m:jrajahalme@nicira.com,m:davem@davemloft.net,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296000-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0CA6364BDF0

On Fri, 5 Jun 2026 01:10:16 +0800 =E4=BE=AF=E6=95=8F=E7=86=99 wrote:
> Should I target net or net-next for the test patch?

net-next, we _allow_ posting tests with the fixes for ease of testing
and review. But if the test comes later, anyway, it should just go to
net-next.

