Return-Path: <netdev+bounces-264443-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GIixK3ibqWnGAwEAu9opvQ
	(envelope-from <netdev+bounces-264443-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:04:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 145892141DB
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 16:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4EC0A30F57ED
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 14:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D48E3B582C;
	Thu,  5 Mar 2026 14:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kASKSyhP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7D23B5822;
	Thu,  5 Mar 2026 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772722757; cv=none; b=k+Ss8vPEdJlHFR45HElucc9Tbnxn64bX3TJ/t3XHd82mpAr7DY0AOwD4A+F2s3A34dTJR9mOxJY0RmG56G8Y0rO/ZyDr9Vfgwbe5kCRXSXVY7z3n7sV2q7Jwo2P/mnW7nfV1+/yKOiL6MdwFR8ZwWFOywhAah4nLi8KykRT1+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772722757; c=relaxed/simple;
	bh=3gau5pG01KTTt4gEFZecCxSVw0aAS8XD2UN3kTCjwq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NidPCQNpgnFcjcfBvBRGwF7/KUhmKI51armrf700f0xZaqauupzKlbRJ+8cefPEX6k4DbW7noMyGX2JN6SoMJbjcnrc9LswtHkTCimCtO80S7yLb4MS9gXEg1WajDhbJmYZgQw6Z/lmAxFInG9VAKXBSvJJtR/KZbK+iZ57exS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kASKSyhP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5E96C116C6;
	Thu,  5 Mar 2026 14:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772722757;
	bh=3gau5pG01KTTt4gEFZecCxSVw0aAS8XD2UN3kTCjwq0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kASKSyhPP31lIWhcYosKNNj463+TUPNWIIAvUEtOMKaHvpbJELFjzINyZyXWlicwZ
	 9Npn1BaMu3UwcVwALDgmMC9qflHmKYallSokd27VgKjnCq7PvvOS5rharoLZ2eOt44
	 w295EATUFH4dMz145NYogmRWJShttctzhzdXtaAJr3R1D3SuBy5z8q/1iEzXIqI2QW
	 ADqPArN4JfTF0iC0/ROs90SaMoTnHeo6YVtGhHuQ7g0jg3TnXFStR+6AnDx9Yx7nQJ
	 G8LWNT5oGu6s7MjE2dEXg1uZHNuALubarlA/WrfO7VK8f3T9k5MZuaEbtRGGSWvd2+
	 K7IcJczmPQRaw==
Date: Thu, 5 Mar 2026 06:59:15 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Akhilesh Samineni <akhilesh.samineni@broadcom.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, andrew+netdev@lunn.ch,
 horms@kernel.org, willemb@google.com, daniel.zahka@gmail.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 jayakrishnan.udayavarma@broadcom.com, ajit.khaparde@broadcom.com,
 kiran.kella@broadcom.com, sachin.suman@broadcom.com
Subject: Re: [net-next 1/3] psp: Support resetting statistics on a device
Message-ID: <20260305065915.1e6e3284@kernel.org>
In-Reply-To: <CANQF7iAYmKUj_WeDgf4dg941Zxm5bBVzz=yvX17PmyKMOYe6ng@mail.gmail.com>
References: <20260302195352.1015990-1-akhilesh.samineni@broadcom.com>
	<20260302195352.1015990-2-akhilesh.samineni@broadcom.com>
	<willemdebruijn.kernel.270f71617ce0@gmail.com>
	<CANQF7iAYmKUj_WeDgf4dg941Zxm5bBVzz=yvX17PmyKMOYe6ng@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 145892141DB
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
	TAGGED_FROM(0.00)[bounces-264443-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,lunn.ch,kernel.org,vger.kernel.org,broadcom.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Thu, 5 Mar 2026 16:24:05 +0530 Akhilesh Samineni wrote:
> The PSP supports dynamic administrative states, allowing it to be
> enabled or disabled during runtime. Currently, statistics are
> persistent across these state transitions, which can lead to baseline
> drift and complicate telemetry analysis.

Baseline drift? What _concrete_ use case do you actually have in mind?
Do you know of other stats that get reset when something is disabled 
in networking?

