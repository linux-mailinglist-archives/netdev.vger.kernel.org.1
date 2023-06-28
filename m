Return-Path: <netdev+bounces-14406-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D50C740A30
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 10:00:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8A81C208C6
	for <lists+netdev@lfdr.de>; Wed, 28 Jun 2023 08:00:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8B4C63C8;
	Wed, 28 Jun 2023 08:00:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D830863BC
	for <netdev@vger.kernel.org>; Wed, 28 Jun 2023 08:00:30 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C8DA3;
	Wed, 28 Jun 2023 01:00:26 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb7589b187so4825469e87.1;
        Wed, 28 Jun 2023 01:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687939224; x=1690531224;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCiVnIiBTWxP9T/l4gc5KqB15PzobXDfsgWHGo4kW6w=;
        b=Atk/FL/9Z6Wadg6fR1BZpsHoBVs6dAZnOoJjIoGnbqSpNasB218H73bm4pxhxs3VJx
         umDvYrlu+7+G8C8UAfPJ0XS4+z1oEcsDGqLppe+qNkUYfPT5jOgL6HGEu+kO867kcmUJ
         UCyf9Apq1cJtI1nV2bqz9cuYXog2xB/uMEUbmiXB2viAp1hs/GkFLkkRBdaW0+bzTzcz
         zUqPyuhfXJsjyRkwsp0NFQM15rXajW4l8ZPaCszNYqmQnVcQlnHDbS14qFQGRdaxp+OH
         XCCg1srlakVE1oL75m3yR0bYWQGBlYmngkaeMZNazjFf3iNORBJKNdO3zxZxxsArQBQC
         d1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687939224; x=1690531224;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gCiVnIiBTWxP9T/l4gc5KqB15PzobXDfsgWHGo4kW6w=;
        b=ktuESsELloTCOHTx2ryoHmJLm6qZ5rd4OUnAbTX4HXVwwOz2De1qDt1YLjcpLHqYu/
         rA2/Vcgze4sZOI7wkwlmLVR5dtSXfbW/Cfg12kTR3eNtbsyrrLJt+VxIniZPkQLwVT0B
         bYSXQ1IRainzlmNBQf+tHsx6G0FaqLB+o1B39ATMYtvZ1yF8AJwzmkgZC8ZXvF3n6idq
         mKyMdHycxb3hzjJo6V0IyDRNqdqDISKcM4AYNVO+y4PMnXfOoVbU3c2cbkCbHNffXIRx
         srwFbreXkaMgNwFzfr2e/NEatBT1s6MnO9MNOiorStTOLPpb1xRdq5QpfiK9BNlmIbTz
         mgIQ==
X-Gm-Message-State: AC+VfDwsa77V3RNcFkYRKJR/siziZa+nnL+VXG3RD63iamdGK2UnI8lN
	nYie6YgtNUIq1CwLVAjO8Ek=
X-Google-Smtp-Source: ACHHUZ5JfjpLByN+xk3+nw7l3otdzAnIQaT9fCpC3MJlEf/M7GLH4UUGnbVSdzEN0B0XtGlgO5VAxw==
X-Received: by 2002:a05:6512:b0e:b0:4f8:75cf:fdd7 with SMTP id w14-20020a0565120b0e00b004f875cffdd7mr16303621lfu.22.1687939223949;
        Wed, 28 Jun 2023 01:00:23 -0700 (PDT)
Received: from localhost (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id u8-20020a05600c210800b003f9b4330880sm13048436wml.29.2023.06.28.01.00.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 01:00:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 28 Jun 2023 10:00:23 +0200
Message-Id: <CTO4IM6NQZ4N.6DC89N410CDS@syracuse>
Cc: "opensource.kernel@vivo.com" <opensource.kernel@vivo.com>
Subject: =?utf-8?q?Re:_[PATCH]_wifi=EF=BC=9Amac80211:_Replace_the_ternary_conditio?= =?utf-8?q?nal_operator_with_max()?=
From: "Nicolas Escande" <nico.escande@gmail.com>
To: "Ping-Ke Shih" <pkshih@realtek.com>, "You Kangren"
 <youkangren@vivo.com>, "Johannes Berg" <johannes@sipsolutions.net>, "David
 S. Miller" <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "open list:MAC80211" <linux-wireless@vger.kernel.org>, "open
 list:NETWORKING [GENERAL]" <netdev@vger.kernel.org>, "open list"
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.15.1
References: <20230626104829.1896-1-youkangren@vivo.com>
 <9e4e3bf85ed945e7b0c8d5d389065670@realtek.com>
In-Reply-To: <9e4e3bf85ed945e7b0c8d5d389065670@realtek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed Jun 28, 2023 at 3:48 AM CEST, Ping-Ke Shih wrote:
>
>
> > -----Original Message-----
> > From: You Kangren <youkangren@vivo.com>
> > Sent: Monday, June 26, 2023 6:48 PM
> > To: Johannes Berg <johannes@sipsolutions.net>; David S. Miller <davem@d=
avemloft.net>; Eric Dumazet
> > <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <p=
abeni@redhat.com>; open
> > list:MAC80211 <linux-wireless@vger.kernel.org>; open list:NETWORKING [G=
ENERAL] <netdev@vger.kernel.org>;
> > open list <linux-kernel@vger.kernel.org>
> > Cc: opensource.kernel@vivo.com; youkangren@vivo.com
> > Subject: [PATCH] wifi=EF=BC=9Amac80211: Replace the ternary conditional=
 operator with max()
>
> The semicolon of "wifi=EF=BC=9A" is different from others.
>
> >=20
> > Replace the ternary conditional operator with max() to make the code cl=
ean
> >=20
> > Signed-off-by: You Kangren <youkangren@vivo.com>
> > ---
> >  net/mac80211/tdls.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/net/mac80211/tdls.c b/net/mac80211/tdls.c
> > index a4af3b7675ef..9f8b0842a616 100644
> > --- a/net/mac80211/tdls.c
> > +++ b/net/mac80211/tdls.c
> > @@ -946,7 +946,7 @@ ieee80211_tdls_build_mgmt_packet_data(struct ieee80=
211_sub_if_data *sdata,
> >         int ret;
> >         struct ieee80211_link_data *link;
> >=20
> > -       link_id =3D link_id >=3D 0 ? link_id : 0;
> > +       link_id =3D max(link_id, 0);
>
> Original logic means "if link_id < 0, then use default link (0)" instead =
of
> "always use link_id larger than or equal to 0". So, I think max(link_id, =
0) could
> cause misunderstanding.=20

I feel the same way, max() implies we want the 'highest' link whereas for m=
e the
actual code really means 'prefer the non default' (zero) link.

>
> >         rcu_read_lock();
> >         link =3D rcu_dereference(sdata->link[link_id]);
> >         if (WARN_ON(!link))
> > --
> > 2.39.0
> >=20
> >=20
> > ------Please consider the environment before printing this e-mail.


