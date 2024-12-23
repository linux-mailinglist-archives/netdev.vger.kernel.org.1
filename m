Return-Path: <netdev+bounces-154080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7840D9FB3CE
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 19:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD1B31884708
	for <lists+netdev@lfdr.de>; Mon, 23 Dec 2024 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B041B413F;
	Mon, 23 Dec 2024 18:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWwoZi6T"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8118A6B7
	for <netdev@vger.kernel.org>; Mon, 23 Dec 2024 18:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734977397; cv=none; b=awpaNLgueHCmN6YlliQRGnU8PHI1gyzgwr/cPLCBri1mCSBBPt2N51vv9HtNykM05pdNDhTX6ymuuA7GpicjDUlp2ok0U57xm4Qz1ID5trhfslUPjt1TL62/gH2MSb6iurVjgS1MtNJr7SouUAPMycDAYlYIZPJyZY5ua+a9Po8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734977397; c=relaxed/simple;
	bh=pjZhKzXGsYCPsre37aUX5Mw489Y91oc0gdy6BDJrfo4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIEjf0iHqe29DUZWJ/nxXbylK9+O6e0dz2H/JpJBQAwwku3eritIVdfwAYM40Lh3rzJoN+Giyh5iSPSEi/6q3R2DGl37JJkdNLuMs4aLknL0Mwz1vzmSZ4G4Sr/crO9XIopMKVvlkaSA4TEhdcrcX8ICC0zbdwwcW/6NkO28/Nw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWwoZi6T; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0689EC4CED3;
	Mon, 23 Dec 2024 18:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734977396;
	bh=pjZhKzXGsYCPsre37aUX5Mw489Y91oc0gdy6BDJrfo4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TWwoZi6TpB7aiZ1RkYLcUwgZEss9rsOjbcZZ2cLwHX5qeDREybICqy2aqxngCVbuU
	 JKNtwgSXbeGVSYi8IV/wFmdBX5Ej7G/cqa3ZSjZOIXeaBhzj2HcTRlllxyYt2t32Jd
	 vuEv5zi8URuSauAWwBTDAZew74rXnlJ/CC11us9BQt1h1xeJUnGOP4sEyZ7B0Bk3xJ
	 sxZCqmubXoVBkjIIty4r9OSqEKSUlu+RB3POw6cFMI6Wrj+yZyK4cEb0qp3VhvBJf5
	 gP9QsjukeQLFDNBLbkfBj/Fo1xwowYWzjtm8ddvgPJlQDdH0uHJkJegCwEZHphOqn/
	 lcfMwtiRtxrFg==
Date: Mon, 23 Dec 2024 10:09:55 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Parav Pandit <parav@nvidia.com>
Cc: <netdev@vger.kernel.org>, <jiri@resnulli.us>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>, Shay Drory
 <shayd@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Jiri Pirko
 <jiri@nvidia.com>
Subject: Re: [PATCH net-next] devlink: Improve the port attributes
 description
Message-ID: <20241223100955.54ceca21@kernel.org>
In-Reply-To: <20241219150158.906064-1-parav@nvidia.com>
References: <20241219150158.906064-1-parav@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 19 Dec 2024 17:01:58 +0200 Parav Pandit wrote:
> Improve the description of devlink port attributes PF, VF and SF
> numbers.

Please provide more context. It's not obvious why you remove PF from
descriptions but not VF or SF.
-- 
pw-bot: cr

