Return-Path: <netdev+bounces-53743-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 251B0804543
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 03:44:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5CB71F21DD1
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 02:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE3E803;
	Tue,  5 Dec 2023 02:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D92fC8RR"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E06CD2F8
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 02:44:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C401C433CD;
	Tue,  5 Dec 2023 02:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701744248;
	bh=+vaehnyGBwsYfA73YriN0Q6j6b8ok5Vd+IkndBBTTDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D92fC8RR1BS7la11RrCDi0nvg78+QgLm8aN6rcwqMdkzkF9tOYxB34GalxyQ/nXB0
	 lDKmGQSFQGg2H0py5nNdVw245XRn5AtiYVI3s/BLYzChBaeBKsBJh2c9hW1ivX70eT
	 dOqjEU7+hNMA1psrs+KCpXDF6wLux/m6nV5CnUp8gpyVp9yEEzMhdZlsa8a3++St4w
	 wqntoU8i0FE4I6um4Ba0fhKAWmS31LhHlyEnVxGZGtGw8mYFFSnhCKyNsduaVADGSo
	 q5mR+TM66fMDsWGVOg/xj6VTTuUYrq/mqMprFL7kiKcBUcBcnxFKd551auOgPksgDF
	 Y0BxOA0l0dm8g==
Date: Mon, 4 Dec 2023 18:44:06 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Min Li <lnimi@hotmail.com>
Cc: richardcochran@gmail.com, lee@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, Min Li <min.li.xe@renesas.com>
Subject: Re: [PATCH net-next v6 3/6] ptp: clockmatrix: Fix u8 -> u16,
 DPLL_WF_TIMER and DPLL_WP_TIMER are 2-byte registers
Message-ID: <20231204184406.4c154e28@kernel.org>
In-Reply-To: <PH7PR03MB70643CB46D5BA34397181500A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
References: <20231130184634.22577-1-lnimi@hotmail.com>
	<PH7PR03MB70643CB46D5BA34397181500A082A@PH7PR03MB7064.namprd03.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Nov 2023 13:46:31 -0500 Min Li wrote:
> Subject: [PATCH net-next v6 3/6] ptp: clockmatrix: Fix u8 -> u16, DPLL_WF_TIMER and DPLL_WP_TIMER are 2-byte registers

> From: Min Li <min.li.xe@renesas.com>

Thanks for the changes, much easier to review now.
This patch, however, should be squashed with the previous one.

