Return-Path: <netdev+bounces-110804-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1472092E65C
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 13:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 464031C219E6
	for <lists+netdev@lfdr.de>; Thu, 11 Jul 2024 11:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD33816D9CD;
	Thu, 11 Jul 2024 11:16:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1299C16D9C2;
	Thu, 11 Jul 2024 11:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720696617; cv=none; b=EbG2ooox6yn3UCPcJvVV7N/IcxG3pMkfSgW+/HoOyX17N89KKhAdjvMCmVk/0WQpr5VePkm1MOmWfGTYFaHdyJ2tzfvEk2e9z430lcDw6G5dR6J34dRipLcSXxpdsScMqequpoFMz9eUXja0cQEyqEzUs53gZNV0wxtbjzkjKdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720696617; c=relaxed/simple;
	bh=3+Cu7JogFBF32s6Ive+/A0rhuCMFCdiT9lruAKuMaHg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oyozUQ5yeDNFTMpYbTFy+USf1UpeecbAgD7paxu3XPce1eVbyEFeLvvUv7CNFNBjs6uzpke2A7lkRKNrcelebkaCSev5+e4czz7R69/gqXTrQZIHskpVcse7GSpUY/IVWBT/m+z4w8tML2g47j4mttp6WhL32oH34HbzTFSIBnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a77c0b42a8fso280161266b.1;
        Thu, 11 Jul 2024 04:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720696614; x=1721301414;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/r51nS+g7lQoWT0HNbExECB6/rA+diGsBSoUeSas/gM=;
        b=WAd45BL3UcIVSPmMLcV0jkFPuwjkyBTJ471YIHfeczU67sgiGQKdePpph8TTCOK0l0
         Vs39Vv+rKS8y9m99ae+2duDafuYuA56l2nwi69mrNp2beZT6/yZq/npsiVCjfrOuxG4Z
         In9O1LESpXjOx4X5sh38KCeZKTeEK70et0HKCEFSHri6+3NroTikCnCKJ3AFaID+hRsw
         gB1Bm6Vxyx8B4nefqx+OZrpjthIfVJJ6vzonxHdzZd55RDSmXXU8glVY4eFZEnpFyQ0a
         dOsj2z60mGMKuFCZFBl6kA83sxrjTeej2BeZ1/ZL3jfdQgBhdpSE9t8WFk3Rbq4iaE18
         Ck+g==
X-Forwarded-Encrypted: i=1; AJvYcCV5ekHEphS5d9i0r5HoYAv7CD1CwiDRAIwvauYiYZzloYOLXdhxkc3YBIsio6RuWrdq6gZ2v5hUIEvkWJbD1gvmMVsyhSkwx9YUrCHM
X-Gm-Message-State: AOJu0YwjiChEelWPB2xAt4JgwS7atlkGkxPDwt+wTR2739B7fLnJamrX
	WKTaGuMFJ7ElJfggDta0NFsR5/BVXUaxXXqOvfy6GsoAoMU2fhm7
X-Google-Smtp-Source: AGHT+IE6LZHdbstxR+votJm7nuupUZbWEEQffPECqBfV2tlXDzop1gI1NS4S6fcacoV6R+qMyM4bdw==
X-Received: by 2002:a17:906:5806:b0:a6f:e699:a9f8 with SMTP id a640c23a62f3a-a798a2cc14amr156904966b.18.1720696614118;
        Thu, 11 Jul 2024 04:16:54 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-115.fbsv.net. [2a03:2880:30ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a797ddb28ccsm132052466b.147.2024.07.11.04.16.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jul 2024 04:16:53 -0700 (PDT)
Date: Thu, 11 Jul 2024 04:16:51 -0700
From: Breno Leitao <leitao@debian.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Madalin Bucur <madalin.bucur@nxp.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 1/5] net: dpaa: avoid on-stack arrays of NR_CPUS
 elements
Message-ID: <Zo+/I5Rw0hp5wGeQ@gmail.com>
References: <20240710230025.46487-1-vladimir.oltean@nxp.com>
 <20240710230025.46487-2-vladimir.oltean@nxp.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710230025.46487-2-vladimir.oltean@nxp.com>

Hello Vladimir,

On Thu, Jul 11, 2024 at 02:00:21AM +0300, Vladimir Oltean wrote:
> The dpaa-eth driver is written for PowerPC and Arm SoCs which have 1-24
> CPUs. It depends on CONFIG_NR_CPUS having a reasonably small value in
> Kconfig. Otherwise, there are 2 functions which allocate on-stack arrays
> of NR_CPUS elements, and these can quickly explode in size, leading to
> warnings such as:
> 
>   drivers/net/ethernet/freescale/dpaa/dpaa_eth.c:3280:12: warning:
>   stack frame size (16664) exceeds limit (2048) in 'dpaa_eth_probe' [-Wframe-larger-than]
> 
> The problem is twofold:
> - Reducing the array size to the boot-time num_possible_cpus() (rather
>   than the compile-time NR_CPUS) creates a variable-length array,
>   which should be avoided in the Linux kernel.
> - Using NR_CPUS as an array size makes the driver blow up in stack
>   consumption with generic, as opposed to hand-crafted, .config files.
> 
> A simple solution is to use dynamic allocation for num_possible_cpus()
> elements (aka a small number determined at runtime).
> 
> Link: https://lore.kernel.org/all/202406261920.l5pzM1rj-lkp@intel.com/
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
Reviewed-by: Breno Leitao <leitao@debian.org>

Thanks for working on it.

--breno

