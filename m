Return-Path: <netdev+bounces-276659-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wOVmB1yM1mnzGAgAu9opvQ
	(envelope-from <netdev+bounces-276659-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:11:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BEB3BF58E
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 19:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4527630231D3
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 17:11:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119723D6462;
	Wed,  8 Apr 2026 17:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="XGeP7RXL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79C993D47A5
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 17:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775668308; cv=pass; b=eY6vHInKhK17+LAyoPJk4qz9qi37QYnOhVQ2n8XJOcF0EGo+poTlm6qNRfI/W3FPR6Ks6lA1kno4flYaS/3W+qFnl1g39q4wD5yItfDFQodOEeNvmrL40y7bmI7jv+pWnttYkC6MF+8lbNufSXgMpScg8ms8DzXaWuzu8ieoxv4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775668308; c=relaxed/simple;
	bh=qP77t0y415mMp3tiL6i4HgNsLBFnCPd4NwAl1/4zwKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U1ASG+eJx4HA8b+WoXihiPr/oT9NfPCt3/6E3kaUEmaJ9g9Gcf2dckVrY+XwBkd8LgkABlSbFgUFZGqg96B7zmmacKOEQ+0M2xuUjWNziAE+37SUfwYyE5ZxZ8ALuAEI+3ZKvo7HCWx8L44Gfq2cVOIDj36Nq52doV+fbHGzGGA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=XGeP7RXL; arc=pass smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c76b6abdb73so97938a12.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 10:11:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775668306; cv=none;
        d=google.com; s=arc-20240605;
        b=dz8IiX9uUFqzzK6Eoah/PbuXkXZU00Cu1kMzollGeoMDshi61Kl9xRFvlfzCc7khDs
         Guw/JmBBN9//3k9Xc+mRs690qwAMJ8ivwADh0wA51yLCJENTDmjQJle6aUAHdU6epUbm
         I65RgLgJ/YEjM8edRTVeFgdMns3sf4AdwRHZLdWoGbavXbZXiBXX7SKVT6FCro4c8viO
         GDg6dq05BHEakFDKsq4SKWjokpJAHR1ckep0G2vnLfUdfcM09ZroMekhbE/F/NdHATl3
         sFaxz7+69WN9WGIFMuZrhMUbhCpc77GvgBSnSpM4jOhiSOOsBUtKkviK4dmqfmsIOnD/
         Hqlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=x+4zquy/7QCXXiYnwGpBa2AgCxSTbjK0oteYixrjc88=;
        fh=1zMP/ZuEUhZ92+Z5XYZDHXx5xca0OM0c592pU0epwR0=;
        b=CPmjoZHtySZV8p/GxMz7Gnv+rrnBolNKgKIywkB600+39u88GeydBwZfd6GlhLFBo4
         czuyDLtycfaYEk0urSUWxLBuF+k0Fr4gR5R6Juepr7NCboLm+XwgmvkD5dxqTcVB1OSj
         OJlZmPlTfjJj2J4P7aTEnguj7mDu0ELHmVYGmbICY7CiGCPK/lOmc+HwyftdQWXXAB/b
         kUsH06JiC+QRCExSreYWko3qbSSEXwSCyZ6p+hqzNLnOS3N2V22ux2NQVNf+zM0zfv7E
         WvgvUlswt+Y0JMENIHDgaT3pHLO5DMMXhfMHQ3Nx5KrgW/x9YwSr+TcWLALGmjNxXioq
         d0/Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1775668306; x=1776273106; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x+4zquy/7QCXXiYnwGpBa2AgCxSTbjK0oteYixrjc88=;
        b=XGeP7RXLWl9dk6t8/4wk6EHWZ0hlQ1kTHa5TbXg1NPfmJb2Im0SlQcylyaZm5AyoND
         ioUVdCeFbB0I6T4wM4g1MOaUczg8wrV6Mtjwr/mCQFzMbzbx715kOIP1O1mlonfj+Iwn
         +zYlLoAW8LLej6wYDoKrv0CCK6hPNkVe/GM5azya6Q8wEC2gocNmGF8twKXnB/biHRz3
         fkePqTzS2HdMg9wbc5eq+JegqWjH2d9RBdvS4NFi21KSHdAANnl6NkIXfUdWpPOsKFZ8
         gbkdxRk4fLaF892ke2iAFGfSgImqzcCSrgLITFaHtjUs37YFCPHhEjoXDmV36yb3FqUi
         tXqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775668306; x=1776273106;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x+4zquy/7QCXXiYnwGpBa2AgCxSTbjK0oteYixrjc88=;
        b=rffh00clfli6EeEcXen2yaW5bVatwNzIgldWlSY1wZmtI/txYiCZN2zBmkyvvPlpbv
         7Rgjsq8ArNRQxuzVYja1qVH2s3FVoFInlYF+X1H7fxUw5UyI9KQ3lpDUY9WJnGeEomBj
         6YsV9bUxvcLUxPtyTe+wP637ccmpAUfeGtP+G+5HNzeOV3oV2+BFmsxYDc2b8f6glmRp
         ZlP8p/kC7lxStqcL5khjj9quMTCIKaC2AXvcXhkHvCONQMldPuR19Qf622XO2NS8A7kK
         qRqv378WN5xbmN4Lc3cyJ0G/y7zIAY9JmVRwn0ZZc13bP6RFmhal7nQrbnxreWbplRfV
         j9zw==
X-Forwarded-Encrypted: i=1; AJvYcCXgYY+KSXiGNy7bw4a6AolN2zGxojRuMpw5xWHgZ5ik6ir8Js2YkzaG1yZb917bBvpWyhIs+w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrTIJlAyBxBSkSa0+0YBi5b3ITHpt1iDHNTUpx5n/Tsdpj3CsP
	AcIsbWuMXiLGO3B0/vQLWNDHD1JkTJ0tm0XHKre9yws2ApD/UjWz1Vtcrkc39Maz7TK7dV/JtGi
	o2ceC+xCmRmyu2vBVr36qGYD8CC/H9rn+kPLCYqDOEXshnfIPpooyVkGbKQ==
X-Gm-Gg: AeBDieulotMKNKS3V/kfxrf+Fz1Y2re0Ay7UAzI8l1le8JtbFnmEcz3OWjWM2siAqTF
	ONwIBCe4zXcOUZhYSo1PbTylPsyLjHR+hDVAOP8ApJAOFnxsDYO0GxJ9VUg17HHjBya7zLpJCVq
	XdpeW1JxjM3xbumUOvb9pXvpJ2lifjCs/X4E/M+DY65zlGYjLr1yCZ82ZiaALLhv4CgnP9KN267
	Lk5jVn/xcoN46zOyRuY6hgXHLHJkIhfexJ2K2ayAzSL+2eRCKgM7yHH+NtPpcvaa3Gqh3Dhw7Nt
	yo7Pd7kRZNpVyjnaSx1AXm8iadjJY3lZis1mafeIi/siZXxqxXAefU6XdlmTsxbLHx8+
X-Received: by 2002:a05:7022:602:b0:128:ceac:6db1 with SMTP id
 a92af1059eb24-12c28c2549amr138555c88.28.1775668305503; Wed, 08 Apr 2026
 10:11:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260403174949.843941-1-alice.kernel@fastmail.im> <20260408164825.GH469338@kernel.org>
In-Reply-To: <20260408164825.GH469338@kernel.org>
From: Alice Mikityanska <alice@isovalent.com>
Date: Wed, 8 Apr 2026 20:11:28 +0300
X-Gm-Features: AQROBzApB1QB6RBsWAbJra0X81QWkDkgY4ZRSfhXP5P50O776n-QC3XORAxlGuY
Message-ID: <CAD0BsJU8-NBeAGn_rPD-woZARNZ8vb6uJGMDNf70syRkzKiL4A@mail.gmail.com>
Subject: Re: [PATCH net-next] l2tp: Drop large packets with UDP encap
To: Simon Horman <horms@kernel.org>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	James Chapman <jchapman@katalix.com>, netdev@vger.kernel.org, 
	syzbot+ci3edea60a44225dec@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[isovalent.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[isovalent.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[fastmail.im,davemloft.net,google.com,kernel.org,redhat.com,katalix.com,vger.kernel.org,syzkaller.appspotmail.com];
	TAGGED_FROM(0.00)[bounces-276659-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alice@isovalent.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[isovalent.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev,ci3edea60a44225dec];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[isovalent.com:dkim,isovalent.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D1BEB3BF58E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 8 Apr 2026 at 19:48, Simon Horman <horms@kernel.org> wrote:
>
> On Fri, Apr 03, 2026 at 08:49:49PM +0300, Alice Mikityanska wrote:
> > From: Alice Mikityanska <alice@isovalent.com>
> >
> > syzbot reported a WARN on my patch series [1]. The actual issue is an
> > overflow of 16-bit UDP length field, and it exists in the upstream code.
> > My series added a debug WARN with an overflow check that exposed the
> > issue, that's why syzbot tripped on my patches, rather than on upstream
> > code.
> >
> > syzbot's repro:
> >
> > # {"procs":1,"slowdown":1,"sandbox":"","sandbox_arg":0,"close_fds":false,"callcomments":true}
> > r0 = socket$pppl2tp(0x18, 0x1, 0x1)
> > r1 = socket$inet6_udp(0xa, 0x2, 0x0)
> > connect$inet6(r1, &(0x7f00000000c0)={0xa, 0x0, 0x0, @loopback, 0xfffffffc}, 0x1c)
> > connect$pppl2tp(r0, &(0x7f0000000240)=@pppol2tpin6={0x18, 0x1, {0x0, r1, 0x4, 0x0, 0x0, 0x0, {0xa, 0x4e22, 0xffff, @ipv4={'\x00', '\xff\xff', @empty}}}}, 0x32)
> > writev(r0, &(0x7f0000000080)=[{&(0x7f0000000000)="ee", 0x34000}], 0x1)
> >
> > It basically sends an oversized (0x34000 bytes) PPPoL2TP packet with UDP
> > encapsulation, and l2tp_xmit_core doesn't check for overflows when it
> > assigns the UDP length field. The value gets trimmed to 16 bites.
> >
> > Add an overflow check that drops oversized packets and avoids sending
> > packets with trimmed UDP length to the wire.
> >
> > syzbot's stack trace (with my patch applied):
> >
> > len >= 65536u
> > WARNING: ./include/linux/udp.h:38 at udp_set_len_short include/linux/udp.h:38 [inline], CPU#1: syz.0.17/5957
> > WARNING: ./include/linux/udp.h:38 at l2tp_xmit_core net/l2tp/l2tp_core.c:1293 [inline], CPU#1: syz.0.17/5957
> > WARNING: ./include/linux/udp.h:38 at l2tp_xmit_skb+0x1204/0x18d0 net/l2tp/l2tp_core.c:1327, CPU#1: syz.0.17/5957
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 5957 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full)
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
> > RIP: 0010:udp_set_len_short include/linux/udp.h:38 [inline]
> > RIP: 0010:l2tp_xmit_core net/l2tp/l2tp_core.c:1293 [inline]
> > RIP: 0010:l2tp_xmit_skb+0x1204/0x18d0 net/l2tp/l2tp_core.c:1327
> > Code: 0f 0b 90 e9 21 f9 ff ff e8 e9 05 ec f6 90 0f 0b 90 e9 8d f9 ff ff e8 db 05 ec f6 90 0f 0b 90 e9 cc f9 ff ff e8 cd 05 ec f6 90 <0f> 0b 90 e9 de fa ff ff 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 4f
> > RSP: 0018:ffffc90003d67878 EFLAGS: 00010293
> > RAX: ffffffff8ad985e3 RBX: ffff8881a6400090 RCX: ffff8881697f0000
> > RDX: 0000000000000000 RSI: 0000000000034010 RDI: 000000000000ffff
> > RBP: dffffc0000000000 R08: 0000000000000003 R09: 0000000000000004
> > R10: dffffc0000000000 R11: fffff520007acf00 R12: ffff8881baf20900
> > R13: 0000000000034010 R14: ffff8881a640008e R15: ffff8881760f7000
> > FS:  000055557e81f500(0000) GS:ffff8882a9467000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000200000033000 CR3: 00000001612f4000 CR4: 00000000000006f0
> > Call Trace:
> >  <TASK>
> >  pppol2tp_sendmsg+0x40a/0x5f0 net/l2tp/l2tp_ppp.c:302
> >  sock_sendmsg_nosec net/socket.c:727 [inline]
> >  __sock_sendmsg net/socket.c:742 [inline]
> >  sock_write_iter+0x503/0x550 net/socket.c:1195
> >  do_iter_readv_writev+0x619/0x8c0 fs/read_write.c:-1
> >  vfs_writev+0x33c/0x990 fs/read_write.c:1059
> >  do_writev+0x154/0x2e0 fs/read_write.c:1105
> >  do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
> >  do_syscall_64+0x14d/0xf80 arch/x86/entry/syscall_64.c:94
> >  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> > RIP: 0033:0x7f636479c629
> > Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 e8 ff ff ff f7 d8 64 89 01 48
> > RSP: 002b:00007ffffd4241c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
> > RAX: ffffffffffffffda RBX: 00007f6364a15fa0 RCX: 00007f636479c629
> > RDX: 0000000000000001 RSI: 0000200000000080 RDI: 0000000000000003
> > RBP: 00007f6364832b39 R08: 0000000000000000 R09: 0000000000000000
> > R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> > R13: 00007f6364a15fac R14: 00007f6364a15fa0 R15: 00007f6364a15fa0
> >  </TASK>
> >
> > [1]: https://lore.kernel.org/all/20260226201600.222044-1-alice.kernel@fastmail.im/
> >
> > Reported-by: syzbot+ci3edea60a44225dec@syzkaller.appspotmail.com
> > Closes: https://lore.kernel.org/netdev/69a1dfba.050a0220.3a55be.0026.GAE@google.com/
>
> Hi Alice,
>
> A Fixes tag needs to go here.
> And if it's fixing code present in net - that is, the bug can manifest
> there - then it should be targeted at net rather than net-next.

Thanks for the review! I submitted to net-next, because I wanted to
piggy-back my net-next series on top of this fix without making a
merge conflict, and the bug didn't look that critical to go to net
(sometimes I received feedback that my bugfixes should have been
submitted to -next). I can resubmit to net, if it's something that
deserves backporting, or the maintainers can apply it to net instead.
For the Fixes tag, I can take the closest commit:

Fixes: 0d76751fad77 ("l2tp: Add L2TPv3 IP encapsulation (no UDP) support")

It's old enough (2010) to cover all supported LTS kernels. Or I can go
as deep as:

Fixes: 3557baabf280 ("[L2TP]: PPP over L2TP driver core")

where the traces of this code initially appeared, but the directory
structure is entirely different, and I haven't tested a kernel that
old.

> > Signed-off-by: Alice Mikityanska <alice@isovalent.com>
> > ---
> >  net/l2tp/l2tp_core.c | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
> > index c89ae52764b8..157fc23ce4e1 100644
> > --- a/net/l2tp/l2tp_core.c
> > +++ b/net/l2tp/l2tp_core.c
> > @@ -1290,6 +1290,11 @@ static int l2tp_xmit_core(struct l2tp_session *session, struct sk_buff *skb, uns
> >               uh->source = inet->inet_sport;
> >               uh->dest = inet->inet_dport;
> >               udp_len = uhlen + session->hdr_len + data_len;
> > +             if (udp_len > U16_MAX) {
> > +                     kfree_skb(skb);
> > +                     ret = NET_XMIT_DROP;
> > +                     goto out_unlock;
> > +             }
>
> As a fix, this looks like the right approach.
> But I do think this code could benefit from some goto labels
> to handle unwinding error cases.

Definitely agree about goto; I noticed it too, but I just followed the
existing pattern to avoid overloading a bugfix with refactoring. What
would you prefer: a follow-up in net-next with a cleanup, or
integrating this cleanup into this patch?

> >               uh->len = htons(udp_len);
> >
> >               /* Calculate UDP checksum if configured to do so */
> > --
> > 2.53.0
> >

