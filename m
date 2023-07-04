Return-Path: <netdev+bounces-15290-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF4947469FA
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 08:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5BEF280F0F
	for <lists+netdev@lfdr.de>; Tue,  4 Jul 2023 06:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F6710E2;
	Tue,  4 Jul 2023 06:49:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C89ED8
	for <netdev@vger.kernel.org>; Tue,  4 Jul 2023 06:49:23 +0000 (UTC)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E285F10C1;
	Mon,  3 Jul 2023 23:49:13 -0700 (PDT)
Received: from [192.168.14.220] (unknown [159.196.94.230])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9014E2005F;
	Tue,  4 Jul 2023 14:49:11 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1688453351;
	bh=PGRdypURB7/bEiy3km3h+y8xHnGSZsusZVLuX9QWNis=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NrgFqCzjKIh0WZtBBLjlTbTJi1XZ5Mv2+Hi2TCHsQj87ntESLe9lIhYUU+vW1OrOo
	 XzfNKiMCj+Z9UUXPe5srPYBgtoKQtQc59vaecLH4nxsuU5ViMZXygHg9ilyEEpQeXd
	 J0KCz6i4XlJvdwNQ+GQRbDn90Ikn7QgzLaoCmQV6gaIDD/lC4RUGMT7HsKTo+mH0Rb
	 ELMkSq9SUw1+1vT8dC0qksJ1rU42VDaI4LIsebWTuL0OMQWW5QxH8RShfeDrMFtU9z
	 SKHW43bNebhoJs1P9zYwRo1aZa8Lvyome5vF4QFmySTC5K8QiNchYZWROFEZiKOl+L
	 SOeVOeIPCrjXg==
Message-ID: <a4c5090defc84625cbac5e16ed50dc8316dda755.camel@codeconstruct.com.au>
Subject: Re: [PATCH 3/3] mctp i3c: MCTP I3C driver
From: Matt Johnston <matt@codeconstruct.com.au>
To: Andrew Lunn <andrew@lunn.ch>
Cc: linux-i3c@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Jeremy Kerr <jk@codeconstruct.com.au>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>
Date: Tue, 04 Jul 2023 14:49:11 +0800
In-Reply-To: <8321002c-9b75-44da-9200-23d951148ae9@lunn.ch>
References: <20230703053048.275709-1-matt@codeconstruct.com.au>
	 <20230703053048.275709-4-matt@codeconstruct.com.au>
	 <8321002c-9b75-44da-9200-23d951148ae9@lunn.ch>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.1-0ubuntu1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Andrew,

On Mon, 2023-07-03 at 16:43 +0200, Andrew Lunn wrote:
> > +#define MCTP_I3C_MAXBUF 65536
> > +/* 48 bit Provisioned Id */
> > +#define PID_SIZE 6
> > +
> > +/* 64 byte payload, 4 byte MCTP header */
> > +static const int MCTP_I3C_MINMTU =3D 64 + 4;
> > +/* One byte less to allow for the PEC */
> > +static const int MCTP_I3C_MAXMTU =3D MCTP_I3C_MAXBUF - 1;
> > +/* 4 byte MCTP header, no data, 1 byte PEC */
> > +static const int MCTP_I3C_MINLEN =3D 4 + 1;
>=20
> Why static const and not #define? It would also be normal for
> variables to be lower case, to make it clear they are in fact
> variables, not #defines.

My personal preference is for static const since it's less error prone,
though had to use #define for the ones used in array sizing. Happy to chang=
e
to #define if that's the style though.

> > +struct mctp_i3c_bus {
> > +	struct net_device *ndev;
> > +
> > +	struct task_struct *tx_thread;
> > +	wait_queue_head_t tx_wq;
> > +	/* tx_lock protects tx_skb and devs */
> > +	spinlock_t tx_lock;
> > +	/* Next skb to transmit */
> > +	struct sk_buff *tx_skb;
> > +	/* Scratch buffer for xmit */
> > +	u8 tx_scratch[MCTP_I3C_MAXBUF];
> > +
> > +	/* Element of busdevs */
> > +	struct list_head list;
> > +
> > +	/* Provisioned ID of our controller */
> > +	u64 pid;
> > +
> > +	struct i3c_bus *bus;
> > +	/* Head of mctp_i3c_device.list. Protected by busdevs_lock */
> > +	struct list_head devs;
> > +};
> > +
> > +struct mctp_i3c_device {
> > +	struct i3c_device *i3c;
> > +	struct mctp_i3c_bus *mbus;
> > +	struct list_head list; /* Element of mctp_i3c_bus.devs */
> > +
> > +	/* Held while tx_thread is using this device */
> > +	struct mutex lock;
> > +
> > +	/* Whether BCR indicates MDB is present in IBI */
> > +	bool have_mdb;
> > +	/* I3C dynamic address */
> > +	u8 addr;
> > +	/* Maximum read length */
> > +	u16 mrl;
> > +	/* Maximum write length */
> > +	u16 mwl;
> > +	/* Provisioned ID */
> > +	u64 pid;
> > +};
>=20
> Since you have commented about most of the members of these
> structures, you could use kerneldoc.

