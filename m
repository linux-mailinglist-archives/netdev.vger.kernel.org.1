Return-Path: <netdev+bounces-303596-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dw15LBv1RGoM4AoAu9opvQ
	(envelope-from <netdev+bounces-303596-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 13:08:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ED936EC922
	for <lists+netdev@lfdr.de>; Wed, 01 Jul 2026 13:08:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=iUykXe56;
	dkim=pass header.d=redhat.com header.s=google header.b=iVlhmPBb;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303596-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-303596-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA1DB30C3A39
	for <lists+netdev@lfdr.de>; Wed,  1 Jul 2026 11:03:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B854843DA5D;
	Wed,  1 Jul 2026 11:03:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DB543CEDD
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 11:02:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782903782; cv=none; b=R4dLw8wbNUJzrS9DpF7rEmyKTCu7a6zluOXMm4Yr/AyU7RcS6XIhyvb8EnFBOTz8YHI1PmaWDWzVu7UusY7SsMGkSffidX42q2nAo6Mfhu2lZ7cv5x+jkmMHCGko7tJrV9ON+oLE1DJqhmjEkW8VzIM9ubymtBkYvnfMqAXZ5xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782903782; c=relaxed/simple;
	bh=fRGiZtTZwPpQ+e62B55nkzc896Y8lcB1tI5y3I/MMEM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a+2c2OYXyB318gCF1/+zYsvM0v7+maDsixzNODHNdQOvfXNH5eJxfD/vZR12M7f0J00wwq+7A/MFUJht/YpIcyevIRfdbTmbk4x6BoLf+c72nVckNgbPUT2Fi7xEJn4SMW1ZPcpPoqVkUV2M+LysbAxoCuXG3Q7bT93t/+CL35k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iUykXe56; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=iVlhmPBb; arc=none smtp.client-ip=170.10.129.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782903777;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NnOYvPIZlJQwQJ6FFCiD44nqFh2+p0us6zgjeQu6Qjg=;
	b=iUykXe56zNUpFB+ZoWZxAEAo30PSeOfIpjp0AMVaLOKvIPryW/nzW3Ejt6dLsq9fm6j25u
	hW3XR16aN/2fi9qnAOqH/4RLQU4xQuWEjTPVAfOkU9tqsHKka/6SFi/fZgyctaxgNFzFTA
	3A/LGBrlYTcvPwkjbD1tVLKCwWOBmqU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-zpMgncJxPsCUAnZm8YEhvA-1; Wed, 01 Jul 2026 07:02:54 -0400
X-MC-Unique: zpMgncJxPsCUAnZm8YEhvA-1
X-Mimecast-MFC-AGG-ID: zpMgncJxPsCUAnZm8YEhvA_1782903773
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-475e540a0ffso351538f8f.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 04:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782903773; x=1783508573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NnOYvPIZlJQwQJ6FFCiD44nqFh2+p0us6zgjeQu6Qjg=;
        b=iVlhmPBb+7k3Oe8KP9Kuo4PtvFA/amoJy/Roa6Li2TUU85OxztmbFdgUYhvobwqSMf
         dfI3UoYJ4Ni/uLB6V8RfQ3kyECcKr+TC717efOlkGT7bSIEKtYvlVKneF9I4oGBv2Haf
         jOJsz9lIRQ2M2lVV8X3LIV9t76TqCHQTOFNTIt801FEYriIAKIZ3FnHE4PMupeVCb+Eq
         NdwuzoaCYfyecxr+KaNRPYdx1XL8DMZNeCZhWB5+tlvlW8rnm8t6meEKG1RZiK/q6ZL0
         CqWuVLrPPWMyDQRY4HnmUKwk9+zou93XO/SV/7uaY1xVWmFIkyiDYVNmTLJed2CTYzT0
         9F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782903773; x=1783508573;
        h=content-transfer-encoding:mime-version:message-id:date:references
         :in-reply-to:subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NnOYvPIZlJQwQJ6FFCiD44nqFh2+p0us6zgjeQu6Qjg=;
        b=ACuDI9rE1zBhSlqPeBTpC3nKppyTumPBjX4xGpD8SCfKZIGIB1SSb1QFYyKZaVPv8j
         shQjz0a5wlExaFZrazHpAaKcErqmkGQ8rEaVMp/bNsL+5ylnhOPBjjl7uBzptso0/mk2
         oMtcafXA98fySrU5ns0GjqtmxYjJZDAhyUlxJI0APPAZJZ59daM4OUu90Uj57fJ5Ees7
         V28HFSbRmfzaMXkHRu/HsCJMSdMcu4U+5tgQwYHhKa2JaHJRLGCKhgNWlQTDtbFvzFFB
         TlSJp15VY+ait0av7qTgLCf7Ep6/TuNAJDs93bQBWKSTMKc2TRbAu7nTbKH2KIxoGN6g
         x7CQ==
X-Forwarded-Encrypted: i=1; AFNElJ+Z92FmXV0m2+ssNd9VdYCYwvmq8vYFBWX/Nm+qPDnbWY1vbBSND0Ct5LuzT4ktRfhyMBHoEwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdPv97alZXH0CyL6SCkDk9fdntV5InYbKF9F02kw7Pfx3lLsls
	LNqrnTZfaqOAjyIU3QKlmIlAoFdIBH/7qwuKBePUxW7IHvZj0K3OxhyZt+mgnkusQAzEdXqSjTB
	COxo4A8XD39r0INpq0YxOnD/VdgX65HTz0obzeE8hjWeBuJeLjHHt5ME7dw==
X-Gm-Gg: AfdE7ckWHrb6WS4MosiY3HEzZq0zOYziv/ffwVV7jNTSGh55Ijy6+Jsui4nh24rhHdG
	brqaCfU7YwzzGA6WIieVNS7eVgxwsgCixEwlX1KqbyIXcUBgeJ2FlfgYUpfMLTRmaIqXL3YyCN0
	OqdwZTc1T73Ih6d6DdjM2PBRzkspWz684WBdulVlQqrwfHXSKO8VDtocWVz0z95F/btde5T9Cxp
	gt9grGzifigbhRRxbsu+hIVYFflkLgjiSuZAgzbdZXwIMO7fiHx8CTD7v6qUUNCRmjdnXQSXeV7
	r4eHxuP12yawpUvvS6DkFn0PY4RuC6Ou8nhEqMbYg8yOcvKbwDeP71VYSD1Es3QTq99uXwzEwWb
	+63hxHgCKQoPINwBnLA5LcV6bPYIRWRvUkqTfug==
X-Received: by 2002:a05:600c:5297:b0:493:a5da:e5d2 with SMTP id 5b1f17b1804b1-493c2b93614mr16386055e9.26.1782903772803;
        Wed, 01 Jul 2026 04:02:52 -0700 (PDT)
X-Received: by 2002:a05:600c:5297:b0:493:a5da:e5d2 with SMTP id 5b1f17b1804b1-493c2b93614mr16385385e9.26.1782903772259;
        Wed, 01 Jul 2026 04:02:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk (alrua-x1.borgediget.toke.dk. [2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493be4d8f5asm99969285e9.8.2026.07.01.04.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 04:02:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 9C78480A7F7; Wed, 01 Jul 2026 13:02:50 +0200 (CEST)
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: David Ahern <dsahern@kernel.org>, Avinash Duduskar
 <avinash.duduskar@gmail.com>, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org
Cc: eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev,
 song@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
 emil@etsalapatis.com, john.fastabend@gmail.com, sdf@fomichev.me,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, hawk@kernel.org,
 yatsenko@meta.com, leon.hwang@linux.dev, kpsingh@kernel.org,
 a.s.protopopov@gmail.com, ameryhung@gmail.com, rongtao@cestc.cn,
 eyal.birger@gmail.com, bpf@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Add BPF_FIB_LOOKUP_VLAN flag to
 bpf_fib_lookup() helper
In-Reply-To: <916191fc-2e10-4449-b82b-c086d90283ae@kernel.org>
References: <20260624030530.3342884-1-avinash.duduskar@gmail.com>
 <20260624030530.3342884-2-avinash.duduskar@gmail.com>
 <d820adf6-4a33-45e9-9cfa-17f11a37c9e8@kernel.org> <87se65bd04.fsf@toke.dk>
 <2ffa32dd-5c88-488a-aa23-deef13465eb9@kernel.org> <87echobb5h.fsf@toke.dk>
 <cf25f667-1095-4f84-98ff-bf4662d3faa8@kernel.org> <874iik2ew4.fsf@toke.dk>
 <916191fc-2e10-4449-b82b-c086d90283ae@kernel.org>
X-Clacks-Overhead: GNU Terry Pratchett
Date: Wed, 01 Jul 2026 13:02:50 +0200
Message-ID: <87y0fv0y79.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.10 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MIXED_CHARSET(0.56)[subject];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-303596-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:dsahern@kernel.org,m:avinash.duduskar@gmail.com,m:ast@kernel.org,m:daniel@iogearbox.net,m:andrii@kernel.org,m:eddyz87@gmail.com,m:memxor@gmail.com,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:jolsa@kernel.org,m:emil@etsalapatis.com,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:hawk@kernel.org,m:yatsenko@meta.com,m:leon.hwang@linux.dev,m:kpsingh@kernel.org,m:a.s.protopopov@gmail.com,m:ameryhung@gmail.com,m:rongtao@cestc.cn,m:eyal.birger@gmail.com,m:bpf@vger.kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:avinashduduskar@gmail.com,m:johnfastabend@gmail.com,m:asprotopopov@gmail.com,m:eyalbirger@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,linux.dev,kernel.org,etsalapatis.com,fomichev.me,davemloft.net,google.com,redhat.com,meta.com,cestc.cn,vger.kernel.org];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,iogearbox.net];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,toke.dk:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[toke@redhat.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1ED936EC922

David Ahern <dsahern@kernel.org> writes:

> On 6/30/26 10:04 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>> David Ahern <dsahern@kernel.org> writes:
>>=20
>>> On 6/30/26 4:00 AM, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>>>> It does not make sense to require a flag to get lookup output. vlan
>>>>> proto of 0 is not valid, so it is a clear indication that the vlan
>>>>> output parameters were not set during the lookup.
>>>>
>>>> Okay, so we could just unconditionally set the VLAN fields, but if we
>>>> start rewriting the ifindex that would be a change of the existing
>>>> behaviour that could break existing applications, no?
>>>
>>> Consistently dealing with upper devices is one of the reasons I never
>>> sent patches for vlan support.
>>>
>>> xdp support is at the driver layer for real (physical) devices. The fib
>>> lookup is going to return the vlan device index - a virtual device.
>>> Support for xdp should not be propagated to virtual devices; it goes
>>> against the intent of xdp. Any trip down this path will have to decide
>>> how to handle vlan-in-vlan use cases. Where is the line drawn for fast
>>> networking?
>>=20
>> Right, which is why we need building blocks that makes it possible for
>> XDP programs to do the right thing in the BPF code :)
>>=20
>> A helper that resolves the parent could be used for stacked VLANs as
>> well (just calling the helper multiple times).
>>=20
>>>> Specifically, if an XDP application has a table of the interfaces it
>>>> forwards between, today they'd get a VLAN interface ifindex, which wou=
ld
>>>> not be in that table, and the application would return XDP_PASS. Where=
as
>>>> if we change the ifindex and populate the VLAN tag, suddenly the
>>>> interface would be in the table, but because the application doesn't
>>>> read the returned VLAN tag, it will end up sending packets out without
>>>> tagging them, leading to broken forwarding.
>>>
>>> I have not followed developments over the past few years. Does XDP have
>>> support for vlan acceleration in the Tx path now? You really want that
>>> to deal with vlans and not replicating s/w processing in ebpf.
>>=20
>> It does not, no. There's TX metadata for AF_XDP, but VLAN support is not
>> in there (see include/uapi/linux/if_xdp.h).
>>=20
>> Doesn't mean software VLAN handling can't be useful, though; there are
>> use cases other than the very high end where XDP can speed things up
>> even if it has to write a VLAN tag or two...
>>=20
>>>> So if we don't want the flag, we'd need some other mechanism to resolve
>>>> the parent ifindex, AFAICT? Maybe a xdp_get_parent_ifindex() kfunc, sa=
y?
>>>> That could also be made generic for other stacked interface types, I
>>>> suppose.
>>>>
>>>> WDYT?
>>>
>>> dealing with stacked devices is hard :-)
>>>
>>> What is the return is a bond device or a vlan on a bond device?
>>=20
>> Well, bond devices have XDP support, so you can just redirect to those :)
>>=20
>> But yeah, each type of stacked device would need to pass different
>> information through to the XDP program, and the program would need to
>> support those. Building a single XDP program that supports all of them
>> will require quite a bit of code, and would probably not perform super
>> well. But most deployments have distinct subsets of features they need,
>> so this does not have to be a blocker, IMO?
>>=20
>
> Seems to me the fib_lookup for xdp needs to return the bottom device,
> not the vlan device, for forwarding to work. That's why I added the
> fields to the struct. That allows the program to push the vlan header if
> required. My preference (dream?) was that Tx path had support to tell
> the redirect the vlan and h/w added it on send.

