Return-Path: <netdev+bounces-60221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 010BB81E2EB
	for <lists+netdev@lfdr.de>; Tue, 26 Dec 2023 00:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 199841C20E59
	for <lists+netdev@lfdr.de>; Mon, 25 Dec 2023 23:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91C321EA7D;
	Mon, 25 Dec 2023 23:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="uSXQnpsO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC661E51D
	for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 23:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dbd73ac40ecso2666564276.1
        for <netdev@vger.kernel.org>; Mon, 25 Dec 2023 15:01:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1703545286; x=1704150086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M/El/7HqAwy3Au1NgzdnJaBiXnlBBReCoOu45FtGb20=;
        b=uSXQnpsOevEyEDu8IxMVzupEc7DDAHyCzBIo3BLY2PZ3/LDny5ZxL5zNGy2/+gF03+
         KyJFE8f3ZYymkBwf6CAnhTK6P4b1O2VYQ2ratvVvqfbEozzbi+EeUzuSVHZ6qasPsSOJ
         PrWusydnV/fiZmhQWYCfUQAF4kbn3vMs8rEaoeuT8oQA96M/clv2kUNVI803B0B3Sf98
         tJkTIyoiOjlZRDKC+6X7Jz8v9cHzXIdDMXA8I9JD4fKu2rgBw7YIA6NhWd0bgxM77Ms8
         y9MaM8eLQaUBjpsm9CLvCKi1sTPhxP/BH88ls1Qmnzd0I03nqH3x4dBfmTAHk422idMD
         NLFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703545286; x=1704150086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M/El/7HqAwy3Au1NgzdnJaBiXnlBBReCoOu45FtGb20=;
        b=JnMVBznqef4EABClwB24erl3DIB9f3OpVmHr1geDRJ+Dw4Zm1jfpeX/xl0uDBJnTTl
         BcAhktWLsUbFdNFZfGc8hj1MwdjUDh4gwrjuttN6ruMSODxbR9JyxsVVZoZlkXIIbjJg
         FM6QjZyBMIWV85DeoOJes6LRkgtLIsjBl44Bq/D4cPaMIthk9zODgidqmJ4KlD0QYY1u
         OSpZEiFUO61YL7UrwK/ojLSh2VSYdnR4Ib+eXEWe8O4iuuIoUrIYsIVRqjLNVj+YwpAx
         siAwdT7tokA1pch7IWGyirflER5TDDFWy6ZgNe4Uo/yCgD07BijWSKdEv4TC+Y+37DO0
         gDBA==
X-Gm-Message-State: AOJu0Yzod5udTm7KFnN8blXNUy0aRIFReCZMXfo+IZI7b3TWzcazTewH
	zsms9cQfu3VUNb5jG80Pm3gsJuKkNaWWNJvEkmscPmi2gsybjes/t89t2Bt5kw==
X-Google-Smtp-Source: AGHT+IFmPWNSHexWKfaq6BAe3aGb8NGrlLWTD2w8YM3t7dz/y8CpysotAliZ705s2zlxv9Oo4cR+jwnpWDJUsNHhqYQ=
X-Received: by 2002:a25:d782:0:b0:dbd:6506:d8df with SMTP id
 o124-20020a25d782000000b00dbd6506d8dfmr3151690ybg.74.1703545286574; Mon, 25
 Dec 2023 15:01:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231222173758.13097-1-stephen@networkplumber.org>
 <20231223123103.GA14803@breakpoint.cc> <20231224091118.2ffa84bb@hermes.local>
In-Reply-To: <20231224091118.2ffa84bb@hermes.local>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 25 Dec 2023 18:01:15 -0500
Message-ID: <CAM0EoMkqijrTv7SSrQf2sHEZWShgfwLKzcVtPT17HK3vR-gsrA@mail.gmail.com>
Subject: Re: [RFC iproute2-next] remove support for iptables action
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Florian Westphal <fw@strlen.de>, Jamal Hadi Salim <hadi@mojatatu.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 24, 2023 at 12:11=E2=80=AFPM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Sat, 23 Dec 2023 13:31:03 +0100
> Florian Westphal <fw@strlen.de> wrote:
>
> > Stephen Hemminger <stephen@networkplumber.org> wrote:
> > >  tc/em_ipset.c                        | 260 --------------
> >
> > Not sure if this is unused, also not related to the iptables/xt action.
>
> There is both the xtables and ematch options to TC.
> Jamal do you want to remove both, or some subset?
>

just the m_ipt/xt (not the em_xxx) which maps to the kernel ipt action
(not the em_ipt which is part of a much larger combination of
matchers, do "ls net/sched/em*.c", of which matching on ipt is one
small part).
There are people still using ematch... (as Eyal just posted to).

> The problematic area for iproute2 seems to be the dependency on libiptabl=
es
> which is not very stable. On the kernel side it is one of the places
> where lightly tested integration could lead to lots of syszbot errors.

Note: the motivation for removing act_ipt was not syszbot, rather it
being overtaken by events. AFAIK, there's never been a syszbot issue
with either act_ipt or the ematcher.
I do empathize with your comment on the challenges on the library.

cheers,
jamal

