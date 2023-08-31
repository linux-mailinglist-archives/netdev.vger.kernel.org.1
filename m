Return-Path: <netdev+bounces-31621-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E7A78F10B
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 18:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A68D7281670
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 16:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0A214001;
	Thu, 31 Aug 2023 16:17:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D489134B0
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 16:17:32 +0000 (UTC)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797D5E5A
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 09:17:18 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fe4cdb72b9so10830825e9.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 09:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693498637; x=1694103437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=k7TvHgS5jGL33dvOu+MIjC58d0MOJ04ATumSUDQM5IY=;
        b=cOOJFPxJ8dxhz4ViFj+ECNx2Iu53v+IYAzKlV86X7kqjDODuRE0mUjoAZ3J9JDb99u
         NpGsYwg4Hs6AB8ezWZK2rB50uqfaRqrhJoyWgpsb2XV8CTCxSaS8Zm6xvLo5naT0/3J0
         zidjgCq8TKSKNt1vQZ2npKRgHKO1yFvqRt5OJ+kGQhKBKSjHNubmdSk6lFU18ElWX7Or
         3mnVRd/hnLKztV/R0EVLQIurJZKqNl08IjOgvTuUuWbAGsdIA0W5alCSZeNENjvCKPt8
         trArmnXVT1YXRrUI4rfjztdkOKHfusQn/juZCzvxKc8fvjIZjM+ubC+Rz83mu0fUYTX8
         0VUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693498637; x=1694103437;
        h=content-transfer-encoding:mime-version:user-agent:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=k7TvHgS5jGL33dvOu+MIjC58d0MOJ04ATumSUDQM5IY=;
        b=hMFVzrHJjaF1bqgnRh06bVMIwbJldqbUtOkAtbsYwxDBigmpt/qxv+VaokZNXEJD8P
         Lyn09FB7natq33DKTshHngk6cp/qt0mKesJhZGd8lQVv3+3sAa6Fm/LHTRqTMn8tKR3O
         0mCUUnzGigXnZTFdTIttZNTUS1ph6iNatOA4H1NEp3CqbMQq1GwRJd+oqhpMXw/SZenc
         3au3QgI/049ANPl3M8futS1Q9c7d1Z3DiPGbyA4b9Wvwlcqbw7Td+JXSzZmfU0tLw3JK
         AvBfuDwg0VmjPvwMGYKTM87nQWuL/h90bE7+hHmc04i/9gHRcHt8OkuUCLsxrXui9/Cp
         qcAw==
X-Gm-Message-State: AOJu0Yxv3mTxlaHnex9wBpEQ0mlYPXKWu6QYlqSJ4Dd1vJd7XCHA1Nwb
	BqKURVZlOlgQD0ElPgIJ6obXyFFW0e4=
X-Google-Smtp-Source: AGHT+IHKILJwgx1XbnZkKS7hkqGOVH9+cVm3DTo1ugKHDJVOeQE+6UcgxbFfGHLJHbNdBRpoJdgq3A==
X-Received: by 2002:adf:f7c1:0:b0:314:1ce9:3c86 with SMTP id a1-20020adff7c1000000b003141ce93c86mr31706wrq.0.1693498636638;
        Thu, 31 Aug 2023 09:17:16 -0700 (PDT)
Received: from imac ([2a02:8010:60a0:0:a8df:c6e8:f57b:aa6e])
        by smtp.gmail.com with ESMTPSA id k8-20020a5d4288000000b003176aa612b1sm2666101wrq.38.2023.08.31.09.17.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 09:17:16 -0700 (PDT)
From: Donald Hunter <donald.hunter@gmail.com>
To: francois.michel@uclouvain.be
Cc: netdev@vger.kernel.org,  stephen@networkplumber.org,  petrm@nvidia.com,
  dsahern@kernel.org
Subject: Re: [PATCH iproute2-next] tc: fix several typos in netem's usage
 string
In-Reply-To: <20230831140135.56528-1-francois.michel@uclouvain.be> (francois
	michel's message of "Thu, 31 Aug 2023 16:01:32 +0200")
Date: Thu, 31 Aug 2023 17:17:11 +0100
Message-ID: <m2h6ofdw54.fsf@gmail.com>
References: <20230831140135.56528-1-francois.michel@uclouvain.be>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

francois.michel@uclouvain.be writes:

> From: Fran=C3=A7ois Michel <francois.michel@uclouvain.be>
>
> Add missing brackets and surround brackets by single spaces
> in the netem usage string.
> Also state the P14 argument as optional.
>
> Signed-off-by: Fran=C3=A7ois Michel <francois.michel@uclouvain.be>

Reviewed-by: Donald Hunter <donald.hunter@gmail.com>

