Return-Path: <netdev+bounces-52805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF4580041A
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 07:43:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 284F21C20BE2
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 06:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56991DDC8;
	Fri,  1 Dec 2023 06:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y54S440A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33B618483;
	Fri,  1 Dec 2023 06:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2828AC433C7;
	Fri,  1 Dec 2023 06:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701413015;
	bh=Ac2LAr8zXdRG53W9ecY2idG7L9BWseIgaVc9xlc+IgE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y54S440AsWcq4zKgpUJwb6Eo2jPhoX7OEwix9AjAOplmg8KzsEW4mWPmVLbS/be5P
	 zg67q/E27Rcg0tCBvZ+v84oAdnRUG6p9jBD7oGTR3YuBkahqq+0Kxteh/bDjpNGiSw
	 SXsByEmi9u5DSNcdMyAxlUkY1QomkRcc+INawIab8L8ILnzh6ODZe/T09BdZYJ89C/
	 aEYeUCIeSx5bWkt+MZOkk0i36rjzxGnSyYlT8vey+E5MfWKBR/LoCWpcASpjBUmrBK
	 ojgOYv3sryOwtdjHI771ExnzToumZEpVsmO5+PQLFNIqni8jAgTdkodgZeM5BdLnZa
	 bSY0whrHcPqNg==
Date: Thu, 30 Nov 2023 22:43:34 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Justin Stitt <justinstitt@google.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH] net: mdio: replace deprecated strncpy with strscpy
Message-ID: <20231130224334.1c1f08c9@kernel.org>
In-Reply-To: <170138163205.3649164.7210516802378847737.b4-ty@chromium.org>
References: <20231012-strncpy-drivers-net-mdio-mdio-gpio-c-v1-1-ab9b06cfcdab@google.com>
	<170138163205.3649164.7210516802378847737.b4-ty@chromium.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 14:00:33 -0800 Kees Cook wrote:
> Applied to for-next/hardening, thanks!
> 
> [1/1] net: mdio: replace deprecated strncpy with strscpy
>       https://git.kernel.org/kees/c/3247bb945786

newer version of this was posted...