Sure, returning the bottom device index with the VLAN tag makes sense,
and that's basically what this series does (but bails out on stacked
VLANs). However, that's not what the helper does today, which is why the
flag is there, to opt-in to the new behaviour. I don't think we can just
change the ifindex without breaking existing applications (as noted
up-thread).

> But really, once stacked devices come into play, I just wanted to make
> sure thought is given to different use cases. As you know the lookup
> struct if hard bound to 64B and it is trying to cover a lot of use cases.

Agreed, I don't think we can handle stacked devices in this helper. But
we could split it out into a new one. Something like:

struct lower_device_info {
	enum device_type type;
	struct {
		__be16	h_vlan_proto;
		__be16	h_vlan_TCI;
	} vlan;
        /* add other types here */
};

int xdp_get_lower_device(int ifindex, struct lower_device_info *info);

called like:

int xdp_program(struct xdp_md *ctx)
{
        struct lower_device_info dev_info =3D {};
	int ifindex, ret;

        ifindex =3D find_destination(ctx); /* does fib lookup, or something=
 else */

        while ((ret =3D xdp_get_lower_device_info(ifindex, &dev_info)) > 0)=
 {
        	if (dev_info.type =3D=3D VLAN) {
                      	push_vlan_tag(ctx, &dev_info.vlan);
                        ifindex =3D ret;
                } else {
                	return XDP_PASS; /* we only handle VLAN devices */
                }
        }

        return bpf_redirect(ifindex, 0);
}


With a helper like this, we obviously don't strictly speaking need to
change the fib lookup helper at all. However, for the single-tagged VLAN
case, I think supporting it directly in the fib lookup could still have
value, as an optimisation: it saves an extra call for resolving the
ifindex, and the fields are already there. So I think my preference
would be to merge this series as-is, and then follow up with a new kfunc
to handle the stacked case. But we could also just drop this series and
go straight to the new kfunc.

WDYT?

-Toke


