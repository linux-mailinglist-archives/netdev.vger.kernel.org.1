Return-Path: <netdev+bounces-284467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kAaUJbMH+mkEIgMAu9opvQ
	(envelope-from <netdev+bounces-284467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:07:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 180E74CFF0A
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 17:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4DF1E3018D56
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 15:05:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1729E48095C;
	Tue,  5 May 2026 15:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="emdA+EcK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EE434A3C5;
	Tue,  5 May 2026 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777993525; cv=none; b=qGi3Pd5Wt179ftGM0BzTij7XbVW3FoiSJ4SYzHw1q96/kFfCig5NIixy2JVXmQTosgrOO+q6SDKw3/UJq9MbVoak4y2atWSIAIr+2Rly1vxqRmick50Ovnz20WLWh9BoJrofEt4TpByCH35ThLyEcll4Dxyoa549wchIX1QtO/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777993525; c=relaxed/simple;
	bh=2GlpJb/TYW/pNu8C6bPuJkJ78AGv9S4CcnAu1FButqU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BXumIgycg+kfk+Z+OiAHecY/+Um9JHdu4qEsQ0vvEa0txee715cmzOVBaC4gzE0b7V3GpBo1fCq7pVH9N6zKuh8CBVvWdhAzbTm37oLcJiHDpkg2nGhEHZC5YaBHkIRIEScNGRq2mHXvPXu1DQ8dNMk1HfNQXoganOdu2Mb4QRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b=emdA+EcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42617C2BCB4;
	Tue,  5 May 2026 15:05:23 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="emdA+EcK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1777993521;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=n/PjvtdnxjKogdxEJRfX74XZLGxhj7pPVIUidngzdYI=;
	b=emdA+EcKpSLwu36MNe7/d73mfG8Qb60oSgaxeFmJtqdQujDaJYKviwMu3gmeya/MMZregz
	m/78IiqJISqonQKXX0Ts6dGW3qNRfodIDZmLBuFr3oUXVzIEgO5A2c0u4gr7SEbL/2BsE2
	WBWgX2mTagt8OVQgB6imiSlycq6Rlp0=
Received: 
	by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 9b2cd7af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 May 2026 15:05:21 +0000 (UTC)
Date: Tue, 5 May 2026 17:05:19 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Valentin Spreckels <valentin@spreckels.dev>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	wireguard@lists.zx2c4.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireguard] wireguard: prevent ipv6 addrconf via
 IFF_NO_ADDRCONF flag
Message-ID: <afoHLzrKk6AOetQk@zx2c4.com>
References: <20260208170545.31942-1-valentin@spreckels.dev>
 <abHz3xcsLhIPc_Jn@zx2c4.com>
 <c486b63c-521f-4972-80bf-ebb2bfe04724@spreckels.dev>
 <afefejiY8SX8UfTm@zx2c4.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afefejiY8SX8UfTm@zx2c4.com>
X-Rspamd-Queue-Id: 180E74CFF0A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[zx2c4.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[zx2c4.com:s=20210105];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[zx2c4.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284467-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Jason@zx2c4.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Sun, May 03, 2026 at 09:18:18PM +0200, Jason A. Donenfeld wrote:
> On Sat, Mar 21, 2026 at 08:20:53PM +0100, Valentin Spreckels wrote:
> > Hi Jason,
> > 
> > On 11/03/2026 23:59, Jason A. Donenfeld wrote:
> > > Hi Valentin,
> > > 
> > > On Sun, Feb 08, 2026 at 06:05:45PM +0100, Valentin Spreckels wrote:
> > >> Use the flag introduced in commit 8a321cf7becc6 ("net: add
> > >> IFF_NO_ADDRCONF and use it in bonding to prevent ipv6 addrconf")
> > >> instead of mangling the addr_gen_mode to prevent ipv6 addrconf.
> > > 
> > > Can you give some more context here? Why was IFF_NO_ADDRCONF added when
> > > the IN6_ADDR_GEN_MODE_NONE method has been working fine? What's the
> > > difference between these approaches? I don't doubt that your patch is
> > > correct, but I would like to better understand this.
> > 
> > Only wireguard configures addr_gen_mode inside the kernel, otherwise it 
> > is only set by userspace; userspace is also able to overwrite the 
> > IFF_NO_ADDRCONF set by wireguard.
> > 
> > Commit 8a321cf7becc ("net: add IFF_NO_ADDRCONF and use it in bonding to 
> > prevent ipv6 addrconf") introduces the private interface flag 
> > IFF_NO_ADDRCONF, which isn't accessible by userspace.
> > 
> > Thus use the IFF_NO_ADDRCONF flag in wireguard.
> > 
> > 
> > Does that answer your questions? If yes, I will submit a v2 with this as 
> > commit message.
> 
> I applied this here:
> https://git.zx2c4.com/wireguard-linux/commit/?id=88427bcbe5bd3711de387b1c1f6540ef6fc05a78
> 
> Sorry for the delay! Patch looks good as-is, once I looked into the
> internal mechanism.

I'm backing this patch out for now. It seems to break the selftests:

    [+] NS2: ping6 -c 10 -f -W 1 fd00::1
    ping6: connect: Network unreachable

Try it yourself with:

    $ make -C tools/testing/selftests/wireguard/qemu -j$(nproc) 

I assume it's because of:

        case NETDEV_UP:
        case NETDEV_CHANGE:
                if (idev && idev->cnf.disable_ipv6)
                        break;

                if (dev->priv_flags & IFF_NO_ADDRCONF) {
			[...]
                        break;
                }

Feel free to submit a v2 if you think this is fixable or if the tests
themselves are wrong.

Jason

