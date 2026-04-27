Return-Path: <netdev+bounces-281409-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kM5OOSeT72ktDAEAu9opvQ
	(envelope-from <netdev+bounces-281409-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:47:35 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D201476A4D
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 18:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEF3830143C1
	for <lists+netdev@lfdr.de>; Mon, 27 Apr 2026 16:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9124E2EAD15;
	Mon, 27 Apr 2026 16:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ql17bBgg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5C43D170C
	for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 16:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777308452; cv=pass; b=p9dlJcslhIcOTdtqSLpbh+ggcMYeH/mTjozeVdQqcaWDceAWZj111phRA/zEHEwG6hKzFvLXlzDT9Q0lauNFSa3ryoPzUE5MgJ4Z7jQzo+U4stzATCgWhdq93kDz/jTY9G6I/0qJtok1fwajR6RA/CqapYQeZJ65GJMa1YMZIQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777308452; c=relaxed/simple;
	bh=8kqAua5vtksnJjG9OoErG3PiZftQxEhfqJGo+6ba5nU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eTaBawesK4VHk1Jz/BaWg/b9k1mfULrwOaOtfdFl7jsymyw6pLsblkxjLOA/ufyXnVpWVfPTyCFjIHyh7rE53F8NC9pot9SDyIaD8DH2JDG2kXLtUi31TxD+rY5evQbwmciQCoc5gPRzuC/Fco4sDdAqsB1FnMZoH2JLvnCNkcU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ql17bBgg; arc=pass smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-50e5eb0fabaso87798591cf.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 09:47:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777308450; cv=none;
        d=google.com; s=arc-20240605;
        b=dsHOv+wUDoE49rbozTn6p+c4/2JoADqa3BSH/Y30cf85vrxv8RT7FdCFnnGp7Uy98m
         SInODkeS+5Tf9hI+qymQn5hsMoFt89xSQQG//y0ZArjkVHDs2IgVn18BS0uj710Sapy2
         +wdXxF4CZzudY+P7xL8VkglHc5Q3z6iZ/ssVPHEYO/2siVXHvOYVqzzXCpeco6PdCLX1
         R4nJ6xjT/u1opIKAoKn1W9+SsMw4VsmEQsokT+1GMmHA6EXo0mIlL0n56df2KzPclWy2
         LvBOA/3SSohWBdGuH2faklCy4UgoSn2UFGjtefhTJ1r9TN0ttc63/BXeBi7waRUR5kf6
         qlVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8kqAua5vtksnJjG9OoErG3PiZftQxEhfqJGo+6ba5nU=;
        fh=YwREElhvrIwF5vtvIWRd7UforkDG7t4raHork0oJYuA=;
        b=MqUhD6MxbwMjBgA83+4T6Ig0sX1MiqTIyZMkaEDt6ak3W7JSOD3uAJ/nOCUnt7W2ev
         RqRkq9ke31fLjlU543624dCJOK2fJAqwUAfUd8b0HKoH993t1YDRgBN+XWv93dWbl+8G
         /HqONBcRfl2NZ+TMVtckSu+2wEjj80WhBFJjwvUhVcPq4K12pqqs3adVBISYXadgGdlf
         vE9ksd9++VJkPlff1XJvDuw4wvbZ5Tjs7yCeOkh/b1R0Pt5McsdhMlvNr7eFw+2A7z4u
         DYiVDHNMM94QB7XZzix2CnbeNlNH8A4q3hf1DI0Yyl0yhZKcpF6W7ULYvUcobdLfMpsM
         4ykA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777308450; x=1777913250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8kqAua5vtksnJjG9OoErG3PiZftQxEhfqJGo+6ba5nU=;
        b=Ql17bBggwytAggR9KQRiSaq3AVsllFYUhlyVUjhFipYCIMSEgzs9dOzW2Egm4qJ7XQ
         cfmHnUEWXvEWRMpyt0N9ZrpBeMwwh241iefAHvl+brrF1OKfz8kA1hk4L8dWuTY8Qpse
         Z+MUaXv3Lt5a8tLQnr2Z9Ce2GlGUagFxR8COqQEgJ6EC2TGIVufjwhPze80wLK1A/vil
         D0rbywU66wMHvp75tvvTsenz9+ofRT+9xo5dSBdOFYIamd5PD5WEe8g5LtO72s4QyErt
         3W8mOTT3zxj9JawbnacMDbrSAXV8CdRlzyYSUIe5i+PKdtvyd8mRpQbOBmNuKDGxQ+eH
         ZiUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777308450; x=1777913250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8kqAua5vtksnJjG9OoErG3PiZftQxEhfqJGo+6ba5nU=;
        b=NONfmLnVfdEBcXv0kAZCcwjXEC5HRogfzIdpRJogEgAHwFTCyAfO9GQfiH9N6i6Uud
         cOby8xEhrbzsrXGWXxK0xaM5RjHIi0gBkgQ0DclJd/g2PFta8eJU5X/a+3lwEYCFRtzv
         fWYpdBmcATGI1wjbcQCgKQ4JWF/8oVs1ClJTTf6JguQvQ+nAqwwvmxfiY9uwJpgzfC4q
         BA3KENFbb6hToV7e7RZ615zWEQGckuLMJldwGBLplKXB4v+NJZ3dSwi+xnHAFPBhY9Bx
         E7gzElDR1IBrQpHbsymnmqnz/SIVIM7tiPTUx2Sdp9lRf5ngn/Zup/jk3mX8i05zRIGH
         nMpA==
X-Forwarded-Encrypted: i=1; AFNElJ9NoRfh5A1FG2Wog6llQo//wgmJzhVA0J8m/AO53rDi2M2+cHHp3lzC1fJaaW3I1uSpA+eLI7M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKoNqXfeWARrOsvqyVNGeHEEpkGznGK+wy3Mm6XLuEl61+7vCB
	/fPyvAHzviy55iakCtuVBRuHu+pgnef9FhJflttG8yM8Sd9cDTAAm1pmq5kNPF1E+sN+sEmZz8g
	qZEqz7j8k4fiHUo0x6jdznfQvKOs9zkYgOwjDFHuG
X-Gm-Gg: AeBDiesLngH/FNw4MZseoB+EruXub4eelSovd9d+coLGgu6dGoySaUcy8TdC5VdLzkJ
	h0x3fjIyqmzbk+bB65/WXiSai0YcesGOV+vGAtYd0MmFGfrY+jaL1PX4jjIO5ZBz+k6OqIaUM50
	IlRqug8rtihKbmdtISu8tuLuRiuIZe0Q/4O1i7aTMiUXGs51CaHQ2H+0531jupym0I7Zf86JQIN
	jHDAUYNx9N6WG9khTh5WXbtltOMapIDcvfiGe1YGfR7zOIqizMZVDF3HKHXmM/MAx1wbgiZkFsj
	86vpZgU3k+EUhCJgGGsEB8Q5Rw9BVqiFMF6k6/M8WmtrYW6xN7+Gmb3KFHokyJ93Dgcw7avt5Y1
	mV+cEjIq2
X-Received: by 2002:a05:622a:610e:b0:50d:9cf7:18fc with SMTP id
 d75a77b69052e-5100c8301d2mr977561cf.11.1777308449676; Mon, 27 Apr 2026
 09:47:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260427081953.364819-1-edumazet@google.com> <20260427093149.2cb7a215@phoenix.local>
In-Reply-To: <20260427093149.2cb7a215@phoenix.local>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 27 Apr 2026 09:47:17 -0700
X-Gm-Features: AVHnY4JOCgV4gBUVkSdVlXH9kN7alxJFoH3qput4v_guq3yUGFi7oJHv97jPTRw
Message-ID: <CANn89iJUxfpofspfsp4Q3OK71QmSVen2C7vmm+LCMH_rn0dN2w@mail.gmail.com>
Subject: Re: [PATCH v2 iproute2-next] utils: add fflush_monitor() helper
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 5D201476A4D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-281409-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,networkplumber.org:email]

On Mon, Apr 27, 2026 at 9:31=E2=80=AFAM Stephen Hemminger
<stephen@networkplumber.org> wrote:
>
> On Mon, 27 Apr 2026 08:19:53 +0000
> Eric Dumazet <edumazet@google.com> wrote:
>
> > Some fflush() calls only make sense for monitor programs.
> >
> > For other cases, forcing a flush is expensive.
> >
> > After this patch, ip, tc and ss are correctly buffering most of their
> > output when redirected to a file.
> >
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>
> What about pulling all the fflush from the leaf calls, and move the fflus=
h
> to one common place. There are some of these that need to come back
> like the addr flush loop, this is just a semi-automated first pass.

SGTM, thanks.

