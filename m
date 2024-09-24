Return-Path: <netdev+bounces-129539-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D387D9845F4
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 14:32:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103641C20B45
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69D6C1A76BD;
	Tue, 24 Sep 2024 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YD0G88K9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4155E1E492;
	Tue, 24 Sep 2024 12:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727181108; cv=none; b=NlUOt5H1m0+8MitXz2QTXeq02gK1TQll/O7KB2f7J1pnV289qeNv9/N2pXGlvPuUjRTqGJW+z6fQseY3gPI24iqcRQ2KETx7a0PddXb9ohlVXrwiomwsQw/q9tgFboWa6btS3GQ51c/+v5aESTbnP+49vdeJezTT8pgO9xVmqi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727181108; c=relaxed/simple;
	bh=g8aaOdojl9wJAyDfLFOxLuTqW+adZpTeXT6liAy2CsY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ce2UsPFDAXmA0KSvyWUVNr+AyUAe0T53lZ+6hpExD5C2XyInJuSSkPiJqm4rIokTQoUZkuxaz4IHNCMcmbTMO+7ITiTtmsF6oBT6p80TKewtONekaGFPr3invRgT4mglA5IFZqe8Ou6R9e3WI5e89WvjgMeX5QHKuzLumKpyJME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YD0G88K9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C65C4CEC6;
	Tue, 24 Sep 2024 12:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727181108;
	bh=g8aaOdojl9wJAyDfLFOxLuTqW+adZpTeXT6liAy2CsY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YD0G88K9ajZ+pZpMAN4TZdscadEFMbWpzmNhjz+PfKJmgJNjEoUH1Wz2/U2Xz0GfL
	 IaKxoyJxJqIHspwlEZD2sERjwJVwPB0TQooZ13B4GJlrXWN7kVT1Vn7FJfPGpfXvhk
	 cjqhogql7UgWm+hTPpaazzny3Fea/w9cba1kWKa1l3V1rFkFylkebfHZoYOhe/0ksj
	 EDGrkm6MeVz5tgsX4HSWdGdY69f8aFYXdVtHCplnUdUYbWtNgJgeA5Bqs1q/anGbAU
	 EDwcDxccNQwTtQc86LBWtsJHZqepL9UuhiSu7he+ZesQvyXfxGUGeXYALvTtVOaSDy
	 kTEonLYW0vs+A==
Date: Tue, 24 Sep 2024 13:31:44 +0100
From: Simon Horman <horms@kernel.org>
To: Shen Lichuan <shenlichuan@vivo.com>
Cc: isdn@linux-pingi.de, quic_jjohnson@quicinc.com, kuba@kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	opensource.kernel@vivo.com
Subject: Re: [PATCH v1] isdn: mISDN: Correct typos in multiple comments
 across various files
Message-ID: <20240924123144.GH4029621@kernel.org>
References: <20240924091117.8137-1-shenlichuan@vivo.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240924091117.8137-1-shenlichuan@vivo.com>

On Tue, Sep 24, 2024 at 05:11:17PM +0800, Shen Lichuan wrote:
> Fixed some confusing spelling errors that were currently identified,
> the details are as follows:
> 
> -in the code comments:
> 	netjet.c: 382:		overun		==> overrun
> 	w6692.c: 776:		reqest		==> request
> 	dsp_audio.c: 208:	tabels		==> tables
> 	dsp_cmx.c: 575:		suppoted	==> supported
> 	hwchannel.c: 369:	imediately	==> immediately
> 
> Signed-off-by: Shen Lichuan <shenlichuan@vivo.com>
> ---
>  drivers/isdn/hardware/mISDN/netjet.c | 2 +-
>  drivers/isdn/hardware/mISDN/w6692.c  | 2 +-
>  drivers/isdn/mISDN/dsp_audio.c       | 2 +-
>  drivers/isdn/mISDN/dsp_cmx.c         | 2 +-
>  drivers/isdn/mISDN/hwchannel.c       | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Hi Shen,

Thanks for your patch.

Running codespell over the files modified by this patch indicates
that the following spelling errors remain, I'd suggest addressing them
too.

drivers/isdn/hardware/mISDN/w6692.c:861: oscilator ==> oscillator
drivers/isdn/mISDN/dsp_audio.c:181: aplitude ==> amplitude, aptitude
drivers/isdn/mISDN/dsp_cmx.c:2: conferrencing ==> conferencing

Or perhaps consider extending spelling fixes to cover all files under
drivers/isdn/mISDN and drivers/isdn/hardware/mISDN. There seem to be a lot,
so if so might consider one patch per sub-directory or something like that
to break things up a bit.


On process:

It is my understanding that patches for drivers/isdn are handled by
the netdev maintainers. That is non-bug fixes go into net-next,
and bug fixes go into net. In this case it is not a but fix, so
the patch should be targeted at net-next, like this.

	Subject: [PATCH net-next v2] ...

Currently net-next is closed for the v6.12 merge window.
It should reopen after v6.12-rc1 has been released,
which I expect to take place a little under a week from now.

Other than RFCs, patches shouldn't be posted for net-next while it is
closed. So please repost your patch, or post an updated patch once
it reopens.

You can find out more about the development process for the Networking
subsystem here: https://docs.kernel.org/process/maintainer-netdev.html

...

-- 
pw-bot: defer

