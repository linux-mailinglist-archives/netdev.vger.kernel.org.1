Return-Path: <netdev+bounces-35747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C2517AAE6D
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 11:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 0A9211F22733
	for <lists+netdev@lfdr.de>; Fri, 22 Sep 2023 09:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1792F1E51E;
	Fri, 22 Sep 2023 09:41:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EF31E518
	for <netdev@vger.kernel.org>; Fri, 22 Sep 2023 09:41:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57AC1C433C8;
	Fri, 22 Sep 2023 09:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695375716;
	bh=707q8KlBrRGVzyK7ourpz6f5DIZ+NIPge1U57ZXA3Pg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qxnHK/AljLoxCzLaH+Gw/L4MAOXFf/eWvO/SbiJj6c/ektV0+m67vGpENhCyLBoqq
	 G0sFFTmuXGEYTj3cWnOCPeOVy4BJMI8RicfkERtqbYD+FJ7gCMhO60QyNpyrd170Ds
	 JvfkMIwx3r3h6ji/rvyseqiwQ3Ls4yX/1Rye3lYoRBFZdZuaZFMTc50K9qoYCDOEwA
	 +53E4/Fst/UbYuuUrzq8XcviALVWvBaklJyODOJ3MEtFjYHDtTtM/rGnnQuQRhgNKn
	 QFKijM1NirLUIfto5cttSKDdtUm819jPu9qaVuF2Pc6vaf+AJWs2jm1EAvLvd2WLrs
	 IEqWiDfRtcKOA==
Date: Fri, 22 Sep 2023 10:41:51 +0100
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, eric.dumazet@gmail.com
Subject: Re: [PATCH v2 net-next 0/3] net: use DEV_STATS_xxx() helpers in
 virtio_net and l2tp_eth
Message-ID: <20230922094151.GX224399@kernel.org>
References: <20230921085218.954120-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921085218.954120-1-edumazet@google.com>

On Thu, Sep 21, 2023 at 08:52:15AM +0000, Eric Dumazet wrote:
> Inspired by another (minor) KCSAN syzbot report.
> Both virtio_net and l2tp_eth can use DEV_STATS_xxx() helpers.
> 
> v2: removed unused @priv variable (Simon, kernel build bot)
> 
> Eric Dumazet (3):
>   net: add DEV_STATS_READ() helper
>   virtio_net: avoid data-races on dev->stats fields
>   net: l2tp_eth: use generic dev->stats fields

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


