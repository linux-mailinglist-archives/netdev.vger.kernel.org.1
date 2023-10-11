Return-Path: <netdev+bounces-39908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD267C4D85
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 10:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 242831C20D41
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 641DF199D4;
	Wed, 11 Oct 2023 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E8pWZ2Ag"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19E95156FD;
	Wed, 11 Oct 2023 08:47:41 +0000 (UTC)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3433C94;
	Wed, 11 Oct 2023 01:47:39 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-693375d2028so5897665b3a.2;
        Wed, 11 Oct 2023 01:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697014058; x=1697618858; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5PHd4L11YnGUPoVNdOQWl2i7d9heDpgbDvz1RYjLYGo=;
        b=E8pWZ2AgZQklRG238cKQVbMARt6w17HVIcabdkMGTcdXdg7N/aD+wpIvfiBJjxG4gM
         Mj0f3YHZZBcP6Btm+dWcNBeWN4DN3/HdNryEsnmS/upGXVTK9VDO3JWfZOf4X4sTYfIk
         cNKCnvmthbvcV8SMFfT6polyc9b8a9UaHzA+q7JNIjaIYY/axPsrGs8vAXaZ1GJ/Vckt
         aHNK7+YpHD/bHTpVnOebg7s4GiEH0gkGfz2lF4kU9AWgyrHRzvbNfUMWC4lU3LzF+dYw
         JGGjY+543iHL2kneytDSRGmM9B1Fw6ucD3ouSdblO4g/FxPPeFUJK2Y8guzjs5XltUSn
         +Ljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697014058; x=1697618858;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5PHd4L11YnGUPoVNdOQWl2i7d9heDpgbDvz1RYjLYGo=;
        b=cVL/+tQiOzm620BPjkuv+Dgv754OgJoJIZS07xbwHnv2ZX+xVw8/Tsdp6kK0lIEytN
         h4BWHaCDAdhr2r14PPIz4BbAzKhdxDIKxk9CLTX1p3KHh0PkSjbGK3D9z2fKT7bs7L2i
         V2sc+Ih0L5wfrBM9yzRmGIaIxjVYov/BUyKajVuXGclZb1f4I2GvZQaoC5gWjtuEw08h
         ocNWMpOTzAabVkU/EdayNW9tzU52mdoZhAJiwgmlXBH3AW2+M8DMCE5k8dlFSmXP/4Xk
         ikBE47qFI0j12O7pqzMByho+kFgDuRPW8oOhvlknMJgHHU59BFct06LZL7JWKZfRvwAd
         HOIg==
X-Gm-Message-State: AOJu0YyC3ws2jy4EQYaNeCJbjDZ3ISUFG28bQZ9VJ2U58TzmtQcncUiR
	CwL27qSsG2aC4tFA7E750yU=
X-Google-Smtp-Source: AGHT+IHKp/lP2UEjdreQ/MNJ3ZVCxCcslScZQgnSOtE2Q68tcxarXWrfg8amvM0SQrX/eavqTPhfmw==
X-Received: by 2002:a05:6a00:234a:b0:68f:b5a1:12bf with SMTP id j10-20020a056a00234a00b0068fb5a112bfmr24118194pfj.29.1697014058577;
        Wed, 11 Oct 2023 01:47:38 -0700 (PDT)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id fb15-20020a056a002d8f00b006932657075bsm7797963pfb.82.2023.10.11.01.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 01:47:37 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
	id 3F2968222031; Wed, 11 Oct 2023 15:47:34 +0700 (WIB)
Date: Wed, 11 Oct 2023 15:47:33 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
	corbet@lwn.net, workflows@vger.kernel.org,
	linux-doc@vger.kernel.org, andrew@lunn.ch,
	jesse.brandeburg@intel.com, sd@queasysnail.net, horms@verge.net.au,
	przemyslaw.kitszel@intel.com, f.fainelli@gmail.com,
	jiri@resnulli.us, ecree.xilinx@gmail.com
Subject: Re: [PATCH net-next v2] docs: try to encourage (netdev?) reviewers
Message-ID: <ZSZhJW92xsLVdtFw@debian.me>
References: <20231011024224.161282-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="N/jma408R2QpVyun"
Content-Disposition: inline
In-Reply-To: <20231011024224.161282-1-kuba@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


--N/jma408R2QpVyun
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 10, 2023 at 07:42:24PM -0700, Jakub Kicinski wrote:
> +Another technique that is useful in case of a disagreement is to ask for=
 others
> +to chime in. If a discussion reaches a stalemate after a few exchanges,
> +then call for opinions of other reviewers or maintainers. Often those in
> +agreement with a reviewer remain silent unless called upon.
> +The opinion of multiple people carries exponentially more weight.

or no conclusing replies?

> +
> +There is no strict requirement to use specific tags like ``Reviewed-by``.
> +In fact reviews in plain English are more informative and encouraged
> +even when a tag is provided, e.g. "I looked at aspects A, B and C of this
> +submission and it looks good to me."
> +Some form of a review message or reply is obviously necessary otherwise
> +maintainers will not know that the reviewer has looked at the patch at a=
ll!
> +

So a bare Reviewed-by: tag is enough to be a reviewer, right?

> +Last but not least patch review may become a negative process, focused
> +on pointing out problems. Please throw in a compliment once in a while,
> +particularly for newbies!

=2E.. to encourage them contributing more.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--N/jma408R2QpVyun
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZSZhIQAKCRD2uYlJVVFO
oymvAP9DmFsyNnwltxdWdQ8mYcBNUcosrEZXiATNE4F9MoPGEwD9HHMb9gqbleNj
6Pn6Ea3JGk95CyppmVUuy+N53qybgQA=
=hKvm
-----END PGP SIGNATURE-----

--N/jma408R2QpVyun--

