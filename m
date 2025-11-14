Return-Path: <netdev+bounces-238551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FDAC5AEF1
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 02:38:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BD21E3448E2
	for <lists+netdev@lfdr.de>; Fri, 14 Nov 2025 01:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A6E3261B98;
	Fri, 14 Nov 2025 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1jzjRRK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70099261B71;
	Fri, 14 Nov 2025 01:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763084289; cv=none; b=OHg0TgWDr572rlLkAcp2lXI4AroHlcyV+Jd/J6OEWdoa57M4DzGBMIhxftuuVJSSsTlMsP0SGrLXAIarmmzwuV6EDe2eyQi7z5s3DVWsAHu/Vhy3AhurgceTLqODshy1e3QH6jLen6cnAaTJo4r1xGn68LgJqacy+Sk5Z0sj7Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763084289; c=relaxed/simple;
	bh=EORKdZAeeFLicUHtkebsHBnjT09RMj8tOEs/adAHAfQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJEF0pfpnwkyboIAjNcjB7ZJ4W9WKybax73FprARCnOBFQdsFd17Buil89rk82kuNf4IOSa92gZpR3cuNivX5C3y1ZLI+SveMwMM6a2SD50PjcS+lnh5hb5tVL+VjSldUhDDsE8QGmLKw4Wdzf6JunliUKr+fsx1tGLNJHr4YgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1jzjRRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5995DC4CEF8;
	Fri, 14 Nov 2025 01:38:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763084288;
	bh=EORKdZAeeFLicUHtkebsHBnjT09RMj8tOEs/adAHAfQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=K1jzjRRKoA02Sq/DP3gRL0vEFXgM/49xW3vlcMAwWMYf8s20feLit7RWXjYynGJ6M
	 Z8s8dh28a2B7KABWNdWD1HUU0wSRHJPOk2Tcc7KsNF14cTQFQRDxGECY8R2+c8gWBw
	 66ND/FDA733jXDG5jzsva9NfcY4aOW8RcwWdNORdG42/CTD/Ersil4+5SeDWY9kAVM
	 X7J85Gr4cnsLTIm3m9fdm9vhM6IHC4WOgFBcSFsCRSMV8I3VOwoauGuINA/X0QpgfO
	 p+HuBAM0a5rgknYcDCWGdmSn6gBZanPGcLqzTgyWPDOUypMNO0yZPt12LYABIT7F3l
	 2M3W0vqHOesTw==
Date: Thu, 13 Nov 2025 17:38:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: =?UTF-8?B?0JLQsNGC0L7RgNC+0L/QuNC9INCQ0L3QtNGA0LXQuQ==?=
 <a.vatoropin@crpt.ru>
Cc: Ajit Khaparde <ajit.khaparde@broadcom.com>, Sriharsha Basavapatna
 <sriharsha.basavapatna@broadcom.com>, Somnath Kotur
 <somnath.kotur@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Venkata Duvvuru
 <VenkatKumar.Duvvuru@Emulex.Com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "lvc-project@linuxtesting.org"
 <lvc-project@linuxtesting.org>
Subject: Re: [PATCH net] be2net: check wrb_params for NULL value
Message-ID: <20251113173807.32a2ba2f@kernel.org>
In-Reply-To: <20251112092051.851163-1-a.vatoropin@crpt.ru>
References: <20251112092051.851163-1-a.vatoropin@crpt.ru>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 12 Nov 2025 09:21:04 +0000 =D0=92=D0=B0=D1=82=D0=BE=D1=80=D0=BE=D0=
=BF=D0=B8=D0=BD =D0=90=D0=BD=D0=B4=D1=80=D0=B5=D0=B9 wrote:
> Another way would be to pass a valid wrb_params from be_xmit(), but that
> seems to be redundant as the corresponding bit in wrb_params should have
> been already set there in advance with a call to be_xmit_workarounds().

I don't think so, or at least I don't see that for all cases..

Since there's just one caller and it has the struct handy I think=20
it's better to just pass it and avoid the NULL.

BTW there are hard spaces in your commit msg, please try to fix
that for v2.
--=20
pw-bot: cr

