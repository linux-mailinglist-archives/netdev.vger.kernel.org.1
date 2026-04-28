Return-Path: <netdev+bounces-281559-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id E7rqJUr872kmNAEAu9opvQ
	(envelope-from <netdev+bounces-281559-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:16:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 286B247C124
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 02:16:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69E4D30087C5
	for <lists+netdev@lfdr.de>; Tue, 28 Apr 2026 00:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 680961A683B;
	Tue, 28 Apr 2026 00:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fLXTlZ7h"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1642818A92F
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 00:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777335366; cv=pass; b=FEmHyckpwOcVgpbV2LZPExlTCDdX40YpHHLpeKhQp0KLLLh5s4jGyCL8aABcdK8+Z/1DweWr/EqgR+nhTv3sIWyXcXO86n43kNoOV/RE+4LjOBYa1IgqShBJE+AavJLNykFm1vbbjmMdemIYHmQveSwnOLe09An1poKXeiwU33M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777335366; c=relaxed/simple;
	bh=aiH7HAWQxJgzUUYGotE/EDAlBQLH+8Yz5c7Y/t3S82I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RyLWYBxkxnkQk9+a0+fTGCodzuy4lZbwhQSb8OVRKn0VnZICKtOZgG1GVgrrqDbisGQPyGim+wHhXSMdL38KpaBdjDA7upQQAF3voC6jP4B9kY+L5Eb6iduYJym52rKVRHSF1DF3s7WjLdUIDSDBpV2WuUuCLxg3SVIvjcpRHwI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fLXTlZ7h; arc=pass smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12ddbe104ccso1023094c88.0
        for <netdev@vger.kernel.org>; Mon, 27 Apr 2026 17:16:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777335364; cv=none;
        d=google.com; s=arc-20240605;
        b=gjnDgFyJqfG3QadGk6VKt5ZIeaPz+yq2J47fSCc6WINTLIuXOLiiY5bg1NgurElpYn
         idzXHgtICTJz6FES3P+YAYe+GEMlHhZZG5Rhk190RmmVVHSLjOHyVqUFFPtFIRONwhKA
         FzA3+VHbfFxmmbL45g9G7GaXP+LIGISWsceBhgAneW35YQnDGyGWwR+KX1GrzoN0qH2W
         dLc2KCEG+3eAELWtQH0gxTFpZ9MIW01Y5CL/+z5tPMzKXRhkK80rm7D54e1OkJNYLpKx
         IdlEd04JzSOWhNkWssfZ5O2iZJNrvajADBwuEm10fR8cQ4j9n7sR++fD685jfQKbm4Sp
         V4bQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=asfZ6jKZAb3mst3Ds4ZKJs3W9TZGfQBVc5QgXQotN+U=;
        fh=iQAjbQBOpw2jiIwoKLftcu2T+zyMHLS1MlHgZWwV/Qk=;
        b=B7AuIv6mj6k3qI1ZiOl4kVW2zEHu7jIwa7G7IcE9RysQBeYquThCZP7LScfDKgvDtO
         qY31VW+X4rD1vmZTQ4ygRer5YoNLOjhDXdxJcBz+Kht/+PGGvK3uoH7hNC3z+7s5tajK
         45FqvSRcBDTwdZRyLwD2SJ1/0uaNidyYKESlmfXbL2F6L1zGy0KZ9GeGBZqEo+eJ9Eg7
         0M6d90lj3UjBWpdoEEIGZ0PPaEeX7JGP5BykznEaC1uS3D+m2yXdu3FGe+pEu673naLR
         4BehbzAeosgEENZcf4ajVyYa8S1H6+NE6A19BxJR1pGjx+yqJvrH5eK1A6L9SjrVQfvX
         oZhg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777335364; x=1777940164; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=asfZ6jKZAb3mst3Ds4ZKJs3W9TZGfQBVc5QgXQotN+U=;
        b=fLXTlZ7hboJA4mwpa8gYQh6bV+S1fvCNjLJJHxJPJlntGzrgxYKJIrTdTf22uGWIbe
         Z0oLiKoXaM41yNUgEKEtojI47yBo43T7e/5QY3rRwrEkGDDdd2K4VbMOQeB8VBSSo/G5
         6gl7y+9u6Q4BuqIDZJXGxG0jDJKbZvdjJOZ8hS6xvJeXFKK8s7+6E/TJyeqXCZti7qh7
         LTRBpVEfT5BMv4MI9uF3g4EZjm8C1Kfg479e9airLEKpdeJ7QMWdzgV62GdORTTMsCEx
         u0OygBACR+4ed/VUIQDFJSrrP14doFdSRMCrJNnU7WGOuCjjOkI+mCEKp2G0GGPXXjyA
         BdwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777335364; x=1777940164;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=asfZ6jKZAb3mst3Ds4ZKJs3W9TZGfQBVc5QgXQotN+U=;
        b=g5bHf+ReR0h9E+3tXc8F9mYImRFdYUcQF9DzGVIhbgrTOOADEDiNgi7ioIgqd/wvrf
         6SgGG28Zn3kdRSLtbaWZqX+ax8bx9kUyNMTW8HLM8Fb+Xqashcn7+lTxw/J2vqmJaS+W
         Xj1ZTAIEb1F8qMsM/FVWUqyyPxaib+WNtejMHhysGZ/Bw1ldvJUCphs0OP/WTiGRfGGz
         0GGj/e0CKk4SJoG/ubfSHlfcB3XH123MAfhLsW4vdkVs/PVu7yF0zAimUee61/ikhRSt
         H/Oqo8lIJHgq7r4MGBLXdwfjcDqdLd5fUt3l6b/q19+w0dELtuggPti4T5xuhE7jWP4a
         HQcg==
X-Forwarded-Encrypted: i=1; AFNElJ9Z23c5pDxQSa1OdaIMjMLB7pCzKs3jmUeQhIPWCa26HGfUv6ETIG33n7n55V7h1MI9dMPiGdQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuynAAPYnLhhxvCTTE09ZN7lWltzjOCtJqJaMLeZPPSAmDGtSM
	y25AO4UkUZ7uiBD0+F6sIqzV0VFp+4opoEZjT1GJKHRLEKZXbH79E7gZemnXQXzfvmYqrFQq8Cw
	uaYBex5JXGbFWd81usHpxkf0K1B7imlSDPLBCUqPI
X-Gm-Gg: AeBDiesbVxiiRcgGqpDj9/zctu0kjrP3bRYYhb3RaTrCz0359YBU6Lw1LgVjCYyPW/I
	KlHigAOVGOg86Wu8ICy7De4vKb0pmz2vjhtCgfiwtVmfE546kw2oZQ4AtM6M+uT77YUsOqPB2Fy
	iemzk8V72xcq/dUL1uuhIV8omFK8oGG/tlYn7JNApgWdYX+mWGeas6c3Jb719zI85Op/xYoS9SI
	TiJQ7eFUsDjtQZiaEKM1uOBDpTUE0pi+Lf5WjEIjd5Xz/U6fgNtL9wlRyFZFbGp2OKqvaHeOxH7
	sTcTOXmRp2+rNxVjjPMkXTBxBlft50Apx4E/xUQ1PjJ2q2Fv8QsZegkCDOSas9iirB913lpGZ9d
	IrkKEVbDOP03LYZZdNDhI/ePdDM6ZjJlrSGHYGqm0T694wDZIN7kX4UL59PsNx0ueNYp+RbM=
X-Received: by 2002:a05:7022:251f:b0:12d:de3f:d84b with SMTP id
 a92af1059eb24-12dde3fdd81mr62854c88.36.1777335363187; Mon, 27 Apr 2026
 17:16:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <48BADABE-4DFB-4DAD-8248-E94D8F5238D2@amazon.com>
 <CAAVpQUCfMsWBpPpywbwBLRCdHUqWqFBoDK=17dwDkG6T0dQxzw@mail.gmail.com> <A7A3F2FE-B18C-4F6D-A5E4-78164D6904F5@amazon.com>
In-Reply-To: <A7A3F2FE-B18C-4F6D-A5E4-78164D6904F5@amazon.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 27 Apr 2026 17:15:51 -0700
X-Gm-Features: AVHnY4LYUqdhewIPbMbMgIAVfYpjlbGpkUp-t1zsVCoBoC0ffHBopdgs2FrNG8A
Message-ID: <CAAVpQUCKQQF=noqxQwD=dJvO3tuhPZxssDygyuVaZxTQGKiWfQ@mail.gmail.com>
Subject: Re: [BUG] net: tcp: SO_LINGER with l_linger=0 leaks memory when
 closing sockets with pending send data
To: "Ahmed, Aaron" <aarnahmd@amazon.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "ncardwell@google.com" <ncardwell@google.com>, 
	"edumazet@google.com" <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 286B247C124
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-281559-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Mon, Apr 27, 2026 at 3:27=E2=80=AFPM Ahmed, Aaron <aarnahmd@amazon.com> =
wrote:
>
> Hi Kuniyuki!
>
> Thanks for taking a look! To clarify the issue: the problem shows up on l=
ong-running servers
> with many concurrent connections. The original reproducer exits
> right after closing the sockets, so the memory gets cleaned up at
> process exit. In production the server never exits, so the memory
> just keeps growing. Is this expected behavior?
>
> I've written an updated reproducer that models a persistent
> server. You can pass 0 or 1 as an argument to set the l_linger value.

I tested it on both net-next.git and vanilla v6.18.20,
but I didn't see much difference.

l_linger=3D0:

sockets: used 41243
TCP: inuse 41101 orphan 0 tw 0 alloc 41103 mem 2635

l_linger=3D1:

sockets: used 50143
TCP: inuse 50007 orphan 0 tw 0 alloc 50009 mem 8473


>
> This outputs the following:
>
> When l_linger=3D0:
>
>   TCP: inuse 7 orphan 0 tw 2 alloc 100009 mem 197259
>
> When l_linger=3D1:
>
>   TCP: inuse 50008 orphan 0 tw 5 alloc 50009 mem 14426
>
> With l_linger=3D0, only 7 sockets are in use but ~770 MB of TCP
> memory has no owner. With l_linger=3D1, 50,008 sockets are in use
> but only ~56 MB of memory.

Both 'inuse' and 'alloc' show the number of TCP sockets, but
'inuse' is per-netns while 'alloc' is global.  'mem' is also a global
counter.

I'm not sure if you saw the result from the wrong netns.
For example, I can see your l_linger=3D0 like result by:

# ip netns add test
# ip netns exec test cat /proc/net/sockstat
sockets: used 0
TCP: inuse 0 orphan 0 tw 0 alloc 50009 mem 13078


And if you see the counters drop close to 0 after killing
the process, the "leaked" counter should be tracked properly
somewhere else.

