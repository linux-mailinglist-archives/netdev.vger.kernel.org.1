Return-Path: <netdev+bounces-270189-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIR1GeBhvml4OAMAu9opvQ
	(envelope-from <netdev+bounces-270189-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:16:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C112C2E454B
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 10:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06BFA30210D1
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 09:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667951459FA;
	Sat, 21 Mar 2026 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PePE/I3m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420A7221FDE;
	Sat, 21 Mar 2026 09:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774084546; cv=none; b=c2cHt+oEGezxSd+h2ebeFDKtRRsVkJ8jXHCV3Q/JyZeucO78pBqxNikq3e+qzY/+dffT1qJnSeXEufrcGgfA4ZpYWWhILnsRctZfJxmHIHJ2Gkud+CBDk8Mhncu/NsFs+4rS848tctihq+cngOP4GxPhTjEWbyAnpH/FAQiKQCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774084546; c=relaxed/simple;
	bh=NYECknoiRRYM5IDDtkno8VJoweUdma3+I//bOJcctlI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ht6a/bAqOLWlDsRDqC5bsZ/PAw0PzwH9xNWaaefAXy6lMPIFjdbv09jjMz1iIkq6fBXOVRp2q8tLGWbHfvu/x9OpSm8BhAY1ZFbK0B+J2fwbDllJR/+TJeH2qSz9LHO61RMwfCj/ByhGbtCBFGlaxgbPbXCHuxWBSuvqn4qPnmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PePE/I3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B96FC19421;
	Sat, 21 Mar 2026 09:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774084546;
	bh=NYECknoiRRYM5IDDtkno8VJoweUdma3+I//bOJcctlI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PePE/I3mtSHMTt8dPt1P4+6tGB1c63Im3wj1wYsCjjNHk+Z/6iXJbGQIm9poWxz1g
	 fdNWUwuJYR0R9HMdWpGM92skzsK5xc7NfmDlB7RZ7McWFdjAcPZZAopzRjgL0SVcAO
	 /QjcMhvS1r95gGUPRrSL+4hHdFxL/E/N+l6aq8lSEmKaUC1eTtL3YVO5+MfRqo/uAi
	 tbHJT78Qkf5C4GxYBRDRAai7Ysw12TOiWGzjsobzrtZHbwyRZkleD0pVYFjGdQn9v1
	 PvqvSYgENPkEj04QrWhxWhVoU7l0GgPgxj4GHOqdP/WCdcY9/Gh6zOEb63XNZLNUAM
	 K1jBi7lLecn4A==
Date: Sat, 21 Mar 2026 09:15:41 +0000
From: Simon Horman <horms@kernel.org>
To: Bhargava Chenna Marreddy <bhargava.marreddy@broadcom.com>
Cc: vikas.gupta@broadcom.com, andrew+netdev@lunn.ch,
	linux-kernel@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
	vsrama-krishna.nemani@broadcom.com, michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com, ajit.khaparde@broadcom.com,
	rajashekar.hudumula@broadcom.com, davem@davemloft.net,
	edumazet@google.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v8 09/10] bng_en: implement netdev_stat_ops
Message-ID: <20260321091541.GS74886@horms.kernel.org>
References: <20260319055124.1350670-10-vikas.gupta@broadcom.com>
 <20260320112704.2065290-1-horms@kernel.org>
 <CANXQDtaMYzKS6KBR4mGmRgtQNvxX=ppBG8mgqZsxW=rQaKNFug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANXQDtaMYzKS6KBR4mGmRgtQNvxX=ppBG8mgqZsxW=rQaKNFug@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270189-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: C112C2E454B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Mar 21, 2026 at 01:57:12AM +0530, Bhargava Chenna Marreddy wrote:
> >
> > Can this race with bnge_close_core when reading bn->net_stats_prev?
> > bnge_close_core writes to bn->net_stats_prev while this function reads
> > it without any locking.
> >
> > Looking at bnge_get_stats64, it uses rcu_read_lock() before accessing
> > bn->net_stats_prev. While this won't cause a crash like the other two
> > issues, it could result in torn reads on 32-bit systems where reading
> > u64 is not atomic, potentially returning inconsistent statistics to
> > userspace.
> >
> > Should bnge_get_base_stats also use rcu_read_lock() when reading
> > bn->net_stats_prev?
> 
> Thanks, Simon.
> 
> Regarding the RCU suggestions: bnge_get_queue_stats_rx,
> bnge_get_queue_stats_tx, and bnge_get_base_stats should not
> require RCU protection here. Unlike ndo_get_stats64, these ops
> are synchronized by the netdev instance lock. Since the writer path
> (bnge_close_core via ndo_stop) also holds the netdev instance lock,
> they are already mutually exclusive.
> 
> Do you agree, or am I missing a case where these ops can be called
> without that lock?

Yes, I agree. And sorry for not thinking of that before forwarding
this review.



