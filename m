Return-Path: <netdev+bounces-277844-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IO7ZF6fM22msGwkAu9opvQ
	(envelope-from <netdev+bounces-277844-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:47:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EB5113E4E62
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 18:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0FB9B3002331
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 16:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A17E263F4A;
	Sun, 12 Apr 2026 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rSFr2Gkw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BC0BA3D
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 16:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776012451; cv=none; b=hoII4rfGwqQA8cqce9qaFfSdnmLrJbFRDerAyPOiR8KIDUR4x9ntPTkhxPNGpVUKr1Z0ZivfexAY1EjieKaMhtOZqT7olQPZQZrzFtodrK1euD+sfcZGIdd96gm3EQ+tdTd0imQxdM15ffD2Y7/hq6jDjs0Cf/ilAH/mec+2UVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776012451; c=relaxed/simple;
	bh=lmtVsM9hxNNbEPBCSyNIncwBgC0pZ/vdTkfaKgaZScY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t94yqnrnEheRi+YNAI1LKzTMnpFoek/0VJ4Vp/Aa8ZJOPl9i0DsQqU2ZmNN7v/jcHTU0kbXvC3V8IZS3tRfmVUa5g3VGQXlBvBQFHuwCRyJhA491o60RjDKdWm77s4l/rFbGDxEEraSWeQL0103LFrWJsVOT38NcNTpPSvphkO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rSFr2Gkw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36F0AC19424;
	Sun, 12 Apr 2026 16:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776012450;
	bh=lmtVsM9hxNNbEPBCSyNIncwBgC0pZ/vdTkfaKgaZScY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=rSFr2GkwkYbwrKTUO3mYlShyoU0rlEIqAkL/paGQ3GXn0krCwAZnTh1HPRQ5d9XII
	 lM2YP76Cvx11LGMiWNAYPv/ifeyvK3mEL40pObmQhloXQgD79BgOxd3TSC5p8DNrW6
	 f1wtiw4V8tfSgJF/NcJmow1xZzOP1Qi9XXnA7Utz1fus8R5ltAaz9l5dZ8LgGmEGg1
	 Oj+6D/ImHfFYcM/J1P3HbcZBxkWdcFFuywMFOaToTIBrWZDZpnO05SxuZzCoZk24Xd
	 pnmkdIblpXAcVlarU6sn6lCkvHJOMDlVE2K+qGrgUFQRS1TJ+PlGrNosqWSGEo0F4M
	 acKFax/m69fug==
Date: Sun, 12 Apr 2026 09:47:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Willem de Bruijn
 <willemb@google.com>, Mahesh Bandewar <maheshb@google.com>, Kuniyuki
 Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH v1 net-next] selftest: net: Use port outside of the
 default ip_local_ports in csum.c.
Message-ID: <20260412094729.334b8890@kernel.org>
In-Reply-To: <willemdebruijn.kernel.15ccd7e646278@gmail.com>
References: <20260410215420.1698033-1-kuniyu@google.com>
	<willemdebruijn.kernel.15ccd7e646278@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,redhat.com,kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-277844-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EB5113E4E62
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 11 Apr 2026 15:18:56 -0400 Willem de Bruijn wrote:
> > diff --git a/tools/testing/selftests/net/lib/csum.c b/tools/testing/selftests/net/lib/csum.c
> > index e28884ce3ab3..4e044689bc37 100644
> > --- a/tools/testing/selftests/net/lib/csum.c
> > +++ b/tools/testing/selftests/net/lib/csum.c
> > @@ -105,9 +105,9 @@ static char *cfg_mac_src;
> >  static int cfg_proto = IPPROTO_UDP;
> >  static int cfg_payload_char = 'a';
> >  static int cfg_payload_len = 100;
> > -static uint16_t cfg_port_dst = 34000;  
> 
> This is paired with wait_port_listen(3400, .. in
> tools/testing/selftests/drivers/net/hw/csum.py

FWIW I can confirm that this caused the HW testing in NIPA to fail
the csum test since Friday.

