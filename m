Return-Path: <netdev+bounces-42646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A027CFB67
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:41:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB0A51C20A5B
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 13:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1653E2746A;
	Thu, 19 Oct 2023 13:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47163DDA6;
	Thu, 19 Oct 2023 13:41:13 +0000 (UTC)
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1F8E124;
	Thu, 19 Oct 2023 06:41:11 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1ead2e6fab7so308143fac.0;
        Thu, 19 Oct 2023 06:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697722871; x=1698327671;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9AD1JfVARQKPIgD2WtIcrrwf03qLXP4ogD7h2MXnzs=;
        b=UkJEI/pXD4KPH2ytekF3NTYXeBay0H1w+qOxvUldpMFFYYLq1OfPF/BQe86+fHxpU5
         tZqipzGa6T7stLlDGV6/BLOVY/EU77KuNangC9/TsgamsBMhYbwH4xzWKZ51qqruSENh
         yiRRvBYWRkthGXo3RCTeIEOVnhU7Y1hw9VG6ETDQQ7m4syLnYJ0hN21Z0X8f4nfIIyqB
         pEeXb3xoSCK5n0JjSPwjukSG6neLks3or2TSd0ynqUcUcw8Cmcz3/m2iIMrqczvKgbpW
         M9kKTfPOp5Ou03CVABHrCW6LnqejgzY+9yxI5hDrdYcwkYfbATjFpNUnySZoesJgQyBd
         C83w==
X-Gm-Message-State: AOJu0YyZPQRsUDQJpBd3RrPj40dVIT5aqSU/riP6Aaama2SOH9m4MLj7
	WHH8uhA0tt9w6yHqiSkpQw==
X-Google-Smtp-Source: AGHT+IHlen4DCcYIWDQZw3HdnzAxhSVqjwrtisVygcXkq64I/+aqT6xTPgJimmb9+EXUw242RCvsgQ==
X-Received: by 2002:a05:6870:b406:b0:1e9:b496:ce2d with SMTP id x6-20020a056870b40600b001e9b496ce2dmr2895598oap.12.1697722870951;
        Thu, 19 Oct 2023 06:41:10 -0700 (PDT)
