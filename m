Return-Path: <netdev+bounces-207086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C80B6B05947
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 13:52:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CCF64A5A6D
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 11:52:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFA72D9EEA;
	Tue, 15 Jul 2025 11:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="ETzqpQH0"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2B3618E1F
	for <netdev@vger.kernel.org>; Tue, 15 Jul 2025 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752580349; cv=none; b=q5m+RW66sNqTuPHDDpHbDAWoE/bNaziqaentI/JapQUxX7bmbPiASEg91Ts5RypAtmFFbB50Rw0qbOjmYvZsC3zR5G5TzUv84ZyBjSTE0WGPcB53Zh6Gmy1+j3lW5NIC6tpC9yyBHWnj1vQ2ChsxiNLJ1Sv8GbT88o9MGb925+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752580349; c=relaxed/simple;
	bh=0SGGpE1FSUN860WwuC1EDMtRnqLDzeHsrpZIKGCl/m8=;
	h=Subject:From:To:CC:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nh0/NOpbLwxx+1bL6Nmw6kqGaEblxGas0pRQcPES4yCAwaGqarFU6B8oWp2srSCdO1IrB3DtBkeUB/lYUmC6jynqrIEUheSCmyQKlIogt4ELKClo7+HXSL7i0ZnDAaQKCUeEbrIGl8y8vubETdfadTg+jONa0VBxcrMdBK2t/HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=ETzqpQH0; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1752580347; x=1784116347;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-transfer-encoding:mime-version:subject;
  bh=0SGGpE1FSUN860WwuC1EDMtRnqLDzeHsrpZIKGCl/m8=;
  b=ETzqpQH0MZ0O6WPpKGqfF259PJaa8P5FiAnbLArtmeTk3bo2gO1Edt50
   67wJpe5nmMZKmNij3kU4lgR2PsYceT7uEOoUt8R/HWuhvOvoe354NmYPN
   0TeN1xmVt1H9Hj+zAKWOaXvpJdyVsWAomFOZpJIBe0c+8NidaLymT+k5S
   Km4VvprBilQQXITTs7nn4bzg+wLf5GY2MB9q+AC/6tFA5+X6NFoDvBOCP
   DXdHUY0IpyS2sMTCPbcx6gZ6zNGb6ro8VHEYHi7+N+3/3g6H8uWzPr89P
   vbKPKfIXPduyUA5eQUjYnCxZJp7SPEUkZ5riMbAi9logQhxrIlYF1LQ5g
   Q==;
X-IronPort-AV: E=Sophos;i="6.16,313,1744070400"; 
   d="scan'208";a="214683291"
Subject: RE: [PATCH ethtool] netlink: fix missing headers in text output
Thread-Topic: [PATCH ethtool] netlink: fix missing headers in text output
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2025 11:52:25 +0000
Received: from EX19MTAEUC002.ant.amazon.com [10.0.17.79:63135]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.36.43:2525] with esmtp (Farcaster)
 id c1e0bddd-6f36-45e4-9f00-d761ad99d406; Tue, 15 Jul 2025 11:52:24 +0000 (UTC)
X-Farcaster-Flow-ID: c1e0bddd-6f36-45e4-9f00-d761ad99d406
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19MTAEUC002.ant.amazon.com (10.252.51.245) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Jul 2025 11:52:22 +0000
Received: from EX19D005EUA002.ant.amazon.com (10.252.50.11) by
 EX19D005EUA002.ant.amazon.com (10.252.50.11) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 15 Jul 2025 11:52:22 +0000
Received: from EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9]) by
 EX19D005EUA002.ant.amazon.com ([fe80::6aa4:b4a3:92f6:8e9%3]) with mapi id
 15.02.1544.014; Tue, 15 Jul 2025 11:52:22 +0000
From: "Arinzon, David" <darinzon@amazon.com>
To: "kuba@kernel.org" <kuba@kernel.org>, "mkubecek@suse.cz" <mkubecek@suse.cz>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"ant.v.moryakov@gmail.com" <ant.v.moryakov@gmail.com>
Thread-Index: AQHb9X7sn+3G9RoAeU22LmBfVeBqjQ==
Date: Tue, 15 Jul 2025 11:52:22 +0000
Message-ID: <3bf85637ed244052a26f03cc42cf8f12@amazon.com>
References: <0bcad81d1d004c74abfbb73eacbe6ec2@amazon.com>
In-Reply-To: <0bcad81d1d004c74abfbb73eacbe6ec2@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

> The commit under fixes added a NULL-check which prevents us from
> printing text headers. Conversions to add JSON support often use:
>=20
>=A0=A0 print_string(PRINT_FP, NULL, "some text:\n", NULL);
>=20
> to print in plain text mode.
>=20
> Correct output:
>=20
>=A0=A0 Channel parameters for vpn0:
>=A0=A0 Pre-set maximums:
>=A0=A0 RX:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n/a
>=A0=A0 TX:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n/a
>=A0=A0 Other:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n/a
>=A0=A0 Combined:=A0=A0=A0=A0 1
>=A0=A0 Current hardware settings:
>=A0=A0 RX:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n/a
>=A0=A0 TX:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n/a
>=A0=A0 Other:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n/a
>=A0=A0 Combined:=A0=A0=A0=A0 0
>=20
> With the buggy patch:
>=20
>=A0=A0 Channel parameters for vpn0:
>=A0=A0 RX:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n/a
>=A0=A0 TX:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n/a
>=A0=A0 Other:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n/a
>=A0=A0 Combined:=A0=A0=A0=A0 1
>=A0=A0 RX:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n/a
>=A0=A0 TX:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n/a
>=A0=A0 Other:=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n/a
>=A0=A0 Combined:=A0=A0=A0=A0 0
>=20
> Fixes: fd328ccb3cc0 ("json_print: add NULL check before jsonw_string_fiel=
d() in print_string()")
> Signed-off-by: Jakub Kicinski mailto:kuba@kernel.org
> ---
>=A0 json_print.c | 3 ++-
>=A0 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/json_print.c b/json_print.c
> index 4f61640392cf..e07c651f477b 100644
> --- a/json_print.c
> +++ b/json_print.c
> @@ -143,10 +143,11 @@ void print_string(enum output_type type,
>=A0=A0=A0=A0=A0=A0=A0=A0 } else if (_IS_FP_CONTEXT(type)) {
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (value)
>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f=
printf(stdout, fmt, value);
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else
> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprin=
tf(stdout, fmt);
>=A0=A0=A0=A0=A0=A0=A0=A0 }
>=A0 }
>=20
> -
>=A0 /*
>=A0=A0 * value's type is bool. When using this function in FP context you =
can't pass
>=A0=A0 * a value to it, you will need to use "is_json_context()" to have d=
ifferent
> --=20
> 2.50.1

Thanks for identifying the issue and proposing the fix.

Reviewed-by: David Arinzon <mailto:darinzon@amazon.com>

