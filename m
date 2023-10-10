Return-Path: <netdev+bounces-39625-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BAF7C02D0
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:36:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 977ED1C20BAF
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:36:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FA236AFC;
	Tue, 10 Oct 2023 17:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1zzlZH8c"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E7242FE22
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 17:36:52 +0000 (UTC)
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427139D
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:36:50 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53d9f001b35so1307833a12.2
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696959409; x=1697564209; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZWNVXhOMB/X7Db/z1zWLDue+XTDYtJ9T9vo+cNZEfhw=;
        b=1zzlZH8cXHkHdZRDMVCSWZMTfaqJJcf9gxAfzNtj+qEkReE6HIZ8Ss0tDAGAyf6Bng
         L927lSmBL0nPZ6LXlLe0oyUG4UhHj5Jgu+uaYEK6boTmxza+qnbyLa2hv7WAGZmI4+DB
         f+cUi5/y7Q1fxilYLgSuFB3UPYvwHYSaMA98VKEV0oM5iDc2LO5y0oVeII2giaBoppi9
         vjD7vSRvj5uTvQAdDgJYU7A/TpjXplrWUM0OUCrNZ6SWN3z016TqdXwZxne0+4cbF2PY
         l5YmKTDsxn7aVOhylIWtgM7Kh95S5r46H+a1qjQ9aHPDblTU0L/i5QoqkjTG+PSjp+cd
         EgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696959409; x=1697564209;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZWNVXhOMB/X7Db/z1zWLDue+XTDYtJ9T9vo+cNZEfhw=;
        b=mILPacnf5mx4LKXbcLWT5vVKTEdo6bRf2gKEgMb94J/QHD+m9S3uzSNO1qKWlCeA2b
         tsQvqURsIxLTn6jIevKEjNQBrHPXacpBkjZM4CNab8N0NIoFNYQom6SsDlzuohCLPjN+
         wkifKJTgUkOvtmZ7SzePxE3E7d1v21RNWXi2ft42fiIeU1Ur66sYhx3kINiA/jS1YfNs
         M03uUhbW32ynqaCYxD+OI4C4qpfOyrHSkyyeZtZ3efxQppRR0J+AxlNB+wt2AE/M/zuZ
         zK+b9s5nta9cVi49fsx7S4lSINNlnSQ8HeYPpERYIyTR2zFtnxxe2YVoKoNUadJ3IvNC
         +3cw==
X-Gm-Message-State: AOJu0Yxfu3N5DkJ4AAfvHL8rQ1tClxx1GXRVw213+uEL00QjZblsD9j6
	Q4QKEf3i9GVpJPdH4jz3jDHtH/Rgbjw0CndfYh7G8oxYrFjDbdg1VFJORg==
X-Google-Smtp-Source: AGHT+IGLNIUhNFg4goSmZvGSOS1oKrfqY+cMA+PaALzrOB69uFcOn6GaHQE6JU/84F7XmflfUBWSo38rtPlyLd1RMJk=
X-Received: by 2002:aa7:dad2:0:b0:533:5e56:bef2 with SMTP id
 x18-20020aa7dad2000000b005335e56bef2mr17194800eds.10.1696959408584; Tue, 10
 Oct 2023 10:36:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009-strncpy-drivers-net-dsa-realtek-rtl8365mb-c-v1-1-0537fe9fb08c@google.com>
 <20231010110717.cw5sqxm5mlzyi2rq@skbuf>
In-Reply-To: <20231010110717.cw5sqxm5mlzyi2rq@skbuf>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 10 Oct 2023 10:36:36 -0700
Message-ID: <CAFhGd8pgGij4BXNzrB5fqk_2CNPDBTgf-3nN0i6cJak6vye_bA@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: realtek: rtl8365mb: replace deprecated strncpy
 with ethtool_sprintf
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
	USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 4:07=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> Hello Justin,
>
> On Mon, Oct 09, 2023 at 10:43:59PM +0000, Justin Stitt wrote:
> > `strncpy` is deprecated for use on NUL-terminated destination strings
> > [1] and as such we should prefer more robust and less ambiguous string
> > interfaces.
> >
> > ethtool_sprintf() is designed specifically for get_strings() usage.
> > Let's replace strncpy in favor of this more robust and easier to
> > understand interface.
> >
> > Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#st=
rncpy-on-nul-terminated-strings [1]
> > Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en=
.html [2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
> > ---
> > Note: build-tested only.
> > ---
> >  drivers/net/dsa/realtek/rtl8365mb.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/real=
tek/rtl8365mb.c
> > index 41ea3b5a42b1..d171c18dd354 100644
> > --- a/drivers/net/dsa/realtek/rtl8365mb.c
> > +++ b/drivers/net/dsa/realtek/rtl8365mb.c
> > @@ -1303,8 +1303,7 @@ static void rtl8365mb_get_strings(struct dsa_swit=
ch *ds, int port, u32 stringset
> >
> >       for (i =3D 0; i < RTL8365MB_MIB_END; i++) {
> >               struct rtl8365mb_mib_counter *mib =3D &rtl8365mb_mib_coun=
ters[i];
> > -
> > -             strncpy(data + i * ETH_GSTRING_LEN, mib->name, ETH_GSTRIN=
G_LEN);
> > +             ethtool_sprintf(&data, "%s", mib->name);
>
> Is there any particular reason why you opted for the "%s" printf format
> specifier when you could have simply given mib->name as the single
> argument? This comment applies to all the ethtool_sprintf() patches
> you've submitted.

Yeah, it causes a -Wformat-security warning for me. I briefly mentioned it
in one of my first patches like this [1].

[1]: https://lore.kernel.org/all/20231005-strncpy-drivers-net-dsa-lan9303-c=
ore-c-v2-1-feb452a532db@google.com/

