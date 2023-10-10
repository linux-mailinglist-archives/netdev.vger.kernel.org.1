Return-Path: <netdev+bounces-39629-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB37C02ED
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 19:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 859AD1C20AF8
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 17:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F50E225AC;
	Tue, 10 Oct 2023 17:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ct9KezJS"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72498225A8
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 17:45:00 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0969E
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:44:56 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-5046bf37daeso7769817e87.1
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696959894; x=1697564694; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CZKPadVGhq7IGu5t5fQwhttBM2lc5ZmxiCdIFjcEzCY=;
        b=ct9KezJSg/5J6pcz3PO/PabhbqOQPfK+7MyXgDVCe1HprLEmJ6f/INCudym/5Mbz1Y
         zAVdMPA6S9qDXPN84Z6rhAWHzoQmWwhNHJmX7gFdyBs9J9qs5MFsFuRXB4w2ErZIP4l+
         MBaT7bu75fviY/6H31yqppOvEGgoq8YUyiJqsVnV4w3mz8hkEPT4d7zuyAZyGirGhlcZ
         5n8eg7KGLrh8d9aMqwdWbMZCTLbPbTdcE9dylDZmWAV19fd9diAeTipgPPuvPTYUB+JD
         7ZIAGlmyBJJ16hHCrWnI0re+f9+/pnO+TiIvFhdr7UEDkWtPgB45BF1RmX9+CaZPxHI3
         Di7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696959894; x=1697564694;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CZKPadVGhq7IGu5t5fQwhttBM2lc5ZmxiCdIFjcEzCY=;
        b=Z85MRQpd1TtJgCX3+3nHVPo/bzGfiyMf3eEVdNExorj3HdYJPZNpkdQ8MCTCl7I9k8
         rB0clRVFqKFza8egSdFXgVLD2gIMSyXguH38DpgcVjRv7sYNnnWSqy5TkQ9tDW6ftHW1
         0k0VzW8jak2+vONJvJ+4pSVuvO0AjFOuA8n+PmNTT9bWQQCxnFjUEKRC0TyQ2vv8orey
         HVy56wpe5IdwbVAEZxuzJansI+Ub2hPpLsVkynTty/koGeC9Dj27ApbF1aWI5n7hTHxt
         DnyjPEQlA6LALEm18jL3KaErpOV6mP9emfTezEhpS3XgYdUMxUqI1UI3WqCQGPeklqzR
         nd+w==
X-Gm-Message-State: AOJu0YyBqJpp1KC/RsZUhYdWbXPn17Dz/s0+QZ/h7hf+kznAvZmfx9jm
	0WaTvN7hA4pENjNJ0GWYHn59OsBmK4BdbP0QteiHPQ==
X-Google-Smtp-Source: AGHT+IEIhc9IU/4HKiS+vMCnOVgQHp9LKtgDSFXjvJ1QHCm9VmXIRJEc0Lyrrby/q5aHKa/b3qsI1w9i7DXBF+PAH1k=
X-Received: by 2002:a05:6512:34d3:b0:500:9d4a:8a02 with SMTP id
 w19-20020a05651234d300b005009d4a8a02mr13360689lfr.62.1696959894309; Tue, 10
 Oct 2023 10:44:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-v1-1-e2427e087fad@google.com>
 <20231010112051.zgefbx2c3tjneudz@skbuf>
In-Reply-To: <20231010112051.zgefbx2c3tjneudz@skbuf>
From: Justin Stitt <justinstitt@google.com>
Date: Tue, 10 Oct 2023 10:44:42 -0700
Message-ID: <CAFhGd8pF04DCbMJFOR+93azqzWYZ2aE9FByp7yVVJR90g7MN9g@mail.gmail.com>
Subject: Re: [PATCH] net: dsa: vsc73xx: replace deprecated strncpy with ethtool_sprintf
To: Vladimir Oltean <olteanv@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 10, 2023 at 4:20=E2=80=AFAM Vladimir Oltean <olteanv@gmail.com>=
 wrote:
