Return-Path: <netdev+bounces-119645-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A335B95675E
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 11:44:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C91701C20B42
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFB115D5B9;
	Mon, 19 Aug 2024 09:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="N7cKX30u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cZMQWZ3K"
X-Original-To: netdev@vger.kernel.org
Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C42C15B986;
	Mon, 19 Aug 2024 09:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724060682; cv=none; b=g69q+RG+yaUSTZ5zA3BJ3M3ottyEOZglDCl0Hc8dB/wR47HVUsOJtFpud5VCyExlBe0T3c9n/+sM6Gl7POhE1y8XIcL5df85TrV8xs1MyyB9DrRru2zbyyGKeV2+2pMCJ4iuO81ND9hZkCTO6vXjbeYxyPjLx6/+rfPdftMLC34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724060682; c=relaxed/simple;
	bh=F/lNjJTG8qdpk6McjXu92CkZOWhrTkgX7cioerSEJAk=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=E2fTyvO38AVc2Y/6ib6hKZp7yqPFNp2+KaByT/L273jp3nyWDMumtKgnDVp48NN7B7Jhy6/tdsMvEo4sKY/HTQoJ3O7T/bVM5QSfO5NaQmtyHrn4rV0HZCBR4pNjGUkUBmHRxDXo+ZAq3MAEGrV3C5oTEK4WwTd40wYHC44YKNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=N7cKX30u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cZMQWZ3K; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 9D7F211518F9;
	Mon, 19 Aug 2024 05:44:39 -0400 (EDT)
Received: from phl-imap-11 ([10.202.2.101])
  by phl-compute-04.internal (MEProxy); Mon, 19 Aug 2024 05:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1724060679;
	 x=1724147079; bh=M2Sy9uLZBrijLkKshf5fPTI4uHKT4t3a14A3XFHcLtU=; b=
	N7cKX30ukkPN2ESX/HM7oFLNlMA2NaZLwpDz/KZH52taVi/ZCQTv46WPXS9dgAZf
	E88EB2ALNg8niLYqMAYlSHE0T9dNBZUOgzJB05QD7aKcTz7sVOUd279YldcfJ84b
	XpmCVsZ7kM3L+CxeNL/c8TLv6Xh1oP8t4sCTkks7m0HQ27PA72O8j/Guiu+zajRT
	FFi2G+D3nq4Xf12Bk9AXUFbhCnHjEjhOOzvcqM98xFavRSLfzZQfUbFRI4rSjAJW
	bmY0Z465rf7oRY3rZBmVEA2MeI6s+0vaXHaKhRjlCIBTMXfvC2o88mIFT9v4SwQt
	emRFTNJaKEk70lwmESQbEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1724060679; x=
	1724147079; bh=M2Sy9uLZBrijLkKshf5fPTI4uHKT4t3a14A3XFHcLtU=; b=c
	ZMQWZ3K2bTZz9poh+Ovusx68QJFK5GDVbuHj8sLa94aSODLjeFp/RJ8tW2tW3ifs
	0NAPqfxsocDm5GtKbKoNO48tOBcjxnsySoWHieS2AOkCem/plan/xVEHNgfi+2eF
	Vk8vi8T1vteeeHUhmHDclOFBuXcfd7L3McTLPN3Al05l+nRqzJPNfb+cMYQDSzwT
	byO2AoXibIL1YPX9/lTPx5gX3uhgrelFpcDjYWVmzmitWmrKfPzWXzgePR3pjLen
	CrpJUr8OJvjThmp+5rBURYrDbJoa4eLYcFzTTFMRSU/itDXNzRKDtQyqppJKu6ZC
	MqhOC/PYec5shtSgJtpzw==
