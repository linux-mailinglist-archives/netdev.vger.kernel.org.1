Return-Path: <netdev+bounces-60733-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 89B7082151A
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 20:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D0691F21369
	for <lists+netdev@lfdr.de>; Mon,  1 Jan 2024 19:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A027CD520;
	Mon,  1 Jan 2024 19:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="WFL+QIHL"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EF6D527
	for <netdev@vger.kernel.org>; Mon,  1 Jan 2024 19:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=networkplumber.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=networkplumber.org
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ce9555d42eso560187a12.2
        for <netdev@vger.kernel.org>; Mon, 01 Jan 2024 11:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1704135830; x=1704740630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJqxlAiuzHGe2ywtSYvGmT0HYV996BDeMfS3Sqsltlo=;
        b=WFL+QIHLM525ar/okUmWnbWUZQJHfeCNjz3AMFwt0OWCTaAR4Wsjb/FQPAaj8oPpkR
         Cih42Rn1OEc0Gzi55spcUO4PS7tc4cxb+nPzQOzOjS5l2ERncswxaOVzdQYH53B9jx6w
         UPKrkLlFEmmN9klHCFwqt1Rdv/+O/FBVs6YSQtH5LWUNtu3gxfb42Nm3/wjW7zCM1xUb
         RYs0c4aPm3/N+ykqgOxtzxES1fBrOSG7CjmipkWNnEiTJVFGjHyYCR8atb0kxVN5TYtd
         a+aYMP4TxW3YvNG5JUMVTuz2ias4aVIIIH5wXJcni9IKMDGibaMntHsFNtrtMA9Cm9H5
         UbcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704135830; x=1704740630;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJqxlAiuzHGe2ywtSYvGmT0HYV996BDeMfS3Sqsltlo=;
        b=YWg1WA2St0Xpqs2YsPAstmeSABYeKn9/DvAbYznZIT2McxMz5aE+lpURbOw4yTc71C
         njveXuSJ4SyF5kj/eRnYuYIU1DAFO/NvYBAyH0nk/aoegl4wUEhFO939gtBS7acwOaJf
         lmiwTSX1B743FMGIa7zcFN1s41NQk3GetvD7p7sC1Mphc5SpPfdBCJdmH7L82wT0zsei
         NW2Fa3w5Yrwt5SfhqxKeAoBZIqG7jXsB/Gl7tAcz5CPXpaHs/R2b5R0+RTFQ/8p7mqZJ
         fl+qf6wUFy01gQt3gmzeDvU4kF9ezag+Dk9LnQD+hzKe1sNNcSzj1lQW3JZGeUjIZShn
         pXxw==
X-Gm-Message-State: AOJu0Ywjnh3PYRJQJ9c6Jw0JYhw2DQzrB2nUCotK5TYSW6oCKsgoCrQz
	gNwrgRCBr2Yq/CSXFuy1wJ688ad7CNOUzg==
X-Google-Smtp-Source: AGHT+IENA1fgThLPTpK34U66PLer87pLqqTMxHbAmMd1SpTbmSkmIE5M8PoRYFJXOG7WHH7M81jHvA==
X-Received: by 2002:a17:903:120a:b0:1d4:85a8:12a2 with SMTP id l10-20020a170903120a00b001d485a812a2mr11084103plh.54.1704135830394;
        Mon, 01 Jan 2024 11:03:50 -0800 (PST)
Received: from hermes.local (204-195-123-141.wavecable.com. [204.195.123.141])
        by smtp.gmail.com with ESMTPSA id p10-20020a170902b08a00b001d403969b65sm20341100plr.187.2024.01.01.11.03.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jan 2024 11:03:50 -0800 (PST)
Date: Mon, 1 Jan 2024 11:03:48 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Eli Schwartz <eschwartz93@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH 2/2] configure: use the portable printf to suppress
 newlines in messages
Message-ID: <20240101110348.482a679d@hermes.local>
In-Reply-To: <20231229060013.2375774-2-eschwartz93@gmail.com>
References: <20231227164645.765f7891@hermes.local>
	<20231229060013.2375774-1-eschwartz93@gmail.com>
	<20231229060013.2375774-2-eschwartz93@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 Dec 2023 01:00:10 -0500
Eli Schwartz <eschwartz93@gmail.com> wrote:

> Per https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
> the "echo" utility is un-recommended and its behavior is non-portable
> and unpredictable. It *should* be marked as obsolescent, but was not,
> due solely "because of its extremely widespread use in historical
> applications".
> 
> POSIX doesn't require the -n option, and although its behavior is
> reliable in `#!/bin/bash` scripts, this configure script uses
> `#!/bin/sh` and cannot rely on echo -n.
> 
> The use of printf even without newline suppression or backslash
> character sequences is nicer for consistency, since there are a variety
> of ways it can go wrong with echo including "echoing the value of a
> shell or environment variable".
> 
> See: https://pubs.opengroup.org/onlinepubs/9699919799/utilities/echo.html
> See: https://cfajohnson.com/shell/cus-faq.html#Q0b
> Signed-off-by: Eli Schwartz <eschwartz93@gmail.com>

This part is not necessary. Although echo is not portable, it is used
many places and not worth changing.

