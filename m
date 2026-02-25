Return-Path: <netdev+bounces-260941-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALlxKrT4nmm+YAQAu9opvQ
	(envelope-from <netdev+bounces-260941-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:27:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21BCD1980C4
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:27:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 80218303D8B0
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822C83B8D78;
	Wed, 25 Feb 2026 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z8hK+HQt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EFDC3B8D5C;
	Wed, 25 Feb 2026 13:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772026026; cv=none; b=dMBamufT9uOULd1Q6FtfYlBMkN2dV3TiUkVtDshN1TpcZ4UH0Jg7Z6O4DocDRJz9vTQjaC7WKT47kBpzDV5znEuaLRoQ6s9xnmDePsdwE+i7ped25yL4tiay2VCuNdYrQ7Kx48VrYhQUZDuN7KxyO7Dhywi+/Me6STTMfadUNpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772026026; c=relaxed/simple;
	bh=SJDxOqpB+rKLyX3QxgwQ6DGI8UdwkTWWYVsinjovuRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a9ICT8JOwuxz3bPd1RJBb78i3iLr85YUdWHkIxpKisju33rSeNNfzKNA0nm6Wio/ofK6VQHq1s+zI7k7v1GypLcfUbYpnLs6xQgI/JAAQS9g0541jExMTQ1t+HBbVTy2qoH4L2U2jZJpT0AMFn0dhfbWF8QAWdxyMociGrDYkeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z8hK+HQt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C624C116D0;
	Wed, 25 Feb 2026 13:27:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772026026;
	bh=SJDxOqpB+rKLyX3QxgwQ6DGI8UdwkTWWYVsinjovuRU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z8hK+HQtKZAmEPdCT87pOuJPb0edyy4iN18icaLcwoJp5NWGCzmFo4JIO6BD9qwGg
	 zkJU9eLqVd8WwiXVHyDj5r1VH3ZfpIJ1zFlnUA6IJjvZPwf+tvt8pjarxmVrf604pT
	 gzhn5S+6kaa6898Nnsc6MX6vQg/XZMjuLkZYqRjEC76MYozIKHMJIkwPe2WucPqmDV
	 7xs6s+W14a36o0gGFNEA5dGQxQVPyqmD6DV3TGh/Qw1cakRrKi2kbCJzwHL+v1TTxY
	 HTDInKyYiqnuf9XatLIiGnsfj68DY0G4bdWNBPFpOtQz3k4w5oo+TVv73aJTe9WnLq
	 +IfdsSDchRdkw==
Date: Wed, 25 Feb 2026 13:27:01 +0000
From: Simon Horman <horms@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Jiayuan Chen <jiayuan.chen@shopee.com>,
	syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v1] atm: lec: fix null-ptr-deref in lec_arp_clear_vccs
