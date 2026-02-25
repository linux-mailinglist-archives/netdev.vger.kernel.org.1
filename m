Return-Path: <netdev+bounces-261011-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEoDNdETn2nWYwQAu9opvQ
	(envelope-from <netdev+bounces-261011-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:22:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9A219986D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 16:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 34C9530A7F4B
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 15:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50A663D7D8E;
	Wed, 25 Feb 2026 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LvuIoCM7"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF8345C0B
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772032492; cv=none; b=i+bkIDIF7bFSW9qjRQjwDYCSZKfSu4uYpPbynYEdSD61pyHyau/eK4aUmYA7n1ktCGwQewwQ3jWleDDEbdQOrJwsSaJ/Xgyn9xsJpWbfno7aWQJi7QTZCxqtH2JiC+TC6R2v7j39QtU+pfdhlXMoQbhw5KFQnJQmXGzwlay8ILY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772032492; c=relaxed/simple;
	bh=VfLwbQTWRqJ9p2z5oBuHtvnwEkZsPqYdX41RY6Y6XYs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g7LFF+VL9sTvoGwpmrByMGWW1cn+uluaazsW+rO4pR5d51skTZJyD3qxQ0QMwAV+IB3A7zxadkNcHybpOCDAGzSBvmJ+tSrfRO2a3C1jDpsANvlXglT/5KoygzZKuJYuN8cUdEGF/wKEkmX4TiRyvsGDj99ueZZoqk1jYPQTJsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LvuIoCM7; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-64caaacb9bcso677114d50.1
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 07:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772032489; x=1772637289; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6WNBbOPPM7eifFdwJBPvZW84/lfztyEzVfKEidDFiDc=;
        b=LvuIoCM7/OEWHB85aLEodTlIVWbURk7fcC1OYTKBhBMiSDoL8osvCS8G7A60gMBd2a
         F6TMvOEYK7TT0SAKVLp7tZ9xTuCjJoERv/mFMkM+pIynyCNZ7tkTDlUr8kYgaV/vYQtu
         errLFsZVaF5DAlda9nsBAgJLcEDsGnG89KzEmp5YQZj/HvFE5bHR7Y1Jnl1eyz2L6yLa
         kJqfIIJumUNUNs5XmHOT4kVT9atu4jgnecNZghw7yTKs1VhuqkBDPUiSnMsA9i8NYUA0
         A0Hh7A0qiMXSUhFwUUaCTbUUyR+UL/o1lbThc/b9LgNMFdp58idP6GRdIg4REZ74Ec1k
         Mdkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772032489; x=1772637289;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WNBbOPPM7eifFdwJBPvZW84/lfztyEzVfKEidDFiDc=;
        b=abq3nhB4DdYUEvungLSQxX/1M0Ko5m1t+YfSfyffC87xnPbyuUqwboZqabArbz2Am5
         0lIDBl1xmmr585qBTUrq3vv6wGX358G+kQuVmuzuDG3iJx2BFgGo+t+NUePuzkooiAhu
         seEFHrjGpSW0gndNYXPALvsDFmHBchb81+0Jj/upQ56aSrLWgtjHIxzXYEKLqiFgm1zT
         1Ql7wkZtFxfOz9SumiQFK4qdBxBVIL8eJQ2ioNzKxVOdLjINthmN6IQQcxAH+AwSj5Wt
         rIbouM/GtWfcUoeXwomIvNdrAkAEFnHPi9v8qd0JZA/aeHczoaWbwpHZfoEnU7d3TEaw
         vcSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiRF5asCUW9DvCKxAiHVrEfMKG0FmYC07OsrPrlD/5mt50QGKvsD/Gs2yWK4VjctBwPsNNPnE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSfXvPrSLVYyoMHrCgTNLcC3LtbX5xJp5XlJefrUAPjpnLnwPp
	8kfFZVdoNnRYxY5RKBlQ9tZQ0VtsFB48r68F53BpCvGD2b2mPltDSS87
X-Gm-Gg: ATEYQzybD/XkvMJzSoXoeVyivdCnofxI6fGt5glls9b11tA9k4gw5/fVexGkTYdicZx
	jPcyeNVIovli5UgO8ICxDgCKbZ8hHNhQeEqK6djxj0wbktzWINMwEaV2twA4K1HhoZUDrjXqFSf
	UmHZDy7C8vzvKgO6RwZSmSYtsDMUwGhUmDs832gUpK1mYbmOOc1zwINQCWiGVD4FZdAMI93CbR+
	hy643dwVKcrcfyWizGf+uMjGiWDnakHtvFYqaGxkGMTyqSAQzEXl6OJIbpYSk42TGm6AN+YVS+D
	AyZURwVaF33p+da3GT3whMH1u3MNqhWIvCTBPd70pC0ZhxlrshE2z8EgDk74D35XeCrd64PhzWZ
	hhha01zyRPbXp6MWiXLiz7M8AYiOOiNV2WOJ1YBwcZhJv1OOHvT9dpoS9FPQs0bjdsnCjFD+2Uq
	N2e4JBB6zz6+cea7pUde4jxyuu4wJOzt5uyMjWnO5H/t2/4kZUCotTZzye+A==
X-Received: by 2002:a05:690e:b8a:b0:64c:9aa3:b0cb with SMTP id 956f58d0204a3-64c9aa3b14fmr5357466d50.14.1772032489206;
        Wed, 25 Feb 2026 07:14:49 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:72::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64c7a37abafsm5618712d50.16.2026.02.25.07.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 07:14:48 -0800 (PST)
Date: Wed, 25 Feb 2026 07:14:46 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Mina Almasry <almasrymina@google.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] net: devmem: use READ_ONCE/WRITE_ONCE on binding->dev
Message-ID: <aZ8R5n80NmnPb1J9@devvm11784.nha0.facebook.com>
References: <20260223-devmem-membar-fix-v1-1-37dcae1e49f8@meta.com>
 <aZ5VNkUqkTEzX6PJ@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ5VNkUqkTEzX6PJ@mini-arch>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-261011-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: 1A9A219986D