X-ME-Sender: <xms:BxTDZjIYlUVg-X8x1OHVnxsmwpKeAwPcr_HTuynCLuNK24UrU_iSVA>
    <xme:BxTDZnJVRobiXiV2Ta8E09UFkVVicqMU79tZMEZ3YjVc2jvjf2hYxG36HdVy2NxYM
    uaCCM4to9jkiEKHLCw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddugedgudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddt
    necuhfhrohhmpedftehrnhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrd
    guvgeqnecuggftrfgrthhtvghrnhephfdthfdvtdefhedukeetgefggffhjeeggeetfefg
    gfevudegudevledvkefhvdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepudef
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegurghvvghmsegurghvvghmlhhofh
    htrdhnvghtpdhrtghpthhtohepvgguuhhmrgiivghtsehgohhoghhlvgdrtghomhdprhgt
    phhtthhopehjihhrihhslhgrsgihsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehkuh
    gsrgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhrvghgkhhhsehlihhnuhigfhho
    uhhnuggrthhiohhnrdhorhhgpdhrtghpthhtoheptghorhgsvghtsehlfihnrdhnvghtpd
    hrtghpthhtohepphgrsggvnhhisehrvgguhhgrthdrtghomhdprhgtphhtthhopeguohhu
    ghesshgthhhmohhrghgrlhdrtghomhdprhgtphhtthhopehlihhnuhigqdguohgtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:BxTDZrslL_V5hJof3ZuxaDOdNrSmeebiercenMdR6N7zoWn_fP1vUQ>
    <xmx:BxTDZsZ-QPhzdKM2doQnxEff-DW1kJNbvkrX67FUTLMexwMFrxGOFg>
    <xmx:BxTDZqaiJ3Sn-6X3YYPNiOmps9sep1YN3z2F_KYEdWBEYy_gtqWcWA>
    <xmx:BxTDZgAB8Ha2jzQ7YLVYMp-vwJRmODA9lOkXum8VpTIf3XJBySddEg>
    <xmx:BxTDZmSsFDSp-_WTffx3LNPSVMYNre3rrJd2N9PGDI6dmI2f8ITYbeKu>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 202D416005E; Mon, 19 Aug 2024 05:44:39 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 19 Aug 2024 11:44:18 +0200
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Rodolfo Zitellini" <rwz@xhero.org>,
 "David S . Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>,
 "Paolo Abeni" <pabeni@redhat.com>, "Jonathan Corbet" <corbet@lwn.net>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 "Jiri Slaby" <jirislaby@kernel.org>
Cc: Netdev <netdev@vger.kernel.org>, linux-doc@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
 "Doug Brown" <doug@schmorgal.com>
Message-Id: <f1c86ed3-9306-459d-acb5-97730bfeb265@app.fastmail.com>
In-Reply-To: <20240817093316.9239-1-rwz@xhero.org>
References: <20240817093316.9239-1-rwz@xhero.org>
Subject: Re: [PATCH net-next 2/2] appletalk: tashtalk: Add LocalTalk line discipline
 driver for AppleTalk using a TashTalk adapter
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Sat, Aug 17, 2024, at 11:33, Rodolfo Zitellini wrote:
> This is the TashTalk driver, it perits for a modern machine to
> participate in a Apple LocalTalk network and is compatibile with
> Netatalk.
>
> Please see the included documentation for details:
> Documentation/networking/device_drivers/appletalk/index.rst
>
> Signed-off-by: Rodolfo Zitellini <rwz@xhero.org>

Hi Rodolfo,

Nice to see you got this into a working state! I vaguely
remember discussing this in the past, and suggesting you
try a user space solution, so it would be good if you can
add in the patch description why you ended up with a kernel
driver after all.

My main concern at this point is the usage of .ndo_do_ioctl.
I had previously sent patches to completely remove that
from the kernel, but never got around to send a new version
after the previous review. I still have them in my tree
and should be able to send them again, but that will obviously
conflict with your added use.

> +static struct net_device **tashtalk_devs;
> +
> +static int tash_maxdev = TASH_MAX_CHAN;
> +module_param(tash_maxdev, int, 0);
> +MODULE_PARM_DESC(tash_maxdev, "Maximum number of tashtalk devices");

You should not need to keep a list of the devices
or a module parameter to limit the number. I'm fairly sure
the devices are already tracked by the network stack in a
way that lets you enumerate them later.

> +static void tashtalk_send_ctrl_packet(struct tashtalk *tt, unsigned 
> char dst,
> +				      unsigned char src, unsigned char type);
> +
> +static unsigned char tt_arbitrate_addr_blocking(struct tashtalk *tt, 
> unsigned char addr);

