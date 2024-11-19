Return-Path: <netdev+bounces-146150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D519D21CA
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:46:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5412B23169
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 08:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EB8B198A1A;
	Tue, 19 Nov 2024 08:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Jqnuhnug"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF37146D53
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 08:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732005962; cv=none; b=JrljMAAFVK+/dk8WJBifI5tChlRvZBxWxrt/weLZbiWUiaiQ3mIdnD0n7sIBltqTz/2Gu2+bJcoJUuaUP65PQGR9TQi3t8kBjq7bAkfc1dXudmPfwOWJ2LYbeBqTEmCbq0dq/p6zZ6/f+Uw7TiuJQiDqDTkQVl9AvL2mo4ETxxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732005962; c=relaxed/simple;
	bh=iQ0IbxDdW3Y2YRmfWIJoRW6LS8pVH/ryYdqv9ynE6Xo=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dd7W2IYXwcQ19sKx9Xr0XiPe+ceq569IvCyoPWOgxF/8sGconk0rcXBbLX8HGXtE7vk49j0TqVNa3PSou9zi9rvZH5BLD1R9+TCeAlStnlLYLSF7A20tVnXSeuuK9OyLgcJfi0fhgNP/vfK/oFEHZipJ3HtUB3qswI1QDX2yFfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Jqnuhnug; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1732005961; x=1763541961;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=2/sateXWcvrQHE3ACa2j9qHVcYruMu2eFlN2hXfLP2Y=;
  b=Jqnuhnugy2g4e/p+AwlRNmsoI6iTJBYfmBBGnZHnsBx17zUV7hOKmX/K
   HcEAQrxC6tfTvygFmRyl5vUUAWZu+KTKF4ysvD6EmCf1Li8av671t97Wz
   NcvMwSsOkpp0KgSU0b/REQW1xBVg+onYNeV7QG7ppaUH5j+sM+XdtfveJ
   c=;
X-IronPort-AV: E=Sophos;i="6.12,165,1728950400"; 
   d="scan'208";a="776831212"
Subject: RE: [PATCH v4 net-next 3/3] net: ena: Add PHC documentation
Thread-Topic: [PATCH v4 net-next 3/3] net: ena: Add PHC documentation
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2024 08:45:55 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:22286]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.31.126:2525] with esmtp (Farcaster)
 id 37568dfa-9180-4a36-addc-82166bcb1c1f; Tue, 19 Nov 2024 08:45:53 +0000 (UTC)
X-Farcaster-Flow-ID: 37568dfa-9180-4a36-addc-82166bcb1c1f
Received: from EX19D010EUA004.ant.amazon.com (10.252.50.94) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 19 Nov 2024 08:45:53 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D010EUA004.ant.amazon.com (10.252.50.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 19 Nov 2024 08:45:52 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1258.035; Tue, 19 Nov 2024 08:45:52 +0000
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
Thread-Index: AQHbNnwBYT2f8QoaH0qt+HbH+6LQELK6ugMAgAAB9wCAA5OIgA==
Date: Tue, 19 Nov 2024 08:45:52 +0000
Message-ID: <a86eb32a374d4853a409c02777e71501@amazon.com>
References: <20241114095930.200-1-darinzon@amazon.com>
 <20241114095930.200-4-darinzon@amazon.com>
 <ZzlMlnDvhBntNkDS@hoboy.vegasvil.org> <ZzlOPEyFxOjvPJd2@hoboy.vegasvil.org>
In-Reply-To: <ZzlOPEyFxOjvPJd2@hoboy.vegasvil.org>
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

> On Sat, Nov 16, 2024 at 05:53:26PM -0800, Richard Cochran wrote:
> > On Thu, Nov 14, 2024 at 11:59:30AM +0200, David Arinzon wrote:
> >
> > > +**phc_skp**         Number of skipped get time attempts (during bloc=
k
> period).
> > > +**phc_err**         Number of failed get time attempts (entering int=
o
> block state).
> >
> > Just curious...  I understand that the HW can't support a very high
> > rate of gettime calls and that the driver will throttle them.
> >
> > But why did you feel the need to document the throttling behavior in
> > such a overt way?  Are there user space programs out there calling
> > gettime excessively?
>=20
> Answering my own question (maybe)
>=20
> I see that your PHC only supports gettime(), and so I guess you must have
> some atypical system setup in mind.
>=20
> I didn't see any comments in the cover letter or in the patch about why t=
he
> PHC isn't adjustable or how offering gettime() only is useful?
>=20
> Thanks,
> Richard

Hi Richard
=09
Thank you for the queries.

Our device limits the number of requests per client (VM) through throttling=
.
To avoid reaching our device throttling limit and ensure a fail-fast mechan=
ism,
the driver preemptively applies throttling.
In addition, AWS cannot be adjusted or controlled by the OS/User to correct=
 any time deviations,
instead, AWS manages the synchronization and accuracy of the clock internal=
ly and provides a
pre-disciplined clock that already adheres to Coordinated Universal Time (U=
TC) standards.
An upcoming patch, which is a continuation of https://lore.kernel.org/netde=
v/4c2e99b4-b19e-41f5-a048-3bcc8c33a51c@lunn.ch/T/#m58cf9b05b34046b3952ae8bf=
4cc7d7f2c8b011d7,
will introduce the error bound in ENA PHC, providing internal AWS accuracy =
error measurements (in nanoseconds).

Thanks,
David



