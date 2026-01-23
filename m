Return-Path: <netdev+bounces-252931-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGFBJhjHc2lZygAAu9opvQ
	(envelope-from <netdev+bounces-252931-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:08:08 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 070B37A041
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 20:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5AF6E301C587
	for <lists+netdev@lfdr.de>; Fri, 23 Jan 2026 19:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC87421FF4D;
	Fri, 23 Jan 2026 19:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="fxOOn2sc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B7420E025
	for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 19:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769195139; cv=pass; b=rF1R9fryeG0rDcVDt/OmwEyMPiotGTNQKHmUW/uC3tYVet4Vyb+NGnKlLKFheYF168+aNwNZTEGrStuiMPaX+YlpjoD2xWGL/UnXPNJdztDF3sPtQMPnq/Vu53WnQSEO70JjoAhwxmy8c7kli4IEbMgfX+OXeQVf+0k767ryoAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769195139; c=relaxed/simple;
	bh=u9MAWqid1f/shlaHElTBFBNNYcjOlWRJvAsOCiwEZRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lKJj628C6XzIdij5YodAmtQYa4RkHdQ+ZLQ5ZdI4egL2oDXRgTXsLiQ3/md+lTp9I3TQ76PT9ASAy/QaIWlaqG9tosfLtfwb82OHqSB9eNU4ZHA1CLl4mabMMrCi8YtMRqkQRtEpuRRs3bNQJ+jriOr50TCqbvkeJSm9XO+kElA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=fxOOn2sc; arc=pass smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-948029fb1f2so676220241.0
        for <netdev@vger.kernel.org>; Fri, 23 Jan 2026 11:05:38 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769195137; cv=none;
        d=google.com; s=arc-20240605;
        b=MbAbh/4dozX5z3RCxM4N+XLBrPU4npA/O67EKuiD176Wu5KHdM77l39/nUryE6HMZ2
         uLUs9RjtCge/QEI/OZ4h89o5+wwSVO9xK3QYd0x21sMDB6PoukJF3ZVfonuXXJQGP4Ty
         LpqbBVkj+/Gx4bolaOxcAXxeeUPIueRVc1IV1uzkjKUmVn3/ApTbLDkDBjAatS7QI7dD
         1NNmmc7PdhmtHX+iJITBB0arPKSCHf7QysTlg3yu/4+xIKbni9gjbhBrxuflM3OvA5+m
         8QwE3aEEsgt0qWB5rDr+M1jnRRFjtdCMMPAJIv2L07BJBtm+Z8o1UZVOd0NYi2H4t7b+
         oamw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=u9MAWqid1f/shlaHElTBFBNNYcjOlWRJvAsOCiwEZRs=;
        fh=S+f6avFf+T3+/lD7i7470lZiUwELamk31lmm9MUv4nw=;
        b=j8PRutJPIMarmE6XHptsJmEQ1XdLXwdXGwXH1hf8Ggw9tq3lDIVJG6m2gTwd/IfHsq
         jv3wHADjMUzY6Yu3WOezqoJZrfHDdyl7w4K2S2UZi7MXCmat4bmwh07MzbQc8bVRCj9M
         ypehx4zA/9ynoZULAwwiCYLFttPjEpo/MmDCAhHGl29QNYIdVwa+nZ6l48Xn6ITZD+Va
         ZVM6p8i8R66DG6y/iGd5xNxMb4wnO+k5jkF81HUVxPDs/EdkM/ufjwTplZ5Tw1HmDAdX
         grtq7PuvtKX91qgK1rfrey0ncPoDtUqs6u0ncmcKaBQN9G5lal1/MeKbcHseXKrXvMWO
         Dwrw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769195137; x=1769799937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u9MAWqid1f/shlaHElTBFBNNYcjOlWRJvAsOCiwEZRs=;
        b=fxOOn2sciY6EzJ5Y4vfbarUnPGMO0Hpg0gRNrxkjjFztz59qJcEg1tlEQxNtSf9CS1
         Q3/kVgIx9NsqO0VS17iMcePEGTWs7ewD1aGJyKg9Lfszw74pD3p1Be63jo3DVSaogoTI
         zT4PL+vqYweGQdkscbmLJSU7wY7doJ3i4jhND5Ycd28FeyyYJ7xwWKjV1MS+4ogNIm+1
         x6N7NcA2zaA3xaO2MBRe3C60f94AXCaOhTWisjoz1fZsl1yPrqPrQr/jGFMVgl51oR2Z
         GTExpEAzpRua1W9jqhtXO4LerkdMASd7RATsRkPovmMRvSnbO8R72QfTnnCsvsjeQp0t
         OwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769195137; x=1769799937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u9MAWqid1f/shlaHElTBFBNNYcjOlWRJvAsOCiwEZRs=;
        b=IdVKw87e/yTrsmrWADymuTUX9BBJM5KxuLp8clEKsAs7ai21VtUPobrvr4ej30DO6A
         gQda3olR0kZzC3Xksmx9ktG/2hbpwfK9CFREn4e839KGdK7BCqybnIH1cUIvJxmKyKqb
         Yqms6XhBllzo/B96Ley0UYJNMggB2qTU7lc+XwFSf2MnrwjeS4du2+ioEO6I4yShfp4A
         ECAcL81/65GdDeME57iQCzAAerHMBWsurLIiQdlTJMTZhBJlaRJ+WFqe1VIMIdlnKIM1
         c7GfNSUxrGtpGIkW5R/hOipWzLZt5PjQp9l1J8m4s+fhXmsAiS10udVQ6/6lIJGZKW9d
         9dug==
X-Gm-Message-State: AOJu0YxbekRygNo3YykFCgRVWx9VCzXlbVtZaiOD0BWQHOihGA/bOTiA
	/tY0DiaP3IJYWmj6SYJcuyFq1H2ygINU05/50oBRoqsrEwsRBqUIhRrWcLFriog6x9yJasrVtdY
	L2loRCvoNKlo5vSESC2Xj4RbIeSEw9W+1+UuD5vz2JQ==
X-Gm-Gg: AZuq6aJdq1lkjTNm7yDNIyhLpiVDIE2JFVFny0hq/Pr0v3gKp9MRFrOSEWjSsCQhyiv
	MO1X2CDhypNp3FbWs6lKlXAIigOzad2r+gAMo6mFipc+E4E1oCfx1m0YpyMPMiIEE2vfzTVugzc
	EGqI8UmG8Qnj1gjyrtJaJGrIblsngVk1CKuvYRLfy/MqF43Ni/E8Ipa0qjRhtMUsfjmjM9ziHH9
	mqZcKnn5qpxmFQiA8czyrOXa81XfCs6NIrCMgP5x7LreKtl+GP66cNqdA/EdfJSEddkT0E=
X-Received: by 2002:a05:6102:a50:b0:5f5:3719:19d8 with SMTP id
 ada2fe7eead31-5f54bcb605amr1188883137.31.1769195137058; Fri, 23 Jan 2026
 11:05:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260121215727.3994324-1-rjethwani@purestorage.com>
 <58fe1908-48de-4bca-ad4e-4976d24581e6@gmail.com> <CAKaoeS2Jnaekdx2dXfBV91LhbaLU6SenBRkNqmRB3-1EhSCbYg@mail.gmail.com>
In-Reply-To: <CAKaoeS2Jnaekdx2dXfBV91LhbaLU6SenBRkNqmRB3-1EhSCbYg@mail.gmail.com>
From: Rishikesh Jethwani <rjethwani@purestorage.com>
Date: Fri, 23 Jan 2026 11:05:26 -0800
X-Gm-Features: AZwV_QiRr5r4R7H_61hkgQ1WUn8yedOXhFMqUWAR6ANTTs9J3O5CplioWDTOqLI
Message-ID: <CAKaoeS1Ykr9E0URiasMy9j0Jw6R7AbXLbSgMV=KHyfrCakp48w@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] tls: Add TLS 1.3 hardware offload support
To: Tariq Toukan <ttoukan.linux@gmail.com>
Cc: netdev@vger.kernel.org, saeedm@nvidia.com, tariqt@nvidia.com, 
	mbloch@nvidia.com, borisp@nvidia.com, john.fastabend@gmail.com, 
	kuba@kernel.org, sd@queasysnail.net, davem@davemloft.net, pabeni@redhat.com, 
	edumazet@google.com, leon@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[purestorage.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[purestorage.com:s=google2022];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-252931-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[purestorage.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rjethwani@purestorage.com,netdev@vger.kernel.org];
	FREEMAIL_CC(0.00)[vger.kernel.org,nvidia.com,gmail.com,kernel.org,queasysnail.net,davemloft.net,redhat.com,google.com];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,purestorage.com:email,purestorage.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 070B37A041
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 11:22=E2=80=AFAM Rishikesh Jethwani
<rjethwani@purestorage.com> wrote:
>
> > Hi Rishikesh,
> >
> > This version doesn't compile for us.
> > A few comments that we wanted to share on V3, but I'll share here as
> > this is the latest:
> >
> > We tested V3 and a few issues were spotted.
> > We did not debug them though...
> >
> > We run a server/client test with nginx and wrk.
> >
> > a.
> > When requesting 128-bit key, ss output shows "cipher: aes-gcm-256" for
> > the respective connection.
> > For TLS 1.2 it works fine.
> >
> > b.
> > On the wrk side, the mlx5 rx_tls_ctx did not increase (meaning no
> > offloaded connections were opened). It works fine on the nginx side
> > however...
> > For TLS 1.2 it works fine.
> >
> > We can share more info if needed.
> >
> > Regards,
> > Tariq
> >
> Hi Tariq,
>
> I have fixed the typo leading to compile errors in V5.
> Could you please share more info. about the setup and test, so that I
> can try to reproduce the issue?
>
> Thanks,
> Rishikesh

HI Tariq,

Did you run SW TLS 1.3 in your environment?

