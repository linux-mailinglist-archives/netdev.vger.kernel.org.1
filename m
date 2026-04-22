Return-Path: <netdev+bounces-280381-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4GqVJFeo6GnEOQIAu9opvQ
	(envelope-from <netdev+bounces-280381-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:52:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1536444FBD
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 12:52:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A9D643026C05
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 10:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E4C3CD8BC;
	Wed, 22 Apr 2026 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SoQZstCl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5DD3CAE61
	for <netdev@vger.kernel.org>; Wed, 22 Apr 2026 10:48:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776854897; cv=none; b=mrktqVhdh28Oqa6GAYcMrNrviRgihG3DLxA+Ri8r6tlNBbJWV/o3kLv76Iz/kGdNiVIjm+ZdvQxlvAEHd0mZC8nDWFVF/xH35y6vwqremX03GAsBSNN4zXO+r2MuWpCHSmTTuKy4bGhSHTMtXE+TID2YFynOizYBZUchLaH4nXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776854897; c=relaxed/simple;
	bh=6mQ5LyQB4fRfCoB0R+sQQG1+3BTD84pOGcxptMUQH+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AXq0aGmpgW5hZFTscRvwx0LHB97AhPWQwGqRoJvLQF06CTURazFSBUnYA+ZdXDCt+cEaoHiWppHnQIhVnMSSRDwPvtrbWarEYUWb5Q0ufQOqOQggwn0hK2UAvw0IfPNecQ6ZWEWCNjoJxdPyUSWTJqbZAANhClCghU3gCh+Bhw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SoQZstCl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88F0DC19425;
	Wed, 22 Apr 2026 10:48:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776854896;
	bh=6mQ5LyQB4fRfCoB0R+sQQG1+3BTD84pOGcxptMUQH+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SoQZstClHLhnHdwrCNUO85JgbXi82BhXuvlv3zmPM+PubBOBI5anpVsaj8E8Ij5j8
	 HkS+NfxqVRkDZnuoCyJcIRkMA08L1YU9kbex0wreKDBEVi9+rLVT+/+98nJGb9yepW
	 +EbXKyQJlNfj4ZWBG5U3kvbyJNOzKAWJX36UQxrkSGSoCntW3Cjqh+DCYSfL9XpFWI
	 n4ou976kzwMGAf9oGldQ+zQ4eFhF6YD6sKAfN7g6kURRUlB+O5qlmMvzOsrSg9eQs7
	 Rk0g6/xXeDhCkbv1PO25bx80Fu8dwUBO9UkECDpi/lBKI1C7RyNfMRaa09Aw+8oVqP
	 qS20PkpIm5dKA==
Date: Wed, 22 Apr 2026 11:48:06 +0100
From: Simon Horman <horms@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, corbet@lwn.net,
	skhan@linuxfoundation.org, alexs@kernel.org, si.yanteng@linux.dev,
	dzm91@hust.edu.cn, linux@armlinux.org.uk, mst@redhat.com,
	jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, xu.xin16@zte.com.cn, wang.yaxin@zte.com.cn,
	jiang.kun2@zte.com.cn, linusw@kernel.org,
	jihed.chaibi.dev@gmail.com, arnd@arndb.de, tytso@mit.edu,
	jiayuan.chen@shopee.com, gregkh@linuxfoundation.org
Subject: Re: [PATCH net-deletions] caif: remove CAIF NETWORK LAYER
Message-ID: <20260422104806.GL651125@horms.kernel.org>
References: <20260416182829.1440262-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260416182829.1440262-1-kuba@kernel.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-280381-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,google.com,redhat.com,lunn.ch,lwn.net,linuxfoundation.org,kernel.org,linux.dev,hust.edu.cn,armlinux.org.uk,linux.alibaba.com,zte.com.cn,gmail.com,arndb.de,mit.edu,shopee.com];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[horms.kernel.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F1536444FBD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 16, 2026 at 11:28:28AM -0700, Jakub Kicinski wrote:
> Remove CAIF (Communication CPU to Application CPU Interface), the
> ST-Ericsson modem protocol. The subsystem has been orphaned since 2013.
> The last meaningful changes from the maintainers were in March 2013:
>   a8c7687bf216 ("caif_virtio: Check that vringh_config is not null")
>   b2273be8d2df ("caif_virtio: Use vringh_notify_enable correctly")
>   0d2e1a2926b1 ("caif_virtio: Introduce caif over virtio")
> 
> Not-so-coincidentally, according to "the Internet" ST-Ericsson officially
> shut down its modem joint venture in Aug 2013.
> 
> If anyone is using this code please yell!
> 
> In the 13 years since, the code has accumulated 200 non-merge commits,
> of which 71 were cross-tree API changes, 21 carried Fixes: tags, and
> the remaining ~110 were cleanups, doc conversions, treewide refactors,
> and one partial removal (caif_hsi, ca75bcf0a83b).
> 
> We are still getting fixes to this code, in the last 10 days there were
> 3 reports on security@ about CAIF that I have been CCed on.
> 
> UAPI constants (AF_CAIF, ARPHRD_CAIF, N_CAIF, VIRTIO_ID_CAIF) and the
> SELinux classmap entry are intentionally kept for ABI stability.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> I think we should accumulate such patches over the coming days on a separate
> branch. CAIF is a no-brainer IMO but other removals may be more controversial.

Reviewed-by: Simon Horman <horms@kernel.org>


