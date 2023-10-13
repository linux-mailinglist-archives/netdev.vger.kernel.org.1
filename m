Return-Path: <netdev+bounces-40861-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2F47C8ECE
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 23:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0687E1C21183
	for <lists+netdev@lfdr.de>; Fri, 13 Oct 2023 21:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B34AA250F4;
	Fri, 13 Oct 2023 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mBaaSXK1"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5785824203
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 21:12:53 +0000 (UTC)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC0E7BE
	for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 14:12:48 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-53dfc28a2afso4377198a12.1
        for <netdev@vger.kernel.org>; Fri, 13 Oct 2023 14:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697231567; x=1697836367; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65Li0CJUc3AAYY2ID9vtBx9Y6C6M7aGLDvXjXcw/aCw=;
        b=mBaaSXK1I5ptvwYwXEbZNty4oAekgLoL8fTQMnd8WgD9uIHa6pKiDxNvTYefxPsm6W
         V1ooqH5HWVIJ1yvOxIpv3FMwCnk/a70obO163LpHKrEe75h2HEF/oLE90E5rgJxphSSD
         v1XQiS4wNcFYg1Dr0kPfjLpKo/RG7qOwBSsyjuxchyaXf/Yln5tWyiVUIpEUoOm9VvN6
         7GLeIMEYEynxwDyR4QG220lf+5SmS2W3nblWhHGtMJ5+3NVx1TX47ZlJxb4sIORfh3MP
         rmdNb7tufK6h/8pOz3FCP7oUkpmrnqhGsNYVjKZMIB8p7NKqdVkRW0MeL8EHcH1Ud65Z
         QAMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697231567; x=1697836367;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65Li0CJUc3AAYY2ID9vtBx9Y6C6M7aGLDvXjXcw/aCw=;
        b=CnrOg7x6yE4ZLoqnb5soIZSSvk9rXfIfr9JPSL/q9WaqnRvdnasIYwhTu1RwZaBhIY
         PHHYgPyDIblChRHHQEe0+s4iem9Hex8gImL1PcWsK9kBdlu5lQrJnVLNM84dv3YXJyzj
         z+MqFFgZqyRZrT/WEuLanRiNR0gW9KxpnyaYlj0UHIGhJwI/+KKSfOCc6CN2Bs88YYGv
         ShkKf/DMLKNPqNUatmyCQS3WgFFRXa53UdVCk31SCsG9PULg10K1Ai+k/DNgz4NEnQek
         ERf42SkJU01u9HGY+NogQvgD8OAw6DPpOYMFdo7vpfPwc5X7cI36HiR1Nuk90D/JhMQS
         Houg==
X-Gm-Message-State: AOJu0Yzo/Z0pKtB9AbtNXZ5qW+tiNCAhUYxaXuIULNCYRzV6IXP4hUFH
	D6OxIURN+SU1kC8MCz+wql51Nq3HqDyMbYFm61FN8Q==
X-Google-Smtp-Source: AGHT+IECae+iT+rBLZo5NuHqthDxyRPk1+BH5q2rVfgRV9e5y2Dk1JwjKBHx5Cq7DDrLHjTGu8UXwVnF8HWTbbm75no=
X-Received: by 2002:a05:6402:2707:b0:53e:1434:25db with SMTP id
 y7-20020a056402270700b0053e143425dbmr5372450edd.23.1697231567170; Fri, 13 Oct
 2023 14:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231012-strncpy-drivers-net-phy-nxp-tja11xx-c-v1-1-5ad6c9dff5c4@google.com>
 <15af4bc4-2066-44bc-8d2e-839ff3945663@lunn.ch> <CAFhGd8pmq3UKBE_6ZbLyvRRhXJzaWMQ2GfosvcEEeAS-n7M4aQ@mail.gmail.com>
 <0c401bcb-70a8-47a5-bca0-0b9e8e0439a8@lunn.ch>
