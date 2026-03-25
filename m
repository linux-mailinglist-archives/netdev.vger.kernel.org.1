Return-Path: <netdev+bounces-271672-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBHCI7IcxGnlwQQAu9opvQ
	(envelope-from <netdev+bounces-271672-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:34:42 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EC52B329E78
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 18:34:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6AD49302BDC4
	for <lists+netdev@lfdr.de>; Wed, 25 Mar 2026 17:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6FA7402440;
	Wed, 25 Mar 2026 17:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rp7+E8kC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C8A73FBED4
	for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 17:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774459714; cv=pass; b=iGblO+INeeoIUpa12Z1QufkgphQASd+DCBk3iMuiVxw0mg5MO1KGA46NUGCeyEMZTYrWEWiOqunpRh1WPWdEvgzWF4hmScHmdbyHAPBBfzuFDBY/bJOgkFS4czNwUcc2dVNHuafO5KqCMcw+boumefxJWcpJu7Zv3JC+WHn9BG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774459714; c=relaxed/simple;
	bh=Rp8fxQCLwFBn0xp4OYUEop/+U+Xl4C79lXLfMQ92/H0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GBQ7IOXK1yP/3XxRUguAvMnjsOn9YXEelRUBI/NwT6HFiFmkOCKQotk8XT/UfI+HbYCG+N7klEaW92CFORKHv7Sl27zFVTwRDsU+jRZ6a7/r386xpTW86jbw5yVr+mkHNhE2ecy7LRunsCcEogEOfOob0wN68PWyIa4A188fNn0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rp7+E8kC; arc=pass smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-50b2b2aa276so1435361cf.3
        for <netdev@vger.kernel.org>; Wed, 25 Mar 2026 10:28:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774459712; cv=none;
        d=google.com; s=arc-20240605;
        b=CYrNvB3TMQyw+bOWZKmqRwyUDZKPFMeskWyoa/tK2sB4OsoNJod1ltVQge+RCFdpsg
         y4hsBLjwWBpHbDwabjXIVzIM0m0rRC1aUEx1AlIqTvuXmNtez3oFbbWU8j3JYuFQxS6i
         sO/cfWCXiSq+/7k1bdtGwxM+2bmDSBRuwbM6mfbUiqWS9A5psFSvx8jMyT8iluu82Lqp
         9mCmBqADRVR5VL6e04/RB73lHNPqzMjpKQv6BG/PG7RbSv02N7cE2NTQa6IYAb9u1Y1s
         4V1taTZmuXmsQqMd9ZJljve66YXBLEuGIzYQPe7irNchabCbVfwroIQ/iek9TxjSJbPk
         qMvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Rp8fxQCLwFBn0xp4OYUEop/+U+Xl4C79lXLfMQ92/H0=;
        fh=G0iTag5MCh6XbgEOpJ/3eK4gF5QvAq6iom5OsZalZMc=;
        b=gn0VVX8TL3H2SO3cu9+nXDi29fhvw4KbddOPNH+d7IQ3PtC0av+FocRMPa15qcQvnA
         VXAkioumHLxJHIF8W5cRAsocIXpMCUn20IqsFxwgVdnco1o4WnPfiIP7k4w5PwfssvD6
         hRGrVdr1BAxmHox2dwAWFcFg5b99hzpcZUtslIB5wtkYl3atnCv6Z1+KG26ggepFl6Zv
         0kOK+nD1I/+MFyESpV/zD6xH6ig/pQAjbxuW+nZ4Ccs+Un8xq4i/xFD+d3q/MDWxwl0X
         SuIDf6G2o5K49t4tdBTtmaZYaLdL53kq3q3EVX+/x3ZaKoBAakY4ltt/QH1bEmO5eiBE
         L28w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774459712; x=1775064512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rp8fxQCLwFBn0xp4OYUEop/+U+Xl4C79lXLfMQ92/H0=;
        b=rp7+E8kCEuPUq0JBHlll9SFHWVtlbE8k4LeRN4BGvRGQJlWIkczw6mjh9E3omnNdc/
         1SB7u3dO5PKUuulKetzTkgjBgeIibALTZue7TjoobnTpyVbe3/0IVOlc6hpCSG1i0NIy
         YlzwmZAHSCri/2EcPE7IBcDdb2PXZtwfcfxCwQ+xZAGaoo+qKFF11DL31mMKavujMivY
         gseSA3PKRf2OrzHaN6AIzTWXCzt/h2pu267si7G5s/RoZr1Zv666wUU1WEF5MWP7DKhU
         TQNu090DonI+1JtC2LhNj5HwEK0Zg6dTy0ZWrCcpbNejcQGwmiyoNd4yJ+9KJ44NuHa9
         RwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774459712; x=1775064512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Rp8fxQCLwFBn0xp4OYUEop/+U+Xl4C79lXLfMQ92/H0=;
        b=hiLPFqoOEA8dBIxxW3uDbHsWeZJkytaguN6/TJ9ZrLi7VvR1717phnwqerwmSq5NEe
         jHkE2GKBGKi/bNuDiwpqh0zXlB1ASc7yarN1ZqCnC9hpTvBq+RgsSYfVW4WTpzrn2e01
         pNlb4XhCQ26fXRyL9wGmlo0cKnMmo86quazuutot6brmB5pguPaHOSRkPZ/sNx8dEdAn
         3lEcQwi+3h06TlFoQG5TO+eocA2x5QD1HL8WXOgScIeWgxc50c7hqaOMjGzP0+tPX6bI
         QQAmjVAYLuuj26x2sspH9Jlclc2c99NaF0Z0mG32qvzUuw4WUltDB4U5pwI+ZcWFqSz6
         x1EA==
X-Forwarded-Encrypted: i=1; AJvYcCWTmUh8eaA0dXnPufH3kDVtbAm3DR8VrOWBvI4b+DdZT/U9c1ec8oPUvai6lho7d6BP6Cn5HEU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZ9ANcTCEeRwJxTtwhEH+N0SEutL7dugSldeZjd/cRUDZfAp7n
	UaFidUHt+FavmQGbNRE6mxwqF61+XAMTmPQA/KEXqXiE+H0OLcvCci7qiKcibc3/ztnMnKjDchW
	acrJffasM4WCMd6EjSriEAGmoZhTc6T1S5aYEG/LC
X-Gm-Gg: ATEYQzzPYFe8vsYqqN0Lnx/8J5GM+MZDKOKY963XkzAnh/An6RG+20VXsQdObFKwbQk
	AYiBu4xFeP3u+ofylBL+NsapLdZ50WfgHGo2Mz9cC3kPAcPVIzVYGstLEL8910DgOXMXue0TdRy
	18g1UKe1ckwJxs4PsNRqr+9MVVYFuDGIdNq9Uk7mML/D3Ge5JpjKVBRIp5hj/UCULR9y0NElfxj
	BwdDGD3HAFsJqin8SmGvWBrdYwwT6My44Ujj4p7NogPhAwTNhUVMm4OLybGcBFch5u8ANvNiE2R
	murTZsS0hyibZwRRToGOdEUpmEYjSDguq4k=
X-Received: by 2002:a05:622a:1896:b0:50b:567a:e91a with SMTP id
 d75a77b69052e-50b80e0cfdcmr65591631cf.33.1774459711578; Wed, 25 Mar 2026
 10:28:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324205301.1361608-1-atwellwea@gmail.com> <acOVlten_N_5evGX@gandalf.schnuecks.de>
 <CANn89iLJJ3EF2-qe4AWJN0teh05x0PPJjOAfB0uG9rNZuJUZUg@mail.gmail.com> <CAN=sVvztL+bc2So8F9x50yQypyLEmEm5bWHzkXOOgdPFLG0MNg@mail.gmail.com>
In-Reply-To: <CAN=sVvztL+bc2So8F9x50yQypyLEmEm5bWHzkXOOgdPFLG0MNg@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 25 Mar 2026 10:28:19 -0700
X-Gm-Features: AaiRm50fdH06bEwfDDCcCnkrWJrbx95K5zRP_Pq7KPdPEhsnTZViwCSo52qmo54
Message-ID: <CANn89i+gDhN-Zo8=WaAuhWGhDG-00tAuzE5XpGsPT+pOESX-ug@mail.gmail.com>
Subject: Re: [PATCH net-next v3 0/3] tcp: fix scaled no-shrink rwnd
 quantization slack
To: Wesley Atwell <atwellwea@gmail.com>
Cc: Simon Baatz <gmbnomis@gmail.com>, netdev@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-271672-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,davemloft.net,kernel.org,redhat.com,google.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: EC52B329E78
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 25, 2026 at 10:18=E2=80=AFAM Wesley Atwell <atwellwea@gmail.com=
> wrote:
>
> Hi,
>
> I still think 2/3 is a legitimate fix. To clarify, I was not trying to
> claim that 84 is some magic number in the abstract, and I agree the
> packetdrill is artificial.
>
> My point was only that, in the constructed case, the old code can
> preserve a scaled window that is larger than the currently backed
> receive space, while 2/3 keeps the stored window representable in
> scaled units.
> That said, I am probably missing the reason why that is not a problem
> according to the feedback you all have given.
>
> So I am going to drop it here.
>
> To be clear this has nothing to do with social engineering, just was
> trying to fix something that doesn't need fixed I suppose.

We have limited time and many bugs to review.

Your series really lacks the signal explaining why it's needed and why
it's important.
What real workload suffers from the current behavior.

Thanks.

