Return-Path: <netdev+bounces-300234-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Dq8sA7/8MmpH8QUAu9opvQ
	(envelope-from <netdev+bounces-300234-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 21:59:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7C869C46D
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 21:59:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="oO/cUxIB";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300234-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300234-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E699A3083011
	for <lists+netdev@lfdr.de>; Wed, 17 Jun 2026 19:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E3F83AFCF3;
	Wed, 17 Jun 2026 19:57:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f43.google.com (mail-oo1-f43.google.com [209.85.161.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D923AFD04
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 19:57:26 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726255; cv=pass; b=YZvCRgN+sVekoxWltwSpTr5s7lw952z5OIwEEWvrUQ0rbQLlEQ6nwSgw5i6rG2dZLr5PI1i14Hmu6cioPcZeR9jO0MZN1Mod39vhevKWqHD+38k+mksJo3KIqBmswRnPr4k1ZDzJdQZw7FFdkGRnmzqo4axCKiWcJjMFJh5uOV4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726255; c=relaxed/simple;
	bh=zJ0IUeGHsdJdPluNaERbeBaxMQit3LG3hz6ZGuJa0tY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JSm/87zdGKolYrJWiOaJleRim0hohGNrYgeZ7IsUOc12VgPI0sAd6wiZkrRVuyfUbi8zWXFKYpR7a/8UJsnDQaxi1Pm7TdCK4BtficvKX+rZLzMyJymtiwvegs8iqm62i746yD0GuBW2xSlk3oGM0vwSIWuABTheyDzX0PZ128I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oO/cUxIB; arc=pass smtp.client-ip=209.85.161.43
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6a0b1edbe32so188488eaf.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 12:57:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781726246; cv=none;
        d=google.com; s=arc-20240605;
        b=JLKmtZnUb3LDt4gQAp0U4kqZITP+Fit9zc2a+LjdI7B4DS4+i+GhvuzgRIfbAgh4f6
         DhER7x9nlCC3bF7YPgEcQNg8t+s+6eph5pcrnr1vN1yfqN8FNIC9puBbv6JrXoGQfdTQ
         jwoHfWb9ROlM3CvJm7g3zykI0bUlMtXwaDAg1/CgacUjxu7Bl2x9dXalkwI8T2EjiNbH
         1rHf6UdO9/N8ETIAZa3bWHlmO3T3zfYhW6sjg5jTypsMPJ0OG6BxdOJ1bw8qHstytY/q
         JSwfWxwNkkJP9JqxPScxq0r7KBm0ftpN14CD1quD8LtH65Y48O0ctadfpFXZeuZpDNvK
         dhbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i6aC/adY0+BnTZkQLrAHVNjq6XIIvBAX4bGpMQTnTwE=;
        fh=VoH+gbTX4UVHLD16lFZICC4Yy1BLUJ2BWY3WpYIAKnI=;
        b=CSc81qR56cZXndRHE+GvNX/LsPRlR/8CEh9iUu2KTth8vWVWFrKBstww0Vavl5Ab36
         NLIOWj9J3ojmS9KdLGJKRZouAK62DaZYXBy8ogUrqd3H564TViJ2gy3YdRrddweJPDDA
         LLm0zQ56YJGOv9WphjTQ73jyepxFo4J2CqJU/ihRH2XB+8LD5UdVLOrZsoMBOR59eO0H
         o75IIj5phR+XklJ8MJGAYqyh7UMbbmdsUsGoXT5ZCKAULjwlvNa/Gt5T7VWmjjm+FvvT
         NK0xSVBjerbKnH5ECdA53m9u1LX2B4MoicCqd6mqaDCIoqglPHtJecyE3lzoUPXW+1Xs
         BZrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781726246; x=1782331046; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6aC/adY0+BnTZkQLrAHVNjq6XIIvBAX4bGpMQTnTwE=;
        b=oO/cUxIBVolPAntAAuoSBXmkw4TumAzDD85o96DnyS4iiQj3HZ0dtSJbT0Hpo2vJO2
         /kij/dzjJxhogUHoe5spNaMHiXgh/l09z/0H7K4U5iBnd1KiAqC0g3ykXwnMFMKHpuaJ
         qHCMc7l3xUpj8fNv5TY2YVDcjkTwXuGqIbHBeK+LNDAC/msoX5rlNR0qPMlhNqixpPj4
         4slxXitO3p9gh0FITq06WE4+27Jp30zYL+yVAdJpZb7/YO02yml0dxjYD6HGb0wovww/
         2ghC51srA2wAdk+UjVuCNRZQZaRa1kRyUDb92GtXyhCBGOuFmYIhW08Lzhpiy7NFT/xn
         Qwow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781726246; x=1782331046;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i6aC/adY0+BnTZkQLrAHVNjq6XIIvBAX4bGpMQTnTwE=;
        b=fyJC7yRN3rlz/1c2upBNc3lf/WFUDQewClRRAvWv5BEVhhDxZpnsSOci7HVBp36D+Y
         F6wgwoW5XNagoDZioQPfzCixb7hRrm4lmFT0uHSyEpmKvpfoVSbPKE7w/dKbUipTF5n/
         xygMZI5QKYyYlpqcQUIvrUB21k1VYkRsGr2Sk9TNyHrOZsxMhC+AfwY5ENzpfqdcl6fb
         ZxJt8/fPAEzUzc77cQcPqRAiAd1ZmRZK9CcuSgsYK9Q7wXC7A0jj53b2rEPZRXXiGBA3
         R3GtlDOQygVKZIKnKNk1iLvTFrwzexSVRrIgUnxC98NrJq224MWjcJo0mwZ44EYeBMD6
         nh9Q==
X-Forwarded-Encrypted: i=1; AFNElJ/48yETgrpfKaIJbnbXnW3FlFzNRkLNileekQVphxkleE1o4gFspLddM1KV8s3wlX3jhjw0bmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWtgcU8s9lBo4wyAq91oDcadRj5RKVUZYmai9zpRhldeqYip9q
	TspZfbJyftc9Uld0cmodJZBNTxmXL5YuQjiiZwTgnIkg50FdFAAojXwPx6dfy/zIY9TMP/heMQB
	w2PERUwFxRWrIUjRk7O76HKPoIyN9INo=
X-Gm-Gg: Acq92OGDpDzNDJdRf3NYnPXmGjUBPeMiilKbzZAt86aFTVaFCYMi88V1+bKtsw4+IfZ
	GfLYhdRB9xO71oIY6muXfKaDXKbljmdpHoJMZnJG1GbSE8Jft9nJlf/O90Vc4rq4ugkt96/2/kW
	327stRprTX6R2/ZZgrbQW/WVt3mgVHo0gsPDShCA1AqR+CDGqdMZR9VygkQ7RG5fS68j5la68tf
	R1Xf/NYZk6GAKzxBK0lp0pvbiyLOfE9zn5B2PMX3mcOZHa2Kylc/giKuXbUAeqYlRFtqoY=
X-Received: by 2002:a05:6820:1c90:b0:68a:f494:e8fc with SMTP id
 006d021491bc7-6a0b60c0b36mr3762306eaf.33.1781726245995; Wed, 17 Jun 2026
 12:57:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260531010107.1953702-1-safinaskar@gmail.com>
 <20260601-enthusiasmus-canceln-anlehnen-0e62317a9784@brauner>
 <CAHk-=wifX_rrDjRGnDnOqE-usptAukuXKrmuPuVDP5bOCBWzGQ@mail.gmail.com>
 <20260601173325.GH2636677@ZenIV> <83f05c55-efba-4bf5-abfe-d2ab0819e904@packett.cool>
 <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com> <20260617-attest-gewechselt-tragik-7ed473860051@brauner>
In-Reply-To: <20260617-attest-gewechselt-tragik-7ed473860051@brauner>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 17 Jun 2026 12:57:14 -0700
X-Gm-Features: AVVi8CcHFrVPI3Twv4VAYTkdhufN4WGXszz_j2JUYmYPkPtYdrsmDFCM1RURvTg
Message-ID: <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Christian Brauner <brauner@kernel.org>
Cc: Joanne Koong <joannelkoong@gmail.com>, Val Packett <val@packett.cool>, 
	Al Viro <viro@zeniv.linux.org.uk>, Linus Torvalds <torvalds@linux-foundation.org>, 
	Askar Safin <safinaskar@gmail.com>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-api@vger.kernel.org, netdev@vger.kernel.org, 
	Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>, 
	Christoph Hellwig <hch@infradead.org>, David Howells <dhowells@redhat.com>, 
	Andrew Morton <akpm@linux-foundation.org>, David Hildenbrand <david@kernel.org>, 
	Pedro Falcato <pfalcato@suse.de>, Miklos Szeredi <miklos@szeredi.hu>, patches@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>, 
	Steven Rostedt <rostedt@goodmis.org>, fuse-devel <fuse-devel@lists.linux.dev>, 
	Bernd Schubert <bernd@bsbernd.com>, Aleksandr Mikhalitsyn <alexander@mihalicyn.com>, 
	"criu@lists.linux.dev" <criu@lists.linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:brauner@kernel.org,m:joannelkoong@gmail.com,m:val@packett.cool,m:viro@zeniv.linux.org.uk,m:torvalds@linux-foundation.org,m:safinaskar@gmail.com,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-api@vger.kernel.org,m:netdev@vger.kernel.org,m:willy@infradead.org,m:axboe@kernel.dk,m:hch@infradead.org,m:dhowells@redhat.com,m:akpm@linux-foundation.org,m:david@kernel.org,m:pfalcato@suse.de,m:miklos@szeredi.hu,m:patches@lists.linux.dev,m:linux-fsdevel@vger.kernel.org,m:jack@suse.cz,m:rostedt@goodmis.org,m:fuse-devel@lists.linux.dev,m:bernd@bsbernd.com,m:alexander@mihalicyn.com,m:criu@lists.linux.dev,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-300234-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_SENDER(0.00)[avagin@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[gmail.com,packett.cool,zeniv.linux.org.uk,linux-foundation.org,vger.kernel.org,kvack.org,infradead.org,kernel.dk,redhat.com,kernel.org,suse.de,szeredi.hu,lists.linux.dev,suse.cz,goodmis.org,bsbernd.com,mihalicyn.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[avagin@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E7C869C46D

On Wed, Jun 17, 2026 at 4:08=E2=80=AFAM Christian Brauner <brauner@kernel.o=
rg> wrote:
>
> > After this patch, step b) is a straight copy which means step d)'s
> > fixup doesn't modify what's in the pipe. This could be fixed up in
> > libfuse to not depend on modify-after-vmsplice, but I don't think this
> > helps for applications using already-released libfuse versions. I
> > think this patch needs to be reverted.
>
> Note, nothing was merged. I deliberately kept in -next though for a long
> time to see how quickly we'd see regressions.

The bait worked. CRIU wins a prize in this lottery.

The CRIU fifo test fails with this change. The problem is that vmsplice
with SPLICE_F_NONBLOCK to a fifo file descriptor fails with -EOPNOTSUPP.

It seems we need a fix like this one:

diff --git a/fs/pipe.c b/fs/pipe.c
index 429b0714ec57..6fc49e933727 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -1253,6 +1253,7 @@ static int fifo_open(struct inode *inode, struct
file *filp)

        /* We can only do regular read/write on fifos */
        stream_open(inode, filp);
+       filp->f_mode |=3D FMODE_NOWAIT;

        switch (filp->f_mode & (FMODE_READ | FMODE_WRITE)) {
        case FMODE_READ:

