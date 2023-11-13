Return-Path: <netdev+bounces-47404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E83767EA1ED
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 18:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 24C911C208CA
	for <lists+netdev@lfdr.de>; Mon, 13 Nov 2023 17:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD7F224D6;
	Mon, 13 Nov 2023 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="gzXuywB6"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A759224D3
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 17:34:32 +0000 (UTC)
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEBF10EC
	for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:34:31 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-28010522882so3954574a91.0
        for <netdev@vger.kernel.org>; Mon, 13 Nov 2023 09:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1699896871; x=1700501671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pE6fvYT+1obOtjWO9/BRfYWE7SohUEDX3W6dmYTnkAQ=;
        b=gzXuywB6vqls++UxPNviUMKefIi3CavuZjI4t0echSKNugTrzXRU+r66yIUIQATcy8
         mcmX1mGW30aXLCrdopBnzs3rcBa7R8i9q6xhA/Fw890AsvPDNQSaoo15abkAkLx3uUbV
         16YISzdKGaxlfZlxovu8tpSdAYR/MgOeku+ffCis61GYTAK3JAAsLZYyCtbP3EQASGKR
         fRTo86wLs6BxSvcFYNc77brrJb7WDLQz44uhVNwlO1Z25MrYBhFZQmETlWkvsb46xbLZ
         kjmgTC7WlEfpxnqHhX8qfoGGnPnPzciRX7GHU/FxWNOeBStKoMXcIdx+AtphRvhfRwtm
         ocRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699896871; x=1700501671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pE6fvYT+1obOtjWO9/BRfYWE7SohUEDX3W6dmYTnkAQ=;
        b=BSV7QOueTFjLbthupORlyQOMVcZUgWq//TiRDiog3E8HOL2WzbirB6djA/WAsg9KWn
         wSkJkfck1SfUgaIkiVdG6kolsuxCQbN5WXcCOp7rnVvPniLajTIrrUlqQKuBzwtmltxq
         VSSdGS2FqPAL5/7WIFvPASMTXpAnpHEkWX/6VVm4+DeKp8gVNmg4F2kQJ+X69HbRXBP5
         iBpUis6U9vaufd0F/V/oyrzdsVig2PbFaYnEDvJrR3gRbLbwzNonqL9H5nlz3tZTpGIJ
         Cm4PRGSlAkuceoovxi4IHgIfAXBJhOa4NWE9iU+QR9QniNER5pxAMEUdDvoddhwJ5MYu
         qU9g==
X-Gm-Message-State: AOJu0YzQpdbpZhORQJo8FynW201zmHl8VdQtuhCtbn05sKrQAldKSd2D
	vmKkg1tnKRwzbG3BV4NfPvWukK5wlZgbef9oYhA=
X-Google-Smtp-Source: AGHT+IFiKhNSiH2ShgZgNbKiGI9VU/PNLX+mtJxT66yEH8O65pRCNVd97uFFWL8XYc+l1vu1cdr/2A==
X-Received: by 2002:a17:90b:1b0a:b0:280:200c:2e20 with SMTP id nu10-20020a17090b1b0a00b00280200c2e20mr4898813pjb.27.1699896871019;
        Mon, 13 Nov 2023 09:34:31 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id 2-20020a17090a0d4200b002801ca4fad2sm6504540pju.10.2023.11.13.09.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 09:34:30 -0800 (PST)
Date: Mon, 13 Nov 2023 09:34:29 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: razor@blackwall.org, martin.lau@kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH iproute2] ip, link: Add support for netkit
Message-ID: <20231113093429.434186eb@hermes.local>
In-Reply-To: <20231113032323.14717-1-daniel@iogearbox.net>
References: <20231113032323.14717-1-daniel@iogearbox.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Nov 2023 04:23:23 +0100
Daniel Borkmann <daniel@iogearbox.net> wrote:

> +	if (tb[IFLA_NETKIT_POLICY]) {
> +		__u32 policy = rta_getattr_u32(tb[IFLA_NETKIT_POLICY]);
> +		const char *policy_str =
> +			policy == NETKIT_PASS ? "forward" :
> +			policy == NETKIT_DROP ? "blackhole" : "unknown";
> +

If you plan to add more modes in future, a table or helper would be good idea.

