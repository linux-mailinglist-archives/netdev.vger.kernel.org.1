Return-Path: <netdev+bounces-294541-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P1IUBsGkH2qWoQAAu9opvQ
	(envelope-from <netdev+bounces-294541-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:51:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 671EF6340AF
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 05:51:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amacapital-net.20251104.gappssmtp.com header.s=20251104 header.b=pACszlmx;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294541-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294541-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 28DB430214C1
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 03:51:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDCE3ED3DC;
	Wed,  3 Jun 2026 03:51:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 725B23E4C75
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 03:51:18 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780458679; cv=pass; b=tFB92aWg8lmqICfnamP7MQZ14iwKhGrdPzPjtl07/m/NrF42Yvrr5sevweokv2Lul4kOCk74jz8yA9InJbWjPj/9DOU/pXUT6yq4jSYjFhaahmKSFVJPXhDF8N6UbsYnQZLNhe1ib3WToR8tt0TdW/X+GFi1NTbIsqEeVSINCC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780458679; c=relaxed/simple;
	bh=anjN+nTOXqNBWHTS9fQMFqGEaXiDXaRnabq18gPz6kk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sZTXaK2azs4j1SM+c5wOQY1zXW19Kkoa8Q+y5isx/Yjuc2yqiAYn7sBNi3JyYS3B9ekmpdWs/Vrky/qRzVRh9uO7xojpAXsSVL1vbuDxmLBxsRWN5EzwpqO8TygDhdTizVQr3MfAj9RZVB0pRQyCtVi+7tQEve2S7jtg0vVpRqg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=pACszlmx; arc=pass smtp.client-ip=209.85.167.46
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aa6cdebc33so2579437e87.2
        for <netdev@vger.kernel.org>; Tue, 02 Jun 2026 20:51:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780458677; cv=none;
        d=google.com; s=arc-20240605;
        b=AkfyAcJ2LER4Zg+tcGWYKi8Im7Yp6G4IzqxJcyJlWSNEkb5zxd8aI0aMflNBN4ejq+
         zTlSgIZOvrhxyPgyoXwoONxLOUK/tfmOd1LVsd0+hcSv2pNSWbhiGkuzulRXOYrOb/xv
         t8IfTvZ3tTVrOLEx8Jjeuv+uGAF1UURvTlsWIjN7VEDrI62+Z49hKrD3pZNE5SzVVVx+
         NwB26MO3zNxO+zDq/je46chrsaMJzpQPeTWtJvyHk6xpEe88jmXnvNNEIKAtzMUvII4m
         Ys8q1hjr/p5PgWGS9X/6tc5qyPHY46f4qRmjuPtU27Lu95AKP/oUgys41dxwqbJwp1P/
         IMcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hLctvnpeHHKwaBCwCGUFctRGdwexf3XsJleZhrQYpkE=;
        fh=h+9os9kEUdWaWqVnyvzfkRe5SClKYiyHv/984MNapU0=;
        b=fEYurG1h8A62bLXimx+WsVGeFEFKWR8YGb7EwQ6M+UMJv6A3t3gI66bQinMHU+qFP1
         fKlRaD6LT7n1ueEuBzb3JAzJzFGQ1qomdrpcNlXOmliP5z/QpdhItjxapMm85ZplZqHg
         NH8Ovn8mHxwUpk8Aj484UGWAoyhxvjL2kWp0/8ykJscbrdfWL7QJ+NyYr65GTMLQxJVk
         fgTCaCrfge8Rz7ZeKzyzwPt4M0rOsjXOAlDInnTK3JIin3aJuIaIyJtA3XDzaIE6H+QV
         2sMm67eFL1NabYu3WqTlsMpyV8Z05T2rd6639OB+qGPkuxoOLAWp5hmIy9f9i4wZ5rtK
         uBLg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780458677; x=1781063477; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLctvnpeHHKwaBCwCGUFctRGdwexf3XsJleZhrQYpkE=;
        b=pACszlmx3Ln9947bgLM/fx/VQ32WWmcPDl9URflypHU47mh09zCUoDdMN0TpbQjwR9
         L4NKNbN7iJdFMkZ549+BK69za4lWIlIR3xkSdAT6lkQPV8xhZBiZlxXrUY96pwWuJaxt
         P4x/pOcbxq556iCMRflqurGV2i89lN/szwObKm/fmWCeSr/BRC6KFwjmPjQnL6ZZ9JNS
         EIIxI4iPFVjGJsfoYJ/CFvh2a/nsPjzBg9jzRp8MP2Ht/HC38+DL88wJ4lIup0I+zzsF
         fmJMB+9s5U7yo9b1xnvi8lyffz4vX7cPHzYB3U02huylW/P16aPOngD1G2DduXNGEGC+
         tORA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780458677; x=1781063477;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hLctvnpeHHKwaBCwCGUFctRGdwexf3XsJleZhrQYpkE=;
        b=r7kqyVR7fDpnUjGRqRfEKk6LKNXNkJ3SKByqJ+8+qRQMGoq1c8kKtnB/OQFDqkbZQE
         agMSZnyOCnlRZFTMo6h2+nD7wktsAj9dpeE09QALuVfFwlAZnzyKa1zQOEPMCmiJeUHv
         H1lOnjwSObl5xbfJCxdgT0Msm/MhJfjy3tATwT3+jdb4PkdiSHiNCMTuP9glsQRqDeX9
         zlNlV27Ipkow3SQDhZAVZdum40C72wEEq/8WXJHnnnYQmF+WU/UwYnUiuweNVjwSg1qD
         jyc++ZIrh66TvMHqYWteGpwcNmB6H5WeMgEbYsXofnIKzPQYslHsqAVh3TB71Lqq10+4
         L1NA==
X-Forwarded-Encrypted: i=1; AFNElJ9CdnE5RRN8AzdjzlEv80h6f+nszNwuSOrhHed1agQWMqxbFn+vTuFutYs9oAE6hPBAq9LqNIc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8EySXeVzqPbClWibGnIc7YbBvi8Coq3wCttCfDqQ+RvJkc9jd
	T3Ut8tq4+MZ5lpo4HPytQ+CDckX+FLEaijzFYj2t3k0CIOiTo4oaxYO86ss2pxOvnyhexz3vITC
	pSn9bfmz6pEhoQmv6PDdGxhBlnN7rpsYFSmvY0GRB
X-Gm-Gg: Acq92OGCs6U9W1T5/p8+c0X48Zn4VVz6zuni70lWJtU8qCCuhgBjOz0yE1SColaL/5u
	VOthWA7MnhKhGgizrjdSMop9DWjit3aYrX/Z5MqGvRvajcys+tjJXCHnMQa0MjCBJi9vGIL6COm
	d21loPRZwF0y9/Bm8gz/PNyjp+uINs0XylwLuB0krHitn1HhCjakMDCry6xs1eLC1m+plyTLZOX
	OcXqtbGw9GKE6o53HiURKHwF751ZFDdR+E5Qjdoataf9I8XfCBAR8HcKWopaOfabokEWth3dIyX
	UdCbK7VpbXnS270=
X-Received: by 2002:a05:6512:1587:b0:5aa:6d0f:1dc7 with SMTP id
 2adb3069b0e04-5aa7c0bf470mr459675e87.19.1780458676548; Tue, 02 Jun 2026
 20:51:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHk-=wiAqf0PdZ4AKj_4riUnnEb=g_ZNPkLnXrByA9BBHYiFRg@mail.gmail.com>
 <20260602225426.122258-1-safinaskar@gmail.com> <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
In-Reply-To: <CAHk-=wgKy4dP0oQCNKyMQQf3-uVpaigmDyH6_T0Via76gWST9g@mail.gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 2 Jun 2026 20:51:03 -0700
X-Gm-Features: AVHnY4I4B2wg7ilf1zQmemgKARTlVUvTJ9JxDnVBlHgiDg-UsafiWLR7jiVDKio
Message-ID: <CALCETrWx8-Q5-rK1KnAPCxCbXaWCd=Yfs_Pr8qVMa8k8L6of1w@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_SENDER(0.00)[luto@amacapital.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-294541-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp,amacapital.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 671EF6340AF

On Tue, Jun 2, 2026 at 5:12=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, 2 Jun 2026 at 15:54, Askar Safin <safinaskar@gmail.com> wrote:
> >
> > Pedro is talking here not about this vmsplice patch, but about
> > my future hypothetical patch, which will remove splice-pagecache-to-pip=
e.
>
> That absolutely would be my suggested next step.
>
> Something like the attached - get rid of filemap_splice_read()
> entirely, and just replace it with copy_splice_read().

Am I understanding correctly that this will completely break zerocopy
sendfile?  sendfile is, internally, splice-to-a-secret-per-task-pipe
and then splice to the socket.  How much to people care?  These days,
a lot of high-bandwidth network senders are sending encrypted data,
which is not zerocopy frompagecache.  But there are surely some users
that care, for example the person who went to the effort to implement
IORING_OP_SPLICE:

commit 7d67af2c013402537385dae343a2d0f6a4cb3bfd
Author: Pavel Begunkov <asml.silence@gmail.com>
Date:   Mon Feb 24 11:32:45 2020 +0300

    io_uring: add splice(2) support

Now maybe someone cares about a different path?  Splice from socket to
pipe to file?  Splice from socket to pipe to other socket?  Does
anyone do any of this?  One can, of course, recv() directly to an
mmapped file, but then you pay for page faults, so that probably a bad
idea in most cases.  At least all of these cases don't have spliced
buffers that refer to a potentially read-only file.


But I'm a little concerned that zerocopy sends from files to network
are actually important.

--Andy

