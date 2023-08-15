Return-Path: <netdev+bounces-27555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1719677C633
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 05:02:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 152491C20BEB
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 03:02:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8051622;
	Tue, 15 Aug 2023 03:02:47 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9717F6
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 03:02:47 +0000 (UTC)
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2969173D
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 20:02:46 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1c0fa9dd74fso3385679fac.3
        for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 20:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692068566; x=1692673366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R7e3EHdm+7ytBwCFLv4xpoK402IHL7X/lvyR21fbrw8=;
        b=koSAppBEFXZF0wS3FOdbJm9CJMsVVzVFWcDuUvpLf8q5QSc59SRaspEGFB/dPfoHrF
         EP6XpFJH+l99d9D6Yt+mkJAHgQLSE8iWMWMIHG6JDUwOAhj/qm52EFtMdRNsJQDtq/7l
         qOBJyOOOc/FsbeBmnAmzLfx3wbis5Eux13VeOd7maWp0IvETRA55IvPOrX5VkqzDSXnK
         1klOezNh9bMRYm1CwzQ/qf/U41GmdbUgBPBAQI78/Cl10+XvzRorLc266uOrVlxXR3yW
         PP5SUg/+PUiOyDvn0jS2Ek+BfH3JBw3euG7QSRjd8MYVRa7PnfIDQ4xSAtq0GLw9kgEq
         2SGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692068566; x=1692673366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R7e3EHdm+7ytBwCFLv4xpoK402IHL7X/lvyR21fbrw8=;
        b=gJeBAk3B5uTyXasiRcZWRdKxay49O2qTv6zPJtljfxGkj8+jAnNnRndWtybe0reZic
         T2b8w/6pIGQXeKM3Rl6KuZvHzyPDqD6Js/KEBYYOiBYxSWb/sUDJD9wlN2kIJ+dxlv5X
         Uq9vIkHpg23YJDYcAnSF56moOvMCNFYU2y+wsBvVkRnGUJrv+6FCe7s4cFwaGiGtiXYo
         Wyg1/pslv+zDYH1rR2tstnaxZIH5dbuxMp3s5Di6ckwhS+8SIpyVz6FPrC90cx5NjTY7
         2EWXVJtN9m/g1Ze9eJXdQ3qBm1ZgOFDAZW99c0aMD54/Z+z6Uuk/ztYFkRi+t0EEIl0C
         5UWg==
X-Gm-Message-State: AOJu0Yz0nkmGYjryZbtibZFTheQ1ep0s1kfA02KFGpSTt0r0NXuvb3ul
	ygGaqZ5JggSfQZJirHAc71FANvQuwmq5opN9Zyc=
X-Google-Smtp-Source: AGHT+IHPtrZddIubrkfTpeWR8900xI7VGu3ZX7zp3xYNCcTq73CgO+5kgmI6Si5UzQAP90co+p0r8LQln+rPGVZE2aI=
X-Received: by 2002:a05:6870:a798:b0:19f:aee0:e169 with SMTP id
 x24-20020a056870a79800b0019faee0e169mr11972219oao.30.1692068565942; Mon, 14
 Aug 2023 20:02:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230811023747.12065-1-kerneljasonxing@gmail.com>
 <CAL+tcoArZtbDKFMCC=i+v3fE1iG+UOBn4KhPxB-85rJCh882Xg@mail.gmail.com> <20230814192444.24033764@kernel.org>
In-Reply-To: <20230814192444.24033764@kernel.org>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Tue, 15 Aug 2023 11:02:09 +0800
Message-ID: <CAL+tcoBdhwwgF43iBd3T7ZZQUn4SCN3wUw1BwwcJfAoPu2Sq7A@mail.gmail.com>
Subject: Re: [PATCH v2 net] net: fix the RTO timer retransmitting skb every
 1ms if linear option is enabled
To: Jakub Kicinski <kuba@kernel.org>
Cc: edumazet@google.com, davem@davemloft.net, dsahern@kernel.org, 
	pabeni@redhat.com, apetlund@simula.no, netdev@vger.kernel.org, 
	Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Aug 15, 2023 at 10:24=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 15 Aug 2023 10:08:13 +0800 Jason Xing wrote:
> > I wonder why someone in the patchwork[1] changed this v2 patch into
> > Superseded status without comments? Should I convert it to a new
> > status or something else?
>
> Ack, looks like a mistake, let me bring it back.

Thanks.

Jason
> --
> pw-bot: under-review

