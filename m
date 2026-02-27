Return-Path: <netdev+bounces-261648-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id VV7gNC3uoGl5oAQAu9opvQ
	(envelope-from <netdev+bounces-261648-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:06:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C1B1B1621
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 02:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 247B0302F6A1
	for <lists+netdev@lfdr.de>; Fri, 27 Feb 2026 01:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86430262FF8;
	Fri, 27 Feb 2026 01:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Gtzmhoa6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6349225B1CB;
	Fri, 27 Feb 2026 01:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772154408; cv=none; b=uS8Mz0kc/9P5953ItJA6AdanEebfhdA83EJrJou3fGg5YO2LCjUnAp2zG8igj02IWGVfaa4xt8lLxaiLTcs3a0GitTYNGVCc+VHOk+ZX2RG3fRP8ZMJwnu9a+BhzwU6uWzd0RPia9G/PZhHUyejRCwnMLl2zYgNGdQ0OhXdkoZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772154408; c=relaxed/simple;
	bh=n8MLTtLjD/7AzNViZ68ja/2l5vEvrlqxhqGcijtvmNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S5w8BC60Kiv3s1yDBpVU01byNv2XtPhQPlZfWsO7L/X35gW/I2qoAEyX43LN/bqaVOXITG5gtR9gcB0DJlokSsm4Pi2T3rlcObKxQy3yxBZiK8PtQKXoAL8wY3Ffd+ChvPBef0apghyswlHe4Bg9yG9ig2b31ddjuqhWiCsLlvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Gtzmhoa6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DB0C116C6;
	Fri, 27 Feb 2026 01:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772154407;
	bh=n8MLTtLjD/7AzNViZ68ja/2l5vEvrlqxhqGcijtvmNQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Gtzmhoa6JkqiNWPKlf/2Q8ezrbm2iQvSO4+7TrBN/P7m7gpiplFnjw9eOvfdJXG22
	 NCBcz8j+ZKZwGPCB2Kb8F3PEK57Z/gggRuR12zJ73sKJ5R2BCWb+RirdyNTq8lH3lK
	 SYPmOkR20bcUhx1ZqkQ9Mg4PnRjs+akGDfeiJj8hyP7dudB5gmOVv2cLic8iLCJPF8
	 xzIzrk7fLKR4rXhXamgu6q47MtB8ZScxQ4cn9u58oI+wb5BkHQ9b8TbkEG1VjKCKav
	 IWSQ2yd1dRkuTg/qjCRBO0SNfvUAjg0DIiBrulMQW1rZC4g6yi6QslTkFnljpZjD5a
	 KYd5LDvDFUrug==
Date: Thu, 26 Feb 2026 17:06:46 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Kiran Kella <kiran.kella@broadcom.com>
Cc: Daniel Zahka <daniel.zahka@gmail.com>, davem@davemloft.net,
 edumazet@google.com, willemb@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, jayakrishnan.udayavarma@broadcom.com,
 ajit.khaparde@broadcom.com, akhilesh.samineni@broadcom.com
Subject: Re: [net-next, v2 1/2] psp: Support for transmit on logical device
 when the underlying transport device supports PSP.
Message-ID: <20260226170646.0c4baeb6@kernel.org>
In-Reply-To: <CAPHeo3eJRYc503Ta24h9r+Uu1cGqb1dCfmnxuZQ4MJLCTFd9Lw@mail.gmail.com>
References: <20260223191154.2800616-1-kiran.kella@broadcom.com>
	<20260223191154.2800616-2-kiran.kella@broadcom.com>
	<0a850f65-be67-4a66-941f-17d8440e987b@gmail.com>
	<CAPHeo3eJRYc503Ta24h9r+Uu1cGqb1dCfmnxuZQ4MJLCTFd9Lw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261648-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,vger.kernel.org,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 45C1B1B1621
X-Rspamd-Action: no action

On Thu, 26 Feb 2026 17:16:58 +0530 Kiran Kella wrote:
> > The lack of support for netns is a bit of a gap for this feature. It may
> > make sense to see if what was posted in
> > https://lore.kernel.org/netdev/20260224002410.1553838-1-weibunny@fb.com/
> > is sufficient for your use case, as it handles cases where upper devices
> > are in a different netns from psd->main_netdev.  
> 
> Thanks. Went through the changes in
> https://lore.kernel.org/netdev/20260224002410.1553838-1-weibunny@fb.com/
> It is sufficient for my use case too, although it specifically
> addresses the cross-netns virtual devices use case.
> But the same net-ns stacked devices like VLANs can be handled with
> this patch implicitly, without user intervention through dev-assoc.
> I think both approaches can co-exist without conflict.
> However, I am ok with using a single approach to use the dev-assoc for
> the same net-ns use case too.

FTR I have mixed feelings about automatic propagation of PSP onto upper
devices. If we propagate it onto vlan, why not bond, and if bond why not
bridge. Or macsec (can every device do multiple layers of encryption?)

If user does the propagation and that results in packet loss that's
user's fault not ours. IDK.

