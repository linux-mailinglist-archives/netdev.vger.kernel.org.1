Return-Path: <netdev+bounces-263897-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDtZHOBcqGmZtgAAu9opvQ
	(envelope-from <netdev+bounces-263897-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:25:04 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D99352042D4
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 17:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 09E6031D1765
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 16:00:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF04E199FBA;
	Wed,  4 Mar 2026 16:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VaD8vMyF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75C9230FC26
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 16:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772640015; cv=pass; b=VwjgLv5gQzDQgLb7tQG5gQaPvS0y81KLndAj6nHDXEqQuOUyh0Zo4MmS6X/NOarHg0DuqmWSZQ+84AEHiJw/jB+PkWEEhxvARCE+BHJOPPiFVF14ihOlrSS40l0RalOMlhMGV15Balp0c6QFAwabRqTL1ciR1h6LcytIc1BUir8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772640015; c=relaxed/simple;
	bh=rI1GyFyPrXzA+/a7clGqi3FniatUTe9TjanGamzeT1c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+JUB8XPGTjZoCXqGwhHWqIh1GeUTNwCDgGeu3hXY7aNZ85XPTW9RtDBBm6LSQowW1i7AQjHMNZMy5tD5wUZB3+rMXA/URyrwCQl46hw7H73xUQmkKzPztTdRWiuzSnrI+oEVVF7clRbL5ll2juQo+U2K/ja6piQAK4de1csqp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VaD8vMyF; arc=pass smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-8cb3825b0fbso677793085a.0
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 08:00:14 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772640013; cv=none;
        d=google.com; s=arc-20240605;
        b=X9BcHdeAh1Xy5Z0DpgqAcx+ANGX2znoQbla2WM7BgJeY/f9NuOZbxo211qmZqVWpfo
         uuMP5dAqicjakdUSXECJh7167JDQZyHusxrNxuMu2eTzpvzd5n+E2j6ac4uSQPpbUBZ+
         thDyRD2ZXRfRlmtBHUoDGmrVclEyW5/szcUrlz5+K5nuyWtZVRwfVbIGi9Cml7DhChzL
         Rf6stzh7iWJJLVBICpcpEvG4X3vYUpa/1xtM9DVLIFhLy2RzHmRmMJcexxi2cXCAKb3y
         5by3xliWHsLqxZFaYPsQBlPAsF4uMcqbFn8bq7y1YYOSMVN6OHZIhmGnGF3FYMAeNDQ4
         rjyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uG4YJPkl73/42Js8FL99JMSYDUN35hlIqmqUUwK5i+o=;
        fh=GDCqGVd+gGKqSibXF3Hjf6G6XtLT97S7PZsiYhvbiM8=;
        b=ejeZ0ggQRJcquonkGhgyYzBJPocOSkWIlljf/uOhkux+efEMm2Txk7UfpBy7bys7BJ
         BrHhvsdnw3a+m3QljNMc/dXxni2rUXXo5h7lbCahQ921Ut7L/043vlJYEVT3Q9Mqrq56
         BJKDLXBwZBoglkUCb+1WNxjB8abW3rFMOsokzFKl9FvzVPKoqGNffUtRWujCdjzSRQBY
         lgCC3Sd/OQqtLyHa1sMgTPQYKLgNWpTVM8QYsDr81qMtXya8sB92PCweKLLnJbXiClw8
         DXDvH0qfnATfyNi5hw2MpDEQHhry+lJfUts8cTXGtHYc20whfMG7eoIH73GfrR5RH56Z
         OVtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772640013; x=1773244813; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uG4YJPkl73/42Js8FL99JMSYDUN35hlIqmqUUwK5i+o=;
        b=VaD8vMyFfWiS2jJefwjzWOs62wvDFgQISEIzqVg98BoRYTfxyfS1mrqa7IUc5G6LEJ
         GugpYDaqKG06z3uo49+HEqRvOmLWXf7mhLYAaeLKi6HSSoRH9X7I6tLBJ9dGeZozdao8
         wfYiREDMMZ8SvQ9d3TIiy8fcWculAIc1U8YKw9kUB63OmGZU/lIIEWnV1/7q9fQWQnou
         Ydr9n5c0i+mLpjXG1kbdVJIg8boY4dNy7Wy2PqBZTaHAakcUDruEOzy40LQlr7rlvqmk
         gb0KSWPh9OMBihXgGPhkBSCUHw10oaebg91nUAeP9DhEPd1Cm9GwlR+WyD9uW76EYa+h
         0Qww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772640013; x=1773244813;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uG4YJPkl73/42Js8FL99JMSYDUN35hlIqmqUUwK5i+o=;
        b=Co8bpg9J7KlwesUo721lf2ysAexwXRpIVQ6aoY1XVZJn7EoF3khS53NJ/TqcUzYgLp
         3Ku7tSByxsiMK4y6tvYgCBAgyxGqA3ImOZA8erSo/zOeKwhw2aKgJPL6j++uYDMwFKAj
         q+XjPffvOrVz6ruqUJbFwjtEsfHnR5ydZqPwlqjiHojAY5ecgeTGZ5PNgWGMyz9/nx1K
         zLY68v1b3hJkh4yYQz5V8NgIR2I4S6Fu9XETV8wHB02sK81OJdaavAilFD2X/nHX2VKd
         rfByeSM84VXM1frKaDDgjydEpeX+arSFyGOXxJsXyrHl/U7assvxAK91oQmT7u0vZrmX
         ymhg==
X-Forwarded-Encrypted: i=1; AJvYcCWTzejQXt5InRdqyQLXPxbGo3s8/0pqKMhv2SmvgQDdQy6CUd+0xU2K8UQIbSpBXhm8/FmYaz4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywz08egoL8LuTm+Y9n58alpT1XU7H9PAN4MJB+VQO0DQjcl0kpi
	oGBvr2CpsDzDJTVgbGHILhPOyANS/Czl/T2i+q0zbfMLkwGI+i8M+AhRSNywO9gRC9xssMjtnFG
	3Q2Y1Aj2BVZP9gEYdkifWxPAv6bsfHh2/v97aLdg7
X-Gm-Gg: ATEYQzwIMfYDBpVYSKavdWMBhhDfAW+7TUAB7NQzTf1/Grj+jz66QQBajhGP5vQ+2BH
	iHmqii9iNWI41Abm535NyYJfxLw6832/sQg2nFXOmUKxZt4+mFv+rRjrfdmrQnX9nLQJH6l5fIx
	oOMzXC/lC8s0lzvMdEnjhofb69otcC+ssl09tY1js4STbro2EipVbDpFR5IkuoDRrjHm9U0eAG2
	D/qCq09XsRM7DeClPA5vPsKeAI+/F5QOD29JJma8w8OSiDupxKHKLeW77PJloXckKdwkVTuQrjV
	p+AGHbZL
X-Received: by 2002:a05:622a:1998:b0:501:4730:fbe1 with SMTP id
 d75a77b69052e-508db2a7ab9mr33833311cf.22.1772640011899; Wed, 04 Mar 2026
 08:00:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260304094318.1769536-1-edumazet@google.com> <93b5fb6d-7aa0-481f-823f-995ed8ab0e52@kernel.org>
In-Reply-To: <93b5fb6d-7aa0-481f-823f-995ed8ab0e52@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 4 Mar 2026 17:00:00 +0100
X-Gm-Features: AaiRm50I60QlYPJhewzIEKmMOkyfI19MLdtQwUrLgqb-LpW56f69_ysZ6MKpDwo
Message-ID: <CANn89i+SQd4H7q=ELJp7-aaN5PyZ-Oakoy9MHZpbuX1iGKV1ag@mail.gmail.com>
Subject: Re: [PATCH net-next] inet_diag: report delayed ack timer information
To: David Ahern <dsahern@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D99352042D4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,redhat.com,google.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-263897-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, Mar 4, 2026 at 4:48=E2=80=AFPM David Ahern <dsahern@kernel.org> wro=
te:
>
> On 3/4/26 2:43 AM, Eric Dumazet wrote:
> > inet_sk_diag_fill() populates r->idiag_timer with the following
> > precedence order:
> >
> > 1 - Retransmit timer.
> > 4 - Probe0 timer.
> > 2 - Keepalive timer.
> >
> > This patch adds a new value, last in the list, if other timers
> > are not active.
> >
> > 5 - Delayed ACK timer.
> >
> > A corresponding iproute2 patch is needed to replace "unknown"
> > with "delack":
>
> ...
>
> > diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
> > index 9d215485b5c7e7ba29dd53c924f0245439d74af5..e4cb18061aefcc22df04644=
c00bf5c7db4e150d2 100644
> > --- a/net/ipv4/inet_diag.c
> > +++ b/net/ipv4/inet_diag.c
> > @@ -298,6 +298,10 @@ int inet_sk_diag_fill(struct sock *sk, struct inet=
_connection_sock *icsk,
> >               r->idiag_retrans =3D READ_ONCE(icsk->icsk_probes_out);
> >               r->idiag_expires =3D
> >                       jiffies_delta_to_msecs(icsk->icsk_keepalive_timer=
.expires - jiffies);
> > +     } else if (timer_pending(&icsk->icsk_delack_timer)) {
> > +             r->idiag_timer =3D 5;
>
> How come the idiag_timer values an enum in
> include/uapi/linux/inet_diag.h since this is a uapi?

Yes, this can be done, although we survived all these years without it.

Do you want to send a patch or should I implement this idea ?

