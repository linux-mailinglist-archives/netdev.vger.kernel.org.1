Return-Path: <netdev+bounces-164392-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 634DDA2DB51
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 07:24:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A809B1886850
	for <lists+netdev@lfdr.de>; Sun,  9 Feb 2025 06:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA36243AB9;
	Sun,  9 Feb 2025 06:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FtUcMwlB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2BD633987
	for <netdev@vger.kernel.org>; Sun,  9 Feb 2025 06:24:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739082250; cv=none; b=kEbS5uEmMWpx8fIoNqOA6uhmdf4b53Hke6Dc6j2aYcm1yBZ+YKApRVQjOoimmwrcNpiXTwv5dEJLUBrG0TJRJGckydNXuzXexxjQfOEfKmbol8b9tEbqo5iE/P+J9DZ5Th2W9kN4ncMX+WfgbyfLLXPFZxHaRsqP+tuiTdsnmWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739082250; c=relaxed/simple;
	bh=aE8Pr7FMgBpzGLwqUQPLB4QILiBDleWz4ZaabRMSO3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCdMkvst1s1XlHBLlCljwAOzwqPHXFEq314ivkOQY7U0ctYklspQxaNjiPLHnqf0WqPzSTgWNSJky6wr5zogT1B+0bXca9ra/7FnPei0O/ZHiEzLFtLWqvDdYvvb5OZ1hujSpn1L0SBCpWkObhHjBanLxovqDu/gxfD2lg/MU9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FtUcMwlB; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5de63846e56so1199158a12.1
        for <netdev@vger.kernel.org>; Sat, 08 Feb 2025 22:24:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739082247; x=1739687047; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yTto9Kr8hhs4LG0n8TSGyp+f3yaAmq1VIFKY3P9KHF0=;
        b=FtUcMwlBjGcQm5TpBrrrZSc1mtPEy+KFHo/653m82noS/CzyuNG9SPjdjcJyxelUUe
         h1N+NiIxjF3WH0zlm+nAE50y8HvWYYJDaFAjs4gZqpm5tD1fxktpGT6UOjt2DUZv9w4i
         mQlkmsBGdIG0GqbgJUZQ+hshLkCwikJw9RntesMheXGA9Gw+ACZPxlYG5+JakwOZmvt6
         jRwwPHJQEVDUUPXBs3AQL990P5/0wE3d1s96w8Gy+RWJaDjLZHgB8sVSD6eobH4liCPv
         02hEgh7oDTbArzfU+4PdOSu8wzsa7wPKTKKgpqK+JD7w0WizCeFa35YXaNXJccNzZTFK
         QcoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739082247; x=1739687047;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yTto9Kr8hhs4LG0n8TSGyp+f3yaAmq1VIFKY3P9KHF0=;
        b=YKkCTTftVrWbW7JV505I0gcMelMNYCW8zQEk5OKvWnAZ/eAfSNG9CM8gqIxm/rJqAX
         p52OXlgHcQZgjQA52crG68CNF3soXRiuJrj+gORZtpdcdDkqzUeOzKpjeQnLI4S/0KPJ
         UMdE2UvRT101fYEUWLFulzfXl1ZH5tG0bYfqS+zAjK5LKKRvqfxO6CHy8O5jlxxs4Tzg
         L3gZN7njgLuuEePiVQUIyIecziOs/D+9zxoSFQGuySRlhvtM8TGbaaKehRe+otzWxHX9
         LUlOjMS+T3LVG3NvQtbZQBwiXQfqEFC/jyGcIg8sZHqKDqDMP3p3D/Ef6uX6qPYo2mdK
         NDew==
X-Forwarded-Encrypted: i=1; AJvYcCVuIzbyTQ71wDbh5G7ZeMSFwf9VrQc3B+lh6a6BWAHCJ5O7XA3odx1e4aePkXgT0vm8lYV+hIc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOAgIcIgtk5bEQm1hePiKtHqw7Y+nuQ0D0nJwyYU4HBJx4hDlk
	KkS+VpyBtTylpqIoq9K+5gb1Z9n1C92O3a1+XlyQDxrsuCIurQtO0FWDCxCCzz4=
X-Gm-Gg: ASbGncv3uUBJmx4ttrNYXD5vIogoE5Ye9SWwyR4wgRh5coaKenCmJ7XbfyX+hjZ1Xdh
	vFsi4GWy739gXhEQq9aoDRLteSSe8B/na1ZJMf64aXWqfl2sknEewx/i6W+/S39g6phfSJtqVIM
	R+J1KSJUbfFV4LFiXq4OA3PsKZYzQhe85TVdgNnxC9bLfBsctI7DUwJ/w46BDaWirvFs1JGxxF3
	sHHap7mz/9kQLwh7ou3XMaybtD1Sv5ydFJafGdl6oxRbBUoZ5MB5U4x6IjZN1MNCTIqsfA8fgnX
	06kKbmO0vcxx8jP6NC/p
X-Google-Smtp-Source: AGHT+IES82N8C+fmH6KFZPQ2PcILhvhCYo68TATrCctmduAL8AzzSocttcg6O+pNFOFLcG4GQSgsDw==
X-Received: by 2002:a05:6402:4588:b0:5db:731d:4456 with SMTP id 4fb4d7f45d1cf-5de45085cc7mr10374231a12.28.1739082247149;
        Sat, 08 Feb 2025 22:24:07 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5de63a89b6asm1714510a12.46.2025.02.08.22.24.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Feb 2025 22:24:06 -0800 (PST)
Date: Sun, 9 Feb 2025 09:24:03 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ethan Carter Edwards <ethan@ethancedwards.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linux-hams@vger.kernel.org, pabeni@redhat.com,
	linux-hardening@vger.kernel.org,
	kernel-hardening@lists.openwall.com
Subject: Re: [PATCH v3] hamradio: baycom: replace strcpy() with strscpy()
Message-ID: <90cb9ac2-2af9-4fc7-b93d-0f36514a76f6@stanley.mountain>
References: <3qo3fbrak7undfgocsi2s74v4uyjbylpdqhie4dohfoh4welfn@joq7up65ug6v>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3qo3fbrak7undfgocsi2s74v4uyjbylpdqhie4dohfoh4welfn@joq7up65ug6v>

On Sat, Feb 08, 2025 at 11:06:21PM -0500, Ethan Carter Edwards wrote:
> The strcpy() function has been deprecated and replaced with strscpy().
> There is an effort to make this change treewide:
> https://github.com/KSPP/linux/issues/88.
> 
> Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
> Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
> ---
>  v3: resend after merge window ends
>  Link to v2: https://lore.kernel.org/lkml/62yrwnnvqtwv4etjeaatms5xwiixirkbm6f7urmijwp7kk7bio@r2ric7eqhsvf/T/#u
>  v2: reduce verbosity
>  Link to v1: https://lore.kernel.org/lkml/bqKL4XKDGLWNih2jsEzZYpBSHG6Ux5mLZfDBIgHckEUxDq4l4pPgQPEXEqKRE7pUwMrXZBVeko9aYr1w_E5h5r_R_YFA46G8dGhV1id7zy4=@ethancedwards.com/

Ah great.  Thanks for remembering.

regards,
dan carpenter


