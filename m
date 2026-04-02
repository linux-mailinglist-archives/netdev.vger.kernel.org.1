Return-Path: <netdev+bounces-274350-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2CAkBivizWlVigYAu9opvQ
	(envelope-from <netdev+bounces-274350-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:27:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B139383211
	for <lists+netdev@lfdr.de>; Thu, 02 Apr 2026 05:27:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47A4A308F3DA
	for <lists+netdev@lfdr.de>; Thu,  2 Apr 2026 03:22:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2241E359A7B;
	Thu,  2 Apr 2026 03:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rUMzJ7Nq"
X-Original-To: netdev@vger.kernel.org
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD830CDAE
	for <netdev@vger.kernel.org>; Thu,  2 Apr 2026 03:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775100151; cv=none; b=T7rlt2vrPN1MikSz6xIWSQwmo1FGyOyQPgzzfs4J41CCNj7F3uxxReOG1ZUjQvJVHPUFl5xMTc9g/weRCmueZNQQVsIXez/+6Szqhe5UPTWe+r4B1UYjPTifhC2dOaa6wiGcZwTWIst7BbClUYcAQAd3yfgqv+wyGsA+7t6cTUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775100151; c=relaxed/simple;
	bh=NhDizPiEmSIbGAGuGI1X+OtUkY9TDnMHcZJDxJXZdcQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AhV+qCeyYdl93/snpflIT/8Qs8T2Rs8VK4pImx/dmTaI6da6fVt7LkJfonNcKDrpxmBa9b3DyeiT49z0IjdHujS8/HbjIJCti2T4S3f1mymR/roBAEhuuUfq2aSu86/Mi5Y94uf9NXYJHYBTXaT/CEurxL8p4jYAig7Ef6WI9o0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rUMzJ7Nq; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6c1d6987-ca73-40de-adab-bc6f9fce67f6@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775100147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bYveJD6LxHD6hKNngQokJ/HPFuXMnyoAnNnr+LysDbo=;
	b=rUMzJ7NqjEpjA/BUsJVc/rGqQOSQJXaRdiEhk9w3uf2igGz8YutUWH1KnQDJo+a9ShTsEd
	apmk9RSVh0FSmAjBi85mmZ5jOaksUw7rYY0ed11UtVyZZaqi01gBqx7aaZ4T1uyAlX0raw
	wkLJ5lgBSJ9ddi3ZedYWu23DAvT/29g=
Date: Thu, 2 Apr 2026 11:22:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] selftests/net: Add two xdp tests to xdp.py
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Leon Hwang <leon.huangfu@shopee.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Shuah Khan <shuah@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org
References: <20260401052746.314667-1-leon.huangfu@shopee.com>
 <20260401132048.3a15601e@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leon Hwang <leon.hwang@linux.dev>
In-Reply-To: <20260401132048.3a15601e@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274350-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,iogearbox.net,gmail.com,fomichev.me];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon.hwang@linux.dev,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:url,sashiko.dev:url,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7B139383211
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 2/4/26 04:20, Jakub Kicinski wrote:
> On Wed,  1 Apr 2026 13:27:46 +0800 Leon Hwang wrote:
[...]
>> +def _set_jumbo_mtu(cfg, mtu):
>> +    ip(f"link set dev {cfg.ifname} mtu {mtu}")
>> +    defer(ip, f"link set dev {cfg.ifname} mtu 1500")
> 
> cfg records the original MTU, you can copy this line from here:
> https://elixir.bootlin.com/linux/v7.0-rc6/source/tools/testing/selftests/drivers/net/gro.py#L88
> 

Sure, will use cfg.dev['mtu'] instead of hard code 1500.

>> +def _exec_cmd(cfg, obj, sec, ip_opts=""):
>> +    return cmd(f"ip {ip_opts} link set dev {cfg.ifname} xdpdrv obj {obj} sec {sec}", shell=True, fail=False)
> 
> We shouldn't need the shell=True where?
> Also it's probably cleaner to pass fail as optional argument here
> so that you can let this throw an exception in the cases we expect
> to succeed instead of having to check in the caller explicitly
> 

Right, shell=True is unnecessary here. Will drop it.

Will pass fail as optional arg to let it fail if fail=True.

>> +def test_xdp_native_attach_sb_to_mb(cfg):
>> +    obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
>> +    mtu = 9000
>> +
>> +    _set_jumbo_mtu(cfg, mtu)
>> +
>> +    probe = _exec_cmd(cfg, obj, "xdp.frags")
>> +    if probe.ret != 0:
>> +        output = probe.stderr.strip() or probe.stdout.strip()
>> +        raise KsftSkipEx(output or "device does not support multi-buffer XDP")
> 
> May be simpler and cleaner to print the whole command separately:
> 	
> 	if probe.ret != 0:
> 		ksft_pr(probe)
> 		raise KsftSkipEx("device does not support multi-buffer XDP")
> 

Ack.

>> +    ip(f"link set dev {cfg.ifname} xdpdrv off")
>> +
>> +    probe = _exec_cmd(cfg, obj, "xdp")
>> +    if probe.ret == 0:
>> +        ip(f"link set dev {cfg.ifname} xdpdrv off")
>> +        raise KsftFailEx(f"driver unexpectedly allows non-multi-buffer XDP at MTU {mtu}")
> 
> Hm, TBH I don't think this sb_to_mb case is adding any coverage.
> Let's just add the test case below?
> 

Ok. Will drop this case.

> 
>> +def test_xdp_native_update_mb_to_sb(cfg):
>> +    obj = cfg.net_lib_dir / "xdp_dummy.bpf.o"
>> +
>> +    _set_jumbo_mtu(cfg, 9000)
>> +
>> +    attach = _exec_cmd(cfg, obj, "xdp.frags")
>> +    if attach.ret != 0:
>> +        output = attach.stderr.strip() or attach.stdout.strip()
>> +        raise KsftSkipEx(output or "device does not support multi-buffer XDP")
>> +
>> +    defer(ip, f"link set dev {cfg.ifname} xdpdrv off")
>> +
>> +    update1 = _exec_cmd(cfg, obj, "xdp.frags", "-force")
>> +    if update1.ret != 0:
>> +        raise KsftFailEx("device fails to update multi-buffer XDP")
>> +
>> +    update2 = _exec_cmd(cfg, obj, "xdp", "-force")
>> +    if update2.ret == 0:
>> +        raise KsftFailEx("device unexpectedly updates non-multi-buffer XDP")

From sashiko's review [1]:

On architectures with larger page sizes, such as 16KB or 64KB on ARM64 or
PowerPC, a 9000-byte packet can fit entirely within a single buffer. In
these environments, the driver might legally accept a non-frag XDP program,
which would lead to a false positive failure here.

WDYT?

[1]
https://sashiko.dev/#/patchset/20260401052746.314667-1-leon.huangfu%40shopee.com

Thanks,
Leon


