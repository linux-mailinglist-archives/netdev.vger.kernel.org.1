Return-Path: <netdev+bounces-290663-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AIDXJfncD2ojQgYAu9opvQ
	(envelope-from <netdev+bounces-290663-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 06:35:05 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A430C5AEB24
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 06:35:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 79D903001395
	for <lists+netdev@lfdr.de>; Fri, 22 May 2026 04:34:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E83330D34;
	Fri, 22 May 2026 04:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJSSkU/s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022A52C375E
	for <netdev@vger.kernel.org>; Fri, 22 May 2026 04:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779424479; cv=none; b=RKzeYkG0UIS0pOnusT+av0MUMSAEZOUoHyKlb6AX1K5Lw0rDjlARxj4Ls1/rt1PP9l1st53/Pe7g/VXdlEQyOeE042vHNap7Eb5+NpoL+R3j/sMY6WiC/N+gRB3bzLrDnbzgAsTYqwiPRZ/lPcaAtsuAVP7Hr2S7EjYsCYXo4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779424479; c=relaxed/simple;
	bh=ID/CA1JUu+vSL2WViBxYaJS7zNva0ko/lsuTwTKoGAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JhqSFlbZOMkqapSX6YdOVPoqVrDCQPNeKZlct0d+m7D40YXhZygYTkibBGJnF7WgMHQvDI1RfmrvcwIVJDSpsf5oEth5Jde1C/8crAnAGSt54jBufo65wDuDQ3e6seZ99ygugxzrflSYfwuQY33oIttgPcVIt3hgRmtK6MFkuWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJSSkU/s; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-7bdf83185bbso66621037b3.2
        for <netdev@vger.kernel.org>; Thu, 21 May 2026 21:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779424477; x=1780029277; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=O1xzaqBhMDGVGNZbdTTocwyFc9fa0Vk+PAieH/4U9sc=;
        b=KJSSkU/sJdzUA6XFDnxR2o6XaKL0EOQwDAsjkVYS4mBkFjjU2xmeXNgfzRsNZDUCYm
         SKNmHNGKL/0IJ9lzFebXWk/RP81ZRUPNeQlUUPMPab95477Ztkg5Vthv9F9UmVOKFG+A
         mSR1Fm1n4fmYbSO8eO+uXPHxigDY4Mc5TUFtLwc9Ec+ew0vn0B737TjzC9Ljry8Zsgsp
         aRiM5twIQJuHeqsnUiloCGiAZQK4Q89KvuyNmM+o1a7zPY/EK+WmDwaKHlBKvnddr7oP
         04J0yQnlCiEshbISo6RvOsmHNVrG6WqWMlBDEki3bLoNB3CebNOA0tjjXS9kXk1MUzga
         0AYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779424477; x=1780029277;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1xzaqBhMDGVGNZbdTTocwyFc9fa0Vk+PAieH/4U9sc=;
        b=fs0jbulVPQ2ln5kbDHsg7KcIxXijFipGPIh+YdtBELd3ubzG9bORujj7qqiMrWANdG
         GhwauuQN56W1gxYvIgk/FNruoKAmV6W+cOaSKhZh9TQlFd8QfGJxcMQ7U8sbz102vkgv
         QR1P5XSmP30iw/ruBvl/1Cuoh6vVHG+h/s1ahuTzXGyqW4khmF8DJIPWuCfmLAfU4wZg
         fQYZ7VYmGN33iEFgoYpmztujn1oGWkx6Xrt1ZJ3kg9LFS2+QppHkEq88dQMtVSvkSc9U
         KTPmW2v7GCl5/9Ev0R2PjFjE191CadYToCWrkFetOascRDteJwVF/+8Gzbe4lQgYqzVl
         fDtQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1OT2+KioMceiMbvcW/h6ZALBumn5dE0Sgl3LefQQ+m5ckHeIO2q3ceNDN4orbZV0eUEYg6b4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJxQgXZqFe2KoTmxnvEeJEBD+n47v2ZBtKtIzsYGIBjbMALmkj
	DhvAdUuKZbr0UUKSzja7YqfVLlmSmLplN6L8J1lvB3WhFkX3NzH8gYMu
X-Gm-Gg: Acq92OHVkq4w3jmrizrpMOy4OBa49A1y31FTzmI+Xp27bPkIRtzpCx6Ul6FJSoZBbhR
	GfRY38SeQJsw/ZEGzPmOSpup/n1IAE5Nopyhty1V+PMgWJg4IsfUIiw+gYvyKx707OQ0ACr7lCg
	255RD5rz3/Ws/LUVqAEmGO01jqF/v+3Pv20FL+2nAk6pTrzmjANLMfNCjJUzG5ba86SOXaFxNS2
	yKfIK7Y0riOODK4pcE84XDrePtRL60FaVQ7MuyF1Xoz9KTXdkMGP2BOK/WfNfs2F/jSLINostbd
	GC0JrbaZG05zQQ07Pp4xJ50mYYoAx4Kf/fp+U8AyVszEZN1d4f/yzE9OMql2HAXvTxOZoi0Dz7g
	Ylx3AP+WWCWgqKud0Av4y0PYTKi8iN8ZGHF+hh89T8qHBMVtelBIRC26Dj/v45078h2Zt0q6ehe
	hxYDMjt+jIk7KUXfs2Cczr5MoNQSildR084mMd2B2u1pRnW5qrSEzJ
X-Received: by 2002:a05:690c:4a05:b0:7d0:5148:98eb with SMTP id 00721157ae682-7d337daf7a5mr24236757b3.4.1779424476861;
        Thu, 21 May 2026 21:34:36 -0700 (PDT)
Received: from hoboy.vegasvil.org ([2600:1700:2430:6f6f:e2d5:5eff:fea5:802f])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c73ff33sm3491447b3.45.2026.05.21.21.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 May 2026 21:34:35 -0700 (PDT)
Date: Thu, 21 May 2026 21:34:25 -0700
From: Richard Cochran <richardcochran@gmail.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	Harshitha Ramamurthy <hramamurthy@google.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Miroslav Lichvar <mlichvar@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Wen Gu <guwen@linux.alibaba.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	David Woodhouse <dwmw@amazon.com>,
	Yonatan Sarna <ysarna@amazon.com>,
	Zorik Machulsky <zorik@amazon.com>,
	Alexander Matushevsky <matua@amazon.com>,
	Saeed Bshara <saeedb@amazon.com>, Matt Wilson <msw@amazon.com>,
	Anthony Liguori <aliguori@amazon.com>,
	Nafea Bshara <nafea@amazon.com>,
	Evgeny Schmeilin <evgenys@amazon.com>,
	Netanel Belgazal <netanel@amazon.com>,
	Ali Saidi <alisaidi@amazon.com>,
	Benjamin Herrenschmidt <benh@amazon.com>,
	Noam Dagan <ndagan@amazon.com>, David Arinzon <darinzon@amazon.com>,
	Evgeny Ostrovsky <evostrov@amazon.com>,
	Ofir Tabachnik <ofirt@amazon.com>,
	Amit Bernstein <amitbern@amazon.com>,
	linux-kselftest@vger.kernel.org, shuah@kernel.org,
	vadim.fedorenko@linux.dev
Subject: Re: [PATCH v3 net-next 0/7] ptp: Add PHC timestamp quality attributes
Message-ID: <ag_c0b0lobeALpFa@hoboy.vegasvil.org>
References: <20260515164033.6403-1-akiyano@amazon.com>
 <20260518182646.2d1337d4@kernel.org>
 <177921463623.22936.15326822041328476600.b4-reply@b4>
 <20260519163351.61b746d0@kernel.org>
 <3685358a639c27a0f0b0ccfe2969c0cfa34cc392.camel@infradead.org>
 <b1c605ae-32ae-42ce-8890-2b32c9945c2e@redhat.com>
 <00c8f25006531726571836a9b2d4ded9227c27d2.camel@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <00c8f25006531726571836a9b2d4ded9227c27d2.camel@infradead.org>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-290663-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[33];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[richardcochran@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: A430C5AEB24
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 02:09:55PM +0100, David Woodhouse wrote:
> 
> Ideally, yes. Although I think we *have* addressed that by implementing
> it for more than one backend driver, which Richard already said "would
> be more compelling" in  
> 
> https://lore.kernel.org/all/aIhGJ9BzR1wY7ij_@hoboy.vegasvil.org

Yes, if the API supports multiple devices, then that is an argument.

Thanks,
Richard



