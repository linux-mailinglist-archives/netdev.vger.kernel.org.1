Return-Path: <netdev+bounces-114782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B6F0E9440E9
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 04:21:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72D1A283C25
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 02:21:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E434313A256;
	Thu,  1 Aug 2024 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JG4zqFyi"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF49D13A253
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 01:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722477312; cv=none; b=QzCXBCBqIrMCbq3j3GcF34u7SmV5qm3XF87i57sCOHmd08eING0Cp4dNwK4qQVwwisn1O3liU5gjYEgpDTyOZsCgf6++Mi9SPcvR3CjG5X6X+cvqCjaNi6oasCOh6ezJ0K/uUDCE+YwGwTHVeyn5AGJu7jKwk5Jiyq3qxLq2Vpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722477312; c=relaxed/simple;
	bh=+xe7UZEbvk5jH0emkNEWG2Q88Ul8OwU0VQoLZT30Vlo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSKfj39LfK+7u/1PuWvKztrHkaWTCvdAXfB/7iV/31FuatmVjmtJkGrRQI4QxP11ZAInUoUa84vXhqInggmGCiVg759eRzASj1PXtNCkebJPpgO80V5oeZg2YVDNsakMdSKe3DvbRRO9eqxUsZQaQGAGns14L+ZXvFm6YhFqSLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JG4zqFyi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F256FC116B1;
	Thu,  1 Aug 2024 01:55:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722477312;
	bh=+xe7UZEbvk5jH0emkNEWG2Q88Ul8OwU0VQoLZT30Vlo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=JG4zqFyi0NyHiPbKBVsouk+lahdLc28MPTLg8gmo2Tlkd5a4JmyM9SX/b7VRV1Rzj
	 3iJbmUwKNqh7h22VauDdmiO6Z8JmOdU/OdU294C3wlvOEu09QeQaxPCkRcehbKcSl+
	 q+JDGfACiYVlR2Kx7Tm1ShkodtAVgUDZxiEOv3fLfT1//mr28+iZKHq0DRmvhlqicM
	 B7ClUZXlTZAaNHwGU9Te8pSAAwLhyM3Cl3ujFpmYzgVYPp6Fbb1Ak8+BwfKCdAwGqn
	 H+MgeIHDpvP0pdpw3kj6JWQhhjABllANTelMSS+/2yihLqWP6eK76AGK98JkZW8Gdv
	 CqfCdK6UVU9aA==
Date: Wed, 31 Jul 2024 18:55:11 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, Madhu Chittim
 <madhu.chittim@intel.com>, Sridhar Samudrala <sridhar.samudrala@intel.com>,
 Simon Horman <horms@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Sunil Kovvuri Goutham <sgoutham@marvell.com>, Jamal Hadi Salim
 <jhs@mojatatu.com>
Subject: Re: [PATCH v3 08/12] testing: net-drv: add basic shaper test
Message-ID: <20240731185511.672d15ae@kernel.org>
In-Reply-To: <29a85a62-439c-4716-abd8-a9dd8ed9e60c@redhat.com>
References: <cover.1722357745.git.pabeni@redhat.com>
	<75fbd18f79badee2ba4303e48ce0e7922e5421d1.1722357745.git.pabeni@redhat.com>
	<29a85a62-439c-4716-abd8-a9dd8ed9e60c@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 31 Jul 2024 09:52:38 +0200 Paolo Abeni wrote:
> On 7/30/24 22:39, Paolo Abeni wrote:
> > Leverage a basic/dummy netdevsim implementation to do functional
> > coverage for NL interface.
> > 
> > Signed-off-by: Paolo Abeni <pabeni@redhat.com>  
> 
> FTR, it looks like the CI build went wild around this patch, but the 
> failures look unrelated to the actual changes here. i.e.:
> 
> https://netdev.bots.linux.dev/static/nipa/875223/13747883/build_clang/stderr

Could you dig deeper?

The scripts are doing incremental builds, and changes to Kconfig
confuse them. You should be able to run the build script as a normal
bash script, directly, it only needs a small handful of exported
env variables.

I have been trying to massage this for a while, my last change is:
https://github.com/linux-netdev/nipa/commit/5bcb890cbfecd3c1727cec2f026360646a4afc62


