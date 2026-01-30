Return-Path: <netdev+bounces-255117-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oHdvN/iTfGkQNwIAu9opvQ
	(envelope-from <netdev+bounces-255117-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:20:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54651B9FF4
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 12:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0C223025D09
	for <lists+netdev@lfdr.de>; Fri, 30 Jan 2026 11:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 249C6378D85;
	Fri, 30 Jan 2026 11:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bijCiHCD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84052378D77
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 11:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769771630; cv=none; b=jhbQA78ox/C+lfRncW1AKqEzEy0yi+gInWzJasKeWHJCZgXJHLz/h1RXZrTa7ntt6wzxihIzQVKf9eU8hh4GbPyOW8rweb90QZvYqC821KzFCW7Fkg4n1/PMPcGIWPbFS+BavestcPCx97Pu4jixgHe13wMql3lce6rbXMXgfHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769771630; c=relaxed/simple;
	bh=TCis+rQCC6z7XYAkYemlUIoHru5jgaTIrUqt6t+FWY4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oK47a/qjAJIsgzoGPIvpjvHt15r+nDHeVJaq85wbvg+Y1cww65uQ07gLyuBl7V2SjvZoGQvlUbgHGg2M/z+rBch6RLIEYrVOJq6yBIJNiCtmVu8dQBPdjBXNX93UgwGvQqyru7/YeJb0h9GfWHt5UcEZ3AYAwnWHVOQYUGy+9tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bijCiHCD; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-4327555464cso1546754f8f.1
        for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 03:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769771627; x=1770376427; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w+yjYwZ7RDCJlqlGtt5ChUntZSWDd8aPFqDlY3AniEk=;
        b=bijCiHCDiDsrfYSkVIjAqtFdXK0pP3y5v8itW4VnLqZB29KGa2STuu35LNttVG3FeD
         3c42LD0VN3OVZl0OwXHeg2zrB8V3YNvwyL0HXxsDzB1qcEZ+YwhJ7CMckfyeQ+x5xU72
         s2CrtAtfxPINwcj5teHNx/VBE9F7lnSx4sGwHfirvj88paMTt7kmu14fQ0auD7MuVxvX
         8DnEgXkyvEy22rxA+B3tXASXH4HcS+Nki6mWmlmUFHjtWbY57ac9OYUKL90KW9PJMiLN
         AunrO3J9F9L/zmEkvl+41y/JuzskrpStPTww79WkogBJh0QU+QarB0Sj1xg+1k9NaeNx
         ZBRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769771627; x=1770376427;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w+yjYwZ7RDCJlqlGtt5ChUntZSWDd8aPFqDlY3AniEk=;
        b=gbku6D9Viossc/ntjvECg2PIxfY9+O79n6TLJ+hM0L97fdHrhH9ZIPEFfXo//pKZI/
         RSzzXBMPv6tOs6qqDCP10w18Kd+r/3fq5/QhpIMYDtO32dfip8s/cUj5gSgsp+9KCLFF
         TrKohb4dGAnzfx8mDVgM8nKeyNHcer5y9sjvTFPMLIGDyHiPRk8PSgKtnC/SAUjy2C/o
         vwHo/Gev/2Z36f2/ovVwZLBEMtlVOPjRGZobeAkkDqUm50/oSnGQ4Xd16dvrcN+WpgK4
         uKVtYeRDPwH3hqsosGA8by01VTIVglNEqChIBKTjQ60lXgOvRMcqP9t0tfaWTO6F/ii2
         gggw==
X-Forwarded-Encrypted: i=1; AJvYcCVgwisN8ShQDDBYnCFONKUrJxqsb/XLb/RA0NTnL3mWTrNh+AeCMHCgxTp4mHlFUMkheFyiI70=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrpmKx18XsDj6isk/AFX5XozFoepAX0oq2pNqTCdZRQuBz/5mI
	EMaZjFDgTDv4Vxb1nyxm238i7GKCrZ3VXL9X6NXX/cNpRGgjDNWt1kJh
X-Gm-Gg: AZuq6aKbd+VAo7P8BBCIkfhFfswMh3izv5J156GP7FtNzbwZegX9IOnL/u9Bfn3awkP
	OkfS/5vJZ1LHHb9lX75fhcj5NN4OBw2NSft/nR9jrPWmv1cVB8SLtmkbg9i44nxeMscSohxt0kz
	QvL0NvMfgTWK7pGnaSzBqadxKg/jz6f6KA/b7KUvLfr00SyqZqKw5xtpxSHAiEJ0Z6vi9eqMmwn
	GJIB0E1blX5aPaSRT5gUKGGclcikaLcZvh68u+BAo6U3BNh1QP6PUpYlP6Uj+5cZGSc/0hXFObf
	cF42nUX8OXkZGZBCV/v0Q7VFXWCzxMyUv7m/N0xQs+oyDgEhJR31Y5t3o+CaqM0JAVm+Coxvds1
	oFagRA3ihXceRW9RrsxRT8383wkywokgKIuFE+eD4XmNwroOBsBy7FYkon7+SYJb/jEJ3D48pk4
	papVWaBtRBNgEMN6jUuW1afdZnsAJBZXtTSzaPEDRXlhd+ksovK0+R1wCQ18rgYl2VZZzA60TgG
	HX3s9fyblhtnzXQwwq+BQq4gSGPjwdQFE0jZHGgm4Io5N0=
X-Received: by 2002:a05:6000:2905:b0:431:16d:63d1 with SMTP id ffacd0b85a97d-435f3aaf59dmr4092783f8f.44.1769771626677;
        Fri, 30 Jan 2026 03:13:46 -0800 (PST)
Received: from ?IPV6:2620:10d:c096:325:77fd:1068:74c8:af87? ([2620:10d:c092:600::1:99eb])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e131cfc9sm21437487f8f.21.2026.01.30.03.13.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jan 2026 03:13:46 -0800 (PST)
Message-ID: <c37ae03d-2b0e-4179-ac22-7d0c01ff601d@gmail.com>
Date: Fri, 30 Jan 2026 11:13:35 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/5] net: devmem: improve cpu cost of RX
 token management
