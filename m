Return-Path: <netdev+bounces-36050-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 088327ACAB7
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id 07C68B209A3
	for <lists+netdev@lfdr.de>; Sun, 24 Sep 2023 16:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67874D521;
	Sun, 24 Sep 2023 16:10:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE50D51F
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 16:10:06 +0000 (UTC)
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B544EE
	for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 09:10:05 -0700 (PDT)
Received: by mail-vs1-xe35.google.com with SMTP id ada2fe7eead31-452962769bdso2105467137.3
        for <netdev@vger.kernel.org>; Sun, 24 Sep 2023 09:10:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695571804; x=1696176604; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x/tu5haE6v6Lb0n+9tuVM4PS+ZgwAzsYhKLkDZrvSlE=;
        b=k4c6OGFMDA5zElK+alcPm3aarfv55d2poeZbfV/7OprR/QCYnih83nx/Y8OcygngL0
         kSHL2wrwuldp3X93mkLiPdgVOse2a/8okZhOd+dV8WqLDgMby8ODbelMkAm0maAq0lYO
         pmM30rfcihavePEIcRLBWdbxWq3d5fiFauw0wVIp1zjKEQ7s/YNm+sYHIAPw3mJd90gU
         99HjQmWHkLeFZVboIhQyNZxHowbpeOZpEF6przfwPjBHT+zU2dkUmx8ahZ0mwClfgmgn
         clQOvCJICo19g1NNZbbILlfPOJLFgHSH3NxHg12fOw/zaljMBfubqRvbeJgp8Y6nadOd
         a9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695571804; x=1696176604;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x/tu5haE6v6Lb0n+9tuVM4PS+ZgwAzsYhKLkDZrvSlE=;
        b=rye40nGixE4oc4MZ/Mkv9hqn5glPCEwj7dn0QYGNLudjhJqzj3W4Mtv3TXVDSH1WOZ
         bxmnPwvv6JOir9HlYvdeiRz2ISqS3HNhGV7EwpmYpodOUI+rxmj70dy/NzKhmW2HUHy6
         j/xRUsfGBMLlE4bUyDsZViO2h6f+/xiSLFTp1Znm9l6KsD7jxnYylcBz+I5j1g2/Jf90
         4Vx/FKaZ3M37jxRd3iqBomW75UZWzeS+lYvDIpcUXs2pESKr9VDQBTDa2dymDQJY1xos
         946C1pgpyvbiMAE8HQ7AdrWIyL3u0SukzUFi/eKR4dmZ4Vhi2DWmNTYPyunJydUTr80f
         4ZXw==
X-Gm-Message-State: AOJu0YxZV1WGRoMO7mCnh8dgUcpBQndP2/PsZI0Ni6wPYab5KuvyZ3dh
	+R6ukMeUE8Jy6sRPisWkFOtbm9sVHnVx1Twv742SlA==
X-Google-Smtp-Source: AGHT+IF7eS4wztpXBqgO1/s9SAXabgS7OGqig/KrLrV1WNHGMZn4qfG0e8tpHnDfVAaYydQ7hvv3vi6uvJ5qviRxnnQ=
X-Received: by 2002:a67:ebc1:0:b0:44d:453c:a838 with SMTP id
 y1-20020a67ebc1000000b0044d453ca838mr2143556vso.5.1695571803989; Sun, 24 Sep
 2023 09:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922220356.3739090-1-edumazet@google.com> <20230922220356.3739090-4-edumazet@google.com>
In-Reply-To: <20230922220356.3739090-4-edumazet@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Sun, 24 Sep 2023 12:09:47 -0400
Message-ID: <CADVnQyngtZRDN=CfWc27zacYtZfwthGTyrBm4uqmoZ=qL+4fWw@mail.gmail.com>
Subject: Re: [PATCH net-next 3/4] tcp_metrics: do not create an entry from tcp_init_metrics()
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Yuchung Cheng <ycheng@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 22, 2023 at 6:04=E2=80=AFPM Eric Dumazet <edumazet@google.com> =
wrote:
>
> tcp_init_metrics() only wants to get metrics if they were
> previously stored in the cache. Creating an entry is adding
> useless costs, especially when tcp_no_metrics_save is set.
>
> Fixes: 51c5d0c4b169 ("tcp: Maintain dynamic metrics in local cache.")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---

Acked-by: Neal Cardwell <ncardwell@google.com>

neal

