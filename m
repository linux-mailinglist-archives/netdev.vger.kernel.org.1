Return-Path: <netdev+bounces-304379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id djlRLqBcR2r5WwAAu9opvQ
	(envelope-from <netdev+bounces-304379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:54:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 790FD6FF423
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 08:54:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=lNeRAGEq;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304379-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-304379-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CFEBC30312AC
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 06:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83228386C0D;
	Fri,  3 Jul 2026 06:52:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0BE038398D
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 06:52:43 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783061565; cv=pass; b=hnuXca0kSMZm0rrtEzVnf/52qqklLRZpZgLrDYov6VbfaDyR/Sa3uw85Jtg0andHz4pI1mM44J74aLtuGrVuBzUgQw8Ht+ysze6uRT7yBjKhol7/VJ8nLLHBSYMnamm2Z685bYKCzVSNYCNeNgQQy/KUVtjoC4WF2CR8iPYL1f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783061565; c=relaxed/simple;
	bh=6rmH7nFZ3g1kVeBhLP7Bf7XYtTGA2NkjIVGswHHX8A4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsfqubOPgr+yejAfnDgiRSDM1Zx0qJ7iw17PYv9uQL+NYGrSjefFwVrLohZmos65DCSQEo0wQ1cOnw/Cq3hx59mFQXzROEVQm+iVw05RJpMA0fd0x914N9Suq5JARV55t4V3y4v8eQJVEquooaQUA0yRKs555RalMK1IfYk6Oic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNeRAGEq; arc=pass smtp.client-ip=209.85.208.174
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-39b093b42b4so2183041fa.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 23:52:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783061562; cv=none;
        d=google.com; s=arc-20260327;
        b=W4Bsf6G7TOnGrVj/6gVI7UcSwhMolUUW6hTkyObXv5+85+RZyQ9fXmgU5eJRSjPUyT
         ST3H3Xonz24QUsH0wHXUS/bttXgSbhs8ACOHyiZOH8+Zok7XJF4+FZnVAqtfwmI/WYry
         IHTSREKDpetnYKffyLRKYw4jt02kKBpa2N0dlBuFu1gKCgey32cX1iiFFDLgL3rPcrl6
         G7RDeqYVGFJCC3ynovxVf/sdgS+DMdsz1O69Ah4Lq3ww5+Ks+dqgKHQCDF7Cvd1LwIku
         hsChYtAze+7KZ1LrvPVHpC4EdYJd53qnyuek3INkblnHB6kLWmZxphAJ3i9BiOGWClaI
         VpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6rmH7nFZ3g1kVeBhLP7Bf7XYtTGA2NkjIVGswHHX8A4=;
        fh=KiBLJiqb7Y4m8HfBvDWaOPZlKWYxMmIKnX9zA0l9m/U=;
        b=jkkZxH23frssDn2qGeq9OnXT85A5N7HB/PXX0XSuP42Xllse9THzNkmBQQ1Xb1w6kK
         RrMIRrHtaGOJ6PO8J6h0LGBerxEf5E7xCThiqwcJU09E/7DFhFZQThbYX3GOBjyR6h4u
         QAfe/1dshJTJ26m0/qOEvd8UNvjGfzFXVTKDKqQag9Lv7WBaOnG95plkwOf/v3tRdXdk
         qTMlTMNpMPzky+alsT6vVTlJVVTYj45aIe2reD0VDY+XDaKRbKEVN2xU0NpX37sd1PPD
         9pkbzpbe7zhZgsxjElMaLywOHG3xIV+Xxjh57fNtHHDhuM5JJEbfy9ImOnMQS9/Z97gi
         IIFA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783061562; x=1783666362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6rmH7nFZ3g1kVeBhLP7Bf7XYtTGA2NkjIVGswHHX8A4=;
        b=lNeRAGEq8KkMb2LBZG50tYY1a1dIgu3GLbwkXgfaKFg4AkYvYTP1GSyQZiIZFtABuR
         XLG2caobbnKDvUWhvm1CVV8yu9iHLkt+uJYaUnkE64xjwEDIXrbRsgipIkTfSjv554f+
         vdFzGfIutiTINhUcZioP+uWYOjMSankJC8ARxrYphNJLjJytA5lqSMLlkSQSSQ1lNW2C
         2GhVzaGvNYlhvg8FtSo0K9X3AnvU1cgU2XkadFxV8j22mM/iEq8Ry3Ngz4t6D4FawCSo
         Hkn8gInWgRrFoYBOSQg5ryXbhT/zRStYq8vHsq0PhvNZyS44xC84F9zPlp4T5INkn9Sr
         IdUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783061562; x=1783666362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6rmH7nFZ3g1kVeBhLP7Bf7XYtTGA2NkjIVGswHHX8A4=;
        b=MH+d60Ado+PGPwmD9q+Pf89Fdjjs9o5qPs91jGADb6uPz8Yw3bMWchAM9HMWlyuYGP
         sBYa9eGQEeQd/H0JO+QgSrYu3IOYdt6LtrZevmRtEiXztOrh2a9cfucJsHZ4ctKUstSS
         TyK+MHhW6NGbLJu62AKHiBFI3Nm+u4iojgJIoiUJWFTuDqffwhuqDn4PMEdzm7gNwZis
         JGtFn3HP2/mYHcIEFW9d2x25vuoFcotrjHVaFK03zlkQHJEcRoe+7ipobBw1N16tfKIs
         Vkfdh44MLN3cH0b2MNlkVrTqSFF2gei/F0GJRlin3LUKVhuxHMz19aZeq4reDp4VmPdC
         AOJQ==
X-Forwarded-Encrypted: i=1; AHgh+RrWR3xImIOoFgCeGYZF1230d5qr7rujl5X7mEc4ZbVVX4ROvJs/9zk0Zh2mmQr/AG8+PxPzqCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YygBpATfxaost/1VtRGcLvSGjMd8tN1v83Kk0XtdKeUPSoeG7fS
	k1B7JkZQ6yjTOI+4sckHUgq82VhEwnSF5KKbjIcxlPJzLl8dDxRhLtEAIhkq9jwt0qVpNDHiWVW
	AhCeXLAhTrWnhlQpPTvZQEPA9K8s+Ld0=
X-Gm-Gg: AfdE7clR12qflzVLR4HNSr0jYjcWppyEGXRe7cImNSoOCXJzQxLe+QF6ogupgB7x24O
	94N1U3Cr3ylkQ1IVxuGFaEI3bB9npvO0qJ6enbIghev/ZwRWBYvdI8UyVeJp3OjJ2Uj4MXo5DTh
	M8jP235SuZS/Bx3hk+UVVRx4Ixi62soR16c18skJ8X3I5pwFNeMtuNL42KyPpmXp5PsH2trbqiI
	jz89+7K7EN7vLDnN1FQbFgZnzslpi94kyfpl1nNhJAW8sLb+gqXDxxAiDpZeWcM+/VLdYrj0zjP
	HHSLqdNKay+E/evuWgeXGjjzL0CI3rVbc5afer0=
X-Received: by 2002:a05:651c:210d:b0:39b:3adc:70f9 with SMTP id
 38308e7fff4ca-39b3adc734dmr12890031fa.1.1783061561803; Thu, 02 Jul 2026
 23:52:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260630110207.37841-1-sigefriedhyy@gmail.com> <2a0033b6-9a54-4de3-b1a8-78d4bc815f56@redhat.com>
In-Reply-To: <2a0033b6-9a54-4de3-b1a8-78d4bc815f56@redhat.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
Date: Fri, 3 Jul 2026 15:52:29 +0900
X-Gm-Features: AVVi8CfsyLmFI4V2Oiy4mfdVVgBC3R6h0Y84VuRNikPC2-9P90u6qAFqpBXQOJo
Message-ID: <CA+7S2vLf55AxPzu47MYisFqeb-0JJtzd96VSHEfgrqaH==93-A@mail.gmail.com>
Subject: Re: [PATCH net-next 0/3] net: report multicast group user count
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	David Ahern <dsahern@kernel.org>, Donald Hunter <donald.hunter@gmail.com>, 
	Eric Dumazet <edumazet@google.com>, Ido Schimmel <idosch@nvidia.com>, 
	Jakub Kicinski <kuba@kernel.org>, Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304379-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:pabeni@redhat.com,m:davem@davemloft.net,m:andrew+netdev@lunn.ch,m:dsahern@kernel.org,m:donald.hunter@gmail.com,m:edumazet@google.com,m:idosch@nvidia.com,m:kuba@kernel.org,m:shuah@kernel.org,m:horms@kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:donaldhunter@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sigefriedhyy@gmail.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,lunn.ch,kernel.org,gmail.com,google.com,nvidia.com,vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,mail.gmail.com:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 790FD6FF423

On Fri, Jul 3, 2026 at 3:50=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On 6/30/26 1:02 PM, Yuyang Huang wrote:
> > RTM_GETMULTICAST reports IPv4 and IPv6 multicast group membership, but
> > does not include the per-group user count. Userspace therefore still ha=
s
> > to parse /proc/net/igmp and /proc/net/igmp6 to obtain the Users column.
> > In particular, this prevents iproute2 from moving "ip maddr show"
> > entirely from procfs to rtnetlink.
> >
> > Add IFA_MC_USERS to carry the user count in RTM_GETMULTICAST dumps and
> > RTM_NEWMULTICAST / RTM_DELMULTICAST notifications for both address
> > families. Update the rt-addr YNL specification and extend the rtnetlink
> > selftest to verify that two joins increase the reported count by two.
>
> Will you take care of implementing the iproute2 bits, too?

Yes, I actually have something WIP for iproute2 and realized it cannot
be done due to the missing fields. That's why I sent out this patch
series first.

