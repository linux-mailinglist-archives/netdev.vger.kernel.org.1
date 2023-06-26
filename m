Return-Path: <netdev+bounces-13854-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E63473D655
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 05:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FDD9280DBF
	for <lists+netdev@lfdr.de>; Mon, 26 Jun 2023 03:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B16EA3D;
	Mon, 26 Jun 2023 03:34:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2760E7F
	for <netdev@vger.kernel.org>; Mon, 26 Jun 2023 03:34:04 +0000 (UTC)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B33411C
	for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 20:34:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4fb7373dd35so921899e87.1
        for <netdev@vger.kernel.org>; Sun, 25 Jun 2023 20:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1687750440; x=1690342440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=kEG/nz/2R/fnkVKgDuD0F6VbT/ihlAJtFn/3UHmwi0o=;
        b=ChYHXvGeuTU8bTi00TZ/r2yTEV+l+57oxHGuQ1CNuBGkz7asAujqXsgcCU4mNA3U1o
         YOz08IJWSemJ+oHytvkxRwgakLp4rcQ1BxJdB6BkA/9Lso1ySiRjRjuqI75Iii23gbNE
         ZonpmX9pymPaWPK7vht/YSxpTokCmlF1hrM34=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687750440; x=1690342440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kEG/nz/2R/fnkVKgDuD0F6VbT/ihlAJtFn/3UHmwi0o=;
        b=PNqp7gtouWqrx7bJtZ3p/pDJHOqXmFV4nSnpQ9Q2u5y5FZfODSf+4gxZoElHOw2iqG
         WzOFlXMRM6M2MJzT4sXWxkAIUkbKV1HftKVzRd5ZbtVTWZjGcvAp0/3rQO55Jm+GXBPq
         CJYIBLkvY+sAPLp7mTLIxKi5jJJrKJvZPuwb4FPxR3bHCF0Jo87sUINMiYejWrAsYFU9
         iklTolagEfWdkXq0Ro6run79mMkMb3aZGVo2T8l0R8eP7PdmwY6XbiHj0Au3moHZQC9C
         joQ3+GjZNr+hrW3LQpSaD207GArI7Q7IquDtfHSqcUB8GCTBO1oilptGaj7TyVnSn6hg
         S2Rw==
X-Gm-Message-State: AC+VfDzw8L370cwckXsaw91dgxL9XSHlUmODnyISDGx7OpUjq8eijACz
	M/68LgVrEC2CGsMA3gwM5Ei9aL4ybT1qwuBz01z47g==
X-Google-Smtp-Source: ACHHUZ4sy/PS5EpGuK5jxR3+nicgo3TSckB61ZaPNrPkX8ICLbRl9YlhcfJfjm6ht5DiBLSIrH3ulh6GZqzZeDb08w8=
X-Received: by 2002:a05:6512:3b8c:b0:4f8:6b98:f4dd with SMTP id
 g12-20020a0565123b8c00b004f86b98f4ddmr7234685lfv.32.1687750440132; Sun, 25
 Jun 2023 20:34:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230624205629.4158216-1-andrew@lunn.ch> <20230624205629.4158216-4-andrew@lunn.ch>
In-Reply-To: <20230624205629.4158216-4-andrew@lunn.ch>
From: Kalesh Anakkur Purayil <kalesh-anakkur.purayil@broadcom.com>
Date: Mon, 26 Jun 2023 09:03:47 +0530
Message-ID: <CAH-L+nP7yn5eUBdGWenFNFYctzmebAWX+PgAVk33e=FHiU_Xig@mail.gmail.com>
Subject: Re: [PATCH v2 net-next 3/3] net: phy: marvell: Add support for
 offloading LED blinking
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev <netdev@vger.kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <rmk+kernel@armlinux.org.uk>, Simon Horman <simon.horman@corigine.com>, 
	Christian Marangi <ansuelsmth@gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000007d7e9505ff00054b"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HTML_MESSAGE,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--0000000000007d7e9505ff00054b
Content-Type: multipart/alternative; boundary="00000000000074a2ce05ff000583"

--00000000000074a2ce05ff000583
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jun 25, 2023 at 2:27=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:

