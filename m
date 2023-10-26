Return-Path: <netdev+bounces-44523-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 947417D86A7
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 18:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F71EB20FF2
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 16:24:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5045E381A0;
	Thu, 26 Oct 2023 16:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="oRQZITFh"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05732DF6A
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 16:24:16 +0000 (UTC)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6973F18A
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:24:15 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507a0907896so1566789e87.2
        for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 09:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698337453; x=1698942253; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BkjZfqyzn67GK1xIIqInGUC5hTYxEpvzdrnvn5k51ZI=;
        b=oRQZITFhxOaHBCil0btWPgih0PsaiZrVNogCluue4ct9MvOQb/wPSiTz5oFiltzyWa
         Q10JqGgxYXl2n6D8lJCHV0WCmWJVfdylaLokTXh2bBmCGj3YaplpVKY+EL1eaa+jO0i1
         B84p9rYkU/V3gO7U9ALKCTKnc54ax7Hm2XzPT9OEmAKTygEHe85Wh0MGRWalOcRrNPpP
         2dZ6CcfPGHD+q1jp2FpfBYbcn+KVnJN91T3tXEKrmtGZB1yicmrf1g7q6DlBWjsL8BCV
         D8WsDVt82RaDiHgB09tcD9Ig/AwI7pBsmkb1792YEzzxth9niRqlJu2H4N+QWM0ncW3O
         Jj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698337453; x=1698942253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BkjZfqyzn67GK1xIIqInGUC5hTYxEpvzdrnvn5k51ZI=;
        b=xMmT/xOKtPKEexlzrydeT8KLAx+jj/RqRY26Q4vTPj+c9V3wcq0Xn2VarILYn5Ywn6
         flNEsCBsk6wFFu64ZCPf246GUk5QzbZQVyxHi+h0CFORzgIsYpMHqRm1PVV1hfRzJQpa
         tHcKA6AJojyenJ/3OiQzdGn+hWxVDVfjLtnxhEGV8rZrBJlpws4Cd5Iic19HBCoGAOrl
         mocVyfRBoGZ4n1ebOPGg/QoZUSnYT13dyLrwnT5Cq1HBZjTUGtl79vIAGeMClPKjjcxL
         3d5H9V3D2x1Yp/3ZlbJD4uCBQrGjwZDhnxC71j5FwOX/CP6kzobb1QJ6WU0iQebVWErD
         wdDw==
X-Gm-Message-State: AOJu0YzMknk3uKE+Hn8TxTjTOOcsKAuC3cWAcXu4EL82bqRRpukMa1yr
	eAo269BQ3UMmTMsBA14kRtn2Vg==
X-Google-Smtp-Source: AGHT+IHiSlI/UScbcsselDMkng3vCq9oDhTnQ2Kg90qvzxiUwkXuTiRpeWCen2NxuGnYbRxI0vKEVg==
X-Received: by 2002:ac2:430d:0:b0:502:d35b:5058 with SMTP id l13-20020ac2430d000000b00502d35b5058mr13933314lfh.4.1698337453528;
        Thu, 26 Oct 2023 09:24:13 -0700 (PDT)
Received: from localhost ([213.235.133.38])
        by smtp.gmail.com with ESMTPSA id c9-20020a7bc849000000b00405d9a950a2sm2899779wml.28.2023.10.26.09.24.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 09:24:12 -0700 (PDT)
Date: Thu, 26 Oct 2023 18:24:09 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pabeni@redhat.com, davem@davemloft.net,
	edumazet@google.com
Subject: Re: [patch net-next v3] tools: ynl: introduce option to process
 unknown attributes or types
Message-ID: <ZTqSqXfx9jlqvOuj@nanopsycho>
References: <20231025095736.801231-1-jiri@resnulli.us>
 <20231025175636.2a7858a6@kernel.org>
 <ZTn7v05E2iirB0g2@nanopsycho>
 <20231026074120.6c1b9fb5@kernel.org>
 <20231026074638.2a5e02b7@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026074638.2a5e02b7@kernel.org>

Thu, Oct 26, 2023 at 04:46:38PM CEST, kuba@kernel.org wrote:
>On Thu, 26 Oct 2023 07:41:20 -0700 Jakub Kicinski wrote:
>> > What is "type" and "len" good for here?  
>> 
>> I already gave you a longer explanation, if you don't like the
>> duplication, how about you stop keying them on a (stringified?!) id.
>
>Let's step back, why do you needs this?
>Is what you're trying to decode inherently un-typed?
>Or is it truly just for ease of writing specs for old families?

When running this with newer kernel which supports unknown attr would be
another usecase, yes. Better to print out known attr then keyerror.

