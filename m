Return-Path: <netdev+bounces-300328-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dOMSDHmRM2rBDQYAu9opvQ
	(envelope-from <netdev+bounces-300328-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:34:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAF869DDC9
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 08:34:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=CUsKF5G9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-300328-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-300328-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5020B301A90B
	for <lists+netdev@lfdr.de>; Thu, 18 Jun 2026 06:34:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97AD832B13D;
	Thu, 18 Jun 2026 06:34:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B24B2E7362
	for <netdev@vger.kernel.org>; Thu, 18 Jun 2026 06:34:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781764470; cv=pass; b=Sajvxz9N/ze+Qz9WN/Yz5bacg4MaFWENEhjMXMUuZ/xrwwHwnqFTE6zMDTVIZpYOMKRS4gsvSOfWAMtrtoWDVrNBjyn6Yq3sF++cpwEIwWjAgTtMraS0Vd/Q4Y/CqI8NcUYugQpUaECP8P1mhKNtDJ4VxurV/Dwrlqbs3SLPg6c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781764470; c=relaxed/simple;
	bh=3Oo8NBVlLWLPAiABDvAMPw2Gh1H7ACmqAdcOnRERYcA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JcHxRixwyq857pr4H+sFTpNg2r5yFLBFQ3Nhr40Y4U7pNCia1uDWS1O+ls10TDafwuq+RaLB9gA6paKilSzxYlWnfcC5Ap24iAojoBPD3RICk5xvOXhgesQ3q2P0wAkRLhmUSyuAP5RZvMezTJZm1IByDrsKo2YHsgyFP1D3KD8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CUsKF5G9; arc=pass smtp.client-ip=209.85.210.54
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7e701435806so493687a34.0
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 23:34:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781764468; cv=none;
        d=google.com; s=arc-20240605;
        b=fCglgVFHdKrGg7YjIWft5IpUw2fL3Rm/WqYPiX4BKWHndoIqKN2WTxrwvhWXywdCm/
         hqyLJPANj4DhUevfkwfHSp7rN8+hBbs5aXczBkrODfSXfg5t/99CVf4iAuA+W3/knzfm
         cxg8p9oQVCtNEIAbVD2HsPJwX/4IHNHKcN5A1zph6E9SZaoaFjL4r66JpewFPFTP0J2k
         aSYGV/cqGgAjC8beWD3XtsTTOACE4RKg33/6FpsZP0F/tBJJNN0b8L7ke5GGTaAyMZLo
         hqjOlFTLWQA9mPhaFMDXt4JECv//AJd2/rHbjX6snn/nbJOV7e3NAMRoSfEu09/7eZU4
         ZI1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3Oo8NBVlLWLPAiABDvAMPw2Gh1H7ACmqAdcOnRERYcA=;
        fh=yioeHQMkbHdBjUg3ua42iAwhkYFR3VC9PHqBWevN7ko=;
        b=UJ2vhdMH4dn9wjlK/qDm96WhcpiG2VoqM+XnINNXhmaYiDXHD4MdSX3p58hNacqdSQ
         T0y6jom5v212SrYfvpO8ytfX2BZymkqZEf6y/apP5nA5uhtavAGqAGtKcXNzTervbwSh
         j8hTePSqWB2WI13SH2FAAs0a3JjQp5/LqYar2O216P+vlK/t7aN0z5PhwUwQMkyp/yqw
         84YMw+GKGZOZaxOw1yiq+6jh8+FKIvjZ3NklfkVcSj2j7Q2Sh2EQyr0oSbHwx+t17CEJ
         tYN/DA2XCCeE/7lUr82xC0Y/5w47rqEmlQ9N14WYYLSPys1Nr8n62acoi5TD5Tdc42Vm
         /dVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781764468; x=1782369268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Oo8NBVlLWLPAiABDvAMPw2Gh1H7ACmqAdcOnRERYcA=;
        b=CUsKF5G9oxQ61j1d6rsf70C4V+CwzfyiYvwAeL7GvJIC7AbqTHLHcKrFrSuqEAV2QA
         pzLF5bqljizbBWys6o8ZhgwJf0RJDM7jP3f8kZoLpYGbee7Gt2XcAmZRDLMlg79qdelJ
         uzna51+fErCL+0y6TBoDa++Ujd4tjKdHjmygqFxYzjaqFC0j6+nR+zuxGnINsMlAvIDB
         owbPXox3hQuPUyUM7JLSnsNAxiCfR5GF0/ojif5kaHmYQz6SArEeg+bQd016pBcQoDy1
         L5pblt0ttzAUyKFnUmUtTKE8bBKbtfj8xjYZ0RX/98iMtUW8y7hFawh8TJoPxft5ew46
         /lFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781764468; x=1782369268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Oo8NBVlLWLPAiABDvAMPw2Gh1H7ACmqAdcOnRERYcA=;
        b=RW9kdx11Wz1ihmsy2awThQT7XB7U1x2C7NJBPAJWNwL0McDH64GfQLruylKfXPM6LF
         ZRiuet5R8fG1ASQe/QbRZAMFtKIcIRTQcaFK3EQYZ78eT2TqkBfx6OAvuJrQv56kmsl7
         DWEjauSNvZDWGbY7oQfEd/5a97FDLHrnmZ3vM01QFervaOg5wtVt0vr8iiYTPbOHblMr
         T+u4Mn0PUOFJ1p73jZqeBp29D9jZ0HuIBSeebeQ5VTQIfoxnPkRLpKfxwv4inp/8XilQ
         422qkfdsr29adeQNnjNk6wR+/ngNajDnBx6F2fAq6pT62S0D+4E69xgphzN3lwA+otMH
         cm6A==
X-Forwarded-Encrypted: i=1; AFNElJ90B092jz/PcjdLFk+Xvdgy0ixS61WPj4mimIdFpCz0U9SbO0arI2VQ87XOyAcoI+gEUDsKtOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylIj3yUIFL/Zu2p+jf/1QkFzm4cy5lEFyJBA/At0KY5nlhcuzJ
	uA17emg8dtECjxl9kqYsq2P1LaZJb4F6I1xwreh6PT5n7QuFaMoFjvg66J/aByF6QQ1fAjgwrip
	o8kXLmY2RBNXyWaAqzyrm41RxkmO1Rzg=
X-Gm-Gg: Acq92OHT3PQ/685AZGWkeuV7TzvP/dY5cxH3dNIvr/mXmvFEF0125QTvWXX2b3ExlmP
	/3NMlvqGzy4O2FIhjFxdWt0VvhbP3sZDZCbbk0Vw0nM1hHrbjiREEPAGqR/+oPnZKZR/ShAETAR
	H8Ysw4tj5eFp2VugjQ7gG7/TdcHfFOdibKiMaAexLl2HdK43hlE2popXDsHgrMBKDO/e5Q4cEnp
	j4oFDJ9zDVdjj+z3I30H38nGAVA2+KsthkWsc63pspIR7UQLi9FAP6lyvuQ79TffcbJ1jM=
X-Received: by 2002:a05:6830:6d50:b0:7dc:2f4f:17b4 with SMTP id
 46e09a7af769-7e90b3dd22emr6348498a34.21.1781764468073; Wed, 17 Jun 2026
 23:34:28 -0700 (PDT)
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
 <CAJnrk1Y9egYizkx1H9K0cqxSYuB+7vLvQbV7Tf4C5eHFqnnC-A@mail.gmail.com>
 <20260617-attest-gewechselt-tragik-7ed473860051@brauner> <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
In-Reply-To: <CANaxB-zK5q=Xw6UZTmeFtXsDZjUsPkFk=p485m-wtNTBnf4hgg@mail.gmail.com>
From: Andrei Vagin <avagin@gmail.com>
Date: Wed, 17 Jun 2026 23:34:16 -0700
X-Gm-Features: AVVi8CdkTtlsRp3whjFCRdKN_CHwplubM07nLp2T3ItfxHiU3lLc-EI912kwpts
Message-ID: <CANaxB-xVCP5HSUNwphFrKPdW0Qh1pA33A6npac60WArkZMFt7w@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-300328-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FAF869DDC9

On Wed, Jun 17, 2026 at 12:57=E2=80=AFPM Andrei Vagin <avagin@gmail.com> wr=
ote:
>
> On Wed, Jun 17, 2026 at 4:08=E2=80=AFAM Christian Brauner <brauner@kernel=
.org> wrote:
> >
> > > After this patch, step b) is a straight copy which means step d)'s
> > > fixup doesn't modify what's in the pipe. This could be fixed up in
> > > libfuse to not depend on modify-after-vmsplice, but I don't think thi=
s
> > > helps for applications using already-released libfuse versions. I
> > > think this patch needs to be reverted.
> >
> > Note, nothing was merged. I deliberately kept in -next though for a lon=
g
> > time to see how quickly we'd see regressions.
>
> The bait worked. CRIU wins a prize in this lottery.
>
> The CRIU fifo test fails with this change. The problem is that vmsplice
> with SPLICE_F_NONBLOCK to a fifo file descriptor fails with -EOPNOTSUPP.

Actually, this change introduces a performance and functional
regression for CRIU.

Here is a brief overview of how CRIU currently dumps memory pages:

CRIU injects a parasite code blob into the target process's address
space. The parasite invokes vmsplice() with the SPLICE_F_GIFT flag to
pin physical pages directly inside a pipe without copying them. The main
CRIU process then takes over from outside the target context, calling
splice() on the other end of the pipe to stream the data directly into
checkpoint image files or a remote network socket.

I ran a simple test that creates an anonymous mapping and touches every
page within it:
Without this patch, CRIU takes 9 seconds to dump the test process.
With this patch, It takes 18 seconds...

Plus, it obviously introduces some memory overhead.

If these changes are merged, we will need to completely rework the
memory dumping mechanism in CRIU. Using vmsplice() in this proposed form
no longer makes any sense for our architecture...

Thanks,
Andrei

