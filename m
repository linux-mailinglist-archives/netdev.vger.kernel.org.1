Return-Path: <netdev+bounces-280580-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP5SJYyI6WnccQIAu9opvQ
	(envelope-from <netdev+bounces-280580-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:48:44 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA62844C5C6
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 04:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CF23A3005331
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 02:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604033C3456;
	Thu, 23 Apr 2026 02:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWFTU3Jv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCCE42C11E2;
	Thu, 23 Apr 2026 02:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776912518; cv=none; b=qyydeE/aEKAR2KCBtQjVH51yMBUAfTii5tcxiZ7ABdPrU8/30VrvNtCoIQVElJg2gYonxG3TvTA74SOO9v99xvlop7ASirGF+qPWHs8G5wWO62p1ipp7s8/Wc/7MFc5W5SFfEA8jca9XxBoQLPQaDrIAvOOBkumci6Zffvyq82g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776912518; c=relaxed/simple;
	bh=3d7KUzhhMRXeI8oJPy4/6hc0Gek3mf0WAjET+oOME2A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cnLAKfWkAg+FLqAnOpRohyeX4FVIxlx5HydEvH1znwWotkJLikIKAbpukskdu2jYrKfaCfYy3l1WpOc0IWJzoqereb6pqDibCsQ+jjPny0E91ctfHBYN8fHsJxKlmBo8OW+IrrXlu9b9zi9lwK5ySKeOinEJlR4Ql8lPwLb4lHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWFTU3Jv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13154C19425;
	Thu, 23 Apr 2026 02:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776912518;
	bh=3d7KUzhhMRXeI8oJPy4/6hc0Gek3mf0WAjET+oOME2A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HWFTU3JvsAcKiaW04q8e/1PBOm3FWaxAtCqNUG635XhUdfpQw1t23BJ6PLpv7meOY
	 zEekJPVxB7W/GVIPqiscuJO7FBjwlPXv96hBqJTuwmVmGcL0lb+N8KHqVHHUx94vD0
	 ud73/dsDYic1VqF+3CS95DVpdIv1dGgO/HwwGAer/LCxb2XL4eNNqMNvI+2SpVuthD
	 vr29Vrlyssw/6sAN/KjSWSqOfDvPXJk/XG+bBTh250aWX1d+J/2I49MBoB7zv/Qh7l
	 qjuLhGk/prjLeLJz+9lABDZAcHw0wkFNdJvDEvbiWMQ1XBjd8JJ6PukJ3bIZ1Molkm
	 LlNiX9JlIaMqA==
Date: Wed, 22 Apr 2026 19:48:37 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Nikola Z. Ivanov" <zlatistiv@gmail.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] netdevsim: Initialize all fields of ip header when
 building dummy sk_buff
Message-ID: <20260422194837.4ffede4f@kernel.org>
In-Reply-To: <20260421082005.74a3efb4@kernel.org>
References: <20260421073738.22110-1-zlatistiv@gmail.com>
	<20260421082005.74a3efb4@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280580-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA62844C5C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, 21 Apr 2026 08:20:05 -0700 Jakub Kicinski wrote:
> On Tue, 21 Apr 2026 10:37:38 +0300 Nikola Z. Ivanov wrote:
> > Additionally remove the now redundant zero assignments
> > and reorder the remaining ones so that they more closely
> > match the order of the fields as they appear in the ip header.  
> 
> Doesn't matter, now that the whole thing is zero-initialized.
> I don't think it's worth the noise in the git history.

I don't see a v2, so just to be clear -- the patch looks good,
just don't reorder the assignments please.

