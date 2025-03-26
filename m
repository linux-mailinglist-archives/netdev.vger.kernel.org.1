Return-Path: <netdev+bounces-177744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 584C1A7181A
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 15:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E32DC16AFBC
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 14:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7172E1EFFBC;
	Wed, 26 Mar 2025 14:09:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from maynard.decadent.org.uk (maynard.decadent.org.uk [65.21.191.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3F21EDA34
	for <netdev@vger.kernel.org>; Wed, 26 Mar 2025 14:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.21.191.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742998141; cv=none; b=UogTXbBz/018bsJyQlQZqRxFWLeWtOqT8nLFI9CQPWKlSUa7S1gbneeuHnum5BsilQtIH0MDkPvwf4iR0tZVCS2IzvC4/wuxOpQ3mwffyzPdMaMLMEaJ4R2f7XH14myrJJmQy4F3ITqkQKdquQJPPJpoflsDZtPyNAWz4G1n0F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742998141; c=relaxed/simple;
	bh=CsUicUuxg8bnsFN2wF+gOPmBexkOA7uPv9yv7q7WE/Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lfOISHr3zUFoKTKCyOXM/3cwi7JRAduYmYv9qrU0vmWSvbAT/4aPG1TJnRj1WEC+phgrn5cEdKbcJ06MpbBFKfcnnukIr9ugWh0rIAbREQwc1anPRnY8ZxRplZ0WjwJpXjY+IPUNmh1N1qmljO/31VIwi/qm/wpXWSWPLpwfIb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=decadent.org.uk; arc=none smtp.client-ip=65.21.191.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=decadent.org.uk
Received: from [2a02:578:851f:1502:391e:c5f5:10e2:b9a3] (helo=deadeye)
	by maynard with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ben@decadent.org.uk>)
	id 1txRRB-00Aa6T-2b;
	Wed, 26 Mar 2025 14:08:57 +0000
Received: from ben by deadeye with local (Exim 4.98.1)
	(envelope-from <ben@decadent.org.uk>)
	id 1txRRA-00000004jTf-3Oxx;
	Wed, 26 Mar 2025 15:08:56 +0100
Date: Wed, 26 Mar 2025 15:08:56 +0100
From: Ben Hutchings <benh@debian.org>
To: netdev@vger.kernel.org
Cc: 1088739@bugs.debian.org
Subject: [PATCH iproute2 2/2] color: Do not use dark blue in dark-background
 palette
Message-ID: <Z-QKeE-9V2QLyDih@decadent.org.uk>
References: <Z-QKNa7_nHKoh9Gl@decadent.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="IuaIC8M/Ivzl5w6/"
Content-Disposition: inline
In-Reply-To: <Z-QKNa7_nHKoh9Gl@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:578:851f:1502:391e:c5f5:10e2:b9a3
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on maynard); SAEximRunCond expanded to false


--IuaIC8M/Ivzl5w6/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

In GNOME Terminal's default dark colour schemes, the default (dark)
blue on a black background is barely readable.  Light blue is
significantly more readable to me, and is also easily readable on a
white background.

In Konsole, rxvt, and xterm, I can see little if any difference
between dark and light blue in the default dark colour schemes.

So replace dark blue with light blue in the dark-background palette.

Signed-off-by: Ben Hutchings <benh@debian.org>
---
 lib/color.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/color.c b/lib/color.c
index 88ba9b03..aa112352 100644
--- a/lib/color.c
+++ b/lib/color.c
@@ -24,7 +24,7 @@ enum color {
 	C_BOLD_RED,
 	C_BOLD_GREEN,
 	C_BOLD_YELLOW,
-	C_BOLD_BLUE,
+	C_BOLD_LIGHT_BLUE,
 	C_BOLD_MAGENTA,
 	C_BOLD_CYAN,
 	C_BOLD_WHITE,
@@ -42,7 +42,7 @@ static const char * const color_codes[] = {
 	"\e[1;31m",
 	"\e[1;32m",
 	"\e[1;33m",
-	"\e[1;34m",
+	"\e[1;94m",
 	"\e[1;35m",
 	"\e[1;36m",
 	"\e[1;37m",
@@ -66,7 +66,7 @@ static enum color attr_colors_dark[] = {
 	C_BOLD_CYAN,
 	C_BOLD_YELLOW,
 	C_BOLD_MAGENTA,
-	C_BOLD_BLUE,
+	C_BOLD_LIGHT_BLUE,
 	C_BOLD_GREEN,
 	C_BOLD_RED,
 	C_CLEAR

--IuaIC8M/Ivzl5w6/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEErCspvTSmr92z9o8157/I7JWGEQkFAmfkCngACgkQ57/I7JWG
EQnkJA/8DU/1qxOL3nxMX5y5r/6ahpld8uMIDw4eaI8RPVGxDThRytbIu3isHYzM
99E3t5T584vSjTYPpUK/lwqoqzob6uYQP/ikK1E2j+/+LUezk5EkS6A1slfC5sg5
2QRrizcTQWULhPQ0r8vMLXR+CL5Eaw+BP+7G1IInFEnCn4T0KKrFSHJVwmYrS9Mk
RDby9A/yTTNuKVq+uDMv5zHq0OQXAM/Wv1Q0+0NzmsnOLvuL9dPZ6C2viML80Qm1
TlpX/fMDz1WtOmOtl35RF/CnRm0P6u4TA0bOSRNNCV9c4fJkyKVHTpVpBWV7bkzo
xSDrtfEPpEZ0ldUQPT1B7eRkwwo/KIoH+xnk6Ptcf1n40Fx2TambbfApuui3vzf2
n3UGHHb7mpVNaKZjkp4NuStmDcvISi8eO9UC/V8bjoovX4kNApl+gxuj02TvfnCu
fUf1l1Xy3yhQP2Gm48u1JTsCmq3iIwY0UjSclS6NVhvKBDmHyn3KizKckzNVQEbL
F7XgnkcltI2ITTSeuTZwNXdkv54kyfreTS6urNM8I1MKhE1fdT+sDnOySH2euf4r
AzUTPynX5jK/DnTbj1SplKh4d3+ekRz+grx8eAftGuYV4HMpwTa9dednvdqn1P1V
CQIL1K0NBwrz6mZnIbUezoAv5PG+MWBtHm1jPQz9IU40OsvvncU=
=ei7y
-----END PGP SIGNATURE-----

--IuaIC8M/Ivzl5w6/--

