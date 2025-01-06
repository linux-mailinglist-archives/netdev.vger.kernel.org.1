Return-Path: <netdev+bounces-155573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5EBA02FA1
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 19:17:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5280B18842E8
	for <lists+netdev@lfdr.de>; Mon,  6 Jan 2025 18:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8139C130E27;
	Mon,  6 Jan 2025 18:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QriLJpN4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F3A1553BB
	for <netdev@vger.kernel.org>; Mon,  6 Jan 2025 18:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736187444; cv=none; b=RD5/2+WkQ4hhkObk1nOXeIivcKoBlEWmMuszmG6YcyTClWVg2vkjqbi7Mz/na1v0a11jeiZRWNdoVXVrvOYkfrZN+4cfsvpeqSQEZ46d3ufWoiEJjI04N2uHLf10MPHFsTd/+Wn4u8R6OWMXvlm7JUmgn2Zu0s47+eR1niePPjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736187444; c=relaxed/simple;
	bh=4HiTtpVA03aLxEF6cY/cgd23YqFKehl3r4Hn2ZPm3bU=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MumcwgetEgevKl23bBnqJ1CpPRK3yXuG4sLWFhaZ5MlE0ymGbtwWVvp2jpjx6aR4V/XXAsymJWGYVcTj8usTAPLbze7dfBXyIUgAjS5WGhYu1gq8WPv75uDVSrAOmzEpyd9/jT6bl1ES9vGeY8Jh2nfSVgEwYoRZ6NdVSuuJoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QriLJpN4; arc=none smtp.client-ip=52.119.213.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736187441; x=1767723441;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=oh7Luu06pdvAzNJ74ENDW6MDy6dSEbTiihGoxsXK35s=;
  b=QriLJpN4xJXbVq++lkWMcf9bPrn7JSZFilIWxANBwB3c8wkYA1r2iUQ4
   9yB7MxaBxNYQIlato+0cybMdygcpm5i4RFoC86ziqmeKP15cQNyimQrQe
   27wbiEMMP3lDkA0CMb23K3fhzzn+4Tl0pVfucl3dQUFgP3lcYYJ25j0GS
   I=;
X-IronPort-AV: E=Sophos;i="6.12,293,1728950400"; 
   d="scan'208";a="55636778"
Subject: RE: [PATCH net 7/8] MAINTAINERS: remove Noam Dagan from AMAZON ETHERNET
Thread-Topic: [PATCH net 7/8] MAINTAINERS: remove Noam Dagan from AMAZON ETHERNET
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2025 18:17:18 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:41416]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.23.192:2525] with esmtp (Farcaster)
 id 4b5d0dfc-3742-4f79-895e-bc1cda701ea3; Mon, 6 Jan 2025 18:17:18 +0000 (UTC)
X-Farcaster-Flow-ID: 4b5d0dfc-3742-4f79-895e-bc1cda701ea3
Received: from EX19D005EUA004.ant.amazon.com (10.252.50.241) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 6 Jan 2025 18:17:18 +0000
Received: from EX19D022EUA002.ant.amazon.com (10.252.50.201) by
 EX19D005EUA004.ant.amazon.com (10.252.50.241) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Mon, 6 Jan 2025 18:17:17 +0000
Received: from EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d]) by
 EX19D022EUA002.ant.amazon.com ([fe80::7f87:7d63:def0:157d%3]) with mapi id
 15.02.1258.039; Mon, 6 Jan 2025 18:17:17 +0000
From: "Kiyanovski, Arthur" <akiyano@amazon.com>
To: Jakub Kicinski <kuba@kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "edumazet@google.com"
	<edumazet@google.com>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Arinzon, David" <darinzon@amazon.com>
Thread-Index: AQHbYFuq0f5O/EakbUSTxNdD1BEVZbMKB5hQ
Date: Mon, 6 Jan 2025 18:17:02 +0000
Deferred-Delivery: Mon, 6 Jan 2025 17:58:40 +0000
Message-ID: <330c31a378b348d4acf96dd0c22348ad@amazon.com>
References: <20250106165404.1832481-1-kuba@kernel.org>
 <20250106165404.1832481-8-kuba@kernel.org>
In-Reply-To: <20250106165404.1832481-8-kuba@kernel.org>
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



> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Monday, January 6, 2025 8:54 AM
> To: davem@davemloft.net
> Cc: netdev@vger.kernel.org; edumazet@google.com; pabeni@redhat.com;
> andrew+netdev@lunn.ch; Jakub Kicinski <kuba@kernel.org>; Agroskin, Shay
> <shayagr@amazon.com>; Kiyanovski, Arthur <akiyano@amazon.com>;
> Arinzon, David <darinzon@amazon.com>
> Subject: [EXTERNAL] [PATCH net 7/8] MAINTAINERS: remove Noam Dagan
> from AMAZON ETHERNET
>=20
> CAUTION: This email originated from outside of the organization. Do not c=
lick
> links or open attachments unless you can confirm the sender and know the
> content is safe.
>=20
>=20
>=20
> Noam Dagan was added to ENA reviewers in 2021, we have not seen a single
> email from this person to any list, ever (according to lore).
> Git history mentions the name in 2 SoB tags from 2020.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: shayagr@amazon.com
> CC: akiyano@amazon.com
> CC: darinzon@amazon.com
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c092c27fcd5f..009630fe014c 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -949,7 +949,6 @@ AMAZON ETHERNET DRIVERS
>  M:     Shay Agroskin <shayagr@amazon.com>
>  M:     Arthur Kiyanovski <akiyano@amazon.com>
>  R:     David Arinzon <darinzon@amazon.com>
> -R:     Noam Dagan <ndagan@amazon.com>
>  R:     Saeed Bishara <saeedb@amazon.com>
>  L:     netdev@vger.kernel.org
>  S:     Supported
> --
> 2.47.1

Acked-by: Arthur Kiyanovski <akiyano@amazon.com>

