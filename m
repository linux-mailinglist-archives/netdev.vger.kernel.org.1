Return-Path: <netdev+bounces-182442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AB8A88C40
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 21:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 653D37A71AC
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 19:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000C928BABD;
	Mon, 14 Apr 2025 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g+5D3ZH/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C75CA28B50F;
	Mon, 14 Apr 2025 19:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744658736; cv=none; b=Q6oE6/mVwb6BOkUMm3OcWafkHvHbImcazTnyt5lglwv7SvswgtwU5RN5u6Exsdj3+d8buWp1+xkrvuWCsI0gQS1Hyz7soegptjA8p0wJ1cKjniCZR2475dYGVVgYjWO43D2DGVC7y/wPnVxphmkV3z6ajvvzShoAiNJu8XzJQTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744658736; c=relaxed/simple;
	bh=jCSqkdfnoUdU/jRX7Jyd1F4Xu+HfkrAYfrr2SZjIUkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fJI86TjQAWGdfuH91xFB6dj2F31VlOAvxkK6mGujNinBBlCp6QaP2o7UKI6lavnUPxXXqzPX4zyjTo2YeXyYpmea+LlaNPBs0CcM+ueBBAB6uYkCNHus1K6b4x59QuRbFSVHm5es0MsXWu758tDmGJ4MUDPRJVPC6EMsstZFtps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g+5D3ZH/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 517C2C4CEE2;
	Mon, 14 Apr 2025 19:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744658736;
	bh=jCSqkdfnoUdU/jRX7Jyd1F4Xu+HfkrAYfrr2SZjIUkY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g+5D3ZH/IIV3rx4A5yZZvnka4Srd602EOQbO7rVOrAotrwxefPEAQgXhsedRdTxUr
	 7qp/YoXz+n91qAUiie9U/4UeCM5RaL0yeRXEj3/dIAm+SVf+rnJ1B2b06MWYWTAela
	 vCnxHiHMYcQXdO8PQCAjGxOFtoYDPLUFiS50Xclk2KAGn0hDkOUj1YJtzj/G+Rwxpl
	 Ef4gXxV+VuMiHxOXTBwJZT71hzgEg2jy/7kcuqNhxP4hCHJA2bry369cYieVoTidHu
	 J6lif6OF9k9WtLq6II1co9e61rxsIqqcvw/USV1YvjBVGpuvLqDFUhNQwN8zNIaMdy
	 SsVcZZaS4aZQA==
Date: Mon, 14 Apr 2025 20:25:32 +0100
From: Simon Horman <horms@kernel.org>
To: Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>, jmaloy@redhat.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] tipc: Removing deprecated strncpy()
Message-ID: <20250414192532.GX395307@horms.kernel.org>
References: <20250411085010.6249-1-kevinpaul468@gmail.com>
 <PRAP189MB1897EE07B01E866F0C757156C6B62@PRAP189MB1897.EURP189.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PRAP189MB1897EE07B01E866F0C757156C6B62@PRAP189MB1897.EURP189.PROD.OUTLOOK.COM>

On Fri, Apr 11, 2025 at 10:46:32AM +0000, Tung Quang Nguyen wrote:
> >This patch suggests the replacement of strncpy with strscpy as per
> >Documentation/process/deprecated.
> >The strncpy() fails to guarantee NULL termination, The function adds zero pads
> >which isn't really convenient for short strings as it may cause performance
> >issues.
> >
> >strscpy() is a preferred replacement because it overcomes the limitations of
> >strncpy mentioned above.
> >
> >Compile Tested
> >
> >Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
> >---
> > net/tipc/link.c | 2 +-
> > net/tipc/node.c | 2 +-
> > 2 files changed, 2 insertions(+), 2 deletions(-)
> >
> >diff --git a/net/tipc/link.c b/net/tipc/link.c index 18be6ff4c3db..3ee44d731700
> >100644
> >--- a/net/tipc/link.c
> >+++ b/net/tipc/link.c
> >@@ -2228,7 +2228,7 @@ static int tipc_link_proto_rcv(struct tipc_link *l, struct
> >sk_buff *skb,
> > 			break;
> > 		if (msg_data_sz(hdr) < TIPC_MAX_IF_NAME)
> > 			break;
> >-		strncpy(if_name, data, TIPC_MAX_IF_NAME);
> >+		strscpy(if_name, data, TIPC_MAX_IF_NAME);
> >
> > 		/* Update own tolerance if peer indicates a non-zero value */
> > 		if (tipc_in_range(peers_tol, TIPC_MIN_LINK_TOL,
> >TIPC_MAX_LINK_TOL)) { diff --git a/net/tipc/node.c b/net/tipc/node.c index
> >ccf5e427f43e..cb43f2016a70 100644
> >--- a/net/tipc/node.c
> >+++ b/net/tipc/node.c
> >@@ -1581,7 +1581,7 @@ int tipc_node_get_linkname(struct net *net, u32
> >bearer_id, u32 addr,
> > 	tipc_node_read_lock(node);
> > 	link = node->links[bearer_id].link;
> > 	if (link) {
> >-		strncpy(linkname, tipc_link_name(link), len);
> >+		strscpy(linkname, tipc_link_name(link), len);
> > 		err = 0;
> > 	}
> > 	tipc_node_read_unlock(node);
> >--
> >2.39.5
> Reviewed-and-tested-by: Tung Nguyen <tung.quang.nguyen@est.tech>

Hi Tung,

Thanks for reviewing these patches,
but I think it's best not to use non-standard tags.

Reviewed-by: ...
Tested-by: ...

