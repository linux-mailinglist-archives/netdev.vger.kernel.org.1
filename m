Return-Path: <netdev+bounces-24304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B8576FB08
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 09:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B19E22824ED
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 07:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9967E79EF;
	Fri,  4 Aug 2023 07:21:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADAA6FAD
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 07:21:43 +0000 (UTC)
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC22435AA
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 00:21:40 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-407db3e9669so151101cf.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 00:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691133700; x=1691738500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PWW3ABIHQi6sSRhQFBIuC8dDMRNhoaTSKtIySe9XQwo=;
        b=oalSL2Nj2569hNGzaA4ZUGPRlQEU1mpkdPlYh8vxIfXVsFE6u8KYUb6gR+B4DGci4+
         HrBKbVmA1+lH2OrAa/TtwzzVpW4/hfirAbWyRIujzAFX43m8I6EKlmI7/ZTAzvfk6Jkb
         hnTWcQoyyeS/Htz6uLrJ8ix8aR5MKieSoMqjxiZIndf396Sx0OPSqjalZ1K9V9RvnzIz
         UaQMKg4YWlhaJlUpAlTNy1vpQAkJHD8hlCgTVGfTHah4pmUcJPG50mU8SjxW5XxbCJMK
         WFMzLUgmlw/o0f+tldwIlIkyjfvBR6yrWlaxxj3ze+hoxJYmvRKoC5fBhRX8Y2Ak6F6q
         u/Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691133700; x=1691738500;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PWW3ABIHQi6sSRhQFBIuC8dDMRNhoaTSKtIySe9XQwo=;
        b=CYD896R+B2uOd8THXDdXpnkFNAhimsOlcP84JWQnAAO6dqvEp0OgmhEg0PAmLas4k0
         dGl1kRJLD/Hqd8gREhljf38jsdf63zu1iG1pthxrLA0hB91GH3Q404SapAuorIaO3WHI
         Gug8WYLOe8QV37t1AtTFjdejTv2QlUxl1rv86E21uwiS+iv6yNKzfUw+o2Gimo3If2bi
         OuoQZ0envZvH43c36UJiAkduGXjEaLCG0fP0puGrnFkgw+tziCT7qhnva3NTonIg329W
         Agsp5mJFMvQmTf8QKx+fPumNiDjku6BOfarOf6byyhz099E4kjlYPEUJbvAjIztW2tVV
         KvhA==
X-Gm-Message-State: AOJu0Yw7kfI3M5QolPYA+jgxlYRzKTSz+xn0Ri6FVNtOeL7G2+vBi3iW
	UkXlQ69hRxzxZGp/KkeKAZ9OOXuf/elfu4S9EjthxRbQ8/pL3QCc+YhOLw==
X-Google-Smtp-Source: AGHT+IHW0Yl7enhTDicLoDmaectlTTgexjAtstb98uUxc03BXJCt5zmKWK8uPqo10EcW3WemN9TF9eGWe9UjKkZccck=
X-Received: by 2002:a05:622a:1827:b0:403:eeb9:a76 with SMTP id
 t39-20020a05622a182700b00403eeb90a76mr107512qtc.17.1691133699862; Fri, 04 Aug
 2023 00:21:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230801142824.1772134-1-vladimir.oltean@nxp.com> <20230801142824.1772134-13-vladimir.oltean@nxp.com>
In-Reply-To: <20230801142824.1772134-13-vladimir.oltean@nxp.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Aug 2023 09:21:28 +0200
Message-ID: <CANn89iLOspJsvjPj+y8jikg7erXDomWe8sqHMdfL_2LQSFrPAg@mail.gmail.com>
Subject: Re: [PATCH v9 net-next 12/12] net: remove phy_has_hwtstamp() ->
 phy_mii_ioctl() decision from converted drivers
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>, 
	Florian Fainelli <f.fainelli@gmail.com>, Maxim Georgiev <glipus@gmail.com>, 
	Horatiu Vultur <horatiu.vultur@microchip.com>, =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Richard Cochran <richardcochran@gmail.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Gerhard Engleder <gerhard@engleder-embedded.com>, Hangbin Liu <liuhangbin@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Jacob Keller <jacob.e.keller@intel.com>, Jay Vosburgh <j.vosburgh@gmail.com>, 
	Andy Gospodarek <andy@greyhouse.net>, Wei Fang <wei.fang@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, 
	NXP Linux Team <linux-imx@nxp.com>, UNGLinuxDriver@microchip.com, 
	Lars Povlsen <lars.povlsen@microchip.com>, Steen Hegelund <Steen.Hegelund@microchip.com>, 
	Daniel Machon <daniel.machon@microchip.com>, Simon Horman <simon.horman@corigine.com>, 
	Casper Andersson <casper.casan@gmail.com>, Sergey Organov <sorganov@gmail.com>, 
	Michal Kubecek <mkubecek@suse.cz>, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 1, 2023 at 4:29=E2=80=AFPM Vladimir Oltean <vladimir.oltean@nxp=