X-Rspamd-Action: no action

On Tue, Feb 24, 2026 at 05:49:42PM -0800, Stanislav Fomichev wrote:
> On 02/23, Bobby Eshleman wrote:
> > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > 
> > binding->dev is protected on the write-side in
> > mp_dmabuf_devmem_uninstall() against concurrent writes, but due to the
> > concurrent bare read in net_devmem_get_binding() it should be wrapped in
> > a READ_ONCE/WRITE_ONCE pair to make sure no compiler optimizations play
> > with the underlying register in unforeseen ways.
> > 
> > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> > ---
> > Note1: This didn't crop up in a discrete error, but just something that
> > didn't seem to quite follow my understanding of memory-barriers.txt, as
> > frail and feeble as that understanding may be.
> > 
> > Note2: the "Fixes" commit I referenced is the first one to introduce
> > binding->dev bare accesses, but the later patch '6a2108c78069 ("net:
> > devmem: refresh devmem TX dst in case of route invalidation")' carried
> > that forward. I wasn't sure which was the ideal one to select for the
> > "Fixes" label.
> > ---
> >  net/core/devmem.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> > 
> > diff --git a/net/core/devmem.c b/net/core/devmem.c
> > index 63f093f7d2b2..cb989949d43c 100644
> > --- a/net/core/devmem.c
> > +++ b/net/core/devmem.c
> > @@ -398,7 +398,8 @@ struct net_devmem_dmabuf_binding *net_devmem_get_binding(struct sock *sk,
> >  	 * net_device.
> >  	 */
> >  	dst_dev = dst_dev_rcu(dst);
> > -	if (unlikely(!dst_dev) || unlikely(dst_dev != binding->dev)) {
> > +	if (unlikely(!dst_dev) ||
> > +	    unlikely(dst_dev != READ_ONCE(binding->dev))) {
> >  		err = -ENODEV;
> >  		goto out_unlock;
> >  	}
> 
> What about the other similar check in validate_xmit_unreadable_skb?
> 
> I don't have a strong opinion, but it feels like as long as we are not
> using these ->dev pointers (and we are only using them for comparisons),
> we should be fine (plus, memory tearing for u64 is not something that
> can happen?).

Makes sense. I don't think it presents a current problem, its just
defensive (e.g., someday other functions referencing binding->dev get
inlined here and the compiler does load omission or invented loads). I
didn't know about u64 being immune to memory tearing.

If it doesn't look like an issue to anyone else, I'll not try to push on
this.

Best,
Bobby

