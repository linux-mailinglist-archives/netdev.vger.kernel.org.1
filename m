Return-Path: <netdev+bounces-23633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 509FA76CCBD
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 14:34:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886ED281E16
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 12:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FDB563B1;
	Wed,  2 Aug 2023 12:34:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F09B5695
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 12:34:24 +0000 (UTC)
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBC12718
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 05:34:20 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 52EA05C01AB;
	Wed,  2 Aug 2023 08:34:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 02 Aug 2023 08:34:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690979660; x=1691066060; bh=GBAh4sgmT3c2Z
	1CoBW0ypuK2rd6hQQSPee33aUv8Et8=; b=fyOMs6nFZ8XdExcfYeIBZcGQbWnbU
	VD325UUGKS5T0A641hE2aCWhp8lhDa3epOxZEfL7fQLfSizDGRid7bMtKEpefJKT
	AqJQzIMu17c11Q/zTU4TViLxaSzbPMgs1oD1TIk3pVsfDhLPeoiKuQQZcZx/b7sV
	31JSpBAyyNxL3AdzSRwduAdrgs+MbRBV6liZMM0nI7KnCT/aDcFSTefScIA9qG2P
	AMeo1QsmFdiHB6SdMPKDL0gzika/dc4qlZ7tfuTTZEyIOmFu5EauouHbW1qILCQO
	QK+EnI6Lh+VqO4Stz0nm78JTLLK7xVkJVyRhI7X9QS9UYlzBBdX1gO5IQ==
X-ME-Sender: <xms:S03KZFfzjzrj5z1yEXmJaCneKR8WIdoxYF6Rvczebn_EqZipHah5TQ>
    <xme:S03KZDPiFFLyc7wczv52mUaXuSnq56CdAN6XDKGagfAVZVEuJmTPetcbDWvlGY_YF
    mUFJC6iZBvN4PI>
X-ME-Received: <xmr:S03KZOh5gm4fNXr71JcVkIWMs_LtPcHqbVhw2Axo47Va1mdI4ftorL2bSat8tYxmdcdG54Y06Wg12ggQKIYf6EF7JxyrZA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeekgdehgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:S03KZO_D1x17d8NSsLIQLL2XW6klUyKdgqLrXr0Jq4JkuyXtiDPRFA>
    <xmx:S03KZBvrfq3ugkBdkm1NQuFC1Tueq0MCbNM0l-N0ze9GAYP9UF8bEA>
    <xmx:S03KZNH4Do4Ao4K1J2IrAKZW6aEfj_Lq1pdhdgy-VePLn1Xa6zrlHQ>
    <xmx:TE3KZJJHVUdw_N0Z3Nbnb7RQ1awkF-NM8VSSau86c5e5GXN8-H4BIg>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Aug 2023 08:34:19 -0400 (EDT)
Date: Wed, 2 Aug 2023 15:34:15 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Petr Machata <petrm@nvidia.com>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	dsahern@gmail.com, stephen@networkplumber.org, razor@blackwall.org
Subject: Re: [PATCH iproute2-next] bridge: Add backup nexthop ID support
Message-ID: <ZMpNRzXKIS7ZzSVN@shredder>
References: <20230801152138.132719-1-idosch@nvidia.com>
 <87sf91enuf.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sf91enuf.fsf@nvidia.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 11:55:26AM +0200, Petr Machata wrote:
> 
> Ido Schimmel <idosch@nvidia.com> writes:
> 
> > diff --git a/bridge/link.c b/bridge/link.c
> > index b35429866f52..c7ee5e760c08 100644
> > --- a/bridge/link.c
> > +++ b/bridge/link.c
> > @@ -186,6 +186,10 @@ static void print_protinfo(FILE *fp, struct rtattr *attr)
> >  				     ll_index_to_name(ifidx));
> >  		}
> >  
> > +		if (prtb[IFLA_BRPORT_BACKUP_NHID])
> > +			print_uint(PRINT_ANY, "backup_nhid", "backup_nhid %u ",
> > +				   rta_getattr_u32(prtb[IFLA_BRPORT_BACKUP_NHID]));
> > +
> 
> This doesn't build on current main. I think we usually send the relevant
> header sync patch, but maybe there's an assumption the maintainer pushes
> it _before_ this patch? I'm not sure, just calling it out.

