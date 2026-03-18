Return-Path: <netdev+bounces-269209-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aGs8Itswu2kEggIAu9opvQ
	(envelope-from <netdev+bounces-269209-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:10:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D045E2C3BC3
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 00:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B780D3047AFF
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 23:10:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7219B32A3F3;
	Wed, 18 Mar 2026 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTAk4c6e"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A801F2B8D;
	Wed, 18 Mar 2026 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773875413; cv=none; b=f1xmjGJM6K6tWi4Zq0uwlwIaf4HPjteodz88QY+pUfr7KuAVH6DOw7WvaZKeUXoRWKVwUTCEawUYA/n6yn9T0tKLcRIQdsTnhLM2iWK0+FzeQuZpHXjFpLog+/dGS19l7XnJF0Gi7KJIOF5zki8Hxq0qZhNCdZ6+zLJ/PPufhcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773875413; c=relaxed/simple;
	bh=zi48I0G/7a4ARouMrnL+S7iTsSegBnlrGL+TUTW0yW4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bt8gc+lnDCD6BJ5Xxvnv/05H/KqV4IsZoIyCKGKS0VSR8a72L20F0hK1yfpJPPyFF0Ix6rE+xRcOQ33vaJtF+VdsCu+sCNccEIDZGgEnJf80ZyG5IxeI+rKY2Wak0UAE5q+jqg2fHXs7YG1wUwirxUsXSlJ2F7JIFZvuzwFONRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTAk4c6e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9828DC19421;
	Wed, 18 Mar 2026 23:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773875412;
	bh=zi48I0G/7a4ARouMrnL+S7iTsSegBnlrGL+TUTW0yW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QTAk4c6eBV4QS/aV+bCCmKBHBnJMRv8F0zwDWDc8T5BF352io/ANWzVgfxprEveY2
	 +vBQd7P5DW+k07FBGf9uIvot7SX9eAphnjzzO8gawzJ2FpNXDzlwr9ksFAoU/ZTDHx
	 /dRRj+5CNGNHk0YJRLuxnwww2lJtIRwoQvLeVD5IcCf8nZjOKveDf3R7UErmJ28Cqi
	 pwUThmhUuEkVw4B86JbJA+wOfmWJOhvVLp4qUaDUla55hokbjws+JRTxyjqdapYGxD
	 aJBrqAhorlO5KLR+nVEfD4BT1bWjkPp8cAKuga79ryyyqiFUUg533+YLIYzPljE2KO
	 8UWYgJtXSSSbg==
Date: Wed, 18 Mar 2026 16:10:10 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Shuah Khan <shuah@kernel.org>, Stanislav Fomichev
 <sdf@fomichev.me>, Mina Almasry <almasrymina@google.com>, Wei Wang
 <weibunny@fb.com>, David Wei <dw@davidwei.uk>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 bpf@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next 5/6] selftests: drv-net: add netkit devmem RX
 test
Message-ID: <20260318161010.2d7338b5@kernel.org>
In-Reply-To: <abrRDNi79H9ircl1@devvm11784.nha0.facebook.com>
References: <20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-0-b53c8cd72b23@meta.com>
	<20260316-scratch-bobbyeshleman-tcp-dm-netkit5-v1-5-b53c8cd72b23@meta.com>
	<abns9COj7WagFtZ8@mini-arch>
	<abn3rJGXXyDYSNzA@devvm11784.nha0.facebook.com>
	<abq97UD7CHR7bdod@mini-arch>
	<abrRDNi79H9ircl1@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269209-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,redhat.com,kernel.org,lunn.ch,fomichev.me,fb.com,davidwei.uk,vger.kernel.org,meta.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.945];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D045E2C3BC3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 09:21:32 -0700 Bobby Eshleman wrote:
> > > IIUC, we could have main() do something like:
> > > 
> > > for env [NetDrvContEnv, NetDrvEpEnv]:
> > >     with env as cfg:
> > >         [...]
> > >         ksft_run(tests, args=(cfg,))
> > > 
> > > 
> > > And then the tests could call helpers that check cfg.netns to use the
> > > nk_{guest,host}_ip6 addresses when true, otherwise use the regular
> > > addresses?
> > > 
> > > It should be doable if I'm following your drift.  
> > 
> > Yeah, yeah, this plus some small changes here and there (to pass your
> > new -n in the netns mode for example).  
> 
> Sounds good, I'll give it a look.

I haven't actually looked but double check ksft_run can actually 
be called multiple times. We may have some global state :S

