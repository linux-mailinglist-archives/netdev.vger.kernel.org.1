Return-Path: <netdev+bounces-261145-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QOsBDz23n2mKdQQAu9opvQ
	(envelope-from <netdev+bounces-261145-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:00:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E611A044E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 04:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61BBA30420BD
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 03:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C0C73859C7;
	Thu, 26 Feb 2026 03:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rx8v+m6y"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 731A238552F;
	Thu, 26 Feb 2026 03:00:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772074803; cv=none; b=mmAqwKt+TTQOo2HlT5C+dT5avmHFzNLpY04oWrEqDeFqEp4Y4WfzsZve95BJFCAOhiz1ObNGJVWPA6fH1qMdTpWY8jBZD0iYO8oad2RgiTgNUxG0HyKS6K/h4Dx5awz/OC7N55s3PBUnIHRHUdfg+kvj0QSbZkLsM/pNOvE0DaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772074803; c=relaxed/simple;
	bh=zXNRF1WeA/4bTS9AeBBWWQ7m2l0KGfZnBlChQb3w/OQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pDlIVMe/xbZMiHskj3DTKrmQYKffyqLIjm+VUyAMYPsKUkQL0QXBLjKoSSePrb1hCMPjI6zhZ+XRJTv5gxErr5AiftdEDDgSges9QNEM19T/oHZus3kvVumCrcE3PMhafGs7Zl5sjVF5mOQLuEISBUEml+AnTqseGI2HR5l1aLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rx8v+m6y; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC691C19425;
	Thu, 26 Feb 2026 03:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772074802;
	bh=zXNRF1WeA/4bTS9AeBBWWQ7m2l0KGfZnBlChQb3w/OQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rx8v+m6yLjjDJSQpvN0HBW+4cEgIV4XLa3iF6uUxwUFEgUmaXBWQE6ulLTUddA1fz
	 UsQsI8r4MUsb7fv7wM40a7fv4svJi8D390mx3m15TzdNaOwh0o1Ha6mAYsAHtO8lhl
	 K1zj5IZD9TVd0bHLbKIorMJpKnhu6tLEM+9bZLuR/OtjnOfJzowmpq8HWayvaNrSFH
	 SRGnUO6U/5ktEC8qUfGDR8djxO2gtN0NA7OEH6qXz34GOSHCA/zpv4hRnem2Wl9rKR
	 R4V1TVvtf8oayZeqiraA9P6do5fE/cCQhe8Y/0LeTFYYDr4QOoLSTFR1vrn/KlcyZd
	 XPiu1nQxJ+fsg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD72380A94B;
	Thu, 26 Feb 2026 03:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: pegasus: validate USB endpoints
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177207480729.1011529.13653045267962557562.git-patchwork-notify@kernel.org>
Date: Thu, 26 Feb 2026 03:00:07 +0000
References: <2026022347-legibly-attest-cc5c@gregkh>
In-Reply-To: <2026022347-legibly-attest-cc5c@gregkh>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org, petkan@nucleusys.com, stable@kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261145-lists,netdev=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,nucleusys.com:email]
X-Rspamd-Queue-Id: F2E611A044E
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 23 Feb 2026 13:58:48 +0100 you wrote:
> The pegasus driver should validate that the device it is probing has the
> proper number and types of USB endpoints it is expecting before it binds
> to it.  If a malicious device were to not have the same urbs the driver
> will crash later on when it blindly accesses these endpoints.
> 
> Cc: Petko Manolov <petkan@nucleusys.com>
> Cc: stable <stable@kernel.org>
> Assisted-by: gkh_clanker_2000
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> [...]

Here is the summary with links:
  - [net] net: usb: pegasus: validate USB endpoints
    https://git.kernel.org/netdev/net/c/11de1d3ae556

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



