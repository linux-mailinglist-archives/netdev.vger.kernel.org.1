Return-Path: <netdev+bounces-82908-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 378C889027C
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A270CB21DB8
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4ACE7E56E;
	Thu, 28 Mar 2024 15:00:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929957D417
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 15:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638020; cv=none; b=nxWXIoxeFiOIVX+xbJsCNuhS87zn3qTpBpiktL0Ewtp2e1jr4O4v9cY5xVef2EoH28YumWJIkHEWC6Ld/5vjrsDQqsd/LDGRjgMMWWFLVKLxIbvN4OOgFV/3nzjCQ+TgRY0HPyMGeHoaYUWzpabd4yZStscvvxjBNekW+5oG5hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638020; c=relaxed/simple;
	bh=pD/njvLamfRD2Zrv+piFl5wkdOBof76JZ/X7Y3agcp0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CtqnGDrACp9WowcqYitqk/m5rh8yFL/lbtVh7llshDYtbj5Ovs/nYgI1bnhULsGQ/RkFFVrHGbhPG2DAVgjUB9bTHYD2618tju0qF7UrX7Gy/lcKEm6if1EeoWucyu1zg21hGA6fQzW54tV/ZsIFIA6IZvWHIjJ42YXuHwq6zoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a46a7208eedso157133066b.0
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:00:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711638016; x=1712242816;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lUbaUhVckqEhZtx+U5u0khQRhlEFlib1PWCFSRYkUGk=;
        b=dgAjpPdRP1a3BaPzyOaex8XcqADR/wGtzIREgM+6+jGru/R/QWqOJOBEkSeh5BIVjW
         i/gCzAbqH4URKX8U8guMQIKxR3MkTxjZ2tlvJGifWFNRRmBYDoOaqtY1BCDWfmsDQFaj
         gCVSN1+Bb2wGAUf/KLlxTMwF1plf4Vwbw2yUOm0n9p4JLmBinLT54jJOvIKuGQ+rInNj
         gVWJ/RpZOxSVo/2Jn76F1I41UG7D7SDsJ1+Ko1X4FvyKjcXwkTdrIWBcOtDFjm4FDtjP
         hT0QwKmDQbQI5u1sCjfD0IoQxGE1/KidFTaaAAXmH2X0b9nPkN0htu9lRMupr9DobeNP
         G+sA==
X-Gm-Message-State: AOJu0YzVOsZqTj+4MLTniStveUanPzl0McgojILrEooeFVYI7bzmh6Jq
	mpqqNiKu5nFROkPU3I8QXEW2ugY/qiIiKaMReZo2T+qoe7wSpo3+
X-Google-Smtp-Source: AGHT+IEehtPyKOufo05mS9mUKL2AZc2eVYkGVvg1q74sJ6ESsEnVOV4286aC5osbGV/QHUAV9GB/rQ==
X-Received: by 2002:a17:906:68d1:b0:a4e:2c19:b73c with SMTP id y17-20020a17090668d100b00a4e2c19b73cmr316865ejr.66.1711638015676;
        Thu, 28 Mar 2024 08:00:15 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id dp12-20020a170906c14c00b00a473a1fe089sm848695ejc.1.2024.03.28.08.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:00:15 -0700 (PDT)
Date: Thu, 28 Mar 2024 08:00:13 -0700
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 2/3] doc: netlink: Add hyperlinks to
 generated Netlink docs
Message-ID: <ZgWF/fIGXo/C1LSh@gmail.com>
References: <20240326201311.13089-1-donald.hunter@gmail.com>
 <20240326201311.13089-3-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326201311.13089-3-donald.hunter@gmail.com>

Hi Donald,

On Tue, Mar 26, 2024 at 08:13:10PM +0000, Donald Hunter wrote:
> Update ynl-gen-rst to generate hyperlinks to definitions, attribute
> sets and sub-messages from all the places that reference them.
> 
> Note that there is a single label namespace for all of the kernel docs.
> Hyperlinks within a single netlink doc need to be qualified by the
> family name to avoid collisions.
> 
> The label format is 'family-type-name' which gives, for example,
> 'rt-link-attribute-set-link-attrs' as the link id.
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>
> ---
>  tools/net/ynl/ynl-gen-rst.py | 44 +++++++++++++++++++++++++++---------
>  1 file changed, 33 insertions(+), 11 deletions(-)
> 
> diff --git a/tools/net/ynl/ynl-gen-rst.py b/tools/net/ynl/ynl-gen-rst.py
> index 5825a8b3bfb4..4be931c9bdbf 100755
> --- a/tools/net/ynl/ynl-gen-rst.py
> +++ b/tools/net/ynl/ynl-gen-rst.py
> @@ -82,9 +82,9 @@ def rst_subsubsection(title: str) -> str:
>      return f"{title}\n" + "~" * len(title)
>  
>  
> -def rst_section(title: str) -> str:
> +def rst_section(prefix: str, title: str) -> str:
>      """Add a section to the document"""
> -    return f"\n{title}\n" + "=" * len(title)
> +    return f".. _{family}-{prefix}-{title}:\n\n{title}\n" + "=" * len(title)

Where is 'family' variable set? Is this a global variable somewhere?

