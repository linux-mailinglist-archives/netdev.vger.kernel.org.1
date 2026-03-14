Return-Path: <netdev+bounces-267747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yK4TKh17tWki1AAAu9opvQ
	(envelope-from <netdev+bounces-267747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:13:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF0C528DA03
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 16:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D2F1301DD96
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 15:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E859D2ECD32;
	Sat, 14 Mar 2026 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s0xiJomY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63121C5D59
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 15:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773501209; cv=none; b=BilJjB0FPMlz9YhzMWs/wu6tr/7Xziv50zLjoCHuSIBDGD76Qf1z79mLHgXqetOA+OVmB6rRksUHXYAPlgaaQCUmb5l//rvAgp4yvf7qRbJGttpAQFeAS5+EjMaunSeG3N+ehFDGusXQdSfLp2jD6u95owWeGiqwBqZsyN2NDR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773501209; c=relaxed/simple;
	bh=WHizFYmIry56OpDo0uge9SNh3o7uX3ISwBlv4bw6UCI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ls9xSlRhXwBYeRpP+dTjLbAD8AtPFJgNcMSvSKTIoHOL3kue+SI4/R0nH+heZul7Y3eG9Qx9TusvO7QofnJNAdUkualaFnPjye38Td9F4ZewdTxRCIyhpptaGOSY6/+Us1eHX04Pg6Nfwmst4mZ3iKkEBHZtjeoJNpZ+HGsT1+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s0xiJomY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D6BBC116C6;
	Sat, 14 Mar 2026 15:13:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773501209;
	bh=WHizFYmIry56OpDo0uge9SNh3o7uX3ISwBlv4bw6UCI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s0xiJomY/kqz2SMx2xzgjhda5Gn2iTrFLX7yij0NGEflBpEude46o4ab+7zRS6pb4
	 8gpbS0Z+pNldMCGrn2+maz6pA5QsNEYaa+f70WDxzp+XGyoqxSj5iJ/XuMxMRVhIkp
	 uW0CzxNZi9AIdgLZcYFEED6gFkatyD0ED4uYGZB8MMfsUdUYHN8WEqvHDgvdWjmjX4
	 +FWG4ld1S2a7rkrHjVsqei2eEmuZFemVY64w8d0ta124pOJILK2I7nezqFENa0WBK+
	 zlQ1yEcH7u33DEWAibcYxMCgAMacyC2XgKpqvv9K9ffF2bit5x9E5zt0p4K9NFveC7
	 nj4shqo33sIYw==
Date: Sat, 14 Mar 2026 08:13:28 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Nguyen, Anthony L"
 <anthony.l.nguyen@intel.com>
Subject: Re: [PATCH iwl-next v4 1/2] ethtool: treat RXH_GTP_TEID as
 intrinsically symmetric
Message-ID: <20260314081328.2635a33d@kernel.org>
In-Reply-To: <IA3PR11MB8986CA12EE22E9C07BCE7E83E545A@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260312093101.1589970-1-aleksandr.loktionov@intel.com>
	<20260312093101.1589970-2-aleksandr.loktionov@intel.com>
	<20260312074225.27a4a7b3@kernel.org>
	<IA3PR11MB8986CA12EE22E9C07BCE7E83E545A@IA3PR11MB8986.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267747-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,osuosl.org:email]
X-Rspamd-Queue-Id: CF0C528DA03
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 13 Mar 2026 11:28:29 +0000 Loktionov, Aleksandr wrote:
> > -----Original Message-----
> > From: Jakub Kicinski <kuba@kernel.org>
> > Sent: Thursday, March 12, 2026 3:42 PM
> > To: Loktionov, Aleksandr <aleksandr.loktionov@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen,
> > Anthony L <anthony.l.nguyen@intel.com>
> > Subject: Re: [PATCH iwl-next v4 1/2] ethtool: treat RXH_GTP_TEID as
> > intrinsically symmetric
> > 
> > On Thu, 12 Mar 2026 10:31:00 +0100 Aleksandr Loktionov wrote:  
> > > +	/* Strip TEID before checking - it carries no src/dst asymmetry  
> > */  
> > > +	rxfh &= ~(u64)RXH_GTP_TEID;  
> > 
> > No need for the u64 cast.  
> 
> But without (u64) it will work only while it defined as implicit int
> #define 	RXH_GTP_TEID	(1 << 8)
> 
> When it will be defined as BIT(8) or unsigned int it will break.
> What you'd recommend preventing such issues in the future?

We will convert the 1 to 1ULL once we actually allocate the previous 31
bits? The type is only u64 because it may come from a UINT but the upper
bits must be zeros right now.

