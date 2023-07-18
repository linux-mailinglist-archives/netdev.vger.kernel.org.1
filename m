Return-Path: <netdev+bounces-18619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC15757FEE
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 16:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4231C1C20D61
	for <lists+netdev@lfdr.de>; Tue, 18 Jul 2023 14:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D01C2FC0D;
	Tue, 18 Jul 2023 14:44:07 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF5F7FBEE
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 14:44:07 +0000 (UTC)
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E661FD
	for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 07:43:55 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-77acb04309dso337934639f.2
        for <netdev@vger.kernel.org>; Tue, 18 Jul 2023 07:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689691435; x=1692283435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WkA8iv3CYThQxjd8x8fTK5A99pwizqwWrMrleQNWwvI=;
        b=O9RGJcwoKltM4nGF/7Epc1Zm0V4Ob8dijXngW6dyVqoOYqo0qIkf/fMAyz3yJZAG5I
         RxyeV3CB/gi+HXeJ/OaUbJU2ftUYoGiq3qfzLTCG2+LpsZxc7IUWS9wx9uv48ANOytXX
         QL/lpL5LPQ7vGXFCF1EJ/9iIt8dizpOPwJTH/BODl9PJ5iYhv1aoh++QPbepTCeAyiyb
         BzjidVFBbNfJWpDW64U3LRux9eJrukpu34bmIeNWl+Ha7tTPE0W9f6akOqPq+xdf7wWm
         5pdHQp7tUJP9UsT9IX2WHn1Xjuu53LiSTNE2vDZo7/P7wyp8qsBLvHbAvhlMbdndsM3r
         Q05Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689691435; x=1692283435;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WkA8iv3CYThQxjd8x8fTK5A99pwizqwWrMrleQNWwvI=;
        b=VdeZGMKSQv5pIffFyL6xTqll7E7KQiF5r/fms3Dv5ry9CbPiT2215bZbmslSWqcDos
         KkaraqZ9kNPGtfFUnd1QS4TrL2PtdadIEo29ai4RWyspdBDsuj2nbo6ZsBJVd7h/mHy3
         d2Vg2EdVebG0Z75M8dJELre8M1Nzr897ig9svMCCPTzm3DVa8Pvqt0khM3gBp1iaS/Zr
         TkVk4yY/icaNwmmXq4SiSSm+hp5FYEHipZDFrltpSKe90F6wGB9zWj/XX4zvGqVsk2Lc
         vvpqAWgOceEnhErDZM4ud72HjUlJzGLihv2m2AZHOPXjAY4IGMOeF5IkAmA4FrkBbEHk
         bbTQ==
X-Gm-Message-State: ABy/qLbuFTPRcmHOdjwSlUnbXrJvLNPQV9XMaTAIXXtV8scGsCkQKZTm
	hXeZ3FKXASyRBtpH51K3Rdo=
X-Google-Smtp-Source: APBJJlG06weYCcLzUAdvgeIirmKv/qZp9GFLIj21hwOgxWrWDGsancEy+B8JgufHP6W/wd3Hu/mhHw==
X-Received: by 2002:a5e:a80a:0:b0:783:6eef:1496 with SMTP id c10-20020a5ea80a000000b007836eef1496mr3138284ioa.19.1689691434652;
        Tue, 18 Jul 2023 07:43:54 -0700 (PDT)
Received: from ?IPV6:2601:282:800:7ed0:bd1d:fe8d:d220:8378? ([2601:282:800:7ed0:bd1d:fe8d:d220:8378])
        by smtp.googlemail.com with ESMTPSA id d19-20020a056602185300b007836a9ca101sm658710ioi.22.2023.07.18.07.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jul 2023 07:43:54 -0700 (PDT)
Message-ID: <085e4f7c-8725-b0e8-e1ec-1b948c2df987@gmail.com>
Date: Tue, 18 Jul 2023 08:43:53 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v2 0/4] Add backup nexthop ID support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, razor@blackwall.org, roopa@nvidia.com,
 petrm@nvidia.com, taspelund@nvidia.com
