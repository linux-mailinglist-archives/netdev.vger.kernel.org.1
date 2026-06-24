Return-Path: <netdev+bounces-301745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 6SQEHvEZPGqAjwgAu9opvQ
	(envelope-from <netdev+bounces-301745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 19:54:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E7356C0856
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 19:54:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=dpkHGD01;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301745-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301745-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 14C7130DC3BC
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC7F3DD843;
	Wed, 24 Jun 2026 17:52:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E78423DD85A
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 17:52:23 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782323545; cv=pass; b=gJ2fv3GVEe2FuLDGTcGJguuncqgXnWV16Yo48QCiUqW7Gm3FznCkjhMSCuNhl8jas7J93fN9hn5+6JaV6bPw9SQOKCWF0eQrnUmaL/sFiBznwLtOeQsn2L4KYdUveHYe1fuY+zSUopRLD2CkwedZiRNteGkPm1RqCIMW1iwurQk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782323545; c=relaxed/simple;
	bh=BUqTLbaqUYoKdg3iiW+mLowzEHeWjN5LiDlT2QPIVfI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2K18MdEOYg2/mjMQiXEr0WlLEPX83UYr25K/hrozq6hbYro73+QC+Xk10tRQdDwChKE18umdaT1rgiQnOyXxEDDapcK5IbI3zmC//qa0e9ROzIppr4BugFVI8zxGyUGAx9JqZTVG+3H7yADw2XgN0Y+/zVk+Q4lHW2acmu/ILo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dpkHGD01; arc=pass smtp.client-ip=209.85.161.50
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-69de9bc590aso985432eaf.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 10:52:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782323543; cv=none;
        d=google.com; s=arc-20240605;
        b=VD9SER2McwpsyCQ83pJnwES+C7Q/72QmxjWd0Kz5Q3WfKlO82qiN8RAY7vF7GGddkT
         Gj7vet+vwJQLxHAhsnh2yZnVewS5PFWts7USdmZ03SzML/9bRQFEub7bf5/qmSLW/Nmv
         OX0BXp5jtEf+MjYIQvHwFlyaN3soCyj46FDMbocsjpukgkOIIbePIz/0lexzJquRzWG7
         rZmd8CJpRcPkfDz1jrFwFHYH+RsSY6N3ZoCfkaQxUqLrcc/z3NC3NRli8fg84Cd8Msng
         IpjkS7YiJTYzmi3cG5TTkWNrRK4QR7L67tlKSomId7Y3UbRBtvBvMMG6ukJ3Ne/68t9u
         o8vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3yIQCK+bzs9AyvsQ75CttiaMe1DqI5YJnh3974Pl4HA=;
        fh=m60VJL/f6UJRH9666UcybldfNvpxcreXk3obMnnUWdg=;
        b=fbqgquUQ830xYC6FEKTx30ai9ciILXU5udYYXcqaOxzA1tDcy+wZpglxPCktC6hl82
         230eh3TV8qcaqhKRqrg4iIjZ0IRWTyzSB8Mtz3qEHKDnC/v0GHxiih1SVx8vAZKrTRkA
         EDhEqazC3TZbTY2x9DTJ9PWWaQ8iBjNNDZ8n7KfycQsVvttDnWE03At6rqCCP3mvLIzM
         opeUBc4xWhQ/PWy5B6S7JOo1ESqcoYrin5rucDGk05BHPCYClOmQ6PzhjRW/C1fBiX0p
         qcjD3r+sXMNbL8GN/FuNfJvjP1llcASqmip2C0m7+ibqb/fhO7hiQCGHovJ7uG6E0yUu
         x/Iw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782323543; x=1782928343; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3yIQCK+bzs9AyvsQ75CttiaMe1DqI5YJnh3974Pl4HA=;
        b=dpkHGD014kNzTRmym8Xmzhh8Uh3XEehN1LpWs11WjWLOwbVCSfy3LK4k12qPPzlUI8
         9i89Gf/7LdY5kOKX3E9NlLyV2BVEERCY3dARyBZQRO9GOh3T2jtI5mYBD/nZzIP5vR9u
         7G3nK9LtnnR+BtGBzQyuj+dDtwmlLx+HYSOClLHbyu4rV0nHz6aB/SOU1l5rVdMlryG1
         +5SRzsGt0xe4rKkknnnaypLkt63oIH3LQfmV+h57Kq7m/UYuq5qnHPbaxmg4/QPGi4YM
         5uOkKOahVS+/BHS9n1K4Q7yHOdaAZy0Bf7YACl2rlmQ0PmgaZIQL/GE1UBWyknVXIueL
         fEhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782323543; x=1782928343;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3yIQCK+bzs9AyvsQ75CttiaMe1DqI5YJnh3974Pl4HA=;
        b=qifUApRdntlcgNbmDmCZ4U+TIe8z/8PQYfjgpxEFw+Nl1T6yZiG7KhTGQ9WGbwHIJH
         h9BBXzQziCPL+WKuaQBuSgofbnj2FvAQZU1WBopfJfz3hh3E/P8a7Xeg0AVUhN2G9uFi
         JtpbSthSEfAIm8Oe24xB8j3VddTTALfSG5GNg0C0/EYNQfT7trGTDMpXbMWNWEE4DAT5
         EnI9s6e4ILM0DTkSH0XQ+m/hgri37DKtP+BKGjXSqgTljT0zA3oQ9KN7lCIPfuRPucU/
         xEiXCAoF+/uVlmuOuaM2mJEQ3OlgEqBx8M5tm/GS54nzWZ4QR0cOpuP8tDIR1xa5ck0N
         Hgsw==
X-Forwarded-Encrypted: i=1; AFNElJ+CJ00l8nzfzjaQJuDTIHjyG+oKa0R8HcpiBupCYwbqkVYPm3WMtJcwQdF100JUZtOC68MdDPA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9v55eAaFYG1dhjksxNgXcCINc1rFYy2NyCmWxO59AydbjSD2S
	wuE4uORSln6AIoupuVfqRJIh0XjfexoDWSl2uPWzP3FX9tJ7ntjdwGTxvcwwzN6vArUQ+JQatZF
	p+ActnWAfxfdte5XdFACmMMlLx/3pwYM=
X-Gm-Gg: AfdE7clco/K3O/ylIxmrS6oWyjUjrDdnjdoxhywgFa7MQL/SwqpswAx6KpTUONi/Hqt
	YKbYbw//k4uE6Sp+pCA5UzVh3GDgfPUE4Mi0QxfxjRMsG9zKrRAX8k6NvQQt60PYZ0wiMeHhPxv
	727ptx+cU8yiMmT39BUSsQ1zsbW6o3Vz3aLRdR1+oLZflaGwCC0MkSyaH6OOVA6u6x++LgwZKQb
	Ym2Aaqh++FAnyWuSfTNUA6CO8+RhTp4rPTTzYn3b/n81dGVLQcKaPER0+qhjfyF0ogeaiA=
X-Received: by 2002:a05:6820:4d03:b0:6a1:10da:ab9d with SMTP id
 006d021491bc7-6a123056b05mr2754013eaf.15.1782323542879; Wed, 24 Jun 2026
 10:52:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
 <20260624071226.2272209-1-safinaskar@gmail.com>
In-Reply-To: <20260624071226.2272209-1-safinaskar@gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 24 Jun 2026 10:52:10 -0700
X-Gm-Features: AVVi8CfO4ShP8XHn8pnL2N4gaP9BD3pzKdndivNRe-NdNvS8dpf9qzg05LfmNXE
Message-ID: <CANaxB-xUrLQYGiRJZc4Boi+KX=0TJSWymErNovANVko20fMDVA@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, alexander@mihalicyn.com, axboe@kernel.dk, 
	bernd@bsbernd.com, brauner@kernel.org, criu@lists.linux.dev, david@kernel.org, 
	dhowells@redhat.com, fuse-devel@lists.linux.dev, hch@infradead.org, 
	jack@suse.cz, joannelkoong@gmail.com, linux-api@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, miklos@szeredi.hu, netdev@vger.kernel.org, 
	patches@lists.linux.dev, pfalcato@suse.de, rostedt@goodmis.org, 
	torvalds@linux-foundation.org, val@packett.cool, viro@zeniv.linux.org.uk, 
	willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:alexander@mihalicyn.com,m:axboe@kernel.dk,m:bernd@bsbernd.com,m:brauner@kernel.org,m:criu@lists.linux.dev,m:david@kernel.org,m:dhowells@redhat.com,m:fuse-devel@lists.linux.dev,m:hch@infradead.org,m:jack@suse.cz,m:joannelkoong@gmail.com,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:rostedt@goodmis.org,m:torvalds@linux-foundation.org,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[avagin@gmail.com,netdev@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-301745-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux-foundation.org,mihalicyn.com,kernel.dk,bsbernd.com,kernel.org,lists.linux.dev,redhat.com,infradead.org,suse.cz,gmail.com,vger.kernel.org,kvack.org,szeredi.hu,suse.de,goodmis.org,packett.cool,zeniv.linux.org.uk];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0E7356C0856

On Wed, Jun 24, 2026 at 12:12=E2=80=AFAM Askar Safin <safinaskar@gmail.com>=
 wrote:
>
> Andrei Vagin <avagin@gmail.com>:
> > The CRIU fifo test fails with this change. The problem is that vmsplice
> > with SPLICE_F_NONBLOCK to a fifo file descriptor fails with -EOPNOTSUPP=
.
> >
> > It seems we need a fix like this one:
> >
> > diff --git a/fs/pipe.c b/fs/pipe.c
> > index 429b0714ec57..6fc49e933727 100644
> > --- a/fs/pipe.c
> > +++ b/fs/pipe.c
> > @@ -1253,6 +1253,7 @@ static int fifo_open(struct inode *inode, struct
> > file *filp)
> >
> >         /* We can only do regular read/write on fifos */
> >         stream_open(inode, filp);
> > +       filp->f_mode |=3D FMODE_NOWAIT;
> >
> >         switch (filp->f_mode & (FMODE_READ | FMODE_WRITE)) {
> >         case FMODE_READ:
>
> Does CRIU actually rely on ability to do SPLICE_F_NONBLOCK vmsplice into
> named fifos? Or this is merely a test?

Yes, it does.

>
> If this is just a test, I think we need not to preserve this behavior.
>
> I did debian code search with regex "vmsplice.*SPLICE_F_NONBLOCK" and I
> found very few packages. And it seems all them use pipes, not named fifos=
.

In short, this isn't how such cases are handled in the kernel. The fix is
simple and should be applied to avoid breaking random software.

>
> (On speed: I still think that my vmsplice patches are good thing,
> despite performance regressions in CRIU.)

I already explained that this isn't just a perfomance degradation, it
actually breaks the pre-dump mechanism in CRIU. vmsplice is invoked from
our parasite code within the context of a user process, where execution
speed is critical. A heavy performance penalty completely invalidates
the pre-dump logic, making the feature useless.

Under normal circumstances, patches that cause this kind of breakage
would never be merged. However, since there are exceptions to every
rule, we should let the maintainers decide how to proceed here. In CRIU,
we have a backup plan to utilize process_vm_readv to dump process
memory. We already support this mode, but it isn't the default due to
performance concerns. If these patches are merged, it will be the
only option left for CRIU to implement pre-dumping.

However, we need to look at this case in a broader context. This is yet
another example where the change introduces a workflow breakage, meaning
there might be other workloads out there that could be broken by this
change.

At a minimum, we may need to consider a deprecation plan where vmsplice
with SPLICE_F_GIFT triggers a warning for a few releases before these
changes are applied. Alternatively, we could introduce the proposed
behavior alongside a sysctl to fall back to the old behavior and explicitly
state that this fallback path will be completely deprecated in a future ker=
nel
version.

Thanks,
Andrei

