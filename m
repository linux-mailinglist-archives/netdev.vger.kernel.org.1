Return-Path: <netdev+bounces-259509-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHG5Fgg1l2kCvwIAu9opvQ
	(envelope-from <netdev+bounces-259509-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:06:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B533B1607EE
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 17:06:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 133FF30125EB
	for <lists+netdev@lfdr.de>; Thu, 19 Feb 2026 16:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEF234B191;
	Thu, 19 Feb 2026 16:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KTKRA9Yb"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f196.google.com (mail-yw1-f196.google.com [209.85.128.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29183344050
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 16:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771517168; cv=none; b=FOqNOisAld6HAWahE7QLlkX5XV1Jc6zLitVNrVSMvusixm3LqBsHN/62P/d29JGUF1wpjfdcc9/r0JnLHG1gGQOklqLOAm6U5zrUHFyjAoC1j8SICDDUui9AtOtzOg5CL3fcrk2qztkM1A8jdqT3qwgroghp9irGN33NUGSGyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771517168; c=relaxed/simple;
	bh=4yMC99NeJMMCPXT8o7FBF9zbcjvh5tyBVPAtjWfERlY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q3s3/kn10Jmd+RiQ5a7rtTPdFGZEm2jzAdAZILkbR0ekj0Oo6iQxSX/9sc9ejtAmMmtQwAJ+VTHt1d70zmgyn7nDvCLYAeE3QfofsIYCeWYgb7JPwGBo+TfW05DjW4dYc1RFLlQ3wfCBBRvhHSUhn+SSNLW9RgYET8hCm/l3cPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KTKRA9Yb; arc=none smtp.client-ip=209.85.128.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f196.google.com with SMTP id 00721157ae682-79088484065so10167677b3.1
        for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 08:06:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771517166; x=1772121966; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pJXEV0fGE0delcXeFKX2uACQoYyrpadO3o4R7qcFW9g=;
        b=KTKRA9YbazNu4TqwFhNxX59aOrp4Bfarg2kUPhdqFTSL+QYD0G35e6yUd2F6zM4TFs
         pQyqh1x0isberlefOWaH84y4gz7qinX4PeFFvXAH+feHCFxnRT73YRCqwsUZyD9phlga
         cueD7ZcuWCwYP2C7oXyDClKe3Af0YGZapEECrJY27ZqN5s0Gnhv8lMgvNGKL9wgXLuLP
         m6RLkbt04EpZ7JRtyvL0PuPsJaciyLOyPIyjTewh78YblNhYi4060Tg+hfbgyhvymz91
         3WkBX0b2MATxczn2pB/hBzLPDmJskzMw0gjo8bgdn7Zd1EEHClku4uNHywliEt2sBjPw
         zTTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771517166; x=1772121966;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJXEV0fGE0delcXeFKX2uACQoYyrpadO3o4R7qcFW9g=;
        b=FAFB9X5WtK3R0tOWbKwsIbRMseq6Dr+0axT8kgZqFNsb7StaBGY5pRDldjm/8/5S+t
         1JGv18JLpQUtMr7D0mNb9+SZMpUaJTi+mqsssGCzMFryKu2gMDqXwdFgiq1hi94IfSgh
         R+wcw7ltZ9Tl1CwSzK9PXlj5BQysB1qn/314Qxoy3bj6Wjo/CmArrIXzYR//R6hw+ahX
         icsTwZdZfFBRezWrxprusn71DRHvV+VyXpilqtfyiN+i6K8cc2hhh4vf3bwBUd8+BYJz
         PacUFNeMDVzfRowDtf5jySAnnsoYUDqgP5iLnyUThZap8cwarE/7E68lheJnz7mzkTYx
         omwg==
X-Forwarded-Encrypted: i=1; AJvYcCX7dhlLxGYgao73UVrMgg+5z/I5KTetiHAvmtbi2zBZe2uwdp/4U1JuppLQTaJLSiI9CpBxDfQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTK4PGxFIIZKEDOw2+0GGrm7A7Lvzk4XVi3z/5L4Z38eesa2HM
	TLCYnu3cmOtbC66U3w2ah/2dKGTl7gmn95j7s7eaK85oSNmOgqDuFedH
X-Gm-Gg: AZuq6aIIjJiEn0mnpCsSvrUkquCHWDiRHfEgdec1SCHEP9quTcmi3FRkTFbFgiNkZuN
	IfdP+9of6MclWey3BX3Xo+rlwfs0Pmy5noYUV69eZNOFBYIMP6/Jr1dktOzExezkMKoF53RXLis
	xCcR7yMaLJBvzTo1ZvuZEA0IjHT5yHfyGiJB8jSj7U4jPkDBEjmnW3XLW746mlUzCs6i7xpA5ZR
	KUmXm4ufBQ7YP9/nAjQFQPjJ+iDoN/sytTNX8i7HqffQYwpvzcTaDLCgy6EaSyuT/Qn+AkuqgQl
	aoN8p110It2zV+oZq33xBYWsH39PmJMFciS7+fNqhOI/tLsB3yMhDszTcUFtq974n8GBD3UdY3g
	iQkK4Mc6xvk41vyvm7VVUTzhiX9kkOLL+oqXup/IgjQjsdkeS5t8i3ni9H0ZxxD62ksRBDgrfDJ
	FclvSprjC/OdCHXvmI9V8NY32GBPHeGjAk8KON58QuCezV7jc=
X-Received: by 2002:a05:690c:6c86:b0:795:c78:b633 with SMTP id 00721157ae682-797f73f4d48mr49916427b3.62.1771517165867;
        Thu, 19 Feb 2026 08:06:05 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7966c18b464sm135320017b3.13.2026.02.19.08.06.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Feb 2026 08:06:05 -0800 (PST)
Date: Thu, 19 Feb 2026 08:06:04 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH net v2 3/3] vsock: document write-once behavior of the
 child_ns_mode sysctl