.com> wrote:
>
> It is desirable that the new .ndo_hwtstamp_set() API gives more
> uniformity, less overhead and future flexibility w.r.t. the PHY
> timestamping behavior.
>
> Currently there are some drivers which allow PHY timestamping through
> the procedure mentioned in Documentation/networking/timestamping.rst.
> They don't do anything locally if phy_has_hwtstamp() is set, except for
> lan966x which installs PTP packet traps.
>
> Centralize that behavior in a new dev_set_hwtstamp_phylib() code
> function, which calls either phy_mii_ioctl() for the phylib PHY,
> or .ndo_hwtstamp_set() of the netdev, based on a single policy
> (currently simplistic: phy_has_hwtstamp()).
>
> Any driver converted to .ndo_hwtstamp_set() will automatically opt into
> the centralized phylib timestamping policy. Unconverted drivers still
> get to choose whether they let the PHY handle timestamping or not.
>
> Netdev drivers with integrated PHY drivers that don't use phylib
> presumably don't set dev->phydev, and those will always see
> HWTSTAMP_SOURCE_NETDEV requests even when converted. The timestamping
> policy will remain 100% up to them.
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
> Tested-by: Horatiu Vultur <horatiu.vultur@microchip.com>
> ---


> +/**
> + * dev_set_hwtstamp_phylib() - Change hardware timestamping of NIC
> + *     or of attached phylib PHY
> + * @dev: Network device
> + * @cfg: Timestamping configuration structure
> + * @extack: Netlink extended ack message structure, for error reporting
> + *
> + * Helper for enforcing a common policy that phylib timestamping, if ava=
ilable,
> + * should take precedence in front of hardware timestamping provided by =
the
> + * netdev. If the netdev driver needs to perform specific actions even f=
or PHY
> + * timestamping to work properly (a switch port must trap the timestampe=
d
> + * frames and not forward them), it must set IFF_SEE_ALL_HWTSTAMP_REQUES=
TS in
> + * dev->priv_flags.
> + */
> +static int dev_set_hwtstamp_phylib(struct net_device *dev,
> +                                  struct kernel_hwtstamp_config *cfg,
> +                                  struct netlink_ext_ack *extack)
> +{
> +       const struct net_device_ops *ops =3D dev->netdev_ops;
> +       bool phy_ts =3D phy_has_hwtstamp(dev->phydev);
> +       struct kernel_hwtstamp_config old_cfg =3D {};
> +       bool changed =3D false;
> +       int err;
> +
> +       cfg->source =3D phy_ts ? HWTSTAMP_SOURCE_PHYLIB : HWTSTAMP_SOURCE=
_NETDEV;
> +
> +       if (!phy_ts || (dev->priv_flags & IFF_SEE_ALL_HWTSTAMP_REQUESTS))=
 {
> +               err =3D ops->ndo_hwtstamp_get(dev, &old_cfg);

old_cfg.ifr is NULL at this point.

This causes a crash later in generic_hwtstamp_ioctl_lower()

    ifrr.ifr_ifru =3D kernel_cfg->ifr->ifr_ifru;



> +               if (err)
> +                       return err;
> +
> +               err =3D ops->ndo_hwtstamp_set(dev, cfg, extack);
> +               if (err) {
> +                       if (extack->_msg)
> +                               netdev_err(dev, "%s\n", extack->_msg);
> +                       return err;
> +               }
> +
> +               changed =3D kernel_hwtstamp_config_changed(&old_cfg, cfg)=
;
> +       }
> +
> +       if (phy_ts) {
> +               err =3D phy_hwtstamp_set(dev->phydev, cfg, extack);
> +               if (err) {
> +                       if (changed)
> +                               ops->ndo_hwtstamp_set(dev, &old_cfg, NULL=
);
> +                       return err;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
>  static int dev_set_hwtstamp(struct net_device *dev, struct ifreq *ifr)
>  {
>         const struct net_device_ops *ops =3D dev->netdev_ops;
> @@ -314,12 +392,9 @@ static int dev_set_hwtstamp(struct net_device *dev, =
struct ifreq *ifr)
>         if (!netif_device_present(dev))
>                 return -ENODEV;
>
> -       err =3D ops->ndo_hwtstamp_set(dev, &kernel_cfg, &extack);
> -       if (err) {
> -               if (extack._msg)
> -                       netdev_err(dev, "%s\n", extack._msg);
> +       err =3D dev_set_hwtstamp_phylib(dev, &kernel_cfg, &extack);
> +       if (err)
>                 return err;
> -       }
>
>         /* The driver may have modified the configuration, so copy the
>          * updated version of it back to user space
> @@ -362,7 +437,7 @@ int generic_hwtstamp_get_lower(struct net_device *dev=
,
>                 return -ENODEV;
>
>         if (ops->ndo_hwtstamp_get)
> -               return ops->ndo_hwtstamp_get(dev, kernel_cfg);
> +               return dev_get_hwtstamp_phylib(dev, kernel_cfg);
>
>         /* Legacy path: unconverted lower driver */
>         return generic_hwtstamp_ioctl_lower(dev, SIOCGHWTSTAMP, kernel_cf=
g);
> @@ -379,7 +454,7 @@ int generic_hwtstamp_set_lower(struct net_device *dev=
,
>                 return -ENODEV;
>
>         if (ops->ndo_hwtstamp_set)
> -               return ops->ndo_hwtstamp_set(dev, kernel_cfg, extack);
> +               return dev_set_hwtstamp_phylib(dev, kernel_cfg, extack);
>
>         /* Legacy path: unconverted lower driver */
>         return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cf=
g);
> --
> 2.34.1
>

