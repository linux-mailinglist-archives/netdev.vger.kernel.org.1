Return-Path: <netdev+bounces-234210-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15980C1DDE6
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 01:10:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 156D84E5333
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2B541C69;
	Thu, 30 Oct 2025 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qGr4wvLN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C1954918
	for <netdev@vger.kernel.org>; Thu, 30 Oct 2025 00:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761783031; cv=none; b=miGi4Wv5l9KrEqmOL3MrxAgdrBNL6zknNDRnDtiY/+4akF2o1aKAFRi7HSB5wq+6m83WisrvE1BMmsEB30brM9HTkSGVTDAWN/sam1y1SbJdazsnDjXiKokNpJSi+xOMNjvWOn4ZKluOYmYVGTnsCPZgRn63UQ7SdE9YwI6NZFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761783031; c=relaxed/simple;
	bh=j8BloVzCbti3UrGusToMcyChK88tb27xUchyVvvilCU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GTjS9eB6WHuU+eXpsbXauISw74Iekydkp4TVSOBEM6O4m9dw2Rd2w2fh+jCl7A3frKLSEVlWS1OpAbX2NSC44M+8ri+b5bArqBo0ZkTORKreWArODztUWpBOI/JZslswo+EyvUFU7jykrlLgsjMtaq4RarX29+fNhScr8EoW4tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qGr4wvLN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0A76C4CEF7;
	Thu, 30 Oct 2025 00:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761783031;
	bh=j8BloVzCbti3UrGusToMcyChK88tb27xUchyVvvilCU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qGr4wvLNJzru3Pr83A3DpyEbf3zAXfhKPJthA/lnXw32XyRpXgFjee2AMXL75GpmA
	 EqlCBQFflxLs76YgapsNgM5wyoEVACVywM/cuzJwYIULuJgjqkxpfzIex/ZUWMbk0A
	 guB+Y5Iy/HnF3SkhWG1d9KcztnfFPhScDHlzM4jj+Gj0uIXK88U2ueN2SNOe8Gc5nY
	 U7U/TYHlpgOVdmkd13OZONr2OBtaf1J1bo0cof+Cj3fPQAkNxGCmQxrhDHngs40hH/
	 W/sLD+92MFjSI6zClNk+9f+1LSRAubKEAB/e6ILEVioqGJATbH1au+cdYwo99EdEYA
	 8pLNNNO8tDhkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33E783A55EC2;
	Thu, 30 Oct 2025 00:10:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] netshaper: fix build failure
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176178300801.3257162.15037543733182121742.git-patchwork-notify@kernel.org>
Date: Thu, 30 Oct 2025 00:10:08 +0000
References: 
 <bda34400c9bdddd48e15526f9a8e203b1a849e45.1761689740.git.aclaudi@redhat.com>
In-Reply-To: 
 <bda34400c9bdddd48e15526f9a8e203b1a849e45.1761689740.git.aclaudi@redhat.com>
To: Andrea Claudi <aclaudi@redhat.com>
Cc: netdev@vger.kernel.org, ernis@linux.microsoft.com,
 stephen@networkplumber.org, dsahern@kernel.org

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Tue, 28 Oct 2025 23:17:56 +0100 you wrote:
> netshaper fails to build from sources with this error:
> 
> $ make
> netshaper
>     CC       netshaper.o
>     LINK     netshaper
> /usr/bin/ld: ../lib/libutil.a(utils_math.o): in function `get_rate':
> utils_math.c:(.text+0x97): undefined reference to `floor'
> /usr/bin/ld: ../lib/libutil.a(utils_math.o): in function `get_size64':
> utils_math.c:(.text+0x2a8): undefined reference to `floor'
> collect2: error: ld returned 1 exit status
> make[1]: *** [Makefile:10: netshaper] Error 1
> make: *** [Makefile:81: all] Error 2
> 
> [...]

Here is the summary with links:
  - [iproute2] netshaper: fix build failure
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ca756f36a0c6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



