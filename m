Return-Path: <netdev+bounces-262664-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLS0FFmapWnxEgYAu9opvQ
	(envelope-from <netdev+bounces-262664-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:10:33 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A291DA6C0
	for <lists+netdev@lfdr.de>; Mon, 02 Mar 2026 15:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D37FC3092231
	for <lists+netdev@lfdr.de>; Mon,  2 Mar 2026 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC4A3FB07D;
	Mon,  2 Mar 2026 14:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OIhhSGMJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D37E3FB057
	for <netdev@vger.kernel.org>; Mon,  2 Mar 2026 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772460270; cv=none; b=L8oP/aGHnA6mCkO+DW4NyvRWyDpAZS6t8qIJQBbXOy41WINX4A+KV5Xrmg70FhbxZsqpJzFXgXNW5vOWYwj6S1QFCfvUgy6H/VhPFhyb8sC0FeB5HAcr+6EJdrX1AHsms789ZqxZmeLzrs47fkHvHt2efdBtW4ST2fwiNME8d9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772460270; c=relaxed/simple;
	bh=urEvhoueRVfKr1e1jrKpMr72QqDM1fli72+QQFwLYjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FVP2N+JQlqCNT81qexY0bsmCBOqfxJiZpLSqtwfwOvwa44K1+HtQDXgWMUIaot0QSLqrorcvvht5ylQWLAPdFaKVZDmqq6x3JyhrbxRbQHhOIg1ebW5t9plEgakWa5B/bpbr3FPBmcpKo9p+USd1DHu4o2SOPZ2ynsYUBfc6eQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OIhhSGMJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64E89C19423;
	Mon,  2 Mar 2026 14:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772460269;
	bh=urEvhoueRVfKr1e1jrKpMr72QqDM1fli72+QQFwLYjc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OIhhSGMJhLPATY2rJj9fA/R222miqiBCou/c+HvCJgl+gfkUc+UxIgxl6aR8qkAhA
	 6KZqiVXqCu/iwOU/16rAblRx8Xa9z77pmHKY8lzr8udwenMNYWN6Pvar0qEQP0JS/+
	 m+prKxRmT66DhnIISQiz1AqnN23NogMyMSATnsX9Io68wR3ss82ZJpWhKoDixUVJp3
	 CwqKNRehRkrSl3YWC3wxShS5TAaiuSF/IGFHYf7fUwhWM99m7wbpYnIewsRs2PmhOE
	 p07PKpKRlHlZ/HTe5jMcbh8G4abir8rP2IVB6Cg4QryJPkjXp5JOZH6Gu6KGmBI1vN
	 8qFW58Bh6stxw==
Date: Mon, 2 Mar 2026 14:04:25 +0000
From: Simon Horman <horms@kernel.org>
To: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
Cc: "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>
Subject: Re: [PATCH iwl-net v2] ice: dpll: Fix compilation warning
Message-ID: <aaWY6Yd8jFWEKtqr@horms.kernel.org>
References: <20260223143214.241797-1-przemyslaw.korba@intel.com>
 <aZ7IDXaOOnwcnuuq@horms.kernel.org>
 <PH0PR11MB490409B2463A17F8E6F64D43947EA@PH0PR11MB4904.namprd11.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <PH0PR11MB490409B2463A17F8E6F64D43947EA@PH0PR11MB4904.namprd11.prod.outlook.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262664-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,intel.com:email,horms.kernel.org:mid,osuosl.org:email]
X-Rspamd-Queue-Id: B7A291DA6C0
X-Rspamd-Action: no action

On Mon, Mar 02, 2026 at 12:01:12PM +0000, Korba, Przemyslaw wrote:
> > From: Simon Horman <horms@kernel.org>
> > Sent: Wednesday, February 25, 2026 11:00 AM
> > To: Korba, Przemyslaw <przemyslaw.korba@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org; netdev@vger.kernel.org; Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>
> > Subject: Re: [PATCH iwl-net v2] ice: dpll: Fix compilation warning
> > 
> > On Mon, Feb 23, 2026 at 03:31:55PM +0100, Przemyslaw Korba wrote:
> > > ice_dpll.c: In function ‘ice_dpll_init’:
> > > ice_dpll.c:3588:59: error: ‘%u’ directive output may be truncated
> > > writing between 1 and 10 bytes into a region of size 4
> > > [-Werror=format-truncation=] snprintf(pin_name, sizeof(pin_name),
> > > "rclk%u", i);
> > >
> > > Fixes: ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and dynamic pin discovery")
> > > Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
> > 
> > Hi Przemyslaw,
> > 
> > I agree that it is good to address this problem.
> > But is it a bug?
> > 
> > It seems to me that of the 8 bytes of pin_name, three are available for %u.
> > So values up to 999 can be safely formatted.  And I suspect that
> > pf->dplls.rclk.num_parents is always significantly smaller than that.
> > 
> > If so, I'd suggest this is iwl-next material. And should not have
> > a Fixes tag. But you could cite the commit that introduced the problem
> > something like this (the part starting with 'commit' is the syntax for
> > citing commits):
> > 
> > Introduced by commit ad1df4f2d591 ("ice: dpll: Support E825-C SyncE and
> > dynamic pin discovery")
> > 
> 
> Thank you! I sent it to next, with updated commit message 😊

Thanks, much appreciated.

