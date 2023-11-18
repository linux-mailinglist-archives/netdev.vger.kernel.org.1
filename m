Return-Path: <netdev+bounces-48942-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9200E7F01B4
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 18:48:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3CED1C2089B
	for <lists+netdev@lfdr.de>; Sat, 18 Nov 2023 17:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E93B19456;
	Sat, 18 Nov 2023 17:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="HePM0ZXP"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F1B1AD;
	Sat, 18 Nov 2023 09:48:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+oEK+naRT7fW5EmkfkwfcZ0PjJ55q4+LYYoW9SH6u1U=; b=HePM0ZXPAC/PI8Lw9i2KLfA7mi
	4EuQtKy3Y7iuastmCWwV8xra5eppTwA+BrM10mzpmi26wbpVpU9I0DwoGDtQHOojDHxjfQzccwCmO
	U3gNgkxehXqEdI3JkjHR/pWiEPfOxd2+2kr9Fj+XaovLLh/ZtaZwpBsyi2LKHeMtNiQE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1r4PQ6-000WHI-4p; Sat, 18 Nov 2023 18:47:50 +0100
Date: Sat, 18 Nov 2023 18:47:50 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Kory Maincent <kory.maincent@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH net-next 8/9] dt-bindings: net: pse-pd: Add bindings for
 PD692x0 PSE controller
Message-ID: <2332a2e2-740f-49a6-8bef-d90ed010a434@lunn.ch>
References: <20231116-feature_poe-v1-0-be48044bf249@bootlin.com>
 <20231116-feature_poe-v1-8-be48044bf249@bootlin.com>
 <6b39c522-1486-4e30-b958-b8a57104cede@linaro.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b39c522-1486-4e30-b958-b8a57104cede@linaro.org>

> > +  ports-matrix:
> > +    description: Port conversion matrix configuration
> 
> I do not see such property defined anywhere. Your description should
> explain what the purpose is and what it is exactly. Currently you just
> repeat property name, so quite pointless.

I have to agree. You appear to have a device which can supply power to
48 RJ-45 connectors on the front panel? Which probably maps to 48
ports of a Ethernet switch. How do i use these properties described
here to say that eth42 connects to port 42 of the PSE?

> > +    $ref: /schemas/types.yaml#/definitions/uint32-matrix
> > +    minItems: 1
> > +    maxItems: 48
> > +    items:
> > +      items:
> > +        - description: Logical port number
> > +          minimum: 0
> > +          maximum: 47
> > +        - description: Physical port number A (0xff for undefined)
> > +          oneOf:
> > +            - minimum: 0
> > +              maximum: 95
> > +            - const: 0xff
> > +        - description: Physical port number B (0xff for undefined)

It would be good to explain what Port A and B are. It might be obvious
to somebody who knows PSE, but i have no idea...

   Andrew

