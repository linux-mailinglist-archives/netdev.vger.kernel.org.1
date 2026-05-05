Return-Path: <netdev+bounces-284597-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UExqAzR3+mkQPQMAu9opvQ
	(envelope-from <netdev+bounces-284597-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:03:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 164E14D487C
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 01:03:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EB393004626
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 23:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 326C22D061D;
	Tue,  5 May 2026 23:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dcIPypoY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A3B31B830
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 23:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778022191; cv=pass; b=O+IDLjQMX0i58k/6x2/hI/ShUgaQYxtdtP6enROlEJyXVxtlY9/N6YM0hdb9v81nGVitMZZGqxDRFVDDLpvD4QYwn6IQpykz9zEmurswkq0zHge8w422xOewh9NdRQpi8TGrIiPzxyIXdP8/3Mw0Au6vnIX+vunbKdyhlhiGCwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778022191; c=relaxed/simple;
	bh=/fycTv5YhTcaHtdvDXRTuawUV4sPx0VutIFIjnZmthE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nFHicBhtYPMKL4mH0YtUwv4z6txi951D3al9ktjl/I4VpAU6nsBqsBOm3MwdM8taTRGykttdGzxB6y+50v+vebhxZbdE5hXKMfzw2WyD3rjI6dftZ01a41F9BQ1ArUBGkMizogml7vsZNFmu/BMxUIsbJKKrQoxb4isz2nxoZKU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dcIPypoY; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50e5eb0fabaso63962391cf.0
        for <netdev@vger.kernel.org>; Tue, 05 May 2026 16:03:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778022189; cv=none;
        d=google.com; s=arc-20240605;
        b=Z8gROc0H54Q5qvJq/C1huXwkz0DMp6JEXLY2GkJCwfGfTiaGwb1OX+JTMREAnzPkOU
         u/crvIdq+QGYbGcwURPEzV9gxqFkxwHQ2FgtqoqaJak3eRlrVB4zIeaM89ht8VPzBJFc
         wculFshmpJMJFRlRd3DySzrIk0sFTmlgOT4XMfQeO35TXb5y0X7grT6E7u38Lx7UOY/8
         Kcuyc+GarsUfzt+89H7LqDl9cyV5J9wkufZ1taG3UvanmGx0CWeE7/ioQXU+1DCzqwg3
         DJrMCy0k7NxCrxcyvvMzTon7QrawLcee3g4xUNjcPiFNQUwmcreP8esHpxB59L9XKeTv
         1x+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=3g7r8RUoodlvBTdhCMylqSsTPrtGyld/5cBb8mp4pno=;
        fh=EUINxAEmgPdCAaYZNyLktn4KZXx+kFtRYBodvvduCfw=;
        b=MC2LoaJLGZN607EoqudeuLXCxyKPJwDZ3iAqUybc+C9fc8VLwx5xiui8Sm1QnzGSyv
         xD63DlMhJ+yCwP5wbD7kw2BoWyWzCmixmScoAmZeifovq3WvCchib9t6lLu00IOlChc+
         tpI7rMF45+53pcYvn9ZW0WVo205SCGUktFwrK4IEKykO5jvOHdXEpJqEfIFINqxxu+zj
         XayHfanw2HJ1uA4+SpMyJ+eypsioQRbHrZ4BxKChIJ/vH2NvD3jIYezk4hroc8RAcOur
         TMSsB2LlxuxO4RdNJI5qa5My5YXmWib1uEMUg945Y9kWIKNZWPx4nesTf6tp1n9hseaT
         eHdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778022189; x=1778626989; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3g7r8RUoodlvBTdhCMylqSsTPrtGyld/5cBb8mp4pno=;
        b=dcIPypoYPeZsclt3C0KDfFiDhldcAPpGuI1EdzHDFMlk/3VXv1xd7ZjjROfM2MhHIb
         vaLCQ+Vt8QYEmWR5aR/ZCGa6kPSXbwLhEsjsRL5HtDLUED9n3+03ootOoX3P1GqN2MFC
         ppfaaRs29K7Y6bEgwUvPWsSlLd9bDpeF0n1R4FBOjKzJekFyilXYOCUHmSDAOPHpNo1U
         U6Pd5/1wqyT7ICvE3ahZZ/PYQ1Ncc+mcv+0rbjRjkrAu1M0hIybaQsWdw6ELXsfpzGxe
         mqxqwMzmip4W/mr9xp4wBKhVpqcRxZV9szu+3PJX1kKZaltjaW6Bv6C9VNdo0tuAuv97
         Gizg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778022189; x=1778626989;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3g7r8RUoodlvBTdhCMylqSsTPrtGyld/5cBb8mp4pno=;
        b=cRBsHlGylEIFXKvjCjxoFamhd3nMYTqJ3TVy+rEuRFNQtdJMer+0uy3r3xPO1TrXgj
         1xlPDjG7divkWwR05tOsCtsKyQ/VJFyr74lyrsUzPFcXOgnAIGAkbrGOD8AcA5pzyNoU
         9JGY7S47ZjLgNjBnS/hCO7SXvxQqfHgfQUTKH8vAV+XNc3LnQKYGs0K9qejlaqbipZZq
         gx8UN3gMVZ/tySqZLpnJodC9+/FLNb5vSdmMgA706H+6zXdM/oLufMhP8luBbuBB6LDG
         AIdjTanpHowEe+cmZWlNepimPYD6mSxaakBiKbHS/5odEq4NOeaJzREJgLm2vDdJdORv
         9dDw==
X-Forwarded-Encrypted: i=1; AFNElJ/ZZrhv0D3yKntTXq47D0ahta7r7Z0CdS7zo2S+9oS/BHh2nb/98FEovLpvh3ZnVttOeqv9uW0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+5r819vkHPIjWuXu5dh/lcZMjI2TgOXtFUxZMb16DeqsX4IHW
	m32ezIMQvLQ5Inn6tR/fHP+SebtYszLcQilbTct8D+QuEddqk3n9EsTus5s4zFjFz9K99cRxJjz
	UmqHjiEdhxTZkZOEBEuAmp+ASOcQMGBY=
X-Gm-Gg: AeBDiet/GKGsWyTLASJVVT2OicZ8jbeM2rvPk+aEOef01PuwvarQxc7Nt/zyuUAHpKY
	yxohxsPmNmJzBH7kEM3fBYUDw7qEOEHn8pGgKsIuDdpQu8hGAo+B38ze/yivUn0npuDNXE4WoVZ
	PkI3onqWNgADEVnY1Wj+MDLcdAVFhrfNd9VjnDTF1RlkqgGjj7EpN929xAdZ14F03dUFia1OujQ
	XLX5UkYCMvYlc8FPldc9VhVvQ9pjTj8RAYOS4ssv/8RzS0IQ8mrOlFKsEzOFQ50xcMZJSiDloSD
	c2vIQoMZvu0JwdNQeMQ=
X-Received: by 2002:a05:622a:2283:b0:501:17a9:5ff5 with SMTP id
 d75a77b69052e-51461e50e22mr17851601cf.21.1778022188578; Tue, 05 May 2026
 16:03:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503-fixes-followup-v1-0-4313278918d3@narfation.org>
 <2262783.irdbgypaU6@sven-l14> <c75c7d50-36b2-4397-8355-891c83d663c9@kernel.org>
 <2313096.ZfL8zNpBrT@ripper>
In-Reply-To: <2313096.ZfL8zNpBrT@ripper>
From: Yuan Tan <yuantan098@gmail.com>
Date: Tue, 5 May 2026 16:02:32 -0700
X-Gm-Features: AVHnY4IaeUwMWTdOrY_jMxvH5xNZ3WPPdSPndWiDvIs2i9Ql7R07jK-C5G3Q8cc
Message-ID: <CAPuPA7+T80k9giivKS2B4WLacwp4JomyxjMmSESR-oyYb7XDSg@mail.gmail.com>
Subject: Re: [PATCH batadv 0/8] batman-adv: follow up fixes
To: Sven Eckelmann <sven@narfation.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Ao Zhou <n05ec@lzu.edu.cn>, Haoze Xie <royenheart@gmail.com>, 
	Jiexun Wang <wangjiexun2025@gmail.com>, Juefei Pu <tomapufckgml@gmail.com>, 
	Luxing Yin <tr0jan@lzu.edu.cn>, Ruide Cao <caoruide123@gmail.com>, Xin Liu <bird@lzu.edu.cn>, 
	Yifan Wu <yifanwucs@gmail.com>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 164E14D487C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284597-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,redhat.com,vger.kernel.org,lzu.edu.cn,gmail.com,perches.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[yuantan098@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,mail.gmail.com:mid]

On Tue, May 5, 2026 at 12:20=E2=80=AFAM Sven Eckelmann <sven@narfation.org>=
 wrote:
>
> On Tuesday, 5 May 2026 07:21:13 CEST Matthieu Baerts wrote:
> [...]
> > >>> Are you CCing netdev to get this reviewed by Sashiko?
> > >>> Please don't..
> > >>> We delegate code to sub-sub-systems to lower the patch volume :(
> > >>>
> > >>
> > >> Because of `b4 prep --auto-to-cc`. Will now manually remove you.
> > >
> > > To speed up the discussion: @Konstantin, is there a way in b4 to say =
"stop at
> > > the sub-sub-systems" when doing `b4 prep --auto-to-cc`? I am just try=
ing to get the
> > > `b4` workflow somehow working with the netdev requirements.
> >
> > Maybe a new option could be added, but that seems difficult to guess
> > where to stop, and to which subsystems to apply this.
> >
> > Can you not simply omit using `b4 prep --auto-to-cc` when working
> > with "internal" patches?
>
> Yes, no, maybe :)
> I will for the moment ignore the .b4-config part and talk about it at the=
 end
> of the mail.
>
> b4 is trying to (afaik) to have a good common work flow for kernel relate=
d
> projects (and more). Independent of my role (if I am the maintainer or ju=
st
> another contributor), it will nag before a send: "Hey, please run
> --auto-to-cc, --check, --check-deps before you submit this patch(set) - y=
ou
> know how embarrassing it is when you notice some obvious problem 2 second=
s
> after the SMTP server accepted your mail."
>
> And I agree with this and also try to convince people to try b4 because I
> think it is really helpful. Or at least ask them to use
> `./scripts/get_maintainer.pl` and NOT send patches with the prefix "net" =
or
> "net-next" when it actually targets our tree. But as it turns out, these
> recommendation seem to have been wrong and I am sorry about this.
>
> And I know, b4 is a good tool but adding a bazillion options just for eve=
ry
> special case doesn't make a lot of sense and might make it a worse tool. =
I was
> therefore more thinking about `scripts/get_maintainer.pl`  (see `b4.send-=
auto-
> cc-cmd`) which also called by b4 with various options to avoid adding too=
 many
> people.
>
> I don't say that any of these tools need to change. I am guessing more th=
at I
> have to adjust something (MAINTAINERS, ...) to avoid that people are send=
ing
> batman-adv sub-sub-system patches directly to netdev. I am just not aware=
 of
> what this should be. But it sounds to me like there is at least a need fo=
r it
> (from the netdev maintainers perspective).
>
> > On my side, that's what I'm doing. I added a .b4-config file with this
> > content, not to have to specify --set-prefix nor --to:
>
> Regarding the .b4-config - yes, this is helpful and I should add it to
> batctl.git. I was more thinking about the normal contributor to
> net/batman-adv/. Regardless of this person taking as base net/net-next.gi=
t or
> our repo.
>
> The fixes from Ren Wei (and associates) and some other people were sent w=
ith
> "net" in the prefix, were Cc'ing netdev and didn't seem to use our tree a=
s
> base. This is of course not correct and they should have targeted our tre=
e
> instead. I didn't complain because the fix was otherwise extremely helpfu=
l and
> I though that there was no harm done. As it looks now, I should have and =
I am
> sorry for not communicating this.
>
> And I am at the moment not sure how to fix this without overloading
> contributers with "when you are contributing to some sub-subsystem of net=
dev
> ..., but when you are contributing to ext4, other rules apply .... don't
> forget about i2c rules for patch submission, ...".
>
> But maybe I am just ignorant and this is already quite simple (and there =
are
> no special "netdev" rules) - I am just not aware of it. In this case, ple=
ase
> point me in the right direction, just to avoid reproducing wrong
> recommendations to other people.
>
> Regards,
>         Sven

Hi Sven,

I apologize for the inconvenience this caused. This was my oversight;
I=E2=80=99m embarrassed to admit that I was unaware that batman-adv used it=
s
own maintenance tree and had instructed my team to follow the standard
netdev process.

It is our responsibility as contributors to carefully follow rules. I
will update our internal guides immediately to ensure our future
patches adhere to the correct workflow.

Best,
Yuan

