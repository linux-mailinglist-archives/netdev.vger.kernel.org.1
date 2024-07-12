Return-Path: <netdev+bounces-111075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 542FE92FBDC
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:53:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08635282F99
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 13:53:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6566417166A;
	Fri, 12 Jul 2024 13:53:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995DB171646;
	Fri, 12 Jul 2024 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720792387; cv=none; b=FYf9bTjkWPDgeCYZYDxh0U7YjyvWNqCKQIqg17/yQ/g4S6yoYl0oi/6vI0qEp5g3gHupQYgzmDehZjBjGWHVjdnsYR2rFmzOPL090SammkMBaVJfd7W0LjD6Z3K06tWSgTsMLOc0npKrdTSG20ZmaFOxNpaQHcMIBSNQSN7tfZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720792387; c=relaxed/simple;
	bh=oUeQAOehsUA8Zz0Q9AJ49iAgQrXTGohjJhjj8d9Ejn4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ppUbRfWnYuq6R414jsn5Awi7qYS4Qpbk8wjp6/ZwS2Fz+QMoaxfuv7GUGDnZSp6+z8nRCRroMouhshkuPPZwMOS1QuiijwaIulFGNWdgrFpGLTvklZ2Z5S828ByPynZMbfvqUItxRPE7HheJtqDr1TMd4zfRk0CZfJTs/HLjCZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-58ef19aa6c4so2646040a12.2;
        Fri, 12 Jul 2024 06:53:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720792384; x=1721397184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7nM9ZZaS7zEh5VH7vpWzHeJauviA6kuXXb6GAmKaWqo=;
        b=ZiFbKMtpqwnWX2s27idqj335VmGy+0eWA+NfKDTpKUHaqU4NS+HtXYKLru6YJqk/dI
         X8a47WdJhKpl1LqrVW10aypTu61sya+PlSV+6lJqk0dctOMk9kb40TR+YzXn1UE2aNx4
         xHW0ev2h7wC2wqEJsMY6LGaqT0C8HXvrpuDuVb/Ik2Wtg3Nan85wQ4ZqxM/dAoMRNOZO
         FhJVuCt5pxJ6K+vRex5/3+S8IzzbASYKoGSWEgPFvP57V2FOqLP2O19nN7Bqkw51hWuZ
         UPI8Oz8djBvUTJfHzQIbJNpcgubxlJ+eBck1IU7FvI7z2RDA/U5JINNX56hSmhnMKQM1
         5Q3A==
X-Forwarded-Encrypted: i=1; AJvYcCVvpH7jZsxcF3iB+dD6c9t+4Y30j5/YheW60bFdyPca8j+NFAZ+/wtqXggpdUjqA97OArBbk9YbTOIobD2BFZAIrcCRk4cMiqJn0YET
X-Gm-Message-State: AOJu0YwX6Csp7ma7PrCcn4x1+kMMcKVTkb7UvsEYu+ZxyG8dPDapDpIe
	g6I1W41QzrYN+LVVt/hc2J1HKj3tKccKtxj1Ie9ZUd/k2v7NFIMefxsufA==
X-Google-Smtp-Source: AGHT+IHbRkYceFQ+y9i5wL92DTMDBFZU43kjo/0dzAA2E7wBDXKD7X1+A3oUtgIcQKPoDAnsgKaHbA==
X-Received: by 2002:a17:906:b319:b0:a72:676a:7d7b with SMTP id a640c23a62f3a-a780b688906mr933166466b.9.1720792383756;
        Fri, 12 Jul 2024 06:53:03 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-006.fbsv.net. [2a03:2880:30ff:6::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6bcc52sm343007166b.4.2024.07.12.06.53.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jul 2024 06:53:03 -0700 (PDT)
Date: Fri, 12 Jul 2024 06:52:38 -0700
From: Breno Leitao <leitao@debian.org>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Madalin Bucur <madalin.bucur@nxp.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net-next 5/5] soc: fsl: qbman: FSL_DPAA depends on
 COMPILE_TEST
Message-ID: <ZpE1Jn5ZbQikAHmI@gmail.com>
References: <20240710230025.46487-1-vladimir.oltean@nxp.com>
 <20240710230025.46487-6-vladimir.oltean@nxp.com>
 <20240712121400.bnjcexqpqgjhlmuc@skbuf>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240712121400.bnjcexqpqgjhlmuc@skbuf>

On Fri, Jul 12, 2024 at 03:14:00PM +0300, Vladimir Oltean wrote:
> On Thu, Jul 11, 2024 at 02:00:25AM +0300, Vladimir Oltean wrote:
> > From: Breno Leitao <leitao@debian.org>
> > 
> > As most of the drivers that depend on ARCH_LAYERSCAPE, make FSL_DPAA
> > depend on COMPILE_TEST for compilation and testing.
> > 
> > 	# grep -r depends.\*ARCH_LAYERSCAPE.\*COMPILE_TEST | wc -l
> > 	29
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> > ---
> 
> I don't know why nipa says there are 800+ new warnings/errors introduced
> by this patch, but it looks like a false positive (or I can't seem to
> find something relevant).

Right, All of the warnings are basically a set of MODULES_DESCRIPTION()
that are missing in other parts of the kernel, and not related to this
patch series. None of them seems to be in the network stack. (for
context, I've fixed all the missing MODULES_DESCRIPTION in the past).

nipa also complained about an unused variable, and we have a patch for
it already:

https://lore.kernel.org/all/20240712134817.913756-1-leitao@debian.org/

