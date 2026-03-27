Return-Path: <netdev+bounces-272519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IuXNMBwxmmkJwUAu9opvQ
	(envelope-from <netdev+bounces-272519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:57:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E183343DE3
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 12:57:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1CC973014848
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 11:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5759D38C2CD;
	Fri, 27 Mar 2026 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="S3bY1HHY"
X-Original-To: netdev@vger.kernel.org
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC167388E47
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 11:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774612668; cv=none; b=mlmG5M/qvCoFnmpQVN+bKogcFEC+mnToW3aXtyvMyrlMVdJ3gqcYW/3J82JQKLTugYbfRPmRKZGmSpM7ozZ6x95yV12mjYnEfYBWtGBbb6IxV7jRo9dY1SuByNiYB6reNh8HMnGdITpJfKVrZclypcOnIl1t86pAHKzYf9+kEi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774612668; c=relaxed/simple;
	bh=JAvBqRz3sGl0D1/KcMB84ps8we2NlkvZTTNxuOOJK+U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g2AVI/AKzZaJfyTkp1/D/5xpJ4ExCDciEw/4G5h92Jlk9Iiyqv2CNd3YaottxXlYC8xoI6TU+2ivIMHanDz1bbD9mFiFA7z6DMdQyI219A6BqziW+EbOs5dzqsV5FBy5b5Bkv5WK/u2buRbx/SVr+19cNc1yrZ6SgjdCJEISUyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=S3bY1HHY; arc=none smtp.client-ip=212.77.101.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 8113 invoked from network); 27 Mar 2026 12:57:39 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1774612659; bh=dhTOyR8UKqY7SHJz5GHQLjXDNtmpvnLdVDZzqV+XcdA=;
          h=From:To:Cc:Subject;
          b=S3bY1HHYPKHernBCT0RMFPrtZRssIWCxkqHfL5/fCOzfr5qUTHh/sg6N/sbNdxDJf
           jO5p17BB+e/SiBcNQlxoPOCCJzVxg3Z+LDCn1NI/8Dbe4MCEsyJRv6MLRWxb8tw2Pl
           fEXiVvm92L+rpvByZatArkAXEwTp3ZdgjZGTPFwozoeO8zVOpc6JVAWe6z1BsU+sF4
           bXlv2s2vz8e+rHmDa31b9+GF7vm6lFvFmurDdGVyCnP7a+v+H4h8ut2N1+hy+tDLJ/
           eVJcTVSl7228LX/HbBqeaVslVfxnblUjGtACKc8DnIFUZ6TWq/8In6xsNFrOzeZCfm
           Ha7teirKUZngw==
Received: from 77-236-5-223.static.play.pl (HELO localhost) (stf_xl@wp.pl@[77.236.5.223])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <jackmanb@google.com>; 27 Mar 2026 12:57:39 +0100
Date: Fri, 27 Mar 2026 12:57:39 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Brendan Jackman <jackmanb@google.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Alexander Potapenko <glider@google.com>,
	Marco Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Allison Henderson <allison.henderson@oracle.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	kasan-dev@googlegroups.com, linux-mm@kvack.org,
	netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com
Subject: Re: [PATCH v2 0/4] treewide: fixup gfp_t printks
Message-ID: <20260327115739.GB16800@wp.pl>
References: <20260326-gfp64-v2-0-d916021cecdf@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260326-gfp64-v2-0-d916021cecdf@google.com>
X-WP-MailID: 935123e2e45b6b0ec231f92885b872d7
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [weNh]                               
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[wp.pl,none];
	R_DKIM_ALLOW(-0.20)[wp.pl:s=20241105];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272519-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linux.intel.com,kernel.org,suse.de,gmail.com,ffwll.ch,google.com,linux-foundation.org,oracle.com,davemloft.net,redhat.com,lists.freedesktop.org,vger.kernel.org,googlegroups.com,kvack.org,oss.oracle.com];
	FREEMAIL_FROM(0.00)[wp.pl];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[stf_xl@wp.pl,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[wp.pl:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,wp.pl:dkim,wp.pl:mid]
X-Rspamd-Queue-Id: 3E183343DE3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 12:31:56PM +0000, Brendan Jackman wrote:
> This patchset used to be about switching gfp_t to unsigned long. That is
> probably not gonna happen any more but while writing it I found these
> cleanups that seem worthwhile regardless.

For the record, these patches are independent and could be sent separately
to the appropriate maintainers. Doing so would avoid unnecessarily large CC 
lists for people not interested about the changes in other subsystems.

Regards
Stanislaw

> Signed-off-by: Brendan Jackman <jackmanb@google.com>
> ---

> Changes in v2:
> - Drop gfp_t changes
> - Add correct CCs
> - Add minor fixups to preexisting code spotted by AI review
> - Link to v1: https://lore.kernel.org/r/20260319-gfp64-v1-0-2c73b8d42b7f@google.com
> 
> ---
> Brendan Jackman (4):
>       drm/managed: Use special gfp_t format specifier
>       iwlegacy: 3945-mac: Fixup allocation failure log
>       mm/kfence: Use special gfp_t format specifier
>       net/rds: Use special gfp_t format specifier
> 
>  drivers/gpu/drm/drm_managed.c                  | 4 ++--
>  drivers/net/wireless/intel/iwlegacy/3945-mac.c | 4 ++--
>  mm/kfence/kfence_test.c                        | 2 +-
>  net/rds/tcp_recv.c                             | 2 +-
>  4 files changed, 6 insertions(+), 6 deletions(-)
> ---
> base-commit: c369299895a591d96745d6492d4888259b004a9e
> change-id: 20260319-gfp64-7a970a80ba4e
> 
> Best regards,
> -- 
> Brendan Jackman <jackmanb@google.com>
> 

