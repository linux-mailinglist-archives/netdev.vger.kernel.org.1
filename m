Return-Path: <netdev+bounces-17172-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3D21750B63
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 16:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D42831C21138
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 14:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B3392773D;
	Wed, 12 Jul 2023 14:48:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCFE27700
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 14:48:28 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CB871BF3
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 07:48:25 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 789F45C0068;
	Wed, 12 Jul 2023 10:48:24 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 12 Jul 2023 10:48:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm2; t=1689173304; x=1689259704; bh=dDGB6dk3gveHu
	vxXP5ggp8ZAFoaeoltwyPWmhEfJpaQ=; b=h6TA0lx6uUC0QidHKNG3uLRNXI+Xe
	ggO01FzNFrXwpAEORttpEYlqIME3ANVI7BaixFC7BcGTauCjmYzhzgW7lXnpldqK
	NsinlvILHxMb6MrBCUUBPOA7CoEKEvGbNbOx3Uy7Pm4K8AUMHkH2lEjhRroMpEXd
	DHrBYNNrD9NTKfPsJbLjxEJF3s/mzH8AiQ7z/u4gRiJjXf0Ef2h+XGxWOKam0kTY
	0/Zqjnrlj7/oPL4w8VuHuYlfx2tB+cG1AhUuQTIkmIpJMOGPCRHs4sebw6S3A34P
	jGu6vBSp0ZaGV6DOv19cLxUgie0EkmPNjeDCmXPOrusF69rqRmCELtQbQ==
X-ME-Sender: <xms:N72uZJX9IvaM6bTjf2WVi_8-jBQhrscqKVGZk6CgFh-aHTvJEAMA7w>
    <xme:N72uZJnyC4AUOJa_FtjeNNr1chLjCEuRP2Uj-InBCSrhhPK0nnGs3tVDf8GV37TKO
    X_38ynlv3xgkBE>
X-ME-Received: <xmr:N72uZFYZeItwSlOg1MyMV3ssOOS5v4RIO1sBJVkvexmsnbhsqUMmDI_3NxwADhXB3SXtdM8ABCG0XoHA-HvYst2jjms>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrfedvgdekudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpeehhfdtjedviefffeduuddvffegteeiieeguefgudffvdfftdefheeijedthfej
    keenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepihguohhstghhsehiughoshgthhdrohhrgh
X-ME-Proxy: <xmx:N72uZMV5EX3AbSPXGCF8kChCYXDIUwFiBleftS80aHa5zir1sIJFyw>
    <xmx:N72uZDmbt0eFqQGxgTEDppqzinFJ3LIww9XR8hWlJXzXuFErfvHNEQ>
    <xmx:N72uZJfpFIY3h2yTq8L-nY_c4L9aErO2ePUEcwHiU4tbKYJxmR1Ifw>
    <xmx:OL2uZMiVvA79fr_1jFmmU0tmloK5iPW2YrtpqLZkvLGXlokBgtxHKQ>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Jul 2023 10:48:22 -0400 (EDT)
Date: Wed, 12 Jul 2023 17:48:20 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: Roopa Prabhu <roopa@nvidia.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	bridge@lists.linux-foundation.org,
	Harry Coin <hcoin@quietfountain.com>
Subject: Re: [PATCH v1 net] bridge: Return an error when enabling STP in
 netns.
Message-ID: <ZK69NDM60+N0TTFh@shredder>
References: <20230711235415.92166-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230711235415.92166-1-kuniyu@amazon.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Tue, Jul 11, 2023 at 04:54:15PM -0700, Kuniyuki Iwashima wrote:
> When we create an L2 loop on a bridge in netns, we will see packets storm
> even if STP is enabled.
> 
>   # unshare -n
>   # ip link add br0 type bridge
>   # ip link add veth0 type veth peer name veth1
>   # ip link set veth0 master br0 up
>   # ip link set veth1 master br0 up
>   # ip link set br0 type bridge stp_state 1
>   # ip link set br0 up
>   # sleep 30
>   # ip -s link show br0
>   2: br0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc noqueue state UP mode DEFAULT group default qlen 1000
>       link/ether b6:61:98:1c:1c:b5 brd ff:ff:ff:ff:ff:ff
>       RX: bytes  packets  errors  dropped missed  mcast
>       956553768  12861249 0       0       0       12861249  <-. Keep
>       TX: bytes  packets  errors  dropped carrier collsns     |  increasing
>       1027834    11951    0       0       0       0         <-'   rapidly
> 
> This is because llc_rcv() drops all packets in non-root netns and BPDU
> is dropped.
> 
> Let's show an error when enabling STP in netns.
> 
>   # unshare -n
>   # ip link add br0 type bridge
>   # ip link set br0 type bridge stp_state 1
>   Error: bridge: STP can't be enabled in non-root netns.
> 
> Note this commit will be reverted later when we namespacify the whole LLC
> infra.
> 
> Fixes: e730c15519d0 ("[NET]: Make packet reception network namespace safe")
> Suggested-by: Harry Coin <hcoin@quietfountain.com>

I'm not sure that's accurate. I read his response in the link below and
he says "I'd rather be warned than blocked" and "But better warned and
awaiting a fix than blocked", which I agree with. The patch has the
potential to cause a lot of regressions, but without actually fixing the
problem.

How about simply removing the error [1]? Since iproute2 commit
844c37b42373 ("libnetlink: Handle extack messages for non-error case"),
it can print extack warnings and not only errors. With the diff below:

 # unshare -n 
 # ip link add name br0 type bridge
 # ip link set dev br0 type bridge stp_state 1
 Warning: bridge: STP can't be enabled in non-root netns.
 # echo $?
 0

[1]
diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
index a807996ac56b..b5143de37938 100644
--- a/net/bridge/br_stp_if.c
+++ b/net/bridge/br_stp_if.c
@@ -201,10 +201,8 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
 {
        ASSERT_RTNL();
 
-       if (!net_eq(dev_net(br->dev), &init_net)) {
+       if (!net_eq(dev_net(br->dev), &init_net))
                NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
-               return -EINVAL;
-       }
 
        if (br_mrp_enabled(br)) {
                NL_SET_ERR_MSG_MOD(extack,

> Link: https://lore.kernel.org/netdev/0f531295-e289-022d-5add-5ceffa0df9bc@quietfountain.com/
> Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> ---
>  net/bridge/br_stp_if.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/net/bridge/br_stp_if.c b/net/bridge/br_stp_if.c
> index 75204d36d7f9..a807996ac56b 100644
> --- a/net/bridge/br_stp_if.c
> +++ b/net/bridge/br_stp_if.c
> @@ -201,6 +201,11 @@ int br_stp_set_enabled(struct net_bridge *br, unsigned long val,
>  {
>  	ASSERT_RTNL();
>  
> +	if (!net_eq(dev_net(br->dev), &init_net)) {
> +		NL_SET_ERR_MSG_MOD(extack, "STP can't be enabled in non-root netns");
> +		return -EINVAL;
> +	}
> +
>  	if (br_mrp_enabled(br)) {
>  		NL_SET_ERR_MSG_MOD(extack,
>  				   "STP can't be enabled if MRP is already enabled");
> -- 
> 2.30.2
> 
> 

