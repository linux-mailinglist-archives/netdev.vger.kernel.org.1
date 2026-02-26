Return-Path: <netdev+bounces-261192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +EFENvj0n2kyfAQAu9opvQ
	(envelope-from <netdev+bounces-261192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:23:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 131FE1A1CE7
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 71684300D376
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 07:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E8238552B;
	Thu, 26 Feb 2026 07:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6OUiFpf"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F11823DD;
	Thu, 26 Feb 2026 07:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772090612; cv=none; b=PbHOdkqpcbg1Dvt2CyUswheiLnX55BqC2tWgzltDXRKRcmK/JOKR5w/SoOrmBHxmDznW0LMY1VKCHm2wFs42ulF1sROKPV3SavXWQSahINwFdaCpEwlk5JSzmVqzGox0uIYTzLD8DET/b1InQziBXJghfLEEiLRl530AJpo+qwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772090612; c=relaxed/simple;
	bh=GCPuXk8MuiUtk6Jf+apT8eJklqsp4FrEkzQCLhHjJzA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u25HQkc/vaeK5Btkhk8Son3AUq11jLGeEPzqhE2SXVwNCyS9yf1hEuwepGLGGvOSpK1z+LbtICxidD/FC9boR6U30pxLHYU7UroZfzBqWkJITJYZ4nvYsdcwRf3KH3DGcdLOyzMELCLpZGyTREOnT1gpLcyP/Fok4DdTiBSr540=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6OUiFpf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 196F8C19422;
	Thu, 26 Feb 2026 07:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772090612;
	bh=GCPuXk8MuiUtk6Jf+apT8eJklqsp4FrEkzQCLhHjJzA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W6OUiFpfAJHJOfeUHzXkGt0sQWDLMLXxHhTfm3DuKlrM0/dxA2DC1pvO5kYbPGRPY
	 ZKxMfIsB60L2EkntNk5xEzwZUTdOZjcPEYRvIOyJEVrR6h0Qdtpj9dvb545jIsKaIf
	 sHLQ4eRE+E/awQbe2GKPK+XGaldnXP5IFVyhEKooj1TuDrz5PEGKlcZneB5poOeQjK
	 /7sDPvUtu6P/ezaEVLmVYFEvMzMs4WSuCJ3tTbT8Kkb7baXcECCktjwRJ3k5t0M3px
	 2xudCbXvFPE6PihONxc13xt9Jeqml+ZIiSD4mLcnt40AATgv5phXvsoaGeEoZfmop7
	 7wVoSRn4cwi+A==
Message-ID: <ccaf0b4a-ba1e-4443-89d3-8fecdcfd3a14@kernel.org>
Date: Thu, 26 Feb 2026 08:23:23 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] selftests: drv-net: rss: Generate unique
 ports for RSS context tests: manual merge
Content-Language: en-GB, fr-BE
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Simon Horman <horms@kernel.org>,
 Willem de Bruijn <willemb@google.com>, Stanislav Fomichev <sdf@fomichev.me>,
 Daniel Zahka <daniel.zahka@gmail.com>, Carolina Jubran <cjubran@nvidia.com>,
 Gal Pressman <gal@nvidia.com>, David Wei <dw@davidwei.uk>,
 Mohsin Bashir <mohsin.bashr@gmail.com>, Nimrod Oren <noren@nvidia.com>,
 Breno Leitao <leitao@debian.org>, Petr Machata <petrm@nvidia.com>,
 netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 "David S . Miller" <davem@davemloft.net>, Mark Brown <broonie@kernel.org>,
 linux-next@vger.kernel.org
References: <20260224224659.1507082-1-dimitri.daskalakis1@gmail.com>
 <20260224224659.1507082-3-dimitri.daskalakis1@gmail.com>
From: Matthieu Baerts <matttbe@kernel.org>
Autocrypt: addr=matttbe@kernel.org; keydata=
 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
 lzVbFe7fduHbABmYz9cefQpO7wDE/Q==
Organization: NGI0 Core
In-Reply-To: <20260224224659.1507082-3-dimitri.daskalakis1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261192-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[lunn.ch,google.com,kernel.org,redhat.com,fomichev.me,gmail.com,nvidia.com,davidwei.uk,debian.org,vger.kernel.org,davemloft.net];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matttbe@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lib.py:url]
X-Rspamd-Queue-Id: 131FE1A1CE7
X-Rspamd-Action: no action

Hello,

On 24/02/2026 23:46, Dimitri Daskalakis wrote:
> The RSS ctx tests rely on NFC rules with unique ports to steer packets
> to the correct ctx. This updates the test to use the new rand_ports()
> helper to guarantee the ports are unique.
> 
> Manual testing shows that generating 32 ports with the existing method
> would result in at least one duplicate 4% of the time.
FYI, we got a small conflict when merging 'net' in 'net-next' in the
MPTCP tree due to this patch applied in 'net':

  ce5a0f4612db ("selftests: drv-net: rss_ctx: test RSS contexts persist after ifdown/up")

and this one from 'net-next':

  19c3a2a81d2b ("selftests: drv-net: rss: Generate unique ports for RSS context tests")

----- Generic Message -----
The best is to avoid conflicts between 'net' and 'net-next' trees but if
they cannot be avoided when preparing patches, a note about how to fix
them is much appreciated.

The conflict has been resolved on our side [1] and the resolution we
suggest is attached to this email. Please report any issues linked to
this conflict resolution as it might be used by others. If you worked on
the mentioned patches, don't hesitate to ACK this conflict resolution.
---------------------------

This conflict was in the context: modifying one line here in 'net-next',
and the ones around in 'net'

Rerere cache is available:

 https://github.com/multipath-tcp/mptcp-upstream-rr-cache/commit/8e4747e

Cheers,
Matt

1: https://github.com/multipath-tcp/mptcp_net-next/commit/098b2437f100

Cheers,
Matt
-- 
Sponsored by the NGI0 Core fund.

--------------------- 8< ---------------------
diff --cc tools/testing/selftests/drivers/net/hw/rss_ctx.py
index b9b7527c2c6b,cbeb3a38fdfe..9a1fba247708
--- a/tools/testing/selftests/drivers/net/hw/rss_ctx.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_ctx.py
@@@ -10,9 -9,8 +10,9 @@@ from lib.py import ksft_eq, ksft_ne, ks
  from lib.py import NetDrvEpEnv
  from lib.py import EthtoolFamily, NetdevFamily
  from lib.py import KsftSkipEx, KsftFailEx
 +from lib.py import ksft_disruptive
- from lib.py import rand_port
+ from lib.py import rand_port, rand_ports
 -from lib.py import ethtool, ip, defer, GenerateTraffic, CmdExitFailure
 +from lib.py import cmd, ethtool, ip, defer, GenerateTraffic, CmdExitFailure, wait_file
  
  
  def _rss_key_str(key):
--------------------- 8< ---------------------

