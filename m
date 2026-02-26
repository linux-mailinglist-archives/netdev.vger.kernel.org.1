Return-Path: <netdev+bounces-261112-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aPTsLs2hn2lWdAQAu9opvQ
	(envelope-from <netdev+bounces-261112-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:28:45 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C6719FCC5
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 02:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B9ED930474D1
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 01:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6A83624AA;
	Thu, 26 Feb 2026 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YiM5DA4v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75E222A4E9;
	Thu, 26 Feb 2026 01:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772069321; cv=none; b=e4IibqXLZPqjR4EAEYV1qWmCX7EXbrMLx71KFv4PQ7/w1PryWnaxNHieQzq65g/Rwqh6XuTuoUSbIDi1S5WVs+QQXWD8GVWZACXS7FrPqZlIyKzwPIW97uSQmU7IAT5WjeOVO/9EQRH70ny6xOhy9DTHzZ+GjcOJxnD7eRYzd5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772069321; c=relaxed/simple;
	bh=LDp3ABznrLB21yPj6JU4fFpdE+2usDUgsJC0IEn+b70=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqDVeDMIKgMQD39Zm9l1HrRC28W8/yUou0ZhGDgRHvwWfebupf5GBk4izpUstRRuC3reSGuG2dZlSs51gU0zGH5fVXsQh/c7CjfvSkb1Et9piEuYs8d9yp0LQpl/yEFOvftt8tqpPjFgx8vUIaIctqBs+IbOJavbU8OPEBahdo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YiM5DA4v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1171C116D0;
	Thu, 26 Feb 2026 01:28:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772069321;
	bh=LDp3ABznrLB21yPj6JU4fFpdE+2usDUgsJC0IEn+b70=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YiM5DA4vxLj3NPFg5PAA6+PNRYAKzSurbneLLDYWP3cigOiuSkR7ajJKw7AC8cAQ9
	 wNJQUjU56J+6foQyAguhypccIFvEBVO+WXRqe1n4QVoHWU6466zogNAGusX4l2786i
	 fo0PUTNm3iOrRo5+WXTQzJCSTHCvNCI5klXcn9BXkxw3yiRi1vrTldwM3m9NqnRB76
	 1D3zVuL11Hy+ZxfiGBaQoLtXWBbLmiO9vFQtDS072olm9zjBEXLvB84vxQXHPYcFfg
	 IIzMZYiu9ToPBSoYjSjohrguwyHV+lentNwKQFqDTPAYDOTadDpnHu+uoRjhkOwCdX
	 i/hoBtUf0UoCw==
Date: Wed, 25 Feb 2026 17:28:39 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Fan Gong <gongfan1@huawei.com>
Cc: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
 <guoxin09@huawei.com>, <horms@kernel.org>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <luosifu@huawei.com>,
 <netdev@vger.kernel.org>, <pabeni@redhat.com>, <shijing34@huawei.com>,
 <wulike1@huawei.com>, <zhoushuai28@huawei.com>, <zhuyikai1@h-partners.com>
Subject: Re: [PATCH net-next v01 00/15] net: hinic3: Fix code styles
Message-ID: <20260225172839.23f3546d@kernel.org>
In-Reply-To: <20260224134315.1735-1-gongfan1@huawei.com>
References: <cover.1771916043.git.zhuyikai1@h-partners.com>
	<20260224134315.1735-1-gongfan1@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-261112-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 68C6719FCC5
X-Rspamd-Action: no action

On Tue, 24 Feb 2026 21:43:15 +0800 Fan Gong wrote:
> Sorry for forgetting to replace cover letter to a newer one.
> We will send the next version with correct cover letter and commit contexts,
> and refer to possible AI review for revisions after 24 hours.

FWIW the AI review is here:
https://netdev-ai.bots.linux.dev/ai-review.html?id=199da9b3-7cc5-40ef-b5d0-e8073e3eb49f

The LLM timed out for one of the patches so it won't get published 
to patchwork.

Another note - could you perhaps cut this series down?
You're adding a bunch of features and:

  34 files changed, 2985 insertions(+), 29 deletions(-)

Not too bad, but I still think you'd make faster progress with
a smaller series.

