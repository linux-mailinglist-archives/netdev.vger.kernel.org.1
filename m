Return-Path: <netdev+bounces-292268-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJIINK7iFmpIvAcAu9opvQ
	(envelope-from <netdev+bounces-292268-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:25:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 305425E4220
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 14:25:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0AAC8305E1B9
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D2A88F7D;
	Wed, 27 May 2026 12:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="eextby6a"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B313D16E5
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 12:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779884082; cv=none; b=YnbmiE8AECVNkdsOeh9tQrul9Ty89QiZGDFCEAcYb4FE0t1ibihgPds/lt+fZHTU7eQGVIGAATmpp0k6IXvU9WdZ+XNliSnxH9kXzPVWACCik/Xjqmju6Qv3Ptlt4f70jDkqlmLSlQ7+ygWZ3Ut7TPeHgDNMOUkMRz/CwExpLyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779884082; c=relaxed/simple;
	bh=r4H4etJpbxgvnWsKcOTGgVwJdweQQvXvLKk8S0w3cbs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nMjZ5a5S7dXFKI5gMJog0NTdiYb2Bn1dheTxIFuT9vWs5QDekxK6AjL/CQ7GZBEVlsSDKEmVGW4zzgygYizurkjbfIfnV60xE3cLYqB2TR8zSdm3WWJXoCNufyoxLJmBPYHwJcXgUrwfi0Mah63cAouUG4SGlLNkqp9PL0pNH7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=eextby6a; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5165195c8b0so127289601cf.0
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 05:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1779884080; x=1780488880; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zjybRMBUQubASldC260OK8MJUJyjzZlOHF/HoeFPi84=;
        b=eextby6ajjRyi73ugcPsaBcUGRyCiEHcrXw76GIcT6DqzMhVcYWiRuYzmmZymJL5kt
         1+DVEbLNgptJKvePXRcfFXDqxThs0EKdBV41MXXGetuT7WYVSf45tsGExGzxd4+PNyeS
         s8CySgQpiGAy0BBvKWE/+8RwhL9Z1kUH5hiNlwkf6FlLfSuzb5uITtJ1ePhC9r2icohc
         gQsQUs2pPEES+kZcFIQfejPDIqTq8H88nH7TpLJXKZz2RHRjxIt+0BsubVGcN5Uc7vzo
         Kk5EjfwzrO+iar6IR8Czp78sN4qOO6nQW0KvinjW+4mtCSbvarN4nojzvZtvidIWxt5w
         KlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779884080; x=1780488880;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjybRMBUQubASldC260OK8MJUJyjzZlOHF/HoeFPi84=;
        b=eAbR3u2zkSszBs2z2YF9VeswyHK/MRsF16DZ6wswdJdvCfl7L02N2IDwM2YqRGTnVg
         g1gVlCsU29zXl4ykJ/UdITTT3382j7nspXArlloWF+T5ASc+RmdaRZF8ooQxJkNzJJHt
         xxT7PiXu82hnBmY2LCBEMDlVW+D1C7j17j8TJniNwRMiMlkr7Cjpk+8Nf30Br2BYJhi2
         ll8o9QJJsXNnLOljmkG4gWa1KpNjySIm4oNxogb2TXk7tNSobCnIlTAYyqbzw/CZTapx
         UH6tDQvUqWOwG91/phkRiZ0Re4hoGcyYGMCiQ36PhuJ9w6cVSKZI/LWRef7RAoJxYgWZ
         AlyQ==
X-Forwarded-Encrypted: i=1; AFNElJ+ni1653aS2tbK+AL5MgttWWfz+us4IOK7O370hstbqReuVMRfP06OTWaz0vLjTmv0zq2kpStU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAdQA7N/hLcXPmztHmU9DF/2wcRFx5At9yOisO9oln7UsqASpO
	sAu9I3qjXPjOpyIVZnHL8EVa9MJCy4mhw5ycegHm/1QRppkSvhne8+WQ3XnaFTf3qd4=
X-Gm-Gg: Acq92OHcg/05hTmks+20ItP94bznIi8zm6bfb7TNZbP4m7i7/HPCfDFVZvnx1w0uPxP
	yjpO7OhSaWEIKEuZaZWhvHB7HHs4BDyDbLClfZSKRuMvfdmDMXreyasyZgE0Nef7AP+h8hfqAuu
	4Xw4prlIFyGwzVyycy1XvST+HFLCN3lpmVuLwqOvJdNJjrjCJrY1qqLmADuWZy3q9X6ThBajMy5
	N7U2UH+EVT1XCcXpnsdLyaCneFj2f0YI+A/G2RuhKokpRvN80rdg+2WJy8kV/QQXAJcES4nti19
	KWt/pCAawyZE9RMqn4uPDLbuADCGKSmGMlKX89iUurhmvxdPHz0Jy9+23Wi/+5VjLNUN1kmsRCh
	M19V3mlUDDHoa3Vhh6xOMyZ15cFCsOBxEeLLMiSktWiYJJtIIgoCSn33ZCXWc+nPsRxcvS329W7
	sOCg2YJiZp6LiA/563pXC4IzBvgMuVpHNHW6pX20GM0xCI1PU84HeFnJD0jg6hVMFKkNeffLTjx
	oouFi4k770a8ULX
X-Received: by 2002:ac8:58d4:0:b0:516:d2cc:5160 with SMTP id d75a77b69052e-516d459212fmr302395201cf.32.1779884079723;
        Wed, 27 May 2026 05:14:39 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51706adc446sm39991901cf.15.2026.05.27.05.14.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 05:14:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wSD9i-0000000ENnz-0tj0;
	Wed, 27 May 2026 09:14:38 -0300
Date: Wed, 27 May 2026 09:14:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>
Cc: Zhiping Zhang <zhipingz@meta.com>, Alex Williamson <alex@shazbot.org>,
	Leon Romanovsky <leon@kernel.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Bjorn Helgaas <helgaas@kernel.org>, kvm@vger.kernel.org,
	linux-rdma@vger.kernel.org, linux-pci@vger.kernel.org,
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
	Keith Busch <kbusch@kernel.org>, Yochai Cohen <yochai@nvidia.com>,
	Yishai Hadas <yishaih@nvidia.com>
Subject: Re: [PATCH v5 0/4] vfio/dma-buf: add TPH support for peer-to-peer
 access
Message-ID: <20260527121438.GJ2487554@ziepe.ca>
References: <20260526144401.1485788-1-zhipingz@meta.com>
 <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a8cd01ab-d7aa-465d-bfa3-431f78f33ee1@amd.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292268-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ziepe.ca:mid,ziepe.ca:dkim,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 305425E4220
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 27, 2026 at 08:55:49AM +0200, Christian König wrote:
> On 5/26/26 16:43, Zhiping Zhang wrote:
> > This series adds TLP Processing Hints (TPH) support to the VFIO dma-buf
> > export path, allowing importing drivers (e.g. mlx5) to use the
> > exporter's steering tag when performing peer-to-peer DMA into a
> > VFIO-owned device.
> 
> I'm not an expert for TPH, but that sounds very strange to me.
> 
> As far as I know the TLP Processing Hints allow devices to give a
> steering tag to the root complex together with memory accesses to
> give fine grained control about cache usage. In other words it is an
> extension to the classic snoop bit.

TPHS includes an bit of data on every TLP and the data transits to the
eventual completer.

It does not have to be a root port.
 
> For P2P that is obviously nonsense because we don't have P2P support
> for cached accesses.

For P2P the TPH data on the TLP will transit to the P2P completer
unchanged.

It is up to the completer do define what it does with the TPH data.

Typically root ports in CPUs will use TPH data for cache placement
instructions. But who knows what a P2P device will use it for.

In Linux the driver that owns the completing address space gets to
specify how the TPH data works based on its own device specific
knowledge.

Jason

