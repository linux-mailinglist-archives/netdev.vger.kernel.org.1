Return-Path: <netdev+bounces-169215-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4B57A42FD4
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 23:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9591889B99
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 22:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4745E1FC11D;
	Mon, 24 Feb 2025 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cuaouu7E"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2F719F11F;
	Mon, 24 Feb 2025 22:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740435010; cv=none; b=W86eoyMP7lJSRds7eyVCCRjAbTv35Mrv3ldhgfoQE6hdHNdwobujjiz3eomLKWp96K6pmGdnztB1h6mX16YBYwlh+lM0nPoo1YZ7xHdEkT8dYay+i5P6OgA146gvP3v2CLNQDFOsl82HBJ4dGIheJbKxfhsjLl0tSDfjqGAyFGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740435010; c=relaxed/simple;
	bh=EVBNpwDMZYWrj1DBB/Slu9MsiZUKPg8LcAsAq7i3c5U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2joRSTW9LWH0SndYCQllX0ATTy6g9C5B/0pRXFq2IIY+831alBrsQZKtf/k9c5OFYYvW7EjEFgA47Sfc1k0LWeHKPRPc0rTmdiaRiFLRUPJE7Y2X1bmK3ZteZ50QxdUHc1EdHyxFdfxA3uTGHrGkXVSuhB9Zz2c+QbCbC7FhgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cuaouu7E; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D89C4CEE9;
	Mon, 24 Feb 2025 22:10:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740435010;
	bh=EVBNpwDMZYWrj1DBB/Slu9MsiZUKPg8LcAsAq7i3c5U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=cuaouu7Eql0mfcgKelO7Z/3TUHklDW9L+m7oa2PPAzuyu5hD0VbRpK36/mbqT3taH
	 6xmVqBqQTc+MYf54I3genvdijo1M9tKZ6zBwlqEG9nwgoR8pB/ifeRD2EXybzw5KvV
	 N+zBTgingDlbQldQH0fJVpbDmjMYxyBsxVXxw0bvWuuMZpTBFH1c6Y1nmcQU7HySV5
	 gTxjRBcFryZ50+ykL84TJPaO4AUS1I1+Or7NZX6jqJjkQVO/AAQMbu+3nBsj/dtOhT
	 b57zp1AzmA10oyvNtXn3SN4Ih+Y4apD2cd8/+gX5L60tuhWS19I+UWXopA0IocumAj
	 j5lGS2N41rA3Q==
Date: Mon, 24 Feb 2025 14:10:08 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Hangbin Liu <liuhangbin@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Nikolay
 Aleksandrov <razor@blackwall.org>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] bonding: report duplicate MAC address in all
 situations
Message-ID: <20250224141008.3ee3a74b@kernel.org>
In-Reply-To: <20250219075515.1505887-1-liuhangbin@gmail.com>
References: <20250219075515.1505887-1-liuhangbin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 19 Feb 2025 07:55:15 +0000 Hangbin Liu wrote:
> Normally, a bond uses the MAC address of the first added slave as the
> bond=E2=80=99s MAC address. And the bond will set active slave=E2=80=99s =
MAC address to
> bond=E2=80=99s address if fail_over_mac is set to none (0) or follow (2).
>=20
> When the first slave is removed, the bond will still use the removed
> slave=E2=80=99s MAC address, which can lead to a duplicate MAC address and
> potentially cause issues with the switch. To avoid confusion, let's warn
> the user in all situations, including when fail_over_mac is set to 2 or
> in active-backup mode.

Makes sense, thanks for the high quality commit message.

False positive warnings are annoying to users (especially users who
monitor all warnings in their fleet). Could we stick to filtering out
the BOND_FOM_ACTIVE case? Looks like this condition:

	if (bond->params.fail_over_mac !=3D BOND_FOM_ACTIVE ||
	    BOND_MODE(bond) !=3D BOND_MODE_ACTIVEBACKUP) {

exists a few lines later in __bond_release_one()

> diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_m=
ain.c
> index e45bba240cbc..ca66107776cc 100644
> --- a/drivers/net/bonding/bond_main.c
> +++ b/drivers/net/bonding/bond_main.c
> @@ -2551,13 +2551,11 @@ static int __bond_release_one(struct net_device *=
bond_dev,
> =20
>  	RCU_INIT_POINTER(bond->current_arp_slave, NULL);
> =20
> -	if (!all && (!bond->params.fail_over_mac ||
> -		     BOND_MODE(bond) !=3D BOND_MODE_ACTIVEBACKUP)) {
> -		if (ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
> -		    bond_has_slaves(bond))
> -			slave_warn(bond_dev, slave_dev, "the permanent HWaddr of slave - %pM =
- is still in use by bond - set the HWaddr of slave to a different address =
to avoid conflicts\n",
> -				   slave->perm_hwaddr);
> -	}
> +	if (!all &&
> +	    ether_addr_equal_64bits(bond_dev->dev_addr, slave->perm_hwaddr) &&
> +	    bond_has_slaves(bond))
> +		slave_warn(bond_dev, slave_dev, "the permanent HWaddr of slave - %pM -=
 is still in use by bond - set the HWaddr of slave to a different address t=
o avoid conflicts\n",
> +			   slave->perm_hwaddr);
--=20
pw-bot: cr

