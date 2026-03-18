Return-Path: <netdev+bounces-269144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GFwROYvhummdcwIAu9opvQ
	(envelope-from <netdev+bounces-269144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:31:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 631492C0532
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 18:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80261304A56E
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 17:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB182FF170;
	Wed, 18 Mar 2026 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4KeVKxG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B18BB2E888A
	for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 17:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773854809; cv=none; b=OienZJmk+lbM1O/uXRmJf1/gk25DKiUkTWbHDI3sNUZOOee5raK3nBix5tU6/u+JFe8QCq4VwBtvb3jLtTTp8lDmPrJCzNKYrDiNwBB0Sj67Bbk+pTp+kJa6ran2AirvdC/6Xw2vygrpPQ47LruF3TLITQwhKK6/hC3WPl9aVrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773854809; c=relaxed/simple;
	bh=W7ybQORcMKJdkf3BWpImd7y/jVljsB/C0BVysNSKorw=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6OfNWb499QliiHQB17LWKZVqcrtjgvvzCfpf+ucUhv8JTDbGVxraamPrd1azfhBfakoeBIb8zf4pQGvhla47IbVzWQtgGGmI1EKwnnV24DXG4DUveFfbLmUGmelSXNObpHmnKe9QK3eWveb7QaEWqkQspvR/bKNtGAKcqCfT9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4KeVKxG; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-48540d21f7dso1046975e9.0
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773854806; x=1774459606; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5EKjOvd8tsoDAzL2NTfko88oUtO7N2mQq0+WyC0PbRc=;
        b=W4KeVKxG4tII1s7aQw0Jv0GkSiKCwRZCRTCuUq2kO7Mu8krmc+aFOp8tQOAv52faVq
         OkE0IuRipgx1KER0lATSbnNYSK5TEnct+sFnXQN1Yk92p9PRflzF3NFyDdIMr4aHXBHw
         bbksQOD01GgOI8qCKDKW6rILlRFSjWYu30i0FU1ByNaalW9jbuW0wcGItXBE0OE+AQW0
         EBO12oaY35MHqV4AD3hUUVREyvwmc9NFA8MoOBbTMls2EjXKtscYx4wWCDTBknNpk97A
         WYzHftWKzZItMkrr2puesclWa51a5piysgCTEXTHZ6RSoVEp9l1QV+LFdjOJ5pdCaIIw
         w4Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773854806; x=1774459606;
        h=in-reply-to:content-disposition:mime-version:references:subject:cc
         :to:from:date:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5EKjOvd8tsoDAzL2NTfko88oUtO7N2mQq0+WyC0PbRc=;
        b=cKk9Q03+2BRpCeTYd5FUekYq3+tWosQlgAcUTxQ+HqgmTngSGY9eYDNLY2qg/x9Gti
         PvpQNr57Nhh1AvS3U7VvtR56Wj0mq8ESEU/++rFa0r44gRuM3/KREt43ZWhbGj+wqHCi
         DY5kRpgMFCsF6PIWaFRd1vhSpR8ORydR4SFFf/koImU+uj99fhulOZ2FvuAj+8bIwydm
         l6jWqSLUs8nEaGGxKFhEw29MT8NqmBmVEf6SPzJEMpkVQIkxCIfUy7JArS1wvrCOdcec
         4WpOF7Hx5ewyaBdUsMX5vXsiWp/jfEsO/ZxgtFEZwcGJ2sJ4LjdU7pMkrti39u606QZK
         ZgiA==
X-Forwarded-Encrypted: i=1; AJvYcCXFMlxQPTcOB3lxp5+CK0cCb76W0nHFKyXFiYbi/1p4mdLUFOjA7Ku6wQr3hevDoEs1Eq3E3oM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAQLLQjm3Ad/qggzQLuqjsUbTTSJs1Lfbawe3mfKlIsVRz4Juy
	oDSY3TrPJxs3mZK0iYCP64dKk7tu5SHsdXdwKKpHi5S4PXEYvKeqlKbs
X-Gm-Gg: ATEYQzxs3qCi2C9NajWoZGHXXsIIuNlfVlRNrOT4MpiXbpM4/hK+oxzNhC0vhoYVnuT
	36bd1zv/E7QS7QF7D7x2D5YG91+npWMk720hSp7kn/ZcyOZ92O9t+Manxcy0vIUkJAj7EBmnuCo
	+cE6juz7c5ewPMzJdN6QXraT9xPiKXH3Nbci582P/k4mqZCpFih6Zb0UE4SMQMlH3v2pccrDMYS
	gddOaw21U8MPPxmbBco1n3UjGc5QRwL7XPcCidIvS28abKHagMaHCjPESd1Ck3L5z/TvT4ugAoV
	ZzMj+qYOOu/WtQriLPwQCmnjsLCuPq/Va0D2Mk65yXtNGjXwLnSQAE2YjkY+vLc4HP/RMIgt6HS
	r4CqND/gexWE/ajXQVIPprHQvT7wHrkDfNY5C2P+GRXTUBQbDVTs5zH193vyaltvScYE/1PFn58
	jgPc4iQ+K2hiGlcGVPpr4v76RUMUu23yQDcylCIg4gtRiiN1W1YuJFwA==
X-Received: by 2002:a05:600c:8683:b0:485:f1d1:8f3d with SMTP id 5b1f17b1804b1-486f442e6e5mr52764705e9.6.1773854805737;
        Wed, 18 Mar 2026 10:26:45 -0700 (PDT)
Received: from Ansuel-XPS. (93-34-88-122.ip49.fastwebnet.it. [93.34.88.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-486f4e48ad5sm113684005e9.1.2026.03.18.10.26.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 10:26:45 -0700 (PDT)
Message-ID: <69bae055.050a0220.3719be.bf31@mx.google.com>
X-Google-Original-Message-ID: <abrgUo4L_FqciUrn@Ansuel-XPS.>
Date: Wed, 18 Mar 2026 18:26:42 +0100
From: Christian Marangi <ansuelsmth@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Jens Emil Schulz Ostergaard <jensemil.schulzostergaard@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>, UNGLinuxDriver@microchip.com,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Woojung Huh <woojung.huh@microchip.com>,
	Russell King <linux@armlinux.org.uk>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 2/8] dt-bindings: net: lan9645x: add LAN9645X
 switch bindings
References: <20260303-dsa_lan9645x_switch_driver_base-v1-2-bff8ca1396f5@microchip.com>
 <4088b0ff-b718-4137-8518-4c9b9764d56d@lunn.ch>
 <20260303-mosaic-debate-90cf8c8bbb33@spud>
 <1db45715a3a12b76b838d20c0e5904c3222053e7.camel@microchip.com>
 <20260305-reliant-parchment-0ff685a9c78e@spud>
 <7b62ace495084794336b19a9685d6b14ea3981a0.camel@microchip.com>
 <20260306-pointless-purr-210540d4dc64@spud>
 <207c7a47e0802dd4c34ba90f2532dc2e0c3f7f05.camel@microchip.com>
 <20260318-visiting-tanning-7d1d6acff081@spud>
 <20260318-placidly-domain-3ea82d265517@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-placidly-domain-3ea82d265517@spud>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269144-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[microchip.com,lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,armlinux.org.uk,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ansuelsmth@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.746];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mx.google.com:mid,0.0.0.0:email,0.0.0.1:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 631492C0532
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 05:20:03PM +0000, Conor Dooley wrote:
> On Wed, Mar 18, 2026 at 05:18:42PM +0000, Conor Dooley wrote:
> > Christian,
> > 
> > On Wed, Mar 18, 2026 at 03:19:20PM +0100, Jens Emil Schulz Ostergaard wrote:
> > > Hi Conor,
> > > 
> > > On Fri, 2026-03-06 at 15:20 +0000, Conor Dooley wrote:
> > > > On Fri, Mar 06, 2026 at 04:08:01PM +0100, Jens Emil Schulz Ostergaard wrote:
> > > > > On Thu, 2026-03-05 at 18:31 +0000, Conor Dooley wrote:
> > > > > > On Thu, Mar 05, 2026 at 01:57:37PM +0100, Jens Emil Schulz Ostergaard wrote:
> > > > > > > On Tue, 2026-03-03 at 19:04 +0000, Conor Dooley wrote:
> > > > > > > > On Tue, Mar 03, 2026 at 03:18:45PM +0100, Andrew Lunn wrote:
> > > > > > > > > > +        properties:
> > > > > > > > > > +          microchip,led-drive-mode:
> > > > > > > > > > +            $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > > > > > +            description: |
> > > > > > > > > > +              Set the LED drive mode for the copper PHY associated with
> > > > > > > > > > +              this port.
> > > > > > > > > > +
> > > > > > > > > > +                0 - LED1 and LED2 in open-drain mode
> > > > > > > > > > +                1 - LED1 in active drive mode (can be used for single-LED
> > > > > > > > > > +                    configurations requiring active drive)
> > > > > > > > > > +                2 - Reserved
> > > > > > > > > > +                3 - LED1 and LED2 in active drive mode
> > > > > > > > > > +            minimum: 0
> > > > > > > > > > +            maximum: 3
> > > > > > > > > 
> > > > > > > > > I doubt the DT Maintainers will accept that. This looks a lot like a
> > > > > > > > > value you write into a register. How are active drive and open-drain
> > > > > > > > > described in other DT bindings? Is there something you can reuse?
> > > > > > > > 
> > > > > > > > I had a quick look and I didn't see anything really that stood out to me
> > > > > > > > that would be a drop-in replacement.
> > > > > > > > I also tried looking in the datasheet for more information on these
> > > > > > > > modes, but I couldn't see anything obvious. For example, there were zero
> > > > > > > > hits for "drain" in either LAN9645xS or LAN9645xF datasheets.
> > > > > > > > 
> > > > > > > > That said, yea you're right about DT maintainer feelings about it.
> > > > > > > > There's a couple things I could suggest, but I'd like to know about what
> > > > > > > > mode 1 means for LED2 first. If there's actually nothing similar, what
> > > > > > > > about representing each led with a child node and having open-drain be
> > > > > > > > the default with a property in the child for active-drive?
> > > > > > > > 
> > > > > > > > > 
> > > > > > > > > For 1, what happens to LED2? Not used at all?
> > > > > > > 
> > > > > > > In mode 1 LED2 will be open-drain. This mode only makes sense if you have
> > > > > > > just 1 LED. With two LEDs mode 0 or mode 3 should be used.
> > > > > > 
> > > > > > Could we then have child nodes for each led, and have a property in each
> > > > > > that sets the mode to either open-drain or active-drive? Or am I just
> > > > > > inserting complexity by asking for that?
> > > > > 
> > > > > I think it sounds sensible, I will add this.
> > > > 
> > > > 
> > > > You don't need a property for each, just make one mode the default (prob
> > > > open-drain given it's the 0 setting, but whatever is default out of
> > > > reset for the part) and have the property for the other mode. Just
> > > > some bool property like "microchip,active-drive" or whatever.
> > > 
> > > 
> > > Based on your feedback I went with this under port properties:
> > > 
> > >           leds:
> > >             patternProperties:
> > >               '^led@[a-f0-9]+$':
> > >                 $ref: /schemas/leds/common.yaml#
> > > 
> > >                 properties:
> > >                   reg:
> > >                     maxItems: 1
> > > 
> > >                   microchip,active-drive:
> > >                     type: boolean
> > >                     description:
> > >                       Set the LED output to active drive mode. The default
> > >                       is open-drain.
> > > 
> > >                 required:
> > >                   - reg
> > > 
> > >                 unevaluatedProperties: false
> > > 
> > > and then the example has
> > > 
> > >           port@1 {
> > >             reg = <1>;
> > >             phy-mode = "gmii";
> > >             phy-handle = <&cuphy1>;
> > > 
> > >             leds {
> > >               #address-cells = <1>;
> > >               #size-cells = <0>;
> > > 
> > >               led@0 {
> > >                 reg = <0>;
> > >                 microchip,active-drive;
> > >               };
> > > 
> > >               led@1 {
> > >                 reg = <1>;
> > >                 microchip,active-drive;
> > >               };
> > >             };
> > >           }
> > > 
> > > However, this does not pass dt_binding_check because we pull in $ref: dsa-port.yaml,
> > > which pulls in ethernet-controller.yaml.
> > > 
> > > I believe the 'unevaluatedProperties: false' on LED nodes in ethernet-controller.yaml
> > > prevents downstream bindings from adding vendor-specific LED properties.
> > > 
> > > Is the right move removing unevaluatedProperties: false from the LED node in
> > > ethernet-controller.yaml, or is there a preferred way to extend per-port LEDs?
> > 
> > The addition looks recent enough, should probably ask Christian why it
> > was done this way and if removing it makes sense. Christian?
> > 
> 
> Ah shit, I autopiloted into sending. Actually +CC Christian this time.

Hi, give me some time to experiment... AFAIK with my limited info on DT,

unevaluatedProperties permits to add vendor property as long as they are
well defined. If the dt_binding_check is failing, then it's probably
because unevaluatedProperties is finding that in the expected LED node
there is extra stuff in the SCHEMA example.

But give me some time to experiment with some other SCHEMA.

-- 
	Ansuel

