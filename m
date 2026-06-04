Return-Path: <netdev+bounces-295026-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SiiaJh7iIGpk8wAAu9opvQ
	(envelope-from <netdev+bounces-295026-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:25:34 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FDDB63C7D3
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 04:25:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i7ULMw3r;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295026-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-295026-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C91D230439B3
	for <lists+netdev@lfdr.de>; Thu,  4 Jun 2026 02:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D23733C1B4;
	Thu,  4 Jun 2026 02:21:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9E8343890;
	Thu,  4 Jun 2026 02:21:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539691; cv=none; b=gvXGWP3hp7SgXa34/0XEnWnhNltgwRt3szCVbLjixBAk698UcRS8SerRf23no+gml98Q825iaX/ak4OeCMejaMrV4VCMr+3LzP40Q/GuJ3iduHS6mm/7oiph9pUTHta+PkqIOnYa+IIM/0apMD2Ld0BcEtCl5/AtazX1BCAjWrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539691; c=relaxed/simple;
	bh=7ZvVXVH6XJPs9cdZFiCPo4IpSHYqzK8OmR3iDhrvKSI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWsM/tLIjgM9tQXoMa+E662eL8ScMM2YKAtyis51ASuoJnoKufpHnrczyHvHq/QuJFe4PZvppdRHy2fG5gb9h9MtygRM3IRRsRTzzIsZVqbUfTCTqDWeOxTf27P6z2Le28wUtvDpUD08kzCT7LTZyJQVctmlI14eLmWwL8tTnBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7ULMw3r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A3FA1F00893;
	Thu,  4 Jun 2026 02:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539690;
	bh=hPjrlOz2n01Vwt1n1fwG5GnjOFf8BkQ6pkQK9AjijTk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i7ULMw3rNx1FOeQTY/FP05qnJvxonfDckgJGowjEwL1+4wYl23X/lCfe6SSxOxUtS
	 T2qrAW8W2m2tKH7WyxP5dMlfJda/D3K7hfswGMJaeFJcht+B8TsVPbZflXiLgeSqRF
	 ucERdMlKbxMgeUVcojGBHSQ4cx8glwcls2gzb0A95z/AyeAmhI+9N+8kJl53lrbz32
	 Ub9H5IEimZLuJsrvCiwYbdUFj+7zgNDSr2nLu0UfJ82ZBYTyWRuW96X5pKlVEFFWqc
	 9pCYpYhN40SCri56P0jUmAB6C/oaM0udKFWcRjX7v5aBLz2m1L5yeLJxB6sDdH8r/X
	 jprPfpfqUEVcQ==
Date: Wed, 3 Jun 2026 19:21:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jakub Raczynski <j.raczynski@samsung.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net-next v3] net/sun: Fix multiple typos in comments
Message-ID: <20260603192129.53f9ca9b@kernel.org>
In-Reply-To: <20260601163727.554364-1-j.raczynski@samsung.com>
References: <CGME20260601163737eucas1p19d7a2bf830568053314738a191cbd591@eucas1p1.samsung.com>
	<20260601163727.554364-1-j.raczynski@samsung.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-295026-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:j.raczynski@samsung.com,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kernel-janitors@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1FDDB63C7D3

On Mon,  1 Jun 2026 18:37:27 +0200 Jakub Raczynski wrote:
> there is no reason not to fix them.

Time needed to process these patches (you are at v3?!) and space in git
history are two reasons that come to mind. These are ancient drivers.
The most action these files will see in the future is git rm..

I'll apply but please try to adjust the compass a little more towards
actively used code.

