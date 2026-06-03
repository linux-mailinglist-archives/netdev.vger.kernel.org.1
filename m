Return-Path: <netdev+bounces-294951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t7sdDdKqIGr/6QAAu9opvQ
	(envelope-from <netdev+bounces-294951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:29:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FC5C63B97B
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:29:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amacapital-net.20251104.gappssmtp.com header.s=20251104 header.b=RalLSyzg;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294951-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294951-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB85F3011F0A
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E62914CA29D;
	Wed,  3 Jun 2026 22:23:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CBA4B8DCE
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:23:33 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780525414; cv=pass; b=XKiYt6FX5HT6UnFhjw8I9siaiI3m0zFP4YLNPeo5hBxTGpx65QLGioB5kXkBpUgEXO9oTs6krCe6NaBoOz5lu7j7cFJXPIxj6TaAHAiud3UxCSHjYgwjqm7W0n/Rg4/jyhNs0G1bQcuJJUq0QPmOwaLcpAo47q1CbKp/66WQEZc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780525414; c=relaxed/simple;
	bh=qdFVVpm9+qBWydzXpCd5rc442R2RuxPVFhAYWPCKrjk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HxccStyCPwexmKpVJeweKZFMwWA/5N49A5zmBHoNL2OlfvatoJla1//wyBRqajwk2Gi13J5ay5s9cLta/AP1XMH+qthjwu4Z0p1JTIyD8fonTbFHttqTF8dhbgzaSsJ9J/1jH3f+bpUpxQpJx9Sfk9zLzYTTOvukHupdswpyNfY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=RalLSyzg; arc=pass smtp.client-ip=209.85.167.46
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa68d9dc18so4764530e87.2
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 15:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780525412; cv=none;
        d=google.com; s=arc-20240605;
        b=eHAUBn5oKh7y/0a5T0GJfUtAlkL4yLeBzXLWX/Bi8RxQH5i2iDn/doOhhh5PfEUDuA
         HI9Tf/Pi8xmh00nunTsOatneLxFoqwiUuAX7tKj0yi5rH5dPDR9SKCT3mEicyyHofAfd
         dOKv1+9jotskNK35OZa6j5HVgaHWzinGU/uedAJHptdi2Wjjxzzo+oGCLBOeKZtFbx1x
         EYDhQCEz+ODn8BRtiRgJgMV3Vg9WsPNQjDvJZHJqiyPbtK6latVTa/SQ05vrFbK2SMLt
         8RbpkM3uNl46aEPJtiKTiaKErIMqIcmmoFpI+HXH8rCBpeNGmYf7hFdOX5saelNh42vW
         z22w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=s3SPKunMho6E/CBsMnfM4oP5YS4R7re3HwYPdqVA40w=;
        fh=40A6+NLZp6l1ibff+ngd11m5BDJCHYy+1Kl3ZhS1uis=;
        b=eNOIliIS9dL0jQHSSCFoaUMJO+Chg0OjpihSGXaBgY+8e56fJ1OWoYvJs8h54413rE
         kKa1M43RIgCTALeF6iSlJ3Oc1kPsYyvXkkglCfpNSAGdifz8AI2hMNSW0ZyL7WY62RwV
         5AWXdlyuY+upfY7+CO9jiXzZGWWzh31EPJe8E4UrJulEeA6C1TnVnHntEc04sku/6Wiw
         R/t8l4Qxj5OshDwb+pCpxHXDDiwtr0OL60kzkX+yco/aWQiMSszHkOnoupMkQvSlkaMZ
         mTKPfdOMib/DiT0gyZpmlwuZnwbsdUdjm7HILNNMlrCMPXsgRB9+w9ahX0osS5y8Olvb
         O92Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780525412; x=1781130212; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s3SPKunMho6E/CBsMnfM4oP5YS4R7re3HwYPdqVA40w=;
        b=RalLSyzghTe1qbss1gZP+U06ITu7Qli1Rj++bTkIVnXwpKefNu46FFxyo7Kr/kG5cl
         48wD1gZfB1caHQ+1YK0vW5j4bSW4pSdrDVi/EJjmakvyuXR0UucKyvVAZ7jTFgSPgo0x
         rUe3+Gf1VWUiTvfaMIDkPzwhTp6Mg9aKah02vrYtLNc3nxSNWj6mrhofr8SichYncx/G
         kxmRgrLIgDY5kojDZ6IOX0Vx/QqOenTv+Yg6aP2K4hm7emQFwJFcuIKOhgo6wRUCRb9O
         DZZTKP38zlm/cob+oxXI9AO2hDozRFDe+wn35z3kQdZKAuzOpanyRX8Euc/584Ew58FC
         bHgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780525412; x=1781130212;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=s3SPKunMho6E/CBsMnfM4oP5YS4R7re3HwYPdqVA40w=;
        b=PXLG1HAYpGxKXQ2YnF6j66BM8cmZGx3wGe4JwkMeDqUy2xGQx5myaBMGonBluW9ziP
         I9yN5+/Ch90mM3yZSs093A5PmwY1oqoANb8VgOWhPG6TPWw6B98XKQXCLQ3xt8XbybAy
         /aenBbKKsWNURBzfEQGiZs8lGVd1PkYOCR98YXSSrXcct+QZ/KpnlZ5FYBE+hjqoXdSX
         T/oxojFOIx/kt0Niqv2vPFCu9aXBfmmXhRHWSWw59VJaPWmpw1lGdl8xkj8ODHKQWzZs
         c6l2wI/Pp29vCGymwHiaqh2WVN+PqVZ0emVaQaLib53MKBYjsOjzI8vhbm73a9X0Vk11
         ub/w==
X-Forwarded-Encrypted: i=1; AFNElJ+Kn+XkutHJ1AKCtJFSDpT7doT2Bws+JDtuWWEz98YmQJsL1Rz0kF7YauMCNQiwWCOJaXxVkes=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrBya0fsfbUGBLYRTrAQwntli/PRtndtn8nD0HLKhk3AymTzRQ
	E1Hmg+1oXDJjp13nIbgQPrGbGAWg/ggo8+f2+9RBonzdRCXqWCSEs+2DsLykNUZNiaUqVkcTo+6
	8ZeWgtxlHcNjYGrCYcMUX3cQV1bJahZdnmcVm/ixI
X-Gm-Gg: Acq92OGFdLyYHOVamqijaPG+VHUKvx4QUeYTMj6OfOHFPTVG6SAbMbF+P6qFpBqrx6c
	gjR+at66GggMHv4jJ3S/5MX8HWpSTrsf44oyQCD6eG3XmUDM4Taygi+4cCbl+5jWH40XFBOSQh4
	tSSgU3qe38EdUwZ5ueakoZzdAcEaJKiA207Y/TvnjEIfzUFsqzuuK7nwz3UWhTWsWnubb3ZzxDh
	QTkfgYpHU6vcDA9ZWT3iyAPIffSG8NPcuilbPIe7NBu3CKoY3iK9YRzHd0/D4suQMFqPTNK+3+I
	aAj4d33xpx/uX6qR9ww=
X-Received: by 2002:a05:6512:3d14:b0:5aa:7126:c645 with SMTP id
 2adb3069b0e04-5aa7c088c90mr1762489e87.2.1780525411782; Wed, 03 Jun 2026
 15:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
 <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
 <CAHk-=wizkDXRut5xLXRF-CVUVYMaZ5AOexxeghOAoXPb4yAvQg@mail.gmail.com>
 <CALCETrXzxubt4eWue3+wv7Fq9C2m7uu6bWPstqFh6Mo57bPwQQ@mail.gmail.com>
 <CAHk-=wiEwSjfbjfO74xu=UmkkdHXkJg5QNQ8pP-3iYmunmeV9g@mail.gmail.com>
 <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com> <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
In-Reply-To: <CAHk-=wgn3QTLj+F+XccE10dXY-UGWN8+fNLEvhsLw+tik9rOmg@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 3 Jun 2026 15:23:19 -0700
X-Gm-Features: AVHnY4Ikay6WVUle1y1S25sIv6i_k8jcErZspj4ec4V3SJVcTGqkjlXJTjro2bQ
Message-ID: <CALCETrXpqPMS487Bm8f8mHe8hv9DzCqoaW4UdoHetzYBUAhYLw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Askar Safin <safinaskar@gmail.com>, akpm@linux-foundation.org, axboe@kernel.dk, 
	brauner@kernel.org, david@kernel.org, dhowells@redhat.com, hch@infradead.org, 
	jack@suse.cz, linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER(0.00)[luto@amacapital.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294951-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[gmail.com,linux-foundation.org,kernel.dk,kernel.org,redhat.com,infradead.org,suse.cz,vger.kernel.org,kvack.org,szeredi.hu,lists.linux.dev,suse.de,zeniv.linux.org.uk];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amacapital.net:from_mime,amacapital.net:email,mail.gmail.com:mid,linux-foundation.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FC5C63B97B

On Wed, Jun 3, 2026 at 2:39=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 3 Jun 2026 at 14:31, Andy Lutomirski <luto@amacapital.net> wrote:
> >
> > I think I buried the lede too much and you're arguing against what I
> > was trying not to say.
> >
> > Maybe we should keep an API that does an optimized copy, from one fd
> > to another, that can send from a file to the network with at most ONE
> > cpu-side copy.  Not aiming for zero like sendfile / splice.  Aiming
> > for one.
>
> Oh, absolutely - that's what my completely untested test patch  basically=
 did.
>
> The user space interface was still there.
>
> And the networking side still continued to use the ->splice_write()
> thing for writing to the socket.

So I'm suspicious that you've possibly make bugs much (MUCH) harder to
exploit, but the underlying awful code and opportunity for bugs is
still there.  MSG_SPLICE_PAGES is still around, and there is still
(AFAICS) no actual coherent description of what it means.  There is
code that checks for it and apparently needs to do something special.
Foir example, some random kernel version I have checked out has this
delight in af_alg.c:

                /* use the existing memory in an allocated page */
                if (ctx->merge && !(msg->msg_flags & MSG_SPLICE_PAGES)) {

Grepping for MSG_SPLICE_PAGES come up with all kinds of terrors.
Check out the lovely comment in drivers/block/drbd/drbd_main.c, for
example...

And even with your patch, I think checking for MSG_SPLICE_PAGES still
matters: if I write to a pipe (using copy_splice_read or even just
plain write) and then I tee() that data, then I splice one of those
teed copies into a socket, then we hit ->sendmsg with MSG_SPLICE_PAGES
set, and we're hoping that the code does the right thing.  And maybe
all the bugs are fixed by now or maybe they're not.  Most of what your
patch accomplishes is breaking the connection between the buffers and
pagecache, so you can't poison /sbin/su.

It also seems kind of unfortunate that we can have skbs that contain
data that isn't actually owned by the socket in question, and, with
your patch applied, I'm wondering if the only case where this can
really happen is tee() and a handful of random drivers that send to
sockets.  (The ones in drivers/nvme/host/tcp.c and iSCSI seem like the
ones that people are likely to care about the most.)

I *think* that what I'm sort of suggesting is to drop this ability
from the kernel as well, or at least to consider it.  skbs would
always own their contents.  And something would get wired up so that
at least the cases of sendfile, nvme and iscsi to TCP or UDP sockets
would still works with only one copy, from the source page cache into
the socket buffer.


I suppose the counterargument is that, even if more bugs exist, it's a
bit hard to imagine a real attack involving tee, and one needs
privileges to set up nvme or iscsi aimed at an unusual socket type.

--=20
Andy Lutomirski
AMA Capital Management, LLC

