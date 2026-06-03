Return-Path: <netdev+bounces-294958-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dFCPDY6vIGq56gAAu9opvQ
	(envelope-from <netdev+bounces-294958-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:49:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 354BA63BA7D
	for <lists+netdev@lfdr.de>; Thu, 04 Jun 2026 00:49:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amacapital-net.20251104.gappssmtp.com header.s=20251104 header.b="Yvz/Dfr7";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294958-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-294958-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD459301A4EB
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 22:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB243B0AC3;
	Wed,  3 Jun 2026 22:49:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BF36998A
	for <netdev@vger.kernel.org>; Wed,  3 Jun 2026 22:49:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526981; cv=pass; b=Rs4Ugy9CsKlaSDPseAPzY7O7NIEbBXqv7aLFRyfAUMOAAw0fzFoRLYoh9YD/o096nGUOnKmVlsLHUnBkRkUrUZtXjg9kEJo7N89rJeZW9kpjk/chPJxAPDBE54iKWvCSquCiTLjRyYSFNMocbmtGJ2hHS4kiGx1jGGnAV9aTwSs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526981; c=relaxed/simple;
	bh=cIMAt4SxZf1p6upEqoxHSHb7RfP9hev2musbsbmwNuo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MUCbSImOVojeAatQBa1neDqwOCs/xSyLjWXkqt+gvkKha6lb+tuNReB4g9W9xIA6WjDBU5VF6MTo9g1cARbWPwdPpvsAEHTTJJurmcZFPiEOSkMEvz471p3xXmctEA6RB2pUc2qyBXNtRjt83EyFm8HhKkQRtmfV1lKRh8XcKNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amacapital.net; spf=pass smtp.mailfrom=amacapital.net; dkim=pass (2048-bit key) header.d=amacapital-net.20251104.gappssmtp.com header.i=@amacapital-net.20251104.gappssmtp.com header.b=Yvz/Dfr7; arc=pass smtp.client-ip=209.85.208.177
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-396aacc5bcfso135111fa.3
        for <netdev@vger.kernel.org>; Wed, 03 Jun 2026 15:49:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780526979; cv=none;
        d=google.com; s=arc-20240605;
        b=BQTKvnt+wZMu/3c9C4FDee0EaF2vTSTwKMa9CJoFt/oJRBtFNJNabjT1//zI3ikzH0
         u6GnH42ffHZbE7PCiHPUFefhHPPpT8BbNn16AeqRswMSH5sJvApuasD8rpNT7uQfqmkG
         NhZ6PSa0LR190fysBOIPp3Mf/wcNdX2glH8xD/7r6fvVdONOmvfQo3akQ/dweey164Rr
         flK3VHSKd+GDB1E3tb3VuqrVaZhJPaXr1Qwc1gh0y9hWPHf3pzV0EPMuxliEK6SC4ewL
         jinWX5OP1VFetarrBPvOOtmRsKlNOqzk2zC88oy8OocTP4mqA+xeZTIC9WMVoNh5BfV1
         t84w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=nThpP6AT70OYHi5mSxqfquLQYax1sVYjIai5D2em8kM=;
        fh=F6xroxEqsagTnEafqqowwfm6qZZAbvNOe9w4/w2T9lQ=;
        b=fzYdpE41Zb67h6wsvwfJfN9dfyhP4elabfsnyBkBKKeI9B8/hrSmwrkcl6HiJBoFC6
         AD1R9GmhdgvhUJ0FLKw93U9dEs3K2/bW+SUcJ8fqNkpSWBiBCXexff1qaUjrL85kzNi3
         5SY+Hk7yJAuNYjGJo/YtrBu2XOpV6Ws0ZmUtTxNJkjKKT/PMCBbt2nKclfqEBmJexfoI
         mB/2rXAWdkp0xgpvVtVLBghMRG7Zzqpm+Y6TYEC3gcuFKM/3SUJikp+L6ZUdb+EfmuVL
         ltd9Kn/JDNE9K3DYC68nDzKet4z4EPSnzB44+WzrtZY+03K0I6EEoNo2UgeCXgSZVjni
         CQCw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20251104.gappssmtp.com; s=20251104; t=1780526979; x=1781131779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nThpP6AT70OYHi5mSxqfquLQYax1sVYjIai5D2em8kM=;
        b=Yvz/Dfr7RO2sXrSJP1+PBKZaWQbv9Yj1UZbDb9M5lVzXO46ZbxlWsqABai/NptWCvJ
         2mPWVoP7aGv7pBODDhXPHfWedwHWtbqBZ+guxAdmCp8fXyTXsQ38bg4qTnFsHK7XT7Y6
         mZnzWEE78oDQZalRDxNDO4d/Q3Mr0+Ct70i3g0WRV28ce5eZ8dIwoZxjj1uf1gSUnrBL
         rzID1BdWO/WpObQbZOmKyZ8hvA7ZWLT2ipdZuiBvjivU4fcitjtonrrTXAcoB1JWDNR5
         MT7hbf+dRXraXtbsg9npXobz9en89b+0inCLnP2Ls5xFDE2PlShcKSimWnecW+fd2eqG
         7JLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780526979; x=1781131779;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nThpP6AT70OYHi5mSxqfquLQYax1sVYjIai5D2em8kM=;
        b=FcsA74JJGIPD3EEKh8HCgyEL4hGTWJZpxLyO0EI3S+jXlGjU2UVKcRxdGSa3wk0Fvx
         xblleg9N7IBtp42nhNS+IDpEjhopE69thkX/G0iPW9vPZz6Uyjxr8WcTLP885oHVku/U
         ULm1acEnkzJZ5uqZaY8hl3n21t+7p2oBm3vnJTAHHn8rmvDHyv88LT1vHcxoY6/1mRXn
         PkDAxYf/wagjmay07vC90/kMebT/GPolDOuezI2Md+tSk0PV8SpYxIs1owPEVk6X2bVK
         JlsCTqV7bRzy3IJbh/ysaCYyWk+SIq5x0EETzIxn+dvoNv1QV6ZLkDPPCemwMQ2wMQTB
         AtmA==
X-Forwarded-Encrypted: i=1; AFNElJ/JsJHwsp5QSplMFPrZRfPj7+bdy+yNn74msBGHboNBmkw2pcvnwiSpKGkmC2qeaveQU9mqeZQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpbhCq70637aAB1MctDAtUfnm/1rz3iSefEQYK+ie1sQNaaeOJ
	hU+XlVUgCjTf3Dhb0UXr2CJs/gd4SvIPa7pR4wpT6LbI/DIkOPJaE4BSSOwiurFvd32oo1bhkO6
	RFu+zISAq7QY8ZWZ/2U/sgibJkA08irolojzji873
X-Gm-Gg: Acq92OFRg3JoVFxrh1zYlKhjgw1jSHL85F8Ct4JSVgx3HEcE9KaqkX01wB2z+4uU/If
	n84NUQCHqDpHd+2RTF5qoLNhkqW2v7888GNPtJrX3Wppc1ghPsPYel0VNjGcWpehPSWjFkC5D5Q
	62Ndtn9Mid+WK9Zyqumz0OygchgvVMn1G+SnO043g2irxXGzYtumViElG0QjY0Jae9p9tI+T3Ga
	jRNQEF7kYwJht7/eLFLnxAOBf30OWCT59iXCehtk+Do/D3b+6J2SgffopqlAI8KiY6z3ktIdSdd
	nPVVUS4fTPkrMtiK4so=
X-Received: by 2002:a05:6512:a88:b0:5aa:7126:c661 with SMTP id
 2adb3069b0e04-5aa7c06347emr1703733e87.7.1780526978614; Wed, 03 Jun 2026
 15:49:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALCETrW3XcNLuB1Y6PSkxQDSK2o+=EB2AAd25SjWQqcJemwnbw@mail.gmail.com>
 <20260603224311.834796-1-safinaskar@gmail.com>
In-Reply-To: <20260603224311.834796-1-safinaskar@gmail.com>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 3 Jun 2026 15:49:26 -0700
X-Gm-Features: AVHnY4LigDaMGEZAFdtnNoXIyXd96f1pywv43JDsz9J-Er1-wYhHVKm162Sc_xY
Message-ID: <CALCETrU94ja56CA5CRtXrm1v_7gBaPUNOHKQzS=JNF9JZ7Fznw@mail.gmail.com>
Subject: Re: [PATCH 0/3] vmsplice: make vmsplice a trivial wrapper for preadv2/pwritev2
To: Askar Safin <safinaskar@gmail.com>
Cc: akpm@linux-foundation.org, axboe@kernel.dk, brauner@kernel.org, 
	david@kernel.org, dhowells@redhat.com, hch@infradead.org, jack@suse.cz, 
	linux-api@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, miklos@szeredi.hu, 
	netdev@vger.kernel.org, patches@lists.linux.dev, pfalcato@suse.de, 
	torvalds@linux-foundation.org, viro@zeniv.linux.org.uk, willy@infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[amacapital-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	DMARC_NA(0.00)[amacapital.net];
	FORGED_RECIPIENTS(0.00)[m:safinaskar@gmail.com,m:akpm@linux-foundation.org,m:axboe@kernel.dk,m:brauner@kernel.org,m:david@kernel.org,m:dhowells@redhat.com,m:hch@infradead.org,m:jack@suse.cz,m:linux-api@vger.kernel.org,m:linux-fsdevel@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:miklos@szeredi.hu,m:netdev@vger.kernel.org,m:patches@lists.linux.dev,m:pfalcato@suse.de,m:torvalds@linux-foundation.org,m:viro@zeniv.linux.org.uk,m:willy@infradead.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[luto@amacapital.net,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[amacapital-net.20251104.gappssmtp.com:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luto@amacapital.net,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-294958-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid,amacapital-net.20251104.gappssmtp.com:dkim,vger.kernel.org:from_smtp,amacapital.net:from_mime,amacapital.net:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 354BA63BA7D

On Wed, Jun 3, 2026 at 3:43=E2=80=AFPM Askar Safin <safinaskar@gmail.com> w=
rote:
>
> Andy Lutomirski <luto@amacapital.net>:
> > Maybe we should keep an API that does an optimized copy, from one fd
> > to another, that can send from a file to the network with at most ONE
> > cpu-side copy.  Not aiming for zero like sendfile / splice.  Aiming
> > for one.
>
> Yes, this is what my hypothetical future patch will do.
>
> One copy from pagecache to pipe, and then network uses that buffer
> directly.
>
> > But splice_to_socket involves
> > MSG_SPLACE_PAGES, which I think is a part of the mess that you
> > dislike.  And the path where one does copy_splice_read and then
> > splice_to_socket has to be a bit complex because of tee and (I think)
> > because splice_to_socket cannot assume that the incoming data is just
> > ordinary unshared buffers.
>
> My future patch will provide new guarantee: pipe buffers are always
> stable, i. e. they will not be externally-modified.
>
> So hopefully network code will be adjusted to use this guarantee.
>
> But pipe buffers will not be "ordinary unshared buffers".
>
> They still may be shared with other things because of tee(2).
> (But they are still stable! They will not be randomly modified!)
>
> But network code can do "pipe_buf_try_steal" and thus ensure that
> these buffers are not shared with anything else.
>
> So, network code can be modified to use "pipe_buf_try_steal", and you
> will get "ordinary unshared buffers" exactly as you want. This will
> give you in total exactly one copy.
>
> Also: as well as I understand, previously, pipe_buf_try_steal was
> kind of lie. It may return true for buffers created via vmsplice with
> GIFT. (I did not check this, but I think so.) I. e. pipe_buf_try_steal wi=
ll
> return "true" in this case, but pages are still shared! But, thanks to my
> vmsplice patchset (which is already applied), this is no longer true!
> So now pipe_buf_try_steal is absolutely safe to use!
>
> Finally, we can degrade tee(2) to copy, and hopefully this will
> allow us to always be sure that pipe buffers are not shared with anything=
.
> This is possible future direction.

I'm a bit nervous that, if I've read the code correctly (a big if),
then iscsi and nvme will still send *shared* buffers via
MSG_SPLICE_PAGES, but that normal user code will not be able to do
this, and that something will bitrot.

