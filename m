Return-Path: <netdev+bounces-265120-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAk3CsoErGkxjAEAu9opvQ
	(envelope-from <netdev+bounces-265120-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 11:58:18 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FF822B3BF
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 11:58:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D47663012B67
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 10:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4187734A3CC;
	Sat,  7 Mar 2026 10:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gTixRSYn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07470346FDB
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 10:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772881094; cv=none; b=JIeXY5qPs+gP48MAhBaLx+U2BAyOMogf4QcwBcwcbUiVr7sBN4BJCLuVrkSlaxwQVGNdHpfj//KnQR6pu50Eq5scZxSN9AeUbGDdu1U7fyeLtFtEmD2cTsLimCF9NnGwvp6XWuzN8qmbyUZe3Bh6kDvRhVeoUEm0CtwO3hXRU9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772881094; c=relaxed/simple;
	bh=JqYPGHt/TQECE/E6zuwNqEwKXnQlrnAHciMrFdwbmZ8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=meAcRUi4iDIdbtHJV2qTneXZ2+ufOpYO3CLmiUI2prFaZDFadvSF3mzW43SMfc4mKN6sChIl0UsO7gFW/DaSlXZmjvobPetRXgYi4aXIqMqod861qWKixoGplHRJfaVrHOzxkADhRepKUMZ4g+3UXMI1dX1h5UhaNJ3vMLhYUA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gTixRSYn; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-506bcb23a78so89541861cf.3
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 02:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772881092; x=1773485892; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dykdbePLxtRxAe6YmrUCwFD8VwzL2P54+xi7/+YogDY=;
        b=gTixRSYneg5GgB0+9JKJksMrqfJiDS4zyxDYFuQsdtGeTZBD2ziocR6fkLKBtl1lp8
         EO0ToiTup/oe12v8T1TBHFxAr7jjQB+FbzP3Ykxad1g1oaX3mf0VH8sGG72XnZXCG1Yf
         RDDaodAXAVsoYsyR7c8La+VIfWIHZ7fSQTPakMy8OuyltoYKej9l1pFl6fB/B4KrY4dR
         75NZvM1eBf12Iigjn8TNLrvsL6jbWe5BBoK4WMNogo09z025E57A/klmX28QY4Ktns5V
         472NTb07FCQNhGB2u5kbgKybRGCQWb/lupMKPrBhvB5XI757Z6zqme/VF9a9g6NyMFW8
         74hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772881092; x=1773485892;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dykdbePLxtRxAe6YmrUCwFD8VwzL2P54+xi7/+YogDY=;
        b=K+C6U1R8Pv2gtIXv4Z+IvReAI31m/9AUwCbRjCahZVxkNBX++NobBNqyPuHzuJMjEs
         CITTZVczqAeXQZvFBWuPI00o+wx7ukAZCPlA6RwqO3nASoSs/24zvzl43T4gibMdvSbh
         gJfcTxNO305Ncn+FTuD0Qj0uPMBDJm5xhBQ+GLN7GRRKEfUNn3xI3x6fS4p5qatfIJ9h
         k7yEFmfL0lytFUd8lj0a+RmRh+QLl95K8ErjqYoIuR58bQdvJq7QJlXkH6dlqLQFc8a1
         A91wLYBcGnXQHl4J3noPPIaRGl4XXooSs0njyjnWhVrZj4gVqMAJnAAGRXBi7VM+4t//
         jf0A==
X-Forwarded-Encrypted: i=1; AJvYcCUjEHbR9EsLbnNcS8LcRca8w6pp3CF1KAwwosqwQIziJGeXkAItWXY+lp3c6WvOonSqhp/IZws=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGerrSdxUtKA5Yfl+ZKEv6jCZpk1zAyAK4CWaYh6g/42ce8CMS
	NEZKATVupQOsg7U+lCRSigD9NLihc58PKUjF1de8tUHLm1Qel0VTJ8xN
X-Gm-Gg: ATEYQzyyEu1hDIQdj4/xYj/zPVfh+6FyDb8IajxhUuSIYZzfvDcpYanPPGXp93qczDE
	5ALrtRD8rWQBqK443+WJi3qkaeU6dfnoXlS5sXAdebUjLV9c9rydfQ8yzboAJHU85gw/LHXjczy
	HlSLIItvioTWuXJNdN0v7aQlaLVPPRPcX1LSyBYh/Y/6O93sN2upuu4pbo3af7ZEBOahz0agjP/
	6b62C340GPqGoVab9mpF6JBQgDr7eJlZQXY+7L1E0RK1freBvmGDr2kyUFCtfxlf2gXWS8dDliE
	U5Xe9mjYboQlGRhtMT44QlU2/pNcghr70s+tEXagJScJH7FffKm/zqcI26XxCCphMkMihZEZs2r
	/gE5qxig2Zr/gEKXpCzCDD+2qUmjomX5y7F/Ro+kiKwoZsGQYQIV2VYqXEdcxLIfz7QQQ3BuUA5
	bEdS1Ar6dLMahTQByBAMeiAK6laN/gwebLfgIP60m9kbCOLakDK1WiLa3EmuSnMx36ESs=
X-Received: by 2002:a05:622a:a9d1:20b0:508:feeb:47da with SMTP id d75a77b69052e-508feeb4d3cmr28359351cf.15.1772881091665;
        Sat, 07 Mar 2026 02:58:11 -0800 (PST)
Received: from PF5YBGDS.localdomain ([163.114.130.7])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-508f655819asm26604921cf.14.2026.03.07.02.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Mar 2026 02:58:10 -0800 (PST)
Date: Sat, 7 Mar 2026 05:58:08 -0500
From: Mike Marciniszyn <mike.marciniszyn@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Alexander Duyck <alexanderduyck@fb.com>, kernel-team@meta.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Jacob Keller <jacob.e.keller@intel.com>, Lee Trager <lee@trager.us>,
	Mohsin Bashir <mohsin.bashr@gmail.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Pei Xiao <xiaopei01@kylinos.cn>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	Samiullah Khawaja <skhawaja@google.com>,
	Hangbin Liu <liuhangbin@gmail.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 3/5] eth fbnic: Add msix self test
