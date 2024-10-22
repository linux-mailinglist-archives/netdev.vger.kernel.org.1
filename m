Return-Path: <netdev+bounces-137941-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95E709AB36D
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 18:09:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25F48B21A9F
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E86F1A3038;
	Tue, 22 Oct 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0RZ03gF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E0F19B5B4;
	Tue, 22 Oct 2024 16:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729613378; cv=none; b=ILLTT2ddMvqq8Rum5CDwuyozozYbi9jlO/KtOcvkYq2l0E30wRHNXU0rTsu10ENQ5hfjgG7+TLfzSz8jZ1JybytPjFka//CrbEb21MM2lqG1Q/qjeam3h7cUTOtvqry1YWSr2H2ZUOErYC0nLVTaCXFyHPWotRyMzS1nPLKrrIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729613378; c=relaxed/simple;
	bh=QnKoIYE9I5tM9ij/E5vo0HAHKj+Hq9JhRSkLc/kxH3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FsOL7P5JAQgOigf9POduHXN04Opbh4Mx23E73JVtwgmiehNqTk1ZiXgB6WAH+kdefub6io2Yl5t2cF8+Ibpar7wLksxJGRDMkcBF0i5jXzqZZ2ahs7NjGdjfnGBNgMV6lVFpXvx3CBKDqe11TqE4jkKzs6afDbhfR0ADbHAXH5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0RZ03gF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9D43C4CEC3;
	Tue, 22 Oct 2024 16:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729613377;
	bh=QnKoIYE9I5tM9ij/E5vo0HAHKj+Hq9JhRSkLc/kxH3M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=s0RZ03gFkurmzZ8vewcw+eUX3RlS8XIu9wwbIN0TpYNzmN4dJZmiw/LLOm4h/e80P
	 lrd+ep6qwJ5ZH73eQB45IfEA7Qab2IHBDXVbiy6dl/TVyJ+RPNT/5xZmidoj6He2fS
	 142I3p/f+ZrXZixSnnjESwaUHPt7uYF0FAY5QV/wiupto0ERfL0CabuDw+fTAkohiw
	 t+tM7Ov5Ch0yokhLnKuMIjrnUjsw96aWRlsDktQQpwTAPateGrAr1wYufTN/wiREKU
	 VDwX6NRjHqtfDTTjdWiIXkWLKkr8xPGprWsDxA5CwIR3rIW9LzuEJExZVJwkhn4d5w
	 tkB41809o6Gpw==
Date: Tue, 22 Oct 2024 17:09:33 +0100
From: Simon Horman <horms@kernel.org>
To: Johnny Park <pjohnny0508@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [net-next] igb: Fix spelling "intialize"->"initialize"
Message-ID: <20241022160933.GB402847@kernel.org>
References: <Zxc0HP27kcMwGyaa@Fantasy-Ubuntu>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zxc0HP27kcMwGyaa@Fantasy-Ubuntu>

On Mon, Oct 21, 2024 at 11:11:56PM -0600, Johnny Park wrote:
> Simple patch that fixes the spelling mistake "intialize" in igb_main.c
> 
> Signed-off-by: Johnny Park <pjohnny0508@gmail.com>

Thanks Johnny,

I agree this is correct. But I am wondering if you could also fix the
following around 3909. It seems to be the only other non false-positive
flagged by codespell in this file.

mor -> more

-- 
pw-bot: changes-requested

