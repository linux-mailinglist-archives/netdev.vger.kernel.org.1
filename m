Return-Path: <netdev+bounces-53840-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C56D8804D3C
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 10:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 64EE01F20FF0
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 09:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3AC3D98C;
	Tue,  5 Dec 2023 09:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embedd.com header.i=@embedd.com header.b="YhwTEFzM";
	dkim=pass (1024-bit key) header.d=embedd.com header.i=@embedd.com header.b="lDa56nBu"
X-Original-To: netdev@vger.kernel.org
Received: from mail.as201155.net (mail.as201155.net [185.84.6.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 536FDC9
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 01:09:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com;
	s=dkim1; h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:
	In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=x19Sv6z52QCXWKoTdf1KWigGPHEuXpj7RBFBo61Rw6A=; b=YhwTEFzMPnsKlYXqhxUPi7kz0S
	0SkvTE/N8gQlAqZQ6C6sP+XKz00DCNI2rMt01Bsi6U4Vo2plzMFu3/Wnr1efkuIK1sxx8Gy2LRlOb
	VNHPlbtBlyWu8Hrz4YB7BBoBfJlA88ZPkA+xeJfnmvkjvKxlQYZA0tP8pkCVbj70CTNi+RAmWrdPu
	Q9/+ly02gv3MhgvTnq/QVnuC2yqXu5xzJMQIzcEpriDX+HiC1Io5Kica1yDDQY5neM0xTCnj9r9K2
	CvPAYJl9tiz4/mGQMZ2aJiiOjQHyVVUKSw4Y6y13CvnPwOih0QFpm2GSNB76Yr5wIBgoOuKPpLqW/
	naxvSAMA==;
Received: from smtps.newmedia-net.de ([2a05:a1c0:0:de::167]:41514 helo=webmail.newmedia-net.de)
	by mail.as201155.net with esmtps  (TLS1) tls TLS_RSA_WITH_AES_256_CBC_SHA
	(Exim 4.96)
	(envelope-from <dd@embedd.com>)
	id 1rARQI-0008R0-0y;
	Tue, 05 Dec 2023 10:08:58 +0100
X-SASI-Hits: BODY_SIZE_6000_6999 0.000000, BODY_SIZE_7000_LESS 0.000000,
	CTE_QUOTED_PRINTABLE 0.000000, CT_TEXT_PLAIN_UTF8_CAPS 0.000000,
	DKIM_ALIGNS 0.000000, DKIM_SIGNATURE 0.000000, HTML_00_01 0.050000,
	HTML_00_10 0.050000, IN_REP_TO 0.000000, LEGITIMATE_SIGNS 0.000000,
	MSG_THREAD 0.000000, MULTIPLE_RCPTS 0.100000, MULTIPLE_REAL_RCPTS 0.000000,
	NO_FUR_HEADER 0.000000, OUTBOUND 0.000000, OUTBOUND_SOPHOS 0.000000,
	REFERENCES 0.000000, RETURN_RECEIPT 0.500000, SENDER_NO_AUTH 0.000000,
	SINGLE_URI_IN_BODY 0.000000, SUSP_DH_NEG 0.000000,
	URI_WITH_PATH_ONLY 0.000000, __ANY_URI 0.000000, __BODY_NO_MAILTO 0.000000,
	__BOUNCE_CHALLENGE_SUBJ 0.000000, __BOUNCE_NDR_SUBJ_EXEMPT 0.000000,
	__BULK_NEGATE 0.000000, __CC_NAME 0.000000, __CC_NAME_DIFF_FROM_ACC 0.000000,
	__CC_REAL_NAMES 0.000000, __CP_URI_IN_BODY 0.000000, __CT 0.000000,
	__CTE 0.000000, __CT_TEXT_PLAIN 0.000000, __DKIM_ALIGNS_1 0.000000,
	__DKIM_ALIGNS_2 0.000000, __DQ_NEG_DOMAIN 0.000000, __DQ_NEG_HEUR 0.000000,
	__DQ_NEG_IP 0.000000, __FORWARDED_MSG 0.000000,
	__FROM_NAME_NOT_IN_ADDR 0.000000, __FUR_RDNS_SOPHOS 0.000000,
	__HAS_CC_HDR 0.000000, __HAS_FROM 0.000000, __HAS_MSGID 0.000000,
	__HAS_REFERENCES 0.000000, __HEADER_ORDER_FROM 0.000000,
	__HTTPS_URI 0.000000, __IN_REP_TO 0.000000, __MAIL_CHAIN 0.000000,
	__MIME_BOUND_CHARSET 0.000000, __MIME_TEXT_ONLY 0.000000,
	__MIME_TEXT_P 0.000000, __MIME_TEXT_P1 0.000000, __MIME_VERSION 0.000000,
	__MULTIPLE_RCPTS_CC_X2 0.000000, __NOTIFICATION_TO 0.000000,
	__NO_HTML_TAG_RAW 0.000000, __OUTBOUND_SOPHOS_FUR 0.000000,
	__OUTBOUND_SOPHOS_FUR_IP 0.000000, __OUTBOUND_SOPHOS_FUR_RDNS 0.000000,
	__RCVD_PASS 0.000000, __REFERENCES 0.000000, __SANE_MSGID 0.000000,
	__SCAN_D_NEG 0.000000, __SCAN_D_NEG2 0.000000, __SCAN_D_NEG_HEUR 0.000000,
	__SCAN_D_NEG_HEUR2 0.000000, __SINGLE_URI_TEXT 0.000000,
	__SUBJ_ALPHA_END 0.000000, __SUBJ_ALPHA_NEGATE 0.000000,
	__SUBJ_REPLY 0.000000, __TO_GMAIL 0.000000, __TO_MALFORMED_2 0.000000,
	__TO_NAME 0.000000, __TO_NAME_DIFF_FROM_ACC 0.000000,
	__TO_REAL_NAMES 0.000000, __URI_ENDS_IN_SLASH 0.000000,
	__URI_HAS_HYPHEN_USC 0.000000, __URI_IN_BODY 0.000000, __URI_MAILTO 0.000000,
	__URI_NOT_IMG 0.000000, __URI_NO_WWW 0.000000, __URI_NS 0.000000,
	__URI_WITH_PATH 0.000000, __USER_AGENT 0.000000, __WEBINAR_PHRASE 0.000000,
	__X_MAILSCANNER 0.000000
X-SASI-Probability: 10%
X-SASI-RCODE: 200
X-SASI-Version: Antispam-Engine: 5.1.4, AntispamData: 2023.12.5.83316
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=embedd.com; s=mikd;
	h=MIME-Version:Content-Transfer-Encoding:Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID; bh=x19Sv6z52QCXWKoTdf1KWigGPHEuXpj7RBFBo61Rw6A=;
	b=lDa56nBu9/s2BssLdKdlrm5r2vfut7gODzBxx9IDCCY0EdXqm6u9d2X4azvyyuU+wA1PwahKjWWckaAOm2RFJiyeadBx22QSsUxWuDjnCo5WvI+znOtWouei57MFKvx14Ok1wH4fy6qAd3OzaS0YAP6bsUmMD2cW4CzlxO8c8Bw=;
Message-ID: <b309ba69b9e97f8e681f814fda1bb069e11e367d.camel@embedd.com>
Subject: Re: [PATCH] net: dsa: microchip: fix NULL pointer dereference on
 platform init
From: Daniel Danzberger <dd@embedd.com>
To: Vladimir Oltean <olteanv@gmail.com>
Cc: woojung.huh@microchip.com, UNGLinuxDriver@microchip.com, 
	netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli
	 <f.fainelli@gmail.com>
Date: Tue, 05 Dec 2023 10:08:39 +0100
In-Reply-To: <20231205083646.h2tqkwourtdyzdee@skbuf>
References: <20231204154315.3906267-1-dd@embedd.com>
	 <20231204174330.rjwxenuuxcimbzce@skbuf>
	 <20231204154315.3906267-1-dd@embedd.com>
	 <20231204174330.rjwxenuuxcimbzce@skbuf>
	 <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>
	 <577c2f8511b700624cdfdf75db5b1a90cf71314b.camel@embedd.com>
	 <20231205083646.h2tqkwourtdyzdee@skbuf>
Disposition-Notification-To: dd@embedd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received-SPF: pass (webmail.newmedia-net.de: localhost is always allowed.) client-ip=127.0.0.1; envelope-from=dd@embedd.com; helo=webmail.newmedia-net.de;
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: dd@embedd.com
X-SA-Exim-Scanned: No (on webmail.newmedia-net.de); SAEximRunCond expanded to false
X-NMN-MailScanner-Information: Please contact the ISP for more information
X-NMN-MailScanner-ID: 1rARQ0-0002Xu-N0
X-NMN-MailScanner: Found to be clean
X-NMN-MailScanner-From: dd@embedd.com
X-Received:  from localhost.localdomain ([127.0.0.1] helo=webmail.newmedia-net.de)
	by webmail.newmedia-net.de with esmtp (Exim 4.72)
	(envelope-from <dd@embedd.com>)
	id 1rARQ0-0002Xu-N0; Tue, 05 Dec 2023 10:08:40 +0100

On Tue, 2023-12-05 at 10:36 +0200, Vladimir Oltean wrote:
> On Tue, Dec 05, 2023 at 09:00:39AM +0100, Daniel Danzberger wrote:
> > > Is this all that's necessary for instantiating the ksz driver through
> > > ds->dev->platform_data? I suppose not, so can you post it all, please=
?
> > Yes, that NULL pointer was the only issue I encountered.
> >=20
> > Here is the module I use to instantiate the switch, which works fine so=
 far in our
> > linux v6.1 x86_64 builds:
> > --
> > #include <linux/kernel.h>
> > #include <linux/module.h>
> > #include <linux/i2c.h>
> > #include <linux/netdevice.h>
> > #include <net/dsa.h>
> >=20
> > static struct i2c_client *i2cdev;
> >=20
> > static struct dsa_chip_data ksz9477_dsa =3D {
> > 	.port_names =3D {
> > 		"cpu",
> > 		"lan1",
> > 		"lan2",
> > 		"lan3",
> > 		"lan4"
> > 	}
> > };
> >=20
> > static struct i2c_board_info t2t_ngr421_i2c_board_info =3D {
> > 	I2C_BOARD_INFO("ksz9477-switch", 0x5f),
> > 	.platform_data	=3D &ksz9477_dsa,
> > };
> >=20
> > static int __init t2t_ngr421_platform_init(void)
> > {
> > 	struct i2c_adapter *adapter =3D i2c_get_adapter(11);
> > 	struct net_device *netdev_cpu =3D NULL, *nd;
> >=20
> > 	if (adapter =3D=3D NULL) {
> > 		pr_err("t2t-ngr421: Missing FT260 I2C Adapter");
> > 		return -ENODEV;
> > 	}
> >=20
> > 	read_lock(&dev_base_lock);
> > 	for_each_netdev(&init_net, nd) {
> > 		if (!strcmp(nd->name, "eth0")) {
> > 			netdev_cpu =3D nd;
> > 			break;
> > 		}
> > 	}
> > 	read_unlock(&dev_base_lock);
> >=20
> > 	if (netdev_cpu =3D=3D NULL) {
> > 		pr_err("t2t-ngr421: Missing netdev eth0");
> > 		return -ENODEV;
> > 	}
> > 	=09
> > 	ksz9477_dsa.netdev[0] =3D &netdev_cpu->dev;
> > 	i2cdev =3D i2c_new_client_device(adapter, &t2t_ngr421_i2c_board_info);
> > 	return i2cdev ? 0 : -ENODEV;
> > }
> >=20
> > static void t2t_ngr421_platform_deinit(void)
> > {
> > 	if (i2cdev)
> > 		i2c_unregister_device(i2cdev);
> > }
> >=20
> > module_init(t2t_ngr421_platform_init);
> > module_exit(t2t_ngr421_platform_deinit);
> >=20
> > MODULE_AUTHOR("Daniel Danzberger <dd@embedd.com>");
> > MODULE_DESCRIPTION("T2T NGR421 platform driver");
> > MODULE_LICENSE("GPL v2");
> > --
>=20
> Pfff, I hate that "eth0" search. If you have a udev naming rule and the
> driver is built as a module, you break it. Although you don't even need
> that. Insert a USB to Ethernet adapter and all bets are off regarding
> which one is eth0 and which one is eth1. It's good as prototyping code
> and not much more.
>=20
> Admittedly, that's the only thing that DSA offers currently when there's
> no firmware description of the switch, but I think it wouldn't even be
> that hard to do better. Someone needs to take a close look at Marcin
> Wojtas' work of converting DSA to fwnode APIs
> https://lore.kernel.org/netdev/20230116173420.1278704-1-mw@semihalf.com/
> then we could replace the platform_data with software nodes and reference=
s.
> That should actually be in our own best interest as maintainers, since
> it should unify the handling of the 2 probing cases in the DSA core.
> I might be able to find some time to do that early next year.
>=20
> Except for dsa_loop_bdinfo.c which is easy to test by anyone, I don't
> see any other board init code physically present in mainline. So please
> do _not_ submit the board code, so I can pretend I didn't see it, and
> for the responsibility of converting it to the new API to fall on you :)
>=20
> (or, of course, you may want to take on the bigger task yourself ahead
> of me, case in which your board code, edited to use fwnode_create_softwar=
e_node(),
> would be perfectly welcome in mainline)
That module is just a way to instantiate the switch on a piece of fixed cus=
tom hardware glued
together on my desk. It's never meant to be upstream. I just posted it as a=
n example on how the
switch can be instantiated via 'i2c_new_client_device' instead of DTS.

>=20
> But let's do something about the ksz driver's use of the platform_data
> structures, since it wasn't even on my radar of something that might be
> able to support that use case. More below.
>=20
> > > Looking at dsa_switch_probe() -> dsa_switch_parse(), it expects
> > > ds->dev->platform_data to contain a struct dsa_chip_data. This is in
> > > contrast with ksz_spi.c, ksz9477_i2c.c and ksz8863_smi.c, which expec=
t
> > > the dev->platform_data to have the struct ksz_platform_data type.
> > > But struct ksz_platform_data does not contain struct dsa_chip_data as
> > > first element.
> >=20
> > Noticed that as well.
> > But hence the 'struct ksz_platform_data' isn't used anywhere, I passed =
(see module above)
> > 'struct
> > dsa_chip_data' directly.
>=20
> What do you mean struct ksz_platform_data isn't used anywhere? What about=
 this?
{
	u8 id1, id2, id4;
	u16 id16;
	u32 id32;
	int ret;

	/* read chip id */
	ret =3D ksz_read16(dev, REG_CHIP_ID0, &id16);
	if (ret)
		return ret;

>  isn't used anywhere? What about this?
>=20
> int ksz_switch_register(struct ksz_device *dev)
> {
> 	const struct ksz_chip_data *info;
> 	struct device_node *port, *ports;
> 	phy_interface_t interface;
> 	unsigned int port_num;
> 	int ret;
> 	int i;
>=20
> 	if (dev->pdata)
> 		dev->chip_id =3D dev->pdata->chip_id;
>=20
> with dev->pdata assigned like this:
>=20
> static int ksz9477_i2c_probe(struct i2c_client *i2c)
> {
> 	struct ksz_device *dev;
>=20
> 	dev =3D ksz_switch_alloc(&i2c->dev, i2c);
> 	if (!dev)
> 		return -ENOMEM;
>=20
> 	if (i2c->dev.platform_data)
> 		dev->pdata =3D i2c->dev.platform_data;

The pointer is only copied around, but ksz_platform_data is never actually =
accessed in any
meaningful way. The chip_id assigned from DTS or platform_data doesn't even=
 seem to be respected
anywhere in the decision making.

Right at 'ksz_switch_register', 'ksz_switch_detect' is called and overwrite=
s 'dev->chip_id' with the
id read from the hardware:

static int ksz_switch_detect(struct ksz_device *dev)
{
	u8 id1, id2, id4;
	u16 id16;
	u32 id32;
	int ret;

	/* read chip id */
	ret =3D ksz_read16(dev, REG_CHIP_ID0, &id16);
	if (ret)
		return ret;


>=20

--=20
Regards

Daniel Danzberger
embeDD GmbH, Alter Postplatz 2, CH-6370 Stans

