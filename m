Return-Path: <netdev+bounces-282597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id zmnkLOm58mkYtwEAu9opvQ
	(envelope-from <netdev+bounces-282597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:09:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EE09649C371
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 04:09:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 161E43013AAC
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 02:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73722220F2D;
	Thu, 30 Apr 2026 02:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bWPkW7w8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F7913777E
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 02:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777514982; cv=pass; b=uBMuGCSP6l2hJw+1tadJ9IkCoKTLtBsYHp0Ebakyp+HTe6bKtLVsv7ePH9pVlG31Yp9vW6KtySessO1427dzEFnM2N0Gq+QG/mMPwozr9nqA2m0XSSUFbC3VS+TJp9Ebsy+yUSf0tDd23BiS13OOVPPbPXU8FYcORkfpHZhP9+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777514982; c=relaxed/simple;
	bh=z/L5FEasjEfUVBGnzkABUuoAiflIqv6vkBJWNwdvMjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MsZWjPugpRSGrnpP8OgSTr4QcW7mtmthTW8o7jptKk9dKbEb0238FxWefuuYx208AJz9IVXb3uQ07HqXqGEgfmBiHhO7NP7hblsflszCyuvkFI0kUABsKqa/PHqIKDoseu/ydUT2atdP2qr8lHcoXwEr2mABwrr7JqxflIVBx/g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bWPkW7w8; arc=pass smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-506a747448dso2477891cf.0
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 19:09:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777514980; cv=none;
        d=google.com; s=arc-20240605;
        b=fbiB9v0vm5UiklniE7ZIER/0JTZTmqKvMLTn7hJqImbPImL8HP0CWLToM8It5pF9VP
         wf8349zfi2dpBETT0NAoSSJbbEQKjy8T6/bLbFYdT3XtCHagfH9dpDR5Nd7UTGyeMVUY
         qXopPdSdJMomQWU2NveoPp8+I62WtZeXPJhqQT+yopLiNm8u2VGfKe6RjrWiGHMiIGve
         6Z0ZELCMc0u/pYrh/cMpzyL6w62c4xy+MwvBogDJt8KCPK2jomeMBcv6Td+OnwqQZEm+
         2BnDQjV2hTm1oMVK6CNHNhz1gB3WkgR93y/8Qgol3Q7LbbuE3Tpoj5tWJ207rmg7dZep
         L+Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SvE0I/JhiLpuwT8tMag71J64hdVM5U416QBSdoJER2s=;
        fh=8EyDL+osoDMWVJE7JQm53vzWK3EATTXPRFA/qRcJHf0=;
        b=Lvnjee1pI0U21BYP4KA3JP4TRiyRwMQYrfRxC7//Hbf8g2s48urSgnWODzazPod9jP
         46EMLcdIp9SQeBkaPYa3sS3chbXDoqZNz0426ZALUiNx48lnEsqZik4Du8/8vrg9VEqu
         W5HuONiTgxWZ6TcsXPZ3d7Pt7ngc32+gTLFTHsQ6wgZPO5VVdQ2XTwwTWM8zvO4FtjOH
         zY5n4k+gcB02LYd7Q7oFOrm1eaYKkQm31iqMTsXd78RaxFv24DX2GLYsug0TRvO1yKOQ
         sPN9UylygxJ97NPlGQ2xBBQ1db40Tcl9ledVVX8uB0Kb6SQYwdrjmIrBUtBwyBYyxAGM
         Kb1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777514980; x=1778119780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SvE0I/JhiLpuwT8tMag71J64hdVM5U416QBSdoJER2s=;
        b=bWPkW7w8gj1OPGy5c4biovbjLgGE5A4zm80AKOsoFBrc0SgbnCvKdykz6sDfKEZdm9
         cgUXJeMwM3b6/gtcbAB3oZEZr+kLmQQh1ZFz7V0sl5799FPMIJq4TQOfdcVjBYfjzGK6
         8kRiqZm115H4FMM4eaqulAunicXW2ctBdFbhm+4+oRdmRST/Mm4nOQXMtM//O9dp/quV
         M8qJ5s9h3Dwk0fzJ9reWVH8eHCFf3IvGqSOFJ7aiiPUch8tsKrMUvLkZ9puHJ6VIZYSC
         jiD6Dsz8Bz9UFnkzNMBrk3241qzJ2KVQGoQFMaYRM8db+akSfTUdPCZE8jOgfkZGUS1X
         C9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777514980; x=1778119780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SvE0I/JhiLpuwT8tMag71J64hdVM5U416QBSdoJER2s=;
        b=B+ac69TSY9ipMUq4vgIT7TODEi+4QSp8La0il49EhXEsdFELuiXcNH6FLjec0r4fyr
         YfAo1QxpzhfJdm7auNZohfWEvbsuEM/NWA9ncfrW30VipDhvHnDYO0PBd8uvOLArsJvA
         qs2pcsMK28QvZhMQbrjbsw0qOTXaD+1umnBPBcDWKrxi/cwqmmdHdgMaRiKRAwlLwXP1
         y/6rly61MHHRtvxBiBdYeax7PY7K8a5TaQF8fk1TqWntIfEN16zP+5OFNKgY8wlTySrF
         jHiI8r6t3rze08sWVWQkRet2TxGaem6S33XhsuC3O8nIYU8ZOduq3Zr85TzffnJdkkYL
         Bv7g==
X-Forwarded-Encrypted: i=1; AFNElJ+R3tJYqzKXCQbQ3OtEMlFFvfW/PTK+oo3e7KS5cZ10WKwYRNcmuddqVlgIGBLY5WtCgUrCG9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtclcvueuGoZvvOGlcAGHM+j8Ys2KYkjlCQRqEforwaXEXKWrr
	ZaCw8UOC/5gLs6pEFynlULA81GUcSj8HkqAhhP1QZsBRDmtSVAOzK5bU/3glGy7yxUtc+e53MnS
	3dd02AX2QyIW3o5Qx/O8p9HgIu1XgJFy75iLNm1Ey
X-Gm-Gg: AeBDieuZ2++MjDf76lZjqwJjw9ExxqSZ9ZEwrTAndMkWxOBo5X1TZxESFpOItL+Pr4l
	3kmWmLOBJVDedsdHHUU5UpvUkvC7mA1kJM4i1AFnYjX7C8CvlJ0fmmQdGyJZFYN84bLlsyvDziZ
	q7mv3oF0IkGya1ESUTBifHTf0JUmxYQTca1De0aFBnBwNZvbtpNbKsDt5VXcKERbWIgzFRgKtxt
	Llwckc+ymr0i1bdEZsQyhbF9cgUOToZUMu45EX9Jwn21OGnwAeHVfScfLjZNVhFxNCMWYJQyyv0
	mvx77qIAaYgFnFNgrQKfrE46h954RQ0pmbMB08AHsPbBW1cltoszqBkuSKmbwr9Cxsgr0wrgQDh
	Jv/g2IPrCCfJYomtkDg==
X-Received: by 2002:a05:622a:5805:b0:50d:8e6b:96ac with SMTP id
 d75a77b69052e-5102afa5dc0mr14709791cf.58.1777514979481; Wed, 29 Apr 2026
 19:09:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260429080036.1528533-1-edumazet@google.com> <20260429094805.1aa6bf3c@kernel.org>
 <CANn89i+KuSf8PhAsf7a=h+tR1c8aLNdiM6NzaBU8tjpoLAfcQA@mail.gmail.com>
 <CANn89iJrvSvw2XKvB7LfXc2egeaqC+seiCiKN2USMw9gicqM1w@mail.gmail.com>
 <CADVnQyn-U-QgyT-HqeqZVX3FJi-UCgwfGJk2VaBBhjajKoih6g@mail.gmail.com> <20260429163338.423c75ee@kernel.org>
In-Reply-To: <20260429163338.423c75ee@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 29 Apr 2026 19:09:27 -0700
X-Gm-Features: AVHnY4IRKhJMPUlXE0pCq9f6lXQs2ElNzDA8giRancGW1vzSw-POqxhj8HQhraM
Message-ID: <CANn89iJcxnh8nH9-Md-R6ZCNkVTSuc76NozkFf_dKBp1bBBesA@mail.gmail.com>
Subject: Re: [PATCH net-next] selftests/net: packetdrill: add tcp_syncookies_ip6_9k
To: Jakub Kicinski <kuba@kernel.org>
Cc: Neal Cardwell <ncardwell@google.com>, "David S . Miller" <davem@davemloft.net>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: EE09649C371
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[google.com,davemloft.net,redhat.com,kernel.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-282597-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Wed, Apr 29, 2026 at 4:33=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Wed, 29 Apr 2026 16:47:14 -0400 Neal Cardwell wrote:
> > > diff --git a/gtests/net/packetdrill/code.c b/gtests/net/packetdrill/c=
ode.c
> > > index d90bffabcfe6..6d8d20e64d8c 100644
> > > --- a/gtests/net/packetdrill/code.c
> > > +++ b/gtests/net/packetdrill/code.c
> > > @@ -129,6 +129,7 @@ static void write_symbols(struct code_state *code=
)
> > >         emit_var(code, "TCPI_OPT_WSCALE",       TCPI_OPT_WSCALE);
> > >         emit_var(code, "TCPI_OPT_ECN",          TCPI_OPT_ECN);
> > >         emit_var(code, "TCPI_OPT_SYN_DATA",     TCPI_OPT_SYN_DATA);
> > > +       emit_var(code, "TCPI_OPT_SACK", TCPI_OPT_SACK);
> > >  #endif  /* linux */
> > >  }
> >
> > Sure! Done. I added all the missing bit values in the following commit:
> >
> > https://github.com/google/packetdrill/commit/faa0dfb54065118625e169d311=
1ce09c65b20229
> >
> > This can be picked up with the following, or similar:
> >
> >   git clone https://github.com/google/packetdrill.git
>
> Updated in netdev CI.

Excellent, thanks Neal and Jakub.

I am sending a V2 right now, because I am OOO for the rest of the week.

