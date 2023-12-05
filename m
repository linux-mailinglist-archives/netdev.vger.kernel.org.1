Return-Path: <netdev+bounces-53949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 751A98055F6
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14E0B1F2159F
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11DD15D902;
	Tue,  5 Dec 2023 13:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="oYT6o8rM"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3901FD59;
	Tue,  5 Dec 2023 05:31:26 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 540FF1BF20E;
	Tue,  5 Dec 2023 13:31:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1701783085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3gqjxkB/PoR9PK0/p2tRHlQoqY/I8JtjcwQCZSlgLSY=;
	b=oYT6o8rMXhMghdveIAj1Q5IC9/kN5OG8xDhayJh/RNtaph3N5hfRP9yzhfOUoJuSuW/56+
	2xpsmPvwSd1rZ3W9xYbxKync7rMT9nIEgol+RggTmB4d3jrjIEsIjkq4p7puFlMtdQll++
	NbvHWGHvhqWCyylpwOEXP7rSbPBQ8LON7meXloweBMsBMKWaz0/30pxQGfqA73JfNZFDXH
	/V7z0br8NY66kSHNcJHH26zi8jTMb4s6in6HJCxrggxY/3E6Bz2MZ2G+URYPo8Uz431aBW
	PYbuaui1Z0mxfZeZuVt+osyRdQwVns5elOkU4JYbNhIler2SFNufAqXEwNo/uQ==
Date: Tue, 5 Dec 2023 14:31:23 +0100
From: =?UTF-8?B?S8O2cnk=?= Maincent <kory.maincent@bootlin.com>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Jonathan Corbet <corbet@lwn.net>, Luis Chamberlain
 <mcgrof@kernel.org>, Russ Weight <russ.weight@linux.dev>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, Dent Project <dentproject@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH net-next v2 7/8] dt-bindings: net: pse-pd: Add bindings
 for PD692x0 PSE controller
Message-ID: <20231205143123.703589c8@kmaincent-XPS-13-7390>
In-Reply-To: <20231205111501.43f80846@kmaincent-XPS-13-7390>
References: <20231201-feature_poe-v2-0-56d8cac607fa@bootlin.com>
 <20231201-feature_poe-v2-7-56d8cac607fa@bootlin.com>
 <20231204230845.GH981228@pengutronix.de>
 <20231205063606.GI981228@pengutronix.de>
 <20231205111501.43f80846@kmaincent-XPS-13-7390>
Organization: bootlin
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: kory.maincent@bootlin.com

On Tue, 5 Dec 2023 11:15:01 +0100
K=C3=B6ry Maincent <kory.maincent@bootlin.com> wrote:

> On Tue, 5 Dec 2023 07:36:06 +0100
> Oleksij Rempel <o.rempel@pengutronix.de> wrote:
=20
> > I would expect a devicetree like this:
> >=20
> >         ethernet-pse@3c {
> > 	  // controller compatible should be precise
> >           compatible =3D "microchip,pd69210";
> >           reg =3D <0x3c>;
> >           #pse-cells =3D <1>;
> >          =20
> > 	  managers {
> > 	    manager@0 {
> > 	      // manager compatible should be included, since we are
> > 	      // able to campare it with communication results
> > 	      compatible =3D "microchip,pd69208t4"
> > 	      // addressing corresponding to the chip select addressing
> > 	      reg =3D <0>;
> >=20
> > 	      physical-ports {
> > 	        phys0: port@0 {
> > 		  // each of physical ports is actually a regulator

If this phys0 is a regulator, which device will be the consumer of this
regulator? log_port0 as the phys0 regulator consumer seems a bit odd!
A 8P8C node should be the consumer.

> > 		  reg =3D <0>;
> > 		};
> > 	        phys1: port@1 {
> > 		  reg =3D <1>;
> > 		};
> > 	        phys2: port@2 {
> > 		  reg =3D <2>;
> > 		};
> >=20
> >                ...
> > 	      }
> >=20
> >           // port matrix can be calculated by using this information
> >           logical-ports {
> > 	    log_port0: port@0 {
> > 	      // PoE4 port
> > 	      physical-ports =3D <&phys0, &phys1>;
> > 	    };
> > 	    log_port1: port@1 {
> > 	      // PoE2 port
> > 	      physical-ports =3D <&phys2>;
> > 	    };
> > 	  };
> >=20
> > ....
> >    ethernet-phy@1 {
> >      reg =3D <1>;
> >      pses =3D <&log_port0>;
> >    }
> >    ethernet-phy@2 {
> >      reg =3D <2>;
> >      pses =3D <&log_port1>;
> >    } =20

In fact if we want to really fit the PoE architecture topology we should wa=
it
for the support of 8P8C connector from Maxime. Then it will look like that:
SoC  --- i2c/uart --> controller -- spi --> manager0 -- phys_port0 --> 8P8C=
_connector0 (PoE4)
                                         |           \- phys_port1 --> 8P8C=
_connector0 (PoE4)
					 |	     \- phys_port2 --> 8P8C_connector1 (PoE2)
					 |	     \- phys_port3 --> 8P8C_connector2 (PoE2)
                                         \- manager1 -- phys_port0 ..

With this type of devicetree:
        ethernet-pse@3c {
	  // controller compatible should be precise
          compatible =3D "microchip,pd69210";
          reg =3D <0x3c>;
          #pse-cells =3D <1>;
         =20
	  managers {
	    manager@0 {
	      // manager compatible should be included, since we are
	      // able to compare it with communication results
	      compatible =3D "microchip,pd69208t4"
	      // addressing corresponding to the chip select addressing
	      reg =3D <0>;

	      physical-ports {
	        phys_port0: port@0 {
		  // each of physical ports is actually a regulator
		  reg =3D <0>;
		};
	        phy_port1: port@1 {
		  reg =3D <1>;
		};
	        phy_port2: port@2 {
		  reg =3D <2>;
		};

               ...
	      }
	    manager@1 {
            ...
            };
          };
	};

....
  rj45_0:8p8c@0 {
    pses =3D <&phy_port0, &phy_port1>;
  };
  rj45_1:8p8c@1 {
    pses =3D <&phy_port2>;
  };
  ethernet-phy@1 {
    reg =3D <1>;
    connector =3D <&rj45_0>;
  };
  ethernet-phy@2 {
    reg =3D <2>;
    connector =3D <&rj45_1>;
  }


The drawback is that I don't really know for now, how port matrix can be
calculated with this. Maybe by adding a "conf_pse_cell()" callback, call
in the of_pse_control_get() for each ports.

For now 8p8c connector are not supported, we could keep using pse phandle
in the phy node like you described but for physical port:
   ethernet-phy@1 {
     reg =3D <1>;
     pses =3D <&phy_port0, &phy_port1>;
   }
   ethernet-phy@2 {
     reg =3D <2>;
     pses =3D <&phy_port2>;
   }



Finally, the devicetree would not know the matrix between logical port and
physical port, this would be cleaner.

Did I miss something?

Regards,
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

