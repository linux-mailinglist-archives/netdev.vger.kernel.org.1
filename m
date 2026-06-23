Return-Path: <netdev+bounces-301482-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id q3j5B4buOmreLwgAu9opvQ
	(envelope-from <netdev+bounces-301482-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:37:26 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AA86BA0E0
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 22:37:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=QY3skTBh;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-301482-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-301482-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A30273006785
	for <lists+netdev@lfdr.de>; Tue, 23 Jun 2026 20:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1077E3A6EEB;
	Tue, 23 Jun 2026 20:36:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127AE3A6B9C;
	Tue, 23 Jun 2026 20:36:35 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782246996; cv=none; b=o/isvaYZMJdhSwSKOOuTAS6NpTyoD8Yxmp1H8ChJZ56/wnTS04Hs5HLy/hIoKwjwxK3B6EnMEm6FaKweEOxf8xeenpVHQBnOwy5OUgxAKzXeB6OV2sZnuuhu4r4YKf7m0REHmkiHKbnOcHXANxXFlGOjl3Ls5qE7bLhwyquOJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782246996; c=relaxed/simple;
	bh=2Gyr82snPt9y2zAFsuCqcD8MRiMv0Xzu72h1HyGDZls=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j0kdZ4SV34eYOFNRx1XHo/boz4OV1fYMrLDiiu9xDBEsxjmmbS+C+TEO6Cbj0MW1FQBtSY2ywaFgWSwsO9GhJER2QUnng3ot0MbDf3gqg3EX4FNysLkXXZTVjgLIpRXaNDLGw7DDaMx6Re+MsZBH5VCO7yf+rLk7tBsCaOz2BK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QY3skTBh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68A071F000E9;
	Tue, 23 Jun 2026 20:36:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782246994;
	bh=xpg/nHxXH9DlFY0d8gQErFvMzvxfYuzDRVc9FFshC90=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QY3skTBhCHtOu23oGQCl4jM38Td9r6cSBj/iGhYxKEiUhLZ1uaboezkJdGfBHkN83
	 3JmGdOHcO8mV0V5Dg+Mo3O6V7z/MRyhzSdTrgkgbo7E7YS2lyosssgjOw4HJcxSjIJ
	 9+Ixcc6Nip6a1jcbiKXII5FMHvKaeSFCxJXL2c5WQQnfJLTOBsIjHiUqeHUtKpeDns
	 kBKD+NmVvBMMAM3KXSyefHhJ23ttzPmO6WnncAjp9RylR9VJURbcYpuLCkZcBNAjuD
	 QOpiZsaBIlVGcDip3STrDaUiZbk66/GlV/CeUCKGlrRQqwr+p2Uvj5kg0fUgP0WSDt
	 lNfGociHc36Kg==
Date: Tue, 23 Jun 2026 13:36:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Tushar Vyavahare
 <tushar.vyavahare@intel.com>, <netdev@vger.kernel.org>,
 <magnus.karlsson@intel.com>, <stfomichev@gmail.com>,
 <kernelxing@tencent.com>, <davem@davemloft.net>, <pabeni@redhat.com>,
 <ast@kernel.org>, <daniel@iogearbox.net>, <tirthendu.sarkar@intel.com>,
 <bpf@vger.kernel.org>
Subject: Re: [PATCH net-next 0/3] selftests/xsk: stabilize timeout test
 behavior
Message-ID: <20260623133633.34c6fad7@kernel.org>
In-Reply-To: <ajqfDYznpCU18C2P@boxer>
References: <20260616154955.1492560-1-tushar.vyavahare@intel.com>
	<CAL+tcoDr0gtCPeGi1yOUtg+ZD2YxEbjAy41LBgG63b8-=CStcw@mail.gmail.com>
	<ajJsMj0QMOF5I8qq@boxer>
	<20260622160706.0b4a27bf@kernel.org>
	<ajpLuDNCu2PHS78l@boxer>
	<ajqfDYznpCU18C2P@boxer>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-301482-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:maciej.fijalkowski@intel.com,m:kerneljasonxing@gmail.com,m:tushar.vyavahare@intel.com,m:netdev@vger.kernel.org,m:magnus.karlsson@intel.com,m:stfomichev@gmail.com,m:kernelxing@tencent.com,m:davem@davemloft.net,m:pabeni@redhat.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:tirthendu.sarkar@intel.com,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,vger.kernel.org,tencent.com,davemloft.net,redhat.com,kernel.org,iogearbox.net];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 21AA86BA0E0

On Tue, 23 Jun 2026 16:58:21 +0200 Maciej Fijalkowski wrote:
> On Tue, Jun 23, 2026 at 11:02:48AM +0200, Maciej Fijalkowski wrote:
> > last refactor from Tushar broke BIDIRECTIONAL test case when HW is test
> > target, but not on veth, so let me test these changes locally and then get
> > back to you.
> > 
> > BPF CI runs xskxceiver on veth so this has not been caught. Seems my/our
> > focus should be to enable xskxceiver HW tests on any kind of
> > environment/infrastructure.
> > 
> > Gonna get back to you by the EOD.
> > Maciej  
> 
> Ah I replied on other thread I guess, so let me repeat:
> 
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> Tested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Great, thanks!


