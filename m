Return-Path: <netdev+bounces-36953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5F2B7B2A03
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 02:55:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 975A3282B53
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 00:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D19D615B1;
	Fri, 29 Sep 2023 00:55:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741B210FA
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 00:54:59 +0000 (UTC)
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72C8C1
	for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 17:54:57 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-502f29ed596so3237e87.0
        for <netdev@vger.kernel.org>; Thu, 28 Sep 2023 17:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695948896; x=1696553696; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lreN35xMhg1T08yBsWwUgYQv1aW4czRqSA3Hrc1fMCw=;
        b=HnRAU47Jz7R1Nzp0wy6b4i2ehIB4AkQIniKGHhohnpfuLrZe59AR7Wzi/daa8dbvIH
         o9hLMzVIPUdY5eegLMDF9/vquC68iVr8TnHzSNIeAJ2KSagj7G97V3nbpPIyxy9pTOPM
         mvUoslsP3J0+jfl3p2Y3qaCZHBw6QG3TjmwVb8Ectdei20rp4YZPR9REIaXXlcx4TO2o
         ZvSIQsa9q6PavkPXLaQ0UH/HUVN7ebfJJeYgU5W3J3d9YYxum0Ghr6Q3XOHZlRDGmbkZ
         WX/cEs1svJfGti2OtFwNGK0ABVdPFygVglCiBSU49Yv1uHjsEnHDaiYeecCP7whHfIeq
         EB3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695948896; x=1696553696;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lreN35xMhg1T08yBsWwUgYQv1aW4czRqSA3Hrc1fMCw=;
        b=nuW/0xDfv8m0n4ugEtdU0+S5bbrUT2hvaDMhhGemPv1SAxlAJzTkERq6mOBEhr3z37
         CePSnR8RQVwgHg5dJNhIzz02yC1iI5cFpPL27LDRSe29sVH4801p3VyMutMbeQDtw2tk
         yFOwRGLiW1eG2+ObWXtw6ov63ouRXQmHB9Hj1ZY5YQNjI0hA4Nx/S4np/x7lk1EYFR4J
         8shWuQYEkmwxp+h49Gv1GtpIxhobgQ25TZ4m7BpZSs/gFIiP1e14F3dwlEvOUVU8xa4V
         nYPJXpLHxu15Iv2GqtmEA5sQ73lqsHy+khBX6YDrHxIheHXDmWwbsqC0YHBdmySh6QeZ
         hNPg==
X-Gm-Message-State: AOJu0YwvU5GvwJat3r19kfHBWe71pTuUvyySfgDyiHTozqg9EPXK/oa2
	RYQXr3YrRBGDZdZ4DW4PAp+o/AAZxaOyp7y6UmFeRA==
X-Google-Smtp-Source: AGHT+IHAThsVmpCpv/FxtQXqBw88S0whBHNVBRRdNRs9fBfeobCUfvRrtoUaTmHOoGpOrtEnjpeS8HD2ZgdQP4FSIBM=
X-Received: by 2002:ac2:44d2:0:b0:502:dc15:7fb with SMTP id
 d18-20020ac244d2000000b00502dc1507fbmr261483lfm.5.1695948895792; Thu, 28 Sep
 2023 17:54:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230927182747.2005960-1-morleyd.kernel@gmail.com> <20230927182747.2005960-2-morleyd.kernel@gmail.com>
In-Reply-To: <20230927182747.2005960-2-morleyd.kernel@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 29 Sep 2023 02:54:44 +0200
Message-ID: <CANn89iKecLBD6uxE3wQF0KtAmhMH0Zk8GoKe-YNSVB7JzwroDQ@mail.gmail.com>
Subject: Re: [PATCH net-next 2/2] tcp: change data receiver flowlabel after
 one dup
To: David Morley <morleyd.kernel@gmail.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, 
	David Morley <morleyd@google.com>, Neal Cardwell <ncardwell@google.com>, 
	Yuchung Cheng <ycheng@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Sep 27, 2023 at 8:28=E2=80=AFPM David Morley <morleyd.kernel@gmail.=
com> wrote:
>
> From: David Morley <morleyd@google.com>
>
> This commit changes the data receiver repath behavior to occur after
> receiving a single duplicate. This can help recover ACK connectivity
> quicker if a TLP was sent along a nonworking path.
>
> For instance, consider the case where we have an initially nonworking
> forward path and reverse path and subsequently switch to only working
> forward paths. Before this patch we would have the following behavior.
>
> +---------+--------+--------+----------+----------+----------+
> | Event   | For FL | Rev FL | FP Works | RP Works | Data Del |
> +---------+--------+--------+----------+----------+----------+
> | Initial | A      | 1      | N        | N        | 0        |
> +---------+--------+--------+----------+----------+----------+
> | TLP     | A      | 1      | N        | N        | 0        |
> +---------+--------+--------+----------+----------+----------+
> | RTO 1   | B      | 1      | Y        | N        | 1        |
> +---------+--------+--------+----------+----------+----------+
> | RTO 2   | C      | 1      | Y        | N        | 2        |
> +---------+--------+--------+----------+----------+----------+
> | RTO 3   | D      | 2      | Y        | Y        | 3        |
> +---------+--------+--------+----------+----------+----------+
>
> This patch gets rid of at least RTO 3, avoiding additional unnecessary
> repaths of a working forward path to a (potentially) nonworking one.
>
> In addition, this commit changes the behavior to avoid repathing upon
> rx of duplicate data if the local endpoint is in CA_Loss (in which
> case the RTOs will already be changing the outgoing flowlabel).
>
> Signed-off-by: David Morley <morleyd@google.com>
> Signed-off-by: Neal Cardwell <ncardwell@google.com>
> Signed-off-by: Yuchung Cheng <ycheng@google.com>
> Tested-by: David Morley <morleyd@google.com>

Reviewed-by: Eric Dumazet <edumazet@google.com>

