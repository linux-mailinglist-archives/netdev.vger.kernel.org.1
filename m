Return-Path: <netdev+bounces-262227-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eNeICUtlo2myBQUAu9opvQ
	(envelope-from <netdev+bounces-262227-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:59:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C1781C95BD
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 22:59:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2454E3073F68
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 21:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9492EBBA9;
	Sat, 28 Feb 2026 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+CPsDw1"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B79723B62B
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 21:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772315691; cv=none; b=P2+O0vnCY5+TUltk7vG3Xm/nM+F3tqK6bmjuNZPre12Rg+5jXvnoJXmDG5tG07NQDqIMuJXJSxa3/UpKSUzATfd6qjRRZTzfmHTLdHRVgR8oY09MFddtg9aTL142UFKZ5T7QthOsDDIQmmVqJ07mBoHJu+W0El57eJNcMpo4Zxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772315691; c=relaxed/simple;
	bh=ZM80T2h0pdoy5+EiuKO77NvYkuqZdQf2QrkyEIEnvDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A6JQdXtXHaY98hjzq88vI6XaRHSL6p432aC/kmhquu3IDpBUbs0JWEkSIRyxXM+ahqtmh24p+b5G77bLnE8ca4VYSLUf/XjBxIsj/mdARrTavTgMznKPdeALzNFnylaeydRy5Zbji4Hbu3ElYAuWGwptQHphWpaiWjrJ/np+8gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+CPsDw1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D89B7C116D0;
	Sat, 28 Feb 2026 21:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772315691;
	bh=ZM80T2h0pdoy5+EiuKO77NvYkuqZdQf2QrkyEIEnvDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=M+CPsDw13CI3FWLIC9UIESbCfYj5+x59hfBWakCW+8yPKxw2IEdd9eChtDeoiVd7h
	 8iTyVrf/c8rcjEZen8qHF/X0ED7EjECBsgEsGm4u9ucD3YSjC/hOkaq+YDLEA1YNkc
	 B0JSoNkBmpU4D+VjG7cDhJrAs9miB/zc2qWQN7/1zY89ctDyFffcYr9v+X/Vxd3Hvt
	 j4/Nrsk2aEgghGz+wuma/J1CXURm/cQt7cuuKlT96wQ5Jjm8AsfTyNHJMnyfemsqTb
	 oUMb84xbt7mOAZFRhE8kFVkKMBHABmv9D46WJ6lkhVZ+zYlaIfHd+YiNXkaxuP9SCQ
	 oUrRjoVmXucYw==
From: Jakub Kicinski <kuba@kernel.org>
To: kuniyu@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	horms@kernel.org,
	kuni1840@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [v2,net-next,02/15] ipmr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.
Date: Sat, 28 Feb 2026 13:54:46 -0800
Message-ID: <20260228215446.4094803-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227033903.3307272-3-kuniyu@google.com>
References: <20260227033903.3307272-3-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,google.com,davemloft.net,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262227-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 9C1781C95BD
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
ipmr: Annotate access to mrt->mroute_do_{pim,assert,wrvifwhole}.

This commit adds READ_ONCE() and WRITE_ONCE() annotations to protect
lockless access to three fields in struct mr_table: mroute_do_pim,
mroute_do_assert, and mroute_do_wrvifwhole.

> diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
> index 131382c388e9..377b5848f99c 100644
> --- a/net/ipv4/ipmr.c
> +++ b/net/ipv4/ipmr.c

[ ... ]

> @@ -2037,7 +2037,7 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
>
>  		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
>
> -		if (true_vifi >= 0 && mrt->mroute_do_assert &&
> +		if (true_vifi >= 0 && READ_ONCE(mrt->mroute_do_assert) &&
>  		    /* pimsm uses asserts, when switching from RPT to SPT,
>  		     * so that we cannot check that packet arrived on an oif.
>  		     * It is bad, but otherwise we would need to move pretty
> @@ -2050,7 +2050,7 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
>  			       MFC_ASSERT_THRESH)) {
>  			c->_c.mfc_un.res.last_assert = jiffies;
>  			ipmr_cache_report(mrt, skb, true_vifi, IGMPMSG_WRONGVIF);
> -			if (mrt->mroute_do_wrvifwhole)
> +			if (READ_ONCE(mrt->mroute_do_wrvifwhole))
>  				ipmr_cache_report(mrt, skb, true_vifi,
>  						  IGMPMSG_WRVIFWHOLE);
>  		}

Should the condition at the start of this block also use READ_ONCE() for
mrt->mroute_do_pim? The check reads:

		if (true_vifi >= 0 && READ_ONCE(mrt->mroute_do_assert) &&
		    (mrt->mroute_do_pim ||
		     c->_c.mfc_un.res.ttls[true_vifi] < 255) &&

The patch adds WRITE_ONCE() for mrt->mroute_do_pim on the writer side in
ip_mroute_setsockopt() and READ_ONCE() for it on the reader side in
ip_mroute_getsockopt(), but the lockless read of mrt->mroute_do_pim in
this condition is not annotated.

Since ip_mr_forward() runs under rcu_read_lock() (not RTNL), this read is
lockless and needs READ_ONCE() to pair with the WRITE_ONCE() added on the
writer side. The adjacent reads of mrt->mroute_do_assert and
mrt->mroute_do_wrvifwhole in the same function were correctly annotated
with READ_ONCE() by this patch, making the omission of mrt->mroute_do_pim
inconsistent.

