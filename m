Return-Path: <netdev+bounces-32010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 990D87920FE
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 10:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4591428101E
	for <lists+netdev@lfdr.de>; Tue,  5 Sep 2023 08:26:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C184431;
	Tue,  5 Sep 2023 08:26:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82520A38
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 08:26:33 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF6F6CCF
	for <netdev@vger.kernel.org>; Tue,  5 Sep 2023 01:26:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1693902389;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wr7DwURnCr/necd9JNHVzn6++72JC9JfYbJ7saAJJBg=;
	b=DEjqdna+rEzRuTjVb7DCC/Nyy0MakTmRBZVmAodaMRKd2tIZaVU7xHY3LkVW5idc5PVO7D
	/TP7rGi5SlSLCWryghslKlZqoCwE7hk9QfabaDiVcRuFcMOxaAqz7WVJAjOeJFDEeOaYIu
	on3Mj1kaBtPMkXNbRIMor8Nwr5vHkuw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-529-ANmzpFi4O0GUjHKoOfVNhg-1; Tue, 05 Sep 2023 04:26:28 -0400
X-MC-Unique: ANmzpFi4O0GUjHKoOfVNhg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-9a1aaaf6460so46468866b.1
        for <netdev@vger.kernel.org>; Tue, 05 Sep 2023 01:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693902387; x=1694507187;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wr7DwURnCr/necd9JNHVzn6++72JC9JfYbJ7saAJJBg=;
        b=GhYnt+eH0yqmm/Hw7phSKRgs4N+KwmUxrSEUQuUhBkmYt5pk4Rv3W3hsn5wMJG3MRs
         faCOYhXdx6IdeGZHaxrpNyS5susFHjMSKTKkSoU3rrnzSOc6vyyw4Y+62UHDSPC3zCJA
         1eN/EO//5FWD5cO8qKV3CxelE7iJP8xj3oVy8cpakj+PuBah5zT6RKliUyUUP5ag7V7u
         RyKFV1HO9vAm40D5XWR3OfhzfzzW3IZfB6jtqJRgl7kDBBTHAa7u+cCyXxeyP4Dxr6/p
         7fiqf7knKuK9fGKl0TrfMhW8F2phe8A92TpaGtJrhsSQxk+mNhIDDQIA+dWV+PO4z20l
         F31A==
X-Gm-Message-State: AOJu0Yww1rpdw5IRKgwfGBwTCqJCJCCHrHXrWw+n/rr7sgR8OighdqD2
	3FjMFn+BZEfkCZCnTG2NnMVLKJgGzO+7XyO+YBA0CbZUun3RKl6jAArpzopBNAdCySlvU7iFTKQ
	EWiWgs9MAmeN0F02Y
X-Received: by 2002:a17:906:109b:b0:9a1:c4ce:65b8 with SMTP id u27-20020a170906109b00b009a1c4ce65b8mr8489400eju.4.1693902387151;
        Tue, 05 Sep 2023 01:26:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEG+whJWY7ZKsZzIZ+azxlEM5vF1xXpWf5XsikJWrsPYr05TGyW5mgNt+gzuGt+4iSo+solTA==
X-Received: by 2002:a17:906:109b:b0:9a1:c4ce:65b8 with SMTP id u27-20020a170906109b00b009a1c4ce65b8mr8489388eju.4.1693902386790;
        Tue, 05 Sep 2023 01:26:26 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-254-194.dyn.eolo.it. [146.241.254.194])
        by smtp.gmail.com with ESMTPSA id cf20-20020a170906b2d400b00988dbbd1f7esm7210115ejb.213.2023.09.05.01.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 01:26:26 -0700 (PDT)
Message-ID: <7125d734bdf73708aae9f431fb5d18b1699499a5.camel@redhat.com>
Subject: Re: [PATCH net v3] team: fix null-ptr-deref when team device type
 is changed
From: Paolo Abeni <pabeni@redhat.com>
To: Ziyang Xuan <william.xuanziyang@huawei.com>, jiri@resnulli.us, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org,  liuhangbin@gmail.com
Cc: linux-kernel@vger.kernel.org
Date: Tue, 05 Sep 2023 10:26:25 +0200
In-Reply-To: <20230905081056.3365013-1-william.xuanziyang@huawei.com>
References: <20230905081056.3365013-1-william.xuanziyang@huawei.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, 2023-09-05 at 16:10 +0800, Ziyang Xuan wrote:
> Get a null-ptr-deref bug as follows with reproducer [1].
>=20
> BUG: kernel NULL pointer dereference, address: 0000000000000228
> ...
> RIP: 0010:vlan_dev_hard_header+0x35/0x140 [8021q]
> ...
> Call Trace:
>  <TASK>
>  ? __die+0x24/0x70
>  ? page_fault_oops+0x82/0x150
>  ? exc_page_fault+0x69/0x150
>  ? asm_exc_page_fault+0x26/0x30
>  ? vlan_dev_hard_header+0x35/0x140 [8021q]
>  ? vlan_dev_hard_header+0x8e/0x140 [8021q]
>  neigh_connected_output+0xb2/0x100
>  ip6_finish_output2+0x1cb/0x520
>  ? nf_hook_slow+0x43/0xc0
>  ? ip6_mtu+0x46/0x80
>  ip6_finish_output+0x2a/0xb0
>  mld_sendpack+0x18f/0x250
>  mld_ifc_work+0x39/0x160
>  process_one_work+0x1e6/0x3f0
>  worker_thread+0x4d/0x2f0
>  ? __pfx_worker_thread+0x10/0x10
>  kthread+0xe5/0x120
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork+0x34/0x50
>  ? __pfx_kthread+0x10/0x10
>  ret_from_fork_asm+0x1b/0x30
>=20
> [1]
> $ teamd -t team0 -d -c '{"runner": {"name": "loadbalance"}}'
> $ ip link add name t-dummy type dummy
> $ ip link add link t-dummy name t-dummy.100 type vlan id 100
> $ ip link add name t-nlmon type nlmon
> $ ip link set t-nlmon master team0
> $ ip link set t-nlmon nomaster
> $ ip link set t-dummy up
> $ ip link set team0 up
> $ ip link set t-dummy.100 down
> $ ip link set t-dummy.100 master team0
>=20
> When enslave a vlan device to team device and team device type is changed
> from non-ether to ether, header_ops of team device is changed to
> vlan_header_ops. That is incorrect and will trigger null-ptr-deref
> for vlan->real_dev in vlan_dev_hard_header() because team device is not
> a vlan device.
>=20
> Assign eth_header_ops to header_ops of team device when its type is chang=
ed
> from non-ether to ether to fix the bug.
>=20
> Fixes: 1d76efe1577b ("team: add support for non-ethernet devices")
> Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>

I'm sorry to note that this submission does not fit our process:

https://elixir.bootlin.com/linux/latest/source/Documentation/process/mainta=
iner-netdev.rst#L353

this specific kind of process violations tend to make reviewers quite
unhappy, please be more careful.

Regards,

Paolo


