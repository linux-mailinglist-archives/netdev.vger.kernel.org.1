Return-Path: <netdev+bounces-304055-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id rExzJQEvRmohLQsAu9opvQ
	(envelope-from <netdev+bounces-304055-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:27:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F27FD6F53AC
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 11:27:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=fFWMmVpC;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304055-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-304055-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D98D3318FA24
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 09:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403B1477E24;
	Thu,  2 Jul 2026 09:10:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 352883B52FA;
	Thu,  2 Jul 2026 09:10:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782983424; cv=none; b=fMuGaK8MNsKj+bUiTEXwKYSIGcXicOD0jEH3Y+OTXwj+kkCo9P//K6dzOdLepoSI7sgggOpV2LksOH69ehbg8YbHcO8eTm7a8SUyy9xgQWmtgR6iXINkslm1igknv09ONr9iAfXYUbpoRNWcOA0/XGr7whbNxkYknRizjsCvANQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782983424; c=relaxed/simple;
	bh=f0HIP3us4SwozEp0bJcD/ng4r23uDIDIXGDEEW2IdFw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nwiy37H45FbhTxSaCWvC/TySJlqhIVjxM9gvd48bmQNxXSj8gsAMatD4rVrI5PcJrHXMLbsucqL3tfH9nmZQxsINe5LCY/YzjhEvGTHntzQs6O+RQETQsBZUYQRNNVtVa7o5vZyrptciDFuSP3z+M+48C3IHJdK9Lpzx67e7n6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fFWMmVpC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3EE81F00A3D;
	Thu,  2 Jul 2026 09:10:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782983422;
	bh=Rs9tTgl5fyFLDqt1jibTXsWudB6xaSrmbkriQUZVpWY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=fFWMmVpCL9pj3uETKXxJ/vRkWx70UXN9E0XzGIdB3XirLY14URJi2rAgBJARFIkIH
	 UF4M8YFa4CmM5H3W9G5/xAgH7Fdpbz364/QnW1nbetuUBSngzKRj/thg64COdEF8Z2
	 d+84aa9LK0xhnzmEW2L1pHyiiS8vv2SPrgt+B/6mJ+3aCQhnxjxl6rjju61OpZ1MId
	 rgGyd9Czc7ug0mBGsC9bTwDsY5D0/nwKGWIfabGpgE0k8UPZMhHppcRDBovc2BsjNO
	 1iSfAvv7jVTczs75Ac74Q/e7f8pYP4ssyEV1/TOj1sZWuGq5no/Lhzoxa4xFrapLhR
	 i28FSSG1/r/rA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19B5B3926665;
	Thu,  2 Jul 2026 09:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4] net: usb: rtl8150: handle link status read
 failures
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178298340589.1537313.17929196143531791690.git-patchwork-notify@kernel.org>
Date: Thu, 02 Jul 2026 09:10:05 +0000
References: <20260630101216.10365-1-alhouseenyousef@gmail.com>
In-Reply-To: <20260630101216.10365-1-alhouseenyousef@gmail.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: petkan@nucleusys.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-304055-lists,netdev=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:alhouseenyousef@gmail.com,m:petkan@nucleusys.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-usb@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:syzbot+9db6c624635564ad813c@syzkaller.appspotmail.com,m:andrew@lunn.ch,m:syzbot@syzkaller.appspotmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev,9db6c624635564ad813c];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F27FD6F53AC

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 12:12:16 +0200 you wrote:
> set_carrier() ignores the result of the USB control transfer and tests
> the stack variable supplied as its receive buffer. If the device rejects
> or aborts the request, that variable remains uninitialized and the driver
> chooses an arbitrary carrier state.
> 
> Leave the existing carrier state unchanged when the link status cannot be
> read. A transient USB error should not be treated as link loss.
> 
> [...]

Here is the summary with links:
  - [net-next,v4] net: usb: rtl8150: handle link status read failures
    https://git.kernel.org/netdev/net-next/c/8c9c5b9a6896

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



