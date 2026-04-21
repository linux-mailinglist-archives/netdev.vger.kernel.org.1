Return-Path: <netdev+bounces-280269-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOb9OVz552kVDgIAu9opvQ
	(envelope-from <netdev+bounces-280269-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:25:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C78324402B4
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D29B300736E
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177753A545D;
	Tue, 21 Apr 2026 22:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tGMYyIp0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com [209.85.167.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C1CF3A4F30
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776810235; cv=none; b=kRnDWUsApTX6UUSPNc/OxnKSYSMV97CEFMt+wBITbJ0DzIk4UQp9zTi5UPXAeIYa++K6OExUVQw1Nd42EeqwY7f+SH3pgAY8FCPUek/FoauZ/p7GthTp8S7eoNXsOAl+LhpCFfPlkPXp7Hvc4Fzky9zjbe4Li43gJvHGu8OU3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776810235; c=relaxed/simple;
	bh=sgxlv1Gy4m4rsCqWOlyOFq+BVwQIC9aK9+QByuoBKgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gxQ//d3c3AMWfjZc3Brx+ThchKyDuDe34PXZVES5T8sld9kh09CeVrN54Mqgxscgfe58OQCVSBjbv/fwuLgj63qL2WMgczacIRoRhBzK9sata3ctfihSuhqWxzbzrQSknplvNoxoJgHwsKNajylwzhRdpBfJlCE6o5pr5JqBxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tGMYyIp0; arc=none smtp.client-ip=209.85.167.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f194.google.com with SMTP id 5614622812f47-479ae363aaeso2600902b6e.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776810232; x=1777415032; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lKoAeQw3fgOsyloCGOYdd/7n6rBcnHophybPgqTIkU8=;
        b=tGMYyIp0O11x1j55iLJCIGvJU28dQap3Y7yqipAhblBl5grCmQA7TlUk5QncCtQNZy
         DSO6DFNeVHan1jHgz7nHcbIsfFlpmU5/PeriByy+rEjFXbvKNPYizvt/PDzapPgwU53y
         zEPD02hL0w9p7I5U31IG6y5GH0X2qmzAWWuwIFwOtTsnay1UvTL0a/DWSPbSviodt9Hf
         Da8oZjkOkAYbgVl7Wcu/cosqNYrHGqAq8QwIEqU+dsZCOJY34TFAFMlIwzD9OL8mNleC
         YkT/fSpWjuNJKD59Ou62u9id9JuvjsAtcAxzmCncbommTZjGLIdBq1Ing/XFyBEa+XHu
         b4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776810232; x=1777415032;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lKoAeQw3fgOsyloCGOYdd/7n6rBcnHophybPgqTIkU8=;
        b=e9CoNn5anrYbQyqxgJCkwIT59ER8OI7EIRPgj0nXVzNnfXQ1Mzz61ypj7D7R1ngIYN
         LYGoNwcr69eZZKkFOYNy/eNF7AtgAY4gkkVc/EX1jlPxgclgdpw9ReauFA/8qLBgY2hy
         BiCgMEF9DPL25Q3DU/3lrM/HWXKkcDK20v37BRkR7wG8UsiBdrqs7Pn/wk2hWdnMjpKB
         sF+0Y6u2ETYJMr1+Lg+IGYzidnRYsuU844IY9L4bmecjGsgI1PbV1p/oe0WfV8fpnRen
         lxUHDL2UGTNyim2eDKARcahY9efc8MowfIVgRJHxuE7NTAUsc9PIeQInpXzj4pFI7JXz
         mQ0A==
X-Forwarded-Encrypted: i=1; AFNElJ+fr/vY/pBnq+Ygn8eAA3dxO041Sdfm5C0hMlIKBND5fvOCBV4tma67Mz8XMZgybpGK6/nxFx4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLXtXVrX3ZjK1ObYHAIPYna7MBhFVfTGBfhxBPY49u9J+0Tdt9
	8CkwgXRENc3fzu68fDqgHR783zS9oCP0MYAqnQfWBdSOmb0OWOqfDbHc
X-Gm-Gg: AeBDietoUivTPyPMGx7+ZRWfCkA/ZUglEtozU0xv3tY9UF79Dr846PECxzr6r7kXTiB
	AxyNFpu4kopQC+SwRjXJZfnogBuejSP1z1YqCDLpLEMQ1gEstwFXI00WBBy2gkIdWf/chxnc8kb
	GAniaLGO35dNuNWuj220UjTXhibhU+1z1VRIeftOxVW1l/S7j843yvHzLwxgrfZjexLRutSYB9u
	83v8kKHRHGB7ee0QXWVlx3pXthavK9ApgArNiL2sQdxgpypyUjGjqy5Bj8+WgGm6h6yEeyWqWvN
	5utF+vllLH9jn1bNdi7bun0N9ANAAGS449ZV4AX8TFTawuma20bw6YvXHaRqmwRfQiHVvIEJv4W
	HHPjX/uUU8u2y3UACjUK8OBBxcV3X1t8Lo6MSOIE7IXsF2aCdFeZ9fC4GBoR/DHe2vqnV9NtiPN
	f4ZcBWdkUMsoiQY16PSrBNTy5rU9M=
X-Received: by 2002:a05:6808:1a19:b0:475:be2f:c56b with SMTP id 5614622812f47-4799bc82da9mr9234418b6e.3.1776810232611;
        Tue, 21 Apr 2026 15:23:52 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:8::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7dc975b0591sm12293852a34.19.2026.04.21.15.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:23:52 -0700 (PDT)
Date: Tue, 21 Apr 2026 15:23:51 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jason Xing <kerneljasonxing@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, bjorn@kernel.org, magnus.karlsson@intel.com, 
	maciej.fijalkowski@intel.com, jonathan.lemon@gmail.com, sdf@fomichev.me, ast@kernel.org, 
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, Jason Xing <kernelxing@tencent.com>
Subject: Re: [PATCH net v2 8/8] xsk: fix u64 descriptor address truncation on
 32-bit architectures
Message-ID: <aef4XHnqR2cs5U1O@devvm17672.vll0.facebook.com>
References: <20260420082805.14844-1-kerneljasonxing@gmail.com>
 <20260420082805.14844-9-kerneljasonxing@gmail.com>
 <aeaCzchKwsp_LWyA@devvm17672.vll0.facebook.com>
 <CAL+tcoCxQ8cU+wr7eJsMH+FPMcp+vQ4J4BdSdsVqyTRqN8q9LQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL+tcoCxQ8cU+wr7eJsMH+FPMcp+vQ4J4BdSdsVqyTRqN8q9LQ@mail.gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280269-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,intel.com,gmail.com,fomichev.me,iogearbox.net,vger.kernel.org,tencent.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tencent.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,devvm17672.vll0.facebook.com:mid]
X-Rspamd-Queue-Id: C78324402B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/21, Jason Xing wrote:
> On Tue, Apr 21, 2026 at 3:49 AM Stanislav Fomichev <sdf.kernel@gmail.com> wrote:
> >
> > On 04/20, Jason Xing wrote:
> > > From: Jason Xing <kernelxing@tencent.com>
> > >
> > > In copy mode TX, xsk_skb_destructor_set_addr() stores the 64-bit
> > > descriptor address into skb_shinfo(skb)->destructor_arg (void *) via a
> > > uintptr_t cast:
> > >
> > >     skb_shinfo(skb)->destructor_arg = (void *)((uintptr_t)addr | 0x1UL);
> > >
> > > On 32-bit architectures uintptr_t is 32 bits, so the upper 32 bits of
> > > the descriptor address are silently dropped. In XDP_ZEROCOPY unaligned
> > > mode the chunk offset is encoded in bits 48-63 of the descriptor
> > > address (XSK_UNALIGNED_BUF_OFFSET_SHIFT = 48), meaning the offset is
> > > lost entirely. The completion queue then returns a truncated address to
> > > userspace, making buffer recycling impossible.
> > >
> > > Fix this by handling the 32-bit case directly in
> > > xsk_skb_destructor_set_addr(): when !CONFIG_64BIT, allocate an xsk_addrs
> > > struct (the same path already used for multi-descriptor SKBs) to store
> > > the full u64 address.
> >
> > Is it easier to make XSK `depends on 64BIT` to avoid dealing with that? Does
> 
> Of course, it would be super easy. Actually the initial version looks
> like this. One line of coder is simply enough.
> 
> > anybody seriously run af_xdp on 32 bit systems?
> 
> But my worry as you guess is if there exists a 32 bit system? I doubt
> it. That's why I put some effort into adding the compatibility code to
> cover the case. Good news is that it doesn't add any side effects of
> the 64 bit system since they are protected under IS_ENABLED condition.

If someone complains, we can follow up? af_xdp is all u64 everywhere,
including uapi, I doubt someone is using it on 32 bit systems. We don't
test this part on 32 bit systems on nipa either..

