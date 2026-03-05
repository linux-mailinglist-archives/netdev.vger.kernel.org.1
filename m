Return-Path: <netdev+bounces-264494-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QPTvMD28qWnNDQEAu9opvQ
	(envelope-from <netdev+bounces-264494-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:24:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 600172161FD
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:24:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5573B301C941
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 17:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C4CB3E3DA8;
	Thu,  5 Mar 2026 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UBo6SF6m"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198453E3DA3;
	Thu,  5 Mar 2026 17:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731430; cv=none; b=WfCH4X+J43RfVQhDm9Ngpko6CIk0GRrTt/yYrEIKBNtp9Lg18xlmn1vhi3ATSlFSQsuTAkvsyVu/s219px9jFbEgfDbuo693OVzOOiY/X4T89sjuuUHdWRdNHQKhQCE5mJyWKkFTLarPQQ2pMhEBnUt9NQs29LQ2Ad/sprNwwes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731430; c=relaxed/simple;
	bh=a5zeyFC0/JYThC2/hr0J3ok/nQLgMN/Nv+EAY4o1+Go=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIBcMn0E1VsYxVpJReZNeBxxqIB3Jy3LIoHCczd7TjLjhVtZEhQL6J9GLyX55AtpxAOQyHpVajDdcAHAQ0QkmvEgub6+Q9nKldU+WhZKECPazwamC3FPtZko/Cmk4fM7obm6AuK4UhWXLnCrd7VQiJ2/+5GEj5x/wzoPbMaaJlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UBo6SF6m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABAA0C19422;
	Thu,  5 Mar 2026 17:23:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772731429;
	bh=a5zeyFC0/JYThC2/hr0J3ok/nQLgMN/Nv+EAY4o1+Go=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UBo6SF6m+UokvUzowlLyTmp6ASYNOcOnSJ/eje2ceH0KeIsSs4f5/IJ1ZqVyMjYvH
	 hfPwAmdGN4ClDtBlicsnryby0thEdEYT/xWjj/M23nVwxmzcFNwKkvtTf+8sl0Vltg
	 ynT4X1wPqrAy0aOW7Ny0+yPrjp/LXb7XqkGHOx0osApUl5z0iueG/FS3iMsm+RSuk2
	 4XrDDBhn53byyuHWeoogIspSv9glTs9kTNcZYiC0Ro3R84nZtalWtpKrnzdTpuydi7
	 OXflZir5TMQo8yHzyrabB+eC0ZuvGFwPqWP9T9yig1plieIXSlQqFMskMbtN4Bfe65
	 F5MNQ/hvCue0A==
Date: Thu, 5 Mar 2026 09:23:48 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v7.0-rc3
Message-ID: <20260305092348.1ef6a546@kernel.org>
In-Reply-To: <20260305171004.322683-1-kuba@kernel.org>
References: <20260305171004.322683-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 600172161FD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-264494-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Action: no action

On Thu,  5 Mar 2026 09:10:04 -0800 Jakub Kicinski wrote:
> A few PRs here narrowly missed the previous rc, but I'm not sure
> if that explains why this PR is almost 2x the usual size.
> I had a feeling that AI tools are helping people investigate
> and send fixes for issues which would previously be waved off
> as one-off / not worth the time. But the data doesn't necessarily
> bear that out.

FWIW when I say data this is supposedly breakdown of how many people
who contributed fixes to networking have only been known to git for
3, 6 or 12 months:

Commits     Date        Avg Age     Med Age   <3mo   <3mo%   <6mo   <6mo%  <12mo   <12m%
------------------------------------------------------------------------------------------
    100  2024-09-04       9.9yr      10.5yr     10   10.0%     13   13.0%     15   15.0%
    100  2024-10-01       8.5yr       8.1yr      5    5.0%      5    5.0%     10   10.0%
    100  2024-10-13       9.2yr       9.2yr     11   11.0%     11   11.0%     18   18.0%
    100  2024-10-24       7.5yr       5.8yr      5    5.0%      6    6.0%     15   15.0%
    100  2024-11-06       7.1yr       5.7yr     18   18.0%     18   18.0%     21   21.0%
    100  2024-11-22       8.4yr       7.3yr      8    8.0%     10   10.0%     10   10.0%
    100  2024-12-08       9.4yr      10.5yr      4    4.0%      9    9.0%      9    9.0%
    100  2024-12-20       7.1yr       5.1yr      9    9.0%     12   12.0%     28   28.0%
    100  2025-01-10       8.5yr       7.7yr      8    8.0%      8    8.0%     12   12.0%
    100  2025-01-26      10.9yr      12.9yr      5    5.0%      7    7.0%      9    9.0%
    100  2025-02-07       9.7yr       9.6yr      7    7.0%      9    9.0%     10   10.0%
    100  2025-02-24       8.1yr       7.4yr      7    7.0%     12   12.0%     13   13.0%
    100  2025-03-07       8.2yr       6.9yr      6    6.0%      7    7.0%     10   10.0%
    100  2025-03-24      10.4yr      13.1yr      7    7.0%      8    8.0%      8    8.0%
    100  2025-04-07       8.1yr       6.9yr     10   10.0%     13   13.0%     15   15.0%
    100  2025-04-18       7.3yr       6.1yr     14   14.0%     19   19.0%     22   22.0%
    100  2025-04-30       9.3yr      10.1yr      6    6.0%      9    9.0%     12   12.0%
    100  2025-05-14       7.7yr       6.5yr      8    8.0%     10   10.0%     14   14.0%
    100  2025-06-02       9.3yr       9.8yr      5    5.0%      6    6.0%      9    9.0%
    100  2025-06-11       9.8yr       6.8yr      8    8.0%      8    8.0%     10   10.0%
    100  2025-06-24       9.0yr       6.9yr      9    9.0%     10   10.0%     13   13.0%
    100  2025-06-12       8.8yr       7.1yr     11   11.0%     13   13.0%     15   15.0%
    100  2025-07-17      10.3yr      11.4yr      7    7.0%      8    8.0%     19   19.0%
    100  2025-08-06       8.3yr       7.8yr      5    5.0%      6    6.0%      8    8.0%
    100  2025-08-19       7.6yr       6.4yr     10   10.0%     12   12.0%     20   20.0%
    100  2025-08-18      10.2yr      10.1yr      2    2.0%      3    3.0%      6    6.0%
    100  2025-09-08       9.7yr       9.9yr      7    7.0%      9    9.0%     13   13.0%
    100  2025-08-13       8.1yr       7.4yr     17   17.0%     19   19.0%     22   22.0%
    100  2025-10-09       9.1yr       9.3yr     12   12.0%     16   16.0%     17   17.0%
    100  2025-11-05       7.5yr       5.9yr     12   12.0%     16   16.0%     19   19.0%
    100  2025-11-18       8.7yr      10.2yr     12   12.0%     18   18.0%     19   19.0%
    100  2025-12-09       9.2yr       8.4yr     12   12.0%     13   13.0%     18   18.0%
    100  2025-12-21       8.5yr       7.6yr     20   20.0%     21   21.0%     26   26.0%
    100  2026-01-09       9.8yr       8.3yr      8    8.0%      9    9.0%     13   13.0%
    100  2026-01-12       6.9yr       5.7yr     14   14.0%     17   17.0%     24   24.0%
     95  2026-02-27      10.0yr      10.4yr     11   11.6%     11   11.6%     11   11.6%

We have a sequence of high percentages since ~Nov but not in a crazy
way.

The numbers looking at just "core parts" (net/core net/ipv4
net/ipv6 net/sched) would support the theory a little more 
but again not very strongly and the numbers are small in absolute
terms:

Commits     Date        Avg Age     Med Age   <3mo   <3mo%   <6mo   <6mo%  <12mo   <12m%
------------------------------------------------------------------------------------------
     24  2024-09-11      13.7yr      14.7yr      0    0.0%      0    0.0%      0    0.0%
     24  2024-10-15       9.4yr       9.1yr      1    4.2%      1    4.2%      1    4.2%
     24  2024-11-28       9.4yr       9.2yr      4   16.7%      4   16.7%      4   16.7%
     24  2024-12-19      11.5yr      12.9yr      1    4.2%      1    4.2%      2    8.3%
     24  2025-01-27      16.0yr      19.6yr      0    0.0%      0    0.0%      0    0.0%
     24  2025-02-07      10.7yr      13.0yr      1    4.2%      1    4.2%      2    8.3%
     24  2025-02-25       7.8yr       5.3yr      1    4.2%      1    4.2%      1    4.2%
     24  2025-03-28      10.8yr      13.1yr      1    4.2%      1    4.2%      1    4.2%
     24  2025-04-03      10.3yr      13.1yr      0    0.0%      0    0.0%      0    0.0%
     24  2025-04-26       9.6yr      11.2yr      2    8.3%      2    8.3%      3   12.5%
     24  2025-06-04      11.8yr      13.3yr      1    4.2%      1    4.2%      3   12.5%
     24  2025-07-09      10.7yr      12.4yr      3   12.5%      3   12.5%      5   20.8%
     24  2025-08-08       9.4yr      11.4yr      2    8.3%      3   12.5%      3   12.5%
     24  2025-09-10      11.1yr      13.6yr      2    8.3%      4   16.7%      5   20.8%
     24  2025-10-28      10.9yr      13.8yr      3   12.5%      5   20.8%      5   20.8%
     24  2026-01-05      14.5yr      20.5yr      0    0.0%      0    0.0%      2    8.3%
     20  2026-02-23       9.1yr       7.2yr      4   20.0%      4   20.0%      4   20.0%

