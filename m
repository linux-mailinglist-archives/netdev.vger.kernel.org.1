Return-Path: <netdev+bounces-296155-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7djQCH6FJGqj7wEAu9opvQ
	(envelope-from <netdev+bounces-296155-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 22:39:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE0AB64E501
	for <lists+netdev@lfdr.de>; Sat, 06 Jun 2026 22:39:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=google.com header.s=20251104 header.b="be/7Bcdw";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296155-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-296155-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=google.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 969C830C5BC1
	for <lists+netdev@lfdr.de>; Sat,  6 Jun 2026 20:33:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 643F33BB100;
	Sat,  6 Jun 2026 20:30:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297DD31327D
	for <netdev@vger.kernel.org>; Sat,  6 Jun 2026 20:30:06 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780777808; cv=pass; b=NvjeoXrnXofDpbbonTcvXYYcaKRkb0nYI2/23M3rS90FH5Zf71epYfkwwdtbRPPTTHTv9JKIxJggJhnRvDeiGoQYJTiodHt3DcvsEx18tkjudiQvI7imBX6bjkeD8EEzigcYdlRRPAvm/tVPVc5LmFiDsZQsJHnqu39xa7XoIPo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780777808; c=relaxed/simple;
	bh=BXmlLPOAouj55aZR5Z231tQ+5+yOAsTB1XYajP3GNkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E5blTW96D8a22lMcLyyQiJpotoCsWyTOlubpJ2p/DxwoteQvExxbVbmz7oT6oaOqpBPPNVRLdbhPCumNXDv7u2Nkzv/wxcKuKpSQYEVzMMxFtaITof/hjRrmPEdTFoLScbOhb7HUiPhhnI7bjVnLaVnfs7lT7MMCB/QPZO9RShI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=be/7Bcdw; arc=pass smtp.client-ip=74.125.82.52
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-13808436ccdso3929692c88.1
        for <netdev@vger.kernel.org>; Sat, 06 Jun 2026 13:30:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780777806; cv=none;
        d=google.com; s=arc-20240605;
        b=dSo36hzz9s2ZtWC6FkuCbQlBQLZ7qHSxxC65xOD7nXtFXz66tV0ucD33LqWIk1Kpd3
         nOV0vHUHAKP/thC6xeqmCUxx0Cc2L6dvrFYW34N3C51Ty1JcINxC3MypqaJLWD8mW0Gb
         O7wVt8roJpJKpdf/75yaMWUuWgyyVkDPVeMBHlAfGVy1mcWg4AAwWu8V/Icu/jiMsH2F
         K5ckzbYKhDkiikubMcaBdl7gm9YJhXd0bMZq7Fnb/Q7owC/ToU1Wy/vx7TA+ZNnRq+2J
         4z1THEr3GPsChLufIL/GwFhKpIY2lI3MZI2JJ2/q9074cwkoeIGLFG8+KkmnQJL90w+P
         RGVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1SLs08VFmrvVfMyB6YZLBVBsY6+S+bY35lwafjP/uOI=;
        fh=zthNbhy9mB1NriJeMEEWd1xzipeCp1v/WFgMAdUy4oQ=;
        b=egCbifGvH0clE+EZ0BwtG+8uh3hfZaEVMRGNCy54ARXIZnfAYau3biqDhzsk7UC5Ta
         q/bIH57vX/piwc9hZfm77zfZhYif++Zti/H0xqfjiqI+kAe6eQ/EP+0WzU9aWNN6dwSM
         CY/pkb31ArU3dn2Vfi3UCGXkCjw3pTKIGzLphYdMCfJPZr/1xSt4zVBgJSCOk9ZTVJ9C
         9kAUuJRQrnitM9HugE0rFSY+BhlO6BxM86PEnPk5ATa3F3wsmGMTKP++8portCOUshlX
         /6TMd/lIyC5gyAj+Tb3+lgF4rgxoRh/eWdDls751YpILXC3ALKR3xhxkvPyZPE+1oP38
         kgYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780777806; x=1781382606; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1SLs08VFmrvVfMyB6YZLBVBsY6+S+bY35lwafjP/uOI=;
        b=be/7BcdwsBfd9ii9WJV3NAZUEpX5pipn1/tjlr+KXSmqwlrKV2jF/ZKHJjzHRc8r7W
         f6Byd8Dsb6NYD78cyR33gH0TtRU/VYGOtnnEGj/V8yYiXup9PdubF5QAis+hrQM1sZg0
         thVX96juckQD3TXjzLVhWLKS2LM45mEOKzREfbiMM8fJ09chCrWIO2iTyLiNG5/9D4Ew
         YXy8J/wwmlFMJccDTN6hZrk9ocHyWaWEJNRkhfrarYklViAB6517tYRsgskdnBWMCZak
         fEdn6+h5xvMY21l0U06UAW8CF5vWC1p3pYDnjxL0GByUSYkvAfknJHF2noDWamNGI0l+
         ROLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780777806; x=1781382606;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1SLs08VFmrvVfMyB6YZLBVBsY6+S+bY35lwafjP/uOI=;
        b=gJ2KcW6GUsEx8BnjGCSzcc2NoQb1/VS0Wy3Bsx3I4pQt3XoBQqVL8+MdQwmy5G3Wkc
         MKCMfae+4F/PKdeA9JfbPh0Re5LgnJ0DH2tJYR2q92OtTJwd07Bv6J/SbFwIi0q7V8cl
         XlOJfG1R6900bDV7uhuRReaXnEm3A+qsE1wLHH+HzcCdcyf1LtV+MptdlqLUpXuWMy5V
         UIoVbuOfypgw3WQFFQ8YmIb9tWcphxq9Kdq6IEM3VJGYShIX7jwhXuTQVULu44fID63T
         TTciqO5iB5CCrNE7EhrruI6T5a9i6fIrDAqYSK+gxsddcsHGSCO8mO5BoZoxhETD7gWl
         fYzQ==
X-Forwarded-Encrypted: i=1; AFNElJ8ptFppvGD+EEpHvSzjqm2ok8gj5KTTaJ2yjS7r7zR/qimyNiivXhld5uGKNtSto8OfeoeM3w8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC6TxikMOSUvzuNZddH3GoPtnCZwhMRG83HLKpk3IqXANvI5xt
	MdNT/y6atvmoarNWoP0US5hTQKUtbXT1tcL+dIhGOVHMcPCerDYLNyPZNJH60HBDJBFiLLYomSl
	zYZtHQyrW4hYUNm7KmsN5P89Xvq9vHRvGcnI3teZ/
X-Gm-Gg: Acq92OEPCh/NDVg76+d51F1uVgZDPPEl5PMcoERrFLAQl5Jrwsasr+wjY1o8oS6rHOx
	SMyg/rAkaIb9j4O9VzZTWsh0u58Zk/bvsi9ZBfLfAyDDf0dpYEkN54uW6qtPyP0UpkGsG5YIImA
	94zPXkydu/DKXAUW4KtsojHi3Q25trbR/shyWgLu+PJpTUH5uuMCxJIHvKa6TIVF78Cvs8EYeoh
	TRNTdkfrm5idaDg7vVcwDhPVnO9bGAEBV43qnPjPXm+XiyRpMbRDtKXrqOsgVLIZCfnsroId4KA
	IzTdxX3Gyh95odJWlAgLHNz6CRV+KH6Zya930jbrWuMgOf0yx/qOQ3YYghVXlikZyJG2+oK1Yp3
	VpCbc65Er7jyQVyns0saVcCjvPQ642TUnia+4II9FGu6PV89/4jkiT8cuOBhMBD8=
X-Received: by 2002:a05:7022:204:b0:137:ee9a:2ad1 with SMTP id
 a92af1059eb24-138067331cemr5151779c88.35.1780777805549; Sat, 06 Jun 2026
 13:30:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260604052127.2227300-1-kuniyu@google.com> <5733ad97-d8be-4bc9-ae66-9137b93708b6@kernel.org>
In-Reply-To: <5733ad97-d8be-4bc9-ae66-9137b93708b6@kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 6 Jun 2026 13:29:54 -0700
X-Gm-Features: AVVi8Ccm7ukAFagTsrt_mw9IHvcP1CV7QT6LatIDsGFNfO70IBtlUXcPYa-QwHo
Message-ID: <CAAVpQUDkBwDJb4BDrB3-hiDbOA10po6GMs+XfZOVEWhZ56zLww@mail.gmail.com>
Subject: Re: [PATCH v3 iproute2-next] iplink_geneve: Support IFLA_GENEVE_LOCAL
 and IFLA_GENEVE_LOCAL6.
To: David Ahern <dsahern@kernel.org>
Cc: Stephen Hemminger <stephen@networkplumber.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296155-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[networkplumber.org,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:stephen@networkplumber.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kuni1840@gmail.com,m:netdev@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AE0AB64E501

On Sat, Jun 6, 2026 at 12:27=E2=80=AFPM David Ahern <dsahern@kernel.org> wr=
ote:
>
> On 6/3/26 11:21 PM, Kuniyuki Iwashima wrote:
> > diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.=
h
> > index a8c64be26f2c..d692d466da6b 100644
> > --- a/include/uapi/linux/if_link.h
> > +++ b/include/uapi/linux/if_link.h
> > @@ -1487,6 +1487,8 @@ enum {
> >       IFLA_GENEVE_INNER_PROTO_INHERIT,
> >       IFLA_GENEVE_PORT_RANGE,
> >       IFLA_GENEVE_GRO_HINT,
> > +     IFLA_GENEVE_LOCAL,
> > +     IFLA_GENEVE_LOCAL6,
> >       __IFLA_GENEVE_MAX
> >  };
> >  #define IFLA_GENEVE_MAX      (__IFLA_GENEVE_MAX - 1)
>
> drop the uapi from this patch and

Do you mean split into two patches or will maintainers
sync the header before applying the patch ?  I guess the
latter from git log.


> update man/man8/ip-link.8.in

Will do.

