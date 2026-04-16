Return-Path: <netdev+bounces-278955-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0F8JA9mU4Gn/jwAAu9opvQ
	(envelope-from <netdev+bounces-278955-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:50:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC0C40B315
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 09:50:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E42673037923
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 07:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8220F22FF22;
	Thu, 16 Apr 2026 07:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="xV8yrVIJ"
X-Original-To: netdev@vger.kernel.org
Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17867340A46
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 07:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776325823; cv=none; b=o+vqJQ7sTcD8mDNBYJYqa4IzQH855bqlR6N47ZYJKE0fU446ONJXhN6I8pH3Pm6SE++Xd746M2JNgIYuUm109byTmf30SbD05oi+84vVVNkBmvLkvjUvEp7ZHzLt+tubRMxPxuZNL12lC0d9locUEnfhtU1U3c5Ro9PvubxbzM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776325823; c=relaxed/simple;
	bh=KxuNWQ2a3a9rgfOr9Cf2/P6mQx3czM9m0lYSOzgROec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pqgwwiPAcJup0BHLb5XyhlPbo/8WTaO9rvoafOB35pROkQc7luEuZBjTo8mcLwHqRTqPEKHVZLFo6V/IE0jDCQ9VUTAC7ugT6cdz78xjhKGQJdMXbmd1/08fiKFSkp3OYt0TnqX+s0yX3/5m6ykQp2RmUY3K0GaGXUQH+RTz+JI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=xV8yrVIJ; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <0e579779-f38b-4db3-936b-5d7add12d15e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776325810;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=11cyg0mvKQwNL/9Dn8fT/UbJkY9yFbzdNgRtigL8718=;
	b=xV8yrVIJm3m5Eoss2vL0r2ithRXeQ2KtK434zYXzyj821InVMuKPvhtIAiiq97KeX74jy2
	aQ5sO2zvfEmCMT38NiYa7kearyrZSbsBqK8OLrW8edfRIbMwqBUVWpSEyNFXOVUaKCgAw1
	lwC+YEu1sL7qITn6zMdDMvpvsr7NNa8=
Date: Thu, 16 Apr 2026 15:49:58 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [syzbot ci] Re: net: tunnel: fix stale transport header after
 GRE/TEB decap
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com, pshelar@nicira.com,
 syzbot@syzkaller.appspotmail.com, tom@herbertland.com
Cc: syzkaller-bugs@googlegroups.com
References: <69e08a0a.a70a0220.259bc5.0019.GAE@google.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <69e08a0a.a70a0220.259bc5.0019.GAE@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-278955-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN_FAIL(0.00)[114.105.105.172.asn.rspamd.com:server fail];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jiayuan.chen@linux.dev,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[googlesource.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzbot.org:url,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Queue-Id: CEC0C40B315
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On 4/16/26 3:04 PM, syzbot ci wrote:
> syzbot ci has tested the following series
>
> [v1] net: tunnel: fix stale transport header after GRE/TEB decap
> https://lore.kernel.org/all/20260416034610.8873-1-jiayuan.chen@linux.dev
> * [PATCH net v1 1/2] net: tunnel: fix stale transport header after GRE/TEB decap
> * [PATCH net-next v1 2/2] net: add DEBUG_NET_WARN_ON_ONCE for negative transport offset
>
> and found the following issue:
> WARNING in udpv6_err
>
> Full report is available here:
> https://ci.syzbot.org/series/3886f2f1-a6d5-4c5c-8dc8-bc1cec577567
>
> ***
>
> WARNING in udpv6_err
>
> tree:      net
> URL:       https://kernel.googlesource.com/pub/scm/linux/kernel/git/netdev/net.git
> base:      1f5ffc672165ff851063a5fd044b727ab2517ae3
> arch:      amd64
> compiler:  Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
> config:    https://ci.syzbot.org/builds/06cf41a2-60fe-4f9b-8f68-57eb6d1e48cc/config
>
> ------------[ cut here ]------------
> off < 0
> WARNING: ./include/linux/skbuff.h:3239 at udpv6_err+0x1521/0x16d0, CPU#0: kworker/u9:2/51
> Modules linked in:


icmpv6_rcv
   pskb_pull ==> skb_transport_offset() = -8
   icmpv6_notify
     udpv6_err
       __udp6_lib_err_encap(skb) ==> WARNING



