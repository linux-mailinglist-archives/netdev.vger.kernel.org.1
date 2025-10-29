Return-Path: <netdev+bounces-233866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6F0C19940
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 11:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 99E824F0A57
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 10:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 293732E5437;
	Wed, 29 Oct 2025 10:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Tz7q9xu6"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E112B2E3AF2;
	Wed, 29 Oct 2025 10:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761732421; cv=none; b=lIVo3MQb7OCo2EsHagzpIIqGx4ccSUmZqhla/m0pFC6nIfp40Jr9N42eizsNaJvcicCdIF+UvKTdVK+F8Nip6H3nVIf9AYcFFpcUTINpZhcI1lYoHh3A1+oxBWEb43H7cTtkPrr8w0nmo3daNb7qK1Rmg1lZhMWO3sd9WxxCuYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761732421; c=relaxed/simple;
	bh=lnkJcczclvPYTFrmVPc+RABtS9RQehFIWvK9WghsEwg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CXKt6SAEWw2ijYRbmCkZD3R9rz/QPXYXWljfM3HNJxyZE/bouiaEg+OzCzrVStcgGRArVsUB0xo9fZt46zLxFpcWfuMinhQp6HSkYZzYARzrB2jFEQkL0wWgzFyTbjHoySkQ6qlBn17Wtwom7ILI0FW3mlcAZbNxEaLfiURh/tc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Tz7q9xu6; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id D7D5B4E413C6;
	Wed, 29 Oct 2025 10:06:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 9D8DE606E8;
	Wed, 29 Oct 2025 10:06:56 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 985DF117F20FD;
	Wed, 29 Oct 2025 11:06:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1761732416; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=srQGehJNPlliVCDWLxoOJNAi36h0guxibWQc1xxoBBQ=;
	b=Tz7q9xu6Fv6aN1JPzSJ8MuzLFYhZuIn+B54dFrLBuz1cnU2oG15fa7juuEgZvZsixtdp2e
	aultH7ner3XuRnKk0HMSjTKIgGPGXVXOpJpafRgar4JexHMGIViXoDAbcRr+LabM1aT8yP
	N64rbNg6c8xuhcFfKlAg6ZqwBakT/5TQhr6nmx342IuuK0G1ULuCRdI9w28MN8hdiDYeMF
	7/KlVSJNW+i6I5KKzfdjsj2gNrVRR/baFrzwMGdTyt2NZEQWzeuwvaLc43C3kS9ZB/ewQJ
	IdjBhHd7gLYNthdImzoUsRvTXmjfNGPv8FAk1jHlkdCQ2kYBT6rY5rxnVig9/Q==
Date: Wed, 29 Oct 2025 11:06:51 +0100
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jiaming Zhang <r772577952@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuniyu@google.com, linux-kernel@vger.kernel.org, sdf@fomichev.me,
 syzkaller@googlegroups.com, Vladimir Oltean <vladimir.oltean@nxp.com>
Subject: Re: [Linux Kernel Bug] KASAN: null-ptr-deref Read in
 generic_hwtstamp_ioctl_lower
Message-ID: <20251029110651.25c4936d@kmaincent-XPS-13-7390>
In-Reply-To: <CANypQFZ8KO=eUe7YPC+XdtjOAvdVyRnpFk_V3839ixCbdUNsGA@mail.gmail.com>
References: <CANypQFZ8KO=eUe7YPC+XdtjOAvdVyRnpFk_V3839ixCbdUNsGA@mail.gmail.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello Jiaming,

+Vlad

On Wed, 29 Oct 2025 16:45:37 +0800
Jiaming Zhang <r772577952@gmail.com> wrote:

> Dear Linux kernel developers and maintainers,
>=20
> We are writing to report a null pointer dereference bug discovered in
> the net subsystem. This bug is reproducible on the latest version
> (v6.18-rc3, commit dcb6fa37fd7bc9c3d2b066329b0d27dedf8becaa).
>=20
> The root cause is in tsconfig_prepare_data(), where a local
> kernel_hwtstamp_config struct (cfg) is initialized using {}, setting
> all its members to zero. Consequently, cfg.ifr becomes NULL.
>=20
> cfg is then passed as: tsconfig_prepare_data() ->
> dev_get_hwtstamp_phylib() -> vlan_hwtstamp_get() (via
> dev->netdev_ops->ndo_hwtstamp_get) -> generic_hwtstamp_get_lower() ->
> generic_hwtstamp_ioctl_lower().
>=20
> The function generic_hwtstamp_ioctl_lower() assumes cfg->ifr is a
> valid pointer and attempts to access cfg->ifr->ifr_ifru. This access
> dereferences the NULL pointer, triggering the bug.

Thanks for spotting this issue!

In the ideal world we would have all Ethernet driver supporting the
hwtstamp_get/set NDOs but that not currently the case.=09
Vladimir Oltean was working on this but it is not done yet.=20
$ git grep SIOCGHWTSTAMP drivers/net/ethernet | wc -l
16
=20
> As a potential fix, we can declare a local struct ifreq variable in
> tsconfig_prepare_data(), zero-initializing it, and then assigning its
> address to cfg.ifr before calling dev_get_hwtstamp_phylib(). This
> ensures that functions down the call chain receive a valid pointer.

If we do that we will have legacy IOCTL path inside the Netlink path and th=
at's
not something we want.
In fact it is possible because the drivers calling
generic_hwtstamp_get/set_lower functions are already converted to hwtstamp =
NDOs
therefore the NDO check in tsconfig_prepare_data is not working on these ca=
se.

IMO the solution is to add a check on the ifr value in the
generic_hwtstamp_set/get_lower functions like that:

int generic_hwtstamp_set_lower(struct net_device *dev,
			       struct kernel_hwtstamp_config *kernel_cfg,
			       struct netlink_ext_ack *extack)
{
...

	/* Netlink path with unconverted lower driver */
	if (!kernel_cfg->ifr)
		return -EOPNOTSUPP;

	/* Legacy path: unconverted lower driver */
	return generic_hwtstamp_ioctl_lower(dev, SIOCSHWTSTAMP, kernel_cfg);
}

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

