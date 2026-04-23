Return-Path: <netdev+bounces-280845-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mKoJLPFr6mmhzAIAu9opvQ
	(envelope-from <netdev+bounces-280845-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:58:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C7A456453
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 20:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BCFE7300FA23
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 18:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F773AE703;
	Thu, 23 Apr 2026 18:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KEZ7n+Wo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 003123043DC;
	Thu, 23 Apr 2026 18:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776970735; cv=none; b=ubD4zMP/JIZKfgXBx1ajqTy7kWXeXrU54EAQ2TN6BKLpYkuHhmg2Y3ClbsXSfx4X3NOuw0gGOSyT1cqbCdPUrACpKk97rWcssp4gKOPy2f22G8CDaVbn6N6WkIkp13B9J4Vb7rlt+xIM6OKTDFvLOigqjltXtgq7JHf4PPy3jJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776970735; c=relaxed/simple;
	bh=qOAhTLO8I95diQxLDKGSlGAp2wiuUKzkAdUZR8FFeGo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pnirmOtwcKCSjr70dH4rZaPbi+QxblslxDKze5s9UtkYWFS7S1dm7gJUymyJzziUHSOgqZPYfuZxDoXSPjeYLZ8KGg8nK6GTEk2Ext7Wca3Rc0lSvB0RxRAJs+RNl71CoWsqlgg/Tjpr03HUX6OM9UpoKctn9dUtDkVt1GzVEIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KEZ7n+Wo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30689C2BCAF;
	Thu, 23 Apr 2026 18:58:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776970734;
	bh=qOAhTLO8I95diQxLDKGSlGAp2wiuUKzkAdUZR8FFeGo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KEZ7n+WokOhbRC2V5PXdjVG5whTRTlvAn6EjRk5nbdv4uJLDkOLAfCkfiY2vPoCPf
	 Fa02cHY8uswSxAlYd2WQrIpt7QNiYP4fTxrj/2j6wwzhdwWaKS+dmT07psBr0hoz5h
	 6GH4bR6g9c5qcagIQZQq3rsHbpwaYRihlbEOyYymkETMEfLPG57kzn1F0MoRaWWNYx
	 EZcX+HcnBSmGJf2fLYlcbMeD04o/iS9bHjA1ddS06Z3oUFXVNTxFB/qV3vI+gqfEKG
	 T5YijYxxfnv5s032DIdTc1281Ku2DOiu+VxL/uDwdwcD8nf9DRsKuxSyV48dyD+e4/
	 v4cHrLytqyf5Q==
Date: Thu, 23 Apr 2026 11:58:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Howells <dhowells@redhat.com>
Cc: netdev@vger.kernel.org, Marc Dionne <marc.dionne@auristor.com>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Anderson
 Nascimento <anderson@allelesecurity.com>, linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2 0/6] rxrpc: Miscellaneous fixes
Message-ID: <20260423115853.59273351@kernel.org>
In-Reply-To: <2990993.1776970042@warthog.procyon.org.uk>
References: <20260423105639.6e0a0a7e@kernel.org>
	<20260422161438.2593376-1-dhowells@redhat.com>
	<2990993.1776970042@warthog.procyon.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-280845-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url]
X-Rspamd-Queue-Id: 36C7A456453
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 23 Apr 2026 19:47:22 +0100 David Howells wrote:
> Jakub Kicinski <kuba@kernel.org> wrote:
> 
> > Have you had a chance to look thru sashiko run for this?
> > 
> > https://sashiko.dev/#/patchset/20260422161438.2593376-4-dhowells@redhat.com  
> 
> It wasn't available this morning when I looked.  I know there are a couple of
> things to fix from other checks.

It is now :) May I offer the following menu of options
 - all the complaints are already taken into account / intentional /
   will be addressed later
 - I need more time, let's wait until tomorrow
 - some of it looks legit, apply patches ${list} only
 - let me respin completely

