Return-Path: <netdev+bounces-302840-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id LoVjLH33QmpCKgoAu9opvQ
	(envelope-from <netdev+bounces-302840-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 00:53:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EE7C6DF1A8
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 00:53:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cLrLjUsm;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302840-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302840-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DFFA430088AA
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 22:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6FA4395AF8;
	Mon, 29 Jun 2026 22:53:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C098E2D592D
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 22:53:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782773625; cv=none; b=PMCDM2+0yS/aGi1CKUIeirsYXJTvuU0oevtf6NWY522B3+QWMDYzxyIm5dfR9VKY4FinLSi0QPj6N8V1SMxwmKYRP8vdRkcN1oKGlMVK3DTL8gBBy2t+S27MWvDnvJt5F7EQk/Tan6Q1OlHDpgNF/I7FQ0nnNggmy56j6SEbBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782773625; c=relaxed/simple;
	bh=Eimbm83VcnNh9iAyz4eSKXIS5dn85BJj6roRS8IzYgM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FYhJsxPTBbHSF9t4LNakpuCDa94tnb84jKCAo1OFZFYMpv1SSmKTdazNpEzCa9y6rf4Ckb50xTnIuuihx98evY8kQUppnIfF9mVw8kiZZyyO+i4+Lva8hM2yAq3EJzE6qMt5yhZDAqXf5Ms9IoHh4n7k8KvcszbczI6aMAuf9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLrLjUsm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9011F000E9;
	Mon, 29 Jun 2026 22:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782773624;
	bh=mQm2Cpdl7FUXTMgD3IZug5m2bpmaRdES+acA5DhlVW4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cLrLjUsmPAx7ouea3DL7B/uiISyRyGu/yohUtSjZxm+ui87QxAUY07QcQjR5/9gQK
	 yZdMROLg5kPBQJhSdl4yqRvOfTgS+gBLjaJeZ5ER22d9U23qA9ZkSsR3fXohvIgTkW
	 isdMP3VY97vwVLQGF+uzHGwU5EDoJxZTedQL3THu2gb5hFquDeE5L7/hPG9mDpUy3p
	 If0rZpIHe3iJrMjpfu2RHcGFf0UW2G1fTJZphfhglXBsWb3DT6Hd2R/4lxJMCBQo4I
	 b8L2ejeIy8pSI20BTJ8CV9yH7TJdrk3bR8sBlMuUhZ41IuzP0orlrt0/VvA69SbZpD
	 yfZtthA7mbVXA==
Date: Mon, 29 Jun 2026 15:53:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>
Subject: Re: [PATCH iwl-next v5 2/2] ice: implement symmetric RSS hash
 configuration
Message-ID: <20260629155343.7fed8291@kernel.org>
In-Reply-To: <IA3PR11MB8986053B156CBA043045A525E5E82@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260626054730.1126969-1-aleksandr.loktionov@intel.com>
	<20260626054730.1126969-3-aleksandr.loktionov@intel.com>
	<20260626152636.1e48330f@kernel.org>
	<IA3PR11MB8986053B156CBA043045A525E5E82@IA3PR11MB8986.namprd11.prod.outlook.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-302840-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:aleksandr.loktionov@intel.com,m:intel-wired-lan@lists.osuosl.org,m:anthony.l.nguyen@intel.com,m:netdev@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0EE7C6DF1A8

On Mon, 29 Jun 2026 14:10:08 +0000 Loktionov, Aleksandr wrote:
> I understood on TEID; I will drop the ethtool core patch.
> 
> One question before respinning the ice feature patch: ice GTP RSS profiles
> include TEID in the hardware hash fields. Since TEID is not generally
> symmetric across UL/DL, should the driver:
> 
>   1. report RXH_GTP_TEID honestly and let the core reject symmetric-xor
>      when GTP flow types are part of the preflight check;
> 
>   2. hide RXH_GTP_TEID while symmetric-xor is enabled, even though that
>      misrepresents the hardware hash input;
> 
>   3. reject symmetric-xor for configurations where GTP profiles include
>      TEID; or
> 
>   4. change/program the ice GTP profile, if possible, to exclude TEID
>      under symmetric-xor?
> 
> My preference is (1) or (3), but I do not want to encode the wrong uAPI
> semantics.

Do you have access to any GTP experts?
If your customers want the TEID in the symmetric hash then they
probably know better what makes sense than me after reading about it
for 1 minute.
We may just need a better commit message on the first patch "TEID is
intrinsically symmetric" is not true.
Or maybe the driver / profiles are not doing the right thing.
Please dig deeper.

