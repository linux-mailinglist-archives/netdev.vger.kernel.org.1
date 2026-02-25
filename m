Return-Path: <netdev+bounces-261070-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GPTzHexSn2mraAQAu9opvQ
	(envelope-from <netdev+bounces-261070-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 20:52:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF8DD19CF05
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 20:52:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 946B530AE37D
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 19:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CAA2DCC1C;
	Wed, 25 Feb 2026 19:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zet2AlBP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173072D876A
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 19:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772048976; cv=none; b=m3Cjasnb9h6ANX88x7sgmSb4dVkEfVk29j65KhTkyUY7Hpfkzluey5IMQiiskyzQXwKDa2X4YvikqmRQgrHInou8DLkfBYnoJfG2NiwjIn+owyaEkA/SEtEAC7ZtEegU+pxxK9qd/hqiktDqdAgfp9ohcfhfSl+RxAOn8U+IeVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772048976; c=relaxed/simple;
	bh=IwiTgpjkeqFMqWSFK6RU5LNOiF/JEUJlaNjNpyEVOUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J7NStjcJmzSdczeeC4yL6Kd2jtQnIgRKoa/Bhe5qh/qiKUtGoBZNTu7+SDNRnCcKtkMc0WHiXcv/EBHciGGnhIYeHvWIqUD2Xklb8Ide0CWHF9+XWrLHSpma1qAiYjrcjFGkos+cq2DeK+f7/GmQ3g4q+ZLb+d+6xLMjFCUqp6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zet2AlBP; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7987531082aso347217b3.3
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 11:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772048974; x=1772653774; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lBrBuKxNKltSGjbyuexsLRyWWbzoDm03jz7Y5rzbxME=;
        b=Zet2AlBPmHI5Rv3ENu2Jk8uIbAvg0EVsgsP8PC0VlhGQij8l5+fdGVvEefRmdkgOpr
         PCv3UBXTWipbTyvSwKSaCn4Yqgc46U37V1SsWvYEF7y1latHLj3DnYtrJ352mBeI/MHN
         264VOufHSa9ujJ4aWh2mhT/bpvLolzHu3er5BLvoLOnWexeNXpribzbeGjsEV5iBmY6C
         K/60NJECmyDJII91v4uH0MnCSDBpfvIGcO0RcRmzDMTsXGG06oLwDBMTOz+fJNmvwCiK
         orC8fbhqY72TX7Hoj/Ti/D+EG6kx4zhQKMjObyasbbvejm+bthPVNmnYUwvEWUnIm1WG
         oZbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772048974; x=1772653774;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lBrBuKxNKltSGjbyuexsLRyWWbzoDm03jz7Y5rzbxME=;
        b=O5Hs0ul8VeorKsnuEZYxSsis50SeoZAl5j5nEN4mTzRlzRxTFuCKch2R6KrxnEGU7k
         SwSa+oG91MbXbn+dUzc6i2yzSauEhSODINbdQCQtmBLauOTbC3oi8MYmpxZr2a1DTxqn
         HCVGuRnqngzG+mlU7biFLa4iYwDVsAx2nBN1rd/FHYkTfkf26IGLAoyFMrYbPjBYvFZQ
         JruPz7PGs8z6O1ydw+5gnJdYwg6XvEEZMYiGcUfIPsH7e50kHovrK4wyP4Zpem/djETk
         xh3afOAMakgTJI7bMKAw4i+y8s2QrSJoVK1e6GbqgF0nvwaCBjeUoQNviiW8pMQQRYXd
         P6RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCt8cfD5w//r19tX+aMN0HVf2AyVN01GAZd5PO0V/d9WjEPc3k2A+Ncy+nMac3YGjhIYO7c5I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzde1NSErt7ykk8w9SHe1vIvgxrWPJEoBz2fXjVUmdyTAdQNrKR
	GYl5falni2J0nx1KMzaeY9P3DmZx1Ec4qgILrJlFfswYyGUjeR88OTqW
X-Gm-Gg: ATEYQzxwqzTW2EtaxWeEaSyUalyo/y0CfuoTLkLCcebAVuUx2Wa0hJAEs+avppd7Jxl
	oUCWFe3m47VIhE7Kiyc6rmDLnEdiELFarbQhbKmWAYNuQ4I1H1u+nTjwpDOCmFSnJS6kaTAm8FR
	rjgG8A4oaju5A888J3MkVMh/Djp+whixdQSoEtNmD3rXGH1d2bRS7SyEqUvfVuHkRoQXiFOlOR9
	TDeRxOCSoLjwhbWZs3q1jttZ4c7b7JDvFAP/Xw5HTI8c5HuPdmDbDRykJJ+H5Lnw1NljU5+HPpd
	qxD4sNXbFTAX5eiH6EVZVnLQ5K7134uWPavXKTBvy36u1fCzkdI3SnWkAsamW80qzbHfJCehZBK
	xR7KMW1iUSdooQl146HFxvBTEYLbfsgy+025CRTGZBrcLqq8NQRJY4j0bRlA6sEaa2Nzdz1MDgW
	NUYQjXtL0mjFHHDxMsnzJxWImEz0lA5GIfADzH2zALdMqzWQs=
X-Received: by 2002:a05:690c:6086:b0:796:3c99:1833 with SMTP id 00721157ae682-79829174a23mr160398677b3.60.1772048974112;
        Wed, 25 Feb 2026 11:49:34 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:74::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982dbd9fa2sm60176917b3.18.2026.02.25.11.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 11:49:33 -0800 (PST)
Date: Wed, 25 Feb 2026 11:49:31 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <stfomichev@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kaiyuan Zhang <kaiyuanz@google.com>,
	Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net] net: devmem: use READ_ONCE/WRITE_ONCE on binding->dev
