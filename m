Return-Path: <netdev+bounces-67342-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E855842E2F
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 21:50:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E9801F263A4
	for <lists+netdev@lfdr.de>; Tue, 30 Jan 2024 20:50:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ABF79DD6;
	Tue, 30 Jan 2024 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X8udOTUB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62ACD71B25
	for <netdev@vger.kernel.org>; Tue, 30 Jan 2024 20:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706647825; cv=none; b=epSKvi23+IcCXV3ICuSq2oLI2CSmDaUooO2gwvi8W3FMGe1aCgxG6TOxADeY0udG033lrC46ioK31jEfLItxFo3YCi8tGIkVEi96SC5gRwAJdQP6OpHwMZsNYU1FFp/i5dNr2QCwmynpPNzCOFq5Zo+sX0BgfRdLC8odk/UQd8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706647825; c=relaxed/simple;
	bh=H5yc4OdrW7NtIT0YQmM733kSJc+G9XdlnEOX95JJlkY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LFDm3py8I4BIMaBqTv2DPaZh1O3HWNtiXSyQh8FqrelUo6aTqQ3VtJNYwVVKITqJnvbG2HW9wY5RxKk1o5wBbCFDnGMv0ADYxzMGtn5UDvQB5LtWe+21pBhghRtX1MkIvmk8NP13CnG+uio7+H8QtCD97ILNnlNUti/KrzeC2tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X8udOTUB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE712C43390;
	Tue, 30 Jan 2024 20:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706647824;
	bh=H5yc4OdrW7NtIT0YQmM733kSJc+G9XdlnEOX95JJlkY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=X8udOTUB9jekgOnhH9ibWEdswoR0jOaxigqDQUKW+R1kaNfWTl6/5w+4wX0lWV+Ss
	 jbX4MFUJCWAYPeWhlWXW5ncbiGEL2ptyPnlu0r888SxGS9JhiqkuEs+g/l6zhOdLL3
	 aF7p7leKz7bgtsnvEsZ2sIfNHl6PptSbxg4qpKfgIuqXVkB9HesYjxGpVBNeN3UJyE
	 LBVGjC7DXkuAOuSFRMgoW+SQ0m3pv8npVwzyTu4qgQukVVmgTc78a49HgiKSFE3+pH
	 PQ6f7hPij0opeMalQojeQu4Neyk8ItSrUIrJzsKP4jDBWkbGMQ8jmB7fUagDr4DfGW
	 TEGWxRjPFUX4Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C1A62C395F3;
	Tue, 30 Jan 2024 20:50:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2] ifstat: make load_info() more verbose on error
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170664782479.32692.1430763041693540494.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 20:50:24 +0000
References: <20240126100855.1004-1-dkirjanov@suse.de>
In-Reply-To: <20240126100855.1004-1-dkirjanov@suse.de>
To: Denis Kirjanov <kirjanov@gmail.com>
Cc: stephen@networkplumber.org, netdev@vger.kernel.org,
 denis.kirjanov@suse.com, dkirjanov@suse.de

Hello:

This patch was applied to iproute2/iproute2.git (main)
by Stephen Hemminger <stephen@networkplumber.org>:

On Fri, 26 Jan 2024 05:08:55 -0500 you wrote:
> From: Denis Kirjanov <denis.kirjanov@suse.com>
> 
> convert frprintf calls to perror() so the caller
> can see the reason of an error
> 
> Signed-off-by: Denis Kirjanov <dkirjanov@suse.de>
> 
> [...]

Here is the summary with links:
  - [iproute2] ifstat: make load_info() more verbose on error
    https://git.kernel.org/pub/scm/network/iproute2/iproute2.git/commit/?id=ddcc9329352a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