Please try to avoid forward declations and instead reorder the
functions to put the callers after the calles.

> +static void tash_setbits(struct tashtalk *tt, unsigned char addr)
> +{
> +	unsigned char bits[33];
> +	unsigned int byte, pos;
> +
> +	/* 0, 255 and anything else are invalid */
> +	if (addr == 0 || addr >= 255)
> +		return;
> +
> +	memset(bits, 0, sizeof(bits));
> +
> +	/* in theory we can respond to many addresses */
> +	byte = addr / 8 + 1; /* skip initial command byte */
> +	pos = (addr % 8);
> +	bits[byte] = (1 << pos);

This is basically set_bit_le(), so you could use that
for clarity and use an array of 'unsigned long' words.

> +	set_bit(TTY_DO_WRITE_WAKEUP, &tt->tty->flags);
> +	tt->tty->ops->write(tt->tty, bits, sizeof(bits));
> +}

> +
> +static u16 tt_crc_ccitt_update(u16 crc, u8 data)
> +{
> +	data ^= (u8)(crc) & (u8)(0xFF);
> +	data ^= data << 4;
> +	return ((((u16)data << 8) | ((crc & 0xFF00) >> 8)) ^ (u8)(data >> 4) ^
> +		((u16)data << 3));
> +}

Can you use the global crc_ccitt() function instead of implementing
your own?

> +static int tt_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
> +{
> +	struct sockaddr_at *sa = (struct sockaddr_at *)&ifr->ifr_addr;
> +	struct tashtalk *tt = netdev_priv(dev);
> +	struct atalk_addr *aa = &tt->node_addr;
> +
> +	switch (cmd) {
> +	case SIOCSIFADDR:
> +
> +		sa->sat_addr.s_node =
> +			tt_arbitrate_addr_blocking(tt, sa->sat_addr.s_node);
> +
> +		aa->s_net = sa->sat_addr.s_net;
> +		aa->s_node = sa->sat_addr.s_node;
> +
> +		/* Set broadcast address. */
> +		dev->broadcast[0] = 0xFF;
> +
> +		/* Set hardware address. */
> +		dev->addr_len = 1;
> +		dev_addr_set(dev, &aa->s_node);
> +
> +		/* Setup tashtalk to respond to that addr */
> +		tash_setbits(tt, aa->s_node);
> +
> +		return 0;
> +
> +	case SIOCGIFADDR:
> +		sa->sat_addr.s_net = aa->s_net;
> +		sa->sat_addr.s_node = aa->s_node;
> +
> +		return 0;

As we discussed in the past, I think this really should
not use ndo_do_ioctl(), which instead should just disappear.

Please change the caller to use some other method of
setting the address in the driver.

> +static int tashtalk_ioctl(struct tty_struct *tty, unsigned int cmd,
> +			  unsigned long arg)
> +{
> +	struct tashtalk *tt = tty->disc_data;
> +	int __user *p = (int __user *)arg;
> +	unsigned int tmp;
> +
> +	/* First make sure we're connected. */
> +	if (!tt || tt->magic != TASH_MAGIC)
> +		return -EINVAL;
> +
> +	switch (cmd) {
> +	case SIOCGIFNAME:
> +		tmp = strlen(tt->dev->name) + 1;
> +		if (copy_to_user((void __user *)arg, tt->dev->name, tmp))
> +			return -EFAULT;
> +		return 0;
> +
> +	case SIOCGIFENCAP:
> +		if (put_user(tt->mode, p))
> +			return -EFAULT;
> +		return 0;
> +
> +	case SIOCSIFENCAP:
> +		if (get_user(tmp, p))
> +			return -EFAULT;
> +		tt->mode = tmp;
> +		return 0;
> +
> +	case SIOCSIFHWADDR:
> +		return -EINVAL;
> +
> +	default:
> +		return tty_mode_ioctl(tty, cmd, arg);
> +	}

I'm also not a bit fan of using the SIOC* command codes
in a tty device with incompatible argument types. I do
see that slip and x25 do the same, but it would be nice
to find a better interface for these. I have not looked
at all the other line disciplines, but maybe you can
find a better example to copy.

     Arnd

