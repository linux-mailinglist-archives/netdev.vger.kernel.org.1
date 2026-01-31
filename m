Return-Path: <netdev+bounces-255311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KM9kMN9ffWn3RgIAu9opvQ
	(envelope-from <netdev+bounces-255311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:50:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4239FC01CE
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 02:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41B623019394
	for <lists+netdev@lfdr.de>; Sat, 31 Jan 2026 01:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C20F32F762;
	Sat, 31 Jan 2026 01:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbOSCY11"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC86332A3E1;
	Sat, 31 Jan 2026 01:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769824214; cv=none; b=Qjy1O/fMYBJC5vqe9vhTFRzOK0o+EJ65aK/rVqTumSOOlPqtnrVcUyhCRoVxkxIgsEodv4+gPCP2JeOjB25Lo3U0G1Fp6SjgARSNuz2khF5VFGF/NU4QiUaK/lNWphWUd9MCf9eHRdWsc93ePmEhSmQVhuQ8m7Ejr9s8V3zJFUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769824214; c=relaxed/simple;
	bh=74AblHvcr993IUENM/P5oB03c8dAjA3vopeouxcZ9+4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Yg6TN4vfCtxE0d8oOE7x7FJJMA8KZFozels1rjUNS3vi1ME+8syFbfQS9YlC2hH90XAj8T4vnFlsC13XODhu6a3wn2JcxkT1GK6trNNUzUjW6CxeUvRmssSa8aatuUM44BehQk5gKyrLLZnXRW6DT9hoCY7vtOXgMY9urqdpXuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbOSCY11; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 937A1C116C6;
	Sat, 31 Jan 2026 01:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769824213;
	bh=74AblHvcr993IUENM/P5oB03c8dAjA3vopeouxcZ9+4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KbOSCY11PiZHeDl4pG9rsQRyonX/oe4v9VMHPMhJ1J5TM3VczdWjnxcpi1telwSJe
	 Dr956kKNkhYPK3wOPtBFtAB5sbhOcS1urFITLWbSsW8Ps9x8qydx3K59gulbtaE05R
	 qVBBcKt18cBVGSLPf/SwhTSAI3PpEPAD9cSs6xKLm1K2jF00FIhxb9lYyH2/GwbJYq
	 Eg7JUJqvRosGPLdhnTHrMmt4uSmck7dd5BsdnZK3tSYKd2dvUN+pDAS1vlOuONQdEr
	 kJmjNJ1CcP0z4cv2HW8NlAYMwfnRn3gsvqR0OtZP4sWJZAc/9ms/FOrO91Oc1h9bEK
	 3VjdoTXeejZYg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 11C18380CFFB;
	Sat, 31 Jan 2026 01:50:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: usb: remove unnecessary get_drvinfo code
 and
 driver versions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176982420586.3961929.943166335604966977.git-patchwork-notify@kernel.org>
Date: Sat, 31 Jan 2026 01:50:05 +0000
References: <20260129042435.13395-2-enelsonmoore@gmail.com>
In-Reply-To: <20260129042435.13395-2-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-usb@vger.kernel.org, andrew@lunn.ch,
 andriy.shevchenko@linux.intel.com, peter@korsgaard.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, petkan@nucleusys.com,
 steve.glendinning@shawell.net, UNGLinuxDriver@microchip.com,
 n.zhandarovich@fintech.ru, oneukum@suse.com, khalasa@piap.pl,
 kartikey406@gmail.com, o.rempel@pengutronix.de, max.schulze@online.de,
 tglx@kernel.org, mingo@kernel.org, kees@kernel.org, gustavoars@kernel.org,
 ebiggers@google.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255311-lists,netdev=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,linux.intel.com,korsgaard.com,davemloft.net,google.com,kernel.org,redhat.com,nucleusys.com,shawell.net,microchip.com,fintech.ru,suse.com,piap.pl,gmail.com,pengutronix.de,online.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4239FC01CE
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 28 Jan 2026 20:23:01 -0800 you wrote:
> Many USB network drivers define get_drvinfo functions which add no
> value over usbnet_get_drvinfo, only setting the driver name and
> version. usbnet_get_drvinfo automatically sets the driver name, and
> separate driver versions are now frowned upon in the kernel. Remove all
> driver versions and replace these get_drvinfo functions with references
> to usbnet_get_drvinfo where possible. Where that is not possible,
> remove unnecessary code to set the driver name. Also remove two
> unnecessary initializations from aqc111_get_drvinfo, an inaccurate
> comment in pegasus.c, and an unused macro in catc.c.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: usb: remove unnecessary get_drvinfo code and driver versions
    https://git.kernel.org/netdev/net-next/c/44ecaff55282

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



