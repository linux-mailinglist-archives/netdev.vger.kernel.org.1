Return-Path: <netdev+bounces-109553-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC8B928C78
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 18:50:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8782F1F2411E
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 16:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8990716CD00;
	Fri,  5 Jul 2024 16:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="xXzvN6ut"
X-Original-To: netdev@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD71114E2D6;
	Fri,  5 Jul 2024 16:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720198252; cv=none; b=um0UVOEZyJEzbdV4yWPvvWwF0N4D6lNI+Z8tykIbFsg1fmkNLaFzcW5YffIlFRai9zCbxxlAOlUg4VUZh+CmADYEj9hFbKjIpVKGxvTPXRidEbk5WrS/AB3PuuQZBUUw/6hjMTucQJgudMRSUrlMCvTaMmt+5ICOAS2PYe5/ZTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720198252; c=relaxed/simple;
	bh=THpNz3GdpyxXNx1U0XkxvQAwQ4nBLkZO77Oiih/WhTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ViX4hYCCaLLQUYftFZ1COJ8ernuck3bbER1TTGQF9NdBVIImoaEzc/tPb7rhBWs11sV5mIm7/qEQMgWaseKEPppDGnuo69stcLWscQp+TLY3Cp7ad/jnuhBFC5dDXIjNbf82R5pw3d3RYLT+mOWCghMkLn3+jVw1T2Z/zG/NrVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=xXzvN6ut; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:Reply-To:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=TyacVIb4lVynekdoUcj7ogqnStFwwVkSIvRUoiyphBs=;
	t=1720198250; x=1720630250; b=xXzvN6ut7wjhDjaTqHrpihXcS0h08eFqCerIr/jGl0b8GlY
	9PsoOhnCgzT5v2qlp+uSrHVBSBjCNsA0niChWV++QLu79tWJUvBbA1NMIHgW+e1TP0GHG0iP7mC9S
	b6TPE77NMkUPEa80d1eRsqmBCh6tfU84BqYto+gCvheen+v2nfmF3GpoRbi2DzQLO0JXcsny0i7eq
	vzVGTdzo6RmJHfVnteTgOHXSXirxnYCvO/75StDJXThKc+7IMUW+0AR79bzfdVPUWR3W/S2UCYhZ4
	2e4XroF6mPZKD8QABig4UkcHuOmMVkPMVtkqJQ9+4wZlVYCXSjwgU2XDVoJ90jbQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1sPm8u-0004M8-T7; Fri, 05 Jul 2024 18:50:40 +0200
Message-ID: <0b96edcc-6b5f-447f-8023-440427a9fff2@leemhuis.info>
Date: Fri, 5 Jul 2024 18:50:40 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: e1000e regressions reg. suspend and resume (was: Re: [GIT PULL]
 Networking for v6.10-rc7)
To: torvalds@linux-foundation.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Jakub Kicinski <kuba@kernel.org>
References: <20240704153350.960767-1-kuba@kernel.org>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Content-Language: en-US, de-DE
In-Reply-To: <20240704153350.960767-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1720198250;c7cb92f7;
X-HE-SMSGID: 1sPm8u-0004M8-T7

On 04.07.24 17:33, Jakub Kicinski wrote:
> 
> The following changes since commit fd19d4a492af77b1e8fb0439781a3048d1d1f554:
> 
>   Merge tag 'net-6.10-rc6' of git://git.kernel.org/pub/scm/linux/kernel/git/netdev/net (2024-06-27 10:05:35 -0700)
> 
> [...] 
>
> There's one fix for power management with Intel's e1000e here,
> Thorsten tells us there's another problem that started in v6.9.
> We're trying to wrap that up but I don't think it's blocking.

Linus, in the scope of the topics I recently brought up on the ksummit
list I'd really like to know how you feel about the particular situation
Jakub hinted at avove, as I wonder if you would have preferred to see
the culprits reverted weeks ago.

I agree with Jakub that the problem might not qualify as "blocking", as
it seems to only affect users with certain ethernet chips. But OTOH it's
not one, but two stacked regressions -- and one is in proper releases
for a few weeks already now. And both afaics could have been solved
weeks ago by quick reverts (while reintroducing an old(?) problem the
first of the two culprits tried to fix); the author of the second
culprit even submitted a revert weeks ago and suggested to revert the
other change, too.

That was the long story short, here are the details.

The first culprit is 861e8086029e00 ("e1000e: move force SMBUS from
enable ulp function to avoid PHY loss issue") [v6.9-rc3, v6.8.5,
v6.6.26]. Due to it ethernet after a suspend and resume did not work
anymore for some users. This is something that bothers people, as
https://lore.kernel.org/all/ZmfcJsyCB6M3wr84@pirotess/ shows.

This regression was something the second culprit bfd546a552e140
("e1000e: move force SMBUS near the end of enable_ulp function")
[v6.10-rc2] tried to fix. Since two days after that rc was out it's
known that this change causes some systems to not even enter suspend.
For details see https://bugzilla.kernel.org/show_bug.cgi?id=218936 and
https://bugzilla.kernel.org/show_bug.cgi?id=218940 . Side note: commit
bfd546a552e140 nearly entered stable kernels as well, but I told Greg
about the problem, who then decided to wait:
https://lore.kernel.org/all/2024061406-refreeze-flatfoot-f33a@gregkh/

It quickly became known that both regression can be fixed with reverts;
the author of bfd546a552e140 even submitted one and suggested to revert
861e8086029e00 as well:
https://lore.kernel.org/all/20240610013222.12082-1-hui.wang@canonical.com/
https://lore.kernel.org/all/20240611062416.16440-1-hui.wang@canonical.com/

But another developer wanted to fix the root cause. The last version of
the patch to do so is from 2024-06-20 afaics:
https://lore.kernel.org/all/20240620063645.4151337-1-vitaly.lifshits@intel.com/
The discussion about it stalled until I pointed the -net maintainers to
it two days ago in private, as afterwards there was one more reply.

All that makes me wonder if both commits should have been reverted in
mainline weeks ago; yes, sure, the problem that 861e8086029e00 tried to
fix would be back. But it's Fixes: tag points to a change to 4.2-rc1, so
maybe that would not be that bad (hard to say without knowing more about
what motivated the development of that change).

That way Greg then could have reverted 861e8086029e00 as well to resolve
this in 6.9.y and 6.6.y (the latter contains this commit since
2024-04-10 and thus likely also shows the regression that bfd546a552e140
was meant to fix).

Ciao, Thorsten