References: <20230717081229.81917-1-idosch@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20230717081229.81917-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/17/23 2:12 AM, Ido Schimmel wrote:
> tl;dr
> =====
> 
> This patchset adds a new bridge port attribute specifying the nexthop
> object ID to attach to a redirected skb as tunnel metadata. The ID is
> used by the VXLAN driver to choose the target VTEP for the skb. This is
> useful for EVPN multi-homing, where we want to redirect local
> (intra-rack) traffic upon carrier loss through one of the other VTEPs
> (ES peers) connected to the target host.
> 
> Background
> ==========
> 
> In a typical EVPN multi-homing setup each host is multi-homed using a
> set of links called ES (Ethernet Segment, i.e., LAG) to multiple leaf
> switches in a rack. These switches act as VTEPs and are not directly
> connected (as opposed to MLAG), but can communicate with each other (as
> well as with VTEPs in remote racks) via spine switches over L3.
> 
> The control plane uses Type 1 routes [1] to create a mapping between an
> ES and VTEPs where the ES has active links. In addition, the control
> plane uses Type 2 routes [2] to create a mapping between {MAC, VLAN} and
> an ES.
> 
> These tables are then used by the control plane to instruct VTEPs how to
> reach remote hosts. For example, assuming {MAC X, VLAN Y} is accessible
> via ES1 and this ES has active links to VTEP1 and VTEP2. The control
> plane will program the following entries to a remote VTEP:
> 
>  # ip nexthop add id 1 via $VTEP1_IP fdb
>  # ip nexthop add id 2 via $VTEP2_IP fdb
>  # ip nexthop add id 10 group 1/2 fdb
>  # bridge fdb add $MAC_X dev vx0 master extern_learn vlan $VLAN_Y
>  # bridge fdb add $MAC_Y dev vx0 self extern_learn nhid 10 src_vni $VNI_Y
> 
> Remote traffic towards the host will be load balanced between VTEP1 and
> VTEP2. If the control plane notices a carrier loss on the ES1 link
> connected to VTEP1, it will issue a Type 1 route withdraw, prompting
> remote VTEPs to remove the effected nexthop from the group:
> 
>  # ip nexthop replace id 10 group 2 fdb
> 
> Motivation
> ==========
> 
> While remote traffic can be redirected to a VTEP with an active ES link
> by withdrawing a Type 1 route, the same is not true for local traffic. A
> host that is multi-homed to VTEP1 and VTEP2 via another ES (e.g., ES2)
> will send its traffic to {MAC X, VLAN Y} via one of these two switches,
> according to its LAG hash algorithm which is not under our control. If
> the traffic arrives at VTEP1 - which no longer has an active ES1 link -
> it will be dropped due to the carrier loss.
> 
> In MLAG setups, the above problem is solved by redirecting the traffic
> through the peer link upon carrier loss. This is achieved by defining
> the peer link as the backup port of the host facing bond. For example:
> 
>  # bridge link set dev bond0 backup_port bond_peer
> 
> Unlike MLAG, there is no peer link between the leaf switches in EVPN.
> Instead, upon carrier loss, local traffic should be redirected through
> one of the active ES peers. This can be achieved by defining the VXLAN
> port as the backup port of the host facing bonds. For example:
> 
>  # bridge link set dev es1_bond backup_port vx0
> 
> However, the VXLAN driver is not programmed with FDB entries for locally
> attached hosts and therefore does not know to which VTEP to redirect the
> traffic to. This will result in the traffic being replicated to all the
> VTEPs (potentially hundreds) in the network and each VTEP dropping the
> traffic, except for the active ES peer.
> 
> Avoiding the flooding by programming local FDB entries in the VXLAN
> driver is not a viable solution as it requires to significantly increase
> the number of programmed FDB entries.
> 
> Implementation
> ==============
> 
> The proposed solution is to create an FDB nexthop group for each ES with
> the IP addresses of the active ES peers and set this ID as the backup
> nexthop ID (new bridge port attribute) of the ES link. For example, on
> VTEP1:
> 
>  # ip nexthop add id 1 via $VTEP2_IP fdb
>  # ip nexthop add id 10 group 1 fdb
>  # bridge link set dev es1_bond backup_nhid 10
>  # bridge link set dev es1_bond backup_port vx0
> 
> When the ES link loses its carrier, traffic will be redirected to the
> VXLAN port, but instead of only attaching the tunnel ID (i.e., VNI) as
> tunnel metadata to the skb, the backup nexthop ID will be attached as
> well. The VXLAN driver will then use this information to forward the skb
> via the nexthop object associated with the ID, as if the skb hit an FDB
> entry associated with this ID.
> 
> Testing
> =======
> 
> A test for both the existing backup port attribute as well as the new
> backup nexthop ID attribute is added in patch #4.
> 
> Patchset overview
> =================
> 
> Patch #1 extends the tunnel key structure with the new nexthop ID field.
> 
> Patch #2 uses the new field in the VXLAN driver to forward packets via
> the specified nexthop ID.
> 
> Patch #3 adds the new backup nexthop ID bridge port attribute and
> adjusts the bridge driver to attach the ID as tunnel metadata upon
> redirection.
> 
> Patch #4 adds a selftest.
> 
> iproute2 patches can be found here [3].
> 
> Changelog
> =========
> 
> Since RFC [4]:
> 
> * Added Nik's tags.
> 
> [1] https://datatracker.ietf.org/doc/html/rfc7432#section-7.1
> [2] https://datatracker.ietf.org/doc/html/rfc7432#section-7.2
> [3] https://github.com/idosch/iproute2/tree/submit/backup_nhid_v1
> [4] https://lore.kernel.org/netdev/20230713070925.3955850-1-idosch@nvidia.com/
> 
> Ido Schimmel (4):
>   ip_tunnels: Add nexthop ID field to ip_tunnel_key
>   vxlan: Add support for nexthop ID metadata
>   bridge: Add backup nexthop ID support
>   selftests: net: Add bridge backup port and backup nexthop ID test
> 
>  drivers/net/vxlan/vxlan_core.c                |  44 +
>  include/net/ip_tunnels.h                      |   1 +
>  include/uapi/linux/if_link.h                  |   1 +
>  net/bridge/br_forward.c                       |   1 +
>  net/bridge/br_netlink.c                       |  12 +
>  net/bridge/br_private.h                       |   3 +
>  net/bridge/br_vlan_tunnel.c                   |  15 +
>  net/core/rtnetlink.c                          |   2 +-
>  tools/testing/selftests/net/Makefile          |   1 +
>  .../selftests/net/test_bridge_backup_port.sh  | 759 ++++++++++++++++++
>  10 files changed, 838 insertions(+), 1 deletion(-)
>  create mode 100755 tools/testing/selftests/net/test_bridge_backup_port.sh
> 

For the series:
Acked-by: David Ahern <dsahern@kernel.org>


