Return-Path: <netdev+bounces-188404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7F4AACA86
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 18:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11C9F9814BD
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 477A728151F;
	Tue,  6 May 2025 16:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lMchMqTa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22109280008
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 16:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746547827; cv=none; b=T6U0XElp+KrXv+XOmaXwijDb3k+V4DuDbsbXCExIpWX5bygZ0mECtBACHoU8mQKJCPudcKlc9+9jCVIAe4crgBxRrkYKiCX+2//0usP1/0j1LSn7ldcTn0kLt0eCyuXMFvYACFcMSQIzUG+v5csLFyUjJ0ATRBcDT0g/TfjNIbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746547827; c=relaxed/simple;
	bh=AtKCwCVuEV0Gusl8CAwsHYTUfoN5JptWoFPq1OQboYY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=epf2dO6/QDD2x+cEAHMM6FfDSMhmDzOiU/uluKB8677GIGXLIkFPM8pQxH8Dk29mbj1uJb1JB6c3u6qJpOo5sXeYC9Ie9zHif15Xgb5FzAoQyDXnlAUR6HPKwhaoVk0FoHJ4P/JtuWJwwAmtb9G+2vRRJGgQ0bEx0EsAiPuwpE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lMchMqTa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A40CC4CEE4;
	Tue,  6 May 2025 16:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746547826;
	bh=AtKCwCVuEV0Gusl8CAwsHYTUfoN5JptWoFPq1OQboYY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lMchMqTao7K/ttz/tCCV5hK0JmIK1CMI9WTKrLYeFkVbrWInncipG8L26Atnr7kq3
	 gHRrvZT0f/d2hLizZvZF74pyNsYLCVCoi/0vlWx0t3hltgrHYrLUZMbmRaoRCoI3zm
	 dLJQcYocw3r97VH102MLdaAoshTAIey9XBqBvGR0BS7pjht4RGorHmDslkbpNYK5B6
	 vce63aG3q60cnnQsJYjmO+23pL5ov8zqN0xLbwHCSi8aig0+zyAkd/7u/FZOuOgp39
	 wvoUO5oNxFwFrvuS2PHjHi/A2VPDWxBi3fCUIOsq03jaixHc9UnQspmhWr87ItLTI8
	 YCMydFMvNWg6Q==
Date: Tue, 6 May 2025 09:10:25 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 johannes@sipsolutions.net, razor@blackwall.org
Subject: Re: [PATCH net-next 3/4] netlink: specs: remove implicit structs
 for SNMP counters
Message-ID: <20250506091025.6002377f@kernel.org>
In-Reply-To: <CAD4GDZyFM0uY9WPPw3DF1F+tsDU=0PwyA1yFvbxVxv3amyfu5g@mail.gmail.com>
References: <20250505170215.253672-1-kuba@kernel.org>
	<20250505170215.253672-4-kuba@kernel.org>
	<CAD4GDZyFM0uY9WPPw3DF1F+tsDU=0PwyA1yFvbxVxv3amyfu5g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 6 May 2025 13:50:44 +0100 Donald Hunter wrote:
> On Mon, 5 May 2025 at 18:02, Jakub Kicinski <kuba@kernel.org> wrote:
> >
> >          name: reasm-overlaps
> > -        type: u64
> >    - name: br-boolopt-multi
> >      type: struct
> >      header: linux/if_bridge.h  
> 
> The patch does not apply for me, I think due to the above line
> changing in another series.

Oh, my bad, the rt-link C info patch was hiding in my queue between
these and net-next. Will send v2 shortly.

