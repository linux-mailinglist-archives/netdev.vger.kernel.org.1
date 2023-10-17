Return-Path: <netdev+bounces-41817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 195E27CBF77
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 11:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C90C8281834
	for <lists+netdev@lfdr.de>; Tue, 17 Oct 2023 09:31:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 484C9405C0;
	Tue, 17 Oct 2023 09:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ELddAi28"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BA03F4DF;
	Tue, 17 Oct 2023 09:31:44 +0000 (UTC)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E472106;
	Tue, 17 Oct 2023 02:31:42 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-99de884ad25so883617666b.3;
        Tue, 17 Oct 2023 02:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697535100; x=1698139900; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xOqbqZUu//HMsDtmlOc6eburKLLaOWxAZ4a81kXORAc=;
        b=ELddAi287gwjFMdIZNVdt6nhnCInRY0JljUlcPOy3GaxkwVqeXEhPYBG+nQax0lZPn
         0+cKYmUfNS3p6CRr7LSx6BMPqjmH0Jyit06ATaQxwIbnMx/yFRlgJ5f3331dHM6p7/9n
         xmEhMFCjzNdS4OqOo2wUYP2N+0cjzhS5nTJP5pSqyZdeI+uJazkb2GEQtIfOQSOeMZQg
         aZT3qELP5Bja8FNikoHGPDYHFieMxU32pYDjiJWkV09+PRiVHAW2YRqjjJ0EZAE6gKLP
         TgCZGuUgkF6bHJ89j+F30JU43b+b6aY9XbRFk4NagRwGY+yOF2oTvT3ovKFUks4ekUjS
         FwWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697535100; x=1698139900;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xOqbqZUu//HMsDtmlOc6eburKLLaOWxAZ4a81kXORAc=;
        b=kMfFL0BQGU84MTadbfbuonlI9oE5ZJ192bT7SqBp8qBSeKysO380izFKZanQhZujil
         0WeLySd+9k3XStP4xzJLVYFM8HSKbyLn2Hs5yBzLdyDbLJkKKa3JJPAeiGqnS1KotnLQ
         Vm+ieO3jHYvlxOQQSu8k+rPfCVbc/kCaoixRVjZkUQdDDnCBY91TUamQKepCmqZOZWaE
         E7mbhskdljvDMmb+rg4B8dGYi8SofLp+KxaBH20exYt6Gdj8A9V8HshKybhXRdiMnLZ5
         hw3tU6aZLjjW9xd07xs4vDR5nQo6XyxIZ0ofW5PpoA0h1dcekypSnkmw0G68U4ls6R3a
         MmnA==
X-Gm-Message-State: AOJu0YzgchU93iHRgHFEGhBJhaeW2A3lEJ2kje/Gmuxs3L/p6zXgjmYq
	iNiRB0303OSDLlAy9MxdZIY=
X-Google-Smtp-Source: AGHT+IFSxnnCjSS0wVEuM5XQp9Hu3jBfbqRIGISjtLp6IzreIJHTjvJEAgXF7CJBV5uG/P6yBdVj2A==
X-Received: by 2002:a17:907:ea2:b0:9bf:4915:22ca with SMTP id ho34-20020a1709070ea200b009bf491522camr1303059ejc.45.1697535100453;
        Tue, 17 Oct 2023 02:31:40 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id i18-20020a1709061cd200b009b2b9af0784sm869947ejh.110.2023.10.17.02.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Oct 2023 02:31:40 -0700 (PDT)
Date: Tue, 17 Oct 2023 12:31:37 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Conor Dooley <conor@kernel.org>
Cc: Ante Knezic <ante.knezic@helmholz.de>, andrew@lunn.ch,
	conor+dt@kernel.org, davem@davemloft.net,
	devicetree@vger.kernel.org, edumazet@google.com,
	f.fainelli@gmail.com, krzysztof.kozlowski+dt@linaro.org,
	kuba@kernel.org, linux-kernel@vger.kernel.org, marex@denx.de,
	netdev@vger.kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
	woojung.huh@microchip.com
Subject: Re: [PATCH net-next v2 2/2] dt-bindings: net: microchip,ksz:
 document microchip,rmii-clk-internal
Message-ID: <20231017093137.qag7xcjuklekn3ef@skbuf>
References: <20231016103708.6ka5vxfkdatrjvdk@skbuf>
 <20231017073548.15050-1-ante.knezic@helmholz.de>
 <20231017-fading-retrial-7faebda79ebb@spud>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017-fading-retrial-7faebda79ebb@spud>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Oct 17, 2023 at 08:48:27AM +0100, Conor Dooley wrote:
> On Tue, Oct 17, 2023 at 09:35:48AM +0200, Ante Knezic wrote:
> > > > +  microchip,rmii-clk-internal:
> > > > +    $ref: /schemas/types.yaml#/definitions/flag
> > > > +    description:
> > > > +      Set if the RMII reference clock is provided internally. Otherwise
> > > > +      reference clock should be provided externally.
> > > > +
> > > > +if:
> > > > +  not:
> > > > +    properties:
> > > > +      compatible:
> > > > +        enum:
> > > > +          - microchip,ksz8863
> > > > +          - microchip,ksz8873
> > > > +then:
> > > > +  not:
> > > > +    required:
> > > > +      - microchip,rmii-clk-internal
> 
> I think this bit can become the slightly simpler
> 	then:
> 	  properties:
> 	     microchip,rmii-clk-internal: false

This looks better. I don't understand how the original formulation worked
("not: required:" when the property was never "required" in the first
place - does that do anything?), but I understand how this one does.

> > > I think that what you want to express is that microchip,rmii-clk-internal
> > > is only defined for microchip,ksz8863 and microchip,ksz8873.
> > > Can't you describe that as "if: properties: compatible: (...) then:
> > > properties: microchip,rmii-clk-internal"?
> > 
> > If I understood you correctly you are refering to a solution like
> > if:
> >   properties:
> >     compatible:
> >       enum:
> >         - microchip,ksz8863
> >         - microchip,ksz8873
> > then:
> >   properties:
> >     microchip,rmii-clk-internal:
> >       $ref: /schemas/types.yaml#/definitions/flag
> >       description:
> >         Set if the RMII reference clock is provided internally. Otherwise
> >         reference clock should be provided externally.
> > 
> > This was already suggested in v1, but was not a satisfactory solution
> > according to Mr. Conor Dooley:
> 
> Yeah, we prefer not to have the property definitions inside the
> conditionals, but rather constrain or allow/disallow them there.
> 
> Cheers,
> Conor.

Ok, now you know I didn't open the discussion on v1 :)

