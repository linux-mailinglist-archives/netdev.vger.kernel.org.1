Return-Path: <netdev+bounces-299282-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id muj7M35JL2px+AQAu9opvQ
	(envelope-from <netdev+bounces-299282-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 02:38:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6820A682A2E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 02:38:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299282-lists+netdev=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="netdev+bounces-299282-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C372D300147C
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 00:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6029C196C7C;
	Mon, 15 Jun 2026 00:38:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ABC215CD7E;
	Mon, 15 Jun 2026 00:38:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781483899; cv=none; b=pYzOouwHsEXXey9uEyKJ35kxNDV9b8QbVPtA8nyl2Gj7BE+QxBIVfJXLXiummEaIv2mPi37xklLaiaxyUoLUeoRodfpW971krAWJnSokCYipshJ/gToUjknlGWHtSnJjDGUyAsELOY27FfDJhHy81Hrq4nEEIE82dBR86sE6tzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781483899; c=relaxed/simple;
	bh=x7Baw3v2AaNLY94j7SiqoQfh1bcLC24lGt0gRNQISzE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QEVlviqNCflwNr8nUDW4+Bw7KCdBRz6d/Zr9z5OSXmswX7p78fm1HXbro0zZXTzJzERFs8Sl90vcU42ws3sc5LtKZJJQ6zC5kpf8cyzPdD/R4tDWxjonO/C2ZDzQffBxyDLuABxvHstV2DrkQDkqT3H5mwxSvO/DpX3ekAGo8+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id EB61560529; Mon, 15 Jun 2026 02:38:09 +0200 (CEST)
Date: Mon, 15 Jun 2026 02:38:09 +0200
From: Florian Westphal <fw@strlen.de>
To: kernel test robot <lkp@intel.com>
Cc: oe-kbuild-all@lists.linux.dev, Pablo Neira Ayuso <pablo@netfilter.org>,
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org
Subject: Re: [netfilter-nf-next:for-netdev-nf-next-26-06-14 3/11]
 net/netfilter/nf_conncount.c:502:18: sparse: sparse: incompatible types in
 comparison expression (different address spaces):
Message-ID: <ai9JaPRfvc3R_9Uz@strlen.de>
References: <202606150616.cpmJToWO-lkp@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202606150616.cpmJToWO-lkp@intel.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_NA(0.00)[strlen.de];
	FORGED_RECIPIENTS(0.00)[m:lkp@intel.com,m:oe-kbuild-all@lists.linux.dev,m:pablo@netfilter.org,m:netdev@vger.kernel.org,m:netfilter-devel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-299282-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fw@strlen.de,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,01.org:url,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6820A682A2E

kernel test robot <lkp@intel.com> wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/netfilter/nf-next.git for-netdev-nf-next-26-06-14
> head:   2354e975932dabb06fad239f07a3b68fd1809737
> commit: 64d7d5abe2160bba369b4a8f06bdf5630573bab0 [3/11] netfilter: nf_conncount: callers must hold rcu read lock
> config: x86_64-randconfig-123-20260614 (https://download.01.org/0day-ci/archive/20260615/202606150616.cpmJToWO-lkp@intel.com/config)
> compiler: gcc-13 (Debian 13.3.0-16) 13.3.0
> sparse: v0.6.5-rc1
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260615/202606150616.cpmJToWO-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202606150616.cpmJToWO-lkp@intel.com/
> 
> sparse warnings: (new ones prefixed by >>)
> >> net/netfilter/nf_conncount.c:502:18: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    net/netfilter/nf_conncount.c:502:18: sparse:    struct rb_node [noderef] __rcu *
>    net/netfilter/nf_conncount.c:502:18: sparse:    struct rb_node *
>    net/netfilter/nf_conncount.c:510:34: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    net/netfilter/nf_conncount.c:510:34: sparse:    struct rb_node [noderef] __rcu *
>    net/netfilter/nf_conncount.c:510:34: sparse:    struct rb_node *
>    net/netfilter/nf_conncount.c:512:34: sparse: sparse: incompatible types in comparison expression (different address spaces):
>    net/netfilter/nf_conncount.c:512:34: sparse:    struct rb_node [noderef] __rcu *
>    net/netfilter/nf_conncount.c:512:34: sparse:    struct rb_node *

Thanks but I have no intent to fix this.

Between rcu_dereference_raw() not giving sparse warnings but also not
providing any hints when callers don't hold rcu read lock and plain
rcu_dereference() that does give runtime coverage but results in above
sparse output I will pick the latter and just ignore these warnings.

