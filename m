Return-Path: <netdev+bounces-18549-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCB5757960
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 12:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E24828154C
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 10:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4129A945;
	Tue, 18 Jul 2023 10:38:48 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4139253C8
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 10:38:48 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97B42E42
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689676726;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ri+et4ywDAN8ZXJ2KStRRUm2ZQOYAdc5QN6i4pH53Iw=;
	b=ef6oP3JjFKYIBOEiK8AvSUFFEiyx0EFTNEd9RWPzPOCIT7Mfmr2wssxUP2SbQPnt8IpFq5
	RbDdvSXcMB2uo+TdyegDVhtxwEhkh9RcrFru/nXaxRMJgVv4NU84mGxnJd7EP/bNVSZ+Ab
	B7LJY46/HuqBvj5d7UnPI4REKvCzhJ4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-nW4ksEYkOSeLYWlM9ejhwg-1; Tue, 18 Jul 2023 06:38:45 -0400
X-MC-Unique: nW4ksEYkOSeLYWlM9ejhwg-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-767d30ab094so129483285a.1
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 03:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689676725; x=1692268725;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ri+et4ywDAN8ZXJ2KStRRUm2ZQOYAdc5QN6i4pH53Iw=;
        b=Xpmt93wxG5ecnLZg/oI5NyFfEa0EzwkT3h9f8EcY7nMeJdmXKqIidq6yu5QsZ3Ey0Q
         KAqodZ8O7k+HG+qYRFN/TE+9yr45aYTCoqu4Erflh0ZT8zvChfyxaIG22Lgz/JSXc2QZ
         qUHcrNk+GzfxdrR6FuSLDLfT3n0tS42Wp74XM/Ckoxvo/JMrUSach7yyRjPLzIqwNeyz
         0ulOY0gX0FQkA9PpN/WQf6wZ7RN3cDTc2vJPnq1xFdmCy27DGe1KhfuzVO0v5d9ODj3s
         Kk8ZDbgTEIaaP4ZBUHA/xk2+c95Ce4w9G7f2+rrMDtbk7uSAj1r/qYtusMcGWeo1btM9
         BvVw==
X-Gm-Message-State: ABy/qLbD53VDM3MXa5/zE1W1DFvZUQqJ9r/z1NbrnWQiQs5mpXHFC884
	vd0cSwqVm0JxtAGyF12SNsvKXFx2UjVy6zkbZhsVngTgBEdoypN1pNfwvfCN6viuHteMm5aYqPz
	icAccYrc+67EBBfQB
X-Received: by 2002:a05:620a:4545:b0:766:3190:8052 with SMTP id u5-20020a05620a454500b0076631908052mr11372005qkp.0.1689676725073;
        Tue, 18 Jul 2023 03:38:45 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH/5DLe3m3riUG62H3ZnGUmsXLQ5/HEGW4WUF/Z3RFMjbgw73rI8Ewzi6W2FTgeXWyFsSaYqQ==
X-Received: by 2002:a05:620a:4545:b0:766:3190:8052 with SMTP id u5-20020a05620a454500b0076631908052mr11371998qkp.0.1689676724784;
        Tue, 18 Jul 2023 03:38:44 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-170.dyn.eolo.it. [146.241.226.170])
        by smtp.gmail.com with ESMTPSA id v14-20020ae9e30e000000b00767f6391ccesm472021qkf.135.2023.07.18.03.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 03:38:44 -0700 (PDT)
Message-ID: <6bff83026bba89cde7c8de594f459cde612937b3.camel@redhat.com>
Subject: Re: [PATCH v1 net 2/4] llc: Check netns in llc_estab_match() and
 llc_listener_match().
From: Paolo Abeni <pabeni@redhat.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>, "David S. Miller"
	 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	 <kuba@kernel.org>, Roopa Prabhu <roopa@nvidia.com>, Nikolay Aleksandrov
	 <razor@blackwall.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, Harry Coin
	 <hcoin@quietfountain.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, 
	netdev@vger.kernel.org
Date: Tue, 18 Jul 2023 12:38:41 +0200
In-Reply-To: <20230715021338.34747-3-kuniyu@amazon.com>
References: <20230715021338.34747-1-kuniyu@amazon.com>
	 <20230715021338.34747-3-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, 2023-07-14 at 19:13 -0700, Kuniyuki Iwashima wrote:
> @@ -476,7 +478,8 @@ static inline bool llc_estab_match(const struct llc_s=
ap *sap,
>   */
>  static struct sock *__llc_lookup_established(struct llc_sap *sap,
>  					     struct llc_addr *daddr,
> -					     struct llc_addr *laddr)
> +					     struct llc_addr *laddr,
> +					     const struct net *net)

You should add 'net' to the doxygen documentation.

>  {
>  	struct sock *rc;
>  	struct hlist_nulls_node *node;

[...]

> @@ -581,24 +588,26 @@ static struct sock *__llc_lookup_listener(struct ll=
c_sap *sap,
>   *	Caller has to make sure local_bh is disabled.
>   */
>  static struct sock *llc_lookup_listener(struct llc_sap *sap,
> -					struct llc_addr *laddr)
> +					struct llc_addr *laddr,
> +					const struct net *net)

Same here.

Thanks!

Paolo


