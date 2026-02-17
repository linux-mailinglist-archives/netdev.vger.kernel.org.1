Return-Path: <netdev+bounces-259166-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAjYCi3ulGnUIwIAu9opvQ
	(envelope-from <netdev+bounces-259166-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:39:41 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B09E51518EC
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 23:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E1F223017252
	for <lists+netdev@lfdr.de>; Tue, 17 Feb 2026 22:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA7B30C36C;
	Tue, 17 Feb 2026 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d8AouUMc"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9951E2E7648;
	Tue, 17 Feb 2026 22:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771367873; cv=none; b=NGRjCFzxSxLsA7l8CSg/aBUtqsRmGYQP4usU8lma7YMI6XQh1/HVtXU/f2SLiHzvMjDqpMb8CSEYQEJwvdNgamCKHyLnXXfntSNibakyP739Y18AJzMBFlzvaEMsxnM8Pfph7QMZ3pC1beJRYx/0ML+I+xjJVNc2QP43xtGH0Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771367873; c=relaxed/simple;
	bh=h9p6QEvCOnQ1bTCxXNQCa4QV3QUVeu0XfstRDDBVvrk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VOftmuP/TMN64QeXLuCozPvQV2TFY7xsZiJKLuQNnwRg3/0YLq9X8SOlRVS9iB5o03DSwxaY+e8YSvED3JjiWBFfX5ZoGieis8nZqdfU86cD2lsw9pVdVc64rm/xg3qzdBDcFVkqROIcP9Lqj7lXw6GEXgzUKZAM1lU6e/YhZdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d8AouUMc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4A41C4CEF7;
	Tue, 17 Feb 2026 22:37:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771367873;
	bh=h9p6QEvCOnQ1bTCxXNQCa4QV3QUVeu0XfstRDDBVvrk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=d8AouUMcqBYJM15E/9QUQY52b8wNv8GrJh3p7IZn185B675YhQZFeNy6HRwJicIpM
	 /Q0nevrNbmi3mKiPsW4v6+W2kS5Wn1R+8aFPsuqoY8tA6z/5Ls05t/i9NYFH3OPSuU
	 zUKn+3XUswHEHir3egi+2vH567c8GIrkWWBO/H37ITIc/AEUGqaZ1GLhKkJ9+DaWNO
	 tSN/7dUcdJWa4YZPhS9w3xa7SZr1REO2lxpP+MRqavAF7WxP56hYZTFBhl/vkLRVta
	 BQuVHneh98/thZaYOnc1WAPlLolfO9fQ4buItc7n8nDTauTHTqDsSYpAsal4/hrsP/
	 bBCMJMBxzcgoQ==
Date: Tue, 17 Feb 2026 14:37:51 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Anand Kumar Shaw <anandkrshawheritage@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, ast@kernel.org,
 daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
 davem@davemloft.net, sdf@fomichev.me, andrii@kernel.org,
 martin.lau@linux.dev
Subject: Re: [PATCH] bpf: cpumap: add missing XDP_ABORTED handling in xdp
 prog runner
Message-ID: <20260217143751.2e7bdefc@kernel.org>
In-Reply-To: <20260216150601.9454-1-anandkrshawheritage@gmail.com>
References: <20260216150601.9454-1-anandkrshawheritage@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259166-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,kernel.org,iogearbox.net,gmail.com,davemloft.net,fomichev.me,linux.dev];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B09E51518EC
X-Rspamd-Action: no action

On Mon, 16 Feb 2026 20:36:01 +0530 Anand Kumar Shaw wrote:
>  		default:
>  			bpf_warn_invalid_xdp_action(NULL, rcpu->prog, act);
>  			fallthrough;
> +		case XDP_ABORTED:
> +			trace_xdp_exception(xdpf->dev_rx, rcpu->prog, act);
> +			fallthrough;

Why are you populating netdev with xdpf->dev_rx when the
bpf_warn_invalid_xdp_action() above did not? Either both or neither should?

