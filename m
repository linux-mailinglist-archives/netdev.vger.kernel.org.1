Return-Path: <netdev+bounces-78699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ABEB87631D
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 12:22:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8D41C21398
	for <lists+netdev@lfdr.de>; Fri,  8 Mar 2024 11:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEE155C27;
	Fri,  8 Mar 2024 11:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jw9K70Fv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE485576D
	for <netdev@vger.kernel.org>; Fri,  8 Mar 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896830; cv=none; b=aXgQ1NUMkvk/V0oN9vpqCGdji6thsyWnuoNioQyHqzW/RFZxkp+7QRzBfmUIezBAf1hGBBkXaxgBbZHKxv7ZO8tka6IHhX4ZJvGJrwU0RuOq6kRIZ6JafFHjcbVAVJR594yfNjxaFNvaSaoOR3tS69gkoVcSL3UINPzPMLjppVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896830; c=relaxed/simple;
	bh=w8tbi5G3+Tm2nN59lymGWACGuWixAxi0KbhS93w6sLk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nz7eicg9i1/ZcmlFyGd9lnip+RJmUWhUJxCSr44cLy65RYp5figWt/qquKYxzyjJqJy2Ho6TnSlaywlqZyz/vA6To+CQCKPggf1s3WNuF37TygBVaQyBjyMrPW2NxB6t1CBAQRpbKXUDLplnhK8C54LsUQaQ1b8F8CLGUo37QGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jw9K70Fv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C440C43394;
	Fri,  8 Mar 2024 11:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709896829;
	bh=w8tbi5G3+Tm2nN59lymGWACGuWixAxi0KbhS93w6sLk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jw9K70FvLySORmjCLH27A7PRUuAALcwelVuytOrEiNLvZNrKqpNwMiktv45gttDNJ
	 bwZY9mGcUrdyGWRboYXJFtrVTBxq+J/MyVr7G+jZQzbNIWFGTEjG7r/a0iX5Jj/mzv
	 Q5GUtOFgOIz4MS/ENz4GNrnq9IemRXfmcTjjjXvpXEqKwlUybhtCkrQW6nT2omcETk
	 66DIbj2o6uwW8yjoVvlI6K3RgpI1c21b5DVUCFo3zzUkYm7ckIfpqmfJi3P212lKde
	 9Zn3d37Soezsj2miTRUFoeZiP5hSObQ49tLAdqIiK0WNI3Cg8rWANcI+uFSsd9jv4v
	 APLGHdLrc/etg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 60B75D84BBF;
	Fri,  8 Mar 2024 11:20:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [patch net] dpll: fix dpll_xa_ref_*_del() for multiple registrations
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170989682939.10075.17604591057572794457.git-patchwork-notify@kernel.org>
Date: Fri, 08 Mar 2024 11:20:29 +0000
References: <20240306151240.1464884-1-jiri@resnulli.us>
In-Reply-To: <20240306151240.1464884-1-jiri@resnulli.us>
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, arkadiusz.kubalewski@intel.com,
 vadim.fedorenko@linux.dev, milena.olech@intel.com, rrameshbabu@nvidia.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Wed,  6 Mar 2024 16:12:40 +0100 you wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently, if there are multiple registrations of the same pin on the
> same dpll device, following warnings are observed:
> WARNING: CPU: 5 PID: 2212 at drivers/dpll/dpll_core.c:143 dpll_xa_ref_pin_del.isra.0+0x21e/0x230
> WARNING: CPU: 5 PID: 2212 at drivers/dpll/dpll_core.c:223 __dpll_pin_unregister+0x2b3/0x2c0
> 
> [...]

Here is the summary with links:
  - [net] dpll: fix dpll_xa_ref_*_del() for multiple registrations
    https://git.kernel.org/netdev/net/c/b446631f355e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



