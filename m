Return-Path: <netdev+bounces-253951-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cFnVLjjweGkCuAEAu9opvQ
	(envelope-from <netdev+bounces-253951-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:04:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6278A98255
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 18:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DEEE33004905
	for <lists+netdev@lfdr.de>; Tue, 27 Jan 2026 17:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7372362128;
	Tue, 27 Jan 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kuwf7OPn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8408431AAAF;
	Tue, 27 Jan 2026 17:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769533494; cv=none; b=mgV04G5rZGN/9nUD50X2zVyutyQIvcAMnWDVQABvxdhdBtCY/gol35MuSIbF1wrbTC0TKxZt8Fu/nLwqn/Mcc88ixvVtbOGUUxpH2TqqmeL6lQPeI/woIqEEdgLTL+PQKNiTiOdq3SwVtXC8XGERxZcbOkNl1tOoHKNiZq+8U9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769533494; c=relaxed/simple;
	bh=Aq2ieBUB1YoKu95ymjZccktO28hLdWEofqN0qLTBdLk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GYIeOL4/QsxgH1YSZoVDtiwthCnzZZMbJlFSSspELNdQkqMXuaTgDsjNlPS5ixIBErasKHzpvtvwoR/++PFTcyvf1jbTQ2cdDNL+wmZNLG8bHhcXBJUGcPyd8OAgQhqipUKJzJ/l4+acAtgJBePMDH8t4geYxb7Ump48W1VSq3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kuwf7OPn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5744C116C6;
	Tue, 27 Jan 2026 17:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769533494;
	bh=Aq2ieBUB1YoKu95ymjZccktO28hLdWEofqN0qLTBdLk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Kuwf7OPnAnM/M8rz8mpmTum5eUbYopAyFIlqDtsOr3zViRudIJmcAO0mF08DVW76s
	 xuvSrZQMAPe52b4+kJF+IB6hZE1/lOXoZ5+KtDk7rYhClKjjho16jIQv2PvK3olnmV
	 WJCxdM1Iakgmuvm7DIv8Yg1mg+2BKdZD3202/qMbfLg34udEOedYukClhvhQHRgdYC
	 ErL1VJDzGnMU11WAiaeE8astuy4OKLuVFgQTkUgGpD049ouY6zEUeaYB3B+2uVjyZv
	 5XNtsWBrgQj2BSYK7uxOpf1MY7n5DWKHjiPEs1c+TC2kLXtgng8rftX1hfKGW4qfdj
	 DiowbMORxXVCQ==
Date: Tue, 27 Jan 2026 17:04:50 +0000
From: Simon Horman <horms@kernel.org>
To: Junjie Cao <junjie.cao@intel.com>
Cc: Shuah Khan <shuah@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kselftest@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] selftests: ptp: use KSFT_SKIP exit code for skip
 scenarios
Message-ID: <aXjwMrXd2i2XI7ZV@horms.kernel.org>
References: <20260126061532.12532-1-junjie.cao@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260126061532.12532-1-junjie.cao@intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-253951-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 6278A98255
X-Rspamd-Action: no action

On Mon, Jan 26, 2026 at 02:15:31PM +0800, Junjie Cao wrote:
> The kselftest framework defines KSFT_SKIP=4 as the standard exit code
> for skipped tests. However, phc.sh currently uses a mix of 'exit 0' and
> 'exit 1' to indicate skip conditions, which can confuse test harnesses
> and CI systems.
> 
> This patch introduces ksft_skip=4 variable and unifies all skip exit
> paths to use 'exit $ksft_skip', consistent with other selftests like
> net/lib.sh and net/fib_nexthops.sh.
> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>


