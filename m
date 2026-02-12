Return-Path: <netdev+bounces-258413-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aE7TG3p+jWl93QAAu9opvQ
	(envelope-from <netdev+bounces-258413-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 08:17:14 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CCD12AE56
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 08:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2EB4A301D4FB
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 07:17:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB6E4291C07;
	Thu, 12 Feb 2026 07:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vjDlEWex"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CA37221D9E
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 07:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770880630; cv=pass; b=E9atAWfD9CFBpqfh2tcAEhzbtutap0t+ON6NZXGdTG9cNoMVhsOI6hEmCnun35YKlg/A4kzbZ6aoapwbzdXZdLKBNjbWn/lOieu5uqLVKrbNcImJFIsXX1YxRqvNd4M/w3/rVg/RRGIEOclGKl1wpWRQrctXPXrWUUzBtL4jR9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770880630; c=relaxed/simple;
	bh=5dKyNqtSv+8+nW0M8u8B/TNdAd78HmYWkm0JDenM2Rk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YxxKT1uertUKBIJmJQ3Jg9+PhKpqi4F8zYqBGiyG6M9Hk+N/cdavi3n/jjqnjYAsTAsiVQeyHWX6S+nsxWv/OZhmbip3Mp1V6W/kHJxMtI0pNkhzZEu6taJLPm/43PvXTYFK3qegLU/LgaIDwrB2A91weXiEXpmGcALa9Pw1+kY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vjDlEWex; arc=pass smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-5014600ad12so55120701cf.2
        for <netdev@vger.kernel.org>; Wed, 11 Feb 2026 23:17:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770880628; cv=none;
        d=google.com; s=arc-20240605;
        b=eQAmhRBvH3Lgwg8oTPMDUai/+RO+V0++nf1m1jW8y47/XuDFhqUHL9gnm08rLatMD6
         teMGHG60RPGfQp3gu251AJfqvs22g6pLzWr4MphyzNf+yWSU1aoEXKTYbx878iSCl6OA
         Kfvu2xm/AEmhX8L24cMhsNf836WCpT1KpNPwN75GoXe7QoeDNvqtbqQzeAvsWdRPO0GZ
         bnBwTV+Er9zmczDzX0geOMyZjmV4Jc5G9b4Rm+fUO6cNqGgbJ+D9eDTCqsKwKJ4mHJT1
         joeOL1APVGY5plrMI9QskKpHnqqw/vjS4HRbcaAPbvS0tLZcpy2hhiemR2TvSIzoEsjh
         Jvbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=yltUO2cOxxVoQIpCKjjDxarQqdo4BfaqnH+MtRjb2qE=;
        fh=3x2WntZbHAFsmM9EvBDTj5tLXoFg79CuAD4CUwDK7JI=;
        b=C7qBXTYqFRtd/eEyKuK1An0p1IvJgiJkArvl1BmlzfWEh7RcHGKMW9cnTpDOyYFz0t
         FBm66w1cEYNGxTaLZl3q6g0w0k9w8lQpa9GMAbyptriUWsUVyqD16xD4WUyyj1UkwCZy
         VX3MqWG9VpnSWX6cSRzjqgDEY1NolMyw6xYOglEehwNhpsMMGalaZ/igij+C+ilXeay7
         nF1UY/DRSi9zvlpKsc2KDoWYu3P+9xn1Uv340jhmp548B9PlV13tIdKiNk//7oYWm7tE
         m8+1yAkBmJhRAfvUOnPbxdMLcjhAEIXeebfIgeFzX8DXHRLcjiGlcR1krJB5cOwSmDuV
         GhMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770880628; x=1771485428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yltUO2cOxxVoQIpCKjjDxarQqdo4BfaqnH+MtRjb2qE=;
        b=vjDlEWexGYxzW6pqyk3Cbue1qnWzOnmS9EzJyLey05dAtBlV1YplIiDLgk6nDDOWrb
         2y1IRTyYkozd/eSLQdYfMAtc3A5SVHIgPFWD5JJxwnDriCa6jGvp6xJ1LZTwJp5UlvNb
         0Mg2EhoMbGogXoKHpYUwZIel+dPclQQCx7fOJ9BBhmjsRIR3k/NSDGa+Op2IHhIx7wW+
         ms9pgGjR8g3kjjCMDW3KJ41cvkhRPLfsmHqf/GZFUipIhilzgMoxg/D11KNjfjvIi1Gm
         vn6jPb4ZxZcga7xNtxS6Z6A9JUHlorQrgKnPQ0FwvLz7TqD6t9G7wITeP9WTRYKqew25
         2YCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770880628; x=1771485428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yltUO2cOxxVoQIpCKjjDxarQqdo4BfaqnH+MtRjb2qE=;
        b=jWJ4M+Im+6/43tZG3DeVzueN3w+hH7CK5LQ7gwbPAp2tMCe5xK/D5SNg1DG4bOb04p
         2n3+DO4RIoBDrSZYWxtPhmvtOMuxEZeB/2uoItpKXfDm31gkKGhIqFJb/1vIeARE9HRB
         v0ed4Lb5SHpS4yCMTnmIbPhFfpjA3YBnZIE2I0rvtLH6C7I76X/w0DycB1IZ1kyl9Kni
         YqH7XQyvk08xS2TmoGWq45URjQbex+eilH9cxZEF7crr2FjcJAB/Vrg5Fr1pJv2u/+2x
         Hd5O7dI5L7Nrp8HpL7rzhWVkBgQwyepq0gyJU4qXrjZtyvGK4ioa5DvzPxM/2Qb50BtU
         dPvg==
X-Forwarded-Encrypted: i=1; AJvYcCVr5bw2++4wuuq/t/3Xcz6G2aSJJYyZuWXYpu+F50XjEZ5NJhUJ133NHifnvqBbqkUA6/gU+h8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyED31WfZPcwKY3GMCZ/nMHhT+mmOshRvpXO6hadZXWvdZo+fp7
	xoQRIb8vTj/laLMClIbLm0oxwSZKiWoN+u9xdP/gysfiNZ1fyLE2HC7YcXu24wof5B3oJxhRa2m
	8vsiUSxy2jJTW1H32bxNKNMC7mAYg1iZhHl3oIIY2
X-Gm-Gg: AZuq6aK6HHhPwATYhvBpU+envUndHERJHUT773VP7G/SKSPYHUnHYTS0RUSTZOH2OKA
	leeEQoYgjgnltgy9W/I180xksxuxyXl7bZ+jMwAZMh1DD4MUvLmtCFq1Q5y7k90wBQ9Ra//rlqR
	v7jMRyT+QJ7L2KRsrDLMmx0OYbD2M+S9WKxBonjl/9EOE40uaXuI2e6G+WMTfEBUFWzTb0hybu5
	CzKEmzRU4B1k9pPMVVVex77ZG2rmoqc2y8n8szc4G07oFkg4QQrfVgsUK6pvFq4jOTm36pRet5Q
	DB36ExGh
X-Received: by 2002:a05:622a:148f:b0:501:46b7:22b2 with SMTP id
 d75a77b69052e-50691f68782mr25609751cf.82.1770880627918; Wed, 11 Feb 2026
 23:17:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260211103243epcms1p2dd304fd11b28df04f4e680e8c90a7fc5@epcms1p2>
 <207b2879-e022-4b50-837b-d536f8fcabcd@suse.de> <CGME20260211030048epcms1p54c6ed78458f57def8e3163032498ca00@epcms1p7>
 <CANn89i+mNojd9mUL_dt_=D+7nZ9xcV96CYJG_LYFmBZDOYUMFQ@mail.gmail.com> <20260212002207epcms1p7a1c19ed12038cf74f8632e5a305bd7ec@epcms1p7>
In-Reply-To: <20260212002207epcms1p7a1c19ed12038cf74f8632e5a305bd7ec@epcms1p7>
From: Eric Dumazet <edumazet@google.com>
Date: Thu, 12 Feb 2026 08:16:56 +0100
X-Gm-Features: AZwV_QgqTD6QqUZeQpStnEGD1Af1tXL6z0Hf9erBzMxQ2x7izWr-zSLdtDTfSGQ
Message-ID: <CANn89iJ6MJxh7BFjVdBMBLYeopgJ52Sbg7jEfQbQeQ-n0MUOTw@mail.gmail.com>
Subject: Re: (2) [net-next,v3] ipv6: shorten reassembly timeout under fragment
 memory pressure
To: soukjin.bae@samsung.com
Cc: Fernando Fernandez Mancera <fmancera@suse.de>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"netfilter-devel@vger.kernel.org" <netfilter-devel@vger.kernel.org>, 
	"davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com" <pabeni@redhat.com>, 
	"dsahern@kernel.org" <dsahern@kernel.org>, "kuba@kernel.org" <kuba@kernel.org>, 
	"horms@kernel.org" <horms@kernel.org>, "phil@nwl.cc" <phil@nwl.cc>, 
	"coreteam@netfilter.org" <coreteam@netfilter.org>, "fw@strlen.de" <fw@strlen.de>, 
	"pablo@netfilter.org" <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258413-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ietf.org:url,samsung.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email]
