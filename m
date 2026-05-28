Return-Path: <netdev+bounces-292745-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFPXGZRiGGpEjggAu9opvQ
	(envelope-from <netdev+bounces-292745-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:43:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E0BF5F4923
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 17:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AE5683003498
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950AA347C6;
	Thu, 28 May 2026 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gV7AvJ22";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="LI1U02yc"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 448A02E7361
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 15:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779981887; cv=pass; b=sF4kzclvzHmTUhBoMo3rBsgvOjn8oWCuCjz22kdnxnef9YRUQu+BIu8OkvuEi+vEZIIIh5TMw3nwJlcJ05ZCv9kAYQMPYg9gE2bAFIW4/ChZxzTpM5gr0jh8wuEFrMiioZDDoxVXym9+FcGrHJNuaYNUceToSSdyQXsZZtrcQMc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779981887; c=relaxed/simple;
	bh=mOD8V8VO94Vl73+R9IBAuZyeEdW5VU83FuEiKr7xxNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aog47rG3dxMfrb5zQxSXAQiSEqVjzKzIhxTZ6o8TYua109YRyfrO37lb4df8hcsUuOUPVy8w1T0R5sXxo/3GHlWjPVCvF2S4VQPRWmTRWVO+FNIOmS6dFAUKPBDoOI9KHzvrBiLrjtjE9M9E3zl8Q5TI8BU36/1jhbqc8zuqlYQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gV7AvJ22; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=LI1U02yc; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779981886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOD8V8VO94Vl73+R9IBAuZyeEdW5VU83FuEiKr7xxNU=;
	b=gV7AvJ228Vk2xYOLRSe+2ma1t0+mI9g6xLmabIhXO1jQUNAjf1Iatg01/G4z8xT79Gkfxk
	PUVBRXlKu4rec3umXXLiAkwxidkgCFtmam5OnBVI9F5AB1t9shz6Op9lsSEoPt1D92kuVc
	UX/Kq1XPo6BRN+R+BgeY1b920h9UyQY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-UR--oaINPp2MduMDNxrvbA-1; Thu, 28 May 2026 11:24:44 -0400
X-MC-Unique: UR--oaINPp2MduMDNxrvbA-1
X-Mimecast-MFC-AGG-ID: UR--oaINPp2MduMDNxrvbA_1779981883
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5a87c6e101aso7670789e87.1
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 08:24:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779981883; cv=none;
        d=google.com; s=arc-20240605;
        b=XMB3C4nhTeNPKd8S640Lnsf6zeOQMHPEK7GtgTCTEflD1TxLfBK1n+1r2EFqG1iHZg
         7BmTflF4oytHr4L1uen1K2OfOoRiXhEB3vVqjz/xUNxtbywUhVm8ZmgxpModvLPj0KzS
         Cnd3IP+QvUZPKbfs/IlBau3/jzX7tJkDuppBtxq9z2mDxIS2a+QRuAwq6+2band8dqhL
         aO4suajgPFH2aGiMuYg0e/50Xtms/GdMP0ycWDtIQSEduINdD8/MIDb8sqhfqyJxxi3b
         XW0Qe1/idFleBgBLXreN74osjPcPqsFvA87l0QDpvFQXZUuG+ISTH2dij+qaZYU/BYEd
         idXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mOD8V8VO94Vl73+R9IBAuZyeEdW5VU83FuEiKr7xxNU=;
        fh=O1h3zE3k8EurgcY3vTo2vlZhO9IVy3bvRKwnqY1x7U4=;
        b=cUEH++2mU4aca8msrmc2PlKtFTfDCPqI7Dcihj48X+9GvHgTMjLq1oEeh8WXFHF68N
         5FdPmA6VheTLHtsXddrx6Ay3fbChCqCei6oO4+8Zx8Yn5JmSBRPs5eUq3nzZO/OdJGmh
         MQZZmdcxCZqUdCB8fCDnq+g237DAJa7MpLZemIxvE5mJCY+aSSAas9wU/o7TqBTHycfC
         C1zpluuZNE9iIL8TZjHktF2pIzOaGJEqjCdT3gE4UurYFWCwThPC4jx4+4XaYZu7QY3d
         Q9OLvATeDcvFiEl8QDru3GGDmPiaXV1S8y6vHCmyx65jXYOHo+Pg66Yw++L+QEmDA4g5
         0OXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779981883; x=1780586683; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOD8V8VO94Vl73+R9IBAuZyeEdW5VU83FuEiKr7xxNU=;
        b=LI1U02ycr8XtEReuuEA6KJyGmGXXAhVewRQ/KYDz3Y8Vl+Izha8RqZBZNVGh2WxZ+0
         v03xP+9Ifo6YSY/AdeqT7HjtPdmhRCo02AGGKJQa4R+GedSMObO9StjpusbRB3//9H/J
         fQSrVc78VX9HaZnaD/aYLyeiAPhxhPMpBKAddJ7YTwnITOtHa6J8Gq5pC3Cg3FvoMn9m
         ShzMLmhh9UR8UOFgrTNsISTsC1xFWiEwALjPNwVInZaMCqMm32MTdl6WLZLkd31J53e8
         MRtxSIoVlDAMZN0Wbmxt0hmmAMAC4UIKuLn8ixiT2UviP+JW2iu7JMiRMnQ+pFm2Cean
         Y9gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779981883; x=1780586683;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mOD8V8VO94Vl73+R9IBAuZyeEdW5VU83FuEiKr7xxNU=;
        b=Qrr7aykUF/ctRqlyoUYgzPEL0diEB88oki7YG5VNQS2pq2VhjwkRccFy4w3EQoHgY5
         /2NAZfE8fkUiusysSiBMlH2R9764rXJaMGX/6/8dXXtvtCFpKSCe0IMpdkKui1InlwwZ
         QyWUTbP50Cv5FG+smCz1HvlZUWZCuKgjAq2skQL/aqYTdRh+W1greExSo8vKYE07FFMi
         RvITsxRsGisH3vlF5MonZRhF67ar1xcML+IXbFd8lsVlmWKXNYoLrBXIBfR8xruIaiLs
         XrR+Z3hXT9g1aN9zQmVFvZLvXo2Ah33j0aCwaGL14adD5lUnD8ZVIk9jFTnjBzZ7GQhR
         znuQ==
X-Forwarded-Encrypted: i=1; AFNElJ+aPTKpXoVcPm11pgizxBu4UX76oamY+PcJuLi4al2Fr2NNaAiIeDoQBn/0LnCk+7KjHn29Tpw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaEMxHROJyCsZgm3Itqlndyc6+9r2hNGjt3evHGOC63e8OU/EW
	E0jDLso4qVg837zGZq2M08pzoI7cEzlve/ie287iJp8cXx+q0C3jw0UwMPXPRx2eC3YGwD06pVW
	QigEs+amXGhBqx3GXz6gU6ij4pTc01+A2M43wDJUMUYwC+jAnh4SZpwIhEA2D1seZQz4SGbwMk3
	KCa2jrw+P6cR9CgiCVu1P1+m+KJC+Yvd4+uLwNzcNEW1A=
X-Gm-Gg: Acq92OEcWzojctNrNPC5x+wD4qxUqZYhWaHO0YrNiDKoN/S+0jctWBh9A3RpNDBXPib
	t1W9lVBSaF6OLVXv7t1P54A/Qu6U9zuYGdQU4lzuFHFoi6yuwbgs4o/LPCvPHfzAgY2JcKlmInh
	xghRdezrMjS1JLg26a+nLfCRg+0hVxwB8rx4cIo3Q7Y86cZ015KkMBmHFVKLyKTJdHrycTVu5v9
	O4mnPHjGqCoYcOZ
X-Received: by 2002:a05:6512:a8c:b0:5a8:8818:819c with SMTP id 2adb3069b0e04-5aa52de085bmr540745e87.16.1779981882580;
        Thu, 28 May 2026 08:24:42 -0700 (PDT)
X-Received: by 2002:a05:6512:a8c:b0:5a8:8818:819c with SMTP id
 2adb3069b0e04-5aa52de085bmr540720e87.16.1779981880632; Thu, 28 May 2026
 08:24:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260521135310.GC977@cmadams.net> <20260526175743.1f2c3761@kernel.org>
 <20260527010641.GA21073@cmadams.net> <20260526183122.348e44e7@kernel.org>
 <20260527215135.GB16443@cmadams.net> <675083b4-e015-4ff3-836c-798e0a971194@suse.de>
 <20260528073849.759da84a@elisabeth> <baba855a-7cc9-409e-9c20-6e50f35d255a@suse.de>
 <20260528131250.1352ab48@elisabeth> <b21c598b-879c-4f6a-9dc8-27e5c362803b@suse.de>
 <bd669eaf-64dc-4217-bae0-4a531e473762@leemhuis.info> <20260528153202.14900687@elisabeth>
 <CACT4ouf5ZqGgb=RO8_7NovLCvYKLKL4vD70dEe6xUODT1UEcSA@mail.gmail.com> <20260528165320.15b90ded@elisabeth>
In-Reply-To: <20260528165320.15b90ded@elisabeth>
From: =?UTF-8?B?w43DsWlnbyBIdWd1ZXQ=?= <ihuguet@redhat.com>
Date: Thu, 28 May 2026 17:24:28 +0200
X-Gm-Features: AVHnY4KanMkNYucjpl0BDejBeU1pjXJHqUd5hPA1HaiCXMbtsv0cmAp2Hlko-1w
Message-ID: <CACT4oue2EMM9Kfsm9Jii2rG9ooi=D37PK=8886cpLuBkwhrOxw@mail.gmail.com>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
To: Stefano Brivio <sbrivio@redhat.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	Fernando Fernandez Mancera <fmancera@suse.de>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	Yumei Huang <yuhuang@redhat.com>, Ido Schimmel <idosch@idosch.org>, 
	Justin Iurman <justin.iurman@gmail.com>, David Ahern <dsahern@kernel.org>, 
	David Gibson <david@gibson.dropbear.id.au>, 
	Linux kernel regressions list <regressions@lists.linux.dev>, Beniamino Galvani <bgalvani@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.25 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_MIXED_CHARSET(0.91)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-292745-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[leemhuis.info,suse.de,kernel.org,vger.kernel.org,redhat.com,idosch.org,gmail.com,gibson.dropbear.id.au,lists.linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[ihuguet@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 6E0BF5F4923
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 4:53=E2=80=AFPM Stefano Brivio <sbrivio@redhat.com>=
 wrote:
> I think what's considered UAPI in this case isn't so clear-cut. I guess
> it would have been pretty hard for anybody not familiar with
> NetworkManager's codebase to imagine that an application would rely on
> IPv6 addresses (and only IPv6) to be returned in the reverse order.

IMHO it's not because an application would rely on the order. It's
because the order matters, as the first one is considered the primary.
This is not NetworkManager specific. Or I am mistaken? I'm speaking by
memory

> Pushing this to the extreme, one could argue for example that if we
> accidentally byteswapped the last 16 bits of some IPv6 addresses, and
> NetworkManager started to work around that, that would start being
> considered established UAPI...

Fair enough. To some extent, it could be considered a long-standing
bug. You can fix bugs even if userspace programs started to workaround
them.

But, on the other side, it can be easier considered just a bad design
that, after a long time, should not be changed anymore because it's a
established UAPI.

> > If the fix must be in NetworkManager, we only need to parse them in
> > non-reverse order like IPv4, I guess.
>
> But that would then require some form of detection, and, at least
> according to Fernando, isn't the most robust option anyway, as ideally
> NetworkManager shouldn't rely on the order at all.

True

> Wait... that's how confusing it is. That's also what I thought at the
> beginning of https://bugs.passt.top/show_bug.cgi?id=3D175, but it turned
> out that insertion is actually reversed for IPv6. Dump isn't.

Uh, OK. That's even worse because even scripts using `ip addr add ...`
may think the first inserted address is the primary.

As I said, I leave for Beniamino the considerations from the
NetworkManager side.

--=20
=C3=8D=C3=B1igo Huguet


