Return-Path: <netdev+bounces-27614-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9322777C8E4
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 09:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C48B61C20C5B
	for <lists+netdev@lfdr.de>; Tue, 15 Aug 2023 07:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86D09AD57;
	Tue, 15 Aug 2023 07:51:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A1953AC
	for <netdev@vger.kernel.org>; Tue, 15 Aug 2023 07:51:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F95BC433C7;
	Tue, 15 Aug 2023 07:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692085883;
	bh=5If4wHkHE6gT4dAKblRxKfzDv/qYoFi7OxoJ7u6cgrE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oxjLNr8RoUzNdtXurS4mBTVUtwPPHWzrklFkNZkMJKgDqMW9+oCRrc+pderdCfjiU
	 4vMcPHFgu5FI/MnJ5Xggx12V1gFx50bwt1GfwtFHRDGHKdPsaf2ySDtDSN1PWSSZm+
	 BxcKYGLug1zJYavwQtFv+3ajpD/U9QyDWjZXGYCUlJID5OUubQs8sP0tgpDDmrzRc2
	 Rak66ye6yQhNR/aoPeFeRxFJfbNiYAC7YVP5AWRWaw5ov46eAYgI98G+cwrJ7/lCVc
	 L6bNCh5HMP4EuA+wGXi/S9Rseoh4xgWyUkAsila9h/myHza+76xiseSoHyYsPdPnGh
	 gGb/VPyMAOJ4A==
Date: Tue, 15 Aug 2023 09:51:20 +0200
From: Simon Horman <horms@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <simon.horman@corigine.com>,
	Soheil Hassas Yeganeh <soheil@google.com>, netdev@vger.kernel.org,
	eric.dumazet@gmail.com
Subject: Re: [PATCH v3 net-next 00/15] inet: socket lock and data-races
 avoidance
Message-ID: <ZNsueHnNIKSKCXiL@vergenet.net>
References: <20230812093344.3561556-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230812093344.3561556-1-edumazet@google.com>

On Sat, Aug 12, 2023 at 09:33:29AM +0000, Eric Dumazet wrote:
> In this series, I converted 20 bits in "struct inet_sock" and made
> them truly atomic.
> 
> This allows to implement many IP_ socket options in a lockless
> fashion (no need to acquire socket lock), and fixes data-races
> that were showing up in various KCSAN reports.
> 
> I also took care of IP_TTL/IP_MINTTL, but left few other options
> for another series.
> 
> v3: fixed patch 7, feedback from build bot about ipvs set_mcast_loop()
> 
> v2: addressed a feedback from a build bot in patch 9 by removing
>  unused issk variable in mptcp_setsockopt_sol_ip_set_transparent()
>  Added Acked-by: tags from Soheil (thanks!)

For series,

Reviewed-by: Simon Horman <horms@kernel.org>


