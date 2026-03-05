Return-Path: <netdev+bounces-264496-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6G6LE9W9qWnNDQEAu9opvQ
	(envelope-from <netdev+bounces-264496-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:31:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0402163F5
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 18:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E91CC3019801
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 17:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8324D3E3D90;
	Thu,  5 Mar 2026 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbEF/unD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E6993E3D87;
	Thu,  5 Mar 2026 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772731818; cv=none; b=BqQJnleh6XkjFWNjPtjw2ZNIopSv47DNlb1q6x7PN1ow1aiVZuiDbFPvYdigcdxjoULG4nKMRWmydKxij7gKszXFX3ZUWXeejClYWSeSdTeKJnzWiPqZoNm6rzEwzEQ8T9s9UwsPwNfADiqlRIZ8g1AzTDZM5UpU/N3qF8FtwDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772731818; c=relaxed/simple;
	bh=9VAMGww3cPjNYjf+swpv5BLTEK9Wb70v7QtphgnjGJI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Pf8t26y/Y9mw3usFnc3Nqv+K8v0+X/xnELZ6bdUnJUl56UzLDNKhrhTQAaVkrEbGNeHdSHiCvmRihSHciMiauFtyutd5hLw1+0azU3aJqj+4jpfpXwyryhEVHS3wGQAIP6/MdFkehRWhQ3bpnSdbRPFkwtm5//sUxXT4HP9AcWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbEF/unD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E15C116C6;
	Thu,  5 Mar 2026 17:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772731818;
	bh=9VAMGww3cPjNYjf+swpv5BLTEK9Wb70v7QtphgnjGJI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=lbEF/unDQJUyG9zaIaRG4FKvu7YvgxKMnxLYBIk11ptoINSAlyppJ8hbcQYEwrq1g
	 1W2Jsfevl8LUgePldqoNZaONPa7hhXINWu84t1Os++EaN9RE5mmviH6UnjY81PcUVm
	 geiXCevWRFEBirdEgAiKL/4DcE4tjGaOUL5Awoug2bOHX9o6qk8JV0cojZTjaej2Qi
	 VwBxGJ2XOltvGD9d4WWm/6s4himJpeP126pjQw1J/+tMkIxkVFLP/KRVkkMAq7+2O3
	 3b2ETT1we2SlP5Kyi9zjNF/S3LI/dq6hQWZdggEI4G05h+GFQdkxtXOmgU3FSxDe1T
	 XBya5afbfalqQ==
Date: Thu, 5 Mar 2026 09:30:16 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: torvalds@linux-foundation.org
Cc: davem@davemloft.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, pabeni@redhat.com
Subject: Re: [GIT PULL] Networking for v7.0-rc3
Message-ID: <20260305093016.2e70e0bc@kernel.org>
In-Reply-To: <20260305092348.1ef6a546@kernel.org>
References: <20260305171004.322683-1-kuba@kernel.org>
	<20260305092348.1ef6a546@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: DE0402163F5
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
	TAGGED_FROM(0.00)[bounces-264496-lists,netdev=lfdr.de];
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

On Thu, 5 Mar 2026 09:23:48 -0800 Jakub Kicinski wrote:
> On Thu,  5 Mar 2026 09:10:04 -0800 Jakub Kicinski wrote:
> > A few PRs here narrowly missed the previous rc, but I'm not sure
> > if that explains why this PR is almost 2x the usual size.
> > I had a feeling that AI tools are helping people investigate
> > and send fixes for issues which would previously be waved off
> > as one-off / not worth the time. But the data doesn't necessarily
> > bear that out.  
> 
> FWIW when I say data this is supposedly breakdown of how many people
> who contributed fixes to networking have only been known to git for
> 3, 6 or 12 months:
> 
> Commits     Date        Avg Age     Med Age   <3mo   <3mo%   <6mo   <6mo%  <12mo   <12m%
> ------------------------------------------------------------------------------------------
>     100  2024-09-04       9.9yr      10.5yr     10   10.0%     13   13.0%     15   15.0%

I realized after hitting 'send' that I should probably de-duplicate 
the humans. Same tables but percentage based on distinct authors not
commits:

Commits  Authors     Date        Avg Age     Med Age   <3mo   <3mo%   <6mo   <6mo%  <12mo   <12m%
----------------------------------------------------------------------------------------------------
    100       65  2024-09-04       8.5yr       6.9yr     10   15.4%     12   18.5%     14   21.5%
    100       57  2024-10-01       7.3yr       5.5yr      4    7.0%      4    7.0%      7   12.3%
    100       62  2024-10-13       9.1yr       9.5yr      8   12.9%      8   12.9%     10   16.1%
    100       63  2024-10-24       7.1yr       5.6yr      5    7.9%      6    9.5%     11   17.5%
    100       55  2024-11-06       6.2yr       5.0yr     12   21.8%     12   21.8%     15   27.3%
    100       59  2024-11-22       7.3yr       6.2yr      7   11.9%      9   15.3%      9   15.3%
    100       51  2024-12-08       9.5yr       9.7yr      4    7.8%      7   13.7%      7   13.7%
    100       57  2024-12-20       6.2yr       2.5yr      8   14.0%     11   19.3%     16   28.1%
    100       55  2025-01-10       7.7yr       6.5yr      7   12.7%      7   12.7%     11   20.0%
    100       42  2025-01-26       8.1yr       8.4yr      4    9.5%      6   14.3%      7   16.7%
    100       55  2025-02-07       8.2yr       6.3yr      7   12.7%      9   16.4%     10   18.2%
    100       61  2025-02-24       7.0yr       5.2yr      6    9.8%     10   16.4%     11   18.0%
    100       68  2025-03-07       7.9yr       6.9yr      6    8.8%      7   10.3%     10   14.7%
    100       50  2025-03-24       8.0yr       7.7yr      7   14.0%      8   16.0%      8   16.0%
    100       41  2025-04-07       8.3yr       7.5yr      3    7.3%      4    9.8%      5   12.2%
    100       65  2025-04-18       6.9yr       4.8yr     11   16.9%     15   23.1%     18   27.7%
    100       56  2025-04-30       8.2yr       7.0yr      6   10.7%      7   12.5%      8   14.3%
    100       74  2025-05-14       7.9yr       6.6yr      6    8.1%      8   10.8%     11   14.9%
    100       50  2025-06-02       7.0yr       5.3yr      5   10.0%      6   12.0%      9   18.0%
    100       49  2025-06-11       8.9yr       6.8yr      7   14.3%      7   14.3%      9   18.4%
    100       52  2025-06-24       7.5yr       6.3yr      7   13.5%      8   15.4%     11   21.2%
    100       58  2025-06-12       7.6yr       5.6yr     10   17.2%     11   19.0%     13   22.4%
    100       62  2025-07-17       8.6yr       7.8yr      6    9.7%      7   11.3%     14   22.6%
    100       60  2025-08-06       7.5yr       4.9yr      5    8.3%      6   10.0%      8   13.3%
    100       60  2025-08-19       7.4yr       6.0yr      9   15.0%     11   18.3%     14   23.3%
    100       56  2025-08-18       8.3yr       7.1yr      2    3.6%      3    5.4%      6   10.7%
    100       52  2025-09-08       9.0yr       9.7yr      7   13.5%      9   17.3%     12   23.1%
    100       55  2025-08-13       7.8yr       6.5yr     10   18.2%     12   21.8%     14   25.5%
    100       58  2025-10-09       8.3yr       6.6yr      9   15.5%     13   22.4%     14   24.1%
    100       52  2025-11-05       7.1yr       5.5yr      9   17.3%     12   23.1%     13   25.0%
    100       71  2025-11-18       8.3yr       7.1yr      8   11.3%     12   16.9%     13   18.3%
    100       71  2025-12-09       8.1yr       6.7yr     12   16.9%     13   18.3%     18   25.4%
    100       63  2025-12-21       6.5yr       4.9yr     15   23.8%     16   25.4%     20   31.7%
    100       62  2026-01-09       8.6yr       7.0yr      5    8.1%      6    9.7%      8   12.9%
    100       65  2026-01-12       7.3yr       6.3yr      9   13.8%     12   18.5%     18   27.7%
     95       44  2026-02-27       9.3yr       8.1yr      7   15.9%      7   15.9%      7   15.9%

in the core:

Commits  Authors     Date        Avg Age     Med Age   <3mo   <3mo%   <6mo   <6mo%  <12mo   <12m%
----------------------------------------------------------------------------------------------------
     24       14  2024-09-11      12.0yr      12.9yr      0    0.0%      0    0.0%      0    0.0%
     24       16  2024-10-15       8.4yr       9.1yr      1    6.2%      1    6.2%      1    6.2%
     24       14  2024-11-28       7.6yr       6.6yr      3   21.4%      3   21.4%      3   21.4%
     24       17  2024-12-19       9.3yr       8.3yr      1    5.9%      1    5.9%      2   11.8%
     24        9  2025-01-27      11.7yr      12.9yr      0    0.0%      0    0.0%      0    0.0%
     24       14  2025-02-07       8.3yr       9.4yr      1    7.1%      1    7.1%      2   14.3%
     24       15  2025-02-25       9.3yr      10.1yr      1    6.7%      1    6.7%      1    6.7%
     24       12  2025-03-28      10.3yr      11.0yr      1    8.3%      1    8.3%      1    8.3%
     24       10  2025-04-03       9.8yr      11.1yr      0    0.0%      0    0.0%      0    0.0%
     24       18  2025-04-26       9.0yr      10.3yr      2   11.1%      2   11.1%      3   16.7%
     24       14  2025-06-04       7.6yr       5.5yr      1    7.1%      1    7.1%      3   21.4%
     24       15  2025-07-09       8.8yr       6.9yr      2   13.3%      2   13.3%      4   26.7%
     24       19  2025-08-08       9.2yr       9.1yr      2   10.5%      3   15.8%      3   15.8%
     24       16  2025-09-10       9.4yr      10.1yr      2   12.5%      3   18.8%      4   25.0%
     24       17  2025-10-28       7.7yr       5.4yr      3   17.6%      5   29.4%      5   29.4%
     24       10  2026-01-05       9.0yr       7.7yr      0    0.0%      0    0.0%      2   20.0%
     20       14  2026-02-23       7.9yr       6.2yr      3   21.4%      3   21.4%      3   21.4%

