Return-Path: <netdev+bounces-31628-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC3A678F1B0
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 19:08:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C45501C20B04
	for <lists+netdev@lfdr.de>; Thu, 31 Aug 2023 17:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4404618C27;
	Thu, 31 Aug 2023 17:08:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370E511CB6
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 17:08:00 +0000 (UTC)
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C33EDA3
	for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 10:07:58 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-40c72caec5cso14051cf.0
        for <netdev@vger.kernel.org>; Thu, 31 Aug 2023 10:07:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693501678; x=1694106478; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KexMA37x2hbBFt8nNrssM03PfVnPAO95fCEOL28aZ2Y=;
        b=dGfBuEBfAYCZi09TG/50PE5e9Hk6mJHLTX4UUtmXTvQ+Zua0RIYLa0vA/FHsYj1q//
         4Q6z5uB4YNqg1warUg79lQoF3nHgOier2wNuMKEKyU6UPIE3hSvmjGAzEJMwovfbZKMN
         paV212bzeJGgY8eTs7BvBUX8Tk4hy6rU+sacWhKafk7WHG4pMfiaweSKUdbTqIW84XPW
         V+bNrBWg3R7CluS4cQqMTDByPyoxDuCoU0cLnG8MJLaRDb7SbcM0HB73fQoXO3LXXD7P
         Oc701APNmb8PRMd67+x8voHBptmZsCKF1E7ViNAI03AdykuXZM0ey0hSeS/V6+QOT9PF
         cevw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693501678; x=1694106478;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KexMA37x2hbBFt8nNrssM03PfVnPAO95fCEOL28aZ2Y=;
        b=HJVs4jDP3JnEw0B2KeLaAeHIxkwwQ5JkcHsxkp8Luz/9M/XkNyWNCFWiCSHwEFprav
         wKee9IvzfWM1ILeYY3C20YAXw86izvL1817L/S/iTM90kmDOx7cNXVGFYOsQ6/Co+aR8
         TN1XXAJUwZ57jlpOJn8sIwuf6rRZ5nzMiYdhWzgn8xIZg1Lcevz8OcbjNa+refwp3Jk1
         72OAFrUwwbgiaUjD+c58T4CdVIoK1qfdPfmZBMsDqxmbMIC6K0inCNBwarSeOuOw2tuj
         /gkZ35By1dmotl6zCyQZXjK0qZh7+2Ri3x5DYmAsk+s4aLyfY7uJmpNROQkeQEKALS1V
         EJ9A==
X-Gm-Message-State: AOJu0YyYO9y69srCKuDKgSkJ+PYtaGaGDyrBOySZuc8/cKukI0KKCXhz
	MYqf3Ufqaup8qonxt7FIn6AkCfkh2BooE++jHLsB7g==
X-Google-Smtp-Source: AGHT+IEBaxkTs2kDjDXeYXBewZBaRXd83tsRKxNf7lHVHeeqmI6HAomuPjy2g+dO6wPd/AXtGZfeS6oslbZI7BFYcnA=
X-Received: by 2002:a05:622a:19a0:b0:410:916b:eb3f with SMTP id
 u32-20020a05622a19a000b00410916beb3fmr7561qtc.16.1693501677631; Thu, 31 Aug
 2023 10:07:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230831165811.18061-1-edward.cree@amd.com>
In-Reply-To: <20230831165811.18061-1-edward.cree@amd.com>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 31 Aug 2023 19:07:46 +0200
Message-ID: <CANn89iKeNw4pjUKmWf=VAEWK-X4JCnP2pJic_9Jb0Whne_4e0Q@mail.gmail.com>
Subject: Re: [PATCH net] sfc: check for zero length in EF10 RX prefix
To: edward.cree@amd.com
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, Edward Cree <ecree.xilinx@gmail.com>, netdev@vger.kernel.org, 
	habetsm.xilinx@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Aug 31, 2023 at 6:59=E2=80=AFPM <edward.cree@amd.com> wrote:
>
> From: Edward Cree <ecree.xilinx@gmail.com>
>
> When EF10 RXDP firmware is operating in cut-through mode, packet length
>  is not known at the time the RX prefix is generated, so it is left as
>  zero and RX event merging is inhibited to ensure that the length is
>  available in the RX event.  However, it has been found that in certain
>  circumstances the RX events for these packets still get merged,
>  meaning the driver cannot read the length from the RX event, and tries
>  to use the length from the prefix.
> The resulting zero-length SKBs cause crashes in GRO since commit
>  1d11fa696733 ("net-gro: remove GRO_DROP"), so add a check to the driver
>  to detect these zero-length RX events and discard the packet.
>
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Nice bug ;)

Thanks for this fix.

Reviewed-by: Eric Dumazet <edumazet@google.com>

