Return-Path: <netdev+bounces-26342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D4146777916
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 15:06:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91CE9282055
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 13:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A9F31E1C3;
	Thu, 10 Aug 2023 13:06:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C5451E1A3
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 13:06:36 +0000 (UTC)
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4711B2698;
	Thu, 10 Aug 2023 06:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1691672796; x=1723208796;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YhVLeHe7hIFvREZYFRzYBtmlRfE8xXBsnawNuJxDi3c=;
  b=c+bnVuPN+by49YNRYOn1T8Md9RlZTBZHQv3dRfiqiWWsGaBmIgpofygK
   UtA6AGWphckknv7eS6kat4CBpgORgxLx7rJJC3MezxXBjpCC5ZJolojgx
   nu5LuRNXLTT6DIXmmVMG+021k6JX/XjH25ECLKjzp0InK2BZM7taqBcHz
   n6+8yxtQuW2euYpXIz6jmQiRviWyCHKSiCaK83jKKavXSVugr9gIBJiA1
   lZGZhrPt6E0NpHt88js6tSb0C+6GWBOrgFD9vwGsOsWaFD4lF4J0g4FEy
   vSOHXHMvWC6TXNnaE7dYS8ed/RJdjegvjT8z+jvgyFp97h4AQhvj0jhgq
   A==;
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="asc'?scan'208";a="224802819"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Aug 2023 06:06:35 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 10 Aug 2023 06:06:34 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex03.mchp-main.com
 (10.10.85.151) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 10 Aug 2023 06:06:30 -0700
Date: Thu, 10 Aug 2023 14:05:52 +0100
From: Conor Dooley <conor.dooley@microchip.com>
To: Md Danish Anwar <a0501179@ti.com>
CC: Conor Dooley <conor@kernel.org>, MD Danish Anwar <danishanwar@ti.com>,
	Randy Dunlap <rdunlap@infradead.org>, Roger Quadros <rogerq@kernel.org>,
	Simon Horman <simon.horman@corigine.com>, Vignesh Raghavendra
	<vigneshr@ti.com>, Andrew Lunn <andrew@lunn.ch>, Richard Cochran
	<richardcochran@gmail.com>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring
	<robh+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski
	<kuba@kernel.org>, Eric Dumazet <edumazet@google.com>, "David S. Miller"
	<davem@davemloft.net>, <nm@ti.com>, <srk@ti.com>,
	<linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-omap@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 1/5] dt-bindings: net: Add ICSS IEP
Message-ID: <20230810-wise-mousy-8841c8880353@wendy>
References: <20230809114906.21866-1-danishanwar@ti.com>
 <20230809114906.21866-2-danishanwar@ti.com>
 <20230809-cardboard-falsify-6cc9c09d8577@spud>
 <0b619ec5-9a86-a449-e8db-b12cca115b93@ti.com>
 <20230810-drippy-draw-8e8a63164e46@wendy>
 <593b3505-9c1e-47e6-e856-f299fc257fa8@ti.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="lQFFhBRnHv9kDzPj"
Content-Disposition: inline
In-Reply-To: <593b3505-9c1e-47e6-e856-f299fc257fa8@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

--lQFFhBRnHv9kDzPj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2023 at 06:27:22PM +0530, Md Danish Anwar wrote:
>=20
> Sure Conor, I will remove items from the last one and make it just const =
like
> below. Please let me know if this is ok.

Yeah, that looks okay to me, thanks.

--lQFFhBRnHv9kDzPj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZNTgsAAKCRB4tDGHoIJi
0qKdAP9zF9maVrY4ug5wrMq10xgDfH9HIUNUkVyNZtsiVQAJ8gEA02aF5QxHHj/S
/GpcJBK9yWb+MPymVq1kN8VFnt1SNgQ=
=fNDU
-----END PGP SIGNATURE-----

--lQFFhBRnHv9kDzPj--

