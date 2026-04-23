Return-Path: <netdev+bounces-280667-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPXnEEPd6WmNlwIAu9opvQ
	(envelope-from <netdev+bounces-280667-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:50:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D780444EC60
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4A95E3006830
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 08:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBAE364055;
	Thu, 23 Apr 2026 08:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bGghTNlN";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELm0MwvQ"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E65D9285CA4
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 08:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776934209; cv=none; b=mNx3lWvh2WQPluOWdM0+FX06Dg4pZFZzhCUgmsjWQoSltdXcqdDmGL7RpSeI9MVyDNPMd2w8vrGRhCHpeFsmywW+WL59mSji/6piDpgKNYnw9PoCwpUWfv8fTGN2NsdCW8cHRZ5r/SK+Fewajnf6/jlY/hc7qtSfufCZYH5AKT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776934209; c=relaxed/simple;
	bh=2I33bLf3FEDj4HSeZsAcuVTcrQtXGindYCJsMLcyM0g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAMM68T0gyrhICmSX42wVvXRj/3daBddeb4igaIT19WA3d7+dLnO4wjdr7T8PLQjYzG/bqQL8fV3iWjEr4PlMVeDUYeoHtnuGpAwVBHNuTH7fRn6klWZyjf2TylQQZr7A6oVBNp4xoPmTowwfo7j66x24j0IoDgehQ8syzeOjLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bGghTNlN; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELm0MwvQ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776934206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=CPNjniPurFuKC+UJn7cdcULljo3LgHo4hck8QqufRls=;
	b=bGghTNlNof9jWcO/0tJSbiaQ+QKCRg5Ae0tWq1cMyfyYHeFQ/EWsQHvim11uj1SwwCFClC
	lUZVl4lJ00YjCmbRi+ophJukDHFxIv2hlyD90zNn0GTbW1PHI7dhnCKibfXNP/uDkJm7Pc
	MIGfE+57+m8fpLDVe1Jabo6icDa0fhk=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-E5a-Bi5pOySUsY9PDzsAWA-1; Thu, 23 Apr 2026 04:50:05 -0400
X-MC-Unique: E5a-Bi5pOySUsY9PDzsAWA-1
X-Mimecast-MFC-AGG-ID: E5a-Bi5pOySUsY9PDzsAWA_1776934204
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-488be33b7a6so45584215e9.0
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 01:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776934204; x=1777539004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CPNjniPurFuKC+UJn7cdcULljo3LgHo4hck8QqufRls=;
        b=ELm0MwvQ0i8F0eKIG5e35svBJxhoe3NnAYIjajTctoveo8i/WFFKQY5OJvakCSS1Ft
         Iu0ewdB7jrJm2Gb7Nf14QCja0j9x9zZmTEBa3Q33/JNW6QdCQHfmWjyZCzgvFN4pOR46
         3wrTRX1rOekXj8KdNLhC2w1b8pXfXY5ooz6pFPp3qrYnoS0p029fxwpnu/fHkdh3iCVE
         Td5iKr4XWqDlHy9HrPecwIW20YFIk0RrlVm7WYFIWjsVQY+DRb5W9p+hXMra/v4kZx7Y
         Odhj0ZXCG1xWNH/EIFbgPm7sfgX/XmeAWY9nRbCmLN046N7PpXMYo0QDSkXULLG4bcoL
         TtDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776934204; x=1777539004;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CPNjniPurFuKC+UJn7cdcULljo3LgHo4hck8QqufRls=;
        b=OoeREkTiQrNlfoFVIoJZf/vg6CjAfWebuVJipl3BNW5Yf37c9FcoKIj770t+oKfaYt
         MOEetQcjZ6drK7fK681Q4QFTAlAlxi0EFBhiFef3YIvm3bqynuGB3oKjZ1AuU8Ganqdm
         S5EEOImnAIh00Ab4botWCyfgF47+hI+dhfDf+zhBgthHoEPVYMTFcJwq/2Wig8OTqNba
         YKVjLFUiFrQ4UtMQDHYvJEnDSkLCXCFVheOs8D8b9RVf6bIiH6G76wwNbtX4/bmgcAOk
         4TESmKb82gMY0Zh2aKG2zJufvEIL/roi4FcCqh4dkxz/9AOyOM6A/lWbGRAYqI6RdxqS
         EUyQ==
X-Forwarded-Encrypted: i=1; AFNElJ9POrI8yksUKv0P8hgrBw6qmMtTffRmT2XcegpMwTwfAb3WWQf/jsSrtIKi53lOSOxuHOrk7qQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt5YxA/R8NceVvpoEAxRMJHjTa0AEDlIzZ6T0cYxWrQSU+mGlM
	IiRae2BeAJe4dzBbXpk7oGR4i2EysP7sWolv0NjYKcxOS/02+g14yh5Z325mktnqRF9sDOCb6TR
	x/AE91if0hCOoBaEBsaarT/x5M27VBBKV/V8scUvdCCZnlJ0VT2U1M5ZKiA==
X-Gm-Gg: AeBDies2ccX077Hc90o7SYYaaoCVE0OuPF2QjQ5tRuN8leuJDfpld464aoy9toFwRkG
	u7jWmnrFZb8fBLjmHgbLWvmpShXt5DFcOmMnz6qaZcz2FbfrzbuU8Rf0GhFejEmKROiIIHUr0+W
	mkIaYnB4LViagsYcOSqlwv4yug2LUsnLSXFOeR0X7qKhUWp1YYMbjxi13i4FTJq7HBjYBleXJ8W
	dnpVG7ZJ9E2y8RyolzZyTblRzDgcZgBPiawWSsgIEYH5ehVl/gw4wNSsAUZhS0+3y/0TnVwrZuf
	rNtUAfRdTCJfzy13AGqSnww+QT0WPPnAzt+hbKUzd6eoqHpidK0zeL+gYJf3hk6elufzOTtQzd4
	sXkaSq6K+H1tFx/HrRT40LYiJR2GEA/eUaYyeCA==
X-Received: by 2002:a05:600c:c4a2:b0:488:c078:bfda with SMTP id 5b1f17b1804b1-488fb78eebdmr358546195e9.26.1776934203725;
        Thu, 23 Apr 2026 01:50:03 -0700 (PDT)
X-Received: by 2002:a05:600c:c4a2:b0:488:c078:bfda with SMTP id 5b1f17b1804b1-488fb78eebdmr358545615e9.26.1776934203241;
        Thu, 23 Apr 2026 01:50:03 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fb7aa593sm159041235e9.24.2026.04.23.01.50.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 01:50:01 -0700 (PDT)
Date: Thu, 23 Apr 2026 10:49:59 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: Stefano Garzarella <sgarzare@redhat.com>, stefanha@redhat.com, 
	netdev@vger.kernel.org, Mathieu Schroeter <mathieu@schroetersa.ch>, 
	David Ahern <dsahern@kernel.org>
Subject: Re: [PATCH iproute2] ss: fix vsock port filter
Message-ID: <aenV8MVMhsXv4U5O@leonardi-redhat>
References: <20260421-fix_vsock-v1-1-812c80a76c1a@redhat.com>
 <20260421163757.31da8751@phoenix.local>
 <CAGxU2F4C4JbqBEWehBhhOehGaXZJOWLkQ09hjaaSAh8-J5W50w@mail.gmail.com>
 <20260422092100.46744a32@phoenix.local>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260422092100.46744a32@phoenix.local>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280667-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leonardi@redhat.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,networkplumber.org:email]