X-Rspamd-Queue-Id: 14CCD12AE56
X-Rspamd-Action: no action

On Thu, Feb 12, 2026 at 1:22=E2=80=AFAM =EB=B0=B0=EC=84=9D=EC=A7=84 <soukji=
n.bae@samsung.com> wrote:
>
> >On Wed, Feb 11, 2026 at 4:11=E2=80=AFPM Fernando Fernandez Mancera
> ><fmancera@suse.de> wrote:
> >>
> >> On 2/11/26 11:32 AM, =EB=B0=B0=EC=84=9D=EC=A7=84 wrote:
> >> >   Changes in v3:
> >> > - Fix build bot error and warnings
> >> > - baseline update
> >> >
> >> >
> >> >
> >> >  From c7940e3dd728fdc58c8199bc031bf3f8f1e8a20f Mon Sep 17 00:00:00 2=
001
> >> > From: Soukjin Bae <soukjin.bae@samsung.com>
> >> > Date: Wed, 11 Feb 2026 11:20:23 +0900
> >> > Subject: [PATCH] ipv6: shorten reassembly timeout under fragment mem=
ory
> >> >   pressure
> >> >
> >> > Under heavy IPv6 fragmentation, incomplete fragment queues may persi=
st
> >> > for the full reassembly timeout even when fragment memory is under
> >> > pressure.
> >> >
> >> > This can lead to prolonged retention of fragment queues that are unl=
ikely
> >> > to complete, causing newly arriving fragmented packets to be dropped=
 due