Received: from herring.priv (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id ef8-20020a0568701a8800b001e9b02b00e9sm1158356oab.22.2023.10.19.06.41.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 06:41:10 -0700 (PDT)
Received: (nullmailer pid 192889 invoked by uid 1000);
	Thu, 19 Oct 2023 13:41:09 -0000
Date: Thu, 19 Oct 2023 08:41:09 -0500
From: Rob Herring <robh@kernel.org>
To: Conor Dooley <conor@kernel.org>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>, Linus Walleij <linus.walleij@linaro.org>, Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, linux-arm-kernel@lists.infradead.org, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, devicetree@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, Eric Dumazet <edumazet@google.com>, Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, Gregory Clement <gregory.clement@bootlin.com>
Subject: Re: [PATCH net-next v4 1/7] dt-bindings: net: dsa: Require ports or
 ethernet-ports
Message-ID: <20231019134109.GA63240-robh@kernel.org>
References: <20231018-marvell-88e6152-wan-led-v4-0-3ee0c67383be@linaro.org>
 <20231018-marvell-88e6152-wan-led-v4-1-3ee0c67383be@linaro.org>
 <169762516670.391804.7528295251386913602.robh@kernel.org>
 <CACRpkdZ4hkiD6jwENqjZRX8ZHH9+3MSMMLcJe6tJa=6Yhn1w=g@mail.gmail.com>
 <ZTEL6Yw+Xcc0E4TJ@shell.armlinux.org.uk>
 <20231019-pulse-autopilot-166bb6c96090@spud>
 <ZTEgnUP0rFL2frkk@shell.armlinux.org.uk>
 <20231019-friday-fabulous-4882c4048b8c@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231019-friday-fabulous-4882c4048b8c@spud>

On Thu, Oct 19, 2023 at 01:46:36PM +0100, Conor Dooley wrote:
> On Thu, Oct 19, 2023 at 01:27:09PM +0100, Russell King (Oracle) wrote:
> > On Thu, Oct 19, 2023 at 12:58:46PM +0100, Conor Dooley wrote:
> > > On Thu, Oct 19, 2023 at 11:58:49AM +0100, Russell King (Oracle) wrote:
> > > > On Wed, Oct 18, 2023 at 01:11:45PM +0200, Linus Walleij wrote:
> > > > > On Wed, Oct 18, 2023 at 12:32 PM Rob Herring <robh@kernel.org> wrote:
> > > > > > On Wed, 18 Oct 2023 11:03:40 +0200, Linus Walleij wrote:
> > > > > 
> > > > > > > Bindings using dsa.yaml#/$defs/ethernet-ports specify that
> > > > > > > a DSA switch node need to have a ports or ethernet-ports
> > > > > > > subnode, and that is actually required, so add requirements
> > > > > > > using oneOf.
> > > > > > >
> > > > > > > Suggested-by: Rob Herring <robh@kernel.org>
> > > > > > > Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> > > > > > > ---
> > > > > > >  Documentation/devicetree/bindings/net/dsa/dsa.yaml | 6 ++++++
> > > > > > >  1 file changed, 6 insertions(+)
> > > > > > >
> > > > > >
> > > > > > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > > > > > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > > > > >
> > > > > > yamllint warnings/errors:
> > > > > > ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:60:7: [warning] wrong indentation: expected 8 but found 6 (indentation)
> > > > > > ./Documentation/devicetree/bindings/net/dsa/dsa.yaml:62:7: [warning] wrong indentation: expected 8 but found 6 (indentation)
> > > > > 
> > > > > Really?
> > > > > 
> > > > > +  oneOf:
> > > > > +    - required:
> > > > > +      - ports
> > > > > +    - required:
> > > > > +      - ethernet-ports
> > > > > 
> > > > > Two spaces after the oneOf, 2 spaces after a required as usual.
> > > > > I don't get it.

Either way is valid. It's just 2 different common styles and I picked 
the other way. The reason is to look different for a sequence vs. 
mapping:

- required:
  - ethernet-ports

- required:
    ethernet-ports

It's easy to miss the missing '-'.


> > > > Given the other python errors spat out in Rob's report, I would suggest
> > > > that the "bot" is running a development version that hasn't been fully
> > > > tested, so anything it spits out is suspect. Maybe Rob can comment on
> > > > the validity of the warnings in the report.
> > > 
> > > In this case, I think it is correct.
> > > 2 spaces for the oneOf, 2 spaces the start of the required for the
> > > nested list, so:
> > > oneOf:
> > >   - required:
> > 
> > This is a total of two spaces indentation.
> > 
> > >       - ports
> > 
> > This is a total of six spaces indentation.
> > 
> > You mention 2 spaces for the oneOf, which explains why the "- required"
> > needs to be indented by two spaces. You also say 2 spaces for the
> > required nested list, but what about the other two spaces?
> 
> I a word that might've made it more clear.
> It is 2 spaces for the oneOf and 2 spaces _from_ the start of the
> required for the nested list.

Yes, 'oneOf' here is not a json-schema keyword, but a key under $defs 
because it is indented. 

'$defs' entries must be a schema/dict/mapping (json-schema/python/yaml 
terms). 

> 
> In theory you might have a contrived example that looks like:
> 
> oneOf:
>   - required:
>       - ports
>     properties:
>       ethernet-ports: false
> 
>   - required:
>       - ethernet-ports
>     properties:
>       ports: false
> 
> Maybe with that example you can see that each option of the oneOf
> contains a `required` and a `properties` component at 4 spaces of
> indent, and then in turn the required properties, being sub-components
> of `required` grow 2 more spaces for 6.
> 
> > I guess if you're a YAML expert, this all makes sense, but to those of
> > us who aren't, these quirky "features" of it just seem totally
> > illogical.

Indentation being significant is not quirky. Languages choose either 
indentation or brackets of some form. YAML uses one and JSON uses the 
other.

> If I were a yaml expert, I would probably be able to use the correct
> terminology to explain this better, but hopefully the example is useful.

It has little to do with YAML other than indentation is *very* 
significant in YAML. It's actually valid YAML. It's probably valid 
json-schema, but questionable use in terms of how $defs is typically 
used.

Anyways, I'm working on a fix for the meta-schema.

Rob