To: Bobby Eshleman <bobbyeshleman@gmail.com>,
 Stanislav Fomichev <stfomichev@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Mina Almasry <almasrymina@google.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Neal Cardwell <ncardwell@google.com>,
 David Ahern <dsahern@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Shuah Khan <shuah@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 matttbe@kernel.org, skhawaja@google.com,
 Bobby Eshleman <bobbyeshleman@meta.com>
References: <20260115-scratch-bobbyeshleman-devmem-tcp-token-upstream-v10-0-686d0af71978@meta.com>
 <20260120170749.101e8bcc@kernel.org>
 <CAHS8izMZxM6rcF+7Lfw=KFv4dmbHGSUrQBPmxO+sYj=V3TRuwQ@mail.gmail.com>
 <aXe2QhzL4DoVbesQ@devvm11784.nha0.facebook.com>
 <20260126173124.1f0bb98e@kernel.org> <aXhUfC7ZyYge1jti@mini-arch>
 <CAKB00G3p9_VUTEW_KQvS1JAd+Ju_pjrU5r-v_p+K8Y=vH__mTQ@mail.gmail.com>
Content-Language: en-US
From: Pavel Begunkov <asml.silence@gmail.com>
In-Reply-To: <CAKB00G3p9_VUTEW_KQvS1JAd+Ju_pjrU5r-v_p+K8Y=vH__mTQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-255117-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,google.com,davemloft.net,redhat.com,arndb.de,lwn.net,lunn.ch,gmail.com,fomichev.me,vger.kernel.org,meta.com];
	RCPT_COUNT_TWELVE(0.00)[26];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[asmlsilence@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 54651B9FF4
X-Rspamd-Action: no action

On 1/27/26 06:48, Bobby Eshleman wrote:
> On Mon, Jan 26, 2026 at 10:00 PM Stanislav Fomichev
> <stfomichev@gmail.com> wrote:
>>
>> On 01/26, Jakub Kicinski wrote:
>>> On Mon, 26 Jan 2026 10:45:22 -0800 Bobby Eshleman wrote:
>>>> I'm onboard with improving what we have since it helps all of us
>>>> currently using this API, though I'm not opposed to discussing a
>>>> redesign in another thread/RFC. I do see the attraction to locating the
>>>> core logic in one place and possibly reducing some complexity around
>>>> socket/binding relationships.
>>>>
>>>> FWIW regarding nl, I do see it supports rtnl lock-free operations via
>>>> '62256f98f244 rtnetlink: add RTNL_FLAG_DOIT_UNLOCKED' and routing was
>>>> recently made lockless with that. I don't see / know of any fast path
>>>> precedent. I'm aware there are some things I'm not sure about being
>>>> relevant performance-wise, like hitting skb alloc an additional time
>>>> every release batch. I'd want to do some minimal latency comparisons
>>>> between that path and sockopt before diving head-first.
>>>
>>> FTR I'm not really pushing Netlink specifically, it may work it
>>> may not. Perhaps some other ioctl-y thing exists. Just in general
>>> setsockopt() on a specific socket feels increasingly awkward for
>>> buffer flow. Maybe y'all disagree.
>>>
>>> I thought I'd clarify since I may be seen as "Mr Netlink Everywhere" :)
>>
>>  From my side, if we do a completely new uapi, my preference would be on
>> an af_xdp like mapped rings (presumably on a netlink socket?) to completely
>> avoid the user-kernel copies.
> 
> I second liking that approach. No put_cmsg() and or token alloc overhead (both
> jump up in my profiling).

Hmm, makes me wonder why not use zcrx instead of reinventing it? It
doesn't bind net_iov to sockets just as you do in this series. And it
also returns buffers back via a shared ring. Otherwise you'll be facing
same issues, like rings running out of space, and so you will need to
have a fallback path. And user space will need to synchronise the ring
if it's shared with other threads, and there will be a question of how
to scale it next, possibly by creating multiple rings as I'll likely to
do soon for zcrx.

-- 
Pavel Begunkov


