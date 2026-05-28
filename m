Return-Path: <netdev+bounces-292796-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNTcH4eGGGq6kggAu9opvQ
	(envelope-from <netdev+bounces-292796-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:16:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2345F6294
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 20:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 04A7B3003351
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 18:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC6B40800B;
	Thu, 28 May 2026 18:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RyZNpRs+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0775E405C33
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 18:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779992196; cv=none; b=pWVYyZQxkZvQ7HVzSArYI0za90HqBALcuvnZm4sDKZGGupJRhneW4Jsu6mIxTfwj1wF4rdNydQEUdzKJAqRE7mjlUKYEufyLGUl1UmupwclP8s8jJSdbVvSUUnXm0sQmi96RkHUPhdrFqlg+idnOqECmSnuw9Zh1D2bTDngdlfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779992196; c=relaxed/simple;
	bh=Ds1Jip4Q+szH28JOmLE2MWPcuCX4YqkYawFCTzZTR90=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s5cpg5igKogWx8K4D17QadwHCiPJvnXT+z+kY9xF8sihtEhpIR/yxNek32oIbzQNBmhyjiRRh3Fxh0wEPvlFMagCMZCJ4ahqnSmMhtItqgQs55A9xl9OVImjmDbR16dqs2oHxZeWHmFgdj3u+Ga4t+gaQJSpOUIJ1U4EFZBp9UE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RyZNpRs+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2bccb978bd9so79496185ad.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 11:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779992194; x=1780596994; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=H98Vwp3bRkB0ayStNiyEfxNXiTSUpiEWRaZG/RbuOdc=;
        b=RyZNpRs+WU8aaHArotM1GhEH+4IG/W6JG/A180LYcb6mTAbHHfMA3yWAmrY+A2tCwJ
         hCaDauM5MjOTuOTGCKs0S+LnmxMyz73w/HFyeJIWiFBGq6owf2Ibf2s37PZw2q15/mXS
         6f77pnlux284O/7Id3CkJRFJpeeUeNb2UmM8c7arhefVic/AvOaOwKQ9ed537esl+aG4
         FYktz9N2sWlGqPOUNaO3T4IlEzWPJfu21Vvn1f7/T7T2nF54UnCmfcVNj953WncNb3MX
         jdeTrDcjKcPiXq/fbjjQ7vW7uf5M9eTU9HdmHeWRJx5Nfvn+Fh7aTrgghxa2b7/6A4Ga
         jhdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779992194; x=1780596994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H98Vwp3bRkB0ayStNiyEfxNXiTSUpiEWRaZG/RbuOdc=;
        b=LZMVXVVyaMPNHAoxsDZ5A9hgjN1xajmywJH6yUmwk/xkGQis8ULlMzoix565qm+Smb
         9e+tiSqIb+pW7GtK7F15xYA1h/+q4uva2emfVVDCU4XkcsodcmDxchUxV/ce4sqSnqAK
         uUshVTLtqvrpcJmsBu5dcsO6qWHl1l4eRKGutnyUWnnVId+luxA6czlkGMhURWxKEzqN
         q6H+iVx9bnkCBKVa2JAMPNdU4XXQcBW89rzl9FsoAxot+LkX3x4Eh8zZ2aOOcwRne4lS
         OINiAaIt4tUYtGgeYgT4G28FHoLFCWEIQKcdX7V7TYhntF8TtRtzsO4kgisnhddTETui
         seGQ==
X-Forwarded-Encrypted: i=1; AFNElJ90SS9ZoavZG1NZLX2kIjhzZ61a2DAxnnjD1ne7iHZsVfaeL0AH+njfTCWEXe7V+pACKe0pQms=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrVZMlKho8GVte+nvEUirnMg0ONpeSbqbWEfkpXCB6/3AOLkGP
	z8E3JCYjuHbA1QRTJloed3pMFjbM+82C+g2HABewEAXCabbhwyswvZcIUXYRUPabOnE7SB/nk0m
	rbGdFJA==
X-Gm-Gg: Acq92OF9kbKtjeHX9hxqC7xpVIDnMwqbETI71AVyV5su6LNv8IEBZjeoACYqvZlSnmv
	UXVegak3+J4+qeMVZKJX+5F1qr4POnwMPyEmN4gt0CJ3ZlL8Gf3maxdaoXW1VMBP47bxe/A971Q
	xEJq4/neKrO259Jqybt5MOkCZB7cjDhNPsIbTghTFDA6aRDg8RtT4/EcEzAontkazQz/pxxJrCS
	s1Nwt2etOLCuTwkoibYmmjxZuMbag1mQIp3UkVKW9RLbm2WlmcMtAyH5eu9majEo3fasNi7qkm4
	MeO8YCIg9UuPbbyoierB6N7YAqLZLe8fg08C2cWEL3Y+1CNtr0dtPaSaDaOiYUAftY9KSGXk3Fy
	qTmPSn4fbMEJuN1MgGj8GJ7fO2EKzEv7JNlpEOypftl+h6GvbM0PR8rDw+Abympfnlwk1haJ+lT
	xIoHHeeCeBGZas+H5km0fMWxOK3wu8/jkOi+8z2IQw0WieIpM9iOeHB5V/WA9VIr0DMzwn1nkL
X-Received: by 2002:a17:902:db05:b0:2bf:1845:baf5 with SMTP id d9443c01a7336-2bf1845bde2mr12584885ad.12.1779992193939;
        Thu, 28 May 2026 11:16:33 -0700 (PDT)
Received: from google.com (56.149.168.34.bc.googleusercontent.com. [34.168.149.56])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb58dde4fsm198930285ad.67.2026.05.28.11.16.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:16:33 -0700 (PDT)
Date: Thu, 28 May 2026 18:16:30 +0000
From: David Matlack <dmatlack@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
	Leon Romanovsky <leon@kernel.org>, linux-kselftest@vger.kernel.org,
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>,
	Shuah Khan <shuah@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	patches@lists.linux.dev
Subject: Re: [PATCH v2 05/11] selftests: Add additional kernel functions to
 tools/include/
Message-ID: <ahiGflOWOOk0U_b4@google.com>
References: <0-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
 <5-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5-v2-72e9640932fd+2c64-mlx5st_jgg@nvidia.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292796-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dmatlack@google.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2F2345F6294
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2026-05-15 02:30 PM, Jason Gunthorpe wrote:
> These are needed by the VFIO mlx5 selftest in the following patches,
> which includes some headers from mlx5 and also needs a few more
> MMIO-related features.
> 
> - DECLARE_FLEX_ARRAY in new tools/include/linux/stddef.h (wraps
>   existing __DECLARE_FLEX_ARRAY from uapi/linux/stddef.h)
> 
> - dma_wmb/dma_rmb barriers: x86 uses compiler barrier
>   (DMA-coherent), arm64 uses dmb oshst/oshld (outer-shareable for
>   device visibility), generic fallback uses wmb/rmb
> 
> - ioread32be/iowrite32be in tools/include/asm-generic/io.h for
>   big-endian MMIO register access
> 
> Assisted-by: Claude:claude-opus-4.6
> Signed-off-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: David Matlack <dmatlack@google.com>

