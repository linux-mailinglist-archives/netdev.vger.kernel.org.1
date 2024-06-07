Return-Path: <netdev+bounces-101958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42119900BE9
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 20:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36D41B22721
	for <lists+netdev@lfdr.de>; Fri,  7 Jun 2024 18:33:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82E5B13FD84;
	Fri,  7 Jun 2024 18:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="hZ136Q9m"
X-Original-To: netdev@vger.kernel.org
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8487D13E41D;
	Fri,  7 Jun 2024 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717785202; cv=none; b=Jfz0yZZ6e4TLX2RJSWslzjs7hec12RQZ2n1NL0QNmnF8F8Qk5eWRfj7hITTE6PH+i15sZKTnkMyvaMixm21BmCrVSEG3lRYOpLL/MWmB076mMKcsufJaRC1EDFs4YcESlXaGvScQBHO2IbUB40iyAZfWwCVbajOjcRxKeXcbF6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717785202; c=relaxed/simple;
	bh=K3XX1ZGrNqgevvYtO1jhNZo5tT+1jItizRltt7qdc88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d3PCnBpZMAJ6EA29xQfP2XMjokN/r7/BV6DzCHNPyToGXH3/gYnL+ZXbM034C2uPWG7hf70vE8KVKXd+DIi1pDAAsBA3JpUMeHUxii7zEeZFr+Vn0GO6vte5PpATBM2ck+9pT6oHhC0giCYpGVM/2FrkF+1wSVQoAuRBE80ytpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=hZ136Q9m; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1717785191;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FFEyK0DY8IpFcUTkeSbNeWt4t8L56sLzjHekE18/ezc=;
	b=hZ136Q9m/YuxRSuKeRtrrdjnpbDqDlC0VZr5Soq51LKx+eI2e74hXat/0nxoBYDWn65akr
	9JrqnR8/r6RKuvbfjU7MwCkuPxL22cJWF1EIf5KXKiE+2Wcx+/VAd+Z3d4kuoUaaGPBGTX
	Iz7VCRzkYMkgkzYT+01PwTc2tOqRbIs=
From: Sven Eckelmann <sven@narfation.org>
To: Marek Lindner <mareklindner@neomailbox.ch>,
 Simon Wunderlich <sw@simonwunderlich.de>, Antonio Quartulli <a@unstable.cc>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Nathan Chancellor <nathan@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>,
 Justin Stitt <justinstitt@google.com>, Kees Cook <keescook@chromium.org>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Erick Archer <erick.archer@outlook.com>
Cc: Erick Archer <erick.archer@outlook.com>, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject:
 Re: [PATCH v4] batman-adv: Add flex array to struct batadv_tvlv_tt_data
Date: Fri, 07 Jun 2024 20:33:08 +0200
Message-ID: <2529523.GKX7oQKdZx@ripper>
In-Reply-To:
 <AS8PR02MB7237205E3231CD335CB988648BFB2@AS8PR02MB7237.eurprd02.prod.outlook.com>
References:
 <AS8PR02MB7237205E3231CD335CB988648BFB2@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2954765.bcXerOTE6V";
 micalg="pgp-sha512"; protocol="application/pgp-signature"

--nextPart2954765.bcXerOTE6V
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"; protected-headers="v1"
From: Sven Eckelmann <sven@narfation.org>
Date: Fri, 07 Jun 2024 20:33:08 +0200
Message-ID: <2529523.GKX7oQKdZx@ripper>
MIME-Version: 1.0

On Friday, 7 June 2024 18:19:12 CEST Erick Archer wrote:
> Hi,
> 
> As it was decided in version 3, I resend this path since -r2 has been
> released. I hope that this time the patch can be applied ;)

Thanks, applied.

Kind regards,
	Sven
--nextPart2954765.bcXerOTE6V
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQS81G/PswftH/OW8cVND3cr0xT1ywUCZmNSZAAKCRBND3cr0xT1
y5B6AQCskTowCR93AUyerf8R+T/LbG434M61OZgxyimamI09YAD8CmdPzu35Sh+O
P7MqIU9qdXBCNKqbNf8jYJhR8W44awE=
=+VlR
-----END PGP SIGNATURE-----

--nextPart2954765.bcXerOTE6V--




