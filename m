Return-Path: <netdev+bounces-284644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AMqiELyY+mmRQAMAu9opvQ
	(envelope-from <netdev+bounces-284644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:26:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 997384D53E3
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 03:26:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E2E76303B729
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 01:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885BD26738D;
	Wed,  6 May 2026 01:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l7yaUtX1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64534266581;
	Wed,  6 May 2026 01:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778030760; cv=none; b=TkG4xxy7AnZx3wvOnlfhsJ7bpCSbVAUsCQq+lIIW2xLSqxjMBX4pdTctnpSLXa30DrSD0bU1KyXpI0gBXs/eLRGD28ZLdRsGRn3BK4RnPTyPSZcJJfHq5HYqhKuJ63b0GnScuOLTbXmlaCdVJo5h0ZRdMQcgE9SkJXNaDIRCUQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778030760; c=relaxed/simple;
	bh=6BdSyObKR1j2/wA7s43U5mIfFg84ZzPVVZymSOHqsjA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M2OlkQLtyaW8MOkAoOVleFU4ujqwjsmfpfnteaofYlwcVuf3nyR2MSQWkablp6h3G4NnVAnfF6gpxuAMwkmu/mipTNtLyvpF0Wy4ZbfQ9LWLrfPU273fDK5qjZl+4hnAWErbWEHdDwaUCGJ8NH3Tebu5Na4Z6hqThV2wnq2NVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l7yaUtX1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F991C2BCB9;
	Wed,  6 May 2026 01:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778030760;
	bh=6BdSyObKR1j2/wA7s43U5mIfFg84ZzPVVZymSOHqsjA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l7yaUtX1mRTSeSd1qX5VAbicxXvaWeXLCYcMWAfeFQC2mAY+xIYncPTxJbpKn26jS
	 ntm3t3+NBiPedeQZsp+gaTnrvbTG04EXH6vIAX765z82DFAWQxUSNhZLZQq/V7DP9s
	 UdB6K90oPj8L2ArZCWFCMicyJHMiQFNDIi5xPy/gPCEFchx1yUS2+HIqZsyrb3HrQb
	 3EMhv89sRNL8P9ew6KDYFZa/qFUuKz8tiHR4y08m1LXQaUVcDgT1T16hjOabpodkAF
	 9wc3MJzCrLSBP4iw1inpyyiyfKwNpRd0CDEXFOqU1ZMO75NGKrbnP3H0gATQglrWfS
	 iwlN958y7+PrA==
Date: Tue, 5 May 2026 18:25:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Linus Walleij <linusw@kernel.org>, Alvin
 =?UTF-8?B?xaBpcHJhZ2E=?= <alsi@bang-olufsen.dk>, Yury Norov
 <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [net-next PATCH v2 4/8] net: dsa: realtek: rtl8365mb: add table
 lookup interface
Message-ID: <20260505182558.34349c0c@kernel.org>
In-Reply-To: <20260503-realtek_forward-v2-4-d064e220b391@gmail.com>
References: <20260503-realtek_forward-v2-0-d064e220b391@gmail.com>
	<20260503-realtek_forward-v2-4-d064e220b391@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 997384D53E3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284644-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,redhat.com,kernel.org,bang-olufsen.dk,rasmusvillemoes.dk,armlinux.org.uk,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bang-olufsen.dk:email]

On Sun, 03 May 2026 03:18:24 -0300 Luiz Angelo Daros de Luca wrote:
> From: Alvin =C5=A0ipraga <alsi@bang-olufsen.dk>
>=20
> Add a generic table lookup interface to centralize access to
> the RTL8365MB internal tables.
>=20
> This interface abstracts the low-level table access logic and
> will be used by subsequent commits to implement FDB and VLAN
> operations.

kdoc says:

Warning: drivers/net/dsa/realtek/rtl8365mb_table.h:32 enum rtl8365mb_table =
{ RTL8365MB_TABLE_ACL_RULE =3D 1, RTL8365MB_TABLE_ACL_ACTION =3D 2, RTL8365=
MB_TABLE_CVLAN =3D 3, RTL8365MB_TABLE_L2 =3D 4, RTL8365MB_TABLE_IGMP_GROUP =
=3D 5, }; error: Cannot parse struct or union!
Warning: drivers/net/dsa/realtek/rtl8365mb_table.h:130 No description found=
 for return value of 'rtl8365mb_table_query'
Warning: drivers/net/dsa/realtek/rtl8365mb_table.h:130 No description found=
 for return value of 'rtl8365mb_table_query'

