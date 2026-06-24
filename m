Return-Path: <netdev+bounces-301699-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GnVDJ0n6O2oAhQgAu9opvQ
	(envelope-from <netdev+bounces-301699-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:39:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD26BFB97
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 17:39:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=XjTFPpK7;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301699-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301699-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 202403007366
	for <lists+netdev@lfdr.de>; Wed, 24 Jun 2026 15:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D9A73B8130;
	Wed, 24 Jun 2026 15:38:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28441A3160
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 15:38:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315509; cv=none; b=UUjbEiG/E0jcmJevZsjxdNnrf8qkHfcCvx2NQCl3gLkH7JXQhEQYXq8jj5lD9GsRbFfCtXvpeYJXlyKts2KDhm94r1/v6z2rIG/V3kYjlLDLwxLxKH3LA2N0fBfDvS/tfCGUyelD6VaY5GgSA7DksiUn/mmyTbHh6xh6eSye2iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315509; c=relaxed/simple;
	bh=jMQMrzTbpWoy7qpTtCXjVhtjJmgz81CeZ3D3zItZ9+Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IVgcPe2ZWoOseqEvPwtf51uERQJekfi0A11XN4XY4RzpXTUVijpXcj27N6BIol17BqRUFQpCQGdwWMMUHRcXI76ZyUsrXnjzz7oQZOeQ1l0IOJNNkqwI0s3GqqRvtuXuWMpR3swDWTqasPlcQQ2WrKH1qvZpaGOFEZGFXpch9JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XjTFPpK7; arc=none smtp.client-ip=209.85.216.65
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-37cab825ec9so972578a91.1
        for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782315507; x=1782920307; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=m7clZiyk0OMH0b3QigtKufFqqXyOmFKPxCwbw/xgdsM=;
        b=XjTFPpK7vXbY+OUV01tCzO23vHIyZAfrmUS4rnp13/dy/6Zl+doCiAotAJhGstxheF
         92Uzv50TZaTv7ouvyKi1p9InndEYZSLrZt8O83biCyzp69yOQ94naHRjBxCyY6cIV5nz
         zAvCduRyXgfTpX4isF+OA2tCldxR6t6l8LsP/Q1yevf4rAMvL2muKh9quYHYDQIAWOcs
         lE0jRxcssk3KwWTk0qIkd821wtqC6MExVHHYsoAxUYECQvrQI6cl5kq9iYwBdkXxcU80
         o5UNLHwCvzLW9RIb4SYSiuOCtXVEN3wA1G3JSenPCL4SPgw/255Ey8Ygc8i5iqYU9SHL
         dNyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782315507; x=1782920307;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m7clZiyk0OMH0b3QigtKufFqqXyOmFKPxCwbw/xgdsM=;
        b=miQeYEH8IFjeREBowFKwznQb5SHlPi51JFC4h3yuCZu7OuWUoIpL474TCavvcTucog
         qsSo46d43zuGoKSidLfOsRMjfLhzrSx/BKkBdvCn6ozgrqd/C46XoTfhxQUB/Rfbs3c1
         +j+kloXbB9G3NVRlWHN1C3yzVQ9773XrZZYFar/cVRc8X2ePF1H9Z8ccWa3bqCJu4uLG
         yg0PEhi4s8RlutgFSOwIeM/JRgvAPBSfyI97J0Hlrf1XiujLJP6Xa1qBMjLWQ3w9g3VX
         Skp5aumAes9RM7W0V1AMM2/CqihBnI/stYlcF/hcJjxk0UxydsGuDb1gQ/a1ufdB+YPr
         qiBw==
X-Gm-Message-State: AOJu0YzClm8YljS1sjY2zBt4UxzJf9eHrLZ4s0RFJrX7Gl+OQKX7M9F6
	SfjsoSzxoSgCEBltFXT+Jf1xPOLUepdDUsp+yzsVPgdPx1T7iwUMAwl0
X-Gm-Gg: AfdE7cm2XVDYrSt5eV5VG8sJFPQF5MGnnhZYnfsIbopEApfwuYTb8Au4d/wUdsBLecl
	z3a0S/1zmCzQO9y8ksEAd6dNk+QupBVf1DrviWVCeIhstffOExfq5eeBvv3NZtCTIAhHKrPUS+U
	AyGqxbC9a9kZ0PSyTBgNVme8sXaGFrBWFFejhtnCvcC3VA1aRp1Qn8hkq5p+pdItax/rfP0rEcJ
	sMSBLoY9sOgDRKvl5PPMxiyKorPJVdnbq1u+K+YM2RVC79O7v2aTmNsN3vC2AcQYGKpsF4LBSkS
	DWtDLLalbPg31Aau8+9VK8xrjNSfrA0QDLXBdDP46EwDJSnppCC8gkokKD/bXwgjLsX/W0hbmdd
	MWLr+pM4CL/rpPExo3/P8EoLez019LksKteql3iWl6a5F7V7sSU+1twzikEZY8BGjgg1GYtUM78
	vWZrn7L8WryQvK6p6T
X-Received: by 2002:a17:90b:44:b0:36a:5d1f:7ac with SMTP id 98e67ed59e1d1-37de429f053mr4028561a91.3.1782315506896;
        Wed, 24 Jun 2026 08:38:26 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37df39db8dfsm26648a91.2.2026.06.24.08.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 08:38:25 -0700 (PDT)
Date: Wed, 24 Jun 2026 08:38:20 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	kerneljasonxing@gmail.com, bjorn@kernel.org
Subject: Re: [PATCH net 0/7] xsk: fix AF_XDP multi-buffer Tx descriptor
 reclaim
Message-ID: <ajv23_r4M3FGrFNN@devvm7509.cco0.facebook.com>
References: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260623133240.1048434-1-maciej.fijalkowski@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-301699-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,gmail.com,kernel.org,redhat.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:netdev@vger.kernel.org,m:bpf@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kerneljasonxing@gmail.com,m:bjorn@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E6FD26BFB97

On 06/23, Maciej Fijalkowski wrote:
> Hi,
> 
> This series fixes several AF_XDP multi-buffer Tx paths where descriptors
> consumed from the Tx ring are not consistently returned to userspace
> through the completion ring when the packet is later dropped as invalid.
> 
> The affected cases are invalid or oversized multi-buffer Tx packets in
> both the generic and zero-copy paths. In these cases, the kernel can
> consume one or more Tx descriptors while building or validating a
> multi-buffer packet, then drop the packet before it reaches the device.
> Userspace still owns the UMEM buffers only after the corresponding
> addresses are returned through the CQ. Missing completions therefore
> make userspace lose track of those buffers.
> 
> The generic path fixes cover three related cases:
> * partially built multi-buffer skbs dropped by xsk_drop_skb();
>   continuation descriptors left in the Tx ring after xsk_build_skb()
>   reports overflow;
> * invalid descriptors encountered in the middle of a multi-buffer
>   packet, including the offending invalid descriptor itself.
> 
> The zero-copy path is handled separately. The batched Tx parser now
> distinguishes descriptors that can be passed to the driver from
> descriptors that are consumed only because they belong to an invalid
> multi-buffer packet. Reclaim-only descriptors are written to the CQ
> address area and published in completion order, after any earlier
> driver-visible Tx descriptors.
> 
> The ZC batching path can also retain drain state when userspace has not
> yet provided the end of an invalid multi-buffer packet. To keep this
> state local to the singular batched path, the series prevents a second
> Tx socket from joining the same pool while such drain state exists.
> During the singular-to-shared transition, Tx batching is gated,
> pre-existing readers are waited out, and bind fails with -EAGAIN if the
> existing socket still has pending drain state. This avoids adding
> multi-buffer drain handling to the shared-UMEM fallback path.
> 
> The last two patches update xskxceiver so the tests account invalid
> multi-buffer Tx packets as descriptors that must be reclaimed, while
> still not expecting those invalid packets on the Rx side.
> 
> This is a follow-up to Jason's changes [0] which were addressing generic
> xmit only and this set allows me to pass full xskxceiver test suite run
> against ice driver.

There is a fair amount of feedback from sashiko already :-( So the meta
question from me is: is it time to scrap our current approach where
we parse descriptor by descriptor? (and maintain half-baked skb and
half-consumed descriptor queues)

Should we:

1. do desc[MAX_SKB_FRAGS] and xskq_cons_peek_desc until we exhaust
PKT_CONT (if the last packet has PKT_CONT, return EOVERFLOW to userspace
and do a full stop here)
2. now that we really know the number of valid descriptors -> reserve
the cq space (if not -> EAGAIN)
3. pre-allocate everything here (if at any point we have ENOMEM -> cleanup
locally, don't ever create semi-initialized skb)
4. construct the skb
5. xmit

If at any point there is an issue, the cleanup is straightforward. That
whole xk->skb goes away, no state between syscalls. Thoughts?

