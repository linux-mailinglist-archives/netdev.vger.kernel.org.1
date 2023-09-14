Return-Path: <netdev+bounces-33766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB22A79FF99
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 11:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B03761C20F5F
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 09:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05009224D6;
	Thu, 14 Sep 2023 09:02:14 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CD9224C1
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 09:02:13 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 504DA273C
	for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 02:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694682131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X+KrfCRQOSDoCpzIg+ySZtUE96Wfxy7L1xyvCEyDaNU=;
	b=OBZWBaAm43szTGyEiA9xLNkA/P8fcGcIOzVqTgBksBEBq0fpDUNAlsk0cIZ1X15U4TI55g
	75pkfhy8w/Wb8dR+SiT8mrQmx44sutEmr/66/Ef/op+ywuoigya+ZuCROOoXeIOrJiG7mJ
	Kh2xMfkcZ9Pz3huYhLeIs713Bw9qC4c=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423--_G2gUzcP0CdoPeUci-s_g-1; Thu, 14 Sep 2023 05:02:09 -0400
X-MC-Unique: -_G2gUzcP0CdoPeUci-s_g-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2b6fdb8d0acso1752731fa.0
        for <netdev@vger.kernel.org>; Thu, 14 Sep 2023 02:02:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694682128; x=1695286928;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X+KrfCRQOSDoCpzIg+ySZtUE96Wfxy7L1xyvCEyDaNU=;
        b=HGbF0N6SW5+t7hPMhjUUkOQCs6bmTSJ9p3eFuZ2WOeFr7cLngfTfYFY1VAh3tfDUYH
         b5y2oOOkCh+cYFrOYW9AnA7mjx4b0ckf7dVWdrrZiQc8Qh4IcYTTJe/jnJ4AdxJx27ij
         DRhBo13ojGzLN72kCjHWg9jRCGemHx58QQ4Yb0twtFjF/8qTZdqT26BzMTZa3EcMfhXZ
         gFo6/vq9MR+Ls32pCNmiJtGKGBMlxZ5k0cRjNH+1PeNnoniwfXXPufU+mlKMZwndfeEk
         nvAod29dSxvQ42IcSMhhQBcd2MO0fXgDQl6kbRg+s3Se7Ym6WxEL+8QZYpzPHm8Gnyh7
         BJzg==
X-Gm-Message-State: AOJu0Yy9QhJ9MgyS27asEl56OkDY9h1uetCEGc21KMTDufwLp6BYODIP
	M0/2JeDn6S1nct1YvoJnC4+q1xD4e4715QnaeJz8Sy8XH6+kHOg/+L+9G1s9tMYTSdcavM7/uvY
	qOrNEo+QAPVEM+kmZlBf396kp
X-Received: by 2002:a2e:bc04:0:b0:2be:5485:4a99 with SMTP id b4-20020a2ebc04000000b002be54854a99mr5547030ljf.4.1694682128040;
        Thu, 14 Sep 2023 02:02:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHL/9CxB4g4lGXRRBpzJ6bDAKaKj9cK9bz/6vsn9YXxXcUCeDIGZwHdqG85hARLd/np+0s9Zg==
X-Received: by 2002:a2e:bc04:0:b0:2be:5485:4a99 with SMTP id b4-20020a2ebc04000000b002be54854a99mr5547007ljf.4.1694682127701;
        Thu, 14 Sep 2023 02:02:07 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-242-187.dyn.eolo.it. [146.241.242.187])
        by smtp.gmail.com with ESMTPSA id o2-20020a1709062e8200b009ad8338aafasm717611eji.13.2023.09.14.02.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 02:02:06 -0700 (PDT)
Message-ID: <e3ed5c1e03d14dabb073bbb6d56f0fb825e770a4.camel@redhat.com>
Subject: Re: [PATCH net-next 2/2] tcp: new TCP_INFO stats for RTO events
From: Paolo Abeni <pabeni@redhat.com>
To: Aananth V <aananthv@google.com>, David Miller <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Neal Cardwell <ncardwell@google.com>, Yuchung
 Cheng <ycheng@google.com>
Date: Thu, 14 Sep 2023 11:02:05 +0200
In-Reply-To: <20230912023309.3013660-3-aananthv@google.com>
References: <20230912023309.3013660-1-aananthv@google.com>
	 <20230912023309.3013660-3-aananthv@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

On Tue, 2023-09-12 at 02:33 +0000, Aananth V wrote:
> @@ -2825,6 +2829,14 @@ void tcp_enter_recovery(struct sock *sk, bool ece_=
ack)
>  	tcp_set_ca_state(sk, TCP_CA_Recovery);
>  }
> =20
> +static inline void tcp_update_rto_time(struct tcp_sock *tp)
> +{
> +	if (tp->rto_stamp) {
> +		tp->total_rto_time +=3D tcp_time_stamp(tp) - tp->rto_stamp;
> +		tp->rto_stamp =3D 0;
> +	}
> +}

The CI is complaining about 'inline' function in .c file. I guess that
is not by accident and the goal is to maximize fast-path performances?

Perhaps worthy moving the function to an header file to make static
checkers happy?

Thanks!

Paolo