Message-ID: <aZ74pf3rT4_SEjqb@horms.kernel.org>
References: <20260224044648.243578-1-jiayuan.chen@linux.dev>
 <aZ60sfG1tdraA0zB@horms.kernel.org>
 <aZ7Ex6c1ZeqvWLFp@horms.kernel.org>
 <beb5b67858a5e90709e67b7935430b9986306279@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <beb5b67858a5e90709e67b7935430b9986306279@linux.dev>
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260941-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,72e3ea390c305de0e259];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,horms.kernel.org:mid,shopee.com:email]
X-Rspamd-Queue-Id: 21BCD1980C4
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 10:16:40AM +0000, Jiayuan Chen wrote:
> February 25, 2026 at 17:45, "Simon Horman" <horms@kernel.org mailto:horms@kernel.org?to=%22Simon%20Horman%22%20%3Chorms%40kernel.org%3E > wrote:
> 
> 
> > 
> > On Wed, Feb 25, 2026 at 08:37:05AM +0000, Simon Horman wrote:
> > 
> > > 
> > > On Tue, Feb 24, 2026 at 12:46:38PM +0800, Jiayuan Chen wrote:
> > >  From: Jiayuan Chen <jiayuan.chen@shopee.com>
> > >  
> > >  syzkaller reported a null-ptr-deref in lec_arp_clear_vccs().
> > >  This issue can be easily reproduced using the syzkaller reproducer.
> > >  
> > >  In the ATM LANE (LAN Emulation) module, the same atm_vcc can be shared by
> > >  multiple lec_arp_table entries (e.g., via entry->vcc or entry->recv_vcc).
> > >  When the underlying VCC is closed, lec_vcc_close() iterates over all
> > >  ARP entries and calls lec_arp_clear_vccs() for each matched entry.
> > >  
> > >  For example, when lec_vcc_close() iterates through the hlists in
> > >  priv->lec_arp_empty_ones or other ARP tables:
> > >  
> > >  1. In the first iteration, for the first matched ARP entry sharing the VCC,
> > >  lec_arp_clear_vccs() frees the associated vpriv (which is vcc->user_back)
> > >  and sets vcc->user_back to NULL.
> > >  2. In the second iteration, for the next matched ARP entry sharing the same
> > >  VCC, lec_arp_clear_vccs() is called again. It obtains a NULL vpriv from
> > >  vcc->user_back (via LEC_VCC_PRIV(vcc)) and then attempts to dereference it
> > >  via `vcc->pop = vpriv->old_pop`, leading to a null-ptr-deref crash.
> > >  
> > >  Fix this by adding a null check for vpriv before dereferencing it. If
> > >  vpriv is already NULL, it means the VCC has been cleared by a previous
> > >  call, so we can safely skip the cleanup and just clear the entry's
> > >  vcc/recv_vcc pointers. Note that the added check is intentional and
> > >  necessary to avoid calling vcc_release_async() multiple times on the
> > >  same vcc/recv_vcc, not just protecting the kfree().
> > > 
> > Sorry for coming back to this a 2nd time.
> > After thinking about this some more I'd like to pass on
> > some feedback from the AI powered review.
> > 
> > I'll put the full text below. But in a nutshell: could you clarify
> > why it is necessary to avoid calling vcc_release_async() multiple times.
> 
> 
> Hi Simon,
> 
> Thanks for the feedback.
> 
> 1. Regarding why it is necessary to avoid calling vcc_release_async()
> multiple times: when vpriv is NULL, it means a previous call to
> lec_arp_clear_vccs() has already freed vpriv, set vcc->user_back = NULL,
> restored vcc->push, and called vcc_release_async() for this VCC.  Calling
> vcc_release_async() again on an already-released VCC would redundantly
> set flags, set sk_err, and trigger sk_state_change() on a socket that is
> already shutting down. While this may not cause an immediate crash, it is
> semantically wrong — the VCC has already been properly released, and we
> should not repeat the teardown sequence.
> 
> That is why I intentionally placed the entire cleanup block (including
> vcc_release_async()) inside the if (vpriv) guard, rather than only
> guarding the vpriv dereference. The NULL vpriv serves as a reliable
> indicator that this VCC has already been processed by a prior iteration.

Thanks. I think it would be useful to include an explanation along
those lines in the commit message.

> 2. Regarding the Fixes tag: the AI suggests pointing to 8d9f73c0ad2f
> ("atm: fix a memory leak of vcc->user_back"), but that only introduced
> the entry->recv_vcc cleanup path. The entry->vcc path has had the same
> bug since the beginning — if two ARP entries share the same VCC, the
> second call dereferences NULL vpriv via vcc->pop = vpriv->old_pop.  My
> patch fixes both paths, and the entry->vcc path bug traces back to the
> original code, so Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2") is correct.
> I've verified that the entry->vcc path is independently triggerable with
> a seperated reproducer [1] (it's not worth to put it into selftest for
> legacy module)
> 
> I also don't think splitting this into two patches makes sense — both
> paths are in the same function, exhibit the same bug pattern, and the fix
> is identical.

Understood. I agree the code changes make sense to keep together
in a single patch. And retain the Fixes tag as you have it.

...

