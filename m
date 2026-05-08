Return-Path: <netdev+bounces-285666-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBFkLpJ+/WnnegAAu9opvQ
	(envelope-from <netdev+bounces-285666-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:11:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B88C4F245F
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 08:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 887FC304A78C
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 06:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F65B376BCD;
	Fri,  8 May 2026 06:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ShUSDu0T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE8F3603E0
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 06:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778220481; cv=none; b=WejBFDl9ojzqP/DOJ4izkzpZjtvhr9xRjhHV0YSow1hzZkWKOcStA/WLUVU0eBZHqsaM3U3vhJWPFJIV6uvME52MN8jDGHTMPAnSAVONlxv6J+FLgYrnRro8D7JiAeuEj06x17hEvBjNj9LPVR7oRgENbpG8GCTZuHhOXeiuJsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778220481; c=relaxed/simple;
	bh=BZBWfRU2gOMVKRVsITMQK2oUWGlBlOlIHnh2YyuF0lQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V0E7Xh+k4vqTZHi8CT7Q4JTfEw8Td0k8OsO8/7MhxBGzaYhef2Yh/teBdf3abEs07lacwm6Xsql5qjw1D+ed28EWkMKhWrc4P9PmWoK/Hcvt23DlAsetE9HE2k1CZXPNB15yYivmBb++Nca13k/j4WsI/lLZHm39iNBzf1CfdkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ShUSDu0T; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c801912c903so695054a12.0
        for <netdev@vger.kernel.org>; Thu, 07 May 2026 23:07:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778220474; x=1778825274; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fp+GqZbaj+uhEpmLLryDblDhTrd7O5aQ3cRerJ03uS0=;
        b=ShUSDu0Tn5tPY26lPe7wCLhfcMmo/v2LDeNw3xjZbQ5xUpXIfxXWN1rJE2e6EJi95v
         MS3jwE+78whvYeyKATZzkMIBOSoJvJfYnClJnasru/Uu2SgP/AYzjZN8Mp8aoA7e2/Le
         7LQt1S8NNnQnM6bcX5e2sA5GwcswbM6M/0rgBW1jSjpOtDGS9JH3j3xeyUbAWE9z8pNa
         6mZCorQBDHI9smue+xnHgbjcFVEH8pgFk1MXXcJRE6CXxDPJK8olUmRhYubZxOvjv7F2
         5KP3KDrfz1T2TrXkx5W3+ONWPhuEwrCz9NcpuhV0HXVmjhqeXx08VxfU4YKXUbWtKgRP
         ffiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778220474; x=1778825274;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fp+GqZbaj+uhEpmLLryDblDhTrd7O5aQ3cRerJ03uS0=;
        b=jHPoCw9w4ePU81mgn0alswlna25IMkBhXccODgKraHviN60u0ei6Q0boxy8Q6usnOP
         xLaGoPR9zwebjO4qjfO7zsutuhla6G/iP2c0qpdjaoDXoeAapR8oRU0fZWAqCKP4ujdj
         huRYAr9OIYMvcbBbKlaJSPXowk1FdHxSW7dhkpTct+3oTIbiv87RK50h7Gqt/7+g20Gl
         xNnykchOErS+AmYbPUSzxV9nC6F8cnq1aKpfbP5h+uD0bad10SfZDvw7quU38wjaC5pn
         tx4MV0qpDnWHNU8GknnwuyA0SWCJBRNwr5xyBp3eJOsebKWXnFZePwLhHHbQcNkuv1RZ
         2Ptg==
X-Forwarded-Encrypted: i=1; AFNElJ+QyOIUzdxpWzvfr5QrmNFqbCL7JeWp9rMgWdAxIbsqlv51ZZzLSOHgd485kxeC/Zfle5lA2ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8F9herw3lz0BnaPYCaHuoeHk4paZO6aDYeOavJ8aUB2niDEyL
	l+IXzAGzURUPhmu0gsJNfqL9CO44TYmnAen/iwV+mk+3vTDkAAq4UA4sd9D2jQ==
X-Gm-Gg: AeBDietLuvuMIEdkIwxQyS7cT8x88gok+3e9icf4wMagVrvyggLnSgUQlDdolLEIEIB
	6F/d7g1vTT/4WtC5p1V/Y33ylFv4M7Krl9t53O3/O/0kCxVuen1lUCXtlpBSVXXkn2SUd+YeabR
	7Qhq6Om0n/8IbTI9fMNe2Z+Ira3udvmBNdg6hWVFGaT+0MQF0Hqt0j/I+fTPecL2mtZ/QZRzCIt
	0u61kE5q2j7KMsGmEV3eVSA3yNzGJc231VhZObYH9iFkDzZLrbEjnoNYzPNoOPqozpHVX//TJDS
	bZaVmOELeASssxSLmcpY9w6gxsjITvs2AMTxQxRjM/C8vdU5BZ/IQD0LxPXKdIPPZ6Ek7tzKmfc
	F6iyDgZZblI83uiiq9t3tyUHEOkJDRyCXCsenJSGaHTKGRHTAzqgJVliRUz2QrAdrrdPeIGi0kk
	eRXN9KmSb/crhzdnMG7uj2k+63KmBlpsy7s0IytW8b6Qc=
X-Received: by 2002:a05:6a20:1591:b0:34f:14d6:15f5 with SMTP id adf61e73a8af0-3aa5a934e9cmr12940553637.29.1778220473727;
        Thu, 07 May 2026 23:07:53 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c826767be49sm688518a12.3.2026.05.07.23.07.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2026 23:07:53 -0700 (PDT)
Date: Fri, 8 May 2026 15:07:49 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: dhowells@redhat.com, marc.dionne@auristor.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, linux-afs@lists.infradead.org,
	netdev@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH net] rxrpc: Also unshare DATA/RESPONSE packets when paged
 frags are present