Not needed. David syncs the headers himself.

> 
> >  		if (prtb[IFLA_BRPORT_ISOLATED])
> >  			print_on_off(PRINT_ANY, "isolated", "isolated %s ",
> >  				     rta_getattr_u8(prtb[IFLA_BRPORT_ISOLATED]));
> > @@ -311,6 +315,7 @@ static void usage(void)
> >  		"                               [ mab {on | off} ]\n"
> >  		"                               [ hwmode {vepa | veb} ]\n"
> >  		"                               [ backup_port DEVICE ] [ nobackup_port ]\n"
> > +		"                               [ backup_nhid NHID ]\n"
> 
> I thought about whether there should be "nobackup_nhid", but no. The
> corresponding nobackup_port is necessary because it would be awkward to
> specify "backup_port ''" or something. No such issue with NHID.
> 
> >  		"                               [ self ] [ master ]\n"
> >  		"       bridge link show [dev DEV]\n");
> >  	exit(-1);
> > @@ -330,6 +335,7 @@ static int brlink_modify(int argc, char **argv)
> >  	};
> >  	char *d = NULL;
> >  	int backup_port_idx = -1;
> > +	__s32 backup_nhid = -1;
> >  	__s8 neigh_suppress = -1;
> >  	__s8 neigh_vlan_suppress = -1;
> >  	__s8 learning = -1;
> > @@ -493,6 +499,10 @@ static int brlink_modify(int argc, char **argv)
> >  			}
> >  		} else if (strcmp(*argv, "nobackup_port") == 0) {
> >  			backup_port_idx = 0;
> > +		} else if (strcmp(*argv, "backup_nhid") == 0) {
> > +			NEXT_ARG();
> > +			if (get_s32(&backup_nhid, *argv, 0))
> > +				invarg("invalid backup_nhid", *argv);
> 
> Not sure about that s32. NHID's are unsigned in general. I can add a
> NHID of 0xffffffff just fine:
> 
> # ip nexthop add id 0xffffffff via 192.0.2.3 dev Xd
> 
> (Though ip nexthop show then loops endlessly probably because -1 is used
> as a sentinel in the dump code. Oops!)
> 
> IMHO the tool should allow configuring this. You allow full u32 range
> for the "ip" tool, no need for "bridge" to be arbitrarily limited.

What about the diff below?

diff --git a/bridge/link.c b/bridge/link.c
index c7ee5e760c08..4bf806c5be61 100644
--- a/bridge/link.c
+++ b/bridge/link.c
@@ -334,8 +334,9 @@ static int brlink_modify(int argc, char **argv)
                .ifm.ifi_family = PF_BRIDGE,
        };
        char *d = NULL;
+       bool backup_nhid_set = false;
+       __u32 backup_nhid;
        int backup_port_idx = -1;
-       __s32 backup_nhid = -1;
        __s8 neigh_suppress = -1;
        __s8 neigh_vlan_suppress = -1;
        __s8 learning = -1;
@@ -501,8 +502,9 @@ static int brlink_modify(int argc, char **argv)
                        backup_port_idx = 0;
                } else if (strcmp(*argv, "backup_nhid") == 0) {
                        NEXT_ARG();
-                       if (get_s32(&backup_nhid, *argv, 0))
+                       if (get_u32(&backup_nhid, *argv, 0))
                                invarg("invalid backup_nhid", *argv);
+                       backup_nhid_set = true;
                } else {
                        usage();
                }
@@ -589,7 +591,7 @@ static int brlink_modify(int argc, char **argv)
                addattr32(&req.n, sizeof(req), IFLA_BRPORT_BACKUP_PORT,
                          backup_port_idx);
 
-       if (backup_nhid != -1)
+       if (backup_nhid_set)
                addattr32(&req.n, sizeof(req), IFLA_BRPORT_BACKUP_NHID,
                          backup_nhid);