Message-ID: <aZ9SS22ig+7BJsGD@devvm11784.nha0.facebook.com>
References: <20260223-devmem-membar-fix-v1-1-37dcae1e49f8@meta.com>
 <aZ5VNkUqkTEzX6PJ@mini-arch>
 <aZ8R5n80NmnPb1J9@devvm11784.nha0.facebook.com>
 <CAHS8izM9gS+4rKaxSdqx3yjn4harxKQ2HeCszPyq6XNbq+UcMQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izM9gS+4rKaxSdqx3yjn4harxKQ2HeCszPyq6XNbq+UcMQ@mail.gmail.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,davemloft.net,google.com,kernel.org,redhat.com,fomichev.me,vger.kernel.org,meta.com];
	TAGGED_FROM(0.00)[bounces-261070-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,meta.com:email,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: CF8DD19CF05
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 09:31:48AM -0800, Mina Almasry wrote:
> On Wed, Feb 25, 2026 at 7:14 AM Bobby Eshleman <bobbyeshleman@gmail.com> wrote:
> >
> > On Tue, Feb 24, 2026 at 05:49:42PM -0800, Stanislav Fomichev wrote:
> > > On 02/23, Bobby Eshleman wrote:
> > > > From: Bobby Eshleman <bobbyeshleman@meta.com>
> > > >
> > > > binding->dev is protected on the write-side in
> > > > mp_dmabuf_devmem_uninstall() against concurrent writes, but due to the
> > > > concurrent bare read in net_devmem_get_binding() it should be wrapped in
> > > > a READ_ONCE/WRITE_ONCE pair to make sure no compiler optimizations play
> > > > with the underlying register in unforeseen ways.
> > > >
> > > > Fixes: bd61848900bf ("net: devmem: Implement TX path")
> > > > Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
> 
> Looks correct to me, and AFAIU Stan is right, we might as well
> annotate all the reads of ->dev as technically there could be a dmabuf
> uninstall happing concurrently on another CPU. I also think it's
> probably good to annotate potential races.
> 
> The ->dev write in dmabuf binding doesn't need WRITE_ONCE annotation I
> guess because it's initialization, it can't race with any reads.
> 
> This makes me wonder what other fields in dmabuf need annotations. I
> hope I didn't miss many more.
> 
> I would add this is really not a critical bug because
> net_devmem_get_binding() is in TX path, and it is more than fine here
> if we fail this check if there is an unbind happening in paraller with
> sendmsg(), but it's probably good to annotate potential races anyway.
> 

Sounds good. I'll take a look at some of the other fields while my mind
is in this space.

I agree about it being non-critical, good point about TX passing through
fine on failed check.

Best,
Bobby