Message-ID: <af19tf9gX3sxIrWr@v4bel>
References: <afKV2zGR6rrelPC7@v4bel>
 <20260508055716.89380-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260508055716.89380-1-qingfang.deng@linux.dev>
X-Rspamd-Queue-Id: 3B88C4F245F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-285666-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,auristor.com,davemloft.net,google.com,kernel.org,lists.infradead.org,vger.kernel.org,gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[imv4bel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 01:57:15PM +0800, Qingfang Deng wrote:
> On Thu, 30 Apr 2026 08:35:55 +0900, Hyunwoo Kim wrote:
> > 
> > The DATA-packet handler in rxrpc_input_call_event() and the RESPONSE
> > handler in rxrpc_verify_response() copy the skb to a linear one before
> > calling into the security ops only when skb_cloned() is true.  An skb
> > that is not cloned but still carries paged fragments (skb->data_len != 0)
> > falls through to the in-place decryption path, which binds the frag
> > pages directly into the AEAD/skcipher SGL via skb_to_sgvec().
> > 
> > Extend the gate so that any skb with non-linear data is also copied,
> > ensuring the security handler always operates on a fully linear skb.
> > The OOM/trace handling already in place is reused.
> > 
> > Fixes: d0d5c0cd1e71 ("rxrpc: Use skb_unshare() rather than skb_cow_data()")
> > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > ---
> >  net/rxrpc/call_event.c | 2 +-
> >  net/rxrpc/conn_event.c | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/rxrpc/call_event.c b/net/rxrpc/call_event.c
> > index fdd683261226..6c924ef55208 100644
> > --- a/net/rxrpc/call_event.c
> > +++ b/net/rxrpc/call_event.c
> > @@ -334,7 +334,7 @@ bool rxrpc_input_call_event(struct rxrpc_call *call)
> >  
> >  			if (sp->hdr.type == RXRPC_PACKET_TYPE_DATA &&
> >  			    sp->hdr.securityIndex != 0 &&
> > -			    skb_cloned(skb)) {
> > +			    (skb_cloned(skb) || skb->data_len)) {
> 
> It's recommended to use skb_is_nonlinear() instead of open-coding
> skb->data_len.
> 
> >  				/* Unshare the packet so that it can be
> >  				 * modified by in-place decryption.
> >  				 */
> > diff --git a/net/rxrpc/conn_event.c b/net/rxrpc/conn_event.c
> > index a2130d25aaa9..eab7c5f2517a 100644
> > --- a/net/rxrpc/conn_event.c
> > +++ b/net/rxrpc/conn_event.c
> > @@ -245,7 +245,7 @@ static int rxrpc_verify_response(struct rxrpc_connection *conn,
> >  {
> >  	int ret;
> >  
> > -	if (skb_cloned(skb)) {
> > +	if (skb_cloned(skb) || skb->data_len) {
> 
> Ditto.

Thank you for the review.

I will submit a v2 patch.


Best regards,
Hyunwoo Kim

> 
> >  		/* Copy the packet if shared so that we can do in-place
> >  		 * decryption.
> >  		 */
> 
> Regards,
> Qingfang

