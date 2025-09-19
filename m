Return-Path: <netdev+bounces-224698-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D036B8872E
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26D26524BE8
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 08:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8020B304BD7;
	Fri, 19 Sep 2025 08:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="gBokNVPS"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3562D9491;
	Fri, 19 Sep 2025 08:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758271191; cv=none; b=J306ojS9lc+hpiisFNltYiV2ynKV9aK/H4zElTEdnNe4Ju7a3TdKBPfycsdf2T61dL8Cl+xN5iOUdvHHGa2WTOamzXSV7BPZkyuO3j7A32zZrL3E154hfUs+lzQRGW9TzQGD2UPTzzaNT4biuxWhXlZcmA/omoYkd0mYBgApSRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758271191; c=relaxed/simple;
	bh=ZdTbnKMvIuPRkDMyZvm2bgbqgaz0f52N9nJkmQJUnB0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M9Xawx8Xw5sF8MZWmT1+zFbyspDFFb24lzjycXL9RFCgCKZLrlYq5ag/07KQIxVLiDMo+e449shg2j9bmrl/zppuxeC2KuhjU/amlRSpgCI6fq6SAmX/Ykl/2iyL9+oYrAGHrqOPL6eQCB481j5BraDZscV6QtA5Bm8oBsc06IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=gBokNVPS; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 539964E40D5A;
	Fri, 19 Sep 2025 08:39:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 123E6606A8;
	Fri, 19 Sep 2025 08:39:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id ED5AD102F1C98;
	Fri, 19 Sep 2025 10:39:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1758271185; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ZdTbnKMvIuPRkDMyZvm2bgbqgaz0f52N9nJkmQJUnB0=;
	b=gBokNVPS56PuxeZ5y4w0f5hGWEL9+16O22kukgvQb33n1vcXKgql1Gbx295bGer2OySAxj
	ZBBb/XB0d0fLYeS50w1gj1hJT+Qp8RRgLsWAE0P3QaXrCUI+q1vJsUNP1sPycM+ieXp43F
	/ctxBV4eU/S8v7jRK0xHiFV+oDIBjg2FCWGHdpBjel+FwqZcE9I+tRITe9g0qeM+UniBeD
	VjWj1j80c+WIhAZmk5clBYhGdn7hEfd407N04lUatThDmY1Bn6TvQ0BHLr2L4qVpPiQiCH
	LiBr9JMT+0VbJ4GPwjHKXm6+EuFDsBcwMSmaV9axpynXzM2I117WAxTeeu3Ciw==
Date: Fri, 19 Sep 2025 10:39:28 +0200
From: Kory Maincent <kory.maincent@bootlin.com>
To: Jacob Keller <jacob.e.keller@intel.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, Broadcom internal
 kernel review list <bcm-kernel-feedback-list@broadcom.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>,
 Richard Cochran <richardcochran@gmail.com>, Yaroslav Kolomiiets
 <yrk@meta.com>, James Clark <jjc@jclark.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 0/3] broadcom: report the supported flags for
 ancillary features
Message-ID: <20250919103928.3ab57aa2@kmaincent-XPS-13-7390>
In-Reply-To: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
References: <20250918-jk-fix-bcm-phy-supported-flags-v1-0-747b60407c9c@intel.com>
Organization: bootlin
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

On Thu, 18 Sep 2025 17:33:15 -0700
Jacob Keller <jacob.e.keller@intel.com> wrote:

> James Clark reported off list that the broadcom PHY PTP driver was
> incorrectly handling PTP_EXTTS_REQUEST and PTP_PEROUT_REQUEST ioctls since
> the conversion to the .supported_*_flags fields. This series fixes the
> driver to correctly report its flags through the .supported_perout_flags
> and .supported_extts_flags fields. It also contains an update to comment
> the behavior of the PTP_STRICT_FLAGS being always enabled for
> PTP_EXTTS_REQUEST2.
>=20
> I plan to follow up this series with some improvements to the PTP
> documentation better explaining each flag and the expectation of the driv=
er
> APIs.
>=20
> Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>

Reviewed-by: Kory Maincent <kory.maincent@bootlin.com>

Thank you!
--=20
K=C3=B6ry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

