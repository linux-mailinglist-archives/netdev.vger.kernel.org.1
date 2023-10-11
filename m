Return-Path: <netdev+bounces-40060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B74CA7C5973
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 18:46:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7D921C20C6C
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 080BA1F95C;
	Wed, 11 Oct 2023 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=networkplumber-org.20230601.gappssmtp.com header.i=@networkplumber-org.20230601.gappssmtp.com header.b="dxwEG/jU"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E71B29B
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 16:45:57 +0000 (UTC)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87D2E102
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:45:54 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-690ba63891dso5437855b3a.2
        for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 09:45:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1697042753; x=1697647553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lr+EBAj14Rs65GPKg1fm8d3yEGR/1EPfgZFUkgBtH0w=;
        b=dxwEG/jUC7w6f0cKQsGoZZ0fkmdyOz1cifFYbvmkY9OtcnPKH69KXPBIoRMKsHY6ni
         7RhFNL/LdUD2/Q8y6q3pX+vGtIb2g/+iUPoTzXIKLPGTsI3JLU8Az9AplXhQtVPPg/na
         tLj03K3LdP+CDWMg0/NR7h/ZP6ZJ4Nj7lkeSVm9io/yCacvsOpCnQtmo7LZ3Pgi4eLBo
         ewfA2B9tVsuyQLb8uBuDKaNBaQaEef/8AI1LygsrB9COXuc4/epkdvhRZVBgtUAGb6lB
         ocj1MzT6Y/63TPjH9ub8VoVVVoPVx7Ws+4++0OpP0BXO0dcL5O7LXFWQZi3t+KWQVb/s
         3NoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697042753; x=1697647553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lr+EBAj14Rs65GPKg1fm8d3yEGR/1EPfgZFUkgBtH0w=;
        b=rr1eO5X7Boclvf+YBhql+rk58PrBg3jHV4x+kw8E95d+0vMKWLMwLLDwLvgFLDxcyM
         glxHsRoamUgT2XHgPBkRufFZRkcnCxbLAcsvZTvMAs3ZR7FbDfb7LlP46WEa1dQfin0h
         vohkYQF9n8aqGbzO/bF9ildagQXVTLxPCunzHF5jL6bFW8Fv0HCV/eJohBydQAvMTeN+
         t+9a+ZUw+LUM9nSFGiGQKo+H26MUNIpuQfRIk7UyH2Glham+MFYgX8i6A+RokiwHxNvq
         QCucibIIPg1kwWA27uF55p5+fdj3ZYgb5XR6Ppgiu0sIYQaeQGWR3n8ceIl5DRly2XUx
         sSww==
X-Gm-Message-State: AOJu0Ywsr/cUe4NuD2Ux0rz98MGFIw/2CnywvLxPJgyi+YCNf12WID9l
	MhUXygHBH0TU+IjTYU4fSTFIJg==
X-Google-Smtp-Source: AGHT+IHDq4Mau6Z529IfFDBnsZXEPjp7MEUevIAynlhB2Hl/Lfkq87FE6/kWrHXm3syM5xtBZOwPRg==
X-Received: by 2002:a05:6a00:4704:b0:6ac:e9ab:c612 with SMTP id df4-20020a056a00470400b006ace9abc612mr382431pfb.16.1697042752938;
        Wed, 11 Oct 2023 09:45:52 -0700 (PDT)
Received: from hermes.local (204-195-126-68.wavecable.com. [204.195.126.68])
        by smtp.gmail.com with ESMTPSA id a28-20020a056a001d1c00b0068a6972ca0esm4054899pfx.106.2023.10.11.09.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Oct 2023 09:45:52 -0700 (PDT)
Date: Wed, 11 Oct 2023 09:45:50 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Jakub Kicinski <kuba@kernel.org>, Nicolas Dichtel 
 <nicolas.dichtel@6wind.com>, netdev@vger.kernel.org, fw@strlen.de,
 pablo@netfilter.org, jiri@resnulli.us, mkubecek@suse.cz,
 aleksander.lobakin@intel.com, Thomas Haller <thaller@redhat.com>
Subject: Re: [RFC] netlink: add variable-length / auto integers
Message-ID: <20231011094550.7837d43a@hermes.local>
In-Reply-To: <30be757c7a0bbe50b37e9f2e6f93c8cf4219bbc1.camel@sipsolutions.net>
References: <20231011003313.105315-1-kuba@kernel.org>
	<f75851720c356fe43771a5c452d113ca25d43f0f.camel@sipsolutions.net>
	<6ec63a78-b0cc-452e-9946-0acef346cac2@6wind.com>
	<20231011085230.2d3dc1ab@kernel.org>
	<30be757c7a0bbe50b37e9f2e6f93c8cf4219bbc1.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, 11 Oct 2023 18:01:49 +0200
Johannes Berg <johannes@sipsolutions.net> wrote:

> On Wed, 2023-10-11 at 08:52 -0700, Jakub Kicinski wrote:
> 
> > > > > Even for arches which don't have good unaligned access - I'd think
> > > > > that access aligned to 4B *is* pretty efficient, and that's all
> > > > > we need. Plus kernel deals with unaligned input. Why can't user space?    
> > > > 
> > > > Hmm. I have a vague recollection that it was related to just not doing
> > > > it - the kernel will do get_unaligned() or similar, but userspace if it
> > > > just accesses it might take a trap on some architectures?
> > > > 
> > > > But I can't find any record of this in public discussions, so ...    
> > > If I remember well, at this time, we had some (old) architectures that triggered
> > > traps (in kernel) when a 64-bit field was accessed and unaligned. Maybe a mix
> > > between 64-bit kernel / 32-bit userspace, I don't remember exactly. The goal was
> > > to align u64 fields on 8 bytes.  
> > 
> > Reading the discussions I think we can chalk the alignment up 
> > to "old way of doing things". Discussion was about stats64, 
> > if someone wants to access stats directly in the message then yes, 
> > they care a lot about alignment.
> > 
> > Today we try to steer people towards attr-per-field, rather than
> > dumping structs. Instead of doing:
> > 
> > 	struct stats *stats = nla_data(attr);
> > 	print("A: %llu", stats->a);
> > 
> > We will do:
> > 
> > 	print("A: %llu", nla_get_u64(attrs[NLA_BLA_STAT_A]));  
> 
> Well, yes, although the "struct stats" part _still_ even exists in the
> kernel, we never fixed that with the nla_put_u64_64bit() stuff, that was
> only for something that does
> 
> 	print("A: %" PRIu64, *(uint64_t *)nla_data(attrs[NLA_BLA_STAT_A]));
> 
> > Assuming nla_get_u64() is unalign-ready the problem doesn't exist.  
> 
> Depends on the library, but at least for libnl that's true since ever.
> Same for libmnl and libnl-tiny. So I guess it only ever hit hand-coded
> implementations.

Quick check of iproute2 shows places where stats are directly
mapped without accessors. One example is print_mpls_stats().

