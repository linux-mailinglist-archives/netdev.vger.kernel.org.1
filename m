Return-Path: <netdev+bounces-58826-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE04D8184F2
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 11:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A24151F24E2F
	for <lists+netdev@lfdr.de>; Tue, 19 Dec 2023 10:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4714017;
	Tue, 19 Dec 2023 10:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MzmwUBqd"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609911426D
	for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 10:01:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3cfb1568eso11544585ad.1
        for <netdev@vger.kernel.org>; Tue, 19 Dec 2023 02:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702980117; x=1703584917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5MQgXYsjLWPHTGlu3V7ENxFI8WlGeSbSaSdUi86HNZI=;
        b=MzmwUBqd8dTXTykCCi1V7hWHJ/2TTenOTj3xgQtlKMRP4mRSqf07ZOgYJnzyx3di6L
         A+in9Y11A1D0qXgacTEDcRj4t5GyC4hJ9DMg4YFzKFOdqCLafYgakW4ra6yQTOb1lwEF
         NFKnh4/j+fl0a5ZpDxlfqD5D1xlkuSfz3Hq2HwFfpATBtC9xgF1BnWmAqVINAY/P1qrP
         MSGgaaGv/+PPOyFFhVPgUbAHKLXi8n/EcyHzOSi+bgIjK4JH4lfHxpE2q0UXb7eo8Lyk
         c4E/pOh2m0oyOEyTO7ud6kCzmzhNPRumAFXyuJ98AjVxXfESjMjxxIegNIQGXGBXPbae
         nQqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702980117; x=1703584917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5MQgXYsjLWPHTGlu3V7ENxFI8WlGeSbSaSdUi86HNZI=;
        b=m9x4Ucz4QdVv+ANIAH1ujwXY4Ykb1d2IIIp76vWaPAq9yTGW5SXVc7l08MKQ2rgt/I
         6UFTCER0vmcAdr5/lGigcZ7P2gH9TICkdR/ANMycKw9WioRQ48HJOAOeuuHsX7h4NHEe
         2wvI/2/NJUNuhMhnCVoJl2HN5U8fI51cVF7VqgwtrVRo/AYRbB/PiyGDxupWveVPTKuj
         ffpMhuJf3F5+IikPhNNhD/rtCfmr5pSUdQkckIsOXagKo6/ACIIGOVWG7X8k/GDfIYRH
         gzQMjNNR79ybwcyZCzyz2Q5W7DTcFZMP3PSI2nib4d13ZcbE7hv++cGHEAwFG2FiTpmp
         ky7Q==
X-Gm-Message-State: AOJu0YxxgRvK2XPOORXlxuN7E1Hh1g6CaoBt+mfhvZroU2f1ixv6Q/zG
	htXH5v+uGV+yVPb+mX/q5B6jUFKp3BdHGo9CivI=
X-Google-Smtp-Source: AGHT+IG/htoP1tF/ccP4HDLECVKhN28RYWYRkqPcamCW6/dmfSdkAz+CkgqWJfp/bGPPMPGMvnKkEw==
X-Received: by 2002:a17:902:6bc2:b0:1d3:52a0:1263 with SMTP id m2-20020a1709026bc200b001d352a01263mr9289865plt.43.1702980117562;
        Tue, 19 Dec 2023 02:01:57 -0800 (PST)
Received: from Laptop-X1 ([43.228.180.230])
        by smtp.gmail.com with ESMTPSA id p11-20020a170902780b00b001d3985a593esm6280367pll.172.2023.12.19.02.01.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 02:01:56 -0800 (PST)
Date: Tue, 19 Dec 2023 18:01:53 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next 1/3] tools: ynl-gen: use correct len for string
 and binary
Message-ID: <ZYFqEePnN9wesTt0@Laptop-X1>
References: <20231215035009.498049-1-liuhangbin@gmail.com>
 <20231215035009.498049-2-liuhangbin@gmail.com>
 <20231215180603.576748b1@kernel.org>
 <ZX1hXMhJLwgg5S1v@Laptop-X1>
 <20231218142209.64b0a2ab@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218142209.64b0a2ab@kernel.org>

On Mon, Dec 18, 2023 at 02:22:09PM -0800, Jakub Kicinski wrote:
> On Sat, 16 Dec 2023 16:35:40 +0800 Hangbin Liu wrote:
> > The max-len / min-len / extact-len micro are used by binary. For string we
> > need to use "len" to define the max length. e.g.
> > 
> > static const struct nla_policy
> > team_nl_option_policy[TEAM_ATTR_OPTION_MAX + 1] = {
> >         [TEAM_ATTR_OPTION_UNSPEC]               = { .type = NLA_UNSPEC, },
> >         [TEAM_ATTR_OPTION_NAME] = {
> >                 .type = NLA_STRING,
> >                 .len = TEAM_STRING_MAX_LEN,
> >         },
> 
> max-len / min-len / extact-len are just the names in the spec.
> We can put the value provided in the spec as max-len inside
> nla_policy as len, given that for string spec::max-len == policy::len 
> 
> Am I confused? 

Yes, we can do that. While this looks like another magic. When user set max-len
for a string type in the yaml spec. After converting to c code, it's .len
attribute. This still makes user confused.

Anyway, this is just a matter of choosing apple or banana. I'm OK to using
the current YAML spec policy.

Thanks
Hangbin

