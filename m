Return-Path: <netdev+bounces-276899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELGPDklr12myNggAu9opvQ
	(envelope-from <netdev+bounces-276899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 11:03:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F553C8237
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 11:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6A7733010169
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 09:01:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72F83A8738;
	Thu,  9 Apr 2026 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="yiOWWhAc"
X-Original-To: netdev@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1388E3A7F72;
	Thu,  9 Apr 2026 09:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775725277; cv=none; b=ZVUi1RNEdkDcTU45UuG12idW0C6KuqSEWnAWnXU26WpzRlpD/B4Rb1wsz0Ez1LAcb3tnrJER+GehDqEUSUnZCfqrAUXdsbIuTFE4LOpdQ360uG8imcBREmK5vEqft86Wicc5/7gCm+rit8j7/XWYTpq7yjJejZMi50sojv6Xjqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775725277; c=relaxed/simple;
	bh=GI7M3Sq4u2nZGi2pWSuuGV178v6wWu1SuhoP1DtLSSA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=caFsmtd2WblG1jjPqw804/njOPx1gWo8vIs0MFAxOgJmUMAuC6eZdbiFO4KTq3etTiOPMW8UuMHDpAc06FOGLO9nuaaLO6UUQjqmD7LBdEoNFWoiTC254F9ERzQAWqqt2mNg9SL1l3U5KpeauKxZEff5Eo3znNN+v2XEHApGZGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=yiOWWhAc; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=Q2AEP7CMJD8PoBhyfTpJUOpR3duCs+Bk2ok596z3dOw=; b=yiOWWhAcKfdZ6X/A88xEF22KOy
	jV9RPL4+S9HfuMLL8gqYsNa2FYEFqV51StGKNF0WKydTVbJ9ityniBgKPkK1A4WhGtLLwDSMLyu70
	r6IygtetsO42w2gwJNq4YOFWUKMVnRhueBo1rBZWf/agnzoSBZ7q/fA9rbeR7gsBszd+TbeFQcL/j
	p4EnT1aGXpwnitL36ab8LaA4LB6Azyyzr2ifuq+uNcZ03LcUdxOpFm8flWfZtNlw9YO9X9SE0aXlJ
	Yt1IjUJgBWoa3WSbKU2aAVdPS+WZeWV1ZluSm/TbSRROI7QncFE7Im6FHHyiRDrplvbrEg873m4xn
	Bg0lOfRwcn5VVeB5wdzrFB57jHdgLuEJPakKaZTLI8O1Ovsup4B9jssQ+y+NgvrKlfjZgetgomYui
	KQ6kpEb6TOqmgL5Fz5tUp++yBFo0YPPHeHDBQBTT0NbmsTKHOnphOofSMegRtTGM+SA8G4hpbmkl4
	KBBpTlQ08iyJ7AFzBaysDb1x;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1wAlGD-000000087wW-1UGt;
	Thu, 09 Apr 2026 09:01:13 +0000
Message-ID: <5405849b-ad9e-4c64-9259-2071f4e36c8a@samba.org>
Date: Thu, 9 Apr 2026 11:01:12 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] uaccess: fix ignored_trailing logic in
 copy_struct_to_user()
To: Aleksa Sarai <cyphar@cyphar.com>
Cc: linux-kernel@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>,
 Dmitry Safonov <dima@arista.com>, Salam Noureddine <noureddine@arista.com>,
 David Ahern <dsahern@kernel.org>, "David S . Miller" <davem@davemloft.net>,
 Michal Luczaj <mhal@rbox.co>, David Wei <dw@davidwei.uk>,
 Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Marcel Holtmann <marcel@holtmann.org>, Xin Long <lucien.xin@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>,
 Neal Cardwell <ncardwell@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
 Kees Cook <keescook@chromium.org>, netdev@vger.kernel.org,
 linux-bluetooth@vger.kernel.org
References: <cover.1775576651.git.metze@samba.org>
 <71f69442410c1186ed8ce6d5b4b9d4a5a70edbad.1775576651.git.metze@samba.org>
 <2026-04-08-ditzy-organic-yowl-croc-yWsgIE@cyphar.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <2026-04-08-ditzy-organic-yowl-croc-yWsgIE@cyphar.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-276899-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,arista.com,kernel.org,davemloft.net,rbox.co,davidwei.uk,intel.com,holtmann.org,google.com,redhat.com,chromium.org];
	RCPT_COUNT_TWELVE(0.00)[24];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samba.org:dkim,samba.org:mid,samba.org:email,samba.org:url,amutable.com:email]
X-Rspamd-Queue-Id: 83F553C8237
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Aleksa,

> On 2026-04-07, Stefan Metzmacher <metze@samba.org> wrote:
>> Currently all callers pass ignored_trailing=NULL, but I have
>> code that will make use of.
>>
>> Now it actually behaves like documented:
>>
>> * If @usize < @ksize, then the kernel is trying to pass userspace a newer
>>    struct than it supports. Thus we only copy the interoperable portions
>>    (@usize) and ignore the rest (but @ignored_trailing is set to %true if
>>    any of the trailing (@ksize - @usize) bytes are non-zero).
> 
> Good catch, though I want to mention that the current API design for
> copy_struct_to_user() is a bit of a compromise -- I was trying to think
> of a way of making it generic but what information you need really
> depends on your API.
> 
> For request-flag APIs (like statx) then you can just unset the bits in
> the response mask for fields past usize and so it is a non-fatal error,
> but it requires knowing which field offsets map to which flags.
> 
> My initial idea for ignored_trailing was for it to return the offset
> memchr_inv() gives you -- but unfortunately, this doesn't help in the
> more generic case where you have multiple non-zero bits that need to
> unset multiple flags.

I guess the caller could use if (ignored_trailing) { ... }
to check more complex stuff and then decide ignore or return an error.

> Out of interest, how did you plan on using it? It might be a good idea
> to rethink this API before it starts getting used "in anger" in a way
> that leaks to uAPIs we can't change.

Currently I only use it with WARN_ON_ONCE(ignored_trailing);
in order to catch internal errors. See
https://git.samba.org/?p=metze/linux/wip.git;a=blob;f=fs/smb/common/smbdirect/smbdirect_proto.c;h=ce7c78eb6795041ba672da434ffb01db73269cb7;hb=37c61ef9758f3e113d4078220d8fc2aee366c955#l1625
But I guess I will at least change it to
if (WARN_ON_ONCE(ignored_trailing))
     return...

And in general I thought it would be good practice to
check that case in new code in order to avoid unexpected
behavior.

> In any case, for this patch feel free to take my
> 
> Reviewed-by: Aleksa Sarai <aleksa@amutable.com>

Thanks!
metze


