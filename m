Return-Path: <netdev+bounces-289480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFLfBvNxDGpKhgUAu9opvQ
	(envelope-from <netdev+bounces-289480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:21:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E15806ED
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 16:21:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D0BAE300C0CA
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 14:21:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4FB47DD4E;
	Tue, 19 May 2026 14:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WTQ+vmDH";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="atxcp2sF"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9494028C0
	for <netdev@vger.kernel.org>; Tue, 19 May 2026 14:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779200490; cv=none; b=AZd+uX4byJmMSwbIjIEx6nokFGyri48E5LR0sNmNTeHPS8HrjZXGgZl3jDIQ9rtPq7REi8kUd7Xt3DnVJGKiMqJh4yze4iO2o0uu5UzHYTT9ZFlr7uvZBjQOqKxY6kLudaY3nPyigTtEzdD4Y6j0LyxuhVkvT815bzdK5hEkjZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779200490; c=relaxed/simple;
	bh=py1MRqKn7exNdjXsmsX1yh47Z7tsmCUTS6qgb/gwScY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fzeYWCUPbTRx0OnRe4EW9WnQDxSBjaxRREH2juwZV/nC9ixwDLQw7aSrYMjiQXenjcDD0wqMpO3N+7Og+h6rX2mJwPkvdeIlx3T8NPvNa+0EJb1PUyvHESDj+Zqz1SW631ptTej5tC6LFvYtvLdgdDGYGtTuFioQfjbp5J45rJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WTQ+vmDH; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=atxcp2sF; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779200488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ShAj6l51xuzBF/j17UKisc3z8T5wY7lSXY12qKT0nQ=;
	b=WTQ+vmDHRD44iDFNooHkJLEpGwk9D80uB2rqmC43hGAj/BMQYb1wh5LpKbwxd8BVVtSlUW
	ozlqLir9E90RLANL4vFPX+n+SsjwKLll2wFNd3Z+aeMy9aXdQLYZSuS7b8EUv66lR11TzT
	G4ievXIR9VXpoIHINDZCCxfC9K0D9oI=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-N-l55fu6Pvqp8U20jcuVVw-1; Tue, 19 May 2026 10:21:27 -0400
X-MC-Unique: N-l55fu6Pvqp8U20jcuVVw-1
X-Mimecast-MFC-AGG-ID: N-l55fu6Pvqp8U20jcuVVw_1779200486
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-67ff00a6997so3425744a12.1
        for <netdev@vger.kernel.org>; Tue, 19 May 2026 07:21:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779200486; x=1779805286; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9ShAj6l51xuzBF/j17UKisc3z8T5wY7lSXY12qKT0nQ=;
        b=atxcp2sFzsNwNoRHq10FJjiYp5yXGrDIXgsUuRUObNPJuwOJt/DbOgPqvCmw7MiKQD
         2K0XJtd03bK5cvv3p0HyJlg2uO33vTsTd7UKtQhHPVZlLNhRRVTeZgQzYJsqln730bla
         hB93zGKCsl+Y/Md1U0z16l/bZf6d55DXJto96PgsHZsTqqPYpSsPHSbpeJz5u6bu/cVa
         qmZF7oRf+7IsXXFgBBRUlRsu3CIHVAHw74URPVZPIA7w3wYX+Jeanhr9gOZsfuQnV6qf
         vQaCoZJFUlWKJZ7H/pYTON0/y2352zCf1fzLJqrCjXXXA7BWHj9A8rgKLorzlIm8JZnZ
         yunQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779200486; x=1779805286;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9ShAj6l51xuzBF/j17UKisc3z8T5wY7lSXY12qKT0nQ=;
        b=bYA+299pr0KDkuz3skSsSlYQlelEGPZJtfi2o1FGX0WgfBqq0hPe9zpdi+/j8iZaTG
         ijv+AfDxOj8YmG4Cc7ZXzeuvg/BdSiFZThj5PmzM/BgyLLGKGj2et9QzlECZcyWQ4rew
         Q63abiwRt4HQ+/fjuMTTgLaexrpzHVFq6PE7/w2Ov9zokFtL9pZrZ7OuBv5n2C+GCy9R
         c9aWslLY45u4vdKMi3DR2dHWFTvzt1Dz4RPtXIQm40eYRthpg7Ozj3cgQu3f+DDVu/i0
         pbnk0yhgRBbLyHVwB9+gFYa+tdZvAPUXsw+YQUhVpKdNTMsicGss6J/xbwese0c9hwlG
         A5bg==
X-Forwarded-Encrypted: i=1; AFNElJ+p2dkvIngCOFjZtr1gfCp5qLIe3AcwTMdyBNYiC7qj5smYLsBYpTLXu7VP8OPaq4sCq4zQ9Bg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyDc2oR4L4bl+cU+b9QUMN5u2yrPxSi+NYT/8BYpPnz7n4iZvN1
	EXWq6tiidMStGm5Ez8fXW4QlHNs1NH0dp0apkJ6Ugg6/qZCoplrJPa5Qo/1VCK5BDBKQ/UE3Dpw
	4su906PhizpXHw7d0A53vmwwlSeioIYNfOAl/604c2+mKjk2abjfyf+qQgw==
X-Gm-Gg: Acq92OFbnZukBAY8gndBv6f2sk0BAOFmkVqyYQbsZ4AyppuvzB+vTWLJfjS3yj0mx0b
	zo0vvssVm2opFgwHnyVMTX9JAY2fLdTxnmVqKMMBvi29XYIbikNWVBZuowVrIA3BYCBBD/Bhy7s
	oKWdCYhvAvuWNkq7ZDe1egUNuF4MmbydoPFyzRL1M6oIzeIzS6h1dGWJ/Tv8EYEuSGLTsMm86Q0
	kQtG28/ScXi/Z7sYNECwsAvEMxlA0a/dmawezgdNKNBxEO0uUIEocA56BKGuhkjwA1Z3PlqI0sb
	lNWF/eplzJhHo8c2Qd/phQy6tLb0HrBnNkhiqksXf1jJ3F94wnXw7bPv0/HQ2oWLCLaiGwcLAxa
	Xug/FHsrs5E31qCWBCMKL4ryL0pPTajmjwWSJ/OagFygS+Xrmmq0XIZhxvCA84K6qIQ==
X-Received: by 2002:a05:600c:5304:b0:490:17da:27f8 with SMTP id 5b1f17b1804b1-49017da2830mr97673695e9.18.1779199722801;
        Tue, 19 May 2026 07:08:42 -0700 (PDT)
X-Received: by 2002:a05:600c:5304:b0:490:17da:27f8 with SMTP id 5b1f17b1804b1-49017da2830mr97672985e9.18.1779199722357;
        Tue, 19 May 2026 07:08:42 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.25.33])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48febe5bc94sm204874615e9.4.2026.05.19.07.08.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 May 2026 07:08:41 -0700 (PDT)
