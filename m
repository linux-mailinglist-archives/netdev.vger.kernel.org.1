Return-Path: <netdev+bounces-117987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A529502C9
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 12:46:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2B79286D0F
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 10:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A80197A61;
	Tue, 13 Aug 2024 10:46:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5511B368;
	Tue, 13 Aug 2024 10:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723545982; cv=none; b=CKIp5NFMv2p/L4Q7us/P4mi6NF9llm9QxNq39eSug9t8y6i0AUCHTcVKoU4dKjalX5Y1PA1e13SD/njFCobRl8cTOpekJR+3cLdYyeNMQzySqGbGulcdn6VJkBn54a/KbSHlqZp34coIeMlRQkoCBRz0ITe92v6+EoU9O2hw0PY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723545982; c=relaxed/simple;
	bh=/fjXahSEjF9ZhlV6L3LaHMKecBdvEBPMXHpQdm2U2cA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LBZrMCnh7CNooZotXuirRUPF53+EkwDJOnIaAdlvGTpiPOQNMfn+9MmSat3+i73TOFfKadjvz3d9Jq5IeG0hcrAheHl9S4ozDULuM66T36z5JeJy86IKCBuHM1n7wP4VDcjcWV6nGtw8txJLxIDkR/8ikUb/B45UXb+1OBAAJm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a77ec5d3b0dso581346266b.0;
        Tue, 13 Aug 2024 03:46:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723545979; x=1724150779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EaRqNknoiXIxBgYUXTCTJlYjmV6mokfwA1oMnDDM/HA=;
        b=niYtyPj+sTHt88R2K9tau2cy3xqKNsFZLanL+LRDknhe9iBU8i1Ew2HGaw9AOGieIW
         dDApjyObDOmCeuoFwQOTFttjYDcqrSZ1v2OeKEzmZk6DkO6OtDkTDHFmPF4RmO7C9eJa
         HIRa4BbIIPQsJypsYCDN0Ezq2ZBK/RrakROqYP8qVxHCXOan3gd1DbecwH92BxylWulo
         6TfhO1RJ2/Py3Zih5gkT9VP33STKJuSBx2/wkNGBA752Tr+ldb6f0G3aXipwG4tWv5bi
         AbOpXLv21+RcxxpjNRRXxjIjfFDFl8bHQwH8jkDgjq7NSHAk3kElhTSrOIRv8Zf8oiHv
         Q4+g==
X-Forwarded-Encrypted: i=1; AJvYcCXvp63pjBKRUAv1Lkb/DbLSMZzVO7kd5EMThqT6wNrARXE6So1kmNK03SNhlUgRkc00FrhY7roKkN995WjAQxokVTJOk/eTPSefBDRwcyFuth6/m454GLERtKfMXuCI0GUZBSFBQLBBnJf/ejPTP//Ri3Bd9ea28zU34WayL3fIreuikVAr
X-Gm-Message-State: AOJu0YzmHSWgHWbF5d8aezfgnENdNJ6DZoET71tdeJ8nAp6Hhnv0dcFe
	dUf7f/nr6INF85keMup9z0UcPCL5WKkZSlFyMqcd6cnEWFMKwqJ7vTlKfQ==
X-Google-Smtp-Source: AGHT+IHDTiyEw8hKE9wVP2vCQm1qA4pO92wamZ6Y1mgtvqkgOHxFimnP6vee5n3w6zJbOY3sUnEVUQ==
X-Received: by 2002:a17:906:db03:b0:a7a:a7b8:adb1 with SMTP id a640c23a62f3a-a80ed258a71mr203720766b.36.1723545978473;
        Tue, 13 Aug 2024 03:46:18 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-114.fbsv.net. [2a03:2880:30ff:72::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80f3f47b4asm59489166b.36.2024.08.13.03.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 03:46:17 -0700 (PDT)
Date: Tue, 13 Aug 2024 03:46:15 -0700
From: Breno Leitao <leitao@debian.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net: netconsole: Constify struct
 config_item_type
Message-ID: <Zrs5dyMWT5u8qXNV@gmail.com>
References: <9c205b2b4bdb09fc9e9d2cb2f2936ec053da1b1b.1723325900.git.christophe.jaillet@wanadoo.fr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9c205b2b4bdb09fc9e9d2cb2f2936ec053da1b1b.1723325900.git.christophe.jaillet@wanadoo.fr>

Hello Christophe,

On Sat, Aug 10, 2024 at 11:39:04PM +0200, Christophe JAILLET wrote:
> 'struct config_item_type' is not modified in this driver.
> 
> This structure is only used with config_group_init_type_name() which takes
> a const struct config_item_type* as a 3rd argument.
> 
> This also makes things consistent with 'netconsole_target_type' witch is
> already const.
> 
> Constifying this structure moves some data to a read-only section, so
> increase overall security, especially when the structure holds some
> function pointers.
> 
> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   33007	   3952	   1312	  38271	   957f	drivers/net/netconsole.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   33071	   3888	   1312	  38271	   957f	drivers/net/netconsole.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Reviewed-by: Breno Leitao <leitao@debian.org>

> Compile tested-only.

I've tested it using a selftime I am creating, and it is all good.

Thanks for the patch!
--breno

