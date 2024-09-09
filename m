Return-Path: <netdev+bounces-126594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E26C4971F55
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 18:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CEA8288838
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 16:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72175165F17;
	Mon,  9 Sep 2024 16:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b="nMmj1KXf"
X-Original-To: netdev@vger.kernel.org
Received: from ewsoutbound.kpnmail.nl (ewsoutbound.kpnmail.nl [195.121.94.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7043A1758F
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 16:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.121.94.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725899644; cv=none; b=EM8pKSOkQSaEP9TsaoDDGM2rW+Z4057w1wl7fF7CJev6qTC7eVjeG3ICwhqLrhWqiTXW7LKiQkWLfb3OWHmma2wvuHnYtAiOoqgNDZTZXpSdG3f5rRTCxt6acbAHaAzPdUQWbO/IiIAZCmIwirhLuUgri9LFOQqODVKrvWrU3lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725899644; c=relaxed/simple;
	bh=JpaGLJfLyJtWY9QoXQOOONrXsrWM156IiSex+R+2jCo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QWLAkabMVBX3Q0QwmAfaPliH0GQS+uEaD5EpR3nO3Lal5iVO8Mc5/h6iT1+C2KJGjs/d6srN5Zkm7/eQHvpEraTpdJV1WURafQuUsCXoBpekYhQRkwgLJWJoHxn+fe5X/v+ECGEZq8M52jDgCntWlXn8Mgw/wR9vCje6NpKnaJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org; spf=none smtp.mailfrom=phenome.org; dkim=pass (1024-bit key) header.d=kpnmail.nl header.i=@kpnmail.nl header.b=nMmj1KXf; arc=none smtp.client-ip=195.121.94.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phenome.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=phenome.org
X-KPN-MessageId: 265bfb25-6ec9-11ef-afd6-005056abad63
Received: from smtp.kpnmail.nl (unknown [10.31.155.38])
	by ewsoutbound.so.kpn.org (Halon) with ESMTPS
	id 265bfb25-6ec9-11ef-afd6-005056abad63;
	Mon, 09 Sep 2024 18:32:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=kpnmail.nl; s=kpnmail01;
	h=content-type:mime-version:message-id:subject:to:from:date;
	bh=iN4XozhJK8yStyKultk7HPY3vWALfCWxHxWLq3OqMGA=;
	b=nMmj1KXfp88+9m80Ombb5tdBH6CyreAvzzuBhBXHdGYEkFHNcP37tWlblsVJSLPfuBKWoAinipabB
	 FDL6+Qv4h5yJmd6o0l7K3m3DQxZwHwPM8a+IVWgHBrpTd70elT+zG8gweorI4tdScap2vlvC/BQZh6
	 3DGLyL4QnmWdnc80=
X-KPN-MID: 33|4RGJpzsTYRaAVX/VxixGaGG6G3d00e2FS/nacjBNr6J19qc/XSI10nh9Cexidtr
 vPdkBw4Y3N9NAZcFCbKFYRLuV2le9e0ipuHDlpjm3oTk=
X-KPN-VerifiedSender: No
X-CMASSUN: 33|X/SSGHERXA4HfBEfljhxF0uAxtyp/wBMuRCN/RipTcp0kOhcQqqrIFNpAUkj1R8
 zuSxibKUxqJe4BXnoEZ40ZA==
Received: from Antony2201.local (213-10-186-43.fixed.kpn.net [213.10.186.43])
	by smtp.xs4all.nl (Halon) with ESMTPSA
	id 26498cae-6ec9-11ef-a2b3-005056abf0db;
	Mon, 09 Sep 2024 18:32:49 +0200 (CEST)
Date: Mon, 9 Sep 2024 18:32:47 +0200
From: Antony Antony <antony@phenome.org>
To: Christian Hopps <chopps@chopps.org>
Cc: Antony Antony <antony@phenome.org>, devel@linux-ipsec.org,
	Steffen Klassert <steffen.klassert@secunet.com>,
	netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Simon Horman <horms@kernel.org>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v10 07/16] xfrm: iptfs: add new
 iptfs xfrm mode impl
Message-ID: <Zt8jL9c9geA4T_p-@Antony2201.local>
References: <20240824022054.3788149-1-chopps@chopps.org>
 <20240824022054.3788149-8-chopps@chopps.org>
 <ZtBe_anpf3QOG8jW@Antony2201.local>
 <24F9C7DC-1591-44C4-8451-00BF3F593853@chopps.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24F9C7DC-1591-44C4-8451-00BF3F593853@chopps.org>

On Fri, Sep 06, 2024 at 11:04:45PM -0400, Christian Hopps via Devel wrote:
> 
> 
> > On Aug 29, 2024, at 07:43, Antony Antony via Devel <devel@linux-ipsec.org> wrote:
> > 
> > On Fri, Aug 23, 2024 at 10:20:45PM -0400, Christian Hopps wrote:
> >> From: Christian Hopps <chopps@labn.net>
> >> 
> >> Add a new xfrm mode implementing AggFrag/IP-TFS from RFC9347.
> 
> [...]
> 
> >> +static int iptfs_clone(struct xfrm_state *x, struct xfrm_state *orig)
> >> +{
> >> + struct xfrm_iptfs_data *xtfs;
> >> +
> >> + xtfs = kmemdup(orig->mode_data, sizeof(*xtfs), GFP_KERNEL);
> >> + if (!xtfs)
> >> + return -ENOMEM;
> >> +
> >> + __iptfs_init_state(x, xtfs);
> > 
> > I noticed __iptfs_init_state() is called twice during XFRM_MSG_MIGRATE.
> > This, the first, call does the right thing. However, the second call resets 
> > the iptfs values to zero.
> 
> Fixed in patchset v11.

thanks Chris.

I notice an unconditional memory alloc in iptfs_init_state()
xtfs = kzalloc(sizeof(*xtfs), GFP_KERNEL);

That is not what I tested. It looks odd.  Did you miss a hunk during the git 
rebase, or did you change the code?
I didn't test v11 yet.

-antony


> 
> Thanks,
> Chris.
> 
> > 
> > While testing I noticed clone is not workig as expected. It seems to reset 
> > values iptfs. See the "ip x s"  out before and after clone.
> > 
> > Here are two "ip x s"  output one before clone and another after clone noice 
> > iptfs values are 0, while before max-queue-size 10485760
> > 
> > root@east:/testing/pluto/ikev2-mobike-01$ip x s
> > src 192.1.2.23 dst 192.1.3.33
> > proto esp spi 0xcd561999 reqid 16393 mode iptfs
> > replay-window 0 flag af-unspec esn
> > auth-trunc hmac(sha256) 0xcba08c655b22df167c9bf16ac8005cffbe15e6baab553b8f48ec0056c037c51f 128
> > enc cbc(aes) 0xb3702487e95675713e7dfb738cc21c5dd86a666af38cdabcc3705ed30fea92e2
> > lastused 2024-08-29 12:33:12
> > anti-replay esn context:
> >  seq-hi 0x0, seq 0x0, oseq-hi 0x0, oseq 0xb
> >  replay_window 0, bitmap-length 0
> > dir out
> > iptfs-opts dont-frag init-delay 0 max-queue-size 10485760 pkt-size 0
> > src 192.1.3.33 dst 192.1.2.23
> > proto esp spi 0xd9ecf873 reqid 16393 mode iptfs
> > replay-window 0 flag af-unspec esn
> > auth-trunc hmac(sha256) 0xf841c6643a06186e86a856600e071e2a220450943fdf7b64a8d2f3e3bffd6c62 128
> > enc cbc(aes) 0x5ffa993bbc568ecab82e15433b14c03e5da18ca4d216137493d552260bef0be1
> > lastused 2024-08-29 12:33:12
> > anti-replay esn context:
> >  seq-hi 0x0, seq 0xb, oseq-hi 0x0, oseq 0x0
> >  replay_window 128, bitmap-length 4
> >  00000000 00000000 00000000 000007ff
> > dir in
> > iptfs-opts drop-time 3 reorder-window 3
> > 
> > After migrate: note iptfs vallues are 0.
> > 
> > root@east:/testing/pluto/ikev2-mobike-01$ip x s
> > src 192.1.8.22 dst 192.1.2.23
> > proto esp spi 0xd9ecf873 reqid 16393 mode iptfs
> > replay-window 0 flag af-unspec esn
> > auth-trunc hmac(sha256) 0xf841c6643a06186e86a856600e071e2a220450943fdf7b64a8d2f3e3bffd6c62 128
> > enc cbc(aes) 0x5ffa993bbc568ecab82e15433b14c03e5da18ca4d216137493d552260bef0be1
> > lastused 2024-08-29 12:33:12
> > anti-replay esn context:
> >  seq-hi 0x0, seq 0xb, oseq-hi 0x0, oseq 0x0
> >  replay_window 128, bitmap-length 4
> >  00000000 00000000 00000000 000007ff
> > dir in
> > iptfs-opts drop-time 0 reorder-window 0
> > src 192.1.2.23 dst 192.1.8.22
> > proto esp spi 0xcd561999 reqid 16393 mode iptfs
> > replay-window 0 flag af-unspec esn
> > auth-trunc hmac(sha256) 0xcba08c655b22df167c9bf16ac8005cffbe15e6baab553b8f48ec0056c037c51f 128
> > enc cbc(aes) 0xb3702487e95675713e7dfb738cc21c5dd86a666af38cdabcc3705ed30fea92e2
> > lastused 2024-08-29 12:33:12
> > anti-replay esn context:
> >  seq-hi 0x0, seq 0x0, oseq-hi 0x0, oseq 0xb
> >  replay_window 0, bitmap-length 0
> > dir out
> > iptfs-opts init-delay 0 max-queue-size 0 pkt-size 0
> > 
> > Now running under gdb during a migrate I see __iptfs_init_state() called 
> > twice.
> > 
> > I got gdb back trace to show the two calls during XFRM_MSG_MIGRATE.
> > 
> > First call __iptfs_init_state() with bt. This is during clone/MIGRATE.
> > 
> > #0  __iptfs_init_state (x=x@entry=0xffff888110a1fc40, xtfs=xtfs@entry=0xffff88810e275000)
> >    at net/xfrm/xfrm_iptfs.c:2674
> > #1  0xffffffff81ece552 in iptfs_clone (x=0xffff888110a1fc40, orig=<optimized out>)
> >    at net/xfrm/xfrm_iptfs.c:2722
> > #2  0xffffffff81eb65ad in xfrm_state_clone (encap=0xffffffff00000010, orig=0xffff888110a1e040)
> >    at net/xfrm/xfrm_state.c:1878
> > #3  xfrm_state_migrate (x=x@entry=0xffff888110a1e040, m=m@entry=0xffffc90001b47400,
> >    encap=encap@entry=0x0 <fixed_percpu_data>) at net/xfrm/xfrm_state.c:1948
> > #4  0xffffffff81ea9206 in xfrm_migrate (sel=sel@entry=0xffff88811193ce50, dir=<optimized out>,
> >    type=type@entry=0 '\000', m=m@entry=0xffffc90001b47400, num_migrate=num_migrate@entry=1,
> >    k=k@entry=0x0 <fixed_percpu_data>, net=<optimized out>, encap=<optimized out>, if_id=<optimized out>,
> >    extack=<optimized out>) at net/xfrm/xfrm_policy.c:4652
> > #5  0xffffffff81ec26de in xfrm_do_migrate (skb=skb@entry=0xffff888109265000, nlh=<optimized out>,
> >    attrs=attrs@entry=0xffffc90001b47730, extack=<optimized out>) at net/xfrm/xfrm_user.c:3047
> > #6  0xffffffff81ec3e70 in xfrm_user_rcv_msg (skb=0xffff888109265000, nlh=<optimized out>,
> >    extack=<optimized out>) at net/xfrm/xfrm_user.c:3389
> > ---
> > second call to __iptfs_init_state() bt.
> > 
> > #0  __iptfs_init_state (x=x@entry=0xffff888110a1fc40, xtfs=0xffff88810e272000) at net/xfrm/xfrm_iptfs.c:2674
> > #1  0xffffffff81ece1a4 in iptfs_create_state (x=0xffff888110a1fc40) at net/xfrm/xfrm_iptfs.c:2742
> > #2  0xffffffff81eb5c61 in xfrm_init_state (x=x@entry=0xffff888110a1fc40) at net/xfrm/xfrm_state.c:3042
> > #3  0xffffffff81eb65dc in xfrm_state_migrate (x=x@entry=0xffff888110a1e040, m=m@entry=0xffffc90001b47400,
> >    encap=encap@entry=0x0 <fixed_percpu_data>) at net/xfrm/xfrm_state.c:1954
> > #4  0xffffffff81ea9206 in xfrm_migrate (sel=sel@entry=0xffff88811193ce50, dir=<optimized out>,
> >    type=type@entry=0 '\000', m=m@entry=0xffffc90001b47400, num_migrate=num_migrate@entry=1,
> >    k=k@entry=0x0 <fixed_percpu_data>, net=<optimized out>, encap=<optimized out>, if_id=<optimized out>,
> >    extack=<optimized out>) at net/xfrm/xfrm_policy.c:4652
> > #5  0xffffffff81ec26de in xfrm_do_migrate (skb=skb@entry=0xffff888109265000, nlh=<optimized out>,
> >    attrs=attrs@entry=0xffffc90001b47730, extack=<optimized out>) at net/xfrm/xfrm_user.c:3047
> > #6  0xffffffff81ec3e70 in xfrm_user_rcv_msg (skb=0xffff888109265000, 
> > nlh=<optimized out>,
> > 
> > I have a proposed fix against v10, that seems to work. see the attached 
> > patch. The patch is applied top of the series.
> > 
> > -antony
> > 
> > PS: this exact issue was also reported in:
> > https://www.spinics.net/lists/netdev/msg976146.html
> > <0001-call-iptfs-state-init-only-once-during-cloning.patch>-- 
> > Devel mailing list
> > Devel@linux-ipsec.org
> > https://linux-ipsec.org/mailman/listinfo/devel
> 
> 
> -- 
> Devel mailing list
> Devel@linux-ipsec.org
> https://linux-ipsec.org/mailman/listinfo/devel

