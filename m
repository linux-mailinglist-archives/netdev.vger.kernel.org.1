Return-Path: <netdev+bounces-44217-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 652F17D71D3
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 18:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F3C00B2105F
	for <lists+netdev@lfdr.de>; Wed, 25 Oct 2023 16:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3E921A14;
	Wed, 25 Oct 2023 16:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Iy83hJrX"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128401A27D
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 16:41:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50868137
	for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 09:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698252070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=45p4m02wDHtfK/5rEeQxDQTRj1TqzHPqRAnek6DIdIw=;
	b=Iy83hJrXQ+8F504VItQlACMRp9INDoe2VCG1cCEJHYxxfWqG2AqocRO+EMcp1pab/8hpBA
	pbzv8cK+3Us/WF7yyHMzqeIpLY/1s0vRMTBUMlMZ12enbqZMxdo9c3dXBBEba98jFlxwXf
	S5bSuig+r6+wZbjMBS+Z63f0mRwPWfg=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-YiXM7AGzNbGvRCdJUKPdFw-1; Wed, 25 Oct 2023 12:41:08 -0400
X-MC-Unique: YiXM7AGzNbGvRCdJUKPdFw-1
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-6befc6bbc23so696972b3a.1
        for <netdev@vger.kernel.org>; Wed, 25 Oct 2023 09:41:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698252066; x=1698856866;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=45p4m02wDHtfK/5rEeQxDQTRj1TqzHPqRAnek6DIdIw=;
        b=kLSgkzVuAIUBr/GbZGw3/6uiQwByzcNv3m8Q6ePcEKXezTY5EtTBhqh2iy6EKAtCLq
         1Grb7+Qw+eMFlJLw1m2dQaY2YA5msA8QhNj44xc5oBR+mfzG4gRHlnf6tvqEF3JdU/l4
         U9YYeln7sE8o5OBHJ6sh5Z4BuOO4R2c3y13CoECjYUoLIYgj3KFW0ATC4/uMSBEzVQqp
         KjSufxO85aNEGFUYEXGihlE0KFCJNDbMJiIdyo7NNjRJ//ZgokdhhoexclYPC9Q7ZZLr
         1AZJpIP0nBeyrlZ7E54iOEHScRQlJM2mzHTgWAwNsC55z4s019nabjgQGBeNcfvIuckl
         dRIg==
X-Gm-Message-State: AOJu0YyFBNHETUwyDzJjJIIavrDkDvUspee7UrM690uUTztb9SJI0BHl
	AqghEN6HNgnki+e8a3j/u4gagVVhNm6sepwEQoorh3/XzlaoOvaUnTLp5UdsWQxFChUokbMYWGC
	Hbt9XSQutPwJN9VtcCrn6R77ecsYd0iiIhnkex9ea
X-Received: by 2002:a05:6a20:8f1a:b0:17b:a34d:5b56 with SMTP id b26-20020a056a208f1a00b0017ba34d5b56mr193003pzk.19.1698252065844;
        Wed, 25 Oct 2023 09:41:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSMFtLZF6hT2B6SagLd1tIs/d8nGPwGyqXWu2J7MgBFAHiktU0p9lRUP2Jys/EDmwvtCDM7p7RBF0in80bIiM=
X-Received: by 2002:a05:6a20:8f1a:b0:17b:a34d:5b56 with SMTP id
 b26-20020a056a208f1a00b0017ba34d5b56mr192979pzk.19.1698252065453; Wed, 25 Oct
 2023 09:41:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231023-send-net-next-20231023-1-v2-0-16b1f701f900@kernel.org>
 <20231023-send-net-next-20231023-1-v2-5-16b1f701f900@kernel.org>
 <20231024125956.341ef4ef@kernel.org> <a29b6917-d578-35c4-978d-d57a3bccd63f@kernel.org>
 <20231024164936.41ae6f3c@kernel.org>
In-Reply-To: <20231024164936.41ae6f3c@kernel.org>
From: Davide Caratti <dcaratti@redhat.com>
Date: Wed, 25 Oct 2023 18:40:52 +0200
Message-ID: <CAKa-r6vCj+gPEUKpv7AsXqM77N6pB0evuh7myHq=585RA3oD5g@mail.gmail.com>
Subject: Re: [PATCH net-next v2 5/7] uapi: mptcp: use header file generated
 from YAML spec
To: Jakub Kicinski <kuba@kernel.org>
Cc: Mat Martineau <martineau@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Matthieu Baerts <matttbe@kernel.org>, netdev@vger.kernel.org, mptcp@lists.linux.dev, 
	Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

hello,

thanks for looking at this.

On Tue, Oct 24, 2023 at 10:00=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> > On Mon, 23 Oct 2023 11:17:09 -0700 Mat Martineau wrote:
> >> +/* for backward compatibility */
> >> +#define     __MPTCP_PM_CMD_AFTER_LAST       __MPTCP_PM_CMD_MAX
> >> +#define     __MPTCP_ATTR_AFTER_LAST         __MPTCP_ATTR_MAX
> >
> > Do you want to intentionally move to the normal naming or would you
> > prefer to keep the old names?

given that nobody should use them, I'd prefer to move to the normal
naming and drop the old definitions (_MPTCP_PM_CMD_AFTER_LAST and
__MPTCP_ATTR_AFTER_LAST). I was unsure if I could do the drop thing
actually, because applications using them would break the build then _
hence these two "backward compatibility" lines.

For the operation list, I see it's about exposing

cmd-cnt-name

to [ge]netlink*.yaml, and then do:

  9 max-by-define: true
 10 kernel-policy: per-op
 11 cmd-cnt-name: --mptcp-pm-cmd-after-last    <-- this
 12
 13 definitions:

the generated MPTCP #define(s) are the same as the ones we have in
net-next now: no need to specify __MPTCP_PM_CMD_MAX anymore.

For the attributes, I thought I could use  'attr-cnt-name' like:

169     name: attr
170     name-prefix: mptcp-pm-attr-
171     attr-cnt-name: --mptcp-attr-after-last <-- this
172     attributes:

as described in the [ge]netlink schema, but the tool seems to just ignore i=
t.
--=20
davide





On Wed, Oct 25, 2023 at 1:49=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue, 24 Oct 2023 16:30:27 -0700 (PDT) Mat Martineau wrote:
> > I'm not sure if you're offering to add the feature or are asking us (we=
ll,
> > Davide) to implement it :)
>
> Either way is fine, Davide seems to have tackled the extensions in patche=
s
> 1 and 2, so he may want to do it himself. Otherwise I'm more than happy
> to type and send the patch :)
>

> Let's make sure we update documentation, tho, in this case:
> Documentation/userspace-api/netlink/c-code-gen.rst
>