These aren't intended to be exposed as an API anywhere, just commented
for future code readers (including me). Is kerneldoc still appropriate?
>=20
> > +/* We synthesise a mac header using the Provisioned ID.
> > + * Used to pass dest to mctp_i3c_start_xmit.
> > + */
> > +struct mctp_i3c_internal_hdr {
> > +	u8 dest[PID_SIZE];
> > +	u8 source[PID_SIZE];
> > +} __packed;
> > +
> > +/* Returns the 48 bit Provisioned Id from an i3c_device_info.pid */
> > +static void pid_to_addr(u64 pid, u8 addr[PID_SIZE])
> > +{
> > +	pid =3D cpu_to_be64(pid);
> > +	memcpy(addr, ((u8 *)&pid) + 2, PID_SIZE);
> > +}
> > +
> > +static u64 addr_to_pid(u8 addr[PID_SIZE])
> > +{
> > +	u64 pid =3D 0;
> > +
> > +	memcpy(((u8 *)&pid) + 2, addr, PID_SIZE);
> > +	return be64_to_cpu(pid);
> > +}
>=20
> I don't know anything about MCTP. But Ethernet MAC addresses are also
> 48 bits. Could you make use of u64_to_ether_addr() and ether_addr_to_u64(=
)?

The 48 bit identifier is an I3C Provisioned ID. It has a similar purpose to
an ethernet MAC address but for a different protocol. I think it might caus=
e
confusion to code readers if it were passed to ethernet functions.
>=20

> > +static int mctp_i3c_setup(struct mctp_i3c_device *mi)
> > +{
> > +	const struct i3c_ibi_setup ibi =3D {
> > +		.max_payload_len =3D 1,
> > +		.num_slots =3D MCTP_I3C_IBI_SLOTS,
> > +		.handler =3D mctp_i3c_ibi_handler,
> > +	};
> > +	bool ibi_set =3D false, ibi_enabled =3D false;
> > +	struct i3c_device_info info;
> > +	int rc;
> > +
> > +	i3c_device_get_info(mi->i3c, &info);
> > +	mi->have_mdb =3D info.bcr & BIT(2);
> > +	mi->addr =3D info.dyn_addr;
> > +	mi->mwl =3D info.max_write_len;
> > +	mi->mrl =3D info.max_read_len;
> > +	mi->pid =3D info.pid;
> > +
> > +	rc =3D i3c_device_request_ibi(mi->i3c, &ibi);
> > +	if (rc =3D=3D 0) {
> > +		ibi_set =3D true;
> > +	} else if (rc =3D=3D -ENOTSUPP) {
>=20
> In networking, we try to avoid ENOTSUPP and use EOPNOTSUPP:
>=20
> https://lore.kernel.org/netdev/20200511165319.2251678-1-kuba@kernel.org/

checkpatch noticed this one too, but the existing I3C functions return
ENOTSUPP so it needs to match against that.

> > +static int mctp_i3c_header_create(struct sk_buff *skb, struct net_devi=
ce
> > *dev,
> > +				  unsigned short type, const void
> > *daddr,
> > +	   const void *saddr, unsigned int len)
> > +{
> > +	struct mctp_i3c_internal_hdr *ihdr;
> > +
> > +	skb_push(skb, sizeof(struct mctp_i3c_internal_hdr));
> > +	skb_reset_mac_header(skb);
> > +	ihdr =3D (void *)skb_mac_header(skb);
> > +	memcpy(ihdr->dest, daddr, PID_SIZE);
> > +	memcpy(ihdr->source, saddr, PID_SIZE);
>=20
> ether_addr_copy() ?
>=20
> > +/* Returns an ERR_PTR on failure */
> > +static struct mctp_i3c_bus *mctp_i3c_bus_add(struct i3c_bus *bus)
> > +__must_hold(&busdevs_lock)
> > +{
> > +	struct mctp_i3c_bus *mbus =3D NULL;
> > +	struct net_device *ndev =3D NULL;
> > +	u8 addr[PID_SIZE];
> > +	char namebuf[IFNAMSIZ];
> > +	int rc;
> > +
> > +	if (!mctp_i3c_is_mctp_controller(bus))
> > +		return ERR_PTR(-ENOENT);
> > +
> > +	snprintf(namebuf, sizeof(namebuf), "mctpi3c%d", bus->id);
> > +	ndev =3D alloc_netdev(sizeof(*mbus), namebuf, NET_NAME_ENUM,
> > mctp_i3c_net_setup);
> > +	if (!ndev) {
> > +		pr_warn("No memory for %s\n", namebuf);
>=20
> pr_ functions are not liked too much. Is there a struct device you can
> use with dev_warn()?

I'll change the ones with a device available, that one in particular can be
removed anyway.

Thanks,
Matt

