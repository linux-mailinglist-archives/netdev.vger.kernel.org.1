Return-Path: <netdev+bounces-303418-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id vyaOBWddRGprtgoAu9opvQ
	(envelope-from <netdev+bounces-303418-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:20:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD306E8E31
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 02:20:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ZD4djcxp;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303418-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303418-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C514E300A7F9
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 00:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F69B640;
	Wed,  1 Jul 2026 00:20:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E1D9219FC;
	Wed,  1 Jul 2026 00:20:21 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782865223; cv=none; b=jCSCKYb5YR1v9vZ24ipvvJ6P0eGrEDabBUX/S2sfmyv8XnrYkUFTHQ2JwUcW02k03K8kP+IxSS55kGiA0TEOqwy35YvIQ5cjCdHbvgbSS1HpUTbj0nWlzQ7Nh3z4ijK8YREp+l/Jqjbbbt0aJFEWPhJbSwo7K2uZI17luWfY3+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782865223; c=relaxed/simple;
	bh=TffaeaZ0/qHBYSA5RFOVOakKWtw2Dy4q32bJqISPWZ0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Taip+ZTkGjJ5cSUYOb0exnbcCs54LihMKEQZHu/vhEFu0UpFObGvybPwyUAfEaA2TByUhKA0N/s80w/yFSIozmtZ5/XW2oYyA18lVlxpUP7LeQ83XowKx0DYlZJAV04cR2g5O4gzDY2mSRYFe8Ana/Krh71B2swkJI2cVAV7LVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZD4djcxp; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA2351F000E9;
	Wed,  1 Jul 2026 00:20:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782865221;
	bh=FhHoEVJX47i6Sq0muV3ZK6X4+lfzLqPfe/vKM7lETeI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ZD4djcxpxUu+P5dJ2j7cr7KejIwE827lFoOldk1DvQGUrWZMYgHivWdJ9Fwi7qJkM
	 yoShvViqEe/8lMElMUNA9alILc4tGVTqdy6aXdh1VT2TbOQMDlQeNc/3/spiczPu+U
	 SqMEgbqBDZKy5Mc0DJGDjmJia5jD+AxmbKP2aFqRa7/XQqKIDunW7tFBPTSTfAEEuN
	 Ljchj++UtV5X3cMNxOJYyxBCMV28PkgRlipIEhD6g1Rivm70EQSB1DOLlWK9fchMcl
	 lMY44rMhVtVNQn3l8bBl2e2BIl4AtL79vtOk05fnJIhnmkkwFXrStd/kOKY9o6TejU
	 dXgFeI9845GZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C9E393A963;
	Wed,  1 Jul 2026 00:20:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5] virtio_net: disable cb when NAPI is busy-polled
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178286520539.349616.104964929108327778.git-patchwork-notify@kernel.org>
Date: Wed, 01 Jul 2026 00:20:05 +0000
References: <20260629024230.37325-1-lange_tang@163.com>
In-Reply-To: <20260629024230.37325-1-lange_tang@163.com>
To: Longjun Tang <lange_tang@163.com>
Cc: kuba@kernel.org, horms@kernel.org, mst@redhat.com, jasowang@redhat.com,
 edumazet@google.com, virtualization@lists.linux.dev, netdev@vger.kernel.org,
 tanglongjun@kylinos.cn
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303418-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[163.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lange_tang@163.com,m:kuba@kernel.org,m:horms@kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:edumazet@google.com,m:virtualization@lists.linux.dev,m:netdev@vger.kernel.org,m:tanglongjun@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[netdev];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,kylinos.cn:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 8FD306E8E31

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 29 Jun 2026 10:42:30 +0800 you wrote:
> From: Longjun Tang <tanglongjun@kylinos.cn>
> 
> When busy-poll is active, napi_schedule_prep() returns false in
> virtqueue_napi_schedule(), so virtqueue_disable_cb() is skipped.
> The device may keep firing irqs until reaches virtqueue_napi_complete().
> Under load (received == budget), it will lead to a large number
> of spurious interrupts.
> 
> [...]

Here is the summary with links:
  - [v5] virtio_net: disable cb when NAPI is busy-polled
    https://git.kernel.org/netdev/net/c/1eb8fc67ca41

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



