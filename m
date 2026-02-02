Return-Path: <netdev+bounces-255977-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNCABQDwgGkgDQMAu9opvQ
	(envelope-from <netdev+bounces-255977-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 19:42:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D0A1D03F4
	for <lists+netdev@lfdr.de>; Mon, 02 Feb 2026 19:42:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 170FA300A8CA
	for <lists+netdev@lfdr.de>; Mon,  2 Feb 2026 18:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B19C2F1FFC;
	Mon,  2 Feb 2026 18:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tJaGx704"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EBF2F0C6A;
	Mon,  2 Feb 2026 18:41:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770057699; cv=none; b=dyKvezZYeh6VrT77FB2C8EGBR1/p0oz7PmhQxQJdLSSr6mrgrNno2X7nnaZBhBsEfKEkIkCnjqjES016ipgJhGRgumcgigyb+X0XFWNr/T0m7gP6rGsCjc+F6L7HNQvC3oXDRTnqtipd914SKYC+3tEDeunuCISbRHe4gGUf/DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770057699; c=relaxed/simple;
	bh=p4XRwZ/6o5ZB7v1K1pUKC2mtPp1ItnetvzxJkA5gE0g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MBtHVqpwHGZ0c5KXsgdAKtgBcNp9dwfkHdaDSzo5GwKIo9OHSiDTKp2Ul7Jt7i9iYgC8CdRHDGN/msjgPOW5BOiwfrIX0YOIZ0G7V/IQ5w6lEZKiigdHj3xd43cOeL74jFz0WaAkJAq/VCtBw9dbsVS8Xs2C/LsVdS8sVZ/V3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tJaGx704; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D067DC116C6;
	Mon,  2 Feb 2026 18:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770057698;
	bh=p4XRwZ/6o5ZB7v1K1pUKC2mtPp1ItnetvzxJkA5gE0g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tJaGx704PRvbxyLUAKLJY1RSxACoUJ+DiIK1abp3+JexDrY0r/BIIFaS6YRqsxL/x
	 s0cBm17VSQhYiuzjCc4GJChsBP/I8ojzikERV2vzTsrZDpF/G0Rg6kyv277aMPuflk
	 jD71FKz4cclCYyJBcFeUDNHcwLcE23DLZxj6OvScyTpKvvCPuOjq7ZfG/GOwjULnvQ
	 IYOPduH9oO6KPBvoO/5crPhKAJm3rMJ+Jm8lGzn3rfvWVZOeZ7YaHc8i/NWaRqj4oX
	 MxckD9NkdzDFpYTY1DoAum+pk9kaa4yW4Vey/FmKNmtMWM6QzpWh1tMDOrssaWEElr
	 uAmXAGVVme9Tw==
Date: Mon, 2 Feb 2026 10:41:36 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: David Wei <dw@davidwei.uk>
Cc: Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, davem@davemloft.net, razor@blackwall.org,
 pabeni@redhat.com, willemb@google.com, sdf@fomichev.me,
 john.fastabend@gmail.com, martin.lau@kernel.org, jordan@jrife.io,
 maciej.fijalkowski@intel.com, magnus.karlsson@intel.com, toke@redhat.com,
 yangzhenze@bytedance.com, wangdongdong.6@bytedance.com
Subject: Re: [PATCH net-next v8 15/16] selftests/net: Add env for container
 based tests
Message-ID: <20260202104136.4a7adbdf@kernel.org>
In-Reply-To: <9037828b-c7fd-4eb1-9dd8-19ee49063361@davidwei.uk>
References: <20260129222830.439687-1-daniel@iogearbox.net>
	<20260129222830.439687-16-daniel@iogearbox.net>
	<20260131163834.2c3d160d@kernel.org>
	<9037828b-c7fd-4eb1-9dd8-19ee49063361@davidwei.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255977-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[iogearbox.net,vger.kernel.org,davemloft.net,blackwall.org,redhat.com,google.com,fomichev.me,gmail.com,kernel.org,jrife.io,intel.com,bytedance.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6D0A1D03F4
X-Rspamd-Action: no action

On Mon, 2 Feb 2026 07:53:34 +0900 David Wei wrote:
> On 2026-02-01 09:38, Jakub Kicinski wrote:
> > I'm not a Python expert but the pre-init of variables that are set
> > later on in __init__() (on all possible paths) seems like a waste of LoC  
> 
> It's so that exceptions thrown -> __del__() don't complain about
> undefined vars.

I see. I guess that's cleaner than hasattr(self, "xyz"), fair.

> >> +
> >> +        ip(f"link add type netkit mode l2 forward peer forward numrxqueues {rxqueues}")  
> > 
> > Would we be able to do this with YNL?
> > no big deal but always nice to avoid the dependency on very latest CLI  
> 
> Hmm, I tried looking into this already. My understanding is that this
> can be done in C but not currently in YNL, not without adding a spec.

I thought the only thing C can do that Python can't is deciding nested
extacks.. Ah, of course.. I missed that patch 10 is not updating the
YAML spec. That needs to be fixed, we want YAML to stay in sync for the
families that are already YAML-ized.

> >> +    def _setup_ns(self):
> >> +        self.netns = NetNS()
> >> +        cmd("ip netns attach init 1")
> >> +        self._init_ns_attached = True
> >> +        ip("netns set init 0", ns=self.netns)  
> > 
> > Hm, refactor class NetNSEnter or just use its enter method?  
> 
> I did consider this but I didn't feel like it fit the very specific
> purpose of NetNSEnter. I needed the init ns to have a valid nsid from
> within the test netns, which I didn't think many other tests would need.

What about the "ip netns attach init 1" ?
that's the main thing that gave me pause TBH
Why is it needed?

> > Don't we need to also add a qdisc if there isn't one already?  
> 
> Sorry, why would qdisc be needed? The bpf prog attaches to tc. I don't
> know anything about qdisc, though.

There's a new way of attaching qdisc-less (TCX) but IIUC here you're
attaching in the old way. So you must have a parent object. The ingress
/ clsact qdisc isn't really for queuing packets, it's just a fake qdisc
that lets you attach TC filters to an interface. Machines at Meta have 
a clsact qdisc installed by init, but that's far from normal (try to
run this command in vng, you'll see)

> >> +        match = re.search(r'pref (\d+).*nk_forward\.bpf.*id (\d+)', tc_info)  
> > 
> > I haven't checked but TC doesn't support enough JSON and YNL doesn't
> > support enough TC to avoid re hacks? :( :(  
> 
> Yeah the old TC tool doesn't give me this info programmatically :(
> 
> Borkmann mentioned TC is outdated/unmaintained. I did use tcx via a C
> loader before, but that was removed in an earlier iteration.

Not sure what you're saying. tc bpf CLI supports JSON output since:

commit 3175bca7182b0867c6e9a3d5d1551fdecf70118c
Author: Davide Caratti <dcaratti@redhat.com>
Date:   Thu Apr 30 20:03:30 2020 +0200

    tc: full JSON support for 'bpf' filter

