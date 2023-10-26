Return-Path: <netdev+bounces-44389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC767D7C67
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 07:44:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 854C1281E17
	for <lists+netdev@lfdr.de>; Thu, 26 Oct 2023 05:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAA2C8E8;
	Thu, 26 Oct 2023 05:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="cZP+K4zw"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F075FF9E8
	for <netdev@vger.kernel.org>; Thu, 26 Oct 2023 05:44:16 +0000 (UTC)
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A3491B8
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 22:44:13 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-9be7e3fa1daso75772466b.3
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 22:44:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1698299051; x=1698903851; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+OJUnu5Xyo6qiAk3lOeHEj7Khwzl6sk3V/Pa66za9zA=;
        b=cZP+K4zwdlDJxQ20ukz4ZCO7pPY9CwNn85CUtpXg1+DEAP+G2kmvYpxTW844KV9o3E
         JKmyF9kzA+gkk1yjvW6NX4LbR6hvSmSEG/BH65tRWyNHjJUm+vqSxkxUugDQMVv2TFKB
         fiexzvy7hBAXqprBMd4czLTl6j6EXRGnAN8HoyXKvRkz9mO86C0trkwb6ESZAKeh3slq
         4p6hSrr8Q1exGRXiCSWbOvUPsatwv4zcYEa0nn4QVJMU3fbRvtoELhWH6KhMTbhaW0I8
         bEz6xQKYrNYyyNg3+UEht8qlWz2HOHxuRxj6OAGG/x2L6R0iC3qHV7AzH/ZZfEoQp2fs
         Ugfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698299051; x=1698903851;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+OJUnu5Xyo6qiAk3lOeHEj7Khwzl6sk3V/Pa66za9zA=;
        b=TokGdoXwY4bx2EJNxTkUPGQszF8eVHSrmVNOVCHfV5S2V9WopXsqsL4Hmy/62S5CYf
         4AMNsAhS39TOdDheq1qeqM5SIFYLkSRYb6tNknwyqRtUWyb2alhv6kbN2L2L8vp/qH8F
         thDWX3Q9O75ezefPkYJYeTsJ+IttE4vmuKNfH7TAaw1+p3xDHSpbeZ1isN4EMHWPPrK6
         h1yHZnYeqb2wAlUcjoAMY69YcezVrP8FU4nmNcEfyeqZ8PGBHsoPTaFBWn+bJmDyOfMC
         uzf2n/DRqs2gupGY7HXo17oIk8ydTHPK2tQBQQnyPUJSsTol/uQIxHCdwZUXJc9an1p+
         jhgg==
X-Gm-Message-State: AOJu0Yyx1Rp9ydIoE/Y46n75qW/IYmEAuWnrYB9k5n2Wq2A7MFWpddkZ
	V3C0EX2BsUzvlvmoE23t4g0m7w==
X-Google-Smtp-Source: AGHT+IEMK+qpYHIw/wHituk5Yf/BG6b9mYwY9jed4nys7qOGnBYi4oDetXp9z8Gd4C8zc1c9u0fdXA==
X-Received: by 2002:a17:907:9306:b0:9be:b43c:38db with SMTP id bu6-20020a170907930600b009beb43c38dbmr13183863ejc.5.1698299051236;
        Wed, 25 Oct 2023 22:44:11 -0700 (PDT)
Received: from localhost ([80.95.114.184])
        by smtp.gmail.com with ESMTPSA id lh22-20020a170906f8d600b0099290e2c163sm10869118ejb.204.2023.10.25.22.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Oct 2023 22:44:10 -0700 (PDT)
Date: Thu, 26 Oct 2023 07:44:05 +0200
From: Jiri Pirko <jiri@resnulli.us>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, j.vosburgh@gmail.com, andy@greyhouse.net,
	dsahern@kernel.org, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
	vinicius.gomes@intel.com, johannes@sipsolutions.net,
	razor@blackwall.org, idosch@nvidia.com,
	linux-wireless@vger.kernel.org
Subject: Re: [PATCH net-next] netlink: make range pointers in policies const
Message-ID: <ZTn8pUiInbowFf+y@nanopsycho>
References: <20231025162204.132528-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025162204.132528-1-kuba@kernel.org>

Wed, Oct 25, 2023 at 06:22:04PM CEST, kuba@kernel.org wrote:
>struct nla_policy is usually constant itself, but unless
>we make the ranges inside constant we won't be able to
>make range structs const. The ranges are not modified
>by the core.
>
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Reviewed-by: Jiri Pirko <jiri@nvidia.com>

