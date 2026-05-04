Return-Path: <netdev+bounces-283980-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AI31MQLf+GmU2gIAu9opvQ
	(envelope-from <netdev+bounces-283980-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:01:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C624C2426
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 631303033D1D
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC11E3E51D5;
	Mon,  4 May 2026 18:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YtBXBGjU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85450266B46
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:01:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777917683; cv=none; b=Z4dGVYFywbbfOE1axW6Oc2obGSWOKClWOM+eQajc/kZSdTRgRCU73UrSoWfIuZxNgR5cAt2B/m2QHhyuj6IAiPsKkF695l8u0Et/1KMu4+Pf4IYS5FoO83X13b3X0JF/3lqvSIyCQzVOePSqclMRxxj39wvwVMKmYMriDTpgvgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777917683; c=relaxed/simple;
	bh=vs+JKxkWL4C9tFoqc20xdPetd8Tahq+BP7nzeAOMwXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kxhl2rf7HE+VsuNXKRPmPTXD5Ryl1cOZnsAF3ONDlXBgarfok7RU+FfajrSFG2uWz2JHHBM6wMR4ITyv+8quALmWd9c6uW8p0a/g5QMrj2r6CzJ5vs5XOou4bD/D7TsXaZocLxqkvn80TB7WDrIJZJ3TXaP5ciWibv3tTo5pvWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YtBXBGjU; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-35fb166b0c6so2636361a91.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 11:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777917682; x=1778522482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VMVg3MoSD5rf46bARIwWV/VX/i27SxbGd3T7TBit19I=;
        b=YtBXBGjU1ZY3agEzC09xWcHBoD+vJ2ToTT6IibC9e8os2pVGQCs0r6dmA93jpg1q92
         uy+Np2ggilXfpd1k/LNWrnqDY01z9q6qXG4Nv+6OOFRuDiWenMHRDVBPLiSCKpxLvI0A
         mDeClzsmBRJvgnL1ePpqV1RCKzeH0+tzMt5x28sCvlc901OC2t91v30u614WqGOTeb6S
         Hfz0LlxFKH9TtNGM6tuAjEZiKE22dvbFypHem6ztu8GkhlNfq4mwzSS6Q5VanN3KSnCo
         dj/215ziDpEkEWkQslYsSzOwRqz/ixspThcM3pZOyf3oTGEpzqu2K2AmkOaVqsABQxeW
         F86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777917682; x=1778522482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VMVg3MoSD5rf46bARIwWV/VX/i27SxbGd3T7TBit19I=;
        b=Jy4EGqYBRnFC90OlMNRIsl2GEHFfFqx4n50xFx8ncjkvcTCNRIGvvIVNDw4fldira2
         hiSijvQXslCVx6p2XMFNX2ZiiQmczR7s4Pu2ES29rAc5Zm63DNWZkClss/I0gzuQpCv3
         EweZg7ii0Or2vIWazB4AQrrZSeyWZBcoS/hPp1pVyPaYs72UDgmpsXoaolgvJfQUxg9K
         APoSS0VgYroccAs2qigdQt7ELf5ECAPlD2FlJQCJgJqTD+tl82QYwcLz8Rf3EMhJ/QSt
         85QR6cmTFwV7UuD4Q7uUhFkrfYrZQWtxwBGAhlj0cIRoVYZ12RVdTQKi0mVmjKfPDTp7
         cFjg==
X-Gm-Message-State: AOJu0YyNZutayYOReJ/RDEQd8eHI8oRPG/lhQWSFmekuFNbHfzzhd9lg
	sgsdJgVg9LcpmnqXCnKxOANHpzdOyxAV94GzPPNd4mx4XYAhXTccacz/
X-Gm-Gg: AeBDietYA7ymwNo+BR6Wm9At6+xTQF8kzpq5ZIN1VyXLWUAKOQokNCP70AUzBCtMRra
	lKyBmXgYfwv+KObJdhzNy5KhHyqDjczcuHvDU50yvOzBgo7T+9GzVnAGL7mZHS+0Q0MvUsjHKlp
	RAUyKXX05DGELqG80bcfnVlUAzzVRoQEHeTotDYi3yp5R+AO+cYOO/Ckqq1iF9IpIp1mxnFIQPs
	mlIGp1WiKpUNNZ9gooM5kKemIy5uezDi8FqSdFx7zf1cxCe3/QaWuKwR2lvgTW0eBgA1ShQJ29K
	glvz9kZYL71vuz74xBDN79l8WUYqBb3xmJaKioosZ9EqEhwdU5I/i4owVb5igpz2fPLikMHm1D5
	hqjMwrq+G0n4Cwgkebu+dXISCoegW7WcYGVuNW/wTgUk6zMupggTnMMkpH12/TlH1Jt8S1Eav//
	HiqaFJM+fnOkBVAdwHHgQBR7q7WwxJAGJKmRJR1jRu/2FdGCpRX4CSwQ==
X-Received: by 2002:a17:90a:e703:b0:364:52d1:32b6 with SMTP id 98e67ed59e1d1-36572732f8amr394453a91.10.1777917680256;
        Mon, 04 May 2026 11:01:20 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f488df2fsm5594991a91.6.2026.05.04.11.01.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:01:19 -0700 (PDT)
Date: Tue, 5 May 2026 03:01:15 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: HexRabbit <h3xrabbit@gmail.com>
Cc: netdev@vger.kernel.org, Steffen Klassert <steffen.klassert@secunet.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net v2] xfrm: esp: avoid in-place decrypt on shared skb
 frags
