Return-Path: <netdev+bounces-278414-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO3KN4sl3mmMoAkAu9opvQ
	(envelope-from <netdev+bounces-278414-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:31:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E07E13F9600
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 13:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C67DF3014D8D
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 11:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9D5E3D34AC;
	Tue, 14 Apr 2026 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RQkf7R1d"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68192BEC2B
	for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776166234; cv=none; b=jzy/HYC7Ff2PLUUPUxS8hl/2g9YT3Rod+ODzh6yOQg2XJIFwo0sxAtlzgCmTN3T+qkEDNZe+G2pMc/qfnkpvt6Fy6zxhOzFu3e2XtsiTmrSIa3PRKHKg5gjsCT7amr7Xl2N9lc1GgnQRVLMeRn523SpqNhSV0HE7bTw/8cT3dRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776166234; c=relaxed/simple;
	bh=zg4s04vAqRJZL8+qesCOOJgplmyTcitRv8aarkt+4nk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nu8W5tDtwqUQ9j9WQaKlkM50XCOaizZw3hxRzr/Osj42/RvnOB0hEJbkbLPxd5FPincMaWXBJXhC3xm60pMNHOtAKZ7A9ZkF/vHtuu/UD5/YaKBJ5d0m34CXXya9I4dhnkyeu2kQYQnh089T0S6FDxltfrvVdjvJcGf6XXINFG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RQkf7R1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59C78C19425;
	Tue, 14 Apr 2026 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776166234;
	bh=zg4s04vAqRJZL8+qesCOOJgplmyTcitRv8aarkt+4nk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RQkf7R1dukJztDefpKtvkQpWTNDpwSASezgyqmdsCbAPdUBHBOIUviyP/0gWM2Ke7
	 drPFBMo+s/mNEPeslcQI+0awQxCZ5dBCW5bTSgvJFInORI1vBKJAFoLMWDupmeVGhB
	 iT9GViFA+Elj7Vb3MAEmS+Y+CeQNDwqrwyrHOIl84+JRwDDrL4nxQ87tIHCOsUTekw
	 naCe/exyTVA6e9Oug8iG88t34pcZFvbopiiw+SM4do1me/9UlB98JGND3TaEX+MnfD
	 0lJTjQvVlSpJEsstXP8cmGPSXTJZjo/6INYTIUCoKFsJOm4HxTA2P7ZeJdnHeJrslm
	 qmxSXfTM0T1yw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC5D3808205;
	Tue, 14 Apr 2026 11:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/1] net: caif: clear client service pointer on
 teardown
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177616620505.837808.3249262246874581583.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 11:30:05 +0000
References: 
 <9f3d37847c0037568aae698ca23cd47c6691acb0.1775897577.git.zcliangcn@gmail.com>
In-Reply-To: 
 <9f3d37847c0037568aae698ca23cd47c6691acb0.1775897577.git.zcliangcn@gmail.com>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 sjur.brandeland@stericsson.com, yifanwucs@gmail.com, tomapufckgml@gmail.com,
 yuantan098@gmail.com, bird@lzu.edu.cn, enjou1224z@gmail.com,
 zcliangcn@gmail.com
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,davemloft.net,google.com,kernel.org,redhat.com,stericsson.com,gmail.com,lzu.edu.cn];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-278414-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_TWELVE(0.00)[14];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E07E13F9600
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 11 Apr 2026 23:10:26 +0800 you wrote:
> From: Zhengchuan Liang <zcliangcn@gmail.com>
> 
> `caif_connect()` can tear down an existing client after remote shutdown by
> calling `caif_disconnect_client()` followed by `caif_free_client()`.
> `caif_free_client()` releases the service layer referenced by
> `adap_layer->dn`, but leaves that pointer stale.
> 
> [...]

Here is the summary with links:
  - [net,1/1] net: caif: clear client service pointer on teardown
    https://git.kernel.org/netdev/net/c/f7cf8ece8cee

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



