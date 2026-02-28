Return-Path: <netdev+bounces-262073-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oAEfF6hmomkV2wQAu9opvQ
	(envelope-from <netdev+bounces-262073-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:53:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B71831C037A
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 04:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3AA0C306DF17
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 03:52:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C96A345736;
	Sat, 28 Feb 2026 03:52:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wVfPnOwy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AC202EA173
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 03:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772250734; cv=pass; b=qMHyx2Qt/oKFrl1bS+/3flktCtIs6KkNHPqIG1CQQGNtHZYy9YQQjfwdaLUX84bHfk97m+EwdrQGpnyxjLmr3wJCf9KkMippLMX3W24Itln88xp+Ayiu8SYbWfM5xFZjEYHF0ppT7i3pMIibIFqXnIcfQPjiokgTHeZNlHx7utk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772250734; c=relaxed/simple;
	bh=GHSHYxs4pPRAZfr/ZQgQNSuYEV/nG+hoD3uZAKj4ELk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XZ5vHaF3QJpSnY1VNYzZx1Ee+ZqRMLlf7QazWpR726jp6aI/KR2rCoLT26A4jIjX/rSh4k+13D0aaTn6CJiegDTQRC0dUQfiB9uXlCtDJk3d9OauCci/n8dxJzA3LbSe4ztjYAvCqspZ6FyeDvNnaJ4DoGdG/JCLSq+ggFh3ncE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wVfPnOwy; arc=pass smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-899c97c5addso34574696d6.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 19:52:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772250730; cv=none;
        d=google.com; s=arc-20240605;
        b=bKaQwJG/e6tls5E75YCjzzFRNsKUAZaviEzLqGhigQ//IBVg6h+p0up7ZAZzykUCNL
         87AJIDoj+yA5EseFj1edOi1o8EO1ESQXK/udFK+nmOqU6BJCyfC38TcTAkqxcmUqM+30
         SUKFCeV86GBeTtJTGh0DlCZN+fJ5LZKv2WQYrpahTOmJyRLjWGSbblVpkE3mcm8dgss2
         IJnoh0bg4d4UI7rYp2Zd2Yk0pdmjWwpPB/CEgb1Fxrv+qCQf9cUNkYMInl9fduCouhtj
         bYW3SfDLKWxHyJ8gyle1hjZM49xtPe6hl6Bb0ddbALFIQ3WxPzcNa+6oAUkC8Ihc6vP8
         mDbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=giogpWpBA0TK8LeydwfrTkxFsQZYOMLJOU6+Trf009M=;
        fh=prAMCP6o/lDarU4G+vqoH3Q3AlH7sYPMINpPb8A14bg=;
        b=FUszjCZZHWuxFOzgZjNCn7hAcsCF1mC7+y3y6RIwLF+Uob+HRs458IQXU6RHT7NctK
         F5egubDEN3z+3aSqaCqhDrzmG2y54t/MmDUGvwMaCIvB4L3N7lSB00hwEmAi1WibzkRC
         XMxA0jnW2HqJ9KUtn6p25SQ93QB5ZaZMqzJzh/I+JZ4RpJ0Q1NW7Ky90/Bgq0ppOkFjr
         QEa74U4pftMbLS0uo+zPVSv46cArnPbrccIoGXaB9bZF/pRsTLox1MsuYIN/MWT6v2QU
         WaDA3I1MMbFedP2B6tv2oDRNbikuwtpXZgX4lnrhhn9nt7DXHg4sLfdcYjL5GfAboINc
         sNEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772250730; x=1772855530; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=giogpWpBA0TK8LeydwfrTkxFsQZYOMLJOU6+Trf009M=;
        b=wVfPnOwynyyi74GfAizj2y7UdjtB4klO3h6t2Ld/k7VsZ2T1jSvhsbh36DSvoiDEwc
         Z0iKkTqezyr0eSmbntu6HlQbsslfaDVSNSNsjxP5SAIMgn4qA4IJbcV+UVa6jRTjdsfQ
         wPl3FADMse0yLuzNjkcHxHvT4J7L7BX90ZmVRn2myEodokue6Ep9s00GfniltoPD2/3w
         m6IUlnp03m7OBcZ83uHY2T/F5aPJxGqiZYAoOR46ptzuLKdIB8L8KNR/+xFU+7vpY6Mg
         vYoK8UTGPey55J93CMrKmNEOlLvAaNgfaiYG0XkNC67Q9bISsHW+K+y9xT7zVcnNnfhT
         +eiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772250730; x=1772855530;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=giogpWpBA0TK8LeydwfrTkxFsQZYOMLJOU6+Trf009M=;
        b=A1/pTmHZN4e/xITqMkan+jWEwTXKMM8wKgRDM7mx2AiFOFqWlQ2GBIrHC4whiFOWWm
         ZKX0F3oxYuqWInA5yud2/PSqXmYU+3rdKCwYM7S+zxLDuL523yAJBcgKcvMGxIkYY7uB
         XqXG3tgO1oSIfvsuGh/OcRJ2FRYECqo2jVHhM9xPJGLjm+BBkeLQqrvce/bUJsOd3Fvk
         uMavA+hK3yItPlOScArLV7GwxrTSpVMbak3KKAZ1lpTaQtmAo9jLgPqU9/nwO1FPXVM2
         8SLdaALI/9XbLbI+ZHfBOjHAnhivkc/hOi9qBAiOzxzqpexLMPRffUptM+Zb2qCosU2p
         ghOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGqzmkfYUAj5BOQSueSFGR7pNP1vWoT5pqFFkZ7GiNQlVzKT7MoiIjW+q6F7NO1a3cF0+1tl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJhYVO+bBj7AwJ8KEu/5REcGbaioFQ72ADSE6sJsAP38nCexnD
	i2FBg/lzG3qo4cEpKp0JYQhaa6vEr/CBr+jJpJfCaHu85z7wGuz4sNExEY+BmINPCXSU3NJWyfL
	+a/y49G6Eq9bghC937qs9pX7pAm6SVIUg8Jd8Rt0I
X-Gm-Gg: ATEYQzxaUQmfdd8WRPigUNJ0uL7ElqfxcgzWAGNtqA/R1PlsmoF8jpD+C82rZeUWOvI
	PrGbZlGflfjQYLWhzupoxFPe0zelf7LMpVCY9pc9XgE3pDEt4smOr4zz47pMn40wJppXjGLJGm9
	BW0boP8vcuH6iPAWgvM9p1TCOQZTflmUWHpagCsaqkiafOyoJDc/jFzLH1lXB5xpH0FJ56XfsAY
	LW4OTDb1rtv9qgvj3J9hc/0JkFZQvzpEWlNNGKtJdYq0a3q2B5OhQ7vB4679tgdT0qtlRxPwdq8
	jbXqnSk=
X-Received: by 2002:ac8:5a96:0:b0:506:a617:175a with SMTP id
 d75a77b69052e-50752763273mr65221941cf.22.1772250729595; Fri, 27 Feb 2026
 19:52:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260227003359.2391017-1-kuba@kernel.org> <CAAVpQUBu+tsn+aWnOp-tkCvKvjf+fjtVP8CtvN9zFfJJNC0HJg@mail.gmail.com>
In-Reply-To: <CAAVpQUBu+tsn+aWnOp-tkCvKvjf+fjtVP8CtvN9zFfJJNC0HJg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Sat, 28 Feb 2026 04:51:58 +0100
X-Gm-Features: AaiRm539kjz9A3edC2PTkfEsHqS7slNnZjMhE0dsmqmSbkv5PmMXRSL1Ag3Drfk
Message-ID: <CANn89iKCOkmjTYZ0Mw-qrgmDe+Ts-7wL=yc++pSffz-ZnZ7oNg@mail.gmail.com>
Subject: Re: [PATCH net] tcp: give up on stronger sk_rcvbuf checks (for now)
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net, netdev@vger.kernel.org, 
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, 
	ncardwell@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-262073-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: B71831C037A
X-Rspamd-Action: no action

On Sat, Feb 28, 2026 at 4:48=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Thu, Feb 26, 2026 at 4:34=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> =
wrote:
> >
> > We hit another corner case which leads to TcpExtTCPRcvQDrop
> >
> > Connections which send RPCs in the 20-80kB range over loopback
> > experience spurious drops. The exact conditions for most of
> > the drops I investigated are that:
> >  - socket exchanged >1MB of data so its not completely fresh
> >  - rcvbuf is around 128kB (default, hasn't grown)
> >  - there is ~60kB of data in rcvq
> >  - skb > 64kB arrives
> >
> > The sum of skb->len (!) of both of the skbs (the one already
> > in rcvq and the arriving one) is larger than rwnd.
> > My suspicion is that this happens because __tcp_select_window()
> > rounds the rwnd up to (1 << wscale) if less than half of
> > the rwnd has been consumed.
> >
> > Eric suggests that given the number of Fixes we already have
> > pointing to 1d2fbaad7cd8 it's probably time to give up on it,
> > until a bigger revamp of rmem management.
> >
> > Also while we could risk tweaking the rwnd math, there are other
> > drops on workloads I investigated, after the commit in question,
> > not explained by this phenomenon.
> >
> > Suggested-by: Eric Dumazet <edumazet@google.com>
> > Link: https://lore.kernel.org/20260225122355.585fd57b@kernel.org
> > Fixes: 1d2fbaad7cd8 ("tcp: stronger sk_rcvbuf checks")
> > Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks !

