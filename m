Return-Path: <netdev+bounces-260689-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id y8i/GVlCnmlzUQQAu9opvQ
	(envelope-from <netdev+bounces-260689-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:29:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC19B18E61A
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 01:29:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9C44301753E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 00:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09561F09B3;
	Wed, 25 Feb 2026 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ttqg69Mo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E83E2745E;
	Wed, 25 Feb 2026 00:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771979350; cv=none; b=VjE9V3Pq6SsBG2PUXle6eKwGxFXP8fyX9de3Hotst4cIfsUD1uAL26zqR550n0NtwUC0RMjuJm6pYQbIGxrtqLeCCUlqT4zI7CKAM1zcSi+dniT+7Zqg4oHZAjj8NU+AwvVCaYzgzNO0W4Duu8+G52sXcIn5gtBi4WNOAows3nQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771979350; c=relaxed/simple;
	bh=7ALb1kZoYHhr6fCH/0pLJS+Yv7Z/WU4NO+3HQ/JttDY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iSguMc7wKLNIuZ2tpPXzhzVRABWxK5B3yrssNQ3cwC9iFrtMxP/1lMid5gdVbbBAN3Rn3FvHXQVq3/zkXGI5r+eDIGEH5Ne/M0UPunHoB2Z9iAQI/GPv3vFvLh22dlrG7bEhQZDmilKe6euFKwV0FR759W1KgtXYJk6gkjhhMcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ttqg69Mo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF8B9C116D0;
	Wed, 25 Feb 2026 00:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771979350;
	bh=7ALb1kZoYHhr6fCH/0pLJS+Yv7Z/WU4NO+3HQ/JttDY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ttqg69Mo+EPbqvRI4VFa/xIHyiwgd/D2nlvv1RzX/QcFfDpnxxDhm7u0sMNABH/Es
	 b319ISSD96pmGOQWKJSFNt3Jx/2oc4fgeUfozl4FNskLwGV/KmyppChCxIMbgEkGhN
	 eexgRQopa+H3wiNmEvTUtYS4mpG0G9Yaa031RCB8FnW8FQvBBreS1YNmTT/WcxzwJa
	 u43OmKEK2c6AP7AW46ILxDju9IH4irhamb9uPsAZFNAjiYeEZcbHR2mOupMaR36CHO
	 0xj5IHWwNlTcWNc8Mjks4buqJp87Q0fvk5fVhGmeZ0dArR9sYT1wBmfGHjmLTh79t/
	 peVliIRbYo/fA==
Date: Tue, 24 Feb 2026 16:29:09 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: davem@davemloft.net, linux-bluetooth@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [GIT PULL] bluetooth 2026-02-23
Message-ID: <20260224162909.047a1431@kernel.org>
In-Reply-To: <20260223211634.3800315-1-luiz.dentz@gmail.com>
References: <20260223211634.3800315-1-luiz.dentz@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260689-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EC19B18E61A
X-Rspamd-Action: no action

On Mon, 23 Feb 2026 16:16:34 -0500 Luiz Augusto von Dentz wrote:
> bluetooth pull request for net:
> 
>  - purge error queues in socket destructors
>  - hci_sync: Fix CIS host feature condition
>  - L2CAP: Fix invalid response to L2CAP_ECRED_RECONF_REQ
>  - L2CAP: Fix result of L2CAP_ECRED_CONN_RSP when MTU is too short
>  - L2CAP: Fix response to L2CAP_ECRED_CONN_REQ
>  - L2CAP: Fix not checking output MTU is acceptable on L2CAP_ECRED_CONN_REQ
>  - L2CAP: Fix missing key size check for L2CAP_LE_CONN_REQ
>  - hci_qca: Cleanup on all setup failures

Pulled (by Paolo), thanks!

