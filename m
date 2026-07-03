Return-Path: <netdev+bounces-304583-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4r38FU7IR2rtfAAAu9opvQ
	(envelope-from <netdev+bounces-304583-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 16:33:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC92703726
	for <lists+netdev@lfdr.de>; Fri, 03 Jul 2026 16:33:49 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b="i/VoiBVh";
	dkim=pass header.d=redhat.com header.s=google header.b="etpmCV/g";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304583-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304583-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F26783145CA4
	for <lists+netdev@lfdr.de>; Fri,  3 Jul 2026 14:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11A433DD51A;
	Fri,  3 Jul 2026 14:19:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30D344D86
	for <netdev@vger.kernel.org>; Fri,  3 Jul 2026 14:19:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783088389; cv=none; b=s1cGyq0Guj89Y9bgDTbE/N1l/cvPXzFrYsVAitgc19tAkvV7ib/tha3ulRDCzwcXPmfqVyEW27IWry3WxIJxgKUEidIo4r4ehzFlalsMV0Nzu9EjpkIFG0SA+rrwNtdaVQMXFaY2YBBd8NNHhAMZQwmp/CxkR1jyu12pdJkXt2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783088389; c=relaxed/simple;
	bh=q/RPtCBDsRXrN8eZhZjqfLHvK5UsV4Ryp4HYWQUEoaY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eJ+NVKKX6FRTMka3fbc+VtwSc2J+jl0O1MwkbYDFC5tpJkbonavdozPlD5DLBqYI6e4docQ1FvHUeiYy2D3LpS0D0zLbT5j1KCHr5Vm8nFFb89safo7h0JFliEZ8cGW+qWyZKb2cILwD1Q3PXmuLbOdMmeVl8z+a2sqDjadL0Ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=i/VoiBVh; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=etpmCV/g; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783088386;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gGk+ND3tT9bnKaJWndsC0fSRrq9dDoIDpmvUwc1Tfsc=;
	b=i/VoiBVhgOFVPQZWBMZqdyX/XqdlatwUGUaPwgg08obG/EJ/doQeOC7Mn3WZDvpxgaVMfu
	gMecXHbIDsA+w85Vt6ldjKXb5rmYN/559ENt12hqXkQnwoSJYdFVJzrJ3AIxvBXQZNQp/O
	sz84Uda7yA7eGU4cT3STLCt6g5OQC1w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-351-spFpfieAMEONBkf_Eayeww-1; Fri, 03 Jul 2026 10:19:45 -0400
X-MC-Unique: spFpfieAMEONBkf_Eayeww-1
X-Mimecast-MFC-AGG-ID: spFpfieAMEONBkf_Eayeww_1783088384
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493b54823bdso11297635e9.0
        for <netdev@vger.kernel.org>; Fri, 03 Jul 2026 07:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783088384; x=1783693184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gGk+ND3tT9bnKaJWndsC0fSRrq9dDoIDpmvUwc1Tfsc=;
        b=etpmCV/gLITc/y4JCqoi+/yOT0y9zmrp72h7bREPw+WzZuJZjmxRMJe9A6EgQ6n+2e
         TpbCpgE+2iWiFCJ1iAtGn8F+cafT/sgKG8qaCFeuZnA4cm2RWtmLef4Dn9lpBSl7QSKB
         eZgXPaYlbjR/eEHJz0QXyhRcaop1AocSCKVcZ45Eb2QiX601eoTfH4103s0ZIESBlrcs
         RQCvrgDo5j+jnLfLe5UC8Gk8T49KIKnnq2LZSNqSvznBT6oCbzIw6wbFKdhSKUx45Qis
         M+HCMcZYRZUInD83E7lRySbPXkL0brB7gVN1goS3sFA8FgMsA2WLl2kBbEvHxBXXPy/p
         uUXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783088384; x=1783693184;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gGk+ND3tT9bnKaJWndsC0fSRrq9dDoIDpmvUwc1Tfsc=;
        b=pwO3PRfzR/c0rjbF453p1pfIVfthYY3XmZqevlGApBAd906/WgEcZDR3FkbG1xJpja
         8K9xm4PmO0WZEkaQ9m02PlGb/D05aRshuJQF+50fpef1SOCN7v+4mTRcAf0BvBntuI77
         2HoMcXqHL+TdnRBYBpiHTMEpKizmYGDXzGt4Xs1owgUfH+p1e5h8zAeqCJeXtnY8JipW
         aaEH7KypBHkVldJheHZwtCd1XPExUKz5j1AFDpWpJnxIriCbySaf6lzupemdq2+ZSCs2
         v8lwQJKY5BppmGIvGnjRD+z2RZ7uyHPCjlYpkwf3raY9Ro5CNmgOxCxJRHctTRM6LYLo
         0UFQ==
X-Forwarded-Encrypted: i=1; AFNElJ9h/9qjXoH202jGQhnR/6fPEzCabT/25rnODtn6oHtYf9D/DlQ2/FnWjDXttX7ukwBGX1r5HFg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrX6vui3vWFTxnO4L/xmwdwFiGwF8YcDIe+kO71wJYP4Z4W2ik
	3ggaecuXAQXkyG2TjP+BWlWatSk2M8cpWzIPcylqubGGqe7jY1PeEnBkfFnlZ3qYLqApBrEewkM
	IRhXrVtEf4U3aF/d4LH6wT0D+CLl/8mOv6FXhtGSpzObYAzG2Exl0op8NVg==
X-Gm-Gg: AfdE7cm8qOdKRbmHx0My55JaVCIjsgYngimI2e8CUnDHqacHTzkcUZC4GD3IgnKjXZb
	D3cY24wEm79YX6GzPldfc6Kvn896enjyBlmfIqB3ukANMGoUrX9hnBUN6xUniTfi3QHXgeV5uEv
	rNHauaS+akYbc4ZEHq0rEY7Tx/9TdcE35cs6zZUG6bcZHHWMNkwB2Xh0sXobkgwZE5zohLhvXMg
	NIo41t+D8UUxxEr8IbIbAdEjvKC3VRzVP8pNZjfBWHYpYRAdKfb65hXRDtFXMp25EG0DPZi9mb0
	rV8i75Vx1rngbJ/4r/FYbF+amf5J3jTgcbe5/0IFLN158Qe51aYq0YmioGP8YZqvx7faIQkMMeL
	tA3eCNVvnUu+n2CTVM1izUlZkB8lf6Ui+
X-Received: by 2002:a05:600c:34ca:b0:490:b26c:64ad with SMTP id 5b1f17b1804b1-493c9b4d759mr50356785e9.5.1783088384271;
        Fri, 03 Jul 2026 07:19:44 -0700 (PDT)
X-Received: by 2002:a05:600c:34ca:b0:490:b26c:64ad with SMTP id 5b1f17b1804b1-493c9b4d759mr50356475e9.5.1783088383785;
        Fri, 03 Jul 2026 07:19:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-68-31.inter.net.il. [80.230.68.31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493c63bfba1sm156369225e9.15.2026.07.03.07.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 07:19:43 -0700 (PDT)
Date: Fri, 3 Jul 2026 10:19:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Brett Sheffield <bacs@librecast.net>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>,
	regressions@lists.linux.dev, netdev@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Tim Gebauer <tim.gebauer@tu-dortmund.de>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowang@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION][BISECTED] tun/tap & vhost-net: multi-threaded
 network performance
Message-ID: <20260703101823-mutt-send-email-mst@kernel.org>
References: <akVnoOYQOrt8k-Gu@karahi.librecast.net>
 <20260701165359-mutt-send-email-mst@kernel.org>
 <ef33f0a7-f0b7-4bc4-9263-10d2b480d717@tu-dortmund.de>
 <akZGg96-Xu9VeGrw@karahi.librecast.net>
 <20260702185420-mutt-send-email-mst@kernel.org>
 <akfDnfkgorxJ_Q6G@karahi.librecast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akfDnfkgorxJ_Q6G@karahi.librecast.net>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-304583-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:bacs@librecast.net,m:simon.schippers@tu-dortmund.de,m:regressions@lists.linux.dev,m:netdev@vger.kernel.org,m:kuba@kernel.org,m:tim.gebauer@tu-dortmund.de,m:willemdebruijn.kernel@gmail.com,m:jasowang@redhat.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:willemdebruijnkernel@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[tu-dortmund.de,lists.linux.dev,vger.kernel.org,kernel.org,gmail.com,redhat.com,lunn.ch,davemloft.net,google.com];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mst@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EC92703726

On Fri, Jul 03, 2026 at 04:13:49PM +0200, Brett Sheffield wrote:
> On 2026-07-02 18:55, Michael S. Tsirkin wrote:
> > On Thu, Jul 02, 2026 at 01:07:47PM +0200, Brett Sheffield wrote:
> > > On 2026-07-02 09:24, Simon Schippers wrote:
> > > > On 7/1/26 22:56, Michael S. Tsirkin wrote:
> > > > > - does it help to increase the tun queue size?
> > > > 
> > > > I agree, this would be great to know.
> 
> I tried adding a queue (qdisc pfifo limit 500) on both host and guest - no
> apparent difference in drops or performance.
> 
> If there's any other setting you want me to try, let me know.
> 
> > Maybe it's the supposedly rare case? Does this change anything
> > for you?
> 
> I also tried both patches, but again, no noticable difference.
> 

Thank you. Simon pointed out issues with the patches but he also said his
intuition is strongly that it's not the way to go.
Let's wait for him to post the backpressure patch, we'll see.

-- 
MST


