Return-Path: <netdev+bounces-268523-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMc3C6AkuWm1sQEAu9opvQ
	(envelope-from <netdev+bounces-268523-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:53:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8487A2A74CD
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 10:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA58B30B9F8E
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 09:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5DA33502A7;
	Tue, 17 Mar 2026 09:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="RQ4hLX8P"
X-Original-To: netdev@vger.kernel.org
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E9B3328E3
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 09:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773740787; cv=none; b=YTez+2FUVL4kjqIQiGt8ERh+tW5ZN/5zG//FrREtGtMB0z3DkAYryLFdHGbiOvVHqgvHmgmhb0du8o3/jSg6Pk/gjVgA5jqb6eyPEViuFtmLHoSDiiaSCZlelT3lbhyzl6bJe3U/RdOMH64tyctSMT23bGIKC452Urt/mZEdS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773740787; c=relaxed/simple;
	bh=gAi5jxv8fF7aM5ZjMOpRleMC9ONCtzk5xWOGgZZRxss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V4Wbvy6pCFA5iWx8syQb8Qv8sTgUYLHnvCDkKrwQMjj6wdeYtTDHgt1dZ81oW8QNA66onFhHyVjnTfbkyvMHy4/WwyCIIh4mJBqK17UH/acww3gCPD27kHGmML0XIfrvj2oNyUKJC0YYN3AK8akepjFNHMMDi26W4VEQzEMxZow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=none smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=RQ4hLX8P; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=debian.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+9X84gM6iPEoxKcZAhAl50CEeyqp8NKTGUKu4SVJ1n0=; b=RQ4hLX8Pjeed5bx1LQsphXhndL
	MFRXk+IVG7JkisutRLWo2IpGuhbrkD62W4vT1fDfScBMc2nqzJFu6ZFRzzOrt+Hrl2QVgWdwLNIWI
	bfb/pMWeksTiZlPJtfR2pOMsMKP1yPwKPG3cWc9wQ8JAO+a5bDsLC9yRRpKMYsVSzbEBk7ZJI9zay
	21BC2oSjdvxXtKnvM+9/XcQSgSSSHZRpFeH1ST9YMcHdcPWGOOspSmmN6jtMrJ5qM91mBcqzhMTpc
	wlbjg0JMUcbWudwcAafBTSn24WgRc5kY07E7crSf1X0VagRHBYR9So70Wu0pY6/YH8VzCuwVO978w
	bM6KrGPQ==;
Received: from authenticated user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.94.2)
	(envelope-from <leitao@debian.org>)
	id 1w2R0B-002nF1-PK; Tue, 17 Mar 2026 09:46:14 +0000
Date: Tue, 17 Mar 2026 02:46:09 -0700
From: Breno Leitao <leitao@debian.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Richard Cochran <richardcochran@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, Simon Horman <horms@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>, 
	Michal Kubiak <michal.kubiak@intel.com>, Joe Damato <joe@dama.to>, 
	Larysa Zaremba <larysa.zaremba@intel.com>, Abdun Nihaal <abdun.nihaal@gmail.com>
Subject: Re: [PATCH net-next v5 01/11] net: ngbe: remove
 netdev->ethtool->wol_enabled setting
Message-ID: <abki0rJxJONPsdfh@gmail.com>
References: <20260317073827.4300-1-jiawenwu@trustnetic.com>
 <20260317073827.4300-2-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317073827.4300-2-jiawenwu@trustnetic.com>
X-Debian-User: leitao
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[debian.org:s=smtpauto.stravinsky];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[debian.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268523-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[debian.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leitao@debian.org,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,net-swift.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,intel.com,dama.to];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8487A2A74CD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 03:38:17PM +0800, Jiawen Wu wrote:
> netdev->ethtool->wol_enabled is set in ethtool core code, so remove the
> redundant setting in ngbe_set_wol().
> 
> Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>

Reviewed-by: Breno Leitao <leitao@debian.org>

