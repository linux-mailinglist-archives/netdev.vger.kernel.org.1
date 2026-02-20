Return-Path: <netdev+bounces-259743-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Dbb8B9OImGlKJgMAu9opvQ
	(envelope-from <netdev+bounces-259743-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 17:16:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA421693A2
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 17:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3BA3130791DB
	for <lists+netdev@lfdr.de>; Fri, 20 Feb 2026 16:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C35E42E06E6;
	Fri, 20 Feb 2026 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b="rCXHmxi1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D14E2DCC13
	for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 16:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771603942; cv=pass; b=btxRdpp8SFUgkEXKhXKPOtle8vzz3W2vWnmYC4E/V/59FBzs2XQyA0GzRApsWxmgXmSiVQ1ez3F+MqrHtIoBQIWjU1+ISpBHzRmc+9DD8Fy9QSll1/iqxd98njzTmYBiYesGj10DjUjrYU4ZJXl/Dg6PrW1O368e0GzVXo09Qyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771603942; c=relaxed/simple;
	bh=W2vIGVp8h9uNwpr8NnU/MlgEJgjjYPGn7YXHS50K6E8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ioFpcEahCba08qMBWb8vdEpYvSXMv0GZ64mFV+WxEdRMPm1bzcJERWzbbLSU1F27DrmN8ZCPdKxs+ZrOZ9Mdm2j3V5Rog7eIzfgvXVk7mwyUDh+U5+fpZoQQ5fw6OBtCUinhKM+lSksjBziTA2g2bjr/wNVsm42KTFXcf+iMX8A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (2048-bit key) header.d=mojatatu-com.20230601.gappssmtp.com header.i=@mojatatu-com.20230601.gappssmtp.com header.b=rCXHmxi1; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-64ad9fabd08so2154359d50.2
        for <netdev@vger.kernel.org>; Fri, 20 Feb 2026 08:12:21 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771603940; cv=none;
        d=google.com; s=arc-20240605;
        b=EkGgfhVIbuVDyIeVqZhM/PJ2JUQzY0KOgRF1D6suFFES4+O2HYghbxPXjuK0Dd0J0w
         fY1XC6S1WZTxuz9dtP2elyJWvTqldQ6DwGybvC9+wcED8WKg5wwxwib85kV7fwkIUm6Z
         n5r3iQSUlwzYMlfP5agge5MXJnknsm3NIkpIP5OE0SiAyEGkxs0O1pMXtT4eXTzLVuvB
         UiGRNl3bsLGYxs8u6ZeRg/Hn5VguqlsAEkfByu5bp1Eh/TgivbmRrYLxP1sR+IfdAuCM
         mO0euwclZj1DB4mVom0viGCBPfVnsnkkL3MlbSTdaa93VeK+oHZ4vvA1ARK/e5fvfYqL
         vT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qXQGNzJwrVzAlsvVue3PVsH3YYfJheCZPEJ1mOeTgFs=;
        fh=JZV9+tELkV36X+4quSphXGk9sFNwlGK0A5vu0RS7rME=;
        b=ZOa3c/RghY+eZ9j3gHFAV3zc8Gaouw2jLw+wymV768rAN6I7yKqa/Hz/469fEUUQIW
         U4Ertwhh0dglBlFdjF/x94Owv56MKIuRB/L83nJxaP1jah6FV1lTr7Xkz5d9Qo4ObW+C
         omu88OnKtcBc67cc/RBRTrUqIsZq+Tel3qNwxKVhiSmDGWOQUu0bSzCltqxeQKQkaEYV
         uFAm2NP1po+B/aG5OK9ALgpyqZp8X7WIlEnK/IUUQqgV0XZtN7/aq2NrNvC8d4mqZiNN
         x7oF38qNsYeaD06v4tZC5vjyxR0m2gVkhx9AMst0Ys6VbvbThF8SWjqGVIWmpJJa/Aku
         Evvw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1771603940; x=1772208740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXQGNzJwrVzAlsvVue3PVsH3YYfJheCZPEJ1mOeTgFs=;
        b=rCXHmxi1yPyRyKBy0ekljWgDRqaz88BKhIUBz0Woho8t2CNvhjv83xgGHh9uQ82Rhl
         ECeQbRoMURzj77YwdIeiIdfDDWBjtJNgQewbdNHtlo3d73JnIo601T76odKc8lja3edI
         Czq70f2nphjpI+zY4ONMQ8E7pA0Zuw11d6o0Q0bPWPmF/XnrlJzfSYad4DQbxLjtJaIl
         OMyPK0edn5UCkvwKftGBRvc5ewG0NdArjtNXgXjxkKO42oZ+eXmMsolRjcsVv21S8p6q
         aNoTvuB4JboZ2ICkTPxyXs25+zChC+Kw4w+DAq9G5w234N9Isx04BX1f1J47gpdihlm2
         rIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771603940; x=1772208740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qXQGNzJwrVzAlsvVue3PVsH3YYfJheCZPEJ1mOeTgFs=;
        b=Zkq51xDh9dw4SPCpWpUa8fGqeFtLGVJtV0FE16h7Bzvu6FhOZMtkHhZwAaT4P7+Ci5
         paqFToM+Oi3PnoH4sES4WgfWR/ZR+q8aZRDjRxCprt4F/ZhZHiIG6+uuHYjSFSllOjQd
         Cj3nDocTXPduulvPhEXvNJf7j/qlMJU6zVvTVV/VLb/NaQzTrEo+0ZEgzzNO9NR1iYj+
         WhUGU6xLOS+AxoYfkPeSxgxAuI7YQAPYtDWpu4YlxKYPJIKnKrei3sJnZ4IPmxl5cIbD
         hnESe96RaI1qCbPDJ0rDdxphVudrNNY6zrTgmr8032thv5e3I+Yqh6ryiySR6cb0WIJm
         LdZA==
X-Forwarded-Encrypted: i=1; AJvYcCWR5qt/jAxb8K+PFkFg/8Ev/+bBD+IbLHB8mquIII9pefvDRih7qwQ6pG6zOYu+YVEy1KkiJy8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvVa9mQhVXTr07nY3s797wNykSbebk4f8JcuYSt6U3vgoPkzbj
	7Mm7GOzF9G4MctED7CG7rpl9BLUoc7+3XGdmnmk8D3LYkvf0sNLFJ/rpYCSS8g7RvlgDUfDo/lv
	K0vIZ9FJrtlLWfgirceuEwlU/8h0tLqZmIycJbXHw2XW3kdKPHUM=
X-Gm-Gg: AZuq6aKtSS+dcNgY5xGnCczg9S8DxH2g81xQQXiuLXr8SPBTQ67OQ/0zoky6OidVGpi
	Ai341+y2jvwoR6yPPr5bosklym0uqaLf2ZaYobeaanLJvZStv62aYIm8npKND2dzTfBp6XHdESD
	OYeHBqzeAktQDMcC1FkLrgKVpeM7C7HkogSh48MkMJVae02N4Kj9Cdg//u1ZFWKfKaYYkWvOtXG
	I3kA4Rg0J3tg4hqOj/zntNX1lENM00YoerA9MTCUdZAtCqZSyO/ulDyPaWQ3yc9QKsxXxC1rNVJ
	W70MDZhjEqq7nkMZPBpLUw==
X-Received: by 2002:a05:690e:d01:b0:649:eb42:582 with SMTP id
 956f58d0204a3-64c787d46bcmr297363d50.2.1771603940179; Fri, 20 Feb 2026
 08:12:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <674b8cbfc385c6f37fb29a1de08d8fe5c2b0fbee.1771321118.git.pabeni@redhat.com>
 <cc6bfb4a-4a2b-42d8-b9ce-7ef6644fb22b@ovn.org> <ecfc49ae-99c9-414e-8b8d-211112fc5873@redhat.com>
 <b6b67235-bd7b-45d3-81e1-49a2a1f6b241@ovn.org> <CAM0EoM=g3ahJ704qDQmr4s-4sDJqbyRvWNDchb3YaRbD0zdyKA@mail.gmail.com>
 <90b25744-76e5-4d9a-865f-72832bbedfe5@ovn.org> <CAM0EoMmgigcc9aYmoj_vEM4TpopHDFjyjbdFeVyEN8QzVLb4vw@mail.gmail.com>
 <CAM0EoMm3zkJpkHkwHX0YQDSJD_gEMphihZ3CC+b1dMx49bdjWg@mail.gmail.com>
 <d07fdeb8-2b26-43f0-8fab-28907e88bd06@redhat.com> <CAM0EoMmq-aN98=TTh7YkODFr2DmZjD=Lzp6roGiCBog1tT9Lyw@mail.gmail.com>
 <CAM0EoMn_eXtLi36Nb3Y=oHCN3dNRjhB0UMwGVhZkr4zbAkxzuA@mail.gmail.com>
 <b4b43d1d-00bc-4168-8204-88bd9b0ba9a1@mojatatu.com> <76d410c5-e685-43c5-980b-ecf325bf4955@ovn.org>
In-Reply-To: <76d410c5-e685-43c5-980b-ecf325bf4955@ovn.org>
From: Victor Nogueira <victor@mojatatu.com>
Date: Fri, 20 Feb 2026 13:12:08 -0300
X-Gm-Features: AaiRm50aJhYVsRmRhUjDA-sZGN64QeB09R4ziOYzp2NhPuHSzKY5qreoQ4e4deY
Message-ID: <CA+NMeC8SntehOUk69APy9OC+q8NeA0T=-SYiozb1Q=BCkPYjkQ@mail.gmail.com>
Subject: Re: [PATCH net] net_sched: act_ct: drop all packets when not attached
 to ingress
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	Jiri Pirko <jiri@resnulli.us>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, 
	Henrik Steen <henrist@henrist.net>, Olivier Tilmans <olivier.tilmans@nokia.com>, 
	Bob Briscoe <research@bobbriscoe.net>, Olga Albisser <olga@albisser.org>, 
	GangMin Kim <km.kim1503@gmail.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Aaron Conole <aconole@redhat.com>, Florian Westphal <fw@strlen.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	R_DKIM_ALLOW(-0.20)[mojatatu-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mojatatu.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259743-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[mojatatu-com.20230601.gappssmtp.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[victor@mojatatu.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[mojatatu.com,redhat.com,vger.kernel.org,resnulli.us,davemloft.net,google.com,kernel.org,henrist.net,nokia.com,bobbriscoe.net,albisser.org,gmail.com,strlen.de];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mojatatu-com.20230601.gappssmtp.com:dkim,ovn.org:email]
X-Rspamd-Queue-Id: 6BA421693A2
X-Rspamd-Action: no action

On Fri, Feb 20, 2026 at 10:41=E2=80=AFAM Ilya Maximets <i.maximets@ovn.org>=
 wrote:
>
> On 2/20/26 1:24 PM, Victor Nogueira wrote:
> > On 19/02/2026 17:13, Jamal Hadi Salim wrote:
> >> On Thu, Feb 19, 2026 at 9:16=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu=
.com> wrote:
> >>>
> >>> On Wed, Feb 18, 2026 at 3:43=E2=80=AFPM Paolo Abeni <pabeni@redhat.co=
m> wrote:
> >>>>
> >>>> On 2/18/26 7:44 PM, Jamal Hadi Salim wrote:
> >>>>> On Wed, Feb 18, 2026 at 1:31=E2=80=AFPM Jamal Hadi Salim <jhs@mojat=
atu.com> wrote:
> >>>>>> On Wed, Feb 18, 2026 at 11:15=E2=80=AFAM Ilya Maximets <i.maximets=
@ovn.org> wrote:
> >>>>>>>  From a user's perspective I'd prefer if RTM_NEWTFILTER just fail=
s when
> >>>>>>> it contains TCA_ACT_KIND "ct" with TC_H_MIN_EGRESS.  This is clea=
r
> >>>>>>> for the application that makes a request and for the user if they=
 make
> >>>>>>> the request manually with 'tc filter ...'.
> >>>>>
> >>>>>> The challenge is actions could be created as a standalone i.e "tc
> >>>>>> actions add action ct..." then later bound via tc filter. Don't fo=
rget
> >>>>>> actions can also be shared by multiple filters (which could be a m=
ix
> >>>>>> of egress/ingress)...
> >>>>>
> >>>>> Actually, looking closely at the code - this is doable. Let's see i=
f a
> >>>>> patch can be cooked.
> >>>>
> >>>> I discussed a bit the topic with Davide, it looks like the thing you
> >>>> mentioned above could be handled. The problematic part is AFAICS the
> >>>> additional indirection level added by (possibly shared) blocks. AFAI=
CS
> >>>> whatever check we do at ct_init() time, shared block could later
> >>>> circumvent it - unless act_ct is always forbidden for shared blocks.
> >>>>
> >>>> TL;DR: I think admission check at init time can be implemented only =
in a
> >>>> quite (too much?) restrictive way.
> >>>>
> >>>
> >>> True - the blocks will require more surgery but seems doable. We may
> >>> end up again in ->quirks() land here. I.e when an action is bound to =
a
> >>> filter (not necessarily when created) it should check its fit in the
> >>> graph and see if it is legit. But since this is only the second quirk
> >>> we know of, we can simplify. Note: We already have one such check,
> >>> albeit ugly-looking, with skbedit (see flag TCA_ACT_FLAGS_AT_INGRESS)=
.
> >>> I will talk to Victor and see if he can cook at minimal a preliminary
> >>> patch without considering blocks, and at best one that does consider
> >>> blocks.
> >>
> >> After discussions with Victor we concluded that blocks have no effect
> >> on this specific issue.
> >> Blocks are only useful in clsact(both ingress/egress) and ingress.
> >> Both of these handle ACT_CONSUMED fine.
> >> Code sample looks as follows:
> >>
> >>          case TC_ACT_STOLEN:
> >>          case TC_ACT_QUEUED:
> >>          case TC_ACT_TRAP:
> >>                  consume_skb(skb);
> >>                  fallthrough;
> >>          case TC_ACT_CONSUMED:
> >>                  *ret =3D NET_RX_SUCCESS;
> >>                  bpf_net_ctx_clear(bpf_net_ctx);
> >>                  return NULL;
> >>
> >> The reason this works is because they don't have to deal with
> >> queues(unlike the other qdiscs).
> >> So, ignoring the block should work just fine. Ilya, for your case, if
> >> you must egress, use clsact egress - the only problem is it will not
> >> support the more feature-rich qdiscs...
> >
> > If there is no objection, we are thinking of sending something along
> > these lines:
> >
> > diff --git a/include/net/act_api.h b/include/net/act_api.h
> > index 91a24b5e0b93..2ba40eb45aad 100644
> > --- a/include/net/act_api.h
> > +++ b/include/net/act_api.h
> > @@ -70,6 +70,7 @@ struct tc_action {
> >   #define TCA_ACT_FLAGS_REPLACE  (1U << (TCA_ACT_FLAGS_USER_BITS + 2))
> >   #define TCA_ACT_FLAGS_NO_RTNL  (1U << (TCA_ACT_FLAGS_USER_BITS + 3))
> >   #define TCA_ACT_FLAGS_AT_INGRESS       (1U << (TCA_ACT_FLAGS_USER_BIT=
S
> > + 4))
> > +#define TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT     (1U <<
> > (TCA_ACT_FLAGS_USER_BITS + 5))
> >
> >   /* Update lastuse only if needed, to avoid dirtying a cache line.
> >    * We use a temp variable to avoid fetching jiffies twice.
> > diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
> > index 81d488655793..a79479faf0f8 100644
> > --- a/net/sched/act_ct.c
> > +++ b/net/sched/act_ct.c
> > @@ -1360,6 +1360,12 @@ static int tcf_ct_init(struct net *net, struct
> > nlattr *nla,
> >                  return -EINVAL;
> >          }
> >
> > +       if (bind && !(flags & TCA_ACT_FLAGS_AT_INGRESS_OR_CLSACT)) {
> > +               NL_SET_ERR_MSG_MOD(extack,
> > +                               "May only attach ct to ingress or clsac=
t");
> > +               return -EPERM;
>
> I haven't tried this change yet, but I'd say this error code should
> be EOPNOTSUPP instead of EPERM, as it's not a permissions problem,
> it's that we decided to not support this use case.
>
> From the OVS side EOPNOTSUPP will be handled by ovs-vswitchd normally
> with a fallback to a standard openvswitch datapath.  While EPERM, though
> still handled, will cause an extra error reported to the user, which
> is not desirable.

That's a fair point, we can make that change.

cheers,
Victor

