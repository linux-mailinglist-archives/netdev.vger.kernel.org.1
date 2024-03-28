Return-Path: <netdev+bounces-82910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4055B890293
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA3FBB22A44
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 15:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342BD7D417;
	Thu, 28 Mar 2024 15:03:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7641E48C
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 15:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711638209; cv=none; b=MElWzQEOG8BEh6T3t2zidPTu2PXnkHPgO+kpXhycULs+dVQG9Ih/vtRGRcBZmokn8g/xucDvrd4yWKF2FZE3CH30RAV+fVnnj22yxsSXXoc28RJ4PgNuaqTfh6O2G7LpyqUvaWqtNnvtfHvKCme13GnWv1n3xLhhhHnm28/7ofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711638209; c=relaxed/simple;
	bh=5EyZBOeRPa4QOPglad1fTvI7GeyrqMuIbfx/Tk5gSc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EoV23MVzkLt9DI+Xq75G+ITiH4OCNlDWERDcJiMk75yQvqC84W3WAddFFaFs8I0IMLNmKk4aF5Htx0PhqiMm21Hh2PUqhICFSe+Sy/CH2wKkrnWvOMJipXXCTaXnfdpeWiPafiSxtrHhhK/rohA5Nif3Kp4TZQ2OuP/+pMG4UAk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44f2d894b7so132366866b.1
        for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 08:03:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711638205; x=1712243005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hQLex7ntB7VTFPIaLwxFN4vNjoelaqHGNSsMwiUnFjs=;
        b=DJ2DA5bpm23lhfUaaITmUn97SNWeSA55BW3DJskKYTej+P92vpx8sDW2dDnfjDMVEO
         E+y1+czao8EHC2okuwuQhUvjKuA3CS//gAFyXXhph+WhfVkFZIfnHiNFugHhSLmTn/MY
         cPkOc23JmKexkcK/1cktkwWI11j+eEpxFEI50R7mRSWVE9J5g4HRaO45yT/AX0i/Zfp/
         oWOjEZuBguhqNbfHJEFXaNd83rj9nBjsi42mDxk1fbCLJMCJhFyExZ3OYTamS4QNvzja
         UEeCMilL8Aw1eczqrc92rHE5abdDJw5vooUA8ZYdk+Rbn2CZmfwmJeMmESLJmUZDpiT1
         PMfw==
X-Gm-Message-State: AOJu0YwZzk8N9X7O3ZsbauNxRGhjihyOW0bYBzrJTnAofWRPWGWXMVxT
	nV1yoBvlBxuZWl3qfhQj0/eh0KeEDORhXAutnQl53sNOHAk5jcjI
X-Google-Smtp-Source: AGHT+IFEmuIf078GPYXs86/Ay81ah3BHyGb/3w+17Dbwx4ai2pl1RT54agf3n4Tyr4G1IsDtTW13zw==
X-Received: by 2002:a17:906:b7c8:b0:a4d:f0c3:a9e9 with SMTP id fy8-20020a170906b7c800b00a4df0c3a9e9mr1993911ejb.28.1711638204528;
        Thu, 28 Mar 2024 08:03:24 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-008.fbsv.net. [2a03:2880:30ff:8::face:b00c])
        by smtp.gmail.com with ESMTPSA id bg12-20020a170906a04c00b00a4a3580b215sm848467ejb.80.2024.03.28.08.03.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 08:03:24 -0700 (PDT)
Date: Thu, 28 Mar 2024 08:03:21 -0700
From: Breno Leitao <leitao@debian.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Alessandro Marcolini <alessandromarcolini99@gmail.com>,
	donald.hunter@redhat.com
Subject: Re: [PATCH net-next v1 1/3] doc: netlink: Change generated docs to
 limit TOC to depth 3
Message-ID: <ZgWGuQIiPxiQh2PA@gmail.com>
References: <20240326201311.13089-1-donald.hunter@gmail.com>
 <20240326201311.13089-2-donald.hunter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240326201311.13089-2-donald.hunter@gmail.com>

On Tue, Mar 26, 2024 at 08:13:09PM +0000, Donald Hunter wrote:
> The tables of contents in the generated Netlink docs include individual
> attribute definitions. This can make the contents exceedingly long and
> repeats a lot of what is on the rest of the pages. See for example:
> 
> https://docs.kernel.org/networking/netlink_spec/tc.html
> 
> Add a depth limit to the contents directive in generated .rst files to
> limit the contents depth to 3 levels. This reduces the contents to:
> 
>  - Family
>    - Summary
>    - Operations
>      - op-one
>      - op-two
>      - ...
>    - Definitions
>      - struct-one
>      - struct-two
>      - enum-one
>      - ...
>    - Attribute sets
>      - attrs-one
>      - attrs-two
>      - ...
> 
> Signed-off-by: Donald Hunter <donald.hunter@gmail.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

