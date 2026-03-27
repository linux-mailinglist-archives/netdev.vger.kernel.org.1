Return-Path: <netdev+bounces-272468-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MPllKr1GxmkbIQUAu9opvQ
	(envelope-from <netdev+bounces-272468-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:58:37 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F80734162B
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 09:58:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 199E3300AC1C
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 08:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 079C93D9DA6;
	Fri, 27 Mar 2026 08:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cTqQEdqP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 962C33D3D12
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 08:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774601811; cv=pass; b=R01sa6R+9+JWak2/a0D0bvZBj3Iv83eymvsXqzBzolorgYDdL3eA+HsBQEdg/x7rLzlInzbClWzjCINKE4msW+56rXXIVHxMVRb5LHICVNCI5IgkYqGY74Debky2cKZnLRLLFHoCz5kC98pPistesQgMYwKW7eS9eBodjjfzoFY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774601811; c=relaxed/simple;
	bh=BAy7dt9p8q1EPcSpdCj4Qxmjm7cEvuikrTG/6GyZGOk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vg/pg8U5+TI4jCaYRMwvQQqCcjhmZvuEuAxn5tReCSXJogu5Ai5xLUJV4Ni7Dar5/yhK+6twoU7WQ2ckZAU5W2kifwuQv/pHtv8pV4OwrrJLSWk23El+lEvQ6cFzSnQCxeH+2xvlyIgdy+AP2q94rjkiIH4oTgllxJ7wayRN/bY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cTqQEdqP; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-899ee491af3so20541426d6.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 01:56:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774601809; cv=none;
        d=google.com; s=arc-20240605;
        b=hcj7ZA8gqUDk6NDMoPZf3fmXuil0mLASMs5A3rFJdYaSqrrV9NP3MK3DYMmO6asT11
         cIUTn6vCODkoLv8tEa010yJhhmkLogr/41LaKmtqPe/5K07GQfg9MQwqnsXjtbAJJyO/
         mWAjHnvbnAkTpsh44HKhEpzz37RIMp1Wo0JXOJzuK99dqf+s/ub4jYmeBjjZJq0g1upP
         4kRb44n3kTfQfiKpS5eLbYXTIXiDXBvTrejqJIk1MvqnFB0PKPKsDelJ2hAmnkxN27fF
         RycFXUiXanxkrSrKiXcm4eut1VImeNYLsl0NqgS6BeRAGA7sHpWurKCodFcoIJfEgbdq
         g7Ew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TfgIZBix8EryPJVpFF9gdxswK0/Wk70kOkvKn4+DmBE=;
        fh=SfaTiBu+sDri2m+yxOLRil/8GjJH7/lbBmQdPMjjiNA=;
        b=gWuf78TrV5qWleqpdkkiJR52KNjvdHCRpQ5RBXMmNHUTE3kOTuEMwIZQCiboYJb/S8
         YnSY2JygQC8HOiyETVcujFFCCZt0QrOpDXWuGMS/lpUyWViBBPlneL3zfLBeMbChkEXM
         s1/fVov950UUvXggYcH5IFIqeGkjMWVBY/XyWXLKzXhJhVzYSXf2sObledGwISmQBL5s
         TvcqUDc262f8P1u/grBdzQ+SNuB7vGZ7VHpo4zxT6A5hRz29k4F0v27XRUWk+/1ConaM
         6ChpgYY7qlGHfHfqjlMw/mhFwIhs3tQWbwoqVW2EtaJfFVu8F+R8/JTlf8gTBaDR3Ufo
         bqkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774601809; x=1775206609; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TfgIZBix8EryPJVpFF9gdxswK0/Wk70kOkvKn4+DmBE=;
        b=cTqQEdqPnow5Rm3VoB5C9szOQnE/fT6KZDAoBKrzWzq8IquPwcxr+fo6S/yfXCZQFv
         3dRMY02qH2kNvxYVYi5jRSYaweAXoGJohGOrmNc6mkZEipbnftOaX9iAOye/zPMUn25E
         Q0bnXptTMwRek6mkJ3FgGSUZmvCrPB8YpIKTt8QtQDDZoq3E5Q2GXSTPldpNZWPW66YI
         sJHp5+bNkYaif/DvS6sQumf8MVsks0R8rEbX93ND/Cvt5kLeBdFEjXPWBh78sBuLW01x
         bUs7Yc1vtnCeDXzvZ2TfvzITbwLfJ/JwJtstiKsdzCLVyT0J6lUdib1hdmDUUbntI/A3
         PYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774601809; x=1775206609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfgIZBix8EryPJVpFF9gdxswK0/Wk70kOkvKn4+DmBE=;
        b=XAqvlqlVP+fxMABt/qb2JYcpkgVR58EGEMROLrAIx4WAGu77sA8l8gflSz6w6ARDHV
         yF58X91+JvZ/u9mancl1K+gWXse0fpW92Yj0QWXCv1gsNZEHp3DRY7e8y0oDviHsQ1y8
         J0igeh3QIKS2jH9RiO9srQsDDU4+pvKuRCVNE4WPOQB0ymYnk8/GrStz82CDt/AXFhm5
         BG3SstYa3rk9RFZDgl6S9QSe7HqV/sJ3WRrtyelJB4Rt3D6HBORfH/vJcukB4so/xzU1
         o9VKF8KiBm/bvbQF721EbAjDbI8vAv1guzu9Rmv9F1xQqJ14YJScMAHeqHidH2gJkkhb
         5AgQ==
X-Gm-Message-State: AOJu0YzSoAlwBxzkP1oeGXQ3qD41yDPiH7wQZ/PATJW33gQyYLH/Betq
	iB2pePEdZTO5AckimfQWrCuM3NI4q6RSw9XMwE5uZl04OS+XSFEcfmVQHirnX/tZc26RRv7SNyQ
	3sbs7mVpx0Yxqex3X+6w/Ac4qGULX+qwUH9/Yl34s
X-Gm-Gg: ATEYQzwDK/QMgOxVy+8DUyV5S1rDAicW0LhSDPEC0au9QNQ6xNYGYP+6YZ+quEmv7sD
	C+0eKqGoeold5kJo2P7DLXvqEYm1NPhtfK9jToK/X/7VvqsR6NjHE1l6W+qK4jdUfHRIfsDS6VU
	NqWf0FMks5fcvdD6hbbfUq6L0Ymuu8So85XGAtVqh6EEQsT8hp/YSgggnMNCDaaTj1cQkmi0bDW
	PDXlKCZCIbWqQyrl5CWURY3wdohXydpESWXpsKf9dgjUzgVJH9zc7HpFLtUDwvIDIB2KqOFE0h3
	+KE+GiinPOr7dxoIYOIFmVCtt3L7J5C4FAojzivA0WKTEl9SXwfyy3m8IB0f
X-Received: by 2002:a05:6214:194d:b0:89c:6bc6:e4fd with SMTP id
 6a1803df08f44-89ce8d97094mr20986136d6.19.1774601809403; Fri, 27 Mar 2026
 01:56:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260325152801.236343-1-jiri@resnulli.us>
In-Reply-To: <20260325152801.236343-1-jiri@resnulli.us>
From: Ben Copeland <ben.copeland@linaro.org>
Date: Fri, 27 Mar 2026 08:56:38 +0000
X-Gm-Features: AQROBzAikv2UHh7exGnWEGTfTrjOShVNQIpn1v4T-UcswAGH9lv0Fr1OUhO_SJk
Message-ID: <CAL0q8a4X6OTB-LAUyuzdVxdqDmi6DU5a+1PR=63zijxq4xdrxg@mail.gmail.com>
Subject: Re: [PATCH net-next] mlx5: shd: Gracefully avoid shared devlink
 creation when no usable SN is found
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch, saeedm@nvidia.com, 
	leon@kernel.org, tariqt@nvidia.com, mbloch@nvidia.com, 
	admiyo@amperemail.onmicrosoft.com
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[linaro.org,none];
	R_DKIM_ALLOW(-0.20)[linaro.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272468-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ben.copeland@linaro.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linaro.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,onmicrosoft.com:email,linaro.org:dkim,linaro.org:email,nvidia.com:email,resnulli.us:email]
X-Rspamd-Queue-Id: 0F80734162B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 at 15:28, Jiri Pirko <jiri@resnulli.us> wrote:
>
> From: Jiri Pirko <jiri@nvidia.com>
>
> On some HW, not even fall-back "SERIALNO" is found in VPD data. Unify
> the behavior with the case there are no VPD data at all and avoid
> creation of shared devlink instance.
>
> Fixes: 2a8c8a03f306 ("net/mlx5: Add a shared devlink instance for PFs on same chip")
> Reported-by: Adam Young <admiyo@amperemail.onmicrosoft.com>
> Closes: https://lore.kernel.org/all/bab5b6bc-aa42-4af1-80d1-e56bcef06bc2@amperemail.onmicrosoft.com/
> Reported-by: Ben Copeland <ben.copeland@linaro.org>
> Closes: https://lore.kernel.org/all/20260324151014.860376-1-ben.copeland@linaro.org/
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
> index bc33f95302df..b925364765ac 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/sh_devlink.c
> @@ -33,7 +33,7 @@ int mlx5_shd_init(struct mlx5_core_dev *dev)
>                 start = pci_vpd_find_ro_info_keyword(vpd_data, vpd_size,
>                                                      PCI_VPD_RO_KEYWORD_SERIALNO, &kw_len);
>                 if (start < 0)
> -                       return -ENOENT;
> +                       return 0; /* No usable serial number found, ignore. */
>         }
>         sn = kstrndup(vpd_data + start, kw_len, GFP_KERNEL);
>         if (!sn)
> --
> 2.51.1
>


Tested-by: Ben Copeland <ben.copeland@linaro.org>

Tested before and after on the Ampere Server, and the applied fix worked.

Thanks!

Ben

