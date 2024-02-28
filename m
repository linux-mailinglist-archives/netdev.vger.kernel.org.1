Return-Path: <netdev+bounces-75842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A73A986B532
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 17:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6043B28602A
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 16:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D307F6EF13;
	Wed, 28 Feb 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pIOHHClO"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6A26EEFA
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 16:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709138541; cv=none; b=J3qlTdPgmwgNsd/f45k6bgJhq0hFZ6D4R9/kO8L04AonJ2oXsMosQoe6Zf1o8C4ryuMXRltbOmEJbIyyDii+90OVFZs+ivq5BkLXScTPPWX3n7lMW4Jjq0/JDCnweI+pHl1A11isIt6flTnjlnlTE0zaTXorVNXOCIp5p9KqYss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709138541; c=relaxed/simple;
	bh=yCsqHiUDR6ywJ6GXVb2Qb1HJLoEYBSj+XtcNixDrrg0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjNEgyqeZve/hLXwamycU3GcG3+SXww6XoBFTesGfWZkcvdqkq5Z1iKXP+jcWvLahbB/LABHat2/jKbUZcP3Gom24LwpJ0PZmx/xeVgSTrIV8cBYx9edQD70b9DRidawBZxskBpDWq5DJRNKN/eo48nmZatIl0SsrImslAXZ+C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pIOHHClO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60E6C43390;
	Wed, 28 Feb 2024 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709138541;
	bh=yCsqHiUDR6ywJ6GXVb2Qb1HJLoEYBSj+XtcNixDrrg0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pIOHHClOqQQd7EX93rYs+bxnXrl+xBwLx0PmFRHMyEA3z+Qhe0X4H0Rf085ETpSrO
	 zBBj0dYpoCkHlvVzj5ycc8Wiyf91Nb7x38eN+09ppjwmLrDgvq7wstOcp1apHrWakP
	 NOZHLnTvaq4cv/3zII4e2j+iJ8PSlZ5l7rXvKoF6TloYzkfkonAJB4nJLzm584yGHe
	 852R/3fRDCuQEnqttSBV7JQq+sP7+Vgo/pStLX8VPiDmGm9yL9KDbUD5L2yl21Yvke
	 gockbk4iaM6+GEo9nXW6UuAqeHQshlFTIeSpj3TWXgpXa5Zs8EbsxFLPr+qcRTsfAi
	 bUBFS8XNkJdvw==
Date: Wed, 28 Feb 2024 08:42:20 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 <netdev@vger.kernel.org>, Ido Schimmel <idosch@nvidia.com>, David Ahern
 <dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: Re: [PATCH net-next 2/7] net: nexthop: Add NHA_OP_FLAGS
Message-ID: <20240228084220.14d2cf55@kernel.org>
In-Reply-To: <87le74o9pu.fsf@nvidia.com>
References: <cover.1709057158.git.petrm@nvidia.com>
	<4a99466c61566e562db940ea62905199757e7ef4.1709057158.git.petrm@nvidia.com>
	<20240227193458.38a79c56@kernel.org>
	<877cioq1c6.fsf@nvidia.com>
	<20240228064859.423a7c5e@kernel.org>
	<20240228071601.7117217c@kernel.org>
	<87le74o9pu.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 28 Feb 2024 16:58:24 +0100 Petr Machata wrote:
> Um, so as I said, I mostly figured let's use bitfield because of the
> validation. I really like how it's all part of the policy and there's no
> explicit checking code. So I'd keep it as it is.

FWIW the same validation is possible for bare unsigned types with
NLA_POLICY_MASK().

