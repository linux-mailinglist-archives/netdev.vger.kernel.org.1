Return-Path: <netdev+bounces-258312-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JpEN9KyjGlLsQAAu9opvQ
	(envelope-from <netdev+bounces-258312-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:48:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 337881264E1
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 17:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A3FA93001CCF
	for <lists+netdev@lfdr.de>; Wed, 11 Feb 2026 16:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5393329E6B;
	Wed, 11 Feb 2026 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="16Z9sUOz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF898344DA0
	for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 16:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770828400; cv=pass; b=nzVC0icPiUI5kS7vRWw1Xn/DlE7UEIpBW/oAJ6Z0IDU0CCaVvO7/x7MVJBgXPVQJsDFD+mrSc7pzuZ3bf1RSYAzTWtHZBJ5fGcvVygpvOzBwjmA6D0o41bFKZBQy5C1liKbhvD7/K0VqynpUh8+jQY9Z/DRCxFXB3bACkSmCqgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770828400; c=relaxed/simple;
	bh=YNj0vjYdFemO9AVHZBFtj7oP9gsGjKG0NsbsxasRXUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTlirQDeTRXG4+27GYLOTYng9U9nstBGd1DE9FU1vh8CYCkatnblSSKIsD9y2IlkLP6vHNdMVs4PUifOXIFHJg5ji+eJkHaFPwj0mocqwgDcYpdV2Ui5q4EoCZzoCNdwv/Qgogw8jVBltgDs5vH8yn/pJV1zd503WXh2Hz2tJzI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=16Z9sUOz; arc=pass smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-649d4c77a32so6525543d50.2
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 08:46:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770828398; cv=none;
        d=google.com; s=arc-20240605;
        b=dkl8fZWDGDxHgDvM4krfz7mblG6mZg4CATE3NO5fgSzldbVS3pkLuq9BEuKmwNpHhO
         3u51/m5js7ieqftPMZqCCSee9cds7IQOarTkjSQJ1S1HTBsiBaHYZhZkGNeJnNBSZ+rc
         AcxlnI0pRcvw3wfj8FJQMMWgMVC6Te5rCcbZW+2boFfEZASy6K1TYkJmiRK4dROeC++A
         lkOjJWeUA/x70VUXQiDr+N60mmSGCbYD37A5jrMxsODpP1bMhJL2l9KVULnhhdEEOmYE
         tzV4QOdMb6Vqe7BP7JqffQAH/xkHvPLBHiKe8hQJuRBhS3L5ZI76gmlsWekgOaX1f3iy
         JHXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=F8Hz/HMGUlKSqxpxVwMh2RPvVWEm5m9+g6sz1byMwto=;
        fh=rS/pOsENBk9o911PsfgMvSYyEKBVztgwZNyAz3W/LTc=;
        b=UzXjfWTT/unjnNfgaDg5A8HfCvvVEig0pvia+Ove7dC1eVFWQVOFBNS2BiIh/LChZl
         6YQiG7oJL4VEXxoRbuUejWRvc72y6IBS0AVy6nHHeIJIIuq6L+Va4nnNfcNUjyUH/Ynj
         bLRjPuOujDbD3O1tf7ffrdNKYr4KXSgUXxrl1rj7IFIPPlAZOy8TgsZyuILBwmyZ/GrU
         XTafecTTGL5Tcb6i3O+q+Tdf3kPrOQ+sBIrUkpyy7btv6Nct46nYK3gL/pMogriXfmtB
         jJkV1kI3IrJkoxWUs2ZP7AuROB3MD55JjJltYYMZao8bv6qYegXaPjxjXWcRiH+nQYqY
         1SyA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1770828398; x=1771433198; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F8Hz/HMGUlKSqxpxVwMh2RPvVWEm5m9+g6sz1byMwto=;
        b=16Z9sUOzayXzRRCh3gGVv1ZK+prjFWLlHiq9Fc2N/+i6sBaWXaWei8BOI4EQ6w3B51
         LjhKhRqtSBfrd74o2nnd4WPUQ/AgG1cUAOs9WxTWeYmkqmW64mnitC6ibpYEYsvmzHiL
         RZfii1Zhqu7weOl5tVrvXZp6pysLBXIjte0QB/MNK8tRH0bRXtS5BQfmgugczjzzWwnU
         TGpZ2lW8/saom2POScBxV4rnkIflrACeAmhhq9dfAVU4Jig0XHYyPYavqJCaCxzjcCKf
         RTgnjCTLZcOt4NXTqE606Ppm4yn3UMQuXB1+uW08Dk9SWV+OA1+t0DxZVrfMYVQCXEkB
         uTXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770828398; x=1771433198;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F8Hz/HMGUlKSqxpxVwMh2RPvVWEm5m9+g6sz1byMwto=;
        b=MttW0XJL7IfjU3lJavGpWcEKyJUOSU3tuHS87DPjbd4RnT5ISg83s1urt9ckk1x7s4
         7eyafy59Fl8OOtGawmp5StErJz23S0xepsi8wtJBbheLi3TZaPckoGrbC+nD8iA6lMSl
         WJqNlVLFS+4GaxgdkRYwWkWNh1T0qBhZ8BZjclxtA7XPd9EUvPJnJh8DcwYBc5JkwEu5
         dxZnJOKqfFzrD9SWAUIPaXkPKwcMcpl58Nt8hqFDQhntY6UvwdYEw6cIbt7d4b0fFZr+
         masIq2ntb+b4EGGErgNSrmcUPosed5LJkaCBEOpn/cIftyueijhAGhpvM28fQjTWpjQV
         K5Mw==
X-Forwarded-Encrypted: i=1; AJvYcCXWYAN1yIqZJ5HZ8F5L5x9l8F9oGwosIwwjBC/PGI1uX9QShWPega0e2UI1YXqqez1gyw7sctU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9FSrWVdeTE+QEdiwKdiY4CrhGzW/m9rn1RsmFjy+O+ZgDSmLz
	4HAToSo36MOWhJWLXvWIzriO9O7F3JwiFJFSDqzFUV+wMLhxeRkopzKq4CBaPpPx2Kog4y47HiN
	hisNL9x7vRg3YGekyfdqVlr+sszggkhsoeza9UVYazhYA7WqA8SI=
X-Gm-Gg: AZuq6aLqg1CmmZsBz2/JAFzKS0bIFpOPju0rqV7Hb1LsutezPhJ3461DaPwEu2o3QRI
	sFLOXZn2RB0hd1HPydBlzAjCmoEF57e1Cgrsf5ER1LZN63nmdpf+vyrxUZVnUrPBFZ6Y+OW+UTY
	6v11gAN4uXX2rfHjqFFT/DuHv7nvLpP+tH3vQcb/e6LGLSGdCPpW67urvamSSnLaNQyjTfW3uvE
	2luTUhmv/uesN1dH6S72J4qVg06tky0mx9IpvXLae67b+h3ps3VHvuSd3c2yK8fZdhN4xKyQLsp
	BDCu5sOkt6ZoAgR5k3qANw==
X-Received: by 2002:a53:ac93:0:b0:64a:dc34:fd54 with SMTP id
 956f58d0204a3-64af2201f12mr4943873d50.86.1770828397970; Wed, 11 Feb 2026
 08:46:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SI2PPF4F82E9256898C9826AF17C3AE8AD9F467A@SI2PPF4F82E9256.apcprd04.prod.outlook.com>
 <8698fad4-c406-4bd8-bfe3-33e5fda641e2@lunn.ch> <CAM0EoMnS5yTW5X8uMw4Q2v-b7vGLaG019=GV_U0pC-7oyHSMnw@mail.gmail.com>
In-Reply-To: <CAM0EoMnS5yTW5X8uMw4Q2v-b7vGLaG019=GV_U0pC-7oyHSMnw@mail.gmail.com>
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 11 Feb 2026 13:46:27 -0300
X-Gm-Features: AZwV_QiN1gF3pF1amFpZz6c5YnXlA64ZiHFCZg3-LS1ANCaUglAiLj1FrcAHcM0
Message-ID: <CA+NMeC-EQepcOY4nP8fmRVERjSwL-4qGr2Cmx1kakx2MiC=SNw@mail.gmail.com>
Subject: Re: [tc] Invalid JSON output from hfsc qdisc
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Deren Teo <deren.teo@outlook.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[mojatatu.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258312-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[lunn.ch,outlook.com,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,mojatatu.com:email]
X-Rspamd-Queue-Id: 337881264E1
X-Rspamd-Action: no action

On Wed, Feb 11, 2026 at 1:33=E2=80=AFPM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sat, Feb 7, 2026 at 10:09=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrot=
e:
> >
> > On Sat, Feb 07, 2026 at 02:01:01AM +0000, Deren Teo wrote:
> > > Dear Jamal,
> > >
> > > I apologise if you have received this email twice. My first attempt m=
istakenly contained an HTML part and so was not delivered to the netdev mai=
ling list. The original content follows.
> > >
> > >
> > > The JSON output for the hfsc qdisc is not parseable when a default cl=
ass is specified; `hfsc_print_opt` uses `fprintf` to print the default clas=
s.
> > >
> > >
> > > Environment:
> > >
> > > - Fedora 42
> > > - Linux 6.19.0-rc4+
> > > - iproute-tc-6.12.0-3.fc42.x86_64
> > >
> > > Reproduce:
> > >
> > > 1. Add a hfsc qdisc with any default class. For example, from the tc-=
hfsc man page:
> > >     # tc qdisc add dev eth0 root handle 1:0 hfsc default 1
> > >
> > > 2. Show the qdisc with the `-j` flag:
> > >     # tc -j qdisc show dev eth0
> > >
> > > Actual results:
> > >
> > > [{"kind":"hfsc","handle":"1:","root":true,"refcnt":17,"options":{defa=
ult 1 }}]
> > >
> > > Expected results:
> > >
> > > [{"kind":"hfsc","handle":"1:","root":true,"refcnt":17,"options":{"def=
ault":1}}]
> >
>
> Yeah, I do note that iproute2 lacks support for json output for hfsc
> (and a couple of other qdiscs).
> Should be a simple patch.

I am hatching something here.
I'll send a patch soon.

cheers,
Victor