> Add the code needed to indicate if a given blinking pattern can be
> offloaded, to offload a pattern and to try to return the current
> pattern. It is expected that ledtrig-netdev will gain support for
> other patterns, such as different link speeds etc. So the code is
> over-engineers to make adding such additional patterns easy.
>
> Reviewed-by: Simon Horman <simon.horman@corigine.com>
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  drivers/net/phy/marvell.c | 243 ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 243 insertions(+)
>
> diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
> index 43b6cb725551..a443df3034f3 100644
> --- a/drivers/net/phy/marvell.c
> +++ b/drivers/net/phy/marvell.c
> @@ -2893,6 +2893,234 @@ static int m88e1318_led_blink_set(struct
> phy_device *phydev, u8 index,
>                                MII_88E1318S_PHY_LED_FUNC, reg);
>  }
>
> +struct marvell_led_rules {
> +       int mode;
> +       unsigned long rules;
> +};
> +
> +static const struct marvell_led_rules marvell_led0[] =3D {
> +       {
> +               .mode =3D 0,
> +               .rules =3D BIT(TRIGGER_NETDEV_LINK),
> +       },
> +       {
> +               .mode =3D 3,
> +               .rules =3D (BIT(TRIGGER_NETDEV_RX) |
> +                         BIT(TRIGGER_NETDEV_TX)),
> +       },
> +       {
> +               .mode =3D 4,
> +               .rules =3D (BIT(TRIGGER_NETDEV_RX) |
> +                         BIT(TRIGGER_NETDEV_TX)),
> +       },
> +       {
> +               .mode =3D 5,
> +               .rules =3D BIT(TRIGGER_NETDEV_TX),
> +       },
> +       {
> +               .mode =3D 8,
> +               .rules =3D 0,
> +       },
> +};
> +
> +static const struct marvell_led_rules marvell_led1[] =3D {
> +       {
> +               .mode =3D 1,
> +               .rules =3D (BIT(TRIGGER_NETDEV_LINK) |
> +                         BIT(TRIGGER_NETDEV_RX) |
> +                         BIT(TRIGGER_NETDEV_TX)),
> +       },
> +       {
> +               .mode =3D 2,
> +               .rules =3D (BIT(TRIGGER_NETDEV_LINK) |
> +                         BIT(TRIGGER_NETDEV_RX)),
> +       },
> +       {
> +               .mode =3D 3,
> +               .rules =3D (BIT(TRIGGER_NETDEV_RX) |
> +                         BIT(TRIGGER_NETDEV_TX)),
> +       },
> +       {
> +               .mode =3D 4,
> +               .rules =3D (BIT(TRIGGER_NETDEV_RX) |
> +                         BIT(TRIGGER_NETDEV_TX)),
> +       },
> +       {
> +               .mode =3D 8,
> +               .rules =3D 0,
> +       },
> +};
> +
> +static const struct marvell_led_rules marvell_led2[] =3D {
> +       {
> +               .mode =3D 0,
> +               .rules =3D BIT(TRIGGER_NETDEV_LINK),
> +       },
> +       {
> +               .mode =3D 1,
> +               .rules =3D (BIT(TRIGGER_NETDEV_LINK) |
> +                         BIT(TRIGGER_NETDEV_RX) |
> +                         BIT(TRIGGER_NETDEV_TX)),
> +       },
> +       {
> +               .mode =3D 3,
> +               .rules =3D (BIT(TRIGGER_NETDEV_RX) |
> +                         BIT(TRIGGER_NETDEV_TX)),
> +       },
> +       {
> +               .mode =3D 4,
> +               .rules =3D (BIT(TRIGGER_NETDEV_RX) |
> +                         BIT(TRIGGER_NETDEV_TX)),
> +       },
> +       {
> +               .mode =3D 5,
> +               .rules =3D BIT(TRIGGER_NETDEV_TX),
> +       },
> +       {
> +               .mode =3D 8,
> +               .rules =3D 0,
> +       },
> +};
> +
> +static int marvell_find_led_mode(unsigned long rules,
> +                                const struct marvell_led_rules
> *marvell_rules,
> +                                int count,
> +                                int *mode)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < count; i++) {
> +               if (marvell_rules[i].rules =3D=3D rules) {
> +                       *mode =3D marvell_rules[i].mode;
> +                       return 0;
> +               }
> +       }
> +       return -EOPNOTSUPP;
> +}
> +
> +static int marvell_get_led_mode(u8 index, unsigned long rules, int *mode=
)
> +{
> +       int ret;
> +
> +       switch (index) {
> +       case 0:
> +               ret =3D marvell_find_led_mode(rules, marvell_led0,
> +                                           ARRAY_SIZE(marvell_led0),
> mode);
> +               break;
>
[Kalesh]: If you return directly from here, you can avoid the "return ret;"
at the end of this function. Also, it will make other cases in sync with
the default one.

> +       case 1:
> +               ret =3D marvell_find_led_mode(rules, marvell_led1,
> +                                           ARRAY_SIZE(marvell_led1),
> mode);
> +               break;
> +       case 2:
> +               ret =3D marvell_find_led_mode(rules, marvell_led2,
> +                                           ARRAY_SIZE(marvell_led2),
> mode);
> +               break;
> +       default:
> +               return -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static int marvell_find_led_rules(unsigned long *rules,
> +                                 const struct marvell_led_rules
> *marvell_rules,
> +                                 int count,
> +                                 int mode)
> +{
> +       int i;
> +
> +       for (i =3D 0; i < count; i++) {
> +               if (marvell_rules[i].mode =3D=3D mode) {
> +                       *rules =3D marvell_rules[i].rules;
> +                       return 0;
> +               }
> +       }
> +       return -EOPNOTSUPP;
> +}
> +
> +static int marvell_get_led_rules(u8 index, unsigned long *rules, int mod=
e)
> +{
> +       int ret;
> +
> +       switch (index) {
> +       case 0:
> +               ret =3D marvell_find_led_rules(rules, marvell_led0,
> +                                            ARRAY_SIZE(marvell_led0),
> mode);
> +               break;
> +       case 1:
> +               ret =3D marvell_find_led_rules(rules, marvell_led1,
> +                                            ARRAY_SIZE(marvell_led1),
> mode);
> +               break;
> +       case 2:
> +               ret =3D marvell_find_led_rules(rules, marvell_led2,
> +                                            ARRAY_SIZE(marvell_led2),
> mode);
> +               break;
> +       default:
> +               return -EOPNOTSUPP;
> +       }
> +
> +       return ret;
> +}
> +
> +static int m88e1318_led_hw_is_supported(struct phy_device *phydev, u8
> index,
> +                                       unsigned long rules)
> +{
> +       int mode, ret;
> +
> +       switch (index) {
> +       case 0:
> +       case 1:
> +       case 2:
> +               ret =3D marvell_get_led_mode(index, rules, &mode);
> +               break;
> +       default:
> +               ret =3D -EINVAL;
> +       }
> +
> +       return ret;
> +}
> +
> +static int m88e1318_led_hw_control_set(struct phy_device *phydev, u8
> index,
> +                                      unsigned long rules)
> +{
> +       int mode, ret, reg;
> +
> +       switch (index) {
> +       case 0:
> +       case 1:
> +       case 2:
> +               ret =3D marvell_get_led_mode(index, rules, &mode);
> +               break;
> +       default:
> +               ret =3D -EINVAL;
> +       }
> +
> +       if (ret < 0)
> +               return ret;
> +
> +       reg =3D phy_read_paged(phydev, MII_MARVELL_LED_PAGE,
> +                            MII_88E1318S_PHY_LED_FUNC);
>
[Kalesh]: Don't you need a check here for "reg  < 0"?

> +       reg &=3D ~(0xf << (4 * index));
> +       reg |=3D mode << (4 * index);
> +       return phy_write_paged(phydev, MII_MARVELL_LED_PAGE,
> +                              MII_88E1318S_PHY_LED_FUNC, reg);
> +}
> +
> +static int m88e1318_led_hw_control_get(struct phy_device *phydev, u8
> index,
> +                                      unsigned long *rules)
> +{
> +       int mode, reg;
> +
> +       if (index > 2)
> +               return -EINVAL;
> +
> +       reg =3D phy_read_paged(phydev, MII_MARVELL_LED_PAGE,
> +                            MII_88E1318S_PHY_LED_FUNC);
> +       mode =3D (reg >> (4 * index)) & 0xf;
> +
> +       return marvell_get_led_rules(index, rules, mode);
> +}
> +
>  static int marvell_probe(struct phy_device *phydev)
>  {
>         struct marvell_priv *priv;
> @@ -3144,6 +3372,9 @@ static struct phy_driver marvell_drivers[] =3D {
>                 .get_stats =3D marvell_get_stats,
>                 .led_brightness_set =3D m88e1318_led_brightness_set,
>                 .led_blink_set =3D m88e1318_led_blink_set,
> +               .led_hw_is_supported =3D m88e1318_led_hw_is_supported,
> +               .led_hw_control_set =3D m88e1318_led_hw_control_set,
> +               .led_hw_control_get =3D m88e1318_led_hw_control_get,
>         },
>         {
>                 .phy_id =3D MARVELL_PHY_ID_88E1145,
> @@ -3252,6 +3483,9 @@ static struct phy_driver marvell_drivers[] =3D {
>                 .cable_test_get_status =3D
> marvell_vct7_cable_test_get_status,
>                 .led_brightness_set =3D m88e1318_led_brightness_set,
>                 .led_blink_set =3D m88e1318_led_blink_set,
> +               .led_hw_is_supported =3D m88e1318_led_hw_is_supported,
> +               .led_hw_control_set =3D m88e1318_led_hw_control_set,
> +               .led_hw_control_get =3D m88e1318_led_hw_control_get,
>         },
>         {
>                 .phy_id =3D MARVELL_PHY_ID_88E1540,
> @@ -3280,6 +3514,9 @@ static struct phy_driver marvell_drivers[] =3D {
>                 .cable_test_get_status =3D
> marvell_vct7_cable_test_get_status,
>                 .led_brightness_set =3D m88e1318_led_brightness_set,
>                 .led_blink_set =3D m88e1318_led_blink_set,
> +               .led_hw_is_supported =3D m88e1318_led_hw_is_supported,
> +               .led_hw_control_set =3D m88e1318_led_hw_control_set,
> +               .led_hw_control_get =3D m88e1318_led_hw_control_get,
>         },
>         {
>                 .phy_id =3D MARVELL_PHY_ID_88E1545,
> @@ -3308,6 +3545,9 @@ static struct phy_driver marvell_drivers[] =3D {
>                 .cable_test_get_status =3D
> marvell_vct7_cable_test_get_status,
>                 .led_brightness_set =3D m88e1318_led_brightness_set,
>                 .led_blink_set =3D m88e1318_led_blink_set,
> +               .led_hw_is_supported =3D m88e1318_led_hw_is_supported,
> +               .led_hw_control_set =3D m88e1318_led_hw_control_set,
> +               .led_hw_control_get =3D m88e1318_led_hw_control_get,
>         },
>         {
>                 .phy_id =3D MARVELL_PHY_ID_88E3016,
> @@ -3451,6 +3691,9 @@ static struct phy_driver marvell_drivers[] =3D {
>                 .set_tunable =3D m88e1540_set_tunable,
>                 .led_brightness_set =3D m88e1318_led_brightness_set,
>                 .led_blink_set =3D m88e1318_led_blink_set,
> +               .led_hw_is_supported =3D m88e1318_led_hw_is_supported,
> +               .led_hw_control_set =3D m88e1318_led_hw_control_set,
> +               .led_hw_control_get =3D m88e1318_led_hw_control_get,
>         },
>  };
>
> --
> 2.40.1
>
>
>

--=20
Regards,
Kalesh A P

--00000000000074a2ce05ff000583
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdiBkaXI9Imx0ciI+PGJyPjwvZGl2Pjxicj48ZGl2IGNsYXNzPSJn
bWFpbF9xdW90ZSI+PGRpdiBkaXI9Imx0ciIgY2xhc3M9ImdtYWlsX2F0dHIiPk9uIFN1biwgSnVu
IDI1LCAyMDIzIGF0IDI6MjfigK9BTSBBbmRyZXcgTHVubiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmFu
ZHJld0BsdW5uLmNoIj5hbmRyZXdAbHVubi5jaDwvYT4mZ3Q7IHdyb3RlOjxicj48L2Rpdj48Ymxv
Y2txdW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44
ZXg7Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFl
eCI+QWRkIHRoZSBjb2RlIG5lZWRlZCB0byBpbmRpY2F0ZSBpZiBhIGdpdmVuIGJsaW5raW5nIHBh
dHRlcm4gY2FuIGJlPGJyPg0Kb2ZmbG9hZGVkLCB0byBvZmZsb2FkIGEgcGF0dGVybiBhbmQgdG8g
dHJ5IHRvIHJldHVybiB0aGUgY3VycmVudDxicj4NCnBhdHRlcm4uIEl0IGlzIGV4cGVjdGVkIHRo
YXQgbGVkdHJpZy1uZXRkZXYgd2lsbCBnYWluIHN1cHBvcnQgZm9yPGJyPg0Kb3RoZXIgcGF0dGVy
bnMsIHN1Y2ggYXMgZGlmZmVyZW50IGxpbmsgc3BlZWRzIGV0Yy4gU28gdGhlIGNvZGUgaXM8YnI+
DQpvdmVyLWVuZ2luZWVycyB0byBtYWtlIGFkZGluZyBzdWNoIGFkZGl0aW9uYWwgcGF0dGVybnMg
ZWFzeS48YnI+DQo8YnI+DQpSZXZpZXdlZC1ieTogU2ltb24gSG9ybWFuICZsdDs8YSBocmVmPSJt
YWlsdG86c2ltb24uaG9ybWFuQGNvcmlnaW5lLmNvbSIgdGFyZ2V0PSJfYmxhbmsiPnNpbW9uLmhv
cm1hbkBjb3JpZ2luZS5jb208L2E+Jmd0Ozxicj4NClNpZ25lZC1vZmYtYnk6IEFuZHJldyBMdW5u
ICZsdDs8YSBocmVmPSJtYWlsdG86YW5kcmV3QGx1bm4uY2giIHRhcmdldD0iX2JsYW5rIj5hbmRy
ZXdAbHVubi5jaDwvYT4mZ3Q7PGJyPg0KLS0tPGJyPg0KwqBkcml2ZXJzL25ldC9waHkvbWFydmVs
bC5jIHwgMjQzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrPGJyPg0KwqAx
IGZpbGUgY2hhbmdlZCwgMjQzIGluc2VydGlvbnMoKyk8YnI+DQo8YnI+DQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9uZXQvcGh5L21hcnZlbGwuYyBiL2RyaXZlcnMvbmV0L3BoeS9tYXJ2ZWxsLmM8YnI+
DQppbmRleCA0M2I2Y2I3MjU1NTEuLmE0NDNkZjMwMzRmMyAxMDA2NDQ8YnI+DQotLS0gYS9kcml2
ZXJzL25ldC9waHkvbWFydmVsbC5jPGJyPg0KKysrIGIvZHJpdmVycy9uZXQvcGh5L21hcnZlbGwu
Yzxicj4NCkBAIC0yODkzLDYgKzI4OTMsMjM0IEBAIHN0YXRpYyBpbnQgbTg4ZTEzMThfbGVkX2Js
aW5rX3NldChzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LCB1OCBpbmRleCw8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoE1JSV84OEUxMzE4U19QSFlf
TEVEX0ZVTkMsIHJlZyk7PGJyPg0KwqB9PGJyPg0KPGJyPg0KK3N0cnVjdCBtYXJ2ZWxsX2xlZF9y
dWxlcyB7PGJyPg0KK8KgIMKgIMKgIMKgaW50IG1vZGU7PGJyPg0KK8KgIMKgIMKgIMKgdW5zaWdu
ZWQgbG9uZyBydWxlczs8YnI+DQorfTs8YnI+DQorPGJyPg0KK3N0YXRpYyBjb25zdCBzdHJ1Y3Qg
bWFydmVsbF9sZWRfcnVsZXMgbWFydmVsbF9sZWQwW10gPSB7PGJyPg0KK8KgIMKgIMKgIMKgezxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5tb2RlID0gMCw8YnI+DQorwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAucnVsZXMgPSBCSVQoVFJJR0dFUl9ORVRERVZfTElOSyksPGJyPg0KK8KgIMKg
IMKgIMKgfSw8YnI+DQorwqAgwqAgwqAgwqB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
Lm1vZGUgPSAzLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5ydWxlcyA9IChCSVQoVFJJ
R0dFUl9ORVRERVZfUlgpIHw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBCSVQoVFJJR0dFUl9ORVRERVZfVFgpKSw8YnI+DQorwqAgwqAgwqAgwqB9LDxicj4NCivC
oCDCoCDCoCDCoHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubW9kZSA9IDQsPGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLnJ1bGVzID0gKEJJVChUUklHR0VSX05FVERFVl9SWCkg
fDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEJJVChUUklHR0VS
X05FVERFVl9UWCkpLDxicj4NCivCoCDCoCDCoCDCoH0sPGJyPg0KK8KgIMKgIMKgIMKgezxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5tb2RlID0gNSw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAucnVsZXMgPSBCSVQoVFJJR0dFUl9ORVRERVZfVFgpLDxicj4NCivCoCDCoCDCoCDC
oH0sPGJyPg0KK8KgIMKgIMKgIMKgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5tb2Rl
ID0gOCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAucnVsZXMgPSAwLDxicj4NCivCoCDC
oCDCoCDCoH0sPGJyPg0KK307PGJyPg0KKzxicj4NCitzdGF0aWMgY29uc3Qgc3RydWN0IG1hcnZl
bGxfbGVkX3J1bGVzIG1hcnZlbGxfbGVkMVtdID0gezxicj4NCivCoCDCoCDCoCDCoHs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubW9kZSA9IDEsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgLnJ1bGVzID0gKEJJVChUUklHR0VSX05FVERFVl9MSU5LKSB8PGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQklUKFRSSUdHRVJfTkVUREVWX1JYKSB8PGJy
Pg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQklUKFRSSUdHRVJfTkVU
REVWX1RYKSksPGJyPg0KK8KgIMKgIMKgIMKgfSw8YnI+DQorwqAgwqAgwqAgwqB7PGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgLm1vZGUgPSAyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoC5ydWxlcyA9IChCSVQoVFJJR0dFUl9ORVRERVZfTElOSykgfDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEJJVChUUklHR0VSX05FVERFVl9SWCkpLDxicj4N
CivCoCDCoCDCoCDCoH0sPGJyPg0KK8KgIMKgIMKgIMKgezxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoC5tb2RlID0gMyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAucnVsZXMgPSAo
QklUKFRSSUdHRVJfTkVUREVWX1JYKSB8PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgQklUKFRSSUdHRVJfTkVUREVWX1RYKSksPGJyPg0KK8KgIMKgIMKgIMKgfSw8
YnI+DQorwqAgwqAgwqAgwqB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLm1vZGUgPSA0
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5ydWxlcyA9IChCSVQoVFJJR0dFUl9ORVRE
RVZfUlgpIHw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBCSVQo
VFJJR0dFUl9ORVRERVZfVFgpKSw8YnI+DQorwqAgwqAgwqAgwqB9LDxicj4NCivCoCDCoCDCoCDC
oHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubW9kZSA9IDgsPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgLnJ1bGVzID0gMCw8YnI+DQorwqAgwqAgwqAgwqB9LDxicj4NCit9Ozxi
cj4NCis8YnI+DQorc3RhdGljIGNvbnN0IHN0cnVjdCBtYXJ2ZWxsX2xlZF9ydWxlcyBtYXJ2ZWxs
X2xlZDJbXSA9IHs8YnI+DQorwqAgwqAgwqAgwqB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgLm1vZGUgPSAwLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5ydWxlcyA9IEJJVChU
UklHR0VSX05FVERFVl9MSU5LKSw8YnI+DQorwqAgwqAgwqAgwqB9LDxicj4NCivCoCDCoCDCoCDC
oHs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubW9kZSA9IDEsPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgLnJ1bGVzID0gKEJJVChUUklHR0VSX05FVERFVl9MSU5LKSB8PGJyPg0K
K8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQklUKFRSSUdHRVJfTkVUREVW
X1JYKSB8PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQklUKFRS
SUdHRVJfTkVUREVWX1RYKSksPGJyPg0KK8KgIMKgIMKgIMKgfSw8YnI+DQorwqAgwqAgwqAgwqB7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLm1vZGUgPSAzLDxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoC5ydWxlcyA9IChCSVQoVFJJR0dFUl9ORVRERVZfUlgpIHw8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBCSVQoVFJJR0dFUl9ORVRERVZfVFgp
KSw8YnI+DQorwqAgwqAgwqAgwqB9LDxicj4NCivCoCDCoCDCoCDCoHs8YnI+DQorwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAubW9kZSA9IDQsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLnJ1
bGVzID0gKEJJVChUUklHR0VSX05FVERFVl9SWCkgfDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoEJJVChUUklHR0VSX05FVERFVl9UWCkpLDxicj4NCivCoCDCoCDC
oCDCoH0sPGJyPg0KK8KgIMKgIMKgIMKgezxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5t
b2RlID0gNSw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAucnVsZXMgPSBCSVQoVFJJR0dF
Ul9ORVRERVZfVFgpLDxicj4NCivCoCDCoCDCoCDCoH0sPGJyPg0KK8KgIMKgIMKgIMKgezxicj4N
CivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5tb2RlID0gOCw8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAucnVsZXMgPSAwLDxicj4NCivCoCDCoCDCoCDCoH0sPGJyPg0KK307PGJyPg0KKzxi
cj4NCitzdGF0aWMgaW50IG1hcnZlbGxfZmluZF9sZWRfbW9kZSh1bnNpZ25lZCBsb25nIHJ1bGVz
LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBj
b25zdCBzdHJ1Y3QgbWFydmVsbF9sZWRfcnVsZXMgKm1hcnZlbGxfcnVsZXMsPGJyPg0KK8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIGludCBjb3VudCw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgaW50ICpt
b2RlKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgaW50IGk7PGJyPg0KKzxicj4NCivCoCDCoCDC
oCDCoGZvciAoaSA9IDA7IGkgJmx0OyBjb3VudDsgaSsrKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgaWYgKG1hcnZlbGxfcnVsZXNbaV0ucnVsZXMgPT0gcnVsZXMpIHs8YnI+DQorwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAqbW9kZSA9IG1hcnZlbGxfcnVsZXNbaV0u
bW9kZTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gMDs8
YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB9PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCivC
oCDCoCDCoCDCoHJldHVybiAtRU9QTk9UU1VQUDs8YnI+DQorfTxicj4NCis8YnI+DQorc3RhdGlj
IGludCBtYXJ2ZWxsX2dldF9sZWRfbW9kZSh1OCBpbmRleCwgdW5zaWduZWQgbG9uZyBydWxlcywg
aW50ICptb2RlKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgaW50IHJldDs8YnI+DQorPGJyPg0K
K8KgIMKgIMKgIMKgc3dpdGNoIChpbmRleCkgezxicj4NCivCoCDCoCDCoCDCoGNhc2UgMDo8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXQgPSBtYXJ2ZWxsX2ZpbmRfbGVkX21vZGUocnVs
ZXMsIG1hcnZlbGxfbGVkMCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBBUlJBWV9TSVpFKG1hcnZlbGxfbGVkMCks
IG1vZGUpOzxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGJyZWFrOzxicj48L2Jsb2NrcXVv
dGU+PGRpdj5bS2FsZXNoXTogSWYgeW91IHJldHVybiBkaXJlY3RseSBmcm9tIGhlcmUsIHlvdSBj
YW4gYXZvaWQgdGhlICZxdW90O3JldHVybiByZXQ7JnF1b3Q7IGF0IHRoZSBlbmQgb2YgdGhpcyBm
dW5jdGlvbi4gQWxzbywgaXQgd2lsbCBtYWtlIG90aGVyIGNhc2VzIGluIHN5bmMgd2l0aCB0aGUg
ZGVmYXVsdCBvbmUuPC9kaXY+PGJsb2NrcXVvdGUgY2xhc3M9ImdtYWlsX3F1b3RlIiBzdHlsZT0i
bWFyZ2luOjBweCAwcHggMHB4IDAuOGV4O2JvcmRlci1sZWZ0OjFweCBzb2xpZCByZ2IoMjA0LDIw
NCwyMDQpO3BhZGRpbmctbGVmdDoxZXgiPg0KK8KgIMKgIMKgIMKgY2FzZSAxOjxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IG1hcnZlbGxfZmluZF9sZWRfbW9kZShydWxlcywgbWFy
dmVsbF9sZWQxLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEFSUkFZX1NJWkUobWFydmVsbF9sZWQxKSwgbW9kZSk7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgY2Fz
ZSAyOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IG1hcnZlbGxfZmluZF9sZWRf
bW9kZShydWxlcywgbWFydmVsbF9sZWQyLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoEFSUkFZX1NJWkUobWFydmVs
bF9sZWQyKSwgbW9kZSk7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0K
K8KgIMKgIMKgIMKgZGVmYXVsdDo8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4g
LUVJTlZBTDs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHJldHVy
biByZXQ7PGJyPg0KK308YnI+DQorPGJyPg0KK3N0YXRpYyBpbnQgbWFydmVsbF9maW5kX2xlZF9y
dWxlcyh1bnNpZ25lZCBsb25nICpydWxlcyw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBjb25zdCBzdHJ1Y3QgbWFydmVsbF9sZWRfcnVsZXMg
Km1hcnZlbGxfcnVsZXMsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaW50IGNvdW50LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGludCBtb2RlKTxicj4NCit7PGJyPg0KK8KgIMKgIMKg
IMKgaW50IGk7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGZvciAoaSA9IDA7IGkgJmx0OyBjb3Vu
dDsgaSsrKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKG1hcnZlbGxfcnVsZXNb
aV0ubW9kZSA9PSBtb2RlKSB7PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgKnJ1bGVzID0gbWFydmVsbF9ydWxlc1tpXS5ydWxlczs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gMDs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqB9PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCivCoCDCoCDCoCDCoHJldHVybiAtRU9QTk9UU1VQ
UDs8YnI+DQorfTxicj4NCis8YnI+DQorc3RhdGljIGludCBtYXJ2ZWxsX2dldF9sZWRfcnVsZXMo
dTggaW5kZXgsIHVuc2lnbmVkIGxvbmcgKnJ1bGVzLCBpbnQgbW9kZSk8YnI+DQorezxicj4NCivC
oCDCoCDCoCDCoGludCByZXQ7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoHN3aXRjaCAoaW5kZXgp
IHs8YnI+DQorwqAgwqAgwqAgwqBjYXNlIDA6PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
cmV0ID0gbWFydmVsbF9maW5kX2xlZF9ydWxlcyhydWxlcywgbWFydmVsbF9sZWQwLDxicj4NCivC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCBBUlJBWV9TSVpFKG1hcnZlbGxfbGVkMCksIG1vZGUpOzxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoGJyZWFrOzxicj4NCivCoCDCoCDCoCDCoGNhc2UgMTo8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXQgPSBtYXJ2ZWxsX2ZpbmRfbGVkX3J1bGVzKHJ1bGVzLCBtYXJ2
ZWxsX2xlZDEsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIEFSUkFZX1NJWkUobWFydmVsbF9sZWQxKSwgbW9kZSk7
PGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYnJlYWs7PGJyPg0KK8KgIMKgIMKgIMKgY2Fz
ZSAyOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IG1hcnZlbGxfZmluZF9sZWRf
cnVsZXMocnVsZXMsIG1hcnZlbGxfbGVkMiw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgQVJSQVlfU0laRShtYXJ2
ZWxsX2xlZDIpLCBtb2RlKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+
DQorwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldHVy
biAtRU9QTk9UU1VQUDs8YnI+DQorwqAgwqAgwqAgwqB9PGJyPg0KKzxicj4NCivCoCDCoCDCoCDC
oHJldHVybiByZXQ7PGJyPg0KK308YnI+DQorPGJyPg0KK3N0YXRpYyBpbnQgbTg4ZTEzMThfbGVk
X2h3X2lzX3N1cHBvcnRlZChzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LCB1OCBpbmRleCw8YnI+
DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB1bnNpZ25lZCBsb25nIHJ1bGVzKTxicj4NCit7PGJyPg0KK8KgIMKgIMKgIMKgaW50IG1v
ZGUsIHJldDs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgc3dpdGNoIChpbmRleCkgezxicj4NCivC
oCDCoCDCoCDCoGNhc2UgMDo8YnI+DQorwqAgwqAgwqAgwqBjYXNlIDE6PGJyPg0KK8KgIMKgIMKg
IMKgY2FzZSAyOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IG1hcnZlbGxfZ2V0
X2xlZF9tb2RlKGluZGV4LCBydWxlcywgJmFtcDttb2RlKTs8YnI+DQorwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBkZWZhdWx0Ojxicj4NCivCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJldCA9IC1FSU5WQUw7PGJyPg0KK8KgIMKgIMKgIMKgfTxicj4NCis8YnI+
DQorwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCit9PGJyPg0KKzxicj4NCitzdGF0aWMgaW50
IG04OGUxMzE4X2xlZF9od19jb250cm9sX3NldChzdHJ1Y3QgcGh5X2RldmljZSAqcGh5ZGV2LCB1
OCBpbmRleCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgdW5zaWduZWQgbG9uZyBydWxlcyk8YnI+DQorezxicj4NCivCoCDCoCDC
oCDCoGludCBtb2RlLCByZXQsIHJlZzs8YnI+DQorPGJyPg0KK8KgIMKgIMKgIMKgc3dpdGNoIChp
bmRleCkgezxicj4NCivCoCDCoCDCoCDCoGNhc2UgMDo8YnI+DQorwqAgwqAgwqAgwqBjYXNlIDE6
PGJyPg0KK8KgIMKgIMKgIMKgY2FzZSAyOjxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJl
dCA9IG1hcnZlbGxfZ2V0X2xlZF9tb2RlKGluZGV4LCBydWxlcywgJmFtcDttb2RlKTs8YnI+DQor
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBicmVhazs8YnI+DQorwqAgwqAgwqAgwqBkZWZhdWx0Ojxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHJldCA9IC1FSU5WQUw7PGJyPg0KK8KgIMKgIMKg
IMKgfTxicj4NCis8YnI+DQorwqAgwqAgwqAgwqBpZiAocmV0ICZsdDsgMCk8YnI+DQorwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqByZXR1cm4gcmV0Ozxicj4NCis8YnI+DQorwqAgwqAgwqAgwqByZWcg
PSBwaHlfcmVhZF9wYWdlZChwaHlkZXYsIE1JSV9NQVJWRUxMX0xFRF9QQUdFLDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCBNSUlfODhFMTMxOFNfUEhZX0xF
RF9GVU5DKTs8YnI+PC9ibG9ja3F1b3RlPjxkaXY+W0thbGVzaF06IERvbiYjMzk7dCB5b3UgbmVl
ZCBhIGNoZWNrIGhlcmUgZm9yICZxdW90O3JlZ8KgICZsdDsgMCZxdW90Oz88L2Rpdj48YmxvY2tx
dW90ZSBjbGFzcz0iZ21haWxfcXVvdGUiIHN0eWxlPSJtYXJnaW46MHB4IDBweCAwcHggMC44ZXg7
Ym9yZGVyLWxlZnQ6MXB4IHNvbGlkIHJnYigyMDQsMjA0LDIwNCk7cGFkZGluZy1sZWZ0OjFleCI+
DQorwqAgwqAgwqAgwqByZWcgJmFtcDs9IH4oMHhmICZsdDsmbHQ7ICg0ICogaW5kZXgpKTs8YnI+
DQorwqAgwqAgwqAgwqByZWcgfD0gbW9kZSAmbHQ7Jmx0OyAoNCAqIGluZGV4KTs8YnI+DQorwqAg
wqAgwqAgwqByZXR1cm4gcGh5X3dyaXRlX3BhZ2VkKHBoeWRldiwgTUlJX01BUlZFTExfTEVEX1BB
R0UsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIE1J
SV84OEUxMzE4U19QSFlfTEVEX0ZVTkMsIHJlZyk7PGJyPg0KK308YnI+DQorPGJyPg0KK3N0YXRp
YyBpbnQgbTg4ZTEzMThfbGVkX2h3X2NvbnRyb2xfZ2V0KHN0cnVjdCBwaHlfZGV2aWNlICpwaHlk
ZXYsIHU4IGluZGV4LDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCB1bnNpZ25lZCBsb25nICpydWxlcyk8YnI+DQorezxicj4NCivC
oCDCoCDCoCDCoGludCBtb2RlLCByZWc7PGJyPg0KKzxicj4NCivCoCDCoCDCoCDCoGlmIChpbmRl
eCAmZ3Q7IDIpPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgcmV0dXJuIC1FSU5WQUw7PGJy
Pg0KKzxicj4NCivCoCDCoCDCoCDCoHJlZyA9IHBoeV9yZWFkX3BhZ2VkKHBoeWRldiwgTUlJX01B
UlZFTExfTEVEX1BBR0UsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIE1JSV84OEUxMzE4U19QSFlfTEVEX0ZVTkMpOzxicj4NCivCoCDCoCDCoCDCoG1vZGUg
PSAocmVnICZndDsmZ3Q7ICg0ICogaW5kZXgpKSAmYW1wOyAweGY7PGJyPg0KKzxicj4NCivCoCDC
oCDCoCDCoHJldHVybiBtYXJ2ZWxsX2dldF9sZWRfcnVsZXMoaW5kZXgsIHJ1bGVzLCBtb2RlKTs8
YnI+DQorfTxicj4NCis8YnI+DQrCoHN0YXRpYyBpbnQgbWFydmVsbF9wcm9iZShzdHJ1Y3QgcGh5
X2RldmljZSAqcGh5ZGV2KTxicj4NCsKgezxicj4NCsKgIMKgIMKgIMKgIHN0cnVjdCBtYXJ2ZWxs
X3ByaXYgKnByaXY7PGJyPg0KQEAgLTMxNDQsNiArMzM3Miw5IEBAIHN0YXRpYyBzdHJ1Y3QgcGh5
X2RyaXZlciBtYXJ2ZWxsX2RyaXZlcnNbXSA9IHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCAuZ2V0X3N0YXRzID0gbWFydmVsbF9nZXRfc3RhdHMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgLmxlZF9icmlnaHRuZXNzX3NldCA9IG04OGUxMzE4X2xlZF9icmlnaHRuZXNzX3NldCw8
YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAubGVkX2JsaW5rX3NldCA9IG04OGUxMzE4X2xl
ZF9ibGlua19zZXQsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmxlZF9od19pc19zdXBw
b3J0ZWQgPSBtODhlMTMxOF9sZWRfaHdfaXNfc3VwcG9ydGVkLDxicj4NCivCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoC5sZWRfaHdfY29udHJvbF9zZXQgPSBtODhlMTMxOF9sZWRfaHdfY29udHJvbF9z
ZXQsPGJyPg0KK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLmxlZF9od19jb250cm9sX2dldCA9IG04
OGUxMzE4X2xlZF9od19jb250cm9sX2dldCw8YnI+DQrCoCDCoCDCoCDCoCB9LDxicj4NCsKgIMKg
IMKgIMKgIHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAucGh5X2lkID0gTUFSVkVMTF9Q
SFlfSURfODhFMTE0NSw8YnI+DQpAQCAtMzI1Miw2ICszNDgzLDkgQEAgc3RhdGljIHN0cnVjdCBw
aHlfZHJpdmVyIG1hcnZlbGxfZHJpdmVyc1tdID0gezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIC5jYWJsZV90ZXN0X2dldF9zdGF0dXMgPSBtYXJ2ZWxsX3ZjdDdfY2FibGVfdGVzdF9nZXRf
c3RhdHVzLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5sZWRfYnJpZ2h0bmVzc19zZXQg
PSBtODhlMTMxOF9sZWRfYnJpZ2h0bmVzc19zZXQsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgLmxlZF9ibGlua19zZXQgPSBtODhlMTMxOF9sZWRfYmxpbmtfc2V0LDxicj4NCivCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoC5sZWRfaHdfaXNfc3VwcG9ydGVkID0gbTg4ZTEzMThfbGVkX2h3X2lz
X3N1cHBvcnRlZCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubGVkX2h3X2NvbnRyb2xf
c2V0ID0gbTg4ZTEzMThfbGVkX2h3X2NvbnRyb2xfc2V0LDxicj4NCivCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoC5sZWRfaHdfY29udHJvbF9nZXQgPSBtODhlMTMxOF9sZWRfaHdfY29udHJvbF9nZXQs
PGJyPg0KwqAgwqAgwqAgwqAgfSw8YnI+DQrCoCDCoCDCoCDCoCB7PGJyPg0KwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgLnBoeV9pZCA9IE1BUlZFTExfUEhZX0lEXzg4RTE1NDAsPGJyPg0KQEAgLTMy
ODAsNiArMzUxNCw5IEBAIHN0YXRpYyBzdHJ1Y3QgcGh5X2RyaXZlciBtYXJ2ZWxsX2RyaXZlcnNb
XSA9IHs8YnI+DQrCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCAuY2FibGVfdGVzdF9nZXRfc3RhdHVz
ID0gbWFydmVsbF92Y3Q3X2NhYmxlX3Rlc3RfZ2V0X3N0YXR1cyw8YnI+DQrCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCAubGVkX2JyaWdodG5lc3Nfc2V0ID0gbTg4ZTEzMThfbGVkX2JyaWdodG5lc3Nf
c2V0LDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5sZWRfYmxpbmtfc2V0ID0gbTg4ZTEz
MThfbGVkX2JsaW5rX3NldCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubGVkX2h3X2lz
X3N1cHBvcnRlZCA9IG04OGUxMzE4X2xlZF9od19pc19zdXBwb3J0ZWQsPGJyPg0KK8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgLmxlZF9od19jb250cm9sX3NldCA9IG04OGUxMzE4X2xlZF9od19jb250
cm9sX3NldCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubGVkX2h3X2NvbnRyb2xfZ2V0
ID0gbTg4ZTEzMThfbGVkX2h3X2NvbnRyb2xfZ2V0LDxicj4NCsKgIMKgIMKgIMKgIH0sPGJyPg0K
wqAgwqAgwqAgwqAgezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5waHlfaWQgPSBNQVJW
RUxMX1BIWV9JRF84OEUxNTQ1LDxicj4NCkBAIC0zMzA4LDYgKzM1NDUsOSBAQCBzdGF0aWMgc3Ry
dWN0IHBoeV9kcml2ZXIgbWFydmVsbF9kcml2ZXJzW10gPSB7PGJyPg0KwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgLmNhYmxlX3Rlc3RfZ2V0X3N0YXR1cyA9IG1hcnZlbGxfdmN0N19jYWJsZV90ZXN0
X2dldF9zdGF0dXMsPGJyPg0KwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgLmxlZF9icmlnaHRuZXNz
X3NldCA9IG04OGUxMzE4X2xlZF9icmlnaHRuZXNzX3NldCw8YnI+DQrCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCAubGVkX2JsaW5rX3NldCA9IG04OGUxMzE4X2xlZF9ibGlua19zZXQsPGJyPg0KK8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgLmxlZF9od19pc19zdXBwb3J0ZWQgPSBtODhlMTMxOF9sZWRf
aHdfaXNfc3VwcG9ydGVkLDxicj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5sZWRfaHdfY29u
dHJvbF9zZXQgPSBtODhlMTMxOF9sZWRfaHdfY29udHJvbF9zZXQsPGJyPg0KK8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgLmxlZF9od19jb250cm9sX2dldCA9IG04OGUxMzE4X2xlZF9od19jb250cm9s
X2dldCw8YnI+DQrCoCDCoCDCoCDCoCB9LDxicj4NCsKgIMKgIMKgIMKgIHs8YnI+DQrCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCAucGh5X2lkID0gTUFSVkVMTF9QSFlfSURfODhFMzAxNiw8YnI+DQpA
QCAtMzQ1MSw2ICszNjkxLDkgQEAgc3RhdGljIHN0cnVjdCBwaHlfZHJpdmVyIG1hcnZlbGxfZHJp
dmVyc1tdID0gezxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5zZXRfdHVuYWJsZSA9IG04
OGUxNTQwX3NldF90dW5hYmxlLDxicj4NCsKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIC5sZWRfYnJp
Z2h0bmVzc19zZXQgPSBtODhlMTMxOF9sZWRfYnJpZ2h0bmVzc19zZXQsPGJyPg0KwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgLmxlZF9ibGlua19zZXQgPSBtODhlMTMxOF9sZWRfYmxpbmtfc2V0LDxi
cj4NCivCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC5sZWRfaHdfaXNfc3VwcG9ydGVkID0gbTg4ZTEz
MThfbGVkX2h3X2lzX3N1cHBvcnRlZCw8YnI+DQorwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAubGVk
X2h3X2NvbnRyb2xfc2V0ID0gbTg4ZTEzMThfbGVkX2h3X2NvbnRyb2xfc2V0LDxicj4NCivCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoC5sZWRfaHdfY29udHJvbF9nZXQgPSBtODhlMTMxOF9sZWRfaHdf
Y29udHJvbF9nZXQsPGJyPg0KwqAgwqAgwqAgwqAgfSw8YnI+DQrCoH07PGJyPg0KPGJyPg0KLS0g
PGJyPg0KMi40MC4xPGJyPg0KPGJyPg0KPGJyPg0KPC9ibG9ja3F1b3RlPjwvZGl2PjxiciBjbGVh
cj0iYWxsIj48ZGl2Pjxicj48L2Rpdj48c3BhbiBjbGFzcz0iZ21haWxfc2lnbmF0dXJlX3ByZWZp
eCI+LS0gPC9zcGFuPjxicj48ZGl2IGRpcj0ibHRyIiBjbGFzcz0iZ21haWxfc2lnbmF0dXJlIj48
ZGl2IGRpcj0ibHRyIj5SZWdhcmRzLDxkaXY+S2FsZXNoIEEgUDwvZGl2PjwvZGl2PjwvZGl2Pjwv
ZGl2Pg0K
--00000000000074a2ce05ff000583--

--0000000000007d7e9505ff00054b
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBWowggRSoAMCAQICDDfBRQmwNSI92mit0zANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAwODI5NTZaFw0yNTA5MTAwODI5NTZaMIGi
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xHzAdBgNVBAMTFkthbGVzaCBBbmFra3VyIFB1cmF5aWwxMjAw
BgkqhkiG9w0BCQEWI2thbGVzaC1hbmFra3VyLnB1cmF5aWxAYnJvYWRjb20uY29tMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAxnv1Reaeezfr6NEmg3xZlh4cz9m7QCN13+j4z1scrX+b
JfnV8xITT5yvwdQv3R3p7nzD/t29lTRWK3wjodUd2nImo6vBaH3JbDwleIjIWhDXLNZ4u7WIXYwx
aQ8lYCdKXRsHXgGPY0+zSx9ddpqHZJlHwcvas3oKnQN9WgzZtsM7A8SJefWkNvkcOtef6bL8Ew+3
FBfXmtsPL9I2vita8gkYzunj9Nu2IM+MnsP7V/+Coy/yZDtFJHp30hDnYGzuOhJchDF9/eASvE8T
T1xqJODKM9xn5xXB1qezadfdgUs8k8QAYyP/oVBafF9uqDudL6otcBnziyDBQdFCuAQN7wIDAQAB
o4IB5DCCAeAwDgYDVR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZC
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJj
YTIwMjAuY3J0MEEGCCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3Iz
cGVyc29uYWxzaWduMmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcC
ARYmaHR0cHM6Ly93d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNV
HR8EQjBAMD6gPKA6hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNp
Z24yY2EyMDIwLmNybDAuBgNVHREEJzAlgSNrYWxlc2gtYW5ha2t1ci5wdXJheWlsQGJyb2FkY29t
LmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGP
zzAdBgNVHQ4EFgQUI3+tdStI+ABRGSqksMsiCmO9uDAwDQYJKoZIhvcNAQELBQADggEBAGfe1o9b
4wUud0FMjb/FNdc433meL15npjdYWUeioHdlCGB5UvEaMGu71QysfoDOfUNeyO9YKp0h0fm7clvo
cBqeWe4CPv9TQbmLEtXKdEpj5kFZBGmav69mGTlu1A9KDQW3y0CDzCPG2Fdm4s73PnkwvemRk9E2
u9/kcZ8KWVeS+xq+XZ78kGTKQ6Wii3dMK/EHQhnDfidadoN/n+x2ySC8yyDNvy81BocnblQzvbuB
a30CvRuhokNO6Jzh7ZFtjKVMzYas3oo6HXgA+slRszMu4pc+fRPO41FHjeDM76e6P5OnthhnD+NY
x6xokUN65DN1bn2MkeNs0nQpizDqd0QxggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25h
bFNpZ24gMiBDQSAyMDIwAgw3wUUJsDUiPdpordMwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcN
AQkEMSIEINC6JHIrYXUxDAO5bGsOYJUQJMTZvz1NVZb1H8FX9j4IMBgGCSqGSIb3DQEJAzELBgkq
hkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMDYyNjAzMzQwMFowaQYJKoZIhvcNAQkPMVwwWjAL
BglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG
9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQDAF8DDkVTp
l4LtX1HJdue90UmTI4ycmCobJUgC0b4Re5PK4AFPLW90mhbFwFrSr52owwAtTFgymEpIEnwb4XnP
gNg2rcKNlq8FoKOKKoNm8X14al27YSCCqu911Wnh53VZlapiLTuEt1dReI6E9UONSJnS7ZRy7Z5B
ypoku0pe6PXzRBqilYQ1klvGus2yIblGOZaWRbfn4i4Ix86wxhnPVeCw6FzyBTiJT1HaxU/C1aQq
jKd9DlPChXKgx6Z1ctR2o3clJU4x06lDEA6Dj3+aTNHP5x7fN8DYfl6TcX6qs6JDOrySmBovc8Hy
keiaowqadITdKyl6lnYIhOaCoiYF
--0000000000007d7e9505ff00054b--

