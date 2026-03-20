Return-Path: <netdev+bounces-269795-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD96MLPjvGmV4AIAu9opvQ
	(envelope-from <netdev+bounces-269795-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:05:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BF9A82D624A
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 07:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B11933004C98
	for <lists+netdev@lfdr.de>; Fri, 20 Mar 2026 06:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29A8B26A0DD;
	Fri, 20 Mar 2026 06:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b="lZx4xLIU"
X-Original-To: netdev@vger.kernel.org
Received: from www2881.sakura.ne.jp (www2881.sakura.ne.jp [49.212.198.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ADE0248886
	for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 06:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.212.198.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773986734; cv=none; b=KEmEnptPcFStfQbmwl3oOaL2z2jx0vvpm2Qjlyolvcb9PvoWgjRQAcfKGbjdOCnHm1u3JOjEZNGr6Zz7IlKqEHcd4KvQFJ7YzlVCshhETHx2IAXyDODeDdHIOqu+3GqTwS+UhAmPRcjTc05eSEG/ueOCyu1vxmJ3Fuh8sWDZin8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773986734; c=relaxed/simple;
	bh=oNWHVssiMzmZKcyAJfV+YaiiycDV97vQmqxRd4IUuvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l2uBGUKXABmEj0ldTI3nB1zcwQlLu0HXmoPEyyB/ulo90PRUmJSfrUxmHCfdiQ/yUqB4maxLsgdfxYArO57qN7vBS5/vJsCF6sIY1Y0HLJYHv0KhbEtRBjhZbeaNlSkIRs5JwjBwgJNnw+RtSmINS2kYxB3aEqI7oWX3543vz3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp; spf=pass smtp.mailfrom=enjuk.jp; dkim=pass (2048-bit key) header.d=enjuk.jp header.i=@enjuk.jp header.b=lZx4xLIU; arc=none smtp.client-ip=49.212.198.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enjuk.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enjuk.jp
Received: from x1 (122.24.31.150.dy.iij4u.or.jp [150.31.24.122])
	(authenticated bits=0)
	by www2881.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62K65Nak002627
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Fri, 20 Mar 2026 15:05:25 +0900 (JST)
	(envelope-from kohei@enjuk.jp)
DKIM-Signature: a=rsa-sha256; bh=pzYpIbPQzLRmoVZlDhNsuUG/czPwk1YNqqtzPT/dJxg=;
        c=relaxed/relaxed; d=enjuk.jp;
        h=From:Message-ID:To:Subject:Date;
        s=rs20251215; t=1773986725; v=1;
        b=lZx4xLIUMlFm6VvvIcjQMDAwFDO6xfzJHhgAN1JZKocAiGrvKB95zon25WEawmoC
         kXOgFIX3ds5c9IUSx43WNIo2gfse8JSHJ0P7SIHH55CyxVsbyjO4EucWlZAiBrB7
         Y/LbvS07zdGnILzZ0pLYp6vejzPIIqh8Tm9kgWZayHbBoXxTUt+uD/oTCil9ylsb
         CIkHI2HVwa19jAQ4HORh8g3ZCxAmXKWzrdQ8IEO7y4vCZKyjsCUQ/rJyq754gYr8
         ALGUq3r50UKWo1kBXu44yNhNhx0GYvg7ey9D1zicQyHX+HHjyboqAsEJyv8M3IoI
         bX3UNSNWkZSfItW7ycg3ng==
Date: Fri, 20 Mar 2026 15:05:23 +0900
From: Kohei Enju <kohei@enjuk.jp>
To: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        Simon Horman <horms@kernel.org>,
        Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, dima.ruinskiy@intel.com,
        kohei.enju@gmail.com
Subject: Re: [PATCH iwl-next v2 0/2] igc: enable build_skb path
Message-ID: <abzhZsk5FdB2eWeN@x1>
References: <20260317062205.39406-1-kohei@enjuk.jp>
 <20260319161140.GI1753385@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260319161140.GI1753385@horms.kernel.org>
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[enjuk.jp,none];
	R_DKIM_ALLOW(-0.20)[enjuk.jp:s=rs20251215];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269795-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.osuosl.org,vger.kernel.org,kernel.org,intel.com,lunn.ch,davemloft.net,google.com,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.950];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kohei@enjuk.jp,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[enjuk.jp:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: BF9A82D624A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/19 16:11, Simon Horman wrote:
> On Tue, Mar 17, 2026 at 06:21:44AM +0000, Kohei Enju wrote:
> > This series enables the build_skb RX path in igc, which is currently not
> > enabled in any configuration.
> > 
> > Patch 1/2 adds missing RX hardware timestamp handling in the build_skb
> > path.
> > Patch 2/2 enables the build_skb path when XDP is inactive and other
> > conditions are met.
> > 
> > Tested on Intel Corporation Ethernet Controller I226-V (rev 04).
> > 
> > Changes:
> >   v2:
> >     - don't insist on reverse christmas tree, reducing net diff in the
> >       patch 1/2 (Dima)
> >   v1: https://lore.kernel.org/intel-wired-lan/20260307182808.155027-1-kohei@enjuk.jp/
> > 
> > Kohei Enju (2):
> >   igc: set RX hardware timestamps in igc_build_skb()
> >   igc: enable build_skb on the non-XDP small-frame RX path
> 
> For the series:
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

Hi Tony, thanks for applying this series to next-queue.
I have a question about the process of patch submission.

Sometimes reviewers give RB tags for a whole series like this, but I
think that those tags on the cover letter are not collected
automatically, right?

In this case, should I add RB tags to each patch if I respin for other
reasons, or what is the recommended way to handle this?

