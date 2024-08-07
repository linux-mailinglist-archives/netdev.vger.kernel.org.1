Return-Path: <netdev+bounces-116357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BC86094A1EB
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 09:42:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E1DB2833C5
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 07:42:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DB0F1C4610;
	Wed,  7 Aug 2024 07:42:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E41B22EE5
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 07:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723016571; cv=none; b=Ismx7p939u0JTHAWMht2a+CXjgrlej4L8ss0W6YbJIGixyi0hRKM7ujx40fdiv77PRiXkzQaNuXKsKHGNAHn1IiQ6OcgM4XRCwUaBOSgmpPQhn9Lr7xoyqWzR6laCxcDD8o1ZOjfiQtLGRzh1h3y0uQADTW8t+NPUhX6CbQ3OTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723016571; c=relaxed/simple;
	bh=lxD1qWqaDljFIw4OxjXr2Y1HyosMj/0qUxjThoHbnAg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=UwfBnez1ZlTzuAJ0qhwF9vIybRIFhC8r7Wji73bezuHoraWw5VaRhZup3e9yunZo2mt7SKfQkaa2CyFegvgn+pJriNVzYrmXstTg6KPXZo/RcYEJSQXqDSmlX5u8+HlpQuCOypXhMV2iXHSQt5LvDP0UbXEsQB3zHy9lUyO5/2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtpsz15t1723016525to8880
X-QQ-Originating-IP: 0DxtdyFwvltcYlbMHfXdh4HAiE/0RigeT6Tr1TCd1as=
Received: from smtpclient.apple ( [60.186.245.110])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 07 Aug 2024 15:42:03 +0800 (CST)
X-QQ-SSF: 0001000000000000000000000000000
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 16839200958760342214
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3814.100.5\))
Subject: Re: [PATCH net-next v5 08/10] net: libwx: add eswitch switch api for
 devlink ops
From: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
In-Reply-To: <ZrIMLEqxn6UxQ7B1@nanopsycho.orion>
Date: Wed, 7 Aug 2024 15:41:53 +0800
Cc: Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <721C2E58-6348-4645-A932-0FF6499147B1@net-swift.com>
References: <20240804124841.71177-1-mengyuanlou@net-swift.com>
 <5DD6E0A4F173D3D3+20240804124841.71177-9-mengyuanlou@net-swift.com>
 <20240805164350.GK2636630@kernel.org> <ZrIMLEqxn6UxQ7B1@nanopsycho.orion>
To: Jiri Pirko <jiri@resnulli.us>
X-Mailer: Apple Mail (2.3814.100.5)
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpsz:net-swift.com:qybglogicsvrsz:qybglogicsvrsz4a-0



> 2024=E5=B9=B48=E6=9C=886=E6=97=A5 19:42=EF=BC=8CJiri Pirko =
<jiri@resnulli.us> =E5=86=99=E9=81=93=EF=BC=9A
>=20
> Mon, Aug 05, 2024 at 06:43:50PM CEST, horms@kernel.org wrote:
>> On Sun, Aug 04, 2024 at 08:48:39PM +0800, Mengyuan Lou wrote:
>>=20
>> Each patch needs a patch description describing not just what is done
>> but why.
>>=20
>> Also, please seed the CC list for patch submissions
>> using get_maintainer this.patch. I believe that b4
>> will do that for you.
>>=20
>>> Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
>>=20
>> ...
>>=20
>>> static void wx_devlink_free(void *devlink_ptr)
>>> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c =
b/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c
>>> new file mode 100644
>>> index 000000000000..a426a352bf96
>>> --- /dev/null
>>> +++ b/drivers/net/ethernet/wangxun/libwx/wx_eswitch.c
>>> @@ -0,0 +1,53 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +/* Copyright (C) 2019-2021, Intel Corporation. */
>>=20
>> Are you sure Intel holds the copyright on this code?
>>=20
>>> +
>>> +#include <linux/pci.h>
>>> +
>>> +#include "wx_type.h"
>>> +#include "wx_eswitch.h"
>>> +#include "wx_devlink.h"
>>> +
>>> +int wx_eswitch_mode_set(struct devlink *devlink, u16 mode,
>>> + struct netlink_ext_ack *extack)
>>> +{
>>> + struct wx_dl_priv *dl_priv =3D devlink_priv(devlink);
>>> + struct wx *wx =3D dl_priv->priv_wx;
>>> +
>>> + if (wx->eswitch_mode =3D=3D mode)
>>> + return 0;
>>> +
>>> + if (wx->num_vfs) {
>>> + dev_info(&(wx)->pdev->dev,
>>> + "Change eswitch mode is allowed if there is no VFs.");
>>=20
>> maybe: Changing eswitch mode is only allowed if there are no VFs.
>>=20
>>> + return -EOPNOTSUPP;
>>> + }
>>> +
>>> + switch (mode) {
>>> + case DEVLINK_ESWITCH_MODE_LEGACY:
>>> + dev_info(&(wx)->pdev->dev,
>>> + "PF%d changed eswitch mode to legacy",
>>> + wx->bus.func);
>>> + NL_SET_ERR_MSG_MOD(extack, "Changed eswitch mode to legacy");
>>> + break;
>>> + case DEVLINK_ESWITCH_MODE_SWITCHDEV:
>>> + dev_info(&(wx)->pdev->dev,
>>> + "Do not support switchdev in eswitch mode.");
>>> + NL_SET_ERR_MSG_MOD(extack, "Do not support switchdev mode.");
>>=20
>> maybe: eswitch mode switchdev is not supported
>>=20
>> I am curious to know if you are planning to implement eswitch mode in =
the
>> near future.  If not, is wx_eswitch_mode_set() needed: it seems =
unused in
>> this patchset: it should probably be added in a patchset that uses =
it.
>=20
> This is wrong.
>=20
> switchdev mode should be supported from the beginning. There is some =
odd
> hybrid mode supported, VF gets devlink port created for representors,
> yet no netdev. I'm very sure this triggers:
>=20
> static void devlink_port_type_warn(struct work_struct *work)
> {
>        struct devlink_port *port =3D =
container_of(to_delayed_work(work),
>                                                 struct devlink_port,
>                                                 type_warn_dw);
>        dev_warn(port->devlink->dev, "Type was not set for devlink =
port.");
> }
>=20
> So, if you don't see this message, leads to my assuptions this =
patchset
> was not tested. Certainly odd.
>=20

I have seen this warnning info.
What I want is that the devlink port Uapi to vfs, but I think the =
product will
not to support switchdev mode and the representors representors will not =
be used.

Be like:
https://lore.kernel.org/netdev/20240620002741.1029936-1-kuba@kernel.org/

>=20
>>=20
>>> + return -EINVAL;
>>> + default:
>>> + NL_SET_ERR_MSG_MOD(extack, "Unknown eswitch mode");
>>> + return -EINVAL;
>>> + }
>>> +
>>> + wx->eswitch_mode =3D mode;
>>> + return 0;
>>> +}
>>> +
>>> +int wx_eswitch_mode_get(struct devlink *devlink, u16 *mode)
>>> +{
>>> + struct wx_dl_priv *dl_priv =3D devlink_priv(devlink);
>>> + struct wx *wx =3D dl_priv->priv_wx;
>>> +
>>> + *mode =3D wx->eswitch_mode;
>>> + return 0;
>>> +}
>>=20
>> ...
>>=20
>=20


