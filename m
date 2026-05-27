Return-Path: <netdev+bounces-292225-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IVHA9LAFmrOqgcAu9opvQ
	(envelope-from <netdev+bounces-292225-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:00:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47FE95E24C8
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:00:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 32E673002B40
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 09:52:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED13D3BFE38;
	Wed, 27 May 2026 09:52:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b="wrL32plP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD61830E82B
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 09:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779875527; cv=pass; b=MxxUh/T8AsfOHnYTmJL3fCwZ4+cpFn2Z0snxn+qOVI4Lb+6Rp5uYEIgSG8/Zb8TpR13zoX1/nqjcJFvmUB0r15Rbf/iKQkc1wWW+cm46xeLiKgA9CaMNQ2PSP3H5WhECFFNH8382i8JNBShGEFOT0Vfgg5UHjShLJA5fTOLKf4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779875527; c=relaxed/simple;
	bh=6yk3OmLcvS9yR1IGEnB8s9mzvV1S/+/IzxWTcA1frBk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JY9XBJPnsQkaAu5iFfr7ZKcRQRqhShv0w2RQMZ+dzQ+0rnCBm7yBBv5Nfwx8/7lE22QhyKaAsU/j7N9OwBqyjmWGMVQivrewG7U03qvmlFQi+k39sDJcTu6sx6HU5hR+WG7fnI7OYwVZty76HAjnXO83X/tmpBB9Tn9P739KCM0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr; spf=pass smtp.mailfrom=snu.ac.kr; dkim=pass (1024-bit key) header.d=snu.ac.kr header.i=@snu.ac.kr header.b=wrL32plP; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=snu.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=snu.ac.kr
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6746d0b2b4aso19457016a12.3
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 02:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779875520; cv=none;
        d=google.com; s=arc-20240605;
        b=Rs3Tz/+mbgh/VCTfQhhbJ5WURlHlczRhsAdi8dMjsKFA8e3f+F6sIS5hm6GXlHW4Z1
         EcxVHgph1rF0RKXY3VTFiE36Wc9j3vDzpvvWEv4aoax+QwNU38s8w/044n1pUVex+iCC
         gdw1CUpOhFFspRU4c3rCMASn/yX8hnb6qQmMZI7R4lX0dNWEzD7gXWmk/3IE2jFBTn2g
         NjP1rog7CRC8rpOsMuLRnlyOPx1eL1XncYQ2chCma7usbanq/KK/Lm56hovEwCMLihpu
         txFtCPlEVNT3e440QYTYi57QY9mHzlAFMR+69NHSQwD+9qaW/nZyiBT+3YYidxk7csUX
         9pLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2PN98aCoYgmIhUzX6WmjhPxG9QNi1I86AbhbpQXMYRA=;
        fh=xRzzBlP2eoVoi6WgjhQvYbtbW8KYnL1Vv7ht+WoRbMA=;
        b=L6vf/vJzYn1qZ2OMaXaaw1J240YlM1fWle79D8Xcnoty1NmYsfA/huHddc43yeq48X
         80mfF6m+J0T5RRkWyPeLi6ua+Bw33e30uPxJ9U9duraUxKluJQCmW9eb7/T1Nf0xaYfp
         tYEo4prB03J4RiQnNVh6DBO4zT0uS2vlVn5uYTveCcI+ZtQwJBGfu4AqkE8XYdoBHgNF
         FjgMxhZNjJ2KuIBQiWiBIhrOCKdCJ8u8jy69BqQD907KUwb02Xplho60fHqjiTPyiep7
         U1ZAJzQJESZGnOxXirjjxBMKS1+qEU/Wx4aSnRB8pp9kjB60paDMzTS1R2tXCOHdVYPZ
         8u+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=snu.ac.kr; s=google; t=1779875520; x=1780480320; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2PN98aCoYgmIhUzX6WmjhPxG9QNi1I86AbhbpQXMYRA=;
        b=wrL32plPML1fnBykAiFWWCw9zUtGYvbeJpsFtjBb/n3ZtvdfqxS3gF6qrVtK7YLyQf
         xhEMsujGXS0aTvzj0vbLvU4L4Sh/k5xMj7jeifDkfPKidxDaFsGUhCzgFzFt+Px3h95Q
         IDr9enygsO8+x/5WRNCRn/WNaypTiB8z0wKv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779875520; x=1780480320;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2PN98aCoYgmIhUzX6WmjhPxG9QNi1I86AbhbpQXMYRA=;
        b=nJ8/ZU3Po8Ozs0e+fibcMozm2rONC571y1TqVmTutFPFt+krevF9iqDUgXcltHMcZR
         bERObOML2EP154ERznfCBhSUJX3v+CtfgsRFv1s/aPt20dvNVrUh0B3e9fwcHRaYMVnL
         l8dvWynOd1/4ZCrrp3mc323vKq696PdoUpx2b+T0EZi4Azlo0rw6DLDYe7uCL/EAWBHd
         pObSKIMoSNGNFu4zYh9RIJL6VHPdotqmQZtqBPSAQUDwMSAYqcNPvWc/s9oFgFGxV6OK
         VoDAM2/cm20i4kUkyMAb03WeYBXiGJmNx+jHk0OHoFSlfTWK3nJgCkgCjmfvTppzekP4
         jpkA==
X-Forwarded-Encrypted: i=1; AFNElJ+MrypC7AEwXXhBynszqrDzd2eS6TOBNvx2R9TSK9IPk3Q7OswOdbXSZYD5z28003jW7dW4yWE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxusLus7GP8jbByTUJuskrdFGtd1JakXcdOIDFJkJ3dSgl7XY7N
	Zz9MTwtHwPda1pz8aEx8SN9oSSb26umseXrnt8HeIW0Mq0VPsMfghrjl9IMuaoWfc4MkHjS60PE
	j4G8piYYZgHirU+/u57DumpdJVELPVz1pyfarZDFKKw==
X-Gm-Gg: Acq92OF7T1MXKjU+PTtOKuTeJOoc0/KLlqi2qEREyGYzZj8FJrIDG5WwWJy9irV905y
	8sNCHiDg72jLVyNW1mbi88Aco0Di557VGCDITemJQglciHICWIr/DyRnXk9iGIjJfxAjJB3c/fK
	sVeh6AaJsO1yyQXKRYWvuBwujetezQaZI1O2MO2TF8Wr6LQQNZN0enU7XRddP4VhU32CE69iNxq
	HstOofkmeYbJ2MrKKBzmlnB7jVKVTvF4L/aWRV6bYjBNsoWOtdAh1dcn0ou4WzyHqYiQJd4BGM9
	TeCs3fBPS3QgYsRPDUrCTgaenrL9uPqu+WNbwCsr
X-Received: by 2002:a05:6402:e10:b0:680:ccda:55b9 with SMTP id
 4fb4d7f45d1cf-6889c47031cmr11449807a12.16.1779875520030; Wed, 27 May 2026
 02:52:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260526064835.2233822-1-swan2718@snu.ac.kr> <14018241.uLZWGnKmhe@ripper>
 <CAL3z5EbfEeMn-2_JrvcXRtuKTtruEf+8MX9tCmn-N9edvvrjwA@mail.gmail.com> <10856691.nUPlyArG6x@ripper>
In-Reply-To: <10856691.nUPlyArG6x@ripper>
From: =?UTF-8?B?wq3rsJXsiJjsmYQgLyDtlZnsg50gLyDsu7Ttk6jthLDqs7XtlZnrtoA=?= <swan2718@snu.ac.kr>
Date: Wed, 27 May 2026 18:51:49 +0900
X-Gm-Features: AVHnY4IeA4ihcvnDzBQR8GLvg4LxRUs2gOTtjT3c6nUk8tNgpf6NhjYMEVU7tkc
Message-ID: <CAL3z5EZDr3sK5pOuiQmX4agLy4-6sJx3UMw9kDYfApFJ6uYb-w@mail.gmail.com>
Subject: Re: [PATCH] batman-adv: fix DAT purge use-after-free on teardown
To: Sven Eckelmann <sven@narfation.org>
Cc: b.a.t.m.a.n@lists.open-mesh.org, netdev@vger.kernel.org, 
	marek.lindner@mailbox.org, sw@simonwunderlich.de, antonio@mandelbit.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	horms@kernel.org, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[snu.ac.kr,none];
	R_DKIM_ALLOW(-0.20)[snu.ac.kr:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RSPAMD_URIBL_FAIL(0.00)[narfation.org:query timed out];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292225-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[swan2718@snu.ac.kr,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[snu.ac.kr:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[syzkaller.appspot.com:url,narfation.org:email,snu.ac.kr:dkim,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 47FE95E24C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

I was running a modified syzkaller locally and the crash came from
that setup. I've since lost the original log, and looking back, I may
have confused an issue in my tooling with a kernel bug. I should have
verified more carefully before sending this. Sorry for the confusion.

Soowan Park

2026=EB=85=84 5=EC=9B=94 26=EC=9D=BC (=ED=99=94) =EC=98=A4=ED=9B=84 11:18, =
Sven Eckelmann <sven@narfation.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Tuesday, 26 May 2026 15:56:58 CEST =C2=AD=EB=B0=95=EC=88=98=EC=99=84 /=
 =ED=95=99=EC=83=9D / =EC=BB=B4=ED=93=A8=ED=84=B0=EA=B3=B5=ED=95=99=EB=B6=
=80 wrote:
> > Hi Sven,
> >
> > You're right. I re-examined __cancel_work_sync() and confirmed that it
> > internally disables the work before flushing, so the re-queue race I
> > described does not exist. I'll withdraw this patch.
> >
> > Thanks for the review.
>
> But you said that this was reported by syzkaller. I can't find the report=
 in
> the official list [1]. I am guessing you have a reproducer in a private
> instance and tested with it. And if you tested your patch with it, you ha=
ve
> found that your patch fixes it, right?
>
> Can you give us more information about this to let us figure out what is
> actually going on?
>
> Regards,
>         Sven
>
> [1] https://syzkaller.appspot.com/upstream/s/batman

