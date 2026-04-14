Return-Path: <netdev+bounces-278379-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICx6OdYV3mlBmwkAu9opvQ
	(envelope-from <netdev+bounces-278379-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:24:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C6243F8A35
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 12:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A4143044B93
	for <lists+netdev@lfdr.de>; Tue, 14 Apr 2026 10:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31BE3D47C6;
	Tue, 14 Apr 2026 10:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzAizErS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D751A3D410B;
	Tue, 14 Apr 2026 10:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776162036; cv=none; b=hMmaKgJiBcVWqZ9Ltx9n5+yVB9uo8tv1AYzODXP43OALIjtmbHY/NxhYXDsPSgSbBW4ViJWX/vFq8jdhswPLAtFEUWvipi3oHIbsDeVtkWoeBDhLAybFzaiqGODGwNJ+fdEY+tBtDkW3IWsu/8xDQEVdounQ34KbHnjBsZag6Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776162036; c=relaxed/simple;
	bh=DB088bkm+R5WzfKl/khDK+zsssDou6km3IYDge0gM04=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KBL/uDCCoaX5EVYIEnfue876Es0Eg1iltiswq1qANdHK6RkC91uw8ofkJQTW+1TYnvVUqvo8WiJfgJlY6zeVcy5pwoou7uec4tPLzGDJmhhJ0ihrg95FKNZHBUYCaZJiJQQKDPrvY5IIC1fLCc/IWIKhPwDMZuKP/D4LBVCHrNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzAizErS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 073B0C19425;
	Tue, 14 Apr 2026 10:20:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776162035;
	bh=DB088bkm+R5WzfKl/khDK+zsssDou6km3IYDge0gM04=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NzAizErS7RdqwA5glbaZAR/AHwe+hpjztJoEJN8bfUPl1Zw0SiUsQ5PwfDQrtrTXs
	 h0T+9r8I+GTXi7ZtjO122qUfZ2dvf7OUwYUCql36lhUP3QE3flEMcN7wK3YOh0mvXD
	 MibOfTVp4SwleJUW0Dw4jEaKzLEPcOuGA22c5FL5ib72XxkHouqHUUWDCDHWU+oDmH
	 bZIpbODTr1VpoRcZ4EfpmcBc5Iw5O7DuobrHD8bJLFjzZ6Q58/XwtSPGgOOs6XVmYu
	 rTWAMYYgn+GALGeniyrQM4SqP4cxAGzBeKSzz8FTy2hCrxZ2S1g2kdMZfX2vGH8KP1
	 kXlZbe5Egg5bw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02D2A380A957;
	Tue, 14 Apr 2026 10:20:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: cdc-phonet: fix skb frags[] overflow in
 rx_complete()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177616200580.811155.3079803654201633076.git-patchwork-notify@kernel.org>
Date: Tue, 14 Apr 2026 10:20:05 +0000
References: <2026041134-dreamboat-buddhism-d1ec@gregkh>
In-Reply-To: <2026041134-dreamboat-buddhism-d1ec@gregkh>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, stable@kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-278379-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5C6243F8A35
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat, 11 Apr 2026 13:01:35 +0200 you wrote:
> A malicious USB device claiming to be a CDC Phonet modem can overflow
> the skb_shared_info->frags[] array by sending an unbounded sequence of
> full-page bulk transfers.
> 
> Drop the skb and increment the length error when the frag limit is
> reached.  This matches the same fix that commit f0813bcd2d9d ("net:
> wwan: t7xx: fix potential skb->frags overflow in RX path") did for the
> t7xx driver.
> 
> [...]

Here is the summary with links:
  - [net] net: usb: cdc-phonet: fix skb frags[] overflow in rx_complete()
    https://git.kernel.org/netdev/net/c/600dc40554dc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



