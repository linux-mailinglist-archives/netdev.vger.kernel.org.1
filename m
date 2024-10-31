Return-Path: <netdev+bounces-140597-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 528DA9B7208
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 02:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180CE2813A5
	for <lists+netdev@lfdr.de>; Thu, 31 Oct 2024 01:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31DE4D8CF;
	Thu, 31 Oct 2024 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PAhL2XQB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DEC448CFC
	for <netdev@vger.kernel.org>; Thu, 31 Oct 2024 01:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730338675; cv=none; b=PDdOzp108zth9YfxeZTK+oAie0JYCYVNjE5ge9T+lmgNvU5XMSHMJYP5jdOl2TnGdonDQrOjYYan710fwq0DeRKjf4DapW8j/vTfVaX764B+0G8Cz9mS/C6J1CczNa5sn+BXpFPX3UU68wiUrfNmJtPPwIg9ff7PHW34PEezcDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730338675; c=relaxed/simple;
	bh=BHRunVDjEMTRKkpFFWE0gR9sPZHM3Ql2/4dbSymRCW0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oduCErgHMndAn5zOasmd2Z8Gtub7IGbCkICZv1h2aa1AhL1d7JWAuAmEq/PaUGwpJhlk5G/L9ucW32roPgtEjeJnVcgLjxVkbxy2b3m6pZckPMSdeZ0jB7buSZWy3sW00/3sH/jO+hHZSDXzG8F4E8Mq73Jn9CG/9rn//EM/xtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PAhL2XQB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D8BC4CECE;
	Thu, 31 Oct 2024 01:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730338675;
	bh=BHRunVDjEMTRKkpFFWE0gR9sPZHM3Ql2/4dbSymRCW0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PAhL2XQBZD+pNnOn1C+xw84UTto9vPgyak2F/Ev1SxTZCXcnSc719Fxnn0fQrKkCF
	 JxeCIv5fpBx/cCnz2IkPJXigiTMYlJ4cFqgCZeqJltxVs9tTMRS9DusiA3+Y7H3nZA
	 8ZMPnGfIzCa4OF/osu8J5L6sHdHIT1FORM7bzdLLnHe10oBCUL8AdYMDmN63I72f6D
	 GV7PVq2blfzK+ruBramBxvwnlAQml3ay+fL8idfZVh+fhtEo1ldzdkFvW8mZZt/EiH
	 Xc1QNEm2ETP902UP5ntYiFMOnbaQ7M1Q0aJsKFvgjwQZcSosASaWiHJ5voxmEsjrop
	 1iQEIUUTIVk5A==
Date: Wed, 30 Oct 2024 18:37:53 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Juraj =?UTF-8?B?xaBhcmluYXk=?= <juraj@sarinay.com>
Cc: netdev@vger.kernel.org, krzk@kernel.org
Subject: Re: [PATCH net-next] net: nfc: Propagate ISO14443 type A target ATS
 to userspace via netlink
Message-ID: <20241030183747.0a042cb9@kicinski-fedora-PC1C0HJN>
In-Reply-To: <20241027143710.5345-1-juraj@sarinay.com>
References: <20241027143710.5345-1-juraj@sarinay.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 27 Oct 2024 15:37:10 +0100 Juraj =C5=A0arinay wrote:
> diff --git a/include/net/nfc/nfc.h b/include/net/nfc/nfc.h
> index 3a3781838c67..72be94e5ecb1 100644
> --- a/include/net/nfc/nfc.h
> +++ b/include/net/nfc/nfc.h
> @@ -105,6 +105,8 @@ struct nfc_target {
>  	u8 is_iso15693;
>  	u8 iso15693_dsfid;
>  	u8 iso15693_uid[NFC_ISO15693_UID_MAXSIZE];
> +	u8 ats_len;
> +	u8 ats[NFC_ATS_MAXSIZE];

New fields need kdoc:

include/net/nfc/nfc.h:111: warning: Function parameter or struct member 'at=
s_len' not described in 'nfc_target'
include/net/nfc/nfc.h:111: warning: Function parameter or struct member 'at=
s' not described in 'nfc_target'

> +	if (ntf->activation_params.nfca_poll_iso_dep.rats_res_len > 0) {
> +		ndev->target_ats_len =3D ntf->activation_params.nfca_poll_iso_dep.rats=
_res_len;
> +		memcpy(ndev->target_ats, ntf->activation_params.nfca_poll_iso_dep.rats=
_res,
> +		       ndev->target_ats_len);

somewhat tangential but does something validate the buffer vs this
length? I see handling in nci_extract_activation_params_iso_dep()
does a min(*data, 20) but there is no buffer length passed in.
Is there a generic length validation somewhere vs the bounds of @data?
--=20
pw-bot: cr