X-Rspamd-Queue-Id: D780444EC60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 09:21:00AM -0700, Stephen Hemminger wrote:
>On Wed, 22 Apr 2026 10:03:49 +0200
>Stefano Garzarella <sgarzare@redhat.com> wrote:
>
>> On Wed, 22 Apr 2026 at 01:38, Stephen Hemminger <stephen@networkplumber.org> wrote:
>> >
>> > On Tue, 21 Apr 2026 14:35:12 +0200
>> > Luigi Leonardi <leonardi@redhat.com> wrote:
>> >
>> > > parse_hostcond() uses get_u32() to parse the vsock port into the
>> > > aafilter.port field, which is a long. On 64-bit systems, get_u32()
>> > > only writes the lower 32 bits, leaving the upper 32 bits set from
>> > > the -1 initialization. This causes the port comparison
>> > > "a->port != s->rport" in run_ssfilter() to always fail, since the
>> > > corrupted long value never matches the int rport.
>> > >
>> > > Fix by using get_long() instead, consistent with how AF_PACKET and
>> > > AF_NETLINK handle the same field.
>> > >
>> > > Fixes: c759116a0b2b ("ss: add AF_VSOCK support")
>> > > Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>> > > ---
>> > >  misc/ss.c | 2 +-
>> > >  1 file changed, 1 insertion(+), 1 deletion(-)
>> > >
>> > > diff --git a/misc/ss.c b/misc/ss.c
>> > > index 14e9f27a..6e3321ac 100644
>> > > --- a/misc/ss.c
>> > > +++ b/misc/ss.c
>> > > @@ -2323,7 +2323,7 @@ void *parse_hostcond(char *addr, bool is_port)
>> > >               port = find_port(addr, is_port);
>> > >
>> > >               if (port && strcmp(port, "*") &&
>> > > -                 get_u32((__u32 *)&a.port, port, 0))
>> > > +                 get_long(&a.port, port, 0))
>> > >                       return NULL;
>> >
>> > If you use get_long() then the code could get negative values.
>> > Actually have port in ss as signed value seems like a mistake in original design.
>> >
>> > The port in unix domain socket is inode number.
>> > Originally it was int, but got changed to long back in 6.6
>> >
>> > The port in ss cache is int.
>>
>> Yeah, as I mentioned I think the issue was introduced by commit
>> 012cb515 ("ss: change aafilter port from int to long (inode support)").
>
>What about this which avoids the cast but keeps the same semantics.
>
>diff --git a/misc/ss.c b/misc/ss.c
>index 14e9f27a..e830e146 100644
>--- a/misc/ss.c
>+++ b/misc/ss.c
>@@ -2317,14 +2317,16 @@ void *parse_hostcond(char *addr, bool is_port)
>
> 	if (fam == AF_VSOCK) {
> 		__u32 cid = ~(__u32)0;
>+		__u32 vport = 0;
>
> 		a.addr.family = AF_VSOCK;
>
> 		port = find_port(addr, is_port);
>-
>-		if (port && strcmp(port, "*") &&
>-		    get_u32((__u32 *)&a.port, port, 0))
>-			return NULL;
>+		if (port && strcmp(port, "*")) {
>+			if (get_u32(&vport, port, 0))
>+				return NULL;
>+		}
>+		a.port = vport;
>
> 		if (!is_port && addr[0] && strcmp(addr, "*")) {
> 			a.addr.bitlen = 32;
>
>

With high enough ports it's not working, I expect to be a problem with
the sign. I'll try updating `struct sockstat` as Stefano suggested.

Luigi


