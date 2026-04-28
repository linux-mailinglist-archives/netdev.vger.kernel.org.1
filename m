Return-Path: <netdev+bounces-281995-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0EDxNAHp8Gn2awEAu9opvQ
	(envelope-from <netdev+bounces-281995-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:06:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A67D489959
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 19:06:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CB4531887D5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 16:40:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CC35328B71;
	Tue, 28 Apr 2026 16:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="KKe1Fh4r"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956DF330644
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777394416; cv=none; b=RF0ahLJaZrZ9QYCVlQK4qHwA/7D1qO6Xu669k+qO+epczHc12OyfWJNixj9n6ic1yC9wwPoQZLkue0Bf01/0Ba6Zs+AYL5ucFlNMGAITXzcxWGlLezHqeBaQeEDytRDERZz0ckZ7hpP4qEbE6l1GJ3U2lTSkelu/a+09MSF7ldM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777394416; c=relaxed/simple;
	bh=/H/qYEml20skAVQTa8A0yHC53jjrmwvl6PPvPrmVfy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BHmgyJ0UKfYd+e1kMHwavaUfqXiOm0XOmiCe3LuIW2Fe9aoS8htIeb4JzirkyxPlpF7syIfcoh2HFscfVt6wx17Z8dbv2e2mg8yVEhnKCQakWjV+joyfLOdPouFp8O47yyZCi5sBonCLaVQqYp4eMUj7mjitTsYJBNAMoIu7HsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=KKe1Fh4r; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=eKhg67p/Q/vgzvwHgsfFuYjbdk49SIaClYWCRzGtz+k=; b=KKe1Fh4rrJ27mEZWOW/03Womj+
	1lJqc7r5rddVXbTIV9NHYzMU6tKvIZEEcWe7+FVD1cHTa+3d8Sviza3CkTIch0iIsGV4C0MRJc+H5
	5Bg4RXbNFm/pO+9c15m5ZdYvW4lKgWmMPHJNf6Rqma35vAAupDRZ4srAE4klSZTXEpEQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wHlTk-000NIk-6r; Tue, 28 Apr 2026 18:40:08 +0200
Date: Tue, 28 Apr 2026 18:40:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Satish Kharat <satishkh@cisco.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org
Subject: Re: Recommended local LLM-assisted review for netdev submissions?
Message-ID: <6fb66176-a20f-4d6a-b12f-f15b95189327@lunn.ch>
References: <20260428151755.1310712-1-satishkh@cisco.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260428151755.1310712-1-satishkh@cisco.com>
X-Rspamd-Queue-Id: 2A67D489959
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	SUBJECT_ENDS_QUESTION(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[lunn.ch,none];
	R_DKIM_ALLOW(-0.20)[lunn.ch:s=20171124];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-281995-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[lunn.ch:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrew@lunn.ch,netdev@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,lunn.ch:dkim,lunn.ch:mid]

On Tue, Apr 28, 2026 at 08:17:55AM -0700, Satish Kharat wrote:
> Hi Jakub,
> 
> I'm the author of the in-flight enic SR-IOV series. Before posting
> revisions I run checkpatch --strict, make W=1 C=1 on touched files,
> scripts/kernel-doc -none, and `b4 prep --check`.

AI reviews is the big news at the moment, but please don't forget the
more mundane testing which also gets run on patches and series. You
can run these locally:

https://github.com/linux-netdev/nipa#running-locally

	Andrew

