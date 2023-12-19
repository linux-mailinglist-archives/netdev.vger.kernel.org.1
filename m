Return-Path: <netdev+bounces-58807-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F20381843B
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 10:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0FECEB2264F
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 09:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9125D12B98;
	Tue, 19 Dec 2023 09:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ws8WpIMK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E0F12B87
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 09:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so11189a12.0
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 01:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702977313; x=1703582113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H3C2LHQgXwxgzamhTVeMi0dLfT0KzRA6aJGGwgr9iL8=;
        b=ws8WpIMK0giiFEtmZ9mcw3D6azun6qvlw0nZpxRd4xktGPwCyOtmp5dMrVKZmHh+l9
         /KwCmUpLKsK3wLwyrFQpjLnx7mQnd4/3yk79BD/nTUVnSIkrR3Zi220hTol/Yl5R8OjV
         rgzxhVuDXp/9yhM7lJzZv9+2ZDbpL5UFHPauHTqroW23/brpN5xKWP9SGt9kqfv35MiU
         Z6I91h/2fvrYYRunYQ6WXMJo5twm2UgrcGronNTwp4kJg66QFqXbVpAyHtdZkVX8emAw
         i7M8qkmnDOcXXaDIy+JrqI1v0el1ZBHHIc+Im+eBUzPi7jX0QxO2u/m7YL+SayRzV2gn
         Qvqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702977313; x=1703582113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H3C2LHQgXwxgzamhTVeMi0dLfT0KzRA6aJGGwgr9iL8=;
        b=nOg4vzp7dge2AjLvcmqqIvAaPQySgWS+3H/2L3RWo8o5NLLUCaGU6gSY6eJh3aSVOd
         0TevgNuWOQpCI1sW7aMT6Al8krp0w+39IavCG/GLIejhIwP1GO4r7ln0lZBQc9LQv1qx
         5RMu3csQrJw+tmdejOaHLHzZoEOvq9zrWqDV9lGoA9QtFUE1JxaYdjl6w8XzYAov9inD
         JXwOKpteIs+p8FU6/rfXg0Th6RZ90P3RIRNnoL5lXa9emRl6Vt/psXcN9koYnWGuYfKr
         FI4zCHz+t0NtFIb9p7hkpx09nKLWxLxvMk1XOPcGQfYyMSg/8jKEUwmLGjwoAilXrwYO
         pHCA==
X-Gm-Message-State: AOJu0Yy2SwtYIS47THcda2ape7ZupmU5siNUg7yrtLfbNeTC8z20fGci
	ceBMNXW1hfo3U9lgsJysKXkflHMIYB4fb840r1gN3VeRbPQ8DOFhIUluC7tjw/gh
X-Google-Smtp-Source: AGHT+IFGHVZeMhHhmfSSuughOLMneN2eb8mWXPZbrYqWuiGZoDb5n+2EVunL+QgbUNoZHfl8Um3ih9f+8Ht7iP+8kU4=
X-Received: by 2002:a05:6402:268b:b0:553:9d94:9f6a with SMTP id
 w11-20020a056402268b00b005539d949f6amr46782edd.7.1702977313062; Tue, 19 Dec
 2023 01:15:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231216-new-gemini-ethernet-regression-v2-0-64c269413dfa@linaro.org>
 <20231216-new-gemini-ethernet-regression-v2-2-64c269413dfa@linaro.org>
 <CANn89iLu_vE_S++5Q6Re4c6DZOD7GD-pLFC61VjYGcjFnKDWCw@mail.gmail.com> <CACRpkdbq=X485QuFvdd8Q=pPE0Hy4CduBbRZH7mdqag=mQw0ag@mail.gmail.com>
In-Reply-To: <CACRpkdbq=X485QuFvdd8Q=pPE0Hy4CduBbRZH7mdqag=mQw0ag@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 19 Dec 2023 10:14:59 +0100
Message-ID: <CANn89iKfqZaqL02GigqwypwD7xKxKbiJMWvJsiPigzNBMPYtDA@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: ethernet: cortina: Bypass checksumming
 engine of alien ethertypes
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Hans Ulli Kroll <ulli.kroll@googlemail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2023 at 12:42=E2=80=AFAM Linus Walleij <linus.walleij@linar=
o.org> wrote:
>
> On Mon, Dec 18, 2023 at 3:50=E2=80=AFPM Eric Dumazet <edumazet@google.com=
> wrote:
> > On Sat, Dec 16, 2023 at 8:36=E2=80=AFPM Linus Walleij <linus.walleij@li=
naro.org> wrote:
>
> > > +       /* Dig out the the ethertype actually in the buffer and not w=
hat the
> > > +        * protocol claims to be. This is the raw data that the check=
summing
> > > +        * offload engine will have to deal with.
> > > +        */
> > > +       p =3D (__be16 *)(skb->data + 2 * ETH_ALEN);
> > > +       ethertype =3D ntohs(*p);
> > > +       if (ethertype =3D=3D ETH_P_8021Q) {
> > > +               p +=3D 2; /* +2 sizeof(__be16) */
> > > +               ethertype =3D ntohs(*p);
> > > +       }
> >
> > Presumably all you need is to call vlan_get_protocol() ?
>
> Sadly no. As the comment says: we want the ethertype that is actually in =
the
> skb, not what is in skb->protocol, and the code in vlan_get_protocol() ju=
st
> trusts skb->protocol to be the ethertype in the frame, especially if vlan
> is not used.
>
> This is often what we want: DSA switches will "wash" custom ethertypes
> before they go out, but in this case the custom ethertype upsets the
> ethernet checksum engine used as conduit interface toward the DSA
> switch.

 Problem is that your code misses skb_header_pointer() or
pskb_may_pull() call...
Second "ethertype =3D ntohs(*p);" might access uninitialized data.

If this is a common operation, perhaps use a common helper from all drivers=
,
this would help code review a bit...