>
> On Mon, Oct 09, 2023 at 10:54:37PM +0000, Justin Stitt wrote:
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
> >  drivers/net/dsa/vitesse-vsc73xx-core.c | 20 ++++++--------------
> >  1 file changed, 6 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/net/dsa/vitesse-vsc73xx-core.c b/drivers/net/dsa/v=
itesse-vsc73xx-core.c
> > index 4f09e7438f3b..09955fdea2ff 100644
> > --- a/drivers/net/dsa/vitesse-vsc73xx-core.c
> > +++ b/drivers/net/dsa/vitesse-vsc73xx-core.c
> > @@ -928,7 +928,8 @@ static void vsc73xx_get_strings(struct dsa_switch *=
ds, int port, u32 stringset,
> >       const struct vsc73xx_counter *cnt;
> >       struct vsc73xx *vsc =3D ds->priv;
> >       u8 indices[6];
> > -     int i, j;
> > +     u8 *buf =3D data;
> > +     int i;
> >       u32 val;
> >       int ret;
> >
> > @@ -948,10 +949,7 @@ static void vsc73xx_get_strings(struct dsa_switch =
*ds, int port, u32 stringset,
> >       indices[5] =3D ((val >> 26) & 0x1f); /* TX counter 2 */
> >
> >       /* The first counters is the RX octets */
> > -     j =3D 0;
> > -     strncpy(data + j * ETH_GSTRING_LEN,
> > -             "RxEtherStatsOctets", ETH_GSTRING_LEN);
> > -     j++;
> > +     ethtool_sprintf(&buf, "RxEtherStatsOctets");
>
> Here you don't use "%s", but everywhere else you do. Can't you just pass
> the counter name everywhere, without "%s"?
>
> >
> >       /* Each port supports recording 3 RX counters and 3 TX counters,
> >        * figure out what counters we use in this set-up and return the
> > @@ -962,22 +960,16 @@ static void vsc73xx_get_strings(struct dsa_switch=
 *ds, int port, u32 stringset,
> >       for (i =3D 0; i < 3; i++) {
> >               cnt =3D vsc73xx_find_counter(vsc, indices[i], false);
> >               if (cnt)
> > -                     strncpy(data + j * ETH_GSTRING_LEN,
> > -                             cnt->name, ETH_GSTRING_LEN);
> > -             j++;
> > +                     ethtool_sprintf(&buf, "%s", cnt->name);
>
> The code conversion is not functionally identical, and I think it's a
> bit hard to make it identical.
>
> The VSC7395 has 45 port counters, but it seems that it can only monitor
> and display 8 of them at a time - 2 fixed and 6 configurable through
> some windows.
>
> vsc73xx_get_strings() detects which counter is each window configured
> for, based on the value of the CNT_CTRL_CFG hardware register (VSC73XX_C_=
CFG
> in the code). It displays a different string depending on the hardware
> value.
>
> The code must deal with the case where vsc73xx_find_counter() returns
> NULL, aka the hardware window is configured for a value that vsc73xx_tx_c=
ounters[]
> and vsc73xx_rx_counters[] don't know about.
>
> Currently, the way that this is treated is by skipping the strncpy()
> (and thus leaving an empty string), and incrementing j to get to the
> next ethtool counter, and next window.
>
> The order of the strings in vsc73xx_get_strings() needs to be strongly
> correlated to the order of the counters from vsc73xx_get_ethtool_stats().
> So, the driver would still print counter values for the unknown windows,
> it will just not provide a string for them.
>
> In your proposal, the increment of j basically goes into the "if (cnt)"
> block because it's embedded within ethtool_sprintf(), which means that
> if a hardware counter is unknown, the total number of reported strings
> will be less than 8. Which is very problematic, because vsc73xx_get_sset_=
count()
> says that 8 strings are reported. Also, all the counter strings after
> the unknown one will be shifted to the left.
>
> I suggest that "if (!cnt)", you should call ethtool_sprintf() with an
> empty string, to preserve the original behavior.

Wow, thanks for the feedback here. I agree that the current
proposal is problematic. I wonder what you think about
using a ternary to avoid smelly code dupe:

for (i =3D 0; i < 3; i++) {
        cnt =3D vsc73xx_find_counter(vsc, indices[i], false);
        ethtool_sprintf(&buf, "%s", cnt ? cnt->name : "");
}

>
> >       }
> >
> >       /* TX stats begins with the number of TX octets */
> > -     strncpy(data + j * ETH_GSTRING_LEN,
> > -             "TxEtherStatsOctets", ETH_GSTRING_LEN);
> > -     j++;
> > +     ethtool_sprintf(&buf, "TxEtherStatsOctets");
> >
> >       for (i =3D 3; i < 6; i++) {
> >               cnt =3D vsc73xx_find_counter(vsc, indices[i], true);
> >               if (cnt)
> > -                     strncpy(data + j * ETH_GSTRING_LEN,
> > -                             cnt->name, ETH_GSTRING_LEN);
> > -             j++;
> > +                     ethtool_sprintf(&buf, "%s", cnt->name);
> >       }
> >  }
> >
> >
> > ---
> > base-commit: cbf3a2cb156a2c911d8f38d8247814b4c07f49a2
> > change-id: 20231009-strncpy-drivers-net-dsa-vitesse-vsc73xx-core-c-1cfd=
0ac2d81b
> >
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >
>

Thanks
Justin

