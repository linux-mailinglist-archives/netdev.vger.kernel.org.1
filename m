Return-Path: <netdev+bounces-272319-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLfNOHXfxWmECgUAu9opvQ
	(envelope-from <netdev+bounces-272319-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:37:57 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 603CB33DE01
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 02:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1B4FC3056B77
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 01:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1DE217662;
	Fri, 27 Mar 2026 01:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="maH48ih5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E41A0238C36
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 01:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774575434; cv=none; b=ntme7e0+8X0kh9EqHSFVeXDaYSN1/uqBpQcHhsoHEhvyjXFgQudG+QLCXLhxAbKgAcKi5PBdRFMza/XhzALV267wVBPeCnpXP58iYqgb98FN4/sYlqgSvW56r2iy2RDLB0AMh6zY8/2VvK4Gb9h9oQzXuGnG3m5ZGcH6kewWesw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774575434; c=relaxed/simple;
	bh=Hv+IpMZOEZMrWoelrXZdxKMJnmCBRKgJ4kESbMprbYM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Rw8EK1vNFTxJO9C2GuHV5kJAvW8G/NXO/v8VYnOb/IOCk0yCdneaxnVQKl1Vs3ALHObpRne6XhEQVj3ldlZL3W9wKKPx73q6yaYsb7H+X3diN4ONwqKuQHLT4cpC01ypVkSBU8VmrxhLkTAmgmdds375lXINLjQlOUwvTseOH1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=maH48ih5; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-35a07c4b17dso652052a91.2
        for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 18:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774575432; x=1775180232; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=oNVyVXDULJT9b9wQnfqOX73j1197ll5nFndF1FtF2Bg=;
        b=maH48ih5QHHs4NIgwekhD+/h4Os7o8ppUUaVMvG0wSZ29Dj97UOpkleulWjcaKxKdF
         oZcYfSOWruLBf6CKIOg+4kOr5gudAgFmPHZdlADcrjl0att7CSe9WBAgLPs+jpRUDeJz
         koj2LcrL+3fHMqnUQUvts+85HSH+13HeuPwKcgQZZQKYZA5J9Tz8WBb6+jcpwaAdtJOb
         rwbfNRMoS+BJIqrswLez4ACH7ocv7mgfh7hiEcdkoJgzm+Bivwk7gEuol3xGleI9w1Ui
         NrZs2/WNoL0joLRSflmai9aefiz6AFSUmkPeEcfe8SAMC3xfA71GTvVL11MKMaf2e/o8
         uKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774575432; x=1775180232;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oNVyVXDULJT9b9wQnfqOX73j1197ll5nFndF1FtF2Bg=;
        b=HmGasgt6dS8RqM7+ZHlfCdGOSh01V9IO+qClvwJ27dLWvZWg+4nzP7Ec9zHO2InAP/
         42i2/NJp7YNc684UrKmahRpzOe0nCgop+OkCxAiHB+HO6B+3f060PXSk2hyhY4HcMd3B
         +SbQbRPimlLo7WvXsxgyR8a8euCsRpjEnfsjuOS2SPAnN2bBln8sktMOoivtMPB5k/2x
         2EVDGFzB5mhRpg2Oqu5jkc4jlLYukeymLS5w6By91QwJOv+AnjmGHEfxS8NOGfLvIxH3
         ss3Sk+qrcKZGwks/A3qAI640XmV4zQen/umx+eeTc2ZPbT35M+BHuy9UklOxJXSrfOM9
         xQvQ==
X-Forwarded-Encrypted: i=1; AJvYcCWukagRMlwPGyjM51v09CXWQuQE34BlpSmgSVoHKr9CDeNd1MMVDl1VKETKAjVpIAFqquhBN14=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVHxfMYagb6JyYR8YvCpmsVMxWsTeMC85kdC7Wys8dOVceYngI
	zUCTZkQCTn8roBPwAf7uVDw97GIA5MuPbT4TXwMWIxCsWmpmetu+PF14
X-Gm-Gg: ATEYQzzvtg0e/5LxGUNZfiKtAFZHJ/SXcQ4BW0mHXCK7aoXKw9jGChmcwPEYuE2E3k/
	Wwh6PdsxhPmlQCwttXHiKJRVLLQTxESAsalbV4HwK9ZUkGDWos7QZyzCuedorx+TeRiuJpoMx7w
	r+lWjyRh+C7tu8yE9i8ql2CVIBkqBNV7gndbdRPtOqxFw68PZTqK45wHOk0ygYeBlVWkwEzWjo/
	VpUHtzUSNFpaGqGPWy4wm+MqTe1MUabZW+E1sgci2F0p5PomjoH5gOBCiF+2ADLNBNYuhRsyEHO
	gMFvr5+3BEyBz00DTS36vSLb7pRGU2latmAMmMCJVCpHfNNSHelog76wZNTtagyqpCRQL2mJ8oU
	GgMRsdoD9CQs+VjQubleqTV89sE/Y/vj9LS7EpblNx3FRCZghj5WSlv7j/SDX1OIsWrqOURAhJQ
	8VWxkSnkeCRjoXY4l9TDJc2bVC0XY=
X-Received: by 2002:a17:90b:52c3:b0:35b:a656:a614 with SMTP id 98e67ed59e1d1-35c300b20f5mr694076a91.21.1774575432185;
        Thu, 26 Mar 2026 18:37:12 -0700 (PDT)
Received: from fedora ([209.132.188.88])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c22de7443sm2705046a91.17.2026.03.26.18.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 18:37:11 -0700 (PDT)
Date: Fri, 27 Mar 2026 01:37:04 +0000
From: Hangbin Liu <liuhangbin@gmail.com>
To: Eric Dumazet <edumazet@google.com>
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Fei Liu <feliu@redhat.com>
Subject: Re: [PATCH net] ipv6: fix data race in fib6_metric_set() using
 cmpxchg
Message-ID: <acXfQPrFpHxhHzrl@fedora>
References: <20260326-b4-fib6_metric_set-kmemleak-v1-1-c89fc1b312c0@gmail.com>
 <CANn89i+SX1Kp7D2JzzEtg-zRkJzi4bdjzc2snvM7npJQzNp0+Q@mail.gmail.com>
 <acUw8zYwbbpgo8KJ@fedora>
 <39c100fe-1f6f-46d2-8dd5-cf82320508ff@linux.dev>
 <CANn89i+wuKmY7NNoe+RNPN0XZNHvzTDOyKDSwA3QJZE3BMgVfQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANn89i+wuKmY7NNoe+RNPN0XZNHvzTDOyKDSwA3QJZE3BMgVfQ@mail.gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272319-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[linux.dev,davemloft.net,kernel.org,redhat.com,gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[liuhangbin@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email]
X-Rspamd-Queue-Id: 603CB33DE01
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Mar 26, 2026 at 07:01:36AM -0700, Eric Dumazet wrote:
> On Thu, Mar 26, 2026 at 6:44 AM Jiayuan Chen <jiayuan.chen@linux.dev> wrote:
> >
> >
> > On 3/26/26 9:13 PM, Hangbin Liu wrote:
> > > On Thu, Mar 26, 2026 at 05:05:57AM -0700, Eric Dumazet wrote:
> > >>> diff --git a/net/ipv6/ip6_fib.c b/net/ipv6/ip6_fib.c
> > >>> index dd26657b6a4a..64de761f40d5 100644
> > >>> --- a/net/ipv6/ip6_fib.c
> > >>> +++ b/net/ipv6/ip6_fib.c
> > >>> @@ -730,14 +730,16 @@ void fib6_metric_set(struct fib6_info *f6i, int metric, u32 val)
> > >>>          if (!f6i)
> > >>>                  return;
> > >>>
> > >>> -       if (f6i->fib6_metrics == &dst_default_metrics) {
> > >>> +       if (READ_ONCE(f6i->fib6_metrics) == &dst_default_metrics) {
> > >>> +               struct dst_metrics *dflt = (struct dst_metrics *)&dst_default_metrics;
> > >>>                  struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
> > >>>
> > >>>                  if (!p)
> > >>>                          return;
> > >>>
> > >>>                  refcount_set(&p->refcnt, 1);
> > >>> -               f6i->fib6_metrics = p;
> > >>> +               if (cmpxchg(&f6i->fib6_metrics, dflt, p) != dflt)
> > >>> +                       kfree(p);
> > >>>          }
> > >>>
> > >> The following line should happen before the cmpxchg(),
> > >>   ->metrics[X] accesses also need READ_ONCE()/WRITE_ONCE() annotations.
> > > Hi Eric,
> > >
> > > Jiayuan also suggested to using READ_ONCE()/WRITE_ONCE() for metrics[X]
> > > accesses. But I don't get why this line should happen before the cmpxchg(),
> > > Would you please help explain?
> >
> >
> > I think what Eric means is something like this:
> >
> >
> > ...
> >          struct dst_metrics *p = kzalloc_obj(*p, GFP_ATOMIC);
> >
> >          if (!p)
> >              return;
> >
> >          p->metrics[metric - 1] = val;
> >          refcount_set(&p->refcnt, 1);
> >          if (cmpxchg(&f6i->fib6_metrics, dflt, p) != dflt)
> >              kfree(p);
> >          else
> >              return;
> >      }
> > }
> >
> > m = READ_ONCE(f6i->fib6_metrics);
> > WRITE_ONCE(m->metrics[metric - 1], val);
> >
> >
> > Since p is private data before being published via cmpxchg(), we can
> > safely initialize its metrics beforehand. This way we don't need to
> > worry about concurrent access to f6i->fib6_metrics->metrics[] during
> > initialization. Right?
> 
> Yes.  Think about RCU (Read Copy Update) rules.
> 
> We allocate an object, and populate it, then make sure changes are
> committed, before publishing the new pointer.
> 
> Othewise an other cpu could read a 0 metric, while we wanted something else.

Ah, got it. Thanks for the explanation.

Regards
Hangbin