> >> > to memory exhaustion.
> >> >
> >> > Introduce an optional mechanism to shorten the IPv6 reassembly timeo=
ut
> >> > when fragment memory usage exceeds the low threshold. Different time=
out
> >> > values are applied depending on the upper-layer protocol to balance
> >> > eviction speed and completion probability.
> >> >
> >> > Signed-off-by: Soukjin Bae <soukjin.bae@samsung.com>
> >>
> >> Hello,
> >>
> >> isn't this what net.ipv6.ip6frag_time does? In addition, the situation
> >> you described could be overcome by increasing the memory thresholds at
> >> net.ipv6.ip6frag_low_thresh and net.ipv6.ip6frag_high_thresh.
> >>
> >> Please, let me know if I am missing something.
> >
> >Also :
> >
> >1) net-next is closed.
> >Please read Documentation/process/maintainer-netdev.rst
> >
> >2) We do not send 3 versions of a patch in the same day.
> >Please read Documentation/process/maintainer-netdev.rst
> >
> >3) What about IPv4 ?
> >
> >4) Only the first fragment contains the 'protocol of the whole
> >datagram', and fragments can be received in any order.
> >
> >5) We do not add a MAINTAINER entry for such a patch, sorry.
>
>
> Hello,
>
>
> Regarding about net.ipv6.ip6frag_time and low/high_thresh:
>
> The issue we are addressing currently occurs due to a large volume of mDN=
S
> traffic from WiFi APs. As a temporary measure, we increased the high_thre=
sh
> value to accommodate the traffic.
>
> However, UDP traffic such as mDNS cannot recover once a fragment stream i=
s
> lost, leading to wasted memory. Therefore, this patch is intended to make
> more efficient use of the currently allocated fragment memory by shorteni=
ng
> the reassembly timeout under memory pressure.
>
> Also, we tend to avoid changing the global value of ip6frag_time to
> preserve existing behavior. This is why I added new config too.
>
>
> Regarding others:
>
> 1, 2) net-next is closed and multiple patch
> I apologize for the oversight regarding the net-next status and the frequ=
ent
> submissions. I was tried to fix CI build failures. I will follow the
> documented guidance going forward.
>
> 3) What about IPv4?
> The issue was primarily observed in IPv6-dominant IMS environments, which
> was the initial focus. However, I agree that the same memory management l=
ogic
> is beneficial for IPv4. I will include IPv4 support in the next version t=
o
> provide a unified solution.
>
> 4) Only the first fragment contains the 'protocol of the whole datagram'.
> You are correct. I will update the logic to store the L4 protocol informa=
tion
> once the first fragment is received, and only then apply the adjusted tim=
eout.
> If the first fragment is lost, the adjusted timer will not be triggered, =
but
> this is acceptable as a partial case.

I do not think we will accept a patch trying to 'fix' reassembly. This
is fundamentally not fixable.

I can tell you that in crowded wifi environments, I have seen delays
of 30 seconds (and more) to complete
a datagram of only 2 fragments. Your default settings are not viable.

If you depend on receiving fragments, change the existing tunables.
Instead of :

/proc/sys/net/ipv6/ip6frag_high_thresh:4194304  (4 MB)
/proc/sys/net/ipv6/ip6frag_low_thresh:3145728 (3 MB)
/proc/sys/net/ipv6/ip6frag_time:60

Use:

/proc/sys/net/ipv6/ip6frag_high_thresh:104857600  (100 MB)
/proc/sys/net/ipv6/ip6frag_low_thresh:78643200 (75 MB)
/proc/sys/net/ipv6/ip6frag_time:60

Of course, avoiding fragments is the right solution.

https://datatracker.ietf.org/doc/html/rfc6762#section-17

TCP should avoid using frags by default.

