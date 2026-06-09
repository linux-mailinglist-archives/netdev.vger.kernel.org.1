Return-Path: <netdev+bounces-297011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7n3WEzvuJ2ps5gIAu9opvQ
	(envelope-from <netdev+bounces-297011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:43:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DB87465F12B
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 12:43:06 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=cvgogunf;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297011-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297011-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ACB233060BC3
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 10:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F0473EF0D3;
	Tue,  9 Jun 2026 10:39:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EFC2BE642
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 10:39:22 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781001564; cv=pass; b=hOGEme/ukj+Z3bdCbvj03RrEaaCb55G/Naon6R7p2Cq00FJhznCkXQ9SKDqs1W+bqi+4sbetEUA9RE7dfLJtN3Kt8Yrw8qnIBAokmTGmtQw+rQfh4EJ3gSSKf6bCGwO48NYxCUH/71mqsurYPpc2ywysZnlN0L1MWyosKArSZUs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781001564; c=relaxed/simple;
	bh=IWXwyWTdkYyFuYBhCCpCpIk+dL44JrGbeBB/Ds1QIhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ll2JmACaA7dI+pAHeBo+y9e48SZiCtBz0fJJ0KUfLWky9FpimNX4/kHFpx5fD0VECaXr2cCrgfrFLdHQ9nBvpAkA6x+EVzd0T1bJJIfX4G+0S8RY8uHAVzRn4p/B0YS1X0AqVd9/gU6tg1cAam1jrRAm/y22b0OmH7cxlQ7uEaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cvgogunf; arc=pass smtp.client-ip=209.85.208.180
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-3967620ceabso50631781fa.0
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 03:39:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781001561; cv=none;
        d=google.com; s=arc-20240605;
        b=XvpJNqGt+EsbhRqNE1+6OyWPYB/b9oCjp4Z95NRbtDfk8MvzPrEADGEvv4xfnpFdQq
         p0scuJG/darsnhcs2h/m4/LcG9mac6t+M78N6FGJtWOSadJP9viwm9BgnRum2tHaPuu1
         CBGub+u7Sq8TIxW+GTY9BFpg0uPhoz8n2NNrC2Kut+IvY9nVvNG9DSFYS3KKHgAmdn9x
         JPT64meES2aRrz11a2wvTNS+ZBDnk+zcw01663wtPW+FKW/Ch00ubt0CeHvRoa9Lj2zG
         VGk9a5+a9kY5UvHGOcYSkAB6HgyVPbY85gFsaJEKIcQeEEKL/HtLoSmH9i/r+1ia3gyp
         vquA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=IWXwyWTdkYyFuYBhCCpCpIk+dL44JrGbeBB/Ds1QIhc=;
        fh=odRI2KAL+d8dnAsuFd6TXbJRK2hk5ELiuP4VWVKsRmw=;
        b=X3jYT2ycMsN/+jiUsbAZJngRl8QH/Biw6XWb2Lr2mdRKmR/poNWcMlXi6sgXa/XvBo
         kUiEJo8CL5/ZkZDsVCC89nh33Gz3EQWqhFmGrVy/ePyocGpi5DEyjlsnDwSGAG8WkYfZ
         UpuysY2ie1pnf2FMYHjZTJPQrkEbU/YDH5i5EhhscxmnAVezirbwB9NGLb2RsOxYMZvr
         Af/+FYtq7q1XO73EDk2rVsK9u0d8ZxP+AMmdW0O6mMxgbOB5y3q0YNIkQzMQIvITON+V
         4UImynC1pm51DU0NzyjQCJ7WmuWMzQUHq15ck3QJq8pm0lJyBClMhcAEJRw2Dl+ccaEp
         0/Ng==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781001561; x=1781606361; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IWXwyWTdkYyFuYBhCCpCpIk+dL44JrGbeBB/Ds1QIhc=;
        b=cvgogunf9qWh3ejV9c0cEFkcSplRyjem+yFNHmi6x8vyoAU9v7ro5B8cq0+utRFvyD
         /nWEO9hdtaqCz5lzWo0+L+OlVw0rYykzkA9bs5zw44xqughps3BEpNCxmYK22/l7+IzZ
         tP6PRlxGdejj61YRh7jOonXEqfGM5j/h18tKghTdrCuEPk9qiGyp37t+w4vn547XKYSc
         ayrn3o3E+SU0Ap3yxQUTPDv1jCQYSXtNFL6J7SDU/nTi+Wi8rK/V7jppz6wvItWTg593
         hPTA5JG6mEhTPZ0d3XDoaeu8fP3R1vQRe1R0YwW0Sk6wmQ24OVXBF/gZ/IG8lsIM/U0X
         xCgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781001561; x=1781606361;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IWXwyWTdkYyFuYBhCCpCpIk+dL44JrGbeBB/Ds1QIhc=;
        b=CUGk01Bzcbok0Bm0TqAIhDH/pe18zZdbPYFfnTh/9ktvTM3CSrxC2SKd0zDyAJ6KCA
         LgnvNU089oZeTyiCGwZyWpfV+SZlH+Liu0MlV5uSgIuUIBOQlGJII3ne9PwVAkOfuwCY
         tg1PGa4RkvbpFB3zO0hUwjW0PnVXzhzKY69nslBRekgBmyt06LVUYoKpZq4wlH4YNxLa
         YeejF9gQTDqodvVyO6Os2UzzyL9C3piievQbzAe7yjQ6mm4yn4xGajWuMnPxD9Qgz2Nt
         iq+c5rn+ZZ9AB8Q6XASVqf3U/NFnoQSafO31rC3ntYDcSXIuk3P2RuPNHjNXKXQ+WiLV
         tJzQ==
X-Forwarded-Encrypted: i=1; AFNElJ/6FeofBpLrxx2O+Qoj64pHQuxTLLoBMRxGD14KOepPxNxlnhzjQFPKQI89dz5D5IxXbtLz/Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvsrLUIJsbYnQltcy4xr/docMYyV6G9gBb/InD2hmJ3EcvFN9G
	SJ6bnLDXC0Vc1ekYQFhepxBoLfLezQVNhvSabnc0x7W7Mh9EmGg4wfehe6W8lidW5qQa9RfvJX0
	RZ8ooauEGNKbacURGtCZKso6PASSMNzw=
X-Gm-Gg: Acq92OED8HVuX19Zp/vTRQgLHH76pMkdOtZQxSmyI2nPurTe9ZfmhOdBikhayyQzZFw
	X4+uLN1Js5e0tpeDoCenogbPyv3yziKljiM99t9jJ3lDsRa/m2g5xVS2LiHtTZGlcLLyxvltuLT
	0jeHmNaILAGtv7eFftZUMuY1lVyYYZQayKrT2sDrPRbEgIOMTOLWYCKOwm2LuxFSmSn8EthwKbo
	5tqRlRtM8kgJLXi79CWHlswPP6qDxIWRcApslXjiBWTO7qwQpj+ER1TqhnZvKtfQiILUcJ4MwsM
	EynX8tknFj4IJnsc6+EuKqNvDY5GIjD+oQmUgppmEGDryR08Fw==
X-Received: by 2002:a2e:a5cb:0:b0:396:7d75:447b with SMTP id
 38308e7fff4ca-396d0993bbdmr53129381fa.24.1781001560751; Tue, 09 Jun 2026
 03:39:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609081113.7613-1-sigefriedhyy@gmail.com> <20260609081113.7613-2-sigefriedhyy@gmail.com>
 <CANn89i+8MnZGUiP0cLT7wJLPModjj3UkUEp87X0SRne8Wcj2+Q@mail.gmail.com>
In-Reply-To: <CANn89i+8MnZGUiP0cLT7wJLPModjj3UkUEp87X0SRne8Wcj2+Q@mail.gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Tue, 9 Jun 2026 19:39:09 +0900
X-Gm-Features: AVVi8CeXDG4h1D-5w4i3C_ibOpQ3NN6Zhoy31rbYO7UzZuz3ztcdEv5-7w5OACk
Message-ID: <CA+7S2v+76J8NAcZacyj9e_+g9ZJBwg2HxJWwahBpJYAdEao15Q@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/2] ipv6: mcast: annotate data-races around mca_flags
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-297011-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:davem@davemloft.net,m:dsahern@kernel.org,m:idosch@nvidia.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DB87465F12B

On Tue, Jun 9, 2026 at 6:36=E2=80=AFPM Eric Dumazet <edumazet@google.com> w=
rote:
>
> On Tue, Jun 9, 2026 at 1:11=E2=80=AFAM Yuyang Huang <sigefriedhyy@gmail.c=
om> wrote:
> >
> > /proc/net/igmp6 walks IPv6 multicast memberships under RCU and
> > prints mca_flags without holding idev->mc_lock. The multicast paths
> > update the field while holding idev->mc_lock.
> >
> > Annotate this intentional lockless snapshot with READ_ONCE() and the
> > matching writers with WRITE_ONCE().
> >
> > Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
> > ---
>
> You forgot to carry Ido's tag? Have you changed something in this
> patch compared to V1?

Sorry, I forgot to carry over Ido's Reviewed-by tag for patch 1. I
didn't touch patch 1, as shown in the cover letter, I only touched
patch 2 to fix the bug pointed out by Sashiko.
Shall I resent the V2 patch sets to add back the tag?

