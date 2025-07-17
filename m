Return-Path: <netdev+bounces-207656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BD2B08144
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 02:05:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA5333A3754
	for <lists+netdev@lfdr.de>; Thu, 17 Jul 2025 00:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF324645;
	Thu, 17 Jul 2025 00:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u6/ihc39"
X-Original-To: netdev@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62013383
	for <netdev@vger.kernel.org>; Thu, 17 Jul 2025 00:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752710707; cv=none; b=CS/RM8qV7pOwWIu1TQOS13iWJI7Wv4FG6Q1FPYXdLgyJ5CjG3qBCHBDeZQcs6vHrO4YtELlvYjBZee5wD5NUeRDH+XeijPyozuq4HBg3O8eAj61w3ddyQ8qZ91RQ/z2zK/dgPTr5zfxPhFdIQ0P4ixLFRVaKbR7PhdO/LqkMoCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752710707; c=relaxed/simple;
	bh=XrI11OlKqo0GkcT2iRh9J4cAMdxAm0O0OQCxALpyLVI=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=cjKA1CdaTYI+PY91D7Mn+uqPikYvV6uynKcGDLN6qs4UMSH7dWMkYAFd2LX5M0ThnC6iq0fwLagK7/6DkAvAQAovTkFR7AdAhCK7sIxM3htUIfZtFYIEb6AxKcvzrxnfCjvWrGPLVodRvO5lJUNm+JiLdm2vpToG/iB/XO65cmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u6/ihc39; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752710700;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=s3LeNNXWYtT9+vzmGvN+VVuby8HV4u2TAQmNVg+niNk=;
	b=u6/ihc39xZlsUfUvt4uOD4TdtHlmBg6TWearERWsq+0mr5qbWySV8F+T7V6UySwkiNryls
	a0Gqb5DSGugrVXX/Jj5egO3r4zu6y7p85cf730fLLJLWtv4xlQN+QzDDQXmXPgCdU9495E
	BtgHk/BJUaMsJFjKpUK/+74YbDwd+ps=
Date: Thu, 17 Jul 2025 00:04:56 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: qiang.zhang@linux.dev
Message-ID: <62666ecc6ac9c5217cf5e376424e512a511791fe@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] net: usb: Make init_satus() return -ENOMEM if alloc
 failed
To: "Simon Horman" <horms@kernel.org>
Cc: oneukum@suse.com, kuba@kernel.org, andrew+netdev@lunn.ch,
 davem@davemloft.net, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250716091839.GM721198@horms.kernel.org>
References: <20250716001524.168110-1-qiang.zhang@linux.dev>
 <20250716091839.GM721198@horms.kernel.org>
X-Migadu-Flow: FLOW_OUT

>=20
>=20On Wed, Jul 16, 2025 at 08:15:23AM +0800, Zqiang wrote:
>=20
>=20>=20
>=20> This commit make init_status() return -ENOMEM, if invoke
> >=20
>=20>  kmalloc() return failed.
> >=20
>=20>=20=20
>=20>=20
>=20>  Signed-off-by: Zqiang <qiang.zhang@linux.dev>
> >=20
>=20
> Hi,
>=20
>=20It seems to me that the code has been structured so that
>=20
>=20this case is not treated as an error, and rather initialisation
>=20
>=20that depends on it is skipped.

Yes, your point is also correct, but in theory,
if usb_alloc_urb() allocation fails, we should
also return a value of 0, should we keep the
two behaviors consistent?

>=20
>=20Are you sure this change is correct?


For drivers that have a driver_info->status method, it is generally
needto allocate an interrupt urb and fill it to obtain some
status information, but if kmalloc() faild and return 0 in init_status(),
and some dirvers directly call usbnet_status_start(),
the WARN_ONCE(dev->interrupt =3D=3D NULL) will be trigger.

Thanks
Zqiang


>

