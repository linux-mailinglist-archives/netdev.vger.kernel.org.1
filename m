Return-Path: <netdev+bounces-40034-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E1557C57BA
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 17:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE7E31C20C57
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E67D1F93D;
	Wed, 11 Oct 2023 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="VdwpkbHu"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453D1D6A7
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 15:05:54 +0000 (UTC)
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7645692
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 08:05:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so12279887a12.1
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 08:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1697036751; x=1697641551; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1BJm74qDGr8hPNxinJoS6NxF4TurSw5N8tweZPzySSc=;
        b=VdwpkbHuzzdZnROVSx4Wy7JAsHtVaJOPgfUYTBsx+IR/RVxEVxmHxBSyqa3KkH4mB+
         guyKq6wyahWYv6MQN1Yt+c1SO4I1fAbCWjmRHy4gIDbGKas9AasH6mP6yaCAlb75Vn0p
         ZlK3PO2wI/Y9/Imr8G789j7jTVzU/EWqxLYc2K0tnFE5dNjP9Ko6wKec+ESGmZmWvhJ3
         B5JnTyJB4KNIPtpEYChCrNvYHYUKgMJXt0SWYH+rDboGDxTG6TwTD5uN9j1v84CE0zWM
         WFTgjQXMGdny6+hakJgogKxPVzgYYMuuB8S/qevFJYaL+CX2aKnqUMVsioV87n3HCiEh
         eaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697036751; x=1697641551;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1BJm74qDGr8hPNxinJoS6NxF4TurSw5N8tweZPzySSc=;
        b=MCD4Y8RNLPHIbfolF289WEQ7Pdqmzd95p6U80tn+J+gwAFyCeMrC8RZqpE0MrWBa82
         2quD5COyAOGhgwSN4l19hSOT4LOy2jR1EpIEsq3FR8skRD+osiyzJM6dquUOOND90+l7
         uS9k13VJMzuZ2X2zpsvI4QUSS5yoYajvb3MAloLWkeAaGEdfbHEkcdGTzYxgbk9Jg3gD
         ruxFCn62IaSgtAYBgkVSJMHRWDsAVznJ/0/iOkX/2uXfP5J1t7OprGyY6pB+lY+J99lP
         XfxHUbtJ5u66KeF6Me4/2JUiacFj7W0RWhp76Q3zGs4KkdhZU/154O0/iZX/Kp8gq6Y5
         0Yvw==
X-Gm-Message-State: AOJu0Yw772V4nyMlzSNpZOpWYB+2YR0ZKDvszuIx8bPad1aANpOxLwZS
	Th3vZ0PVJJGd4tsEHQXIUwT0NQ==
X-Google-Smtp-Source: AGHT+IFaVydb+lCseruWsgLjRVh4JE5AGAop0CJaRVWa8AfDE/0vxLiKIjdKDCV7Wkg5sHCiwnBheg==
X-Received: by 2002:a05:6402:541a:b0:53d:b2c8:6783 with SMTP id ev26-20020a056402541a00b0053db2c86783mr3011948edb.14.1697036750824;
        Wed, 11 Oct 2023 08:05:50 -0700 (PDT)
Received: from localhost (host-213-179-129-39.customer.m-online.net. [213.179.129.39])
        by smtp.gmail.com with ESMTPSA id c17-20020a056402121100b0052ff9bae873sm9026862edw.5.2023.10.11.08.05.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 08:05:50 -0700 (PDT)
Date: Wed, 11 Oct 2023 17:05:48 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, Ido Schimmel <idosch@nvidia.com>,
	mlxsw@nvidia.com
Subject: Re: [PATCH net-next] mlxsw: pci: Allocate skbs using GFP_KERNEL
 during initialization
Message-ID: <ZSa5zFyFdU4njwj4@nanopsycho>
References: <dfa6ed0926e045fe7c14f0894cc0c37fee81bf9d.1697034729.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dfa6ed0926e045fe7c14f0894cc0c37fee81bf9d.1697034729.git.petrm@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Wed, Oct 11, 2023 at 04:39:12PM CEST, petrm@nvidia.com wrote:
>From: Ido Schimmel <idosch@nvidia.com>
>
>The driver allocates skbs during initialization and during Rx
>processing. Take advantage of the fact that the former happens in
>process context and allocate the skbs using GFP_KERNEL to decrease the
>probability of allocation failure.
>
>Tested with CONFIG_DEBUG_ATOMIC_SLEEP=y.
>
>Signed-off-by: Ido Schimmel <idosch@nvidia.com>
>Reviewed-by: Petr Machata <petrm@nvidia.com>
>Signed-off-by: Petr Machata <petrm@nvidia.com>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