Message-ID: <aawEwLt-RZGs2yAx@PF5YBGDS.localdomain>
References: <20260305150947.16893-1-mike.marciniszyn@gmail.com>
 <20260305150947.16893-4-mike.marciniszyn@gmail.com>
 <aasqpPj2rOIKgnSY@PF5YBGDS.localdomain>
 <20260306140958.42ccee3a@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306140958.42ccee3a@kernel.org>
X-Rspamd-Queue-Id: C0FF822B3BF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265120-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[fb.com,meta.com,lunn.ch,davemloft.net,google.com,redhat.com,kernel.org,armlinux.org.uk,intel.com,trager.us,gmail.com,linaro.org,kylinos.cn,fomichev.me,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikemarciniszyn@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.976];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,checkpatch.pl:url,PF5YBGDS.localdomain:mid]
X-Rspamd-Action: no action

On Fri, Mar 06, 2026 at 02:09:58PM -0800, Jakub Kicinski wrote:
> On Fri, 6 Mar 2026 14:27:32 -0500 Mike Marciniszyn wrote:
> > There is a change in the patchworks checkpatch test the wants to see this as:
> >
> > test_data = kzalloc_obj(*test_data, GFP_KERNEL);
> >
> > Unfortunately, the net-next repo does not yet have this api and doesn't
> > have the checkpatch and the new api that comes in:
> >
> > Commit 070580b0b174 ("checkpatch: Suggest kmalloc_obj family for sizeof allocations")
> >
> > This looks like the checkpatch.pl in the test is not from net-next/main.
>
> I suspect your local tree is old? Or I don't get what you're saying..

Sorry.   I must have messed up the rebase.

The lastest next-next DOES have the correct API.

v4 on the way.

Mike

