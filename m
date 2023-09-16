Return-Path: <netdev+bounces-34255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7AAA7A2ED5
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 10:27:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8B341C209D4
	for <lists+netdev@lfdr.de>; Sat, 16 Sep 2023 08:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258B8111A1;
	Sat, 16 Sep 2023 08:27:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB2461FA3
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 08:27:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id DA79819AE
	for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 01:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694852840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xk07fBKmYtVdjfq/YbeUvoBCkb4c4JI3bYtw/NeUM+M=;
	b=b+KwQL+SUs2dYLPan8iQT6eIB063gvv+O15k8VgexuOJZ7AzHqApYdRrJ9lbChd4tHMn4g
	auCZJI8LvmxTIc7oTRjZ4Wx6eLszuLR7WsExF7oA0fgNhmMlYEWYPNFr7WP/s/sGPvcTqO
	knFW8Gj99z8R8bqrYDInJF4GdOALVAM=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-9cbn1GZ5Oy2zDr0KLnX5QA-1; Sat, 16 Sep 2023 04:27:16 -0400
X-MC-Unique: 9cbn1GZ5Oy2zDr0KLnX5QA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9adcb9ecc16so35060766b.0
        for <netdev@vger.kernel.org>; Sat, 16 Sep 2023 01:27:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694852835; x=1695457635;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xk07fBKmYtVdjfq/YbeUvoBCkb4c4JI3bYtw/NeUM+M=;
        b=a9xfl4g1FCdqDvortukjBHZ2QwZQ2c6r6EfjxPoRhqDRao2yqlbws5y81WtObq2/Al
         44b5Z9Q5RQEhZi8i6lOAhi+dvea9PsIG3389mUh4v+KPYlYQVQW5b3PjyMiOW4l2+p1j
         Cu3I1Kd5TEsodH5UDfOFXq1UE52y9FOdH/DfZSHYg5EQcn/pYrNcElJ4ZWGAI32nu1zw
         m9jjl+VZzaU7SsNVxvkfHKC4RXNbna52XxUoli7WjCFEQ9yhR9uFjjqNDS5a03V4nj7t
         kPTrXPx13VmGHH/NOjAEhwqfsdvalhovp5xXsqNPLw7I0YvkrHfOV6BWsFgNn1GpojYV
         Nb/w==
X-Gm-Message-State: AOJu0Yz7nu4mJ3burnMYlj96iVVFHOJYkRBj1W5LJX7kOZG3yEvOIy7v
	j2VgalVyCyEQTDt1MUgAWfEVEo41QSy7FaZS+sctRd+SPFOvAQma52bJIJ+PX9nSZblDJbRBMuQ
	DQPR3HVLjzkTVbQwr
X-Received: by 2002:a05:6402:40ca:b0:52f:bedf:8eea with SMTP id z10-20020a05640240ca00b0052fbedf8eeamr3139593edb.3.1694852835806;
        Sat, 16 Sep 2023 01:27:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHblJdE5s5EXInkymj4GKBO3QFfY17OBBsieQVpuYrD9NYx7HCuR+rTvZmmq6fLWdAEpF86Zw==
X-Received: by 2002:a05:6402:40ca:b0:52f:bedf:8eea with SMTP id z10-20020a05640240ca00b0052fbedf8eeamr3139585edb.3.1694852835508;
        Sat, 16 Sep 2023 01:27:15 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-149.dyn.eolo.it. [146.241.247.149])
        by smtp.gmail.com with ESMTPSA id x26-20020aa7dada000000b005224f840130sm3182970eds.60.2023.09.16.01.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 01:27:15 -0700 (PDT)
Message-ID: <8a62f57a9454b0592ab82248fca5a21fc963995b.camel@redhat.com>
Subject: Re: Urgent Bug Report Kernel crash 6.5.2
From: Paolo Abeni <pabeni@redhat.com>
To: Martin Zaharinov <micron10@gmail.com>, netdev <netdev@vger.kernel.org>
Cc: Eric Dumazet <edumazet@google.com>, patchwork-bot+netdevbpf@kernel.org, 
	Jakub Kicinski
	 <kuba@kernel.org>, Stephen Hemminger <stephen@networkplumber.org>, 
	kuba+netdrv@kernel.org, dsahern@gmail.com
Date: Sat, 16 Sep 2023 10:27:13 +0200
In-Reply-To: <67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
References: <64CCB695-BA43-48F5-912A-AFD5B9C103A7@gmail.com>
	 <51294220-A244-46A9-A5B8-34819CE30CF4@gmail.com>
	 <67303CFE-1938-4510-B9AE-5038BF98ABB7@gmail.com>
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
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sat, 2023-09-16 at 02:11 +0300, Martin Zaharinov wrote:
> one more log:
>=20
> Sep 12 07:37:29  [151563.298466][    C5] ------------[ cut here ]--------=
----
> Sep 12 07:37:29  [151563.298550][    C5] rcuref - imbalanced put()
> Sep 12 07:37:29  [151563.298564][ C5] WARNING: CPU: 5 PID: 0 at lib/rcure=
f.c:267 rcuref_put_slowpath (lib/rcuref.c:267 (discriminator 1))
> Sep 12 07:37:29  [151563.298724][    C5] Modules linked in: nft_limit nf_=
conntrack_netlink vlan_mon(O) pppoe pppox ppp_generic slhc nft_ct nft_nat n=
ft_chain_nat nf_tables netconsole coretemp bonding i40e nf_nat_sip nf_connt=
rack_sip nf_nat_pptp nf_conntrack_pptp nf_nat_tftp nf_conntrack_tftp nf_nat=
_ftp nf_conntrack_ftp nf_nat nf_conntrack nf_defrag_ipv6 nf_defrag_ipv4 nf_=
xnatlog(O) ipmi_si ipmi_devintf ipmi_msghandler rtc_cmos [last unloaded: BN=
GBOOT(O)]
> Sep 12 07:37:29  [151563.298894][    C5] CPU: 5 PID: 0 Comm: swapper/5 Ta=
inted: G           O       6.5.2 #1


You have out-of-tree modules taint in all the report you shared. Please
try to reproduce the issue with such taint, thanks!

Paolo


