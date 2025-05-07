Return-Path: <netdev+bounces-188517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 650DAAAD2C5
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 03:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A01CD985FBF
	for <lists+netdev@lfdr.de>; Wed,  7 May 2025 01:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBCF14B08A;
	Wed,  7 May 2025 01:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGB1yjcW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB6613C82E
	for <netdev@vger.kernel.org>; Wed,  7 May 2025 01:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746580947; cv=none; b=VGngX450m1hNkXe/m4fLgo3+cfhhH3vI3Hki1RJb5FL1FpoQ1AMr1A5Xgflp9DWbtmKcHSqIbLUFBzws+oZ1YMtwwpTuiIS+TqeeLrelAVHMJSaQDN4RIFD4PiZVsEDApnjX1reyRUaMPRgdeCztMiXkvEnd1rEEPB7hLeuPfZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746580947; c=relaxed/simple;
	bh=zh2ArE0ny7JMMIi5iAr+i39WQ0nj5xlSu9vNDtm1spE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jUpp/t19La5463UHbcxAMq+nuuVVo/byQuguBueHUL6Un5lqjrpcnebK33lvfS80CGeQGXvJhz5Oqd6OACcSoBlxEzmOUw1MpB03DpeiIqjv9sHoU36u31nB8zSjc+AYD9fvhNLgvhkNmHsAfRQt5XzGjTRyQeqnWe1AWXKQI2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGB1yjcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13B2FC4CEE4;
	Wed,  7 May 2025 01:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746580946;
	bh=zh2ArE0ny7JMMIi5iAr+i39WQ0nj5xlSu9vNDtm1spE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lGB1yjcWUa+NjYeT66lowq7buceOZbgn57sVzjY4BsV2mtWQtB+CejjL1Aj/FBmRn
	 HmGZ4/KgANkp6cXE0lO6JBIc0K5OXWdi77LdaejmVibcXl0KjV7QaAMwNNlm3BZYue
	 kLowdGksoenz7UHEZCnzuvQEMPzWShOWBCs3XzBXp27m4gtKxhphv/JAqcIKWYRMmm
	 ZH8+EEMmjPRvMn7V+5gDG39umSHvy8DmnYFGXAEl+owctZEnxxbvoiZO6fRCChn3lh
	 8B35RdrYkWdet80QuMWLP3wsu58cnDVZ6irmDxh3XphbdbXbOGCjZI1LyJJPUvCtGL
	 p6DB89Gqg/bHQ==
Date: Tue, 6 May 2025 18:22:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, saeedm@nvidia.com, horms@kernel.org,
 donald.hunter@gmail.com
Subject: Re: [PATCH net-next v2 1/4] tools: ynl-gen: allow noncontiguous
 enums
Message-ID: <20250506182225.531a036e@kernel.org>
In-Reply-To: <5mgfrsapfnljlminy67o2wnz3iwh3mqba7fazt4ku2v6xh5t4g@nwgn3rdndvng>
References: <20250505114513.53370-1-jiri@resnulli.us>
	<20250505114513.53370-2-jiri@resnulli.us>
	<5mgfrsapfnljlminy67o2wnz3iwh3mqba7fazt4ku2v6xh5t4g@nwgn3rdndvng>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 May 2025 08:38:36 +0200 Jiri Pirko wrote:
> Mon, May 05, 2025 at 01:45:10PM +0200, jiri@resnulli.us wrote:
> >From: Jiri Pirko <jiri@nvidia.com>
> >
> >in case the enum has holes, instead of hard stop, generate a validation
> >callback to check valid enum values.
> >
> >signed-off-by: jiri pirko <jiri@nvidia.com>  
> 
> By some accident I managed to remove uppercases from this line. Should I
> repost or would you fix this during apply in case there are no changes
> requested?

No worries, I don't think it's a big deal as long as the email matches.
But I'll fix when applying.

