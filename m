Return-Path: <netdev+bounces-24283-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA20476F9BD
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 07:57:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9977C282404
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 05:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3E2C522A;
	Fri,  4 Aug 2023 05:57:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952E51FC8
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 05:57:48 +0000 (UTC)
Received: from smtpbg151.qq.com (smtpbg151.qq.com [18.169.211.239])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81EFE2708
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 22:57:44 -0700 (PDT)
X-QQ-mid:Yeas47t1691128596t732t56834
Received: from 3DB253DBDE8942B29385B9DFB0B7E889 (jiawenwu@trustnetic.com [125.119.251.0])
X-QQ-SSF:00400000000000F0FQF000000000000
From: =?utf-8?b?Smlhd2VuIFd1?= <jiawenwu@trustnetic.com>
X-BIZMAIL-ID: 8784499072271469170
To: "'Russell King \(Oracle\)'" <linux@armlinux.org.uk>
Cc: <netdev@vger.kernel.org>,
	<andrew@lunn.ch>,
	<hkallweit1@gmail.com>,
	<Jose.Abreu@synopsys.com>,
	<mengyuanlou@net-swift.com>
References: <20230724102341.10401-5-jiawenwu@trustnetic.com> <ZL5TujWbCDuFUXb2@shell.armlinux.org.uk> <03cc01d9be9c$6e51cad0$4af56070$@trustnetic.com> <ZL9+XZA8t1vaSVmG@shell.armlinux.org.uk> <03f101d9bedd$763b06d0$62b11470$@trustnetic.com> <ZL+cwbCd6eTU4sC8@shell.armlinux.org.uk> <ZL+fF4365f0Q9QDD@shell.armlinux.org.uk> <052c01d9c13b$edc25ef0$c9471cd0$@trustnetic.com> <ZMOZkzCqiUZP/uQ8@shell.armlinux.org.uk> <068501d9c5b1$0e263ad0$2a72b070$@trustnetic.com> <ZMuLKa2HX9/LiCPn@shell.armlinux.org.uk>
In-Reply-To: <ZMuLKa2HX9/LiCPn@shell.armlinux.org.uk>
Subject: RE: [PATCH net-next 4/7] net: pcs: xpcs: adapt Wangxun NICs for SGMII mode
Date: Fri, 4 Aug 2023 13:56:35 +0800
Message-ID: <071c01d9c698$6d814fa0$4883eee0$@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQHlV8ySIJxDOVsue1vtJKXvPgm7WQHq1YyvAkVmz6sBytGrVAIdGgySAzyQo7ECIz2R/AHpKtnAAfaBl44C3nHZLAFERt5frxZm9QA=
Content-Language: zh-cn
X-QQ-SENDSIZE: 520
Feedback-ID: Yeas:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,FROM_EXCESS_BASE64,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thursday, August 3, 2023 7:11 PM, Russell King (Oracle) wrote:
> On Thu, Aug 03, 2023 at 10:20:22AM +0800, Jiawen Wu wrote:
> > > No there isn't, and it conforms with the above.
> > >
> > > A read looks like this:
> > >
> > >       Address  Data                   Address  Data     Data
> > > Start 10101100 000yyyyy RepeatedStart 10101101 DDDDDDDD DDDDDDDD =
Stop
> > >                       or Stop followed
> > > 		          by Start
> > >
> > > The terms "Address" and "Data" here are as per the I=B2C =
specification.
> > > You will notice that the first part has one byte of address and =
*one*
> > > byte of data to convey the register address. This is what the "1" =
you
> > > are referring to above is for.
> > >
> > > For completness, a write looks like this:
> > >
> > >       Address  Data     Data     Data
> > > Start 10101100 000yyyyy DDDDDDDD DDDDDDDD Stop
> > >
> > > Essentially, in all cases, when 0x56 is addressed with the data
> > > direction in write mode, the very first byte is _always_ the =
register
> > > address and the remainder contain the data. When the data =
direction is
> > > in read mode, the bytes are always data.
> > >
> > > The description you quote above is poor because it doesn't make it
> > > clear whether "read" and "write" apply to the bus transactions or =
to
> > > the device operations. However, I can assure you that what is
> > > implemented is correct, since this is the standard small 24xx =
memory
> > > device protocol, and I've been programming that on various
> > > microcontrollers and such like for the last 30 years.
> > >
> > > Are you seeing a problem with the data read or written to the PHY?
> >
> > Hi Russell,
> >
> > I really don't know how to deal with "MAC side SGMII", could you =
please
> > help me?
> >
> > From the test results, when I config PCS in "PHY side SGMII", the =
link status
> > of PHY in copper SFP is read by I2C after AN complete. Then PHY's =
link up
> > status is informed to PHYLINK, then PCS will check its status. But =
when I just
> > change PCS to "MAC side SGMII", I2C will keep reading timeouts since =
AN
> > complete. I checked the register of PCS to confirm AN complete, but =
PHY's
> > link status would never be updated in PHYLINK.
>=20
> I don't understand what is going on here either - but what I do know
> is that there is _zero_ difference as far as the network link is
> concerned between an on-board PHY using SGMII to the MAC/PCS and a SFP
> with a PHY using SGMII.
>=20
> In both situations the PHY behaves the same - it presents a PHY-side
> SGMII interface, so it sends to the MAC/PCS the speed and duplex
> settings, and expects the MAC/PCS to acknowledge them.
>=20
> The name "MAC side SGMII" suggests that this mode provides the
> acknowledgement, whereas "PHY side SGMII" suggests that this mode
> provides a speed and duplex.
>=20
> Given all this, using "PHY side SGMII" with a SFP, and "MAC side
> SGMII" for an on-board PHY just seems utterly wrong - and I can't
> make head nor tail of it.

Since no reasonable explanation can be given, can we assume that there =
is a
design flaw in the hardware? Although it's not clear to the designers...

>=20
> > It's kind of weird to me, how does the configuration of PCS relate =
to I2C?
>=20
> I2C is just the access method for PHYs on SFPs - because there are
> no MDIO bus pins on SFP modules, only I2C pins mainly for accessing
> the identification EEPROM and diagnostics, but many copper SFPs have
> a way to access the PHY.
>=20
> I2C is transparent as far as phylib is concerned - the mdio-i2c
> driver makes the PHY "appear" as if it is on a conventional MDIO
> bus.
=20


