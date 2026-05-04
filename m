Return-Path: <netdev+bounces-284016-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFv+EMPr+Gmi3AIAu9opvQ
	(envelope-from <netdev+bounces-284016-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:56:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A9C4C2D0B
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5D4E33007B04
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336093E317A;
	Mon,  4 May 2026 18:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DhBsySXW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6953E1208
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920945; cv=none; b=Ww1d5idvsYjgtD+eIheBB77mv2qRZrAx45Wmt2ck2JNftFWXuyrwPWUS4Fkn6jmNI5v3wooaQAR/ZEb6GW/71skcI6MZ5rDlEkQfiqPZwuAepwW1E+M7sFvqxgR9Drqvg836bNw3wgeRWZKVn8J2O9tNrY481aSdLP6oENcgfuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920945; c=relaxed/simple;
	bh=J9RoJy40EqeSlTwS3lFcthxbl6NE7GxI6UtEfVoMQTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFikQ5PE/V0GFYpL6xI6i/e1FILqZeuVjWYxJfMjn/aXkAKJO6JdJVl6Gyt+HdPPmCakudD8Jg/y5hABguCumPYjL5LhtPXFWhSMCTd7i0LBHwRFWuT8rslOdHY0u5uvtXfl0PsU08wg9pGk/3hb1x5kjQuzyHKrbejm3nrq2jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DhBsySXW; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-837c09d2268so555771b3a.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 11:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777920943; x=1778525743; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9ekag8HpagqUYt6GzX/RCTDXN8ntakuY7kIa4gof9sg=;
        b=DhBsySXWl4cudNOKXpiL4atRQW9/vXUyq4Twd05S1zH92AWml5Da5fesyMKy/SfIJq
         l9yMzIsnq/I9eeDoSHEAdYaJ7ltIvdJeWqEs8sWAfiy+8cQXOzLTjG/6YPjPC2ewTXju
         hqbE8ihW04sQnewv+xFBFEf5bxvI/96LiFeXnkJsXtMFHYw4xr2qYimZuTIrcVKarNyF
         rDwB2OWDR1z34Fxurcc2KargpDjBRyhIyFpLkdOW/u/ctbAioSBt4q/lH/69YssmeVwa
         ck6WZt3KoRMztNO2EEGfjgZkR+QrRklXCU7CCgU1uZ505GYAQLQseixvtJW7++mQQE1K
         FidA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920943; x=1778525743;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9ekag8HpagqUYt6GzX/RCTDXN8ntakuY7kIa4gof9sg=;
        b=J43wbPFTgbiiog48At9EzxngewSVhDc88stXnvV697p8Gwy/LZNU3EvYmYXQgReDxO
         UhbMcBQOLxyBLbKmuJLbufzUniwy5KbliZSTAJJUKeAxcw40Q+ve3R1axn1ed6wzzbOf
         NpdJphvV6tfZAXvDt3oVLSem63dQOkSn5zwhJs2H5o5R7pPu3QdN0Jrlv9EKX1ZBrjSB
         GTX2xVKQ5t/Xvbj7lWj/GptFAHbQtHCdpvc1FRQy0o3iwt6QWtxocFhFn/QlROMLTQfe
         kHoxgD3pMS7eSZMc5GZgtq0ZuDe+wrL1e2WVO6ZJepm5OYAIKPeGBPN744B1EzEc6V7s
         TObQ==
X-Forwarded-Encrypted: i=1; AFNElJ9e055CCbblgIXKDIsPKWy33oDlEO2wxUD/D1E9ZTAG+bNjy2RfvhmuqGfD9XUWUqoFv5UcnAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkTfwGVJLOOWTCQljeJjiwUy9jsYBAAtx2FylWWhUoyJsmu/G4
	aHnAzXtOt/V/LXX0kf5N8LrZQtHkG57IbDVYzYeM7lhLAZWS1LAIuK3G
X-Gm-Gg: AeBDiev3At6UX6d0GOANcYEcnoiqM3moQfuFJKCiRbMvFIs+2YyCoXITmbj9YnVVSrX
	OJbzMl4iiQ0OInQ3t/fvDuy789GfqtbPXBiZyp2SEynqJYkiBB+AxBTqQ5dOs7VDygr1s1mhuD9
	yIx60xQb6fCTBs9VneA3PEiZKwNLxg5OCg0SUtp1nUjL6KOI+pHM+FZQPe/uuw6iiHC3IA9i1a5
	SKox62xlVBjX5+RnK3AesaiHGg5GaOa2E5yofRs2NGat7nP2i5y2on2KWrq+5kQ0fg2cf0jPot8
	5oflOii3X3fCluiqL8cjweWZKi7Fxmpl92/4PBkb/e81NgcaXbdVyYiHKdxkkgri4VrOV26BKVn
	pqx4YLp7lKmlajyWMsjP5JfFmiPcJJcjUh4p8WD5gM2QwjKYPWnkDBp4rvsGConMnVeXl+bBhNd
	PZqqMCExCvnl8EoxBMfNLrDiuD/qsSmqtm3/Gt3sXF4iR2/nfsz8B7NA==
X-Received: by 2002:a05:6a00:3003:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-83921df9f9fmr143440b3a.1.1777920943043;
        Mon, 04 May 2026 11:55:43 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8392b7ca908sm8605b3a.27.2026.05.04.11.55.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:55:42 -0700 (PDT)
Date: Tue, 5 May 2026 03:55:38 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: HexRabbit <h3xrabbit@gmail.com>, netdev@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Simon Horman <horms@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ido Schimmel <idosch@nvidia.com>, linux-kernel@vger.kernel.org,
	imv4bel@gmail.com
Subject: Re: [PATCH net v2] xfrm: esp: avoid in-place decrypt on shared skb
 frags
Message-ID: <afjrqlBPSv0X9kaY@v4bel>
References: <20260504152712.76305-1-h3xrabbit@gmail.com>
 <afje62FxYMuTUpSb@v4bel>
 <afjpqNXYFVfZjQl5@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afjpqNXYFVfZjQl5@secunet.com>
X-Rspamd-Queue-Id: 47A9C4C2D0B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284016-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,linuxfoundation.org,gondor.apana.org.au,kernel.org,davemloft.net,google.com,redhat.com,nvidia.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

On Mon, May 04, 2026 at 08:47:04PM +0200, Steffen Klassert wrote:
> On Tue, May 05, 2026 at 03:01:15AM +0900, Hyunwoo Kim wrote:
> > On Mon, May 04, 2026 at 11:27:12PM +0800, HexRabbit wrote:
> > > From: Kuan-Ting Chen <h3xrabbit@gmail.com>
> > > 
> > > MSG_SPLICE_PAGES can attach pages from a pipe directly to an skb. TCP
> > > marks such skbs with SKBFL_SHARED_FRAG after skb_splice_from_iter(),
> > > so later paths that may modify packet data can first make a private
> > > copy. The IPv4/IPv6 datagram append paths did not set this flag when
> > > splicing pages into UDP skbs.
> > > 
> > > That leaves an ESP-in-UDP packet made from shared pipe pages looking
> > > like an ordinary uncloned nonlinear skb. ESP input then takes the no-COW
> > > fast path for uncloned skbs without a frag_list and decrypts in place
> > > over data that is not owned privately by the skb.
> > > 
> > > Mark IPv4/IPv6 datagram splice frags with SKBFL_SHARED_FRAG, matching
> > > TCP. Also make ESP input fall back to skb_cow_data() when the flag is
> > > present, so ESP does not decrypt externally backed frags in place.
> > > Private nonlinear skb frags still use the existing fast path.
> > > 
> > > This intentionally does not change ESP output. In esp_output_head(),
> > > the path that appends the ESP trailer to existing skb tailroom without
> > > calling skb_cow_data() is not reachable for nonlinear skbs:
> > > skb_tailroom() returns zero when skb->data_len is nonzero, while ESP
> > > tailen is positive. Thus ESP output will either use the separate
> > > destination-frag path or fall back to skb_cow_data().
> > > 
> > > Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> > > Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> > > Fixes: 7da0dde68486 ("ip, udp: Support MSG_SPLICE_PAGES")
> > > Fixes: 6d8192bd69bb ("ip6, udp6: Support MSG_SPLICE_PAGES")
> > > Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > Reported-by: Kuan-Ting Chen <h3xrabbit@gmail.com>
> > 
> > I dynamically tested this patch and confirm it resolves the
> > issue. Clean work.
> 
> Feel free to add a Tested-by: tag.
> 
> > One correction request before merge -- please drop the
> > second Reported-by tag (your own) from the trailer.
> > 
> > The report and patch for this issue were already posted on
> > the public netdev ML 6 days ago, i.e., the bug was already
> > publicly reported:
> > 
> >   https://lore.kernel.org/all/afLDKSvAvMwGh7Fy@v4bel/
> > 
> > Credit for patch authorship is adequately covered by
> > Signed-off-by alone. Setting aside that your work proceeded
> > independently rather than as a review of my earlier
> > submission, the trailer should conform to convention to
> > avoid future misunderstanding.
> 
> The issue was reported independently, so both Reported-by tags
> are valid. But indeed the Signed-off-by tag should cover the
> second one. I've applied it to the testing branch of the ipsec
> tree to make it available to our test systems. I can still fix
> the tags on request, no need for a v3.
> 
> > No objections to the patch itself.
> 
> Thanks a lot for your effort!

Hi Steffen,

Thanks for the Tested-by tag offer -- please add:

  Tested-by: Hyunwoo Kim <imv4bel@gmail.com>

And please drop the second Reported-by: line as well.
Appreciate the careful handling.


Best regards,
Hyunwoo Kim

