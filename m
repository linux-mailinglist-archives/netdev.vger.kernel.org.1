Return-Path: <netdev+bounces-146707-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5579D533E
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 20:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACA321F21549
	for <lists+netdev@lfdr.de>; Thu, 21 Nov 2024 19:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88C791C57AA;
	Thu, 21 Nov 2024 18:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KS1+1fVn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0232A1DE2B2
	for <netdev@vger.kernel.org>; Thu, 21 Nov 2024 18:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732215570; cv=none; b=NzlVNN1h+UfaqmD7PMc+qmAcJ3TLaJc598UJkTZi8uDpTJMN8KGavRtgW1wzQ4H5CYFXj8C19mkCRwBj9U1YytBtt4wnugr92PEkxT/2gwsM/+BlJ9C8HUBtRN7hSmQ+ZLKOELdJsQuq4mwSX0cq4THEcG+BaWkEh1CgVEL26Hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732215570; c=relaxed/simple;
	bh=pg2vScaEi7P7fdNjOrU7DaIsKa33+gh5Z7aol5JAspY=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TCRp7veW1M9w2jQ0Vrsi/PaZ3p1zehg7mhIQU1j5EK5dPBSrTJv6D2vJLuHgGbQzX6I4P4S71KgalmSTRbFIc2cEq1KOBk892MhWRZQKCpwzN+FkUPqbU9LEaQSJKr94XCYEKzIm8hjPVLsPGWN4+dC25/QIrhuTzMyMMPY4WGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KS1+1fVn; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732215570; x=1763751570;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=dlx8UU6pixlviPs6mw0KKH2pHUGX8daepbFNASo1ktM=;
  b=KS1+1fVnrRovNPZ3Ial16+h3AmGzZh0yi9p6K/UsqhSEdXemP82sFCAm
   dcXWwx6fH+8El16IbSNldJp0A2kMsh50fXHpdIDxoxSA4kpgzg4hNu4QM
   Zhd3VhpuR4hWD58kx1c/2mjxtnadreCTKXeCZnQPKh0viRXWQB0LNXvD9
   c=;
X-IronPort-AV: E=Sophos;i="6.12,173,1728950400"; 
   d="scan'208";a="777687899"
Subject: RE: [PATCH v4 net-next 3/3] net: ena: Add PHC documentation
Thread-Topic: [PATCH v4 net-next 3/3] net: ena: Add PHC documentation
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2024 18:59:22 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:24191]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.9.62:2525] with esmtp (Farcaster)
 id 891a0c33-f102-408d-a8ae-ce3f3f98d3bd; Thu, 21 Nov 2024 18:59:20 +0000 (UTC)
X-Farcaster-Flow-ID: 891a0c33-f102-408d-a8ae-ce3f3f98d3bd
Received: from EX19D022EUA004.ant.amazon.com (10.252.50.82) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 21 Nov 2024 18:59:19 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D022EUA004.ant.amazon.com (10.252.50.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 21 Nov 2024 18:59:19 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Thu, 21 Nov 2024 18:59:19 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: Richard Cochran <richardcochran@gmail.com>
CC: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Eric Dumazet
	<edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Woodhouse, David"
	<dwmw@amazon.co.uk>, "Machulsky, Zorik" <zorik@amazon.com>, "Matushevsky,
 Alexander" <matua@amazon.com>, "Bshara, Saeed" <saeedb@amazon.com>, "Wilson,
 Matt" <msw@amazon.com>, "Liguori, Anthony" <aliguori@amazon.com>, "Bshara,
 Nafea" <nafea@amazon.com>, "Schmeilin, Evgeny" <evgenys@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Bernstein, Amit"
	<amitbern@amazon.com>, "Agroskin, Shay" <shayagr@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Machnikowski, Maciek" <maciek@machnikowski.net>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>, Gal Pressman <gal@nvidia.com>
Thread-Index: AQHbNnwBYT2f8QoaH0qt+HbH+6LQELK6ugMAgAAB9wCAA5OIgIAC54GAgADqqyA=
Date: Thu, 21 Nov 2024 18:59:19 +0000
Message-ID: <322f671cadb946a3bd528aa5755bc378@amazon.com>
References: <20241114095930.200-1-darinzon@amazon.com>
 <20241114095930.200-4-darinzon@amazon.com>
 <ZzlMlnDvhBntNkDS@hoboy.vegasvil.org> <ZzlOPEyFxOjvPJd2@hoboy.vegasvil.org>
 <a86eb32a374d4853a409c02777e71501@amazon.com>
 <Zz6973UqdRO1uV8L@hoboy.vegasvil.org>
In-Reply-To: <Zz6973UqdRO1uV8L@hoboy.vegasvil.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> On Tue, Nov 19, 2024 at 08:45:52AM +0000, Arinzon, David wrote:
> > Our device limits the number of requests per client (VM) through
> throttling.
>=20
> So it sounds like this device provides time to VM guests?
>=20
> If so, you might consider generating an interrupt to provide a "virtual" =
PPS as
> some of the other VM solutions do.  That way, you avoid all of those
> unwanted gettime() calls.
>=20
> HTH,
> Richard

Hi Richard,

AWS instances currently lack support for the 1PPS signal.
Currently, time information can only be accessed via the GetTime call.
Some instance families already provide this functionality,
with the solution designed to work consistently across both bare-metal and =
virtualized environments.

Thanks,
David

