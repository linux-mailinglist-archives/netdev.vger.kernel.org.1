Return-Path: <netdev+bounces-238335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D869CC575CB
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 13:19:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B7AA04E415D
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 12:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD0A334D4C1;
	Thu, 13 Nov 2025 12:19:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19D672D879F;
	Thu, 13 Nov 2025 12:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763036375; cv=none; b=I0ZSm1kymv2DeO5ErOGWpUXW7bP9wKo90mwoge+OuMENCLizkKSTsqEZ0RieySnKc14jb/Gk5TtblcI4+GiK3zSG+bOuBigbFlq0WTX53GCwYi6v34hpJhyYjcOT/rSDOPLOfp/XPfwwYiokumOniarM1Wu5K4u3IErbpcHRUeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763036375; c=relaxed/simple;
	bh=dgogvBtvmtOv+FSq2bha9l2SBuoGmRUcjioflGOcXVQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iNJC6m0tj2snB6wVrh8U/L3wpzQFUNxCifR9GAvTH1f9KTd6OupMy5qPVS9lZA+MlQgyiuQ3eyxXwgY3eboTAon/iZxwAYba42bmksIHG2SqpVgKbIF2Cs5J28fvxTrsiBEc2tzg2/n2GqGr85to6ZVK/7SOaTZ8mzeskIHPEiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id B7AD96039D; Thu, 13 Nov 2025 13:19:30 +0100 (CET)
Date: Thu, 13 Nov 2025 13:19:31 +0100
From: Florian Westphal <fw@strlen.de>
To: Scott Mitchell <scott.k.mitch1@gmail.com>
Cc: pablo@netfilter.org, kadlec@netfilter.org, phil@nwl.cc,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org,
	netfilter-devel@vger.kernel.org, coreteam@netfilter.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Scott Mitchell <scott_mitchell@apple.com>
Subject: Re: [PATCH v2] netfilter: nfnetlink_queue: optimize verdict lookup
 with hash table
Message-ID: <aRXM079gVzkawQ-y@strlen.de>
References: <20251113092606.91406-1-scott_mitchell@apple.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113092606.91406-1-scott_mitchell@apple.com>

Scott Mitchell <scott.k.mitch1@gmail.com> wrote:
> Signed-off-by: Scott Mitchell <scott_mitchell@apple.com>

Didn't notice this before, these two should match:

scripts/checkpatch.pl netfilter-nfnetlink_queue-optimize-verdict-lookup-wi.patch
WARNING: From:/Signed-off-by: email address mismatch: 'From: Scott Mitchell <scott.k.mitch1@gmail.com>' != 'Signed-off-by: Scott Mitchell <scott_mitchell@apple.com>'

