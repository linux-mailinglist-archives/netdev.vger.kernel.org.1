Return-Path: <netdev+bounces-280267-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iHCmAQz452kVDgIAu9opvQ
	(envelope-from <netdev+bounces-280267-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:19:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 785604401E7
	for <lists+netdev@lfdr.de>; Wed, 22 Apr 2026 00:19:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 01927301E7C1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 22:19:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ADA82FF66B;
	Tue, 21 Apr 2026 22:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TWWNxnGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f67.google.com (mail-oo1-f67.google.com [209.85.161.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3914729CB24
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 22:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776809991; cv=none; b=NjeeRRlN/ZxdHxOy43XvsthVSyQRuFgzgo6s7gIeZf5bq1hnh/R6wJVNqCpT1q+jS6bmHEGmqknV2fvZq4oDGGbVjhfJ9mjNCeMHuoYqfVU/5isr1OryFE1NjXdaDuYWKj7/62+KO8KVH+hO/fa8yhjVp4bzvpQml+yCJADwSOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776809991; c=relaxed/simple;
	bh=YJjkwzjvk711gxx1h6r3RvdskTMccUXenoPmKYc+Qu4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bMNNkpvKNo68m0Mgk2XGz2H4j5Feut+NqGE5pqETKv2YQ5UDINVrZKwZxuZ4LCUzz7TERlRRXbG/TmM+qDJ3Xa2FUAaDz3Gio4IV1qKGLw0M6U/7Qlhl/EsDABRdpuEHxHpGz+WnxhAE9Kpxgxai7WLM6yLzvo7Fp5owmAWmUxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TWWNxnGr; arc=none smtp.client-ip=209.85.161.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f67.google.com with SMTP id 006d021491bc7-694891f8f75so1389436eaf.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 15:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776809989; x=1777414789; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UDfJXGgc/V222vviC4DkbGL2KVIVeRUy8xcy04JZw1Y=;
        b=TWWNxnGr8dJ8eXo/kXS1WWJDAFdmn1VixTsnYnnvdbp+2MTWoXeFIulwYWfjxcvmhi
         sv+zOBYI3QJQkuq2CXNiz0I23XAjk6thJBhEroMvPF9M3WzWxNqX3zQfC6eI5SR0tkOO
         RVzuZ6XqGZSpWpYKzlyJ7rkP9F23ZICsj+z3+Hi1/7hl/+/NU8RSSwyWMAvjIFu2L5Uo
         HQngx21NSEQo4fia/r1lqHoB4N/EgRoWhCiNOLTfbZBt6QEF5bPlWEYAj3b+E88vOnA8
         rTdzU4GKSdnw5BEISaFrs4clcBq1xLRNp8TfoKpTnfYsZUyY8LG8EWfaDpd5n7x1m59D
         uLAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776809989; x=1777414789;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UDfJXGgc/V222vviC4DkbGL2KVIVeRUy8xcy04JZw1Y=;
        b=hu1HbHaTN+44v8kMAisC956KbvQ7tlU1MD4ET0zcFFGZnvEk6y0qg+J+7NeD+WlHXf
         ywcqjqh9FDE6ExEES0eNz/8EkboakZ87FqK/1K8xaCnIDtsHgv7XhHgIRsRZYPHf+yex
         qHVEvgG1YAf3KnrNtBaYREDjmpLtN+AFg/CNoC9Zjb7I98ICkzYBdjkN9l5U3m9AuzV6
         ruQCeteUD5MC4VjOzcdbSOdzBW5Az2MSQ7BVMu/0yvNc6vd63PI/K4N6D/ocBSPaYtM0
         0OvRMvQfauRFwQ26btU7wR/P05DP1tiqwLkN11JhpnXkuyne+O1hLWXhJt/+tvjH3GpH
         xxpg==
X-Gm-Message-State: AOJu0YzCXQgcgdd6E8UgiFWEG+G27ptK8d+ZbrG1cnmQV6Bhe0TPCIgU
	Dcu0fShR3yZc3IAk+3fOIs5CrFMxVtmuwufTwsfq8W1BX68r10IH4iC3
X-Gm-Gg: AeBDievKtdWxKlszx091aZJJRAj++SLOgxeVyMKNJ47j3/eJsiic7IBUiCBhPF+obOT
	kBAxhPOnXtz4F7VKVut+yuJ0QEGGw8qXl8+hjEV20msDhWaJ26hZRqRlcz/wKAHyCNco7T2is4o
	Fqj1qaXdpPBXFC4lcIE+E5zDemuVge8iRrh7UpokZgom3PQiVJEH2Flz1oKe8CcGrZwHjIZvQ5j
	B0aZ7OPOTU074yuLbikURfgjRZcH4qowT5qSouXRklvfNUxTE4UIb4zuD68hMPtFK8hpjANpLeo
	NOEUQMcf+V1z6qhKiSS1DuH/FrMGxmR7BGT6h3LfdU33e9JX/zDrg98xtq3xU5U/y87aPtW/N+G
	vKXnVqBs2SJ5x6scj5ldMpdo+LTcLJ45wxj5P6DNbcn+NeW1xVEYetK8wb1bPkuLJVWBE/5Mx3r
	As0CAs8ScmHQ4uWJn6DZknnz424n0=
X-Received: by 2002:a05:6820:858e:10b0:694:6acf:a40a with SMTP id 006d021491bc7-6946acfae46mr7031922eaf.56.1776809989127;
        Tue, 21 Apr 2026 15:19:49 -0700 (PDT)
Received: from localhost ([2a03:2880:12ff:1::])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69493183021sm2834216eaf.13.2026.04.21.15.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 15:19:48 -0700 (PDT)
Date: Tue, 21 Apr 2026 15:19:48 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org
Subject: Re: [PATCH net v8 03/15] net: cache snapshot entries for
 ndo_set_rx_mode_async
Message-ID: <aef3wzOywP8_LhCh@devvm17672.vll0.facebook.com>
References: <20260416185712.2155425-1-sdf@fomichev.me>
 <20260416185712.2155425-4-sdf@fomichev.me>
 <1d871492-2da5-44b0-b6fe-860966dff55a@redhat.com>
 <12244c7a-07c5-4d75-98aa-3fe35c149272@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <12244c7a-07c5-4d75-98aa-3fe35c149272@redhat.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-280267-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sdfkernel@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,fomichev.me:email]
X-Rspamd-Queue-Id: 785604401E7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 04/21, Paolo Abeni wrote:
> On 4/21/26 11:52 AM, Paolo Abeni wrote:
> > On 4/16/26 8:57 PM, Stanislav Fomichev wrote:
> >> Add a per-device netdev_hw_addr_list cache (rx_mode_addr_cache) that
> >> allows __hw_addr_list_snapshot() and __hw_addr_list_reconcile() to
> >> reuse previously allocated entries instead of hitting GFP_ATOMIC on
> >> every snapshot cycle.
> >>
> >> snapshot pops entries from the cache when available, falling back to
> >> __hw_addr_create(). reconcile splices both snapshot lists back into
> >> the cache via __hw_addr_splice(). The cache is flushed in
> >> free_netdev().
> >>
> >> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>
> >> (cherry picked from commit ba3ab1832a511f660fdc6231245b14bf610c05bd)
> > 
> > Are you backporting from 7.2 via time machine??? :-P
> > 
> >> @@ -611,8 +633,8 @@ void __hw_addr_list_reconcile(struct netdev_hw_addr_list *real_list,
> >>  		}
> >>  	}
> >>  
> >> -	__hw_addr_flush(work);
> >> -	__hw_addr_flush(ref);
> >> +	__hw_addr_splice(cache, work);
> >> +	__hw_addr_splice(cache, ref);
> > 
> > I think here sashiko has a point, with the cache size being unbounded. I
> > guess syzkaller or the like will find a way to make it grow too much.
> > 
> > What about hard-limit it to some reasonable value?!?
> 
> There are a few more remarks from sashiko at the driver level, but
> AFAICS are all pre-existing issues.
> 
> I think even the above one it's better handled as a follow-up, so I'm
> applying the series as-is (I'll just drop the cherry-pick statement above).

I have a follow-up series to add retries here, but not sure it's the
right direction. I can send it once net-next opens just to opinions.

