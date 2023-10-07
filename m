Return-Path: <netdev+bounces-38752-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C7A7BC57B
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 09:19:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BF81281D4A
	for <lists+netdev@lfdr.de>; Sat,  7 Oct 2023 07:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9FBF507;
	Sat,  7 Oct 2023 07:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=umich.edu header.i=@umich.edu header.b="pdAJcPai"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0329679D2
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 07:19:35 +0000 (UTC)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26777BD
	for <netdev@vger.kernel.org>; Sat,  7 Oct 2023 00:19:33 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-d862533ea85so3334709276.0
        for <netdev@vger.kernel.org>; Sat, 07 Oct 2023 00:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03; t=1696663172; x=1697267972; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WtrPmYOKGR0UXv+Z4lGb8ax2K62Yq7ToL0FjOLnOMOw=;
        b=pdAJcPaiHO3CDXzPqNZYfI3/+0T0mpCxENb1VPzpzrZ9OnAdUbKD91XJJ2H+NDKBEN
         rQXQhCoJtN6r4F/5xvzOX422jaMw3H7LGFM2LGAX2VU+gHgwFV/32cQ8IF7ZOBEiemV0
         PA63T7Eia5NwrqL6TIx/iShGVZbIwgKYxrGEtxFQLHrJO12cGDUn5SVYuOT1WF8ebxzX
         2h4nch+WsGNmhPdIygRYBUopK0/88gmOKJoWahSliqBCdyoXNms1sV+1EJmX/SZQr+Qp
         Jo9+iDCsAa7csD3PI3suUkVZKAblFo09jC+cpx+A8Ct6iI54AU7L1/9BC4O2QCna6G9v
         PvvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696663172; x=1697267972;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WtrPmYOKGR0UXv+Z4lGb8ax2K62Yq7ToL0FjOLnOMOw=;
        b=hIlxIGnmVEfJdmQ65ehnRqTvbd+E2RLf9UP4+BR26EcvwBVbhMs9RRDccP8MMASAVf
         hy4H0EbUOadgf5JEcGaqTw1pLoW93FOhtRjD4OSd4bb1UEVQORMazE3Yk6U25J2zhINb
         uwd6kZzbWlFl4OSn01iJS/kMJD7pCpdqPgj9nINxQ/LBWHmTjrJG98ETjJt+JZ7Yl9AG
         6ygzq12aMEPVXWcKPwJtz9eHvKip7+D5gnlyav5CgzzbHuKtfeWleitevb7osHuJk86n
         0YO/FGldiWa8ppLKeJyKXelPPva6RqAkPK7E+KFM9rOov6c/cKvUahIMqnOv+C3FD1pn
         6aSw==
X-Gm-Message-State: AOJu0YzKq2ypDYkHJKK5y8W7wl/kzq95Iyonwv7UT1e8sqrBZ191O5cN
	NW9NNYaFcgvdb6fubRxAKSnf02T5IqwW3SV5nhazlQ==
X-Google-Smtp-Source: AGHT+IEL6aPPa2Kk3pC8haZBn3D1JU9D/HZfdmMyk8WJN3fLkBiCGhMXlFxWyA29fOzIEfZ0+mHcrKDcLEE2N9FLcPA=
X-Received: by 2002:a25:d7cd:0:b0:d86:56e1:7a36 with SMTP id
 o196-20020a25d7cd000000b00d8656e17a36mr10631283ybg.56.1696663172222; Sat, 07
 Oct 2023 00:19:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231006094911.3305152-1-fujita.tomonori@gmail.com> <20231006094911.3305152-4-fujita.tomonori@gmail.com>
In-Reply-To: <20231006094911.3305152-4-fujita.tomonori@gmail.com>
From: Trevor Gross <tmgross@umich.edu>
Date: Sat, 7 Oct 2023 03:19:20 -0400
Message-ID: <CALNs47syMxiZBUwKLk3vKxzmCbX0FS5A37FjwUzZO9Fn-iPaoA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] net: phy: add Rust Asix PHY driver
To: FUJITA Tomonori <fujita.tomonori@gmail.com>
Cc: netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, andrew@lunn.ch, 
	miguel.ojeda.sandonis@gmail.com, greg@kroah.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 6, 2023 at 5:49=E2=80=AFAM FUJITA Tomonori
<fujita.tomonori@gmail.com> wrote:

> diff --git a/drivers/net/phy/ax88796b_rust.rs b/drivers/net/phy/ax88796b_=
rust.rs
> new file mode 100644
> index 000000000000..d11c82a9e847
> --- /dev/null
> +++ b/drivers/net/phy/ax88796b_rust.rs

Maybe want to link to the C version, just for the crossref?

> +    fn read_status(dev: &mut phy::Device) -> Result<u16> {
> +        dev.genphy_update_link()?;
> +        if !dev.get_link() {
> +            return Ok(0);
> +        }

Looking at this usage, I think `get_link()` should be renamed to just
`link()`. `get_link` makes me think that it is performing an action
like calling `genphy_update_link`, just `link()` sounds more like a
static accessor.

Or maybe it's worth replacing `get_link` with a `get_updated_link`
that calls `genphy_update_link` and then returns `link`, the user can
store it if they need to reuse it. This seems somewhat less accident
prone than someone calling `.link()`/`.get_link()` repeatedly and
wondering why their phy isn't coming up.

In any case, please make the docs clear about what behavior is
executed and what the preconditions are, it should be clear what's
going to wait for the bus vs. simple field access.

> +        if ret as u32 & uapi::BMCR_SPEED100 !=3D 0 {
> +            dev.set_speed(100);
> +        } else {
> +            dev.set_speed(10);
> +        }

Speed should probably actually be an enum since it has defined values.
Something like

    #[non_exhaustive]
    enum Speed {
        Speed10M,
        Speed100M,
        Speed1000M,
        // 2.5G, 5G, 10G, 25G?
    }

    impl Speed {
        fn as_mb(self) -> u32;
    }


> +        let duplex =3D if ret as u32 & uapi::BMCR_FULLDPLX !=3D 0 {
> +            phy::DuplexMode::Full
> +        } else {
> +            phy::DuplexMode::Half
> +        };

BMCR_x and MII_x are generated as `u32` but that's just a bindgen
thing. It seems we should reexport them as the correct types so users
don't need to cast all over:

    pub MII_BMCR: u8 =3D bindings::MII_BMCR as u8;
    pub BMCR_RESV: u16 =3D bindings::BMCR_RESV as u16; ...
    // (I'd just make a macro for this)

But I'm not sure how to handle that since the uapi crate exposes its
bindings directly. We're probably going to run into this issue with
other uapi items at some point, any thoughts Miguel?

> +        dev.genphy_read_lpa()?;

Same question as with the `genphy_update_link`

> +    fn link_change_notify(dev: &mut phy::Device) {
> +        // Reset PHY, otherwise MII_LPA will provide outdated informatio=
n.
> +        // This issue is reproducible only with some link partner PHYs.
> +        if dev.state() =3D=3D phy::DeviceState::NoLink {
> +            let _ =3D dev.init_hw();
> +            let _ =3D dev.start_aneg();
> +        }
> +    }
> +}

Is it worth doing anything with these errors? I know that the C driver does=
n't.

---

The overall driver looks correct to me, most of these comments are
actually about [1/3]

- Trevor

[1]: https://lore.kernel.org/rust-for-linux/baa4cc4b-bcde-4b02-9286-c923404=
db972@lunn.ch/