Message-ID: <aZc07N4BFw0hhnoZ@devvm11784.nha0.facebook.com>
References: <20260218-vsock-ns-write-once-v2-0-19e4c50d509a@meta.com>
 <20260218-vsock-ns-write-once-v2-3-19e4c50d509a@meta.com>
 <aZbN8fXtCkhItSV8@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZbN8fXtCkhItSV8@sgarzare-redhat>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-259509-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[devvm11784.nha0.facebook.com:mid,meta.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B533B1607EE
X-Rspamd-Action: no action

On Thu, Feb 19, 2026 at 11:36:40AM +0100, Stefano Garzarella wrote:
> On Wed, Feb 18, 2026 at 10:10:38AM -0800, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > Update the vsock child_ns_mode documentation to include the new the
> 
> nit: s/the new the/the new
> 
> > write-once semantics of setting child_ns_mode. The semantics are
> > implemented in a different patch in this series.
> 
> s/different/preceding ?
> 
> IMO this can be squashed with the previous patch, but not sure netdev policy
> about that. Not a strong opinion, it's fine also in this way.
> 
> > 
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Documentation/admin-guide/sysctl/net.rst | 10 +++++++---
> > 1 file changed, 7 insertions(+), 3 deletions(-)
> > 
> > diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
> > index c10530624f1e..976a176fb451 100644
> > --- a/Documentation/admin-guide/sysctl/net.rst
> > +++ b/Documentation/admin-guide/sysctl/net.rst
> > @@ -581,9 +581,9 @@ The init_net mode is always ``global``.
> > child_ns_mode
> > -------------
> > 
> > -Controls what mode newly created child namespaces will inherit. At namespace
> > -creation, ``ns_mode`` is inherited from the parent's ``child_ns_mode``. The
> > -initial value matches the namespace's own ``ns_mode``.
> > +Write-once. Controls what mode newly created child namespaces will inherit. At
> > +namespace creation, ``ns_mode`` is inherited from the parent's
> > +``child_ns_mode``. The initial value matches the namespace's own ``ns_mode``.
> > 
> > Values:
> > 
> > @@ -594,6 +594,10 @@ Values:
> > 	  their sockets will only be able to connect within their own
> > 	  namespace.
> > 
> > +``child_ns_mode`` can only be written once per namespace. Writing the same
> > +value that is already set succeeds. Writing a different value after the first
> > +write returns ``-EBUSY``.
> 
> nit: instead of saying that it can only be written once, we could say that
> the first write locks the value, to be closer to the actual behavior,
> something like this:
> 
>   The first write to ``child_ns_mode`` locks its value. Subsequent
>   writes of the same value succeed, but writing a different value
>   returns ``-EBUSY``.
> 
> 
> Thanks,
> Stefano

Sounds good! I agree that is more clear. I'll also remove the change
above that adds "Write-once" at the beginning of the paragraph, since
this clause does a better job explaining how it actually works.

> 
> > +
> > Changing ``child_ns_mode`` only affects namespaces created after the change;
> > it does not modify the current namespace or any existing children.
> > 
> > 
> > -- 
> > 2.47.3
> > 
> 

