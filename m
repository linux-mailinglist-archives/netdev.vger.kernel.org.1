Return-Path: <netdev+bounces-268814-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2BFBDHfjuWmnPAIAu9opvQ
	(envelope-from <netdev+bounces-268814-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:27:51 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8203C2B455A
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 00:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D40D30A879A
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 23:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C6C3EB7FF;
	Tue, 17 Mar 2026 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RnMRxZYO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CE3450F2
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 23:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789785; cv=none; b=Spe9lzSDa1PN3ZWrEIpegoPutp74CIX9/+GxJjHZvky4GHMEfvsce1vX+R/ziE0EbDd+SdvOlT4MTxNY6rgwsR9x9OUF9fSXk3S4cMJGVFX/ZCehBG2JRXOR2q+k/uYrG+vPiBIFBePRU1HGrYONr6UUdSGyhtpLT8DWRUGnf3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789785; c=relaxed/simple;
	bh=U+35fxnxuLR6FtUXOAabPz+lR3mz5wtMpq/EJH1H7VE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=byMjLEPnTMthb1drOuu7E5OyVoV1g74vhbIChKDLlotrXB+S3plAr4g+4hPrNTB10e9szxGpmZu6MbbNvmQydbokh3t9ky6wqVMG0ryprdull7u+uiiBkGjrPuQpf4ZwoS/D3MslbvBHQGUFDD8w+Y+kfmiuAQNDoBAgPYL7+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RnMRxZYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E53A0C4CEF7;
	Tue, 17 Mar 2026 23:23:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773789785;
	bh=U+35fxnxuLR6FtUXOAabPz+lR3mz5wtMpq/EJH1H7VE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RnMRxZYOGJr0LloNTe5BgFBljGgsc/o5OSfdxGiuYPJqh3871kGOfbd1FVB51CCkF
	 YjtTMh/4v+CsEoP2ozJ21yW8pORP7/Buuno9RUKWkuGZLpLJuiLjRdtqi5UZFHevh7
	 3zW9ByRJ5aDhz2vzvldX2nzg1fM+rH3DjWdHVwNO/iJ3xpAytzWoYGAoY+w9xsaU/O
	 YrkRVQtlqzHZsRPB7qvtqx0PcUSbK0TaaJ8N/kGSlzJ9SK/5yTYyHo2OtXnfY6C2cd
	 IKgl3O7lJ1vjsEsW2zA7q8+GFd+6zx9H+XOEf1d3sBozZEBgdKq6pt3FpkiKM+ofb5
	 I8EmtvM+Ae7FQ==
Date: Tue, 17 Mar 2026 16:23:03 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: =?UTF-8?B?VGjDqW8=?= Lebrun <theo.lebrun@bootlin.com>,
 nicolas.ferre@microchip.com, claudiu.beznea@tuxon.dev,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: macb: allow MTU changes while the
 interface is running
Message-ID: <20260317162303.4065e307@kernel.org>
In-Reply-To: <1aae7cf5906c753c0ff5356b8e1f53e2@tipi-net.de>
References: <20260316092720.39198-1-nb@tipi-net.de>
	<DH57URLYG3TU.B4HGNJATLFMU@bootlin.com>
	<20260317152330.32998fdd@kernel.org>
	<1aae7cf5906c753c0ff5356b8e1f53e2@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-268814-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:email]
X-Rspamd-Queue-Id: 8203C2B455A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 17 Mar 2026 23:58:21 +0100 Nicolai Buchwitz wrote:
> On 17.3.2026 23:23, Jakub Kicinski wrote:
> > On Tue, 17 Mar 2026 18:00:02 +0100 Th=C3=A9o Lebrun wrote: =20
> >> Reviewed-by: Th=C3=A9o Lebrun <theo.lebrun@bootlin.com> =20
> >=20
> > I told you recently that open / close is not allowed.
> > So why are you putting a rb tag on a patch which does exactly that?
> >=20
> > https://lore.kernel.org/all/20260306190948.44d23f8f@kernel.org/ =20
>=20
> Just checking if I got the idea before submitting another approach.
> Something like:

Hm, not really. Take a look at fbnic_set_ringparam()
You need some struct that's config + pointers to all the resources.
And make all allocation helpers operate on that without touching the HW.
Then you can just allocate a new struct, give it whatever config you
need, call all the alloc helpers with it. Now you have a fully
populated struct and haven't touched the HW yet at all. Stop HW,=20
swap the resources, start HW.

I did something similar for the nfp driver but that code has been
slightly adulterated since I left Netronome so fbnic is clearer :)


