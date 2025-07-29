Return-Path: <netdev+bounces-210824-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F813B14FF5
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 17:06:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AC22171DEA
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 15:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54B926AAA3;
	Tue, 29 Jul 2025 15:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="Oz3cgp4P"
X-Original-To: netdev@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4816A207E1D;
	Tue, 29 Jul 2025 15:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753801590; cv=none; b=dYCrK3TlCOMdkFATfoiNUqHAcRHG8FiIdti0B9/Cipf089kl6DEyux+dy73USiZQcsxdcFg8oY/gkqhg+31/LrA+plmaiIOM3yeWXSvP+KNRhUNEX/MfUIrNC2t80xuRGhFtn45kMnoziz0Wt0s/qpM/8z/6hkZdk2Z1zu01MCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753801590; c=relaxed/simple;
	bh=PvbI4Mz0pcXa1WZQDU4y4yYv4ip/qg1s3TKzZSqga9s=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=XjccxVZmOqoIRL19pkjuonv1Zw+zS1mHmzVRoMHmULXNYFk8/1Gw7daNBXNmdhZBd4qtYzT3VFPpAYpalvvGV46PEISxGyGi/8hYq7fOTKF+i090sp6b5NH2TcYbPXNbtP9RQxsCBv7vunowslW7ElxKpZT7gjgUAhogUBgxWjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=Oz3cgp4P; arc=none smtp.client-ip=212.227.17.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1753801571; x=1754406371; i=markus.elfring@web.de;
	bh=PvbI4Mz0pcXa1WZQDU4y4yYv4ip/qg1s3TKzZSqga9s=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=Oz3cgp4Pz8CKuLShAAL/UK1Ff6PgqEcaEC9R12rzkLqZjApLckVLR6Jggn4lO3Fw
	 kCt06Vzde2YlpjEOEVTmdzdvu7ViwxxD2N2H5bWI69vMTnq/E9VfDnTncIbL1Iyar
	 vAlWD/D7ml6iVA9GulV5g18Zypa5PmlQ1O0WUQBNPqKPMBzOzsLs+mosspLN2qzd9
	 CSpteFt8cG9Chk5c3OdY86sFsUcrWc0hINkj7TKzWy9GaTlkkCOF3hsYSveN2fu3m
	 ODMAgpHp4i49PYLeS2aOBq0mAcxSZkKPk6lob5A10yo/F2UjVqli0sjAuUMBN4EVc
	 iKqyxRP5DToaxejl4A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.201]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N9cLf-1udWj81NRN-00weSj; Tue, 29
 Jul 2025 17:06:11 +0200
Message-ID: <6b7f5179-66c7-46ae-b1a9-af9be97baafe@web.de>
Date: Tue, 29 Jul 2025 17:06:08 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Tian Liu <27392025k@gmail.com>, netdev@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Igor Russkikh <irusskikh@marvell.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
References: <20250729005853.33130-1-27392025k@gmail.com>
Subject: Re: [PATCH net v2] net: atlantic: fix overwritten return value in
 Aquantia driver
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250729005853.33130-1-27392025k@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:39wbgMK7BtJ4ap8lsna6Ki8ZmJqrAY3pigrKmLxfDJmIBObyz4l
 hSIXg6exPgJ2ydQMUFh0XNYQT3S3oeY16l+TILY4aH5XBmzQYRIPQTsqNsIupLt5j4T2DT1
 E7yNjK+H1dJxPLcsJ1EfrxBo+ou4X0HyOxpKl9CtUxViWAdp654jUFxLEQHmKRJAV+eBXjS
 hrs6W1i5Y1bzYZntUQFcw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4uo2xk/iK18=;11vwohP2PEjC0GVXDZ8QLY0HcQG
 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

=E2=80=A6
> This patch uses =E2=80=A6

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n94


=E2=80=A6
> Signed-off-by: Tian Liu <27392025k@gmail.com>
>=20
> Changes in v2:
=E2=80=A6
> ---

Please move the marker line.
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Do=
cumentation/process/submitting-patches.rst?h=3Dv6.16#n784

Regards,
Markus

