Return-Path: <netdev+bounces-31531-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A09B878E954
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 11:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB3931C2091B
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 09:24:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABED8498;
	Thu, 31 Aug 2023 09:24:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F6FF8488
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 09:24:46 +0000 (UTC)
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1014F198
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 02:24:43 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id d75a77b69052e-4036bd4fff1so268731cf.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 02:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693473882; x=1694078682; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z17+vVN6sx2weR0H3t69ibncC3rE1QVGqpLhrNEg4RQ=;
        b=zhjNRu8LKalLITUQQpHHpvAGK/vzJV9kEu8DbK3GOg7bEAPSFdAeWGtSkek2wjJZrZ
         dGRIDneY9kEmGrQN+wK2N4SUBhi1fartHKx6zWWzejegKCROmiwVVQHMttTCgwkksTjm
         ezOVn5Bx8nQrguTy8aijvfauTD3lgwbw8X36ar7bQSbDR88/ny2DhsWFTj+Nofw9w4+l
         tW6bngUp2dCET09bwPjXVwuV8OIhheTX86YVtV7u6liNFILoF7X6+hMPfYun9Xd/OMcc
         QWglNR8QQ+nLv6wYfJk4TWiOzYS9jgHPQXafWgZNbnwRgZQbbB1oNO+ODlDkSKd1EWrM
         UKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693473882; x=1694078682;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z17+vVN6sx2weR0H3t69ibncC3rE1QVGqpLhrNEg4RQ=;
        b=Cdg2dkTADATOh91iUoxVSofUNMjHvJpSAgvGmszd2WOu3XuE/QxcEqV2zwbIeA+cJ+
         Ji8cA8xLb7c48nljxl4oIXYIvCkl49o21lnp5cLK9PVC1YWHTE4WliCcBOctVWWsuhh/
         fSMCJMhIVCOdq4VLcq4v7fAljGnOtzkVGuM07cKpwtRbCJ0yctI2uhwZeJvUWfAC3Pt+
         BAtg7t7jZN0OELmIJPdHCkc/8A/zzfbYk5FM9eEmo3psbcgrNiDi6mosBdc0F5K21QCF
         WNd40H+yjdmtvIcnsy8spyFjsV9uJ45WPhgni2zLRX3pazjX3c5j3ae0TX7zBy7kVqzH
         qiWA==
X-Gm-Message-State: AOJu0YwlO9YdHkJeeRtmz9C/OJH6gIyHJbVytJkQEHDE2PamG1Jw92mG
	UFscU2lRkeyuOVKuhg76Kn5Nu2X+1rqtuQGBv4CY6w==
X-Google-Smtp-Source: AGHT+IHO3NbC7RZ+B5XargMo0aoclgdBoPhKNw1rbOXBj+FOEajIyNRhga0AQfyiVg7lmWsm/atGgQEZh8BkzretJrQ=
X-Received: by 2002:ac8:7f48:0:b0:403:eeb9:a76 with SMTP id
 g8-20020ac87f48000000b00403eeb90a76mr152885qtk.17.1693473881890; Thu, 31 Aug
 2023 02:24:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230831090525.17742-1-liangchen.linux@gmail.com>
In-Reply-To: <20230831090525.17742-1-liangchen.linux@gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 31 Aug 2023 11:24:30 +0200
Message-ID: <CANn89i+9GBoL-xDMwv6fBzCju9DxA-1LMk-5Errj7tA0Xoyo1A@mail.gmail.com>
Subject: Re: [PATCH net-next] veth: Fixing transmit return status for dropped packets
To: Liang Chen <liangchen.linux@gmail.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 11:06=E2=80=AFAM Liang Chen <liangchen.linux@gmail.=
com> wrote:
>
> The veth_xmit function returns NETDEV_TX_OK even when packets are dropped=
.
> This behavior leads to incorrect calculations of statistics counts, as
> well as things like txq->trans_start updates.
>
> Signed-off-by: Liang Chen <liangchen.linux@gmail.com>
> ---

We kindly ask for net patches to include a Fixes: tag.

If we receive hundreds of patches without them, it takes hours of work
for reviewers
to do the _needed_ work.

We need your help.

Fixes: e314dbdc1c0d ("[NET]: Virtual ethernet device driver.")

Reviewed-by: Eric Dumazet <edumazet@google.com>

Thanks.

