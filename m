Return-Path: <netdev+bounces-39448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0510B7BF457
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 09:31:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 559CD281AA2
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 07:31:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FBB2FBE5;
	Tue, 10 Oct 2023 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="r5eglyf4"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF733D309
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 07:31:27 +0000 (UTC)
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2AC199
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:31:25 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-405459d9a96so174095e9.0
        for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 00:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696923084; x=1697527884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F4OjawN4EWFXnf+1aT4Y6ZvvcqO40Vz4jUYoVUP23pY=;
        b=r5eglyf4sewHpDCwRlmOVSoLhJDZ60kwjEBWEDYSWNoKVHZhU43xrnwc2pwbVqKo03
         Bg3FQm6v686c2qjnRfJoCzU5PdsrTS2zgbNNRoLVzVhsXPScVbtu2R3HV53g+8/SZwIk
         lgjjtH8A0jGbYSq6Ufjh9Gd1j5ygVaDizW+CAkPldVtSVXea09wGk5s/dkIdU4QP4RUw
         0NhfG/+88brNFla9LGaOeGbZKINEAZQnIuRLyYzWhelNf76snsBOkBlQFqpK0XUK9lz/
         ai6TmmxCxgODulXQ4Z0pedwQ2xRCBxNu5Qox20gIizVr28I2kXSJ3y3Bw5qePH4ed6dN
         JgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696923084; x=1697527884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F4OjawN4EWFXnf+1aT4Y6ZvvcqO40Vz4jUYoVUP23pY=;
        b=En7/F05NqEt9cXRuW5zyknbOlduq8Xqxw4jGwVHSHidGrSzlrIsklhAlC49IYg4loh
         yOJbERBJf/La7gI776C31HDXUt6oKQXFHIWpRmCwT6A1tEAHnDLc+PaQz1YkC0XEJytE
         Zv5WAbD3CZkUAGSLNpW9tRGtODt7070yNCr904VPlJ3NdxScUy43vLDr6+fpPNxfg0+z
         DDwv/bBWtHNbnlsAsCIU/mQ5eq4vAwAha3+s/e2T45kN3lYmzIddUHAOFYEb42b2bMsr
         LgRATw2+TFcVjqV0niAcF2oTOn5s2HyUCD3DfyV1ffQ4pUL3mV22dUdMSXNLu8kKXMMM
         4p8g==
X-Gm-Message-State: AOJu0Ywfn07+4T7oaufqw6F19VxIQ9rYVdvqsdHd2PCP9hPDPZqmDkyA
	s8ivU3hM0AthKqhI3cKsxHfcYX/StvkZxNg/23AuqA==
X-Google-Smtp-Source: AGHT+IHSztFKWPzBB8GNQhcB/J3rWIA7DksMh580Xxim0H5NLF+t9K5xcSPM2HpsSstHIZtJXwM89Q2HWf12Oldi8WI=
X-Received: by 2002:a05:600c:b93:b0:3fe:eb42:7ec with SMTP id
 fl19-20020a05600c0b9300b003feeb4207ecmr429407wmb.1.1696923083984; Tue, 10 Oct
 2023 00:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231009111633.2319304-1-yajun.deng@linux.dev>
In-Reply-To: <20231009111633.2319304-1-yajun.deng@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 10 Oct 2023 09:31:10 +0200
Message-ID: <CANn89iLAEHW1yH9bP+kBqG=TbeXjsYH7JzMqPLXzBc-wXEzsZw@mail.gmail.com>
Subject: Re: [PATCH net-next v8] net/core: Introduce netdev_core_stats_inc()
To: Yajun Deng <yajun.deng@linux.dev>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Mon, Oct 9, 2023 at 1:16=E2=80=AFPM Yajun Deng <yajun.deng@linux.dev> wr=
ote:
>
> Although there is a kfree_skb_reason() helper function that can be used t=
o
> find the reason why this skb is dropped, but most callers didn't increase
> one of rx_dropped, tx_dropped, rx_nohandler and rx_otherhost_dropped.
>
> For the users, people are more concerned about why the dropped in ip
> is increasing.
>
> Introduce netdev_core_stats_inc() for trace the caller of
> dev_core_stats_*_inc().
>
> Also, add __code to netdev_core_stats_alloc(), as it's called with small
> probability. And add noinline make sure netdev_core_stats_inc was never
> inlined.
>
> Signed-off-by: Yajun Deng <yajun.deng@linux.dev>
> Suggested-by: Alexander Lobakin <aleksander.lobakin@intel.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

