Return-Path: <netdev+bounces-297314-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sWHAN8yMKGpQGAMAu9opvQ
	(envelope-from <netdev+bounces-297314-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:59:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B677664674
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 23:59:40 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eT6Akloo;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297314-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297314-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E10F0302DB73
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 21:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7A0481FB1;
	Tue,  9 Jun 2026 21:57:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A8F93FBEAF;
	Tue,  9 Jun 2026 21:57:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781042253; cv=none; b=gf0T8JjdJdpKUHJBqpn8atb//WqMW0c2HvzwqN42OFXfisZNIDASTPof6DdDPindLWkhwLFtwnri8eDWn/H7qxfvabDS22pTq/q/VEaf+FezYby3u4mcWg0FfVHsSNDymE0MUQ2Ckmu3ZPZ7+8HY6/7v78nxIUn+gSS0BaawQx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781042253; c=relaxed/simple;
	bh=0CYUk3mcY2Z5Sz4+beWfJokuW2ClAlI66bTArmd+Fz8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iOX+P71JMxmjFNeTlfiSj+HrAokyPWaObwCStLULMvx3J/FH2oKCItmDUlDFQR4Atr3ho+vFjPCDnN5AEYdcg4Gzi3bahwF+MLRI7gmW3D55c+teL3++1kW9SFJLN8NoH+E2fv/E1h0JwVt8vq396ZYedP2uAYPOD/G0/9/4h+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eT6Akloo; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4420F1F00893;
	Tue,  9 Jun 2026 21:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781042251;
	bh=qddQ3xG3nLP7iaPeo6rwHCCEvIqeK9/UCvhobSlMWdg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=eT6AkloofolTU+44bYcsvAKqeDvXgLLmDorOoVoh5fclXviRz9sdo1x6Jql0WQ1KZ
	 ZqL1L3btKOb/25lrFBiiqKftLEOWXYZS93U3p1Eyyg+Or3iwJYw1eLnjdj3WySxvNH
	 T6Gaa/V7DB2JXZxo2Zn4fO57JFy8U70YDhrdewG2fd8ldx5EM0ja2m+QaMZ4DzsklQ
	 hXB0VWUGqEYdaLtAr0Tr8DQuvyqV5BL8eC4oUCpesj3hCXWGwW9F1/wPmTYTCi7hCR
	 PrE4RFmGg1nYWSxItAObqG0AJyfnIxTcQ8PBsvBtXEaaugY1B58uRhElvspAPynSad
	 oyPrxjfP/kbpw==
Date: Tue, 9 Jun 2026 14:57:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: abaci-kreproducer <abaci@linux.alibaba.com>
Cc: Sechang Lim <rhkrqnwk98@gmail.com>, John Fastabend
 <john.fastabend@gmail.com>, Sabrina Dubroca <sd@queasysnail.net>, "David S
 . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Jiayuan Chen
 <jiayuan.chen@linux.dev>, Alexei Starovoitov <ast@kernel.org>,
 netdev@vger.kernel.org, bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 Oliver <oliver.yang@linux.alibaba.com>
Subject: Re: [PATCH net] tls: fix use-after-free in tls_sw_sendmsg() cork
 error path
Message-ID: <20260609145730.2497829f@kernel.org>
In-Reply-To: <178101875671.841617.9555980064609175426@linux.alibaba.com>
References: <20260605214802.1647008-1-rhkrqnwk98@gmail.com>
	<178101875671.841617.9555980064609175426@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-297314-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_RECIPIENTS(0.00)[m:abaci@linux.alibaba.com,m:rhkrqnwk98@gmail.com,m:john.fastabend@gmail.com,m:sd@queasysnail.net,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:horms@kernel.org,m:jiayuan.chen@linux.dev,m:ast@kernel.org,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:oliver.yang@linux.alibaba.com,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,queasysnail.net,davemloft.net,google.com,redhat.com,kernel.org,linux.dev,vger.kernel.org,linux.alibaba.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[alibaba.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3B677664674

On Tue, 09 Jun 2026 23:25:56 +0800 abaci-kreproducer wrote:
> From: abaci-kreproducer <abaci@linux.alibaba.com>
> 
> This is an AI-generated validation of this patch. The issue was
> reproduced on the unpatched kernel, and the original symptoms were no
> longer observed on the patched kernel. However, additional issues were
> identified during validation (details below).

Please never spam mailing list without automated bots unless
the maintainers have given you permission.

