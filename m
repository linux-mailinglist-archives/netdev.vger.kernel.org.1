Return-Path: <netdev+bounces-40936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC417C920A
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 03:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74FBDB20A9D
	for <lists+netdev@lfdr.de>; Sat, 14 Oct 2023 01:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 989297F1;
	Sat, 14 Oct 2023 01:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GTEK2tR5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D6B87E
	for <netdev@vger.kernel.org>; Sat, 14 Oct 2023 01:11:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3032C433C8;
	Sat, 14 Oct 2023 01:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697245913;
	bh=RRr5YyVOA68plwQGD/XThz6FUOndTHow/w4U9d8Z1KQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GTEK2tR5gnpMazKvW+s4J/3h146ObAhmHbbSm7mgZVxDN3PyyBfXLeKUN9B/nvmcg
	 kY/TT9G/obRMivJeYhA77oP5uj0ddwfdtWYBsMtQICjHylwpjQOE+R+XoOc/STJKMi
	 pVPHXW5RaJYguJPb9NbVUelmHy3UNWP0Vc8x45BfkSEADVlmcEncRlbk4mWPRxUFY5
	 R+MVTGzB+H6Gl044zL21FY7q8SyBIxxJK/rbTlMLS49yPgZVJa9iHZOMoDq/Ize/CV
	 05Ry4IqghRq5I2fHofmLP5kX1/tFhwtGWiFW7DnNRjtuulpPj0RlKpu0o8I+kkbUVI
	 Ky+GFPaRxNLvg==
Date: Fri, 13 Oct 2023 18:11:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Heng Qi <hengqi@linux.alibaba.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>, Paolo Abeni <pabeni@redhat.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, Alexei Starovoitov <ast@kernel.org>, Simon
 Horman <horms@kernel.org>, "Liu, Yujie" <yujie.liu@intel.com>
Subject: Re: [PATCH net-next 2/5] virtio-net: separate rx/tx coalescing
 moderation cmds
Message-ID: <20231013181148.3fd252dc@kernel.org>
In-Reply-To: <dc171e2288d2755b1805afde6b394d2d443a134d.1697093455.git.hengqi@linux.alibaba.com>
References: <cover.1697093455.git.hengqi@linux.alibaba.com>
	<dc171e2288d2755b1805afde6b394d2d443a134d.1697093455.git.hengqi@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 12 Oct 2023 15:44:06 +0800 Heng Qi wrote:
> +
> +static int virtnet_send_rx_notf_coal_cmds(struct virtnet_info *vi,
> +					  struct ethtool_coalesce *ec)
> +{
> +	struct scatterlist sgs_rx;
> +

../drivers/net/virtio_net.c: In function =E2=80=98virtnet_send_rx_notf_coal=
_cmds=E2=80=99:
../drivers/net/virtio_net.c:3306:14: error: =E2=80=98i=E2=80=99 undeclared =
(first use in this function); did you mean =E2=80=98vi=E2=80=99?
 3306 |         for (i =3D 0; i < vi->max_queue_pairs; i++) {
      |              ^
      |              vi