In-Reply-To: <0c401bcb-70a8-47a5-bca0-0b9e8e0439a8@lunn.ch>
From: Justin Stitt <justinstitt@google.com>
Date: Fri, 13 Oct 2023 14:12:34 -0700
Message-ID: <CAFhGd8p3WzqQu7kT0Pt8Axuv5sKdHJQOLZVEg5x8S_QNwT6bjQ@mail.gmail.com>
Subject: Re: [PATCH] net: phy: tja11xx: replace deprecated strncpy with ethtool_sprintf
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Oct 13, 2023 at 1:13=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Oct 13, 2023 at 12:53:53PM -0700, Justin Stitt wrote:
> > On Fri, Oct 13, 2023 at 5:22=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > -     for (i =3D 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++) {
> > > > -             strncpy(data + i * ETH_GSTRING_LEN,
> > > > -                     tja11xx_hw_stats[i].string, ETH_GSTRING_LEN);
> > > > -     }
> > > > +     for (i =3D 0; i < ARRAY_SIZE(tja11xx_hw_stats); i++)
> > > > +             ethtool_sprintf(&data, "%s", tja11xx_hw_stats[i].stri=
ng);
> > > >  }
> > >
> > > I assume you are using "%s" because tja11xx_hw_stats[i].string cannot
> > > be trusted as a format string? Is this indicating we need an
> > > ethtool_puts() ?
> >
> > Indeed, it would trigger a -Wformat-security warning.
> >
> > An ethtool_puts() would be useful for this situation.
>
> Hi Justin
>
> hyperv/netvsc_drv.c:                    ethtool_sprintf(&p, netvsc_stats[=
i].name);
> hyperv/netvsc_drv.c:                    ethtool_sprintf(&p, vf_stats[i].n=
ame);
> ethernet/intel/i40e/i40e_ethtool.c:             ethtool_sprintf(&p, i40e_=
gstrings_priv_flags[i].flag_string);
> ethernet/intel/i40e/i40e_ethtool.c:             ethtool_sprintf(&p, i40e_=
gl_gstrings_priv_flags[i].flag_string);
> ethernet/intel/ice/ice_ethtool.c:                       ethtool_sprintf(&=
p, ice_gstrings_priv_flags[i].name);
> ethernet/intel/igc/igc_ethtool.c:                       ethtool_sprintf(&=
p, igc_gstrings_stats[i].stat_string);
> ethernet/intel/ixgbe/ixgbe_ethtool.c:                   ethtool_sprintf(&=
p, ixgbe_gstrings_test[i]);
> ethernet/netronome/nfp/nfp_net_ethtool.c:                       ethtool_s=
printf(&data, nfp_self_test[i].name);
> ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf(&=
data, nfp_net_et_stats[i + swap_off].name);
> ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf(&=
data, nfp_net_et_stats[i - swap_off].name);
> ethernet/netronome/nfp/nfp_net_ethtool.c:               ethtool_sprintf(&=
data, nfp_net_et_stats[i].name);
> ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_s=
printf(&p, txq_stat_names[j]);
> ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_s=
printf(&p, xdpq_stat_names[j]);
> ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_s=
printf(&p, rxq_stat_names[j]);
> ethernet/fungible/funeth/funeth_ethtool.c:                      ethtool_s=
printf(&p, tls_stat_names[j]);
> ethernet/amazon/ena/ena_ethtool.c:              ethtool_sprintf(&data, en=
a_stats->name);
> ethernet/amazon/ena/ena_ethtool.c:                      ethtool_sprintf(&=
data, ena_stats->name);
> ethernet/brocade/bna/bnad_ethtool.c:            ethtool_sprintf(&string, =
bnad_net_stats_strings[i]);
> ethernet/pensando/ionic/ionic_stats.c:          ethtool_sprintf(buf, ioni=
c_lif_stats_desc[i].name);
> ethernet/pensando/ionic/ionic_stats.c:          ethtool_sprintf(buf, ioni=
c_port_stats_desc[i].name);
> ethernet/hisilicon/hns/hns_dsaf_gmac.c:         ethtool_sprintf(&buff, g_=
gmac_stats_string[i].desc);
> ethernet/hisilicon/hns/hns_dsaf_xgmac.c:                ethtool_sprintf(&=
buff, g_xgmac_stats_string[i].desc);
> vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmx=
net3_tq_dev_stats[i].desc);
> vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmx=
net3_tq_driver_stats[i].desc);
> vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmx=
net3_rq_dev_stats[i].desc);
> vmxnet3/vmxnet3_ethtool.c:                      ethtool_sprintf(&buf, vmx=
net3_rq_driver_stats[i].desc);
> vmxnet3/vmxnet3_ethtool.c:              ethtool_sprintf(&buf, vmxnet3_glo=
bal_stats[i].desc);
>

Woah, are these all triggering -Wformat-security warnings?

> It looks like there are enough potential users to justify adding
> it. Do you have the time and patience?

I do :)

Should I create ethtool_puts() and then submit adoption patches
for it in the same series? Or wait to hear back about how ethtool_puts()
is received.

>
>     Andrew

Thanks
Justin

