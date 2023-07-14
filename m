Return-Path: <netdev+bounces-17989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F094754017
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 19:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60414281E6E
	for <lists+netdev@lfdr.de>; Fri, 14 Jul 2023 17:01:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5A914AB9;
	Fri, 14 Jul 2023 17:01:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D41A1371C
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 17:01:19 +0000 (UTC)
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E6E35A6
	for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 10:01:18 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id e9e14a558f8ab-345f3e28082so9122735ab.1
        for <netdev@vger.kernel.org>; Fri, 14 Jul 2023 10:01:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689354077; x=1691946077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zsNeqji1XYB0jXHNl1SF54r4WjafGvPzvfwZx0ZnD4A=;
        b=ZTTOIcw1yPG20kHkYiHm4QBfF+RLSm255lGSV6nC1KQlESzSiI9ABxSlYKOfU1fZc2
         QgEXxlQB2nRh6ZsIx43Ck280e2cMoy3xuQXwiolqVmez6FHQFjhzgt/0e2m4joeYtOGE
         07j3fD4gEvdlrHR9xAGVjrhcUYufLK9W/ZS+4wiEiP5urt1WJSPPi7otGg55uGVf9E4l
         xTerY2pSeovFfbYQSkT1JYQAh/yMKRaObMBqjiCQOxQLSdyJvzMwRXAoFjUdGmlWkWsG
         qVElN67xw/O3gcmJohg4Lqj5CDDmY6l0zLoMiHyInZ7XsQQk+sJrR9KB0VHw/8NOQTrg
         FBbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689354077; x=1691946077;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zsNeqji1XYB0jXHNl1SF54r4WjafGvPzvfwZx0ZnD4A=;
        b=BZA9Pi+w9WCvara7iSoPkvtxz460SuIo6d5KrgRJ6UjWysL/fJoFaBi1iyIHLY0lwT
         Crqok+6weiZADoaNZbp50Myvjzej/qXNPa2QQawIu9OuO7lTkjB7dQ5/NBHpm/HSke8g
         BTXra7kURMyv0sr4IpjzRbInEEO0xEzYuOemp5r7gRti7pXdn4szg7px0m2znaG7FZ6/
         iihQu6K5P/D00IKXBYtBKHJu7byeDHHykxmsd1uRuKY1f6bA2VTqVzceyuFEsfPrtMgK
         G9QEy9qNFHg8qFfQHBb56as86SCGQrn/IKNumeX2iknHBcEWoZGUuflbVg/AeI5FJhaW
         0Z/g==
X-Gm-Message-State: ABy/qLb0LWi+m4xVF65G2jfvigoYOfESkVIv0+Xsbed0npPWxprzmk71
	6vVnGYhZLgmpFOzjKs+Iofs=
X-Google-Smtp-Source: APBJJlHBGAMtYTo7sCB6bEXffkS84banNk412fbewLf19gVWsOwi0iSFRxhvJ3Ajyd3ARtytdxIGWw==
X-Received: by 2002:a05:6e02:150:b0:345:e9a4:c6e5 with SMTP id j16-20020a056e02015000b00345e9a4c6e5mr5277724ilr.13.1689354077270;
        Fri, 14 Jul 2023 10:01:17 -0700 (PDT)
Received: from ?IPV6:2601:284:8200:b700:f5e5:d823:5b2:878d? ([2601:284:8200:b700:f5e5:d823:5b2:878d])
        by smtp.googlemail.com with ESMTPSA id m12-20020a924b0c000000b0034587c5533fsm2832952ilg.51.2023.07.14.10.01.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 10:01:16 -0700 (PDT)
Message-ID: <ba91d049-21a1-9cea-a000-a016c753b1a8@gmail.com>
Date: Fri, 14 Jul 2023 11:01:15 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [RFC PATCH net-next 0/4] Add backup nexthop ID support
Content-Language: en-US
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
 bridge@lists.linux-foundation.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@google.com, razor@blackwall.org, roopa@nvidia.com,
 petrm@nvidia.com, taspelund@nvidia.com
References: <20230713070925.3955850-1-idosch@nvidia.com>
From: David Ahern <dsahern@gmail.com>
In-Reply-To: <20230713070925.3955850-1-idosch@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/13/23 1:09 AM, Ido Schimmel wrote:
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
> [1] https://datatracker.ietf.org/doc/html/rfc7432#section-7.1
> [2] https://datatracker.ietf.org/doc/html/rfc7432#section-7.2
> [3] https://github.com/idosch/iproute2/tree/submit/backup_nhid_v1
> 

Looks good to me. Thanks for the detailed cover letter and test coverage