Message-ID: <afje62FxYMuTUpSb@v4bel>
References: <20260504152712.76305-1-h3xrabbit@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260504152712.76305-1-h3xrabbit@gmail.com>
X-Rspamd-Queue-Id: F1C624C2426
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283980-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,secunet.com,linuxfoundation.org,gondor.apana.org.au,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Mon, May 04, 2026 at 11:27:12PM +0800, HexRabbit wrote:
> From: Kuan-Ting Chen <h3xrabbit@gmail.com>
> 
> MSG_SPLICE_PAGES can attach pages from a pipe directly to an skb. TCP
> marks such skbs with SKBFL_SHARED_FRAG after skb_splice_from_iter(),
> so later paths that may modify packet data can first make a private
> copy. The IPv4/IPv6 datagram append paths did not set this flag when
> splicing pages into UDP skbs.
> 
> That leaves an ESP-in-UDP packet made from shared pipe pages looking
> like an ordinary uncloned nonlinear skb. ESP input then takes the no-COW
> fast path for uncloned skbs without a frag_list and decrypts in place
> over data that is not owned privately by the skb.
> 
> Mark IPv4/IPv6 datagram splice frags with SKBFL_SHARED_FRAG, matching
> TCP. Also make ESP input fall back to skb_cow_data() when the flag is
> present, so ESP does not decrypt externally backed frags in place.
> Private nonlinear skb frags still use the existing fast path.
> 
> This intentionally does not change ESP output. In esp_output_head(),
> the path that appends the ESP trailer to existing skb tailroom without
> calling skb_cow_data() is not reachable for nonlinear skbs:
> skb_tailroom() returns zero when skb->data_len is nonzero, while ESP
> tailen is positive. Thus ESP output will either use the separate
> destination-frag path or fall back to skb_cow_data().
> 
> Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> Fixes: 7da0dde68486 ("ip, udp: Support MSG_SPLICE_PAGES")
> Fixes: 6d8192bd69bb ("ip6, udp6: Support MSG_SPLICE_PAGES")
> Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> Reported-by: Kuan-Ting Chen <h3xrabbit@gmail.com>

I dynamically tested this patch and confirm it resolves the
issue. Clean work.

One correction request before merge -- please drop the
second Reported-by tag (your own) from the trailer.

The report and patch for this issue were already posted on
the public netdev ML 6 days ago, i.e., the bug was already
publicly reported:

  https://lore.kernel.org/all/afLDKSvAvMwGh7Fy@v4bel/

Credit for patch authorship is adequately covered by
Signed-off-by alone. Setting aside that your work proceeded
independently rather than as a review of my earlier
submission, the trailer should conform to convention to
avoid future misunderstanding.

No objections to the patch itself.


Best regards,
Hyunwoo Kim

