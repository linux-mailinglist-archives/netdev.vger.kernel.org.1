Return-Path: <netdev+bounces-15052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44293745717
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 10:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731041C20873
	for <lists+netdev@lfdr.de>; Mon,  3 Jul 2023 08:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CE211FA4;
	Mon,  3 Jul 2023 08:14:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51ADD1C38
	for <netdev@vger.kernel.org>; Mon,  3 Jul 2023 08:14:20 +0000 (UTC)
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED944C5;
	Mon,  3 Jul 2023 01:14:18 -0700 (PDT)
Received: from [192.168.12.102] (unknown [159.196.94.230])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 9D9352012A;
	Mon,  3 Jul 2023 16:14:16 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1688372056;
	bh=3vG4Y1Ce9Qo+ZUx7zgRT9LamZxjnSqZyYA8M+Re6/EU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MG8hDVpq0S4fuCRWQnn2t81qZilkAi0AnQWQCcT0RXKXCWxdCUlV3TdiT57gtsqD+
	 OJ5diuvizhUlGXAiYVDtsuN1ewrHWAtiqdKEsltc6zumfQoeSE1i5VoIZYHTER+J7v
	 QEQ2Z+lzVsJJ3Iy+gG5nphl3s5LWzonUNVNVuzdiM1f2qzzMFghUr144QPtq8OyWh/
	 gGkG7JLzSqeds1sLW82eaIcVVZ5GemLwevZ1BkY9hwcDSRd0Vs+6W1u1R9aCFdrNw7
	 XcLWnOqeo0KQeD7+M+yWIGe8n3bfgK6kpuYTIRact2/PrumPosDngv7KmLkHQqyvc1
	 mJhg9lJ/KMgGQ==
Message-ID: <d29fc42c04f2e1142b0a196ef7df2d74335cec2e.camel@codeconstruct.com.au>
Subject: Re: [PATCH 1/3] dt-bindings: i3c: Add mctp-controller property
From: Matt Johnston <matt@codeconstruct.com.au>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-i3c@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, Eric Dumazet <edumazet@google.com>, "David S.
 Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>,  Jeremy Kerr <jk@codeconstruct.com.au>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>, Rob Herring
 <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Date: Mon, 03 Jul 2023 16:14:16 +0800
In-Reply-To: <CAGE=qrrqE3Vj1Bs+cC51gKPDmsqMTyHEAJhsrGCyS_jYKf42Gw@mail.gmail.com>
References: <20230703053048.275709-1-matt@codeconstruct.com.au>
	 <20230703053048.275709-2-matt@codeconstruct.com.au>
	 <CAGE=qrrqE3Vj1Bs+cC51gKPDmsqMTyHEAJhsrGCyS_jYKf42Gw@mail.gmail.com>
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
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, 2023-07-03 at 09:15 +0200, Krzysztof Kozlowski wrote:
> On Mon, 3 Jul 2023 at 07:31, Matt Johnston <matt@codeconstruct.com.au> wr=
ote:
> >=20
> > This property is used to describe a I3C bus with attached MCTP I3C
> > target devices.
> >=20
> > Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
> > ---
> >  Documentation/devicetree/bindings/i3c/i3c.yaml | 4 ++++
> >  1 file changed, 4 insertions(+)
> >=20
> > diff --git a/Documentation/devicetree/bindings/i3c/i3c.yaml b/Documenta=
tion/devicetree/bindings/i3c/i3c.yaml
> > index fdb4212149e7..08731e2484f2 100644
> > --- a/Documentation/devicetree/bindings/i3c/i3c.yaml
> > +++ b/Documentation/devicetree/bindings/i3c/i3c.yaml
> > @@ -55,6 +55,10 @@ properties:
> >=20
> >        May not be supported by all controllers.
> >=20
> > +  mctp-controller:
> > +    description: |
> > +      Indicates that this bus hosts MCTP-over-I3C target devices.
>=20
> I have doubts you actually tested it - there is no type/ref. Also,
> your description is a bit different than existing from dtschema. Why?
> Aren't these the same things?

(sorry my reply minutes ago was somehow an old draft, please ignore)

Ah, I'll add=20
$ref: /schemas/types.yaml#/definitions/flag

Testing with=20
  make dtbs_check DT_SCHEMA_FILES=3Dtrivial-devices.yaml
I don't see any warnings, and neither after adding mctp-controller to a .dt=
s
(out of tree) and testing with
  make CHECK_DTBS=3Dy DT_SCHEMA_FILES=3Di3c.yaml aspeed-test.dtb

Should that pick it up?

For the description, do you mean it differs to the other properties in
i3c.yaml, or something else?

Thanks,
Matt

