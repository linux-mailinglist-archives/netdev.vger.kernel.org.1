Return-Path: <netdev+bounces-76929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5D6786F77A
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 23:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BAF71F2150C
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 22:40:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100BA7A707;
	Sun,  3 Mar 2024 22:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r5yAhwTH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02F676910
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 22:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709505629; cv=none; b=FSRmaeYBEPcLf4wvO4iG/ptTTjzM8PoSjYU8I5XaIOM73RLtfN5GvY7HxiglpdcNz04T3p+H7MRkj+WNaH9Y+yeEAtCh8S0bg3YsjN1PaT9jniOsbw7iAAd0xFcD4Zw5QasupBhbHYjkkVkHP9Kh+wePl21KjLhTTo6p1TQsp10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709505629; c=relaxed/simple;
	bh=XJxXoRVzkjzGBPNcHRYDAY/UGUNk+HpX+HXtAfExnZo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RHFXNsTyVoDpXpNfjbmeYr3gBoVG6oEsbqXLyN+XwxqiV6Opy1+5z0ANv47abzRSzoB8yWModASgVqca5RPdRcyNyodqmeNRsCcL6VzGnEjjJhwRc3jcMcdaqcFa2DwkGmHAOef+Kq8XD0WeXkowCpwyUWyJlzkqmn3jrWo8BWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r5yAhwTH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7B223C43394;
	Sun,  3 Mar 2024 22:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709505628;
	bh=XJxXoRVzkjzGBPNcHRYDAY/UGUNk+HpX+HXtAfExnZo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=r5yAhwTHCVRh8PmaDdqr6SWO54xUY2yljBll1zZ3cmBM0OLid7pP4al3d1Uu/Zlae
	 NL07Ag573H1rQYcD00wD0jhkVKLh/WjXpE11uX9ghkKHM6m8GYxYZ6NFXfgNqk61Ui
	 G+RBfLwP4oULzDga2l4z8IwkisLvm0OoIDjRJxORSZzXdBkkSNeYw1sf/AuHybOGlb
	 ibM3wGkWlHCbqkSkO8DKOqsqndHHkllnkZpi7Q5J0n6jaV/xB72MTR6KfWH6XtpWty
	 eCmopanXcLYAv1DUJ7Yam0KfeyD2KXSvQsfeE91yVUfKIXSWRv6s9AI6VLkJe6z3QO
	 M3HmaRCVyg5wQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 564CBD9A4B6;
	Sun,  3 Mar 2024 22:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iproute2-next 0/3] multicast event support for ioam6
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170950562835.16991.13440473552331986103.git-patchwork-notify@kernel.org>
Date: Sun, 03 Mar 2024 22:40:28 +0000
References: <20240222154539.19904-1-justin.iurman@uliege.be>
In-Reply-To: <20240222154539.19904-1-justin.iurman@uliege.be>
To: Justin Iurman <justin.iurman@uliege.be>
Cc: netdev@vger.kernel.org, dsahern@kernel.org

Hello:

This series was applied to iproute2/iproute2-next.git (main)
by David Ahern <dsahern@kernel.org>:

On Thu, 22 Feb 2024 16:45:36 +0100 you wrote:
> Add support for ioam multicast events via a new command: ip ioam
> monitor.
> 
> Justin Iurman (3):
>   uapi: ioam6: update uapi based on net-next
>   ip: ioam6: add monitor command
>   man8: ioam: add doc for monitor command
> 
> [...]

Here is the summary with links:
  - [iproute2-next,1/3] uapi: ioam6: update uapi based on net-next
    (no matching commit)
  - [iproute2-next,2/3] ip: ioam6: add monitor command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=ae5c6f9b0391
  - [iproute2-next,3/3] man8: ioam: add doc for monitor command
    https://git.kernel.org/pub/scm/network/iproute2/iproute2-next.git/commit/?id=94107bba2456

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



