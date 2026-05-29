Return-Path: <netdev+bounces-293066-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qLSDFXZeGWpevwgAu9opvQ
	(envelope-from <netdev+bounces-293066-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:37:58 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AADD86000A0
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 11:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 605E0303ADDC
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34D8F3C277E;
	Fri, 29 May 2026 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AYmxpyPM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058603446DE;
	Fri, 29 May 2026 09:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780047296; cv=none; b=axF7fLTEn3QKaYSVcpJfvH5fcoLyclG2hXwpSsaL7tm2wDT6o/qyrDJGF/ZHyvM87vM9Rq2VJSf+1IUnf+mYEDe5nqgkk7f5zyRNhQGQnQ3NvmmVQB7lGoPb65eb213O5QCLIuMHsLrWnGwSq9BKPfOa9troBGKpNCIQzYV+OD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780047296; c=relaxed/simple;
	bh=4fNw6ghQiLfMpseVSQY5c76rnKVPZ/fhYgyKqPsIlyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b0QWnhY4hmzfXFObintVBZ9PdX6/fd42Mm39mqSeN6nfDd/gbX23zqteyrzJEKngtzcPBbMw3iQ/ZCbEF2KvMvbzBUAlw2HCSQCJvbW0npQtxwPHi8nT0xV6oDnAcHOho6pngmEN0kS3A8HYrEy/n7nm0fgXpN6hUWUcqiA6qLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AYmxpyPM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 143B01F00893;
	Fri, 29 May 2026 09:34:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780047293;
	bh=AK8ANNkExqOCITqWBHg+9jotgKMJByIVfhp0S8C+FEE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AYmxpyPM8hKkZHTLfPs7uwwpSLfKH0JWQUgbZrT0aAn7zzM2SV8xAMv6STs8uuL/2
	 uDjTW7RJ1YoPLRpSfhcP0P/JGYlmNyrhwbs4U4Y+bSbpjb5KcD+cOyaRcGLeXpRkYN
	 tjrBU6jLg14yOHU0KMS7cngHQBtrwvbr41pYcoF5tF3uck6gtidjoR8vx0HX78N0NT
	 viKhX9OerJUouMX3w0CE7Wi8X0PRzsLG1OgwO84oQO5R31hCpqqpN0wBZayLYSZZHX
	 vWYmO1kY/dLOCg0c+bIbTIxCcYcW2nHWI6Jjiy+Yonin+twrefMV7uCP/1/j2Zae6a
	 Pwa/ZRtDZxtlg==
Date: Fri, 29 May 2026 10:34:48 +0100
From: Simon Horman <horms@kernel.org>
To: Jijie Shao <shaojijie@huawei.com>
Cc: Paolo Abeni <pabeni@redhat.com>, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, andrew+netdev@lunn.ch,
	shenjian15@huawei.com, liuyonglong@huawei.com,
	chenhao418@huawei.com, huangdonghua3@h-partners.com,
	yangshuaisong@h-partners.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 net-next 0/6] net: hns3: enhance tc flow offload
 support
Message-ID: <20260529093448.GV2256768@horms.kernel.org>
References: <20260523105449.661848-1-shaojijie@huawei.com>
 <20260527095930.GI2256768@horms.kernel.org>
 <c6dc79ef-5f6e-4c97-97da-fa50eb1d1370@huawei.com>
 <b0b0ac82-bcbf-4aef-bf6f-7340f9517fc6@redhat.com>
 <83f34836-c848-469a-9c1c-7f28bf3035fc@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83f34836-c848-469a-9c1c-7f28bf3035fc@huawei.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-293066-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url]
X-Rspamd-Queue-Id: AADD86000A0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 28, 2026 at 07:24:28PM +0800, Jijie Shao wrote:
> 
> on 2026/5/28 17:06, Paolo Abeni wrote:
> > On 5/27/26 3:12 PM, Jijie Shao wrote:
> > > on 2026/5/27 17:59, Simon Horman wrote:
> > > > On Sat, May 23, 2026 at 06:54:43PM +0800, Jijie Shao wrote:

...

> > > > Hi Juijie,
> > > > 
> > > > There are AI-generated reviews of this patch-set available at
> > > > https://netdev-ai.bots.linux.dev/ and https://sashiko.dev/
> > > Hi,
> > > 
> > > I'm sorry, I don't understand how to use https://netdev-ai.bots.linux.dev/, it seems to require an API Token?
> > > I find it difficult to locate my own patch-set in Recent Reviews.
> > The nipa sashiko instance has the same web UI as sashiko.dev. The full
> > URL for the former is:
> > 
> > https://netdev-ai.bots.linux.dev/sashiko/
> > 
> > You can lookup your series by the cover letter title or you can use the
> > direct link including the msg id for the cover:
> > 
> > https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260523105449.661848-1-shaojijie%40huawei.com
> 
> Thanks,
> 
> It appears that the two URLs mentioned by Simon Horman are the results of the one AI-generated reviews.

Hi,

Firstly sorry for truncating the netdev-ai URL, that was not my intention.
Secondly, let me explain the relationship between the AI-generated review
on netdev-ai and sashiko.dev.

Both use the same underlying review engine - Sashiko [1].  But they are
using different AI models to run the review.  And I believe that the
prompts also differ a little.  Overall, netdev-ai, has been tuned for the
Netdev review process.  While sashiko.dev is more general.

My observation is that netdev-ai tends to flag things relevant to the
Netdev development process that may be skipped by sashiko.dev. While
sashiko.dev has a tendency to report pre-existing issues that are not
strictly related to the topic of the patch under review.

But, as the underling engine is the same there is also a lot of overlap in
the output produced by these two instances. And in some cases both
instances flag all of the same issues.

[1] https://github.com/sashiko-dev/sashiko

