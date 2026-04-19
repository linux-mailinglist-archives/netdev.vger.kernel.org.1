Return-Path: <netdev+bounces-279568-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id THsyEzhg5GlpUgEAu9opvQ
	(envelope-from <netdev+bounces-279568-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 06:55:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF25423207
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 06:55:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE196300E3C3
	for <lists+netdev@lfdr.de>; Sun, 19 Apr 2026 04:55:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F50C371056;
	Sun, 19 Apr 2026 04:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="jW8akn7l"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308C23559E1
	for <netdev@vger.kernel.org>; Sun, 19 Apr 2026 04:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776574511; cv=none; b=dmW3aeE7TcTbb9jR/70FrTL4R7FxQq0M71wggReViuKDlMVr9xyQBmLsg21byssJHn3ZAeHZG+Av9AdYwhO5ljMliLfBQBCCIbMTkqGdIuo7Rpjp2nhWOk41cEeRQhxEWVFHWfbbB1dhqPAEOwhLreQxTt1fJRDGvi6GCn84ikU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776574511; c=relaxed/simple;
	bh=aWwkkO/dK7+4Ij0ZtbCQR5qJUncR5rTmloO/+65ixYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C4AyMjzoxDDiWNTOlbxqTr0hoACWk8VB3rkbR1+ZEBzsWQDGX8Pm53il8N8sXY2Zv1D3lUrNmSC7biTbt6a978ZkUY0qsFXLVURJxDzVcXwpSDoUMO7Vwg63BvV3GhHC01MhfZJHMfZP3fI40nvqoWCCWi83vVaESdIwkvHZvG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=jW8akn7l; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (232.154.13.160.dy.iij4u.or.jp [160.13.154.232])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 63J4sw77096849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 19 Apr 2026 13:54:59 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=+miTzbzmAeJTvCc4KYsQeM1c0jUtDrPE4GIVDyvf1jY=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1776574499; v=1;
        b=jW8akn7lx0SeR4Xr8DtlFzFOUiNqna7GBvGf3ZTAeuOoq/fd1Af+xjsziN0xcavV
         d981jL2tYemcz/Gujawl5SaTI1crHME0d4RRbBs3i4spsDYEMwAG8v9aHF4qL+MH
         N393zTl83fltpAlR9CBDFrY7hWLuzWEK/N+maX3b2r3ZD/FoWf+7lH8C1HtoQQnI
         VwvhTxf/BqwrA3+bOOTrtc/LUcaf5FIzTbKGDXiBO+baTCi7XS9VO88ARtuZo/8n
         o87GiN/W021spC2dG0nGzurGC48Xs7fFhkVkjdiaJFaUhuGt9blBj6PwcMzUfpyQ
         in38zhSL1TTGEKkboA+H/A==
Date: Sun, 19 Apr 2026 13:54:57 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, dima.ruinskiy@intel.com,
        kohei.enju@gmail.com
Subject: Re: [PATCH iwl-next v2 0/2] igc: enable build_skb path
Message-ID: <aeRejyttAu4EO0HW@x1>
References: <20260317062205.39406-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260317062205.39406-1-kohei@enjuk.jp>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-279568-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,sashiko.dev:url,enjuk.jp:dkim]
X-Rspamd-Queue-Id: AEF25423207
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/17 06:21, Kohei Enju wrote:
> This series enables the build_skb RX path in igc, which is currently not
> enabled in any configuration.
> 
> Patch 1/2 adds missing RX hardware timestamp handling in the build_skb
> path.
> Patch 2/2 enables the build_skb path when XDP is inactive and other
> conditions are met.
> 
> Tested on Intel Corporation Ethernet Controller I226-V (rev 04).
> 
> Changes:
>   v2:
>     - don't insist on reverse christmas tree, reducing net diff in the
>       patch 1/2 (Dima)
>   v1: https://lore.kernel.org/intel-wired-lan/20260307182808.155027-1-kohei@enjuk.jp/
> 
> Kohei Enju (2):
>   igc: set RX hardware timestamps in igc_build_skb()
>   igc: enable build_skb on the non-XDP small-frame RX path

Hi Tony,

Could you drop this series from Intel's queue?

Sashiko pointed out a potential use-after-free when dereferencing RX
hardware timestamps with build_skb enabled, and I believe this concern
is valid.
https://sashiko.dev/#/patchset/20260317062205.39406-1-kohei%40enjuk.jp

I'm working on a new series to address this problem.

Thanks,
Kohei

