Return-Path: <netdev+bounces-132813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 222D2993478
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 19:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ACCA1C2260D
	for <lists+netdev@lfdr.de>; Mon,  7 Oct 2024 17:09:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1AF1DCB10;
	Mon,  7 Oct 2024 17:09:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A42E1DCB0A;
	Mon,  7 Oct 2024 17:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728320975; cv=none; b=hoBkDN8aoAFADRuv9jSx4EsLcpJcA4PGBFPpXxsAPfRPwwXZmWLZpFmZkwXgFa/luUKYgHWZZRqCutk+6cL0iDEFxAy8y7akSRPvnx76CVNrquFqkxa1yk6iPkmUmT/0o7i5cktuHAHoWyhHn13fqskp/oPnU7sHa6oi8akoLy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728320975; c=relaxed/simple;
	bh=icNVlLzTCqAZ1hLnxOTXJhScS09pcofSsGvrCvZ1Sb8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O5YYKhwDv1iH4Dtplyx727S9COWbXdBK7RoPip9zq/yjWaR5Nw6NlZ2HpOq40x0pPetZHqTTSjXMPlFIRxKKvuFLU5a18qpnwpglRqlEBbfSWDhnaCPW6i8q2s94LHPosUBkKXwJGO+e59VfCNFxApSwl3tFDi2E8TG5PiyyAZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5c88e6926e5so5489921a12.3;
        Mon, 07 Oct 2024 10:09:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728320972; x=1728925772;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzQJu2S+cF08b3R0TD9yNtu8OgKssIiP0a9XzvPgjqI=;
        b=NMPwxFGuWMRRJ90TzWRv6nnq777BUBbXDw//SyQrP3ERUoTzSD5b0DlF7N7/7ywWGZ
         lEd0SR27lKUbGLB+9Q7zAiZF8BLsg8f6T4EJRcOzCUFhafT3YqjZsCAaLXJ1N/gDP/pq
         U2Qelm0dgwIw1QfFM1rm8ll3yIhu6jISLwr/P8uqVBIMAxNnOc13ptjqnW6XVcM3eROt
         zYQd1bWrzj/L3w/PZVH1C7IprVkO2ItkFJx5UYEZSkqv8J3XdAtnBpVHFcEJAyDFKPuO
         S4LIvmAHEaoRs71ReH1bp4GAD/4SRsNbWUcDX+1/9qYyeK3d/CHGrNNSIf9gyRPTxdHi
         SBqA==
X-Forwarded-Encrypted: i=1; AJvYcCUmcEP6EtHaHwzWyi5kc6ek0Ist8iLRDg0guCuZrdkGB3msI6nr74eg+W5PmF2FaqEsM8mZaEdgL9Vd1svO@vger.kernel.org, AJvYcCWUG9XBofu7uidrw2m6bbdVzvO/GIP0ZziB8RwBfwKqpuH5k0AL8lgQPDGJ2QAn5hJblClkE6h9MP8=@vger.kernel.org, AJvYcCX6GMJx7t9il7nhHiPG8hWdX+2fd6w0I1mhyakfpYbjFvonikapI8tZmIsxCpO01RY8wIh9zNfl@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8t//XDNnK2Q4Sm/gYwblq/DGgDClkZuY4FOZ/HGfz9sC9I8wE
	ftxyyP19xqqaJxUy2daOFdhZ9V2jAX9NscSOz9l0ieVOOnlsm+UX
X-Google-Smtp-Source: AGHT+IEwwJlSpT58wKvS5BI3ETf6Hj0RGN8LQtRHHAOFmRIj/CrZYtj5Fkr+MLYxnOCiJybcqp5T2A==
X-Received: by 2002:a05:6402:2792:b0:5c8:9f44:a24d with SMTP id 4fb4d7f45d1cf-5c8d2e14e98mr6968692a12.9.1728320971502;
        Mon, 07 Oct 2024 10:09:31 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-001.fbsv.net. [2a03:2880:30ff:1::face:b00c])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c8e05f3c8csm3540583a12.83.2024.10.07.10.09.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 10:09:30 -0700 (PDT)
Date: Mon, 7 Oct 2024 10:09:27 -0700
From: Breno Leitao <leitao@debian.org>
To: Pavel Begunkov <asml.silence@gmail.com>
Cc: Akinobu Mita <akinobu.mita@gmail.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	Jonathan Corbet <corbet@lwn.net>, horms@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Mina Almasry <almasrymina@google.com>,
	Willem de Bruijn <willemb@google.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	"open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Subject: Re: [PATCH net-next] net: Implement fault injection forcing skb
 reallocation
Message-ID: <20241007-phenomenal-literate-hog-619ad0@leitao>
References: <20241002113316.2527669-1-leitao@debian.org>
 <CAC5umyjkmkY4111CG_ODK6s=rcxT_HHAQisOiwRp5de0KJkzBA@mail.gmail.com>
 <20241007-flat-steel-cuscus-9bffda@leitao>
 <9386a9fc-a8b5-41fc-9f92-f621e56a918d@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9386a9fc-a8b5-41fc-9f92-f621e56a918d@gmail.com>

Hello Pavel,

On Mon, Oct 07, 2024 at 05:48:39PM +0100, Pavel Begunkov wrote:
> On 10/7/24 17:20, Breno Leitao wrote:
> > On Sat, Oct 05, 2024 at 01:38:59PM +0900, Akinobu Mita wrote:
> > > 2024年10月2日(水) 20:37 Breno Leitao <leitao@debian.org>:
> > > > 
> > > > Introduce a fault injection mechanism to force skb reallocation. The
> > > > primary goal is to catch bugs related to pointer invalidation after
> > > > potential skb reallocation.
> > > > 
> > > > The fault injection mechanism aims to identify scenarios where callers
> > > > retain pointers to various headers in the skb but fail to reload these
> > > > pointers after calling a function that may reallocate the data. This
> > > > type of bug can lead to memory corruption or crashes if the old,
> > > > now-invalid pointers are used.
> > > > 
> > > > By forcing reallocation through fault injection, we can stress-test code
> > > > paths and ensure proper pointer management after potential skb
> > > > reallocations.
> > > > 
> > > > Add a hook for fault injection in the following functions:
> > > > 
> > > >   * pskb_trim_rcsum()
> > > >   * pskb_may_pull_reason()
> > > >   * pskb_trim()
> > > > 
> > > > As the other fault injection mechanism, protect it under a debug Kconfig
> > > > called CONFIG_FAIL_SKB_FORCE_REALLOC.
> > > > 
> > > > This patch was *heavily* inspired by Jakub's proposal from:
> > > > https://lore.kernel.org/all/20240719174140.47a868e6@kernel.org/
> > > > 
> > > > CC: Akinobu Mita <akinobu.mita@gmail.com>
> > > > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > > > Signed-off-by: Breno Leitao <leitao@debian.org>
> > > 
> > > This new addition seems sensible.  It might be more useful to have a filter
> > > that allows you to specify things like protocol family.
> > 
> > I think it might make more sense to be network interface specific. For
> > instance, only fault inject in interface `ethx`.
> 
> Wasn't there some error injection infra that allows to optionally
> run bpf? That would cover the filtering problem. ALLOW_ERROR_INJECTION,
> maybe?

Isn't ALLOW_ERROR_INJECTION focused on specifying which function could
be faulted? I.e, you can mark that function as prone for fail injection?

In my the case I have in mind, I want to pass the interface that it
would have the error injected. For instance, only inject errors in
interface eth1. In this case, I am not sure ALLOW_ERROR_INJECTION will
help.

Thanks
--breno

