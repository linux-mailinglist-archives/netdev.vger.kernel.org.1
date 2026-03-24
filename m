Return-Path: <netdev+bounces-271249-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAVYLM3gwmmPnAQAu9opvQ
	(envelope-from <netdev+bounces-271249-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:06:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B8931B324
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 20:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30C583005653
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 19:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 825A2371D09;
	Tue, 24 Mar 2026 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uZ2/m73F"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F945340282
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 19:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379185; cv=none; b=DQe6o5guA4O53nAXDkr6JrJenkhcuWWLsLXVsxSPZsmJbBgXdkvVo+g5fO+hpsgNkUs6kdJL6Ppl5N/Vq/aLRGLiem62U17whhSfU4DjqO9OXpCUwo3bHjGPfrCqRNUTv5RoAe1s3j1ZqjwtjMCQTomTR9TXMZgS01u2+OBEeeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379185; c=relaxed/simple;
	bh=SvzlX1uuzmY7Mp9BmMubxQRH2ngFBpBlaBMBmLIepjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aRhGi1cYsGZbaZskgYn+NjEtjsHZFt6km0AZmLm06nQqP+RQB1iyofD6Ix6py1Jlkdkf25OTWi43qhIc7xvPqtxgYXgy7Lez9eQhMwtKDgghj5je7LWl1UNGwsMdwtpD2gxWIU4rKCp2wgqtdgThcyY/++0jQZXRMlzUYHpESRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uZ2/m73F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F404C2BCB1;
	Tue, 24 Mar 2026 19:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774379185;
	bh=SvzlX1uuzmY7Mp9BmMubxQRH2ngFBpBlaBMBmLIepjg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=uZ2/m73FMmCmshrmqNIi4AoGcmkmnGrXYXYcXI6Awj3uN2jzlvsh2Yvn0BDUxPOuX
	 Is6jGpQ8FyIpbYBKu6PI6tt1n2QDaw91q6j7fGcAkDYzQ+z//ctZb59N1i8lweZfA0
	 gRb7bMd/BPC0zXBXhQ46j9wr8VkVpigsov/T74N7MOivQwPSnW2ltOtIFhZiWZYv1I
	 uM2V0mHWdDnoq6/riDQF8bIJBFLBsANsWteRc+BA65Vx/GtxsUVb38JODoNMdA6BBr
	 3tiHlcqGxtWlIv2S2hnHieHCkbzzhNCbYs+59uSnVe+LmimmfnNszK/AdCMfZvnJsP
	 Jfn2CcxVC8qdQ==
Message-ID: <154d612f-2621-488c-9c9e-984062345ea9@kernel.org>
Date: Tue, 24 Mar 2026 13:06:23 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] vrf: Remove unnecessary NULL check
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, petrm@nvidia.com,
 lirongqing@baidu.com
References: <20260324155521.525292-1-idosch@nvidia.com>
 <20260324155521.525292-2-idosch@nvidia.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260324155521.525292-2-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-271249-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dsahern@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 23B8931B324
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 3/24/26 9:55 AM, Ido Schimmel wrote:
> The VRF driver always allocates an IPv4 dst entry for a VRF device and
> prevents the device from being registered if the allocation fails.
> 
> Therefore, there is no need to check if the entry exists when tearing
> down a VRF device. Remove the check.
> 
> Note that the same is not true for the IPv6 dst entry. Its creation can
> be skipped if IPv6 is administratively disabled (i.e.,
> 'ipv6.disable=1').
> 
> Reviewed-by: Petr Machata <petrm@nvidia.com>
> Signed-off-by: Ido Schimmel <idosch@nvidia.com>
> ---
>  drivers/net/vrf.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
> 

Reviewed-by: David Ahern <dsahern@kernel.org>



