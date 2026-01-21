Return-Path: <netdev+bounces-251862-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAXzJ0XNcGkOaAAAu9opvQ
	(envelope-from <netdev+bounces-251862-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:57:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 65CB7572B7
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 13:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C6D6D9E649E
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 12:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C08CF44CAE2;
	Wed, 21 Jan 2026 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="TsbuY5Rb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1F72E414
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768999386; cv=pass; b=DAAhtZswrsCiktJ0T+UNU9h5sgBuHec3QmPsPKiOwmXmgF7CTYJPOY3DRdp7YmCnD/A9kItLSTw71xfFrvBaabCHVK/NsA+tHh4DwZ19/qDA54gxJMFZ9S9S0QIpizTG0C47fOc+oM/5bjO/EvALFtdL+8ZdfagA0jauHX33eeo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768999386; c=relaxed/simple;
	bh=F4W8QEgzjnO8NfDhGCcs69hZH5D3mlX7mCIdRwUXGEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gigqft/lNa+YoDmDIxtlBC9slquFSc9mfcz0/6kCgMpErUvfRYyqef+fjHEEncYINGRuILH+1zDOYIU1bc7JXuDpmx82O3LgNgO/hZk1U/PjgCnQJN7Py27sGnLGbKstXs0awfGlOA/AqjDAh2rlpen38zmxBeORsIWqh7hDdeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=TsbuY5Rb; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6446c924f9eso5422836d50.1
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 04:43:04 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768999384; cv=none;
        d=google.com; s=arc-20240605;
        b=KjM6jbaoAkcb72Yppq3pYiF5yZIBBHVIaAcwZrWKBIDMID10POpTHckYWRhbJTlEom
         vSPwRAZ5/drM3Q7awURRKzHO5F0W2wGExcQf5rIHTe7IP5t5wVWK6qymwZjAKH++Fel9
         riRwOl8loaYs5Cbf6A3WRzOEUbSxeuoWHdB2j7BbaWImxdHbMNkvm38Ok7p3QhV1dEpD
         zx+mP0nf4HBEKrIgbTCNVzhSk9S63mGh46wOsDTqAx33UjsyhhgpvnuVnijNlY7fClvl
         ACp154H7/LfZzLlQgkYNLWhbKAopDOrafgHWgeVayx+91KwuNG4BetomlE4TkjKuGWiC
         EzSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zzquMhNeBJPqbj4nPsbpAdeLaivWEBnUHnDMfWUomS8=;
        fh=8UDauyIvQmqvtQyg6OX+MrsOKHsmZJ56qg3arIzpy9M=;
        b=GnS0xXE7CnzpF31qnqbUsx/WJrtaBA36ELYspNOpvhHGs7uyrBw8GfFtDEr8KXKvfo
         ImFliH9SQ3KtrQIWeuo+Q0sNy9nSX+PLCyItkY+Aw3fzyeDq7h2ywR3POEicBOtz5EwU
         gJakszwJf4pvmOUjhTuhL1TNH0cljD6P62S6agkIq34eLkpCAjYk6Gk+MFNoICEZfjAs
         f2BHe/H2KncvucLIvEjBNIjrbhTLFXY/cRINPqnRnlv2hnqj8Q4tcZKZGWRbZeiHVx7W
         9WnE8JijpPhXOCqRvS78UKuvUT2NdSnGljLwZ9CJwQK11J7W637m51UWEzBo/j/NdOB7
         dE4Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1768999384; x=1769604184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzquMhNeBJPqbj4nPsbpAdeLaivWEBnUHnDMfWUomS8=;
        b=TsbuY5Rb+KFhYuvC8KhNTsrPdEJw1hJdvtnItIE63h5atl8t1tKFEfgXRbVycRm7P6
         8GVCnbd3+VyYeGy040QMlvDeOtBlPhwAFrHDeytyu5d9pnlJKOQlo70uU8ITGVE5F0kq
         T8iBRpq7KkDVtlZJcCKdqhk6dQOKcwsyeDpSbDCsktGp+fUMWq4YP8KJEcbAyWIggOvN
         SNLWK6O7DqWhkTHU/VUx9gCXZe3+/mxcdblex2S0dlhDATmApBjdH86W2qHP4PVdgRJG
         mF1qE6k6meLeUThbxj0OuSNyXvlR4+olbrMg+CrEFwjTKGQKUFuAhl364FbC7subqop8
         Qzgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768999384; x=1769604184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zzquMhNeBJPqbj4nPsbpAdeLaivWEBnUHnDMfWUomS8=;
        b=UCpKnE300pVHL2idPHdkzl+4G8PlERVkh4tML6DlfGzZVBwCHhxKdryZle6zUIIdnE
         Mat1dydIV/DF8Lyx5xhUgwpkVnL71DxHHVY/Y/GKAa08QPfFGTg4ho4AZj3S+P8KP3Rs
         b7G/FwOQNdzBR0xEdJVcr3RDeR6RO6JNWnfdc+NfnltKiiimRB3odUw2jb0DFYLaQpPS
         e6eiW9u5pd5SNSPp6vXv2lgu8XuRKDj/OQtB8xKGXRQTyP4+zCDcYkRKZSTeX105Pjms
         3KdAhkFJdGayoAfeXQNVQadLmXRq5SmeVBafWbmwZp5hG9nYf0O9m04mK3N/oLOC/CAM
         mkuA==
X-Gm-Message-State: AOJu0Ywv+WyDLtNBU+pqv0Hyyisch9ptx+WBhzGc2YMR9yFcagX+dEE8
	56epzbj7HjLd51/LJeWwJyeLNUuV9Pb5v2+DmDFnTCNxRIx02F4VQZh4BdSzb8qiDF8jpnGtyhR
	EXSaNqjgMcsZACo87izxsSAQ06Ny4hBYx2gOaKw1RI1B9RMleDBk=
X-Gm-Gg: AZuq6aJOjG0RDeV5thiOUUcU8PjcinDGfnoOrAfXOEba9dWUCd+F19KyUZ4jmRPxR1W
	K1bDW/1cAVbJe1d1YKn+EQhmjBYBp666tFZnPY9nJKwybStQIvhiWDuWfrxIrDInRaxpp2HHiWA
	LyWzmBzOj3oZCqoNr4/hwI6Sh4lk93um6ZdZwECbEQlGLJ3D2VM83rAfKArPECADlMvy9Jg6ASZ
	H0L141rXIC0MirFf1hLDVWwsv6QRYxEP8cVfwYDdrt4/MkyTN9jmSRToENFhWF34GabkWsI+TX8
	gi588/OSRA==
X-Received: by 2002:a05:690e:e8b:b0:646:4f86:4f1b with SMTP id
 956f58d0204a3-649164cd9e6mr15934562d50.61.1768999384151; Wed, 21 Jan 2026
 04:43:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260120004720.1886632-1-p@1g4.org> <20260120004720.1886632-2-p@1g4.org>
 <bff53f0a-2c94-46b2-bb49-b05d10ae420e@mojatatu.com> <4v-I_ZuHhZBLG3lGttZ9HHAT8n_AggP70Rw2IDrj5w6BK_Ol2VoPsR9eP-BKBlLToLNNCElTtbXdTRdD1wsR3QzlCoSaBi6R7SCPn6CDk5c=@1g4.org>
In-Reply-To: <4v-I_ZuHhZBLG3lGttZ9HHAT8n_AggP70Rw2IDrj5w6BK_Ol2VoPsR9eP-BKBlLToLNNCElTtbXdTRdD1wsR3QzlCoSaBi6R7SCPn6CDk5c=@1g4.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Wed, 21 Jan 2026 09:42:53 -0300
X-Gm-Features: AZwV_Qg7ofwKki90DQFLtomP2kQYfAp7dIw3Gs39PWW6oR7LS18XId3KbNW5jeQ
Message-ID: <CA+NMeC-wBDTvwvxAy5Za5Dq0wXpqYHNVPV_wKk-kfpSyAWCPPw@mail.gmail.com>
Subject: Re: [PATCH 1/2] net/sched: act_gate: fix schedule updates with RCU swap
To: Paul Moses <p@1g4.org>
Cc: netdev@vger.kernel.org, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [0.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-251862-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,mojatatu.com,gmail.com,resnulli.us,davemloft.net,google.com,kernel.org,redhat.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,mojatatu-com.20230601.gappssmtp.com:dkim,1g4.org:email]
X-Rspamd-Queue-Id: 65CB7572B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 10:00=E2=80=AFPM Paul Moses <p@1g4.org> wrote:
>
> > Also, the AI review [2] pointed out a real issue.
> > It's easy to reproduce by running something like:
> >
> > tc action add action gate base-time 200000000000ns \
> >   sched-entry close 0ns index 10
>
> This was never allowed. A zero interval has always been invalid for a gat=
e schedule entry

The issue is not whether this is valid or not (as you said, it isn't).
The issue is that, with your patch, this will result in a null-ptr deref.
You can avoid this by initialising the timer before calling tcf_idr_release=
.

> [...]
> I will prepare and test v3 with your first 8 suggestions and await furthe=
r input on best practices for avoiding a monolithic patch and on appropriat=
e levels of validation in this specific case.

Ok, the main suggestion is to logically break down (as much as possible),
the introduction of RCU and the other additional cleanups/checks.

cheers,
Victor

