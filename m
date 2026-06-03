Return-Path: <netdev+bounces-294969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LmuTFk6+IGq07QAAu9opvQ
	(envelope-from <netdev+bounces-294969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 01:52:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7244063BEE7
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 01:52:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Op1+6vms;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294969-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-294969-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B35C1300BD56
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 23:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CFCE4DBD9D;
	Wed,  3 Jun 2026 23:52:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2CC3B585D;
	Wed,  3 Jun 2026 23:52:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780530761; cv=none; b=GtMc1xgcWZfwJ4HMcmYvhbcGJaaLA7edI/Zrh8oHp/GqF5TqNHQpyt2TLOvdepP6alHq0jG0QAFB07dbbdbv08mA/TyWKPRfxzR4ltFmFVkZ5uDf8X2g4eG5sul3YShtiyFMF365nNlT4x/1QFbgwbULdU2PmbGT3aFQJA+yhOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780530761; c=relaxed/simple;
	bh=J161UQqMh9wxSA8A4moimcmgr0gOVC0pTzMbys2arTM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qIrpq/LU1ki+cRy+ENPVa3MK4l8d/HhUFktVRpjwWwas5z8G73s2qqMIEPoJcZd3dxsBixcv649O62UwIo3FkEywi2b4TeCImDAz16R7e+6ligx/2XqAaW2sUIvMQ5PyZG4D6upZDX5dbEs3wascP7H9U0+ETD+cLNFd91Wm26w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Op1+6vms; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 490F11F00893;
	Wed,  3 Jun 2026 23:52:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780530760;
	bh=pIhFG4QGZBE88pUeGj789/G2k4umSI59x5bGIxRq2bA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Op1+6vmsjKCJ+0c/7Z9rYZ3iFiNgW33YKcZcf/tJ9fNgbMsYRys1jgDgIVe7f7Y/q
	 ZFGXV851h7UhUQKQCw67jhOMq9qivVrkqshkW2KvwrgEusgWx0CNS/l52bTg2i6P1H
	 appkCNbUJrhhmqCtIkCgk7PfYD86AApDHvNneHd+5ccsJEZ3/gbWHh9tIFyF/DNPYN
	 w6CyFVhqFiiTtoddyILgXhxuXSnFnn230eTPCtW4HsM/L1k0Io3ZDUi/mbyTxIVBc+
	 yhEnylu1lP3eoT4f+A3KM//g+r3H6BguA42kv9YeRDzwXtRDfSFI9cQNv15W06ZJna
	 Dm2e48XEgKVTw==
Date: Wed, 3 Jun 2026 16:52:38 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Edward Cree <ecree.xilinx@gmail.com>
Cc: Gui-Dong Han <hanguidong02@gmail.com>, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, linux-kernel@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, baijiaju1990@gmail.com
Subject: Re: [PATCH] sfc: Use acquire/release for irq_soft_enabled
Message-ID: <20260603165238.43259251@kernel.org>
In-Reply-To: <74e6932f-a755-4931-8d4d-0025826a5502@gmail.com>
References: <20260528092838.2099352-1-hanguidong02@gmail.com>
	<20260603112035.0866d7d4@kernel.org>
	<74e6932f-a755-4931-8d4d-0025826a5502@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-294969-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:ecree.xilinx@gmail.com,m:hanguidong02@gmail.com,m:netdev@vger.kernel.org,m:linux-net-drivers@amd.com,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:baijiaju1990@gmail.com,m:ecreexilinx@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,amd.com,lunn.ch,davemloft.net,google.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7244063BEE7

On Wed, 3 Jun 2026 21:28:02 +0100 Edward Cree wrote:
> On 03/06/2026 19:20, Jakub Kicinski wrote:
> > On Thu, 28 May 2026 17:28:38 +0800 Gui-Dong Han wrote: =20
> >> Use release stores when updating the gate and acquire loads in interru=
pt
> >> handlers before touching channels. Keep the existing smp_wmb() after g=
ate
> >> updates, preserving the current ordering with event queue start and st=
op. =20
> >=20
> > Why are you keeping the smp_wmb() tho? You don't have to repeat what
> > the patch does. The goal of the commit message is to explain the why.
> >=20
> > Ed, WDYT? =20
>=20
> I think... that my head hurts from trying to understand this.
> What I particularly don't understand is why it wouldn't suffice to just
>  put smp_rmb() after every read of irq_soft_enabled, pairing with the
>  existing smp_wmb().

Exactly..

> And, conversely, why any of this works at all =E2=80=94 what stops an int=
errupt
>  handler passing the gate, because the write to irq_soft_enabled has
>  propagated to its CPU, but the writes to channel pointers haven't?
>  Na=C3=AFvely I'd expect the smp_wmb() in efx_soft_enable_interrupts() to
>  come _before_ the write to irq_soft_enabled.
> (The smp_wmb() in efx_soft_disable_interrupts(), I'm not sure exactly
>  what that pairs with, since the ordering that matters there is between
>  the irq_soft_enabled=3Dfalse write and the synchronize_irq().)
>=20
> Anyway, this code predates my involvement with sfc and I've never had
>  to touch it, so frankly I don't know any more here than anyone else,
>  and if a memory-models expert reviews it and says 'this is needed and
>  correct', that would mean more than a review tag from me.
> That's not a cop-out "I won't review this", rather I'm saying that if
>  Gui-Dong can't convince me because I'm too dumb, but can convince you,
>  then you don't need to wait for me to show up and add my tag.

I haven't dug into the code too much but FWIW having a store_release
barrier which flips something _both_ to true and false strikes me as
highly suspicious. So the patch needs a much better commit description
at the very least.

Thanks for the prompt reply!

