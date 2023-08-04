Return-Path: <netdev+bounces-24371-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D0176FFDD
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 14:02:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 270FA282622
	for <lists+netdev@lfdr.de>; Fri,  4 Aug 2023 12:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFB7BA3F;
	Fri,  4 Aug 2023 12:02:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FEB6BA28
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 12:02:11 +0000 (UTC)
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F576126
	for <netdev@vger.kernel.org>; Fri,  4 Aug 2023 05:02:06 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id d75a77b69052e-407db3e9669so224581cf.1
        for <netdev@vger.kernel.org>; Fri, 04 Aug 2023 05:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691150525; x=1691755325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hZhCQtFnDyxPkfOkKO4E3UsLO0Txsl66rqqt9O7ZV8I=;
        b=qDS6ttGqU/zs67dKw+hoc0dPw6r3cxK7b9CH1rjcEapNHeyqqg++sQ3VpWqySZgm/F
         YfiiID3jwnWZDRF1inE1LPFKKt5pDWbuuo7Vl/vlODaUC74dirQX85wsrda1iQftxWEV
         s6mrdrT5WP0cLLaqc+FgoCEEDSPxdoJCwnaUOaB78RnI82r+ezKvjuA8TQXkgnO6KYp1
         1wJX6yxbY8rAs2uWJ52Kyx+VnAULfH0UGH+leY4c79UuY0/KTP9mxR0YRzJsIL5+AHW0
         7CqXB6QfD3P6zESSBmmWq2L5Wqn7/Ey4djZwLiMqrHTzW0uFdv4oD5Z2upUSHfVloSA2
         6Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691150525; x=1691755325;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hZhCQtFnDyxPkfOkKO4E3UsLO0Txsl66rqqt9O7ZV8I=;
        b=MkTeKfTiWma3gAljaAhtOEI8iir8ouMAjJGqS6IZEYU4YA6lkE3U8WkEaZa+3ZbQXC
         tMGYWYImSI3EG1vji1+qft9lS+3fJ5SE29kdqfbTjka5+NpHrOe0JZY7jP+Bs2iOQdlH
         cytu977NCa/xt0Z3MMg0Qm++EKzko2ilbjNk2oZfIhQ9qsF0nFa55859yrCFVZIoxcL2
         6PF7776htSJVQWwl5ByRlPoUTH5IGhqQTVQTwJwxzAP++J7BmPllxea4dFW2ODM0rm2u
         qLTWc3mqHJA3idIlosA1fy9oVrSy+LDRd6LCqaDBsZo+RREC0hV7VSexfIGMOHuys5h7
         lZhA==
X-Gm-Message-State: AOJu0YyDXSX9o+flBHi3s8Xuy/GO9SprfGKvCIE463hCuCp8291Oqsw3
	m9oGwQ8HCWUaIXHInjD5cNigOl9ak/F7DDM+CwlyGCb3oEkwsw9Sy7w=
X-Google-Smtp-Source: AGHT+IG+Q7mWxOPe1xSEaUBsoN4Hq+g/YNV4MXVXrtWRnX4iAtgSgH+Frd81r1ps76nF2rY3EpEErrFemFfXwRw5aCQ=
X-Received: by 2002:a05:622a:55:b0:3f2:1441:3c11 with SMTP id
 y21-20020a05622a005500b003f214413c11mr245276qtw.2.1691150525424; Fri, 04 Aug
 2023 05:02:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202308041657467504029@zte.com.cn>
In-Reply-To: <202308041657467504029@zte.com.cn>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 4 Aug 2023 14:01:52 +0200
Message-ID: <CANn89iK61nt5o7KBZyjqVP6Q1EREvzg-x_bos8hSGSmwfwZRBw@mail.gmail.com>
Subject: Re: [PATCH] net: add net device refcount tracker to pneigh_queue
To: yang.yang29@zte.com.cn
Cc: davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 4, 2023 at 10:58=E2=80=AFAM <yang.yang29@zte.com.cn> wrote:
>
> From: xu xin <xu.xin16@zte.com.cn>
>
> Add a static net device refcount tracker to neighbour.c to track
> dev's refcnt when pneigh enqueuing and dequeuing.
>
> Signed-off-by: xu xin <xu.xin16@zte.com.cn>
> Reviewed-by: Yang Yang <yang.yang.29@zte.com.cn>
> Cc: Kuang Mingfu <kuang.mingfu@zte.com.cn>
> ---


Can you explain how this patch was tested ?

Thanks.

