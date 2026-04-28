Return-Path: <netdev+bounces-282015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIn1Bwzt8Gn9bAEAu9opvQ
	(envelope-from <netdev+bounces-282015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:23:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6FF489DBC
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 44C1B30374B5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 17:15:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2531330D22;
	Tue, 28 Apr 2026 17:15:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KX0pWs0E"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4A337C91B
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 17:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396540; cv=pass; b=HXVoVTXGH0rtD+sErFujAruGF9PKJcvk1iBJIoyQS3ErstArvRqgI0Xws/bhfMqZWu98ZTHKRG234VdR4rHoUIMrGlPEzJxoAdu3/O8B4b7ADNsuD0NXsOND9CTxXAuam2Lru4TDRNwmAtV1i9tDq+WOYIGsixyPKtHdak/qcY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396540; c=relaxed/simple;
	bh=Y4SInoJ+gQjLv2MpP5+ds4DYPfajGSs/Ku9vQ9VWKjE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UGBGaFdcl/gw08Bz25GspgVuFvvZCqQmSVDhVO2eA0IVJYPqGSrSfb4XjBDWNlP6nYINoIOhaFGIP4zgTU+PFiuacK0CmPB1MuZ79Ukn/q9M0uDgpRz7WPBiEMzFnopubztpDC1oHCE0OT50GIx38hQdAdEDwlWa6Ge8mYCW4A0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KX0pWs0E; arc=pass smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2dec803f9f0so50408eec.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 10:15:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777396536; cv=none;
        d=google.com; s=arc-20240605;
        b=bF32I1PEmYQfvRf/tdgLRpLFJoQ9hwN0FJl/v/hJBEv8WgpzW+sRPiXVg6RBn+4xi+
         AgzPAA9V9cgdOMF2MoUB8ryChuU4ex3i23f7YleUoBXnMj/5rsAJq0dEqOIbXf4iHcX/
         cvcCUHy6aLYKiIX9J1BIhhTDeB0OM8MBA+I5VYzsNOMFkQuhxyn0PUTuXIZ89X5wWlMe
         8IxOtT34nxtkgL7QVVAJj3FaBJjFpW1uFS2MLZCrjv87/mtC+b147n9oS290dkiRdWKi
         ZfLe6MDYKf9+g1eONnoJ7LDqQF+JLhLIQT7CFZQPWMdBhE2VE1e/D1B3bnsJ7y5LTWdJ
         qPZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4mHkN2xwVkuWH/B1Z4Hbwt0I5/IXNGH1RdG0Zb8nsFM=;
        fh=4l5DPsttvu+8jWOE2eSNTzjeAEY7U3uZSLa1DZhy4Po=;
        b=Lh74xyrv7rpmw+dpi3OZsIM66Y208w1k7rvMaPJ2ecrb0E5kCW18oEyzGj0cIhQmlR
         cPkff7C3jKUGILjH3bVPiz723eYpm0AsierdZ4skrUN7WCooDxbd9Dre/wG8K4a08ras
         FCvVAN3y9r8dvHwtjcfqYcGIsHJW6rETch8sCo0ceEMZB670ZGTd2a9rqNmx4rF5KzvU
         R8ISOPCJfrR3q/LwaUFUOQz0JqvQdeg5xr4/8Oa4yutZj48nsXiXEWK70RWtf7MDbPGl
         YHcnGPQ5i+2uWUP9RKcqketKqejrp8av/DF50xEJwpTfTgwWHnwh18CDDqXiEzuk4trH
         C+rg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777396536; x=1778001336; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4mHkN2xwVkuWH/B1Z4Hbwt0I5/IXNGH1RdG0Zb8nsFM=;
        b=KX0pWs0E79cOegLOBsHlIxrr/RczNRJeTALWToKti1T+ClE4VmEJm5XvQvla2Fpk+i
         QAMatUs63Eye3CwEPJoUBjcgLFLoOrZJjGe4xBHE78FCozCCatKygev6OrYlvY77X/x2
         jHSsgQwL7YukzyE6CZLRfnzwprWLBrdm+5ZO76B7GT2xArHMvrJAwd96XgP/N2fL3Qiy
         h8RVlnWdoJnauY/WTrxYAV1DY4F7rx8tVzP3C8Aa5AO2shFf3cBJhFqTpRLePKdCx6ar
         4uLOU6gCho6Zs3HVtwOigBYaj5KImMKUB4MD9UJiGmIRzJnpj07bPhAZzBccu/87+e3U
         TWdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777396536; x=1778001336;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4mHkN2xwVkuWH/B1Z4Hbwt0I5/IXNGH1RdG0Zb8nsFM=;
        b=Tu6q4d2ekO1ZMTci/1WGFWkrcUs1MInYhWRRUCmahumgNIbXEIcY8sVsJXCLNWteax
         bP8Se5zji88yoA1Oc7UUEgoReifT87aj0s8cFcN9uf1JYpyvj4w6OPlFXinbvgHXBafa
         45DMUO/hfh7/f1wje4e/1ITKY4p0yJmEFvBOZZCv3VPdtJAcJ9Gyw+825NRr4hBCsIa3
         CAWraVyqdM4R8gpf4TtXFD11boBhn1I/caN3X5z4yyHBf7Bw/dwurQY6E15rs3ESXkPq
         kizm0pV8ueHKaFt76sVmi6gdqcRkTg50byCYirH8m8z6DEBmVBU9lJm9y0P+zXFWoaGG
         vNNg==
X-Gm-Message-State: AOJu0Yxm1r4KVbNNfZzfZCJsXxxpKC1MRTIiWG5yx57qJZMAGOysCoxh
	7D1dLeQ9YB2c271PWJ4laP1rb/qyFT+KgbWTmfBq0HMkLIdWhEoijJCM4+SPxVWZcsLDcDWq2sV
	mcjMMIZWqu0nsqHdEjDPiQ014TLj8ScM=
X-Gm-Gg: AeBDies0YiR7VJyuApe33m2Y7y7qE5LliYo8g0evrn88Fk2iO5jvjF8IUOBodaKGsEf
	R2M2AdRc3DYdfXymr/jlJz7yk2O3iO9aEcbTFUpDABZ6MbO5DQTmaPdCQkN+yGcIY+xXGJ9oMJK
	+9c1Be2hdKzWCC4haAhIbxllkFGTy5frRetdhfXDTe3tWVXE3c2HB2lg97IvbMfkhF9vyg/a/GH
	fOlpkPu28F8sizV2XcwIT5pxIg/owjBxVtMQ08VjsF8uofiipdbll3WCTtjc3nMLyiPNvYodlTp
	BhB8E8Lqu8t03QrU
X-Received: by 2002:a05:7300:cd8d:b0:2e7:190:41d6 with SMTP id
 5a478bee46e88-2ed0e2e4725mr1026663eec.2.1777396535792; Tue, 28 Apr 2026
 10:15:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260428024400.123337-1-ebiggers@kernel.org>
In-Reply-To: <20260428024400.123337-1-ebiggers@kernel.org>
From: Marc Dionne <marc.c.dionne@gmail.com>
Date: Tue, 28 Apr 2026 14:15:23 -0300
X-Gm-Features: AVHnY4K6RjnbJfMAlZVpH30RZ8jL2Td5aRSXV2MW-u6vf0Qmr0Jq_0ZDVqUO6Dk
Message-ID: <CAB9dFdtCXMaavBB=NODcG5su8oTqgpYysSJ60bOj0Qivw1dG1Q@mail.gmail.com>
Subject: Re: [PATCH net-next 0/5] Consolidate FCrypt and PCBC code into net/rxrpc/
To: Eric Biggers <ebiggers@kernel.org>
Cc: netdev@vger.kernel.org, linux-afs@lists.infradead.org, 
	David Howells <dhowells@redhat.com>, linux-crypto@vger.kernel.org, 
	linux-kernel@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: CD6FF489DBC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-282015-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marccdionne@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 11:47=E2=80=AFPM Eric Biggers <ebiggers@kernel.org>=
 wrote:
>
> [This series applies to v7.1-rc1 and is intended to be taken via
> net-next.  Patches 4-5 could be left for later if desired.]
>
> The FCrypt "block cipher" and the PCBC mode of operation are obsolete
> and insecure.  Since their only user is net/rxrpc/, they belong there,
> not in the crypto API.
>
> Therefore, this series removes these algorithms from the crypto API and
> replaces them with local implementations in net/rxrpc/.
>
> The local implementations are simpler too, as they avoid the crypto API
> boilerplate.
>
> I don't know how to test all the code in net/rxrpc/, but everything
> should still work.  I added a KUnit test for the crypto functions.

Giving this is a spin with afs, I get this oops during xfstests generic/011=
:

[   22.838773] kernel BUG at net/core/skbuff.c:2295!
[   22.843470] Oops: invalid opcode: 0000 [#1] SMP NOPTI
[   22.850243] CPU: 4 UID: 0 PID: 5869 Comm: fsstress Not tainted
7.1.0-rc1.kafs+ #89 PREEMPT(full)
[   22.853205] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS 1.17.0-10.fc44 06/10/2025
[   22.855185] RIP: 0010:pskb_expand_head+0x2d2/0x380
...
[   22.867340] Call Trace:
[   22.867617]  <TASK>
[   22.869409]  __pskb_pull_tail+0x67/0x510
[   22.870719]  rxkad_verify_packet+0x297/0x3b0 [rxrpc]
[   22.872550]  rxrpc_recvmsg_data+0x150/0x760 [rxrpc]
[   22.875923]  rxrpc_kernel_recv_data+0x75/0x230 [rxrpc]
[   22.878500]  afs_extract_data+0x65/0x250 [kafs]
[   22.880238]  yfs_deliver_fs_fetch_data64+0x209/0x2f0 [kafs]
[   22.882017]  afs_deliver_to_call+0x60/0x5a0 [kafs]
[   22.882346]  afs_wait_for_call_to_complete+0x133/0x1f0 [kafs]
[   22.883019]  ? __pfx_default_wake_function+0x10/0x10
[   22.883445]  ? afs_wait_for_operation+0x2c/0x1c0 [kafs]
[   22.883878]  afs_wait_for_operation+0x9f/0x1c0 [kafs]
[   22.884342]  afs_do_sync_operation+0x1a/0x30 [kafs]
[   22.884632]  netfs_unbuffered_read_iter_locked+0x30f/0x6c0 [netfs]
[   22.884980]  netfs_unbuffered_read_iter+0x56/0x80 [netfs]
[   22.885266]  vfs_read+0x2e1/0x410

From the stack this looks like a direct IO read, where the skb passed
to skb_linearize() trips on BUG_ON(skb_shared(skb)) in
pskb_expand_head.

Marc

