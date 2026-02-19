Return-Path: <netdev+bounces-259466-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SPbwORcTl2n7uAIAu9opvQ
	(envelope-from <netdev+bounces-259466-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:41:43 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 506EB15F2DE
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 14:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D65683052B91
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 13:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B77833D6D9;
	Thu, 19 Feb 2026 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PHaHdW2u"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3965A33A9FE
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771508391; cv=none; b=vCVg6Q5kFEoOudQWU69MbwyQpTe3UCfMfEx2f04YdzLfYspCNVB8o8W1qNuhCX5/oV9WQpaQ0OTi4DUlAF+GWiAIp424nB0TwEfox5q4Y2fjWTkvockq88eSGvg09Xyn9pXlfZH2EZaHfqFbaFzj9hti0QPv8kPtPLR5TGdw5ZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771508391; c=relaxed/simple;
	bh=N9OBe8gFy/5lAWdIQtGeULCTj8GBSBFYRaakur4X1Og=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M1qVsJE1yypCWqtvMescBYPuU1+lJSl/zDUeTxJmV/V/kbnZc59U55xB/9b19zlh5xu74TW5uuKWBnSuC3PGph11wPNTaVlqCC7RST88Ue9eRMpOYC1b+IHJUO8M2xwNPqB4fb1Lzd7nFAU1aXQBTUH9Ru8nZ4/CJi9/Lnxsp5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PHaHdW2u; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-c626bd75628so318412a12.3
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 05:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771508389; x=1772113189; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HG2fzVv7T3rTOzyp2iO5eb5j3k2FtcwtFNElfJxNd7I=;
        b=PHaHdW2urufR1SGoyLGVXpdRJpOBQEIRo/1aoLLGqhJkRky12HF8N4bpv5rqKHzNMY
         MvRoRZ7pc4a8ogQRuLah1WvhKBDeJds93zvLOOn6OVOrJSaI1lFvEriLBZUS2wBj5cxk
         XydcGIm8EJodQ7yEhxImibGQnTUIuL6J5P5JKH3gkbwd7HIfPqnRB8yx8Ifa3uVPgLhs
         gK0L2CeIjKlYfy4tTFmN7WzAk9DyGg9puiU68Dhx8nRHpY2uN5agWL6TA43qGvCecah3
         mGoA4y2LalD+p1HVNFLlgFLbpkharacYrUlADRPxilRpc4BpQt9/tmhXJNhVjTvwQKmv
         LRHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771508389; x=1772113189;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HG2fzVv7T3rTOzyp2iO5eb5j3k2FtcwtFNElfJxNd7I=;
        b=poVvsovpDBGkMLwZXxkML+4OTWPHlEKVxTWa7c/HlQLK0HBqNTuqqr6bO2mx3D1oRK
         bRM9o25VOD16FshAKs0Hjnnuw6M2SgcOacvEsorx31MGguZ9pJSk5hpGlzWmN4s8CJTa
         mXBNMXS3XOdK/cAv78v/EDZLCr2Nd6Cu1/MH0vfK1O5mzwz3RfyVzjuyg1u4Mnr+LQv4
         r3a0wDxDm6XI9c4ns8rW7tmQt0e1jGHW0AhrIrgi8JbuHs6VwUN7cs/Oj56cewHffEKF
         aYmkUQk+b+q/y5X4YObdQpObi0dIEu67oKt0yM9uq8lSyCqaVzv6k+LyboifpSQi4YCo
         JHMA==
X-Gm-Message-State: AOJu0YzT4ofvxLr2eBNoSjkngQdHW7n8qOWWb5kQysmZSrjH9aXZH+Ci
	FVGUK5nBiOPZTEPXEDvV/ToJpCDoMuECBpq6JKHdjKtMVU0p5wq0QdOM
X-Gm-Gg: AZuq6aIxCwFqXMjTrTEoDpYvcqYzmthydx5Ffva2XjXtDQ/6ClcWjQej49U+KJo+M5y
	hK36wn/du71L5QmBmHsjafrzqpEnF2g9NXeqj1O7TI6BE6UJH8LpbFHQ4E35+zEL+hTmrVO0CVA
	/aUe1zPqagxu5jY/nfGTxuDlxsQIlJU9YakH6Mlr2e1CJoBbPB4daV2pGB0k8O8OCGXeHF6/g0c
	jr3D0RilGx1E2q8ssGBGV80x8KM64+58uDLxyAy/85LsTlIN1byyyOUQQlbPEDoesDilr3utjrd
	buKbg4UQaq7Q8Ps8HxN/LzxGpAjET+xL4rDsHYErusmJFO1RAU0kkABE7iJ0ARJkJwNGZqIV1IV
	cjDDa+CBdcvVZvo/xPGhzLtiUGtqAepISBFgkmjhHNj9lNwu5stMIIGYs01iuqrU3ayo+Opl+Gs
	fjfyda6yNXpGxPfqkFoSVLsyoFLeIOh4ZTBZ2Oxg==
X-Received: by 2002:a17:90a:d410:b0:33b:bf8d:6172 with SMTP id 98e67ed59e1d1-358891e543dmr3895608a91.34.1771508389464;
        Thu, 19 Feb 2026 05:39:49 -0800 (PST)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3589d8fdf1csm151982a91.17.2026.02.19.05.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 05:39:48 -0800 (PST)
Date: Thu, 19 Feb 2026 13:39:42 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Bohac <jbohac@suse.cz>, Liang Li <liali@redhat.com>,
	Nikolay Aleksandrov <nikolay@nvidia.com>
Subject: Re: [PATCHv2 net] bonding: alb: fix UAF in rlb_arp_recv during bond
 up/down
Message-ID: <aZcSnpcDrIWogpb8@fedora>
References: <20260214091541.89659-1-liuhangbin@gmail.com>
 <20260217164355.7139ab53@kernel.org>
 <aZVByEOAYdR3WF4q@fedora>
 <20260218161110.14f1551a@kernel.org>
 <aZcRS0cUsAOgktMf@fedora>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZcRS0cUsAOgktMf@fedora>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259466-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 506EB15F2DE
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 01:34:10PM +0000, Hangbin Liu wrote:
> On Wed, Feb 18, 2026 at 04:11:10PM -0800, Jakub Kicinski wrote:
> > On Wed, 18 Feb 2026 04:36:24 +0000 Hangbin Liu wrote:
> > > On Tue, Feb 17, 2026 at 04:43:55PM -0800, Jakub Kicinski wrote:
> > > > On Sat, 14 Feb 2026 09:15:41 +0000 Hangbin Liu wrote:  
> > > > > Fixes: e53665c6eaa6 ("bonding: delete migrated IP addresses from the rlb hash table")  
> > > > 
> > > > Ah, also AI says the issue existed already in 
> > > > 3aba891dde38 ("bonding: move processing of recv handlers into
> > > > handle_frame()")
> > > > not the exact trapping instruction but the hash table was used from
> > > > recv_probe so at least a UAF would happen.  
> > > 
> > > Not sure if I understand correctly. Do you mean we still able to access
> > > rlb_arp_recv() after setting recv_probe to NULL?
> > 
> > Simply put -- wasn't there a case where rx_hashtbl was accessed after
> > being freed in 3aba891dde38 already? That commit is a year and a half
> > older than the commit you had under Fixes.
> 
> AFAIK, the UAF/null-ptr-deref issue for rx_hashtble is introduced by
> 53665c6eaa6 ("bonding: delete migrated IP addresses from the rlb hash table"),
> which added rlb_purge_src_ip() in rlb_arp_recv().
> 
> In 3aba891dde38 ("bonding: move processing of recv handlers into handle_frame()")
> it only let other CPU still able to access rlb_arp_recv() after we set recv_probe
> to NULL. But it doesn't trigger a null-ptr-deref.

Oh, I remember now. rlb_arp_recv() also calls rlb_update_entry_from_arp(),
which could access rx_hashtbl. You are right, the fixes tag should be
3aba891dde38 ("bonding: move processing of recv handlers into handle_frame()")

Thanks
Hangbin