Message-ID: <c05304bd-1c7a-486a-9929-e6947de07adb@redhat.com>
Date: Tue, 19 May 2026 16:08:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 7/7] tipc: convert to getsockopt_iter
To: Breno Leitao <leitao@debian.org>, Chas Williams <3chas3@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Magnus Karlsson <magnus.karlsson@intel.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>, Jon Maloy <jmaloy@redhat.com>,
 Alexandra Winter <wintera@linux.ibm.com>,
 Thorsten Winkler <twinkler@linux.ibm.com>,
 James Chapman <jchapman@katalix.com>, David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>, David Heidelberg
 <david+nfc@ixit.cz>, Samuel Ortiz <sameo@linux.intel.com>
Cc: linux-atm-general@lists.sourceforge.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 tipc-discussion@lists.sourceforge.net, linux-s390@vger.kernel.org,
 linux-afs@lists.infradead.org, oe-linux-nfc@lists.linux.dev,
 kernel-team@meta.com
References: <20260515-getsock_four-v2-0-0d8eed952627@debian.org>
 <20260515-getsock_four-v2-7-0d8eed952627@debian.org>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260515-getsock_four-v2-7-0d8eed952627@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-289480-lists,netdev=lfdr.de];
	FREEMAIL_TO(0.00)[debian.org,gmail.com,davemloft.net,google.com,kernel.org,intel.com,fomichev.me,iogearbox.net,redhat.com,linux.ibm.com,katalix.com,auristor.com,ixit.cz,linux.intel.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[30];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev,nfc];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: AD6E15806ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/15/26 10:32 AM, Breno Leitao wrote:
> @@ -3260,7 +3260,6 @@ static int tipc_getsockopt(struct socket *sock, int lvl, int opt,
>  		break;
>  	case TIPC_CONN_TIMEOUT:
>  		value = tsk->conn_timeout;
> -		/* no need to set "res", since already 0 at this point */

Since you have to repost, there is another obsoleted comment referring
to "res" later on:

		return res;	/* "get" failed */

please strip it, too.

/P


