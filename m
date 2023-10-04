Return-Path: <netdev+bounces-38080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 286FC7B8E3A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 22:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 5571E1C208F2
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 20:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD16D224E2;
	Wed,  4 Oct 2023 20:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="atmaCxJF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB1721BDD2;
	Wed,  4 Oct 2023 20:41:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 650C3C433C8;
	Wed,  4 Oct 2023 20:41:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696452068;
	bh=72lPpExPa7/l8tL0qUn7j7l+TWc7n+AL+YkQK0hH4Rs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=atmaCxJFjkuoGabbdB9Yr5oZJNjn/Bdzqi3HITjYF6aqnSMDpHMH5bfp99hp4hu9S
	 ZLej3ZVqDIlgcOCVWEh/z1TfL0JlJy7ejY/tVkUEWh1lkzML859fY26D21NbzrJ6oS
	 mZcJ+vs7HWLQWYMCkiilFAeuUE/i91yUMQRGVUSmATPRArfZ/68UMXOIcLCjXFgITR
	 wVUTJ633op4v50sGt+9IYH/R3RFQhOsfrKs39O9GDD2IyBBuYeIH5PxlHeeAI3bdao
	 DlShNOOgHT0wJGGHJbTENeMzo8Da3kPKTYi2A+7IvcTnZxvavLahGW7enZIs7mVro3
	 9tzhl8wqhc7fQ==
Date: Wed, 4 Oct 2023 13:41:06 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Cc: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
 <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
 <conor+dt@kernel.org>, <michal.simek@amd.com>, <linux@armlinux.org.uk>,
 <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <git@amd.com>, "Sarath Babu Naidu
 Gaddam" <sarath.babu.naidu.gaddam@amd.com>
Subject: Re: [PATCH net-next v7 2/3] net: axienet: Preparatory changes for
 dmaengine support
Message-ID: <20231004134106.7779c29c@kernel.org>
In-Reply-To: <1695843151-1919509-3-git-send-email-radhey.shyam.pandey@amd.com>
References: <1695843151-1919509-1-git-send-email-radhey.shyam.pandey@amd.com>
	<1695843151-1919509-3-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 Sep 2023 01:02:30 +0530 Radhey Shyam Pandey wrote:
>   */
> -static int axienet_open(struct net_device *ndev)
> +

nit: spurious new line

> +static inline int axienet_init_legacy_dma(struct net_device *ndev)

nit: no need for the inline, it has one caller and isn't on the fast
path


