Return-Path: <netdev+bounces-27087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C8577A570
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 09:40:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70C83280F17
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 07:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51E9F1846;
	Sun, 13 Aug 2023 07:40:01 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B3F17C5
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 07:40:01 +0000 (UTC)
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3999B
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 00:39:59 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailout.west.internal (Postfix) with ESMTP id 52A8532007BE;
	Sun, 13 Aug 2023 03:39:58 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sun, 13 Aug 2023 03:39:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1691912397; x=1691998797; bh=noNeEVBB96Axp
	uJchOoxUm1gw8GHDnOuRy1i+xHgXV8=; b=gYvgnXnPGlR8+Nuh/9dmyEcUc8WF5
	ziNVUmtc+yudRM6ZR4qCG0dlg/UiUSJ9TPuGCybN4qjwCYoSMLhVG4jtbmecQ4Xx
	rj9Bji+zIMZW+8QXDbUnh96yvUDb71ThSBBSS/qVRm2V727zmnUtEZSKSWZoTkJ9
	4WoPBuhU+rN+AxgOT6CGupvycC/MYDZ9+XH7F50g1nR2in87I2cGJZcl/Annhxd1
	TDHp4B5VYnCtv8jswmjyYGKFe8wfJUaFYwXpaKs+9SpTnVdT+Mb+chQj0+0Sr4QU
	ZZtNh8ntxNPlISORaTHn73cfL3m1u9uM2zZGYybq+outFyjP5yetmxVkw==
X-ME-Sender: <xms:zYjYZAFq_56K8e7rxKyGMSyUDVtjBWishVHkZFJfSZJFFjaEVXQo0g>
    <xme:zYjYZJUk3wqV6KMoFsp3JMpmW0Y4qAP_5eC4xoOm-DZgq-Abk4df7YMZvVklOvi4E
    iX8inkNNWdQZWw>
X-ME-Received: <xmr:zYjYZKLJnAKM24ruycAi76YHJ0wvyLuxnAKD0EHQxsSo8x0Hg9YQ7DipqP5B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddtuddguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkugho
    ucfutghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrg
    htthgvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefgudffvdfftdefheeijedt
    hfejkeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhr
    gh
X-ME-Proxy: <xmx:zYjYZCHSJJyXLRuFfK18EZV2un6zunIV64IMip1u-lOk8jRCZqGFRA>
    <xmx:zYjYZGXiJiHen9cRHLhc58YoaAibQ5GpPIXa3Cn5GDAE3Drb4YaiwQ>
    <xmx:zYjYZFO_99i599HGixRTNmtP1BFruVA5RP4raG-ZjeVurXJ2ihMvCw>
    <xmx:zYjYZPPXzr4Vo6Mt-0tiFcEUub76GWPudH4vHu6Gydo6CRRo5F877A>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Aug 2023 03:39:56 -0400 (EDT)
Date: Sun, 13 Aug 2023 10:39:54 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Vlad Buslov <vladbu@nvidia.com>
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, netdev@vger.kernel.org, amir.hanania@intel.com,
	jeffrey.t.kirsher@intel.com, john.fastabend@gmail.com,
	horms@kernel.org,
	syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com,
	syzbot+4b4f06495414e92701d5@syzkaller.appspotmail.com,
	syzbot+d810d3cd45ed1848c3f7@syzkaller.appspotmail.com
Subject: Re: [PATCH net] Revert "vlan: Fix VLAN 0 memory leak"
Message-ID: <ZNiIyjStj71S5/Rs@shredder>
References: <20230811154523.1877590-1-vladbu@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811154523.1877590-1-vladbu@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Aug 11, 2023 at 05:45:23PM +0200, Vlad Buslov wrote:
> This reverts commit 718cb09aaa6fa78cc8124e9517efbc6c92665384.
> 
> The commit triggers multiple syzbot issues, probably due to possibility of
> manually creating VLAN 0 on netdevice which will cause the code to delete
> it since it can't distinguish such VLAN from implicit VLAN 0 automatically
> created for devices with NETIF_F_HW_VLAN_CTAG_FILTER feature.
> 
> Reported-by: syzbot+662f783a5cdf3add2719@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/00000000000090196d0602a6167d@google.com/
> Reported-by: syzbot+4b4f06495414e92701d5@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/00000000000096ae870602a61602@google.com/
> Reported-by: syzbot+d810d3cd45ed1848c3f7@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/0000000000009f0f9c0602a616ce@google.com/
> Fixes: 718cb09aaa6f ("vlan: Fix VLAN 0 memory leak")
> Signed-off-by: Vlad Buslov <vladbu@nvidia.com>

Reviewed-by: Ido Schimmel <idosch@nvidia.com>

