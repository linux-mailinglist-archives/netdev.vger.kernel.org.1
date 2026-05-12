Return-Path: <netdev+bounces-287165-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eBSlFG8uA2qd1QEAu9opvQ
	(envelope-from <netdev+bounces-287165-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:43:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3255B5217C0
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 15:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 60F8630C113E
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD51B397AE4;
	Tue, 12 May 2026 13:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E9MpqmiX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094B9383986
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 13:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591865; cv=none; b=eYb0NRVD3BP4e2Kq+i+A63pvSp8HWgsouRn4+9ACTtTZV4rB0cJ6mlmUfBYxoEXaw7RBYyfd898+6l0BNDYv3uEfMFiHUu3hC2WHfar6pI0EGVC93l2aYbGF9scLWHSkxJ3HV/ykyq1ukKtOOwEDPQRNquuQH4dDT+cI+tL1aP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591865; c=relaxed/simple;
	bh=AaSElHOtQvI/PMMQbN50yT1nLckA2+tupeEMNVvVjEU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qQE/WTR/db6dE73m45TgS5n7VEHK/Rn1USaAF2q8s4KCntWPrLUp658vRB6qkaGwFHf9MUbJ+QdQJ4sFvvhQUV+MAz5Af0pA7krqqjSWrY04UVKmLeeKxGtKSF7oxDMPSTpiN8Svp1C952v12JCu0Hm30Kz5KEAi6st5LIY6+Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E9MpqmiX; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-39394e1e8f3so46702591fa.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 06:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591862; x=1779196662; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pslgnpi6oJHX0FC9c/oZUmb0rO29LqRdvT8VmcUjOsw=;
        b=E9MpqmiXYAGUXqnYg8MlqnETjUcAQsyQtWev8ofcIWPWR+b90sdwG4eFjiRKFXF6Y1
         appgKW5aPS0ms+XNA/m393Be32w0QB1WXw/NZmdB2c0dlLzZ1Uc2FIhYTSs3CDEBhWZs
         vpn7xTwEk2GfPWrcrkSDEYyV4I0e9601dyDc9qRr+QjH9gF7qJtUPsBYr2HHzVGDhYbT
         W3LtqGb+UW3n8fmnK+ThAlZLFzQHiVRcWRda4tdks0exwqUo/m4K7lCWo0WdrCyiF2v8
         qvFB1EYkYonZZiQvZB2RZFfbZsK+NF3xnw1GIMNXTou6WotiYo3ZRaf5S4O8/XPL7igL
         HUFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591862; x=1779196662;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pslgnpi6oJHX0FC9c/oZUmb0rO29LqRdvT8VmcUjOsw=;
        b=YMuyWQ7LlpJr5RYvOX9REWviSuiU74iI6gOn5ZOcgudHwxHe0T7gv9zbSJuAhMpBKs
         6igjKdWMMvyhTVRLhimJzifKZ9P9LhisOW/Z+w/AAuvpQrSV+hSctv/8rFo9JylA9+0M
         HmGIT04k9sHtvwaCh4iSZyZDeC3GQieG6pNGAI7X75w5IzEZYI5k7vD7Hzjx9eCaM1Am
         CMwk12bZDXZXo/sfl44jKW2L7aqyGmSB2oDTm7rYaCka6puqD+HcmR1N+rL4mfLj3INQ
         iq6Q25Pq8rRAsoMNTcPSs2iFYnFCCpDEK0ft6p+rBhVe7ET+yv0ktCMibk3We+g8+8VP
         hrmA==
X-Forwarded-Encrypted: i=1; AFNElJ9pesKdkbRfJ9n/pAUvmIGYIywqZrJj4qJc5LOBSNfeVtidAVmrbwN0XqeKTUr7tNCowJRnz6k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbH0uVTQ2iENQM8l5+SScy3+dn2guxG8CWT7n9vsVifC0cdxXK
	rV357LVW3QxZfD4TuG6ub7iQiPoVmgkXNeo1cjt3cymIBmbzf3urG480
X-Gm-Gg: Acq92OE+L5WMZPm/6/7/usVeJVnqiZ0alF8B1Orsz4lI3YXa+Cmr4GRH0ThPSLNxqry
	coBnUdQ++9r77JpJEu80G6utFNja/sdi6ER3WtJxPRFKve5VbUdlSDDk1yBTdNlIalhTUWm4c73
	k+cvhQXxy/fZGXEH2Oq0hVtFuuN7BXT8sFrLtMlY1bI61s11gtHlW3iSaj8PPLy80DnDO9mKUyN
	P0f+aW91jSA/fr6HxhuZ8+iqrjpDUubwcsFH49dKMvAWj2qxEP7pxnkGLi5dthIaFvSEO8yLKTA
	o5wstjdtXa8lWNYI2B56qDSRY/0tv0gKSAj/ENEk7jeHykd+8mHaaRdP+r2WVYmMoMDsCdBUyyQ
	HpL2pb7umAXWBbI1INcdyEUe2gJmq7S/S0OKVgkkIUfD5KyVpqUVSSKCSJqRNf8Qw
X-Received: by 2002:a2e:a80b:0:b0:38c:63df:8298 with SMTP id 38308e7fff4ca-3940819a961mr45586531fa.28.1778591861755;
        Tue, 12 May 2026 06:17:41 -0700 (PDT)
Received: from milan ([2001:9b1:d5a0:a500::24b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-393fa029671sm32172131fa.36.2026.05.12.06.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:17:41 -0700 (PDT)
From: Uladzislau Rezki <urezki@gmail.com>
X-Google-Original-From: Uladzislau Rezki <urezki@milan>
Date: Tue, 12 May 2026 15:17:39 +0200
To: Ido Schimmel <idosch@nvidia.com>
Cc: Ido Schimmel <idosch@nvidia.com>,
	syzbot <syzbot+8b12fc6e0fb139765b58@syzkaller.appspotmail.com>,
	bridge@lists.linux.dev, davem@davemloft.net, edumazet@google.com,
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, pabeni@redhat.com, razor@blackwall.org,
	syzkaller-bugs@googlegroups.com, fw@strlen.de
Subject: Re: [syzbot] [bridge?] kernel BUG in __get_vm_area_node
Message-ID: <agMoc9Bvcxis8mT7@milan>
References: <69ff8c7c.050a0220.1036b8.000b.GAE@google.com>
 <20260512084754.GA181587@shredder>
 <agLyLko3Et-V2mRV@pc636>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agLyLko3Et-V2mRV@pc636>
X-Rspamd-Queue-Id: 3255B5217C0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-287165-lists,netdev=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[storage.googleapis.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email,syzkaller.appspot.com:url];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[urezki@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,8b12fc6e0fb139765b58];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Action: no action

On Tue, May 12, 2026 at 11:26:06AM +0200, Uladzislau Rezki wrote:
> On Tue, May 12, 2026 at 11:47:54AM +0300, Ido Schimmel wrote:
> > On Sat, May 09, 2026 at 12:35:24PM -0700, syzbot wrote:
> > > Hello,
> > > 
> > > syzbot found the following issue on:
> > > 
> > > HEAD commit:    9207d47f966b Merge tag 'for-linus' of git://git.kernel.org..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17e44d06580000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=d0f0911eedbc130a
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=8b12fc6e0fb139765b58
> > > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> > > userspace arch: i386
> > > 
> > > Unfortunately, I don't have any reproducer for this issue yet.
> > > 
> > > Downloadable assets:
> > > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-9207d47f.raw.xz
> > > vmlinux: https://storage.googleapis.com/syzbot-assets/6c5e883f31aa/vmlinux-9207d47f.xz
> > > kernel image: https://storage.googleapis.com/syzbot-assets/19f3e863ae5c/bzImage-9207d47f.xz
> > > 
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+8b12fc6e0fb139765b58@syzkaller.appspotmail.com
> > > 
> > > ------------[ cut here ]------------
> > > kernel BUG at mm/vmalloc.c:3206!
> > 
> > It seems that this bug was fixed by commit 30c19366636f ("mm: fix BUG
> > splat with kvmalloc + GFP_ATOMIC"), but then commit c6307674ed82 ("mm:
> > kvmalloc: add non-blocking support for vmalloc") re-introduced it.
> > 
> > Uladzislau, can you please look into it?
> > 
> > Note that the bridge is calling rhashtable_lookup_insert_fast() with BH
> > disabled.
> > 
> Yep, since vmalloc can be called with ATOMIC/NOWAIT flags now. I am
> checking this. Probably we can just remove below check:
> 
> <snip>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 676851d5cfe7..3d338e4bcbf7 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3209,7 +3209,6 @@ struct vm_struct *__get_vm_area_node(unsigned long size,
>         struct vm_struct *area;
>         unsigned long requested_size = size;
> 
> -       BUG_ON(in_interrupt());
>         size = ALIGN(size, 1ul << shift);
>         if (unlikely(!size))
>                 return NULL;
> <snip>
> 
> We have already the check:
> 
> 	gfp_mask = gfp_mask & GFP_RECLAIM_MASK;
> 	allow_block = gfpflags_allow_blocking(gfp_mask);
> 	might_sleep_if(allow_block);
> 
> in alloc_vmap_area().
> 
Actually since we are not allowed to call vmalloc from NMI nor IRQ
context. We should keep the check. But in a slightly different form:

<snip>
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 676851d5cfe7..273bbe49eaef 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -3209,7 +3209,7 @@ struct vm_struct *__get_vm_area_node(unsigned long size,
 	struct vm_struct *area;
 	unsigned long requested_size = size;
 
-	BUG_ON(in_interrupt());
+	BUG_ON(in_nmi() || in_hardirq());
 	size = ALIGN(size, 1ul << shift);
 	if (unlikely(!size))
 		return NULL;
<snip>

if any context disables BH, i.e. local_bh_disable() it does not mean we
are in IRQ context. Furthermore the documentation about in_interrupt()
says:

<snip>
/*
 * The following macros are deprecated and should not be used in new code:
 * in_softirq()   - We have BH disabled, or are processing softirqs
 * in_interrupt() - We're in NMI,IRQ,SoftIRQ context or have BH disabled
 */
#define in_softirq()		(softirq_count())
#define in_interrupt()		(irq_count())
<snip>

those are should not be used.

--
Uladzislau Rezki

