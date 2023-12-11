Return-Path: <netdev+bounces-55870-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA3DC80C97B
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 13:20:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79D5DB20C17
	for <lists+netdev@lfdr.de>; Mon, 11 Dec 2023 12:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2368C3B18F;
	Mon, 11 Dec 2023 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEEqCEQd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45B61F1
	for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 04:20:23 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6cea1522303so2647739b3a.1
        for <netdev@vger.kernel.org>; Mon, 11 Dec 2023 04:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702297222; x=1702902022; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vHNc2iZRlEJ/g06n4SjPSJU8dGxpln3/T5FnwmRNBng=;
        b=iEEqCEQdwZsyplKix45pf/R+rTEjiqf4oU0sd4R1OrPt5PoNEubf2HXDlA0Xd/u9RY
         PMrasAKTidChifo18exrZx/lEIBUPg5HeQRH8wYADwgXlkHhzk9+u+6mIx9INr4mz2n0
         zug94OY0ym53PCOXPyjZtAPx56+WTaoUETdzPSRIiz9j5HE0qDszUVbC5MSHHfKcdgxN
         raZOSkgRPt6uXDuyZp9gI9F+1kdkMZGW7OE3sapbyHNy0Q2rOMvJsKDg6gS6GGDUwfB/
         Wsud54u9S4FQh/wKB5MCAJMCBA0W8F6e4ifJ2xwlKwbZs7SvzRj7gu/LDvJd3/wtNhq3
         +kKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702297222; x=1702902022;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHNc2iZRlEJ/g06n4SjPSJU8dGxpln3/T5FnwmRNBng=;
        b=A4C+M1FKftl7zMGeZFIBjQ03YJ0C5zFnG8EfIxbZjEomTAKSFWPzD7ufX3+mYFMRxK
         R0Dvoansunpn+m0b/gN4M63qxoRSU3y+3zw055hRDxoB/sMTNQn7m1zvXHY0gcm2hJ0X
         IN39hjzr57XwNj/hMLKYr4FPzSYx0x4bczT41cRFIuGlFnxqtXd6YbVmLXI3ONYjXUFv
         R2OQeO69W15CEm8aIzDNYch8xfxDHEtgjdrORuI7VM7Ky/DMdDk92pwcCDteftz49UO/
         Fu6gsauopLPBvKJOQC30OhNKCua6XJAQepe7UKQnO42SauH4N9/X30ZiyW8c2d2CFE/8
         LFiQ==
X-Gm-Message-State: AOJu0YxTS/nBj2aUN19b7tRIQBM0JFK9bBfodMJy8ic9LH9viUJAaM4K
	peuJrDfS/izmQEgtqDd3vd4=
X-Google-Smtp-Source: AGHT+IHDDnDuhytKPqmRZYK9u+TGoPLU3H6E0QcxKDEiUTjmLl5CyKvnSi7DxMo4A3FEwKlMOfOtbQ==
X-Received: by 2002:a05:6a00:6004:b0:6ce:f65b:a6ef with SMTP id fo4-20020a056a00600400b006cef65ba6efmr1004974pfb.12.1702297222176;
        Mon, 11 Dec 2023 04:20:22 -0800 (PST)
Received: from swarup-virtual-machine ([171.76.80.2])
        by smtp.gmail.com with ESMTPSA id b8-20020aa78108000000b006ce7bd009c0sm6342198pfi.149.2023.12.11.04.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 04:20:21 -0800 (PST)
Date: Mon, 11 Dec 2023 17:50:13 +0530
From: swarup <swarupkotikalapudi@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [PATCH net-next v6] netlink: specs: devlink: add some(not all)
 missing attributes in devlink.yaml
Message-ID: <ZXb+fRawVUgU+lrX@swarup-virtual-machine>
References: <20231208182515.1206616-1-swarupkotikalapudi@gmail.com>
 <ZXbaauFOfttLCe78@nanopsycho>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXbaauFOfttLCe78@nanopsycho>

esOn Mon, Dec 11, 2023 at 10:46:18AM +0100, Jiri Pirko wrote:
> Fri, Dec 08, 2023 at 07:25:15PM CET, swarupkotikalapudi@gmail.com wrote:
> >Add some missing(not all) attributes in devlink.yaml.
> >
> >Signed-off-by: Swarup Laxman Kotiaklapudi <swarupkotikalapudi@gmail.com>
> >Suggested-by: Jiri Pirko <jiri@resnulli.us>
> >---
> >V6:
> >  - Fix review comments
> 
> Would be nice to list what changes you actually did.
> 
> Nevertheless, patch looks fine to me.
> 
> Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Hi Jiri,

Do you mean in the commit message, i should have listed all the changes?
Please clarify, if required i update the commit message.

Thanks,
Swarup

