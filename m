Return-Path: <netdev+bounces-293971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8HHjCsdBHmraiAkAu9opvQ
	(envelope-from <netdev+bounces-293971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:36:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 921BA62750B
	for <lists+netdev@lfdr.de>; Tue, 02 Jun 2026 04:36:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B3E130BA552
	for <lists+netdev@lfdr.de>; Tue,  2 Jun 2026 02:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E4433655C0;
	Tue,  2 Jun 2026 02:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XhemKVfZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D67363C62;
	Tue,  2 Jun 2026 02:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780367414; cv=none; b=ACOQAwCU2xdmC0rsnF5sAH1dPRLtNrDnqX3o+e1HN+aJcRLOQi65tKCye2POX8YQI4NCEXrI0Usva71wEqi2BIlzjTra/AqRp3N67kdbIlr01JvcppQwLoqV9yMIRuzpZh+G0pxdMQ1WGfv4BU+hDbagIWpMo6tv4LNmtghA1b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780367414; c=relaxed/simple;
	bh=EnoCzSE1yseyHHb1mNzen525LAR9fD+NpoFMxIGEBuU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n9+vvHp0t4AU+i69uUKhqrF1slrHuiwkKelemEnWrwb7BhCJ0gKw8CVbZ/ataygARFPbsHUylHuIt94WK6grjr1LhvaFVBYUi1YOxPjWnuxrqQ5hIe+ab/Y+cDm2GeMKc3zIXCfFXekDhvFGGJGFzGjZ1PTnPatD+fAp6kzonak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XhemKVfZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A724A1F00893;
	Tue,  2 Jun 2026 02:30:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780367412;
	bh=YDCFXe3YpgloXPSj0OFKTsle5u6blbAVQyE/eH/fQ5g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=XhemKVfZP/Jv6xjimDlyTcbp6MbWX15hsx7xXECtygNNwO+5cleunFUbxNZg8IcMF
	 4ss+8ktboZCANp4if2OmZpjN5xfRBY9DkDXSmpPGjZECxSywQzobI8t98NzbOmMEyO
	 Ta690OKDqhhm2+w1CCZ5JrZ/SgZtQClLeJyCRFVBmuDiYOo1/PKvBrjywu/+nX788K
	 FNqdFZLR5BD2US8kCy5jkN5qNxSvGslQKPuk4EpEcg2fF/5MxC2icdBrMr3TWhDMRd
	 nC92KjZoAtPxylA2ZD+m/UkEJlp+goQ1M6fjN/iz6dX+OBeg8hrNZ8jBhh3sLOB/jr
	 yzaSQhEB+PxPQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199A738119F9;
	Tue,  2 Jun 2026 02:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: wwan: t7xx: Add delay between MD and SAP suspend
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178036741464.211970.10289027977478077482.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 02:30:14 +0000
References: <20260527061451.12710-1-jtornosm@redhat.com>
In-Reply-To: <20260527061451.12710-1-jtornosm@redhat.com>
To: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
Cc: chandrashekar.devegowda@intel.com, haijun.liu@mediatek.com,
 ricardo.martinez@linux.intel.com, loic.poulain@oss.qualcomm.com,
 ryazanov.s.a@gmail.com, johannes@sipsolutions.net, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[intel.com,mediatek.com,linux.intel.com,oss.qualcomm.com,gmail.com,sipsolutions.net,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,netdev@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-293971-lists,netdev=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 921BA62750B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 27 May 2026 08:14:51 +0200 you wrote:
> SAP (Service Access Point) suspend occasionally times out with error
> -110 (ETIMEDOUT), followed by modem port errors and complete modem
> failure requiring a system reboot to recover.
> 
> Error symptoms:
>   mtk_t7xx 0000:72:00.0: [PM] SAP suspend error: -110
>   mtk_t7xx 0000:72:00.0: can't suspend (...returned -110)
>   mtk_t7xx 0000:07:00.0: Failed to send skb: -22
>   mtk_t7xx 0000:07:00.0: Write error on MBIM port, -22
> 
> [...]

Here is the summary with links:
  - net: wwan: t7xx: Add delay between MD and SAP suspend
    https://git.kernel.org/netdev/net-next/c/ae733795e593

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



