Return-Path: <netdev+bounces-141275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02B3E9BA544
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 12:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B6A9281D92
	for <lists+netdev@lfdr.de>; Sun,  3 Nov 2024 11:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEFCF171E43;
	Sun,  3 Nov 2024 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b="RGXnp5nG"
X-Original-To: netdev@vger.kernel.org
Received: from natrix.sarinay.com (natrix.sarinay.com [159.100.251.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D174C16FF44
	for <netdev@vger.kernel.org>; Sun,  3 Nov 2024 11:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.100.251.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730633486; cv=none; b=reiNH4ZhkNxElHFZUdCHAHQhJ7nq6TJ33IoY6lSUX/a4EwIelJB4jZfFl4qvgEGYCV++dHjkBhlyoDDYlJR0NQtaWOA/3+WLoS02cuDbZvHZrotnVj5CSuduHNqmNYnT4Ublq4TR89jIakTS2fJIufNfSmKnwjO19l6f/Mv5Srs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730633486; c=relaxed/simple;
	bh=c5lY5sJGa39xpgpuhaC+XT/5eSxUYygjNsfYEKJ6qo0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ivLyfVzJ5BeUf/S+TXIAU3CuOehiwGQE+Z4NfUJse49vdzLCLfjv7HuATVMmmj+40yrF4iqakdDyUTdx5uDJ2JF7nV+xw5FzjSrO6As2sUlteTt6df+DmGmFy9m44/PKEZ5VjGR5AT/m5GUt9tez+rfhD6AQMG2tn2awKKqk+Z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com; spf=pass smtp.mailfrom=sarinay.com; dkim=pass (2048-bit key) header.d=sarinay.com header.i=@sarinay.com header.b=RGXnp5nG; arc=none smtp.client-ip=159.100.251.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sarinay.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sarinay.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=sarinay.com; s=2023;
	t=1730633477; bh=c5lY5sJGa39xpgpuhaC+XT/5eSxUYygjNsfYEKJ6qo0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RGXnp5nGoY6KDY4k0DFJzn4LSmctQVeLYmcbtVQzGqfYEr0kJ7LNm8LK7SzWPi5eZ
	 yer46JndbVBDYFN3aUf2UYUiU6rbuGQa7If35YHFdmBkN7Td47P5wsCol6iKBOQV3z
	 2riKIjW/3nMipG2kaaVWYYck/AOcP8ASNUL7OTdkMq2TB7GGepGSykzaArjFcxHSL9
	 FwlwCEdcHEQDZvm53MxBZDpIplIDW7TvO5lAVInnmGKPPMCBl+XRxdsdyRyQIEsTkc
	 OSRe1goHMPg8TuXMY+phGW8IyDQWYg8qW+EjqMpBSCTypjf9V3pAQNc4nYbK6t0wXb
	 jsLc1u2zLrRQA==
Message-ID: <ee3c732fc23517439642d4da9ee9b198e8b77bce.camel@sarinay.com>
Subject: Re: [PATCH net-next] net: nfc: Propagate ISO14443 type A target ATS
 to userspace via netlink
From: Juraj =?UTF-8?Q?=C5=A0arinay?= <juraj@sarinay.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: krzk@kernel.org, netdev@vger.kernel.org
Date: Sun, 03 Nov 2024 12:31:16 +0100
In-Reply-To: <20241030183747.0a042cb9@kicinski-fedora-PC1C0HJN>
References: <20241027143710.5345-1-juraj@sarinay.com>
	 <20241030183747.0a042cb9@kicinski-fedora-PC1C0HJN>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-10-30 at 18:37 -0700, Jakub Kicinski wrote:
> > +	u8 ats_len;
> > +	u8 ats[NFC_ATS_MAXSIZE];
>
> New fields need kdoc:
>
> include/net/nfc/nfc.h:111: warning: Function parameter or struct member '=
ats_len' not described in 'nfc_target'
> include/net/nfc/nfc.h:111: warning: Function parameter or struct member '=
ats' not described in 'nfc_target'

Thanks, I shall adapt the patch accordingly.

> > +	if (ntf->activation_params.nfca_poll_iso_dep.rats_res_len > 0) {
> > +		ndev->target_ats_len =3D ntf->activation_params.nfca_poll_iso_dep.ra=
ts_res_len;
> > +		memcpy(ndev->target_ats, ntf->activation_params.nfca_poll_iso_dep.ra=
ts_res,
> > +		       ndev->target_ats_len);
>
> somewhat tangential but does something validate the buffer vs this
> length? I see handling in nci_extract_activation_params_iso_dep()
> does a min(*data, 20) but there is no buffer length passed in.
> Is there a generic length validation somewhere vs the bounds of @data?

It does appear that nothing else gets checked after the call to
nci_valid_size() within nci_rx_work(). An invalid length byte within
the payload might well lead to a read beyond the packet boundary.
Although the packets come from a NFC Controller expected to conform to
NCI, it might still be worthwhile to make sure all the lengths add up.

The problem is common to all nci_extract_* functions. Given the various
packet types I do not see a generic way to solve it other than passing
the (remaining) buffer length down to each of the specific functions.

On a positive note, my proposed change does not make the matters worse.=20

For clarity, I shall replace the hard-coded constant 20 by
NFC_ATS_MAXSIZE, yet keep the following rather redundant check:
+	if (ntf->activation_params.nfca_poll_iso_dep.rats_res_len > NFC_ATS_MAXSI=
ZE) {
+		pr_debug("ATS too long\n");
+		return NCI_STATUS_RF_PROTOCOL_ERROR;
+	}

	Juraj


