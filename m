Return-Path: <netdev+bounces-280442-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IIh4G6rh6GkHRQIAu9opvQ
	(envelope-from <netdev+bounces-280442-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:56:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1603C447993
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 16:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 5422C3070B1D
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 14:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B9033C1B4;
	Wed, 22 Apr 2026 14:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PavkPGQS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD64C318EE7
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 14:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776869391; cv=pass; b=epEL/gkljCM70szmqa508yJby4926wJ5M92Ypx3hdqBKIpCuSU9m8FQnsaUaIFW2lApuo3Zrc83shDzHUedCDSS111IbgGbMkDQECYw7ppRP4V9aSVcoJI37rR5qvvMWyyj3bAqr/joeepjuHzTGZEOSCCevEwhO7wheEP48Ryc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776869391; c=relaxed/simple;
	bh=t2XbN8ULAb+GBwQSJq0X9aog7nk2s64iwqFA/9Fv6hQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hE24IzD+yX89zYMYE/jcNWYRP+5UY8+SQISYbifR/6E+IpZAgNY+uMbO8xyzbBBLeyoG/C4K5NABmuBjdzxcEhHmBp48Y1l6zczymvglt2ID3qes3odQqAQmPnF3lPOTb0BXnaxaEqKzJQd1qL4Wt6T3CIeTheJ1uerZxZiexpY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PavkPGQS; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-94de664b541so1502648241.1
        for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 07:49:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776869386; cv=none;
        d=google.com; s=arc-20240605;
        b=CSW6LvMMD83GhfAq87FztHKWB/RB/Jho205PWl6z0f2/l4PkyDs/h1Y2LURIk8J09Z
         xrLunKzBO1behA1QK7qLpT6t0f1vBtJQsOsAA7trc3r4xONFhV8lLW6aHifYfEPKwwTJ
         OT3q3Ar4+7XUAJEctYV82z/QbkV4hW2AFWPNHOULv/Fekg4dyARo6C7rzUUkX19t/Wk0
         Gv7rXuKvaESj+9yGc4mArfwk3wwjWYZxJguDznE1pQSzEFNROvTIbXsV2MwN6vPUDRHf
         iiPKWJKlfbKtvwFF53WEKb1Dk/+AUaYygVkAMFSMSBg+5cHvLOlqJW5SWs8oTfBH51EO
         Ju4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eAJBfQ8yKFwcszC8n4aL6C6Ym0YtNvc5vil4gI8HbLY=;
        fh=K9DUiBtDO5PF6ZsfDSNJjKfZVDHWWMK5Ky99HEqOMWA=;
        b=cbJ2zKuercwkm3RB/SCzPYz/1mntb8RHpyhAbY22NjwNljK8T6ci1yTTfUKPqXQNKr
         2I7cjVEvOP+o0EKlUFWj1mC0i1wYL38h5mWBQq8Guk2RLqtcGacTo351TKDQ7USkUr5y
         yh6Lxqz/sR47A2PpT8TPrGgsfA75TOlXO2YEQkFaKeGVmhje6Ffs4N5l3NiXoSziLCSQ
         e5zgzY+5O65f9QOm/6CNymEVqryHbgRQ646RJ4to8l6GMkXMYO8iUHUViaTQGf7h6vos
         ITZN+RAeR+1ZXqy8+166LvRmmgABWflFzONsrigeHeDTkEfYReSeMLXDGf00F82wr0A9
         7hIg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776869386; x=1777474186; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAJBfQ8yKFwcszC8n4aL6C6Ym0YtNvc5vil4gI8HbLY=;
        b=PavkPGQSrm67SCvoEkjxKqeVDJpf87RFHgfX70qWMonI948KR8OsAH7peaRSXa8N+L
         clc2DKRMIdfjY2XyIyoovf2ofRdwHCZ5y5NJYsr+C4WnHuHnQs/DmjKNr0717mv6OtDL
         eDhOhVyxmznoBpY3u/Zelpd/x+URfxzyaIOIEaz91AKnJ40VVprx/zWn1mppEIkJCAMH
         RFhR7QvyetudXIjwmL7Wsjzw8sK33F47c454cRWbjiTwnaCDEEX3LIVJnlK3fsCoECvZ
         v8rEN3PimrpQEMPV+zRVqXo41bwkX8sthSULAVb3wEBlBbpat72q8JFGIN5+UAFZBXd+
         IK6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776869386; x=1777474186;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eAJBfQ8yKFwcszC8n4aL6C6Ym0YtNvc5vil4gI8HbLY=;
        b=lNfvJo8MSm+qtsCr5lwqEiMe+d8YaH2A2JrEagwN118Kx9j6ly5CBY7raQDPOC2vIu
         VihTyAum58K5cmoJE78W/a5IP+L4fngqwzgRW4i34GBP/daDTvTnO5T+4GUNwV1P1BTH
         xbNJ544Zqsw6MzImDjPSmLKVwq2l261mJONRStOmDGZ0ew0rqF7JWj+N65Ws4QmFQQ15
         00f9qQqpACj+a1/nV3jHqkIksHNPx5978lLso3IBaFRyWS3cvNwZeaEmctr15ab2Eyjg
         Thw4KxR0BLj/lmLdZqKKyXmeBB/8ULC8spIVVaYOyjC0DMV9tY1CzE+Q1EPkCaWagLLI
         VDqw==
X-Forwarded-Encrypted: i=1; AFNElJ9RbsQsrHHi9XaAcDDsh+qDfB6W0a6XGvSIwQG1RqQLXiWKYBJOKFGfqEy45vo1cFzKy8IZiio=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7TvFi2D54vf1nTQbUsUJew1GJ9Ow7Erz8TBs9VVXd42+bu0qV
	h+XK+C3QZC7shiunIw8a/K2PkDf1vQ1IAKJbWn/ZTRhVBxAemlYiN9Vj8WlpJeAhjfVD9JLbcEa
	cn5y3YgFuzeYgmripGiX3pPrBrv4CBSk=
X-Gm-Gg: AeBDievhz3MNCLpIKuC+QTszqn71DVPxO6JcBmyhL2H6twE7z7PvSSC7aPljS/CrpgX
	yOkCLJiCuXVqLKUVXon45I0K00bDF6p6ScZP4+rA18vhvMkMQNC4gAnlXJ74x+cGaHZpnoYdigr
	ufpduh/eOLbTbB3TGZAuJfY6nwtFktX5R9nPhKI2wzle64lc3pRS5LdBe1cm7znkrPoGi3BsC29
	9mlW+8a37EeFU4YVjeJz9jKxviwgGM/OoW9V+9REzzG4xdiGQxnYSdqXcuG6zYbsG+D/z9jivuO
	xVbPB9GzqQ0pgjkl2gBKtm5IOwcpzk+Q1AErp/oxY1QBBN43KSASEsLmncC3fDNzGmHaodSkRm5
	PdVCvkImMWw2k5EOp/IejU3KkVlq3urgSAA1VfAexXEwsmLR3RZLbSg5V2uGV0I9bHN+e1RgL3w
	==
X-Received: by 2002:a67:e718:0:b0:5f5:4055:4558 with SMTP id
 ada2fe7eead31-616f4546fd5mr11177594137.2.1776869386083; Wed, 22 Apr 2026
 07:49:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419192018.3046449-1-metze@samba.org> <aehrPuY60VMcYGU8@infradead.org>
 <9cb0901c-18c5-4858-941c-3b37ee112af9@samba.org>
In-Reply-To: <9cb0901c-18c5-4858-941c-3b37ee112af9@samba.org>
From: Steve French <smfrench@gmail.com>
Date: Wed, 22 Apr 2026 09:49:34 -0500
X-Gm-Features: AQROBzCYzdLfMWSd1uFLJ8XC1YCZMAbk3sG8ZrbfCGB_aYlDD1y44LjlIIB4UJs
Message-ID: <CAH2r5msb3-HiPSv+HgBknEwDXGsv0xU=TGCxHdmc-VCLKzYCmw@mail.gmail.com>
Subject: Re: [PATCH] smb: smbdirect: move fs/smb/common/smbdirect/ to fs/smb/smbdirect/
To: Stefan Metzmacher <metze@samba.org>
Cc: Christoph Hellwig <hch@infradead.org>, linux-cifs@vger.kernel.org, 
	linux-rdma@vger.kernel.org, netdev@vger.kernel.org, 
	samba-technical@lists.samba.org, Tom Talpey <tom@talpey.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280442-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 1603C447993
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 3:16=E2=80=AFAM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> Hi Christoph,
>
> >> diff --git a/fs/smb/Makefile b/fs/smb/Makefile
> >> index 9a1bf59a1a65..353b1c2eefc4 100644
> >> --- a/fs/smb/Makefile
> >> +++ b/fs/smb/Makefile
> >> @@ -1,5 +1,6 @@
> >>   # SPDX-License-Identifier: GPL-2.0
> >>
> >>   obj-$(CONFIG_SMBFS)                +=3D common/
> >> +obj-$(CONFIG_SMBDIRECT)             +=3D smbdirect/
> >
> > Why is this not in net/smbdirect/ or driver/infiniband/ulp/smdirect?
>
> Yes, I also thought about net/smbdirect.

I would prefer to leave it in fs/smb for the time being, since it makes it
easier to track since fs/smb/server and fs/smb/client have dependencies
on it.   In the long run, I don't mind moving it, if it starts being
used outside
of smb client and server.


> As IPPROTO_SMBDIRECT or PF_SMBDIRECT will be the next step,
> see the open discussion here:
> https://lore.kernel.org/linux-cifs/cover.1775571957.git.metze@samba.org/
> (I'll follow with that discussion soon)
>
> I was just unsure about the consequences, e.g. would
> the maintainer/pull request flow have to change in that case?
> Or would Steve be able to take the changes via his trees?
> Any I also didn't want to offend anybody, so I just took
> what Linus proposed.
>
> Using driver/infiniband/ulp/smdirect would also work,
> if everybody prefer that.
>
> > As far as I can tell there is zero file system logic in this code.
> >
> >> -#include "../common/smbdirect/smbdirect_public.h"
> >> +#include "../smbdirect/public.h"
> >
> > And all these relative includes suggest you really want a
> > include/linux/smdirect/ instead.
>
> Yes, that's my also my goal in the next steps.
>
> > While we're at it: __SMBDIRECT_EXPORT_SYMBOL__ is really odd.
> > One thing is the __ pre- and postfix that make it look weird.
>
> Yes, the __SMBDIRECT_EXPORT_SYMBOL__ was mainly a temporary
> thing, now it's useless and I'll remove it.
>
> > The other is that EXPORT_SYMBOL_FOR_MODULES is for very specific
> > symbols that really should not exported.  What this warrants instead
> > is a normal EXPORT_SYMBOL_NS_GPL.
>
> I want the exported functions be minimal, as most of
> of should go via the socket layer instead.
>
> If EXPORT_SYMBOL_NS_GPL(func, "smbdirect") is better than
> EXPORT_SYMBOL_FOR_MODULES() I can change that.
>
> It means cifs.ko and ksmbd.ko would need MODULE_IMPORT_NS("smbdirect"), c=
orrect?
>
> Thanks!
> metze



--=20
Thanks,

Steve

