Return-Path: <netdev+bounces-33114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98EAF79CBDE
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 11:32:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9CE41C209CE
	for <lists+netdev@lfdr.de>; Tue, 12 Sep 2023 09:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AC4816434;
	Tue, 12 Sep 2023 09:32:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8834E8F6D
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 09:32:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id A467A123
	for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1694511138;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fGSoAwqC1LRe7m7wbtUH6OdB455fQg8AH6TJak61tbA=;
	b=CfCbzP7mtUrEU5u6EeD9yaWdQltQ/nxAcN/y8wYdsf5hcs/HpeiyJhZlViu+yFM8+Ob5Ae
	eue3JWq31q15M82E06gfoH3gG2u+D8xpJSuWbBmTom2GRxN5AeTOclYdJo1/N95NtV1ByY
	LAxUyCY07Z+UzZpl4GXRWrvoJtUH4ag=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-eDDX4GtFOcuKssHlsbX8tg-1; Tue, 12 Sep 2023 05:32:17 -0400
X-MC-Unique: eDDX4GtFOcuKssHlsbX8tg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-52f274e64ceso122835a12.1
        for <netdev@vger.kernel.org>; Tue, 12 Sep 2023 02:32:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694511136; x=1695115936;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fGSoAwqC1LRe7m7wbtUH6OdB455fQg8AH6TJak61tbA=;
        b=fVmSTIJkqZ2V13vtaTd+YvUCn7sKQ5b88v5vqYski0BOdUgjC19F28HNpiagr9Suq5
         4uYfzbAK5LlcPcr3pZECDzYpOrxV0bazNwgpnPUJfIpIuQQjAKWXJihIeuGQM90tx0sX
         iEbyLtMrjRQw6BTELT90BJyTPZx7ZzGWELMgbZHWJuk2jX3xik4NsNwCHtTvJXaLc8VZ
         uTxQRH09DpGOFQrM/6DhYxBqroW876LGhxkncFvw4vHgNGV8RU5N/wRAID/DvA/As3rp
         maUsYgPje0+e18rx917HKeyX5zZXdND4nbq3gAvZTy+NH6Jccos4uj5JWTXoma3Gy/j1
         /cXg==
X-Gm-Message-State: AOJu0YzFF1nva3M8eVSdwxQ6ao6A7QMAFlLhRBGNot3b+WHtnQuMsbvW
	mGXhbx/1SzQipvp5tJpRO848MX6N9cFiEaMHR0ZOOH6qk6tLIQedgLpJCaifm3jjtJ+TEnNW8o6
	5EhxmgMcQZHiAN3tq
X-Received: by 2002:a05:6402:5207:b0:523:2e64:122b with SMTP id s7-20020a056402520700b005232e64122bmr9553567edd.3.1694511136407;
        Tue, 12 Sep 2023 02:32:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IErnK7sRHLbsPa3qC4L0vGO/i0EjBkNBfelb/WCPsz67Ny8mHbPirU0Ni6fn2yQCMhWGEJvpw==
X-Received: by 2002:a05:6402:5207:b0:523:2e64:122b with SMTP id s7-20020a056402520700b005232e64122bmr9553552edd.3.1694511136032;
        Tue, 12 Sep 2023 02:32:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-249-231.dyn.eolo.it. [146.241.249.231])
        by smtp.gmail.com with ESMTPSA id i23-20020a0564020f1700b0052f8c67a399sm1348042eda.37.2023.09.12.02.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 02:32:15 -0700 (PDT)
Message-ID: <2910908aeafc8ff133168045ee19f290a7bb35e0.camel@redhat.com>
Subject: Re: [PATCH net v4] team: fix null-ptr-deref when team device type
 is changed
From: Paolo Abeni <pabeni@redhat.com>
To: Ziyang Xuan <william.xuanziyang@huawei.com>, jiri@resnulli.us, 
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 netdev@vger.kernel.org,  leon@kernel.org, ye.xingchen@zte.com.cn,
 liuhangbin@gmail.com
Date: Tue, 12 Sep 2023 11:32:14 +0200
In-Reply-To: <20230911094636.3256542-1-william.xuanziyang@huawei.com>
References: <20230911094636.3256542-1-william.xuanziyang@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2023-09-11 at 17:46 +0800, Ziyang Xuan wrote:
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
> Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
> ---
> v4:
>   - Add Reviewed-by tag.
> v3:
>   - Export eth_header_ops to fix modpost error.
> v2:
>   - Just modify header_ops to eth_header_ops not use ether_setup().
> ---
>  drivers/net/team/team.c | 5 ++++-
>  net/ethernet/eth.c      | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/team/team.c b/drivers/net/team/team.c
> index d3dc22509ea5..12fb5f4cff06 100644
> --- a/drivers/net/team/team.c
> +++ b/drivers/net/team/team.c
> @@ -2127,7 +2127,10 @@ static const struct ethtool_ops team_ethtool_ops =
=3D {
>  static void team_setup_by_port(struct net_device *dev,
>  			       struct net_device *port_dev)
>  {
> -	dev->header_ops	=3D port_dev->header_ops;
> +	if (port_dev->type =3D=3D ARPHRD_ETHER)
> +		dev->header_ops	=3D &eth_header_ops;
> +	else
> +		dev->header_ops	=3D port_dev->header_ops;
>  	dev->type =3D port_dev->type;
>  	dev->hard_header_len =3D port_dev->hard_header_len;
>  	dev->needed_headroom =3D port_dev->needed_headroom;

If I read correctly, for !vlan_hw_offload_capable() lower dev, egress
packets going trough the team device will not contain the vlan tag.=20

Additionally, why is vlan special? Why others lower devices with custom
header_ops do not need any care?=20

Exporting 'eth_header_ops' for team's sake only looks a bit too much to
me. I think could instead cache the header_ops ptr after the initial
ether_setup().

Thanks!

Paolo





