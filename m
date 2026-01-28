Return-Path: <netdev+bounces-254302-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKRVOaUhemmv2wEAu9opvQ
	(envelope-from <netdev+bounces-254302-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:48:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 886E0A3194
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 15:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D9B44303A6F4
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 14:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07565353EC8;
	Wed, 28 Jan 2026 14:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rXkBALyK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D664D1FECCD;
	Wed, 28 Jan 2026 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769611364; cv=none; b=IfVBnf/ArXjBQCFrWybVak4X/FZ71Wimzb71N18bZu04y31jIWnd4F9fQKC8KKD/L5JIN5G2Vj6fvheXZ1x484UA08C1c18ZTk0yhsMkRu8wiin39/LAUkNkIb7usyOqsrZbN+gMDPu3fT7p66mGlXvOKXtLQxF78EuEehVqkuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769611364; c=relaxed/simple;
	bh=hqVAydtNojfE6yRZQtQ7PC8yJuJoMjtL+AUQAO6Fh4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l+RVN0q21ODXhiuXmRaEHIhbowDfIDYzrID4HPClxzqYR5aJ6SkHvh6Sr5KMhugO1b7nruEo4+nfp68qsi5I6Y5Re71gChUVo3A25tLArmSZ9gX0YPIMIHRJ9mXLPzAAZKwa9tXp5nSQpoWsdclbiE6Af3E7JB3mf9czcYgTZzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rXkBALyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C72C4CEF1;
	Wed, 28 Jan 2026 14:42:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769611364;
	bh=hqVAydtNojfE6yRZQtQ7PC8yJuJoMjtL+AUQAO6Fh4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rXkBALyK4SWwiWB2YvyG2J4mVHVJg54T2OBxbhTnQWLHfnObnkDkZvnm6c73BVpt4
	 AQnIPAVBBxqeFk0Qa5e7EyGpxKDFVwtPjyXNP+IiBqLI6mwPcdBGgQo0HbuBkK2mO2
	 Y8n37470qd4xNUlro8g3PldFInrTnH+NK0Xeq2loltyDv4lazlpzaBOwag0ucub9Dt
	 +AtBRQEIoIATr9A06h200b8b4s+SHzKf0fH3EGezyrggfZL63GWNdJpeCTTRAgTHlA
	 aPtxH3xVAs1GNZTnt7Owkn/msvpuUi+Mm0ZwcbcOKKzVXXxCQsWcc6V5yqlfWrTyUj
	 y+qMN1NVtn8fw==
Date: Wed, 28 Jan 2026 14:42:39 +0000
From: Simon Horman <horms@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	guoxin09@huawei.com, kuba@kernel.org, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, luosifu@huawei.com,
	luoyang82@h-partners.com, netdev@vger.kernel.org, pabeni@redhat.com,
	shijing34@huawei.com, wulike1@huawei.com, zhoushuai28@huawei.com,
	zhuyikai1@h-partners.com
Subject: Re: [PATCH net-next v02 2/4] hinic3: Remove redundant defensive code
Message-ID: <aXogX8UDfUpq05_d@horms.kernel.org>
References: <aXjm6fE7Vsv_0GTP@horms.kernel.org>
 <20260128065038.1381-1-gongfan1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260128065038.1381-1-gongfan1@huawei.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254302-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,h-partners.com:email,huawei.com:email,horms.kernel.org:mid]
X-Rspamd-Queue-Id: 886E0A3194
X-Rspamd-Action: no action

On Wed, Jan 28, 2026 at 02:50:37PM +0800, Fan Gong wrote:
> On 1/28/2026 12:25 AM, Simon Horman wrote:
> > On Mon, Jan 26, 2026 at 09:03:32AM +0800, Fan Gong wrote:
> >> According to comment of patch 03, check codes that were merged and
> >> remove redundant defensive codes.
> >>
> >> Co-developed-by: Zhu Yikai <zhuyikai1@h-partners.com>
> >> Signed-off-by: Zhu Yikai <zhuyikai1@h-partners.com>
> >> Signed-off-by: Fan Gong <gongfan1@huawei.com>
> >
> > Hi,
> >
> > I agree that defensive coding is unnecessary in Networking drivers.
> > But I'm unsure what "codes that were merged" and "patch 03" refers to.
> > Could you clarify this?
> >
> > Likewise in patch 3/4 of this series.
> >
> 
> Our negligence did not explain this clearly.
> 
> Patch 03 points to the mergeed patch "net: hinic3: Add a driver for Huawei 3rd
> gen NIC - sw and hw initialization".
> 
> "codes that were merged" means that we review the code already merged into
> Linux based on Jakub's review comments.
> https://lore.kernel.org/netdev/20250902180843.5ba05bf2@kernel.org/
> 
> At that time, "patch 03" could only modify the parts where the code was to be
> merged. Therefore, after we checked the previous codes ,the codes already
> merged are modified in this current patchset.

Thanks, and apologies if I still have this mixed up.
I'm wondering if the following commit message would make things clearer.

Subject: [PATCH net-next v3 2/4] hinic3: remove defensive txq_num check

Since commit 1f3838b84a63 ("hinic3: Add Rss function") nic_dev->num_txqs
cannot be zero in hinic3_alloc_txqs(). So remove the check for this case.

Link: https://lore.kernel.org/netdev/20250902180843.5ba05bf2@kernel.org/
Signed-off-by: ...

