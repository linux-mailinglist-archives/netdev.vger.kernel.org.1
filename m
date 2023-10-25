Return-Path: <netdev+bounces-44091-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A5C7D6161
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 08:00:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA88D1C20DDA
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 05:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A1E314288;
	Wed, 25 Oct 2023 05:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zkhabfxq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FB011732
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 05:59:57 +0000 (UTC)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E718910E4
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:59:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-99de884ad25so786084466b.3
        for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 22:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698213587; x=1698818387; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BOWSMzIuC7GUZMUwYGj3DIblX0gA9OO3MK529W4bM7I=;
        b=zkhabfxqMe4f9wCIah5YfoUuPMpClUmH52dVn6M/cbMq4X+Hz5hVwdn+xp1UG1au73
         XBoyywA3l64m/PY+JXrOKPDMHRuuBQvpFyF/z63BO7L9VZZeD9P2szc0UHgAWmpwRnr7
         RO+8Qd4paspknxUng4alKYUXuUEHAi9TcJpvAcaGuaowEYeJRDD/i39nus9/J9e6+O0Y
         cSzh5YEv3xBkE8tXygcbs5wKBb5O1GvwumseXbn1ZQTYYBiWfuAvC6EUp3pAQPc7UGX9
         99aUCGgCVzZgOFh5XJf+s4Gt2/UMTVN4k8wJDCjxhgtfAuSQtckihD2YfIkJX/wm4B9o
         pfUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698213587; x=1698818387;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BOWSMzIuC7GUZMUwYGj3DIblX0gA9OO3MK529W4bM7I=;
        b=WvExgJYK8SudYnez/4BMPtUDE3JvOgfm9Vqo2qfwdC3W7waHQ8n8h7YGbw0hRWzx14
         g71YCJCBIocpNLTh3MCenDhsEYAHztZ6AKxKQiJ6K+Szj9MWU/vl9S0hdEr1cK1Ss8ci
         gIh6qZxwq6taT0olzaYYb96SZNJIF/Ui8AxaXSkhyPdBrg8e0l4COy45ZIKKCZSjBkXV
         Q/ZG8y5l+TuxGlTONTGkOD7nv8wLNj/7KpkURzF25bDdNyPts6lcAhfNynLrZBPPueSy
         lUeBpCwV/sF7yRfgmKS0ytfHhKHUkSUeMTFcb0uIYoGMze+Bly2i63hkv+zHNtUJ2ooV
         FIaw==
X-Gm-Message-State: AOJu0YxFpVKhRdOnF0KJwEKBgCkylSzz2KZzD9YT1UJJdr23sHc0/DJx
	oUWf8AnWU189MyYEkHX5fJsCGA==
X-Google-Smtp-Source: AGHT+IH42o7TAQuoVRqfi/hNZc6KDJ53eY6IzDZr79PS2xrC1OmR7GqpXMIoRktxGuph/T7NIQMmPA==
X-Received: by 2002:a17:907:3d9f:b0:9c7:5a01:ffec with SMTP id he31-20020a1709073d9f00b009c75a01ffecmr10621767ejc.0.1698213587055;
        Tue, 24 Oct 2023 22:59:47 -0700 (PDT)
Received: from hera (ppp046103219117.access.hol.gr. [46.103.219.117])
        by smtp.gmail.com with ESMTPSA id m1-20020a170906580100b009ae3e6c342asm9329709ejq.111.2023.10.24.22.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 22:59:46 -0700 (PDT)
Date: Wed, 25 Oct 2023 08:59:44 +0300
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Sven Auhagen <sven.auhagen@voleatech.de>, netdev@vger.kernel.org,
	thomas.petazzoni@bootlin.com, hawk@kernel.org, lorenzo@kernel.org,
	Paulo.DaSilva@kyberna.com, mcroce@linux.microsoft.com
Subject: Re: [PATCH v2 1/2] net: page_pool: check page pool ethtool stats
Message-ID: <ZTiu0Itkhbb8OqS7@hera>
References: <abr3xq5eankrmzvyhjd5za6itfm5s7wpqwfy7lp3iuwsv33oi3@dx5eg6wmb2so>
 <20231002124650.7f01e1e6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002124650.7f01e1e6@kernel.org>

Hi Jakub,

On Mon, Oct 02, 2023 at 12:46:50PM -0700, Jakub Kicinski wrote:
> On Sun, 1 Oct 2023 13:41:15 +0200 Sven Auhagen wrote:
> > If the page_pool variable is null while passing it to
> > the page_pool_get_stats function we receive a kernel error.
> >
> > Check if the page_pool variable is at least valid.
>
> IMHO this seems insufficient, the driver still has to check if PP
> was instantiated when the strings are queried. My weak preference
> would be to stick to v1 and have the driver check all the conditions.
> But if nobody else feels this way, it's fine :)

I don't disagree, but OTOH it would be sane for the API not to crash if
something invalid is passed.  Maybe the best approach would be to keep the
driver checks, which are saner, but add the page pool code as well with a
printable error indicating a driver bug?

Thanks
/Ilias

