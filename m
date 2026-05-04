Return-Path: <netdev+bounces-284088-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFMiECsu+Wma6QIAu9opvQ
	(envelope-from <netdev+bounces-284088-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:39:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D63D4C4E8F
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 01:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5EDB2301D4EC
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 23:39:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172F53DDDCA;
	Mon,  4 May 2026 23:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QeYaQTwk"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E607637B3F4;
	Mon,  4 May 2026 23:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777937958; cv=none; b=JbhpEIj3IDIqYZgBUIdQzeZMqb1MTrMD6Ls2+M81C8tNtil5XbSkoMsssk/HNxDASR/CwHGxo7gRzNriPX4DyrnhrGT8rFZ5m9ztoXgGchJBhtXM1lfT+GGO5H7QKAT32QfLUSAnB7C0LNh8qPShxu7V9NlAA8amj+gLnx6WdPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777937958; c=relaxed/simple;
	bh=rGhCAgv7V+Aw2yNHCHAsZ1MiCQDgCZexQb57zy/+Wto=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mAWDcxgZZ93FTo6W0quzqab5GSiVK5Cy5yRnLL3p6XVPvWOFetV2j8vXcE9ij31SD5uwNo5CRy/zLVEUpuhIJoGAmOMGuiKa0Yw6h6Z/JjkC/ziaOaUBYyCAohJixbD70dQs+Yd4zs+ZbYHIman3TpnRFqnTlEPAzZ6nGISWSaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QeYaQTwk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8F2C2BCB8;
	Mon,  4 May 2026 23:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777937957;
	bh=rGhCAgv7V+Aw2yNHCHAsZ1MiCQDgCZexQb57zy/+Wto=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QeYaQTwkspFYexYjdtm/g3tch402fhCdjjnsFH6OilZB5yCV70ZaSP8BB//uJ5JmK
	 GPS5Y43vKC0N4eq8VZF0iVK0vuhuUHM8Br6tXoH6Q2hfMrUpEifVYsrdPFBp+tM9lD
	 lu8JjaaUsLBYbraoVxS6uBBHDqXdBUAq5a0eJ74uvbHmIRLiCVt8hLOkKqcIS4PP/g
	 icqRIgxccUqUuJjvVHD1tC3V0upu+Hpzpl25L6qqZepj6Ge+/ossmPKvSAAweT8ySw
	 dik1KUi9zIBN3OqALQ4RqfTCeCkMIfcrqKafHAW1lhym5WJPc0yOsBdEp6honMUc7w
	 nR8Adg+AamVwA==
Date: Mon, 4 May 2026 16:39:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Andrea Mayer <andrea.mayer@uniroma2.it>, Shuah Khan
 <shuah@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
 <skhan@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 0/7] seg6: add SRv6 Mobile User Plane (RFC 9433)
 behaviors
Message-ID: <20260504163915.4a8b028e@kernel.org>
In-Reply-To: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
References: <20260505-seg6-mobile-v2-0-9e8022bdfdb6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 9D63D4C4E8F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284088-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Tue, 05 May 2026 01:30:10 +0900 Yuya Kusakabe wrote:
> This series adds the in-kernel data path for the SRv6 Mobile User
> Plane (MUP) architecture defined in RFC 9433.  SRv6 MUP integrates
> GTP-U mobile traffic into an SRv6 transport domain by mapping the
> 5-tuple (TEID, QFI, R, U, PDU Session ID) into a single SID, allowing
> operators to replace the GTP-U overlay between the gNB and the
> upstream UPF with native SRv6 forwarding while keeping the radio side
> unchanged.

Could you switch to posting this as an RFC until you gather some review
tags? Our CI require manual intervention to add the necessary iproute2
patches, I suspect there may be some uAPI changes therefore requiring
iproute2 changes here.

