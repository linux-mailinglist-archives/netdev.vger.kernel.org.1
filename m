Return-Path: <netdev+bounces-208310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BC08DB0AE51
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 09:06:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1861C207D2
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 07:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09FE922D781;
	Sat, 19 Jul 2025 07:06:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C59143164
	for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 07:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752908799; cv=none; b=qfX7R8S+QuqdeNRfE8zHXZaH5wSUfTPwY9L/OVi+PUysuwmfndzVhIxLEC7yev8kuM67kqCATfd2AQsfPNu+6uuK/GmXMIu4RBCVYxztdo2ma94rJEDhNAcPja8stTgnEPOSwRiDC0uK5mz2X4l5N4vyjle2mPM+06RNWhORpdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752908799; c=relaxed/simple;
	bh=E2rRnfhp6L2b6X7P6LRvVszqtcE+83bpAsB1KhBLMws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XrTaYlOyH0cA40fdAcg3wJOQVfiuP1Fcj/xirJP7Ltky97OevQLxQoeZbzPk52UAMUjtHYTbLd6W1bY+vHmktQZJT7nbmIe3sLmfA/spArbdMh6G0dqdsNOaDGbBx4RTZ1KagWOHX51sEaIETFs74Iykc+AC6Er04isAphqDLHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=strlen.de; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=strlen.de
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id 497B260491; Sat, 19 Jul 2025 09:06:33 +0200 (CEST)
Date: Sat, 19 Jul 2025 09:06:31 +0200
From: Florian Westphal <fw@strlen.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, pablo@netfilter.org, pabeni@redhat.com
Subject: Re: [PATCH net] selftests: netfilter: tone-down conntrack clash test
Message-ID: <aHtD9xpFpCBkMWQ-@strlen.de>
References: <20250717150941.9057-1-fw@strlen.de>
 <20250718172634.18261f54@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250718172634.18261f54@kernel.org>

Jakub Kicinski <kuba@kernel.org> wrote:
> Hm, someone set this patch to Deferred and Archived in patchwork,

I did.  I will send a v2 next week.

> otherwise we'll apply the patch.

I got the impression that there is no urgency anymore since the
failing test no longer reports to patchwork, so I'd prefer to
take more time to try and understand whats going on.

