Return-Path: <netdev+bounces-299916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id NqkLFCt7MWrHkQUAu9opvQ
	(envelope-from <netdev+bounces-299916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:34:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C34EF692388
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 18:34:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=debian.org header.s=smtpauto.stravinsky header.b=RIzm9+Pn;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299916-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-299916-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=debian.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9B2B531C2FDD
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 16:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DF646AF14;
	Tue, 16 Jun 2026 16:23:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BAF1E8320;
	Tue, 16 Jun 2026 16:23:05 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781626987; cv=none; b=X9HU0e0ThFRk8Ixb+j5hIZ2cXVRbhxRC2t/CDIjCL3A6PSxpLQa1g1KcOo5eeJdgDHISAzhXPqpeQ9QQl3EG6aIpunva+cpLcf9Wj6/pYfjbKLEqB00XkpQyhV/CW/NqmmqK2U+xBqV3bMRskwo2q/4L1jrWtReHDQRycCgAinw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781626987; c=relaxed/simple;
	bh=IXsEAwgWvm+ambQ9+3AGPStMs5cLfc6BF+yzHqadZSo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uBlXoQ1fH9wig+WjDaQM5CgInoCBwswiFj25kXDPfTv204t+gz3ugxmNnv0wTCCrE/QV13mFSu3lWqFv7nA65wH3TFru1xF2mD6eK+nG1u+p2i1uip+cUrMBHeFS+V1BY/mEYecD5tRSeNFE3ffORVMcrDN/yn/ZoxDB2ArXGuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RIzm9+Pn; arc=none smtp.client-ip=82.195.75.108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=IRo7D4zv4MpQ9wRyO+ve3dpnbeFV2Oef1k+e+ZUWC0o=; b=RIzm9+PnNC5LEFOKtIe0rhQkOw
	yRbg8nyVKvPht00btnI5Uu1JqpkM+9V9lpIstwBWoUizaMWByMMM6QWCGjCPJqsSvWbRp6CvcK6UW
	8JBvEegSB7dv51EMsVNZdbkq0ZF1fxnXD2ANCZ+b060SJbLZdm8aOt1Nr1LkU6pac4RrSY49JU+EB
	kc830XpfwH+NzHYbS0ql09r0GHzssD+6eaH+crVD8wiTdzVYwRXb/e3+45WRwGQiIlZzE6QseWZpY
	ZxNVpHUr5d5eZdKuN5K6iWetwugTLjdb7KidVFDkgOArjiVmz3bLhv4Bzu0AkJGW8ZIlVr5VhYpvo
	aHci+zWQ==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wZWYz-00DyOR-2K;
	Tue, 16 Jun 2026 16:22:58 +0000
Date: Tue, 16 Jun 2026 09:22:52 -0700
From: Breno Leitao <leitao@debian.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Shuah Khan <shuah@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH net-next 2/2] udp: convert udp_lib_getsockopt to sockopt_t
Message-ID: <ajF4Odi_L28LdIXC@gmail.com>
References: <20260612-getsockopt_phase2-v1-0-7b01f1f5d106@debian.org>
 <20260612-getsockopt_phase2-v1-2-7b01f1f5d106@debian.org>
 <aiy7ZR7Yz2Z4Ioyd@devvm7509.cco0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aiy7ZR7Yz2Z4Ioyd@devvm7509.cco0.facebook.com>
X-Debian-User: leitao
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[debian.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:sdf.kernel@gmail.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:willemdebruijn.kernel@gmail.com,m:shuah@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:kernel-team@meta.com,m:sdfkernel@gmail.com,m:willemdebruijnkernel@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299916-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,gmail.com,vger.kernel.org,meta.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C34EF692388

On Fri, Jun 12, 2026 at 07:10:15PM -0700, Stanislav Fomichev wrote:
> On 06/12, Breno Leitao wrote:

> >  int udp_lib_getsockopt(struct sock *sk, int level, int optname,
> > -		       char __user *optval, int __user *optlen)
> > +		       sockopt_t *opt)
> >  {
> >  	struct udp_sock *up = udp_sk(sk);
> >  	int val, len;
> >  
> > -	if (get_user(len, optlen))
> > -		return -EFAULT;
> 
> [..]
> 
> > -	if (len < 0)
> > -		return -EINVAL;
> 
> I see this part now in sockopt_init_user, but you mention that it's a
> transitional helper. When we drop it, will we loose this <0 check?
> Maybe keep `if ((int)opt->optlen < 0))` here for backwards
> compatibility?

Good idea. I will do it and respin (once net-next reopens).

Thanks for the review,
--breno

