Return-Path: <netdev+bounces-23569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C008C76C86E
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 10:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 811381C21288
	for <lists+netdev@lfdr.de>; Wed,  2 Aug 2023 08:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38B6C187A;
	Wed,  2 Aug 2023 08:37:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A47B1869
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 08:37:49 +0000 (UTC)
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B020A0
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 01:37:48 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id ACCCA5C004F;
	Wed,  2 Aug 2023 04:37:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 02 Aug 2023 04:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1690965465; x=1691051865; bh=GEP5asmFNwXuc
	9kqiIfHZNbsB9k++vxpnuzesbBBLs8=; b=o7y2ynbGFc8JjcbD/rCZoZCYzTJJ0
	ZiOB6hsTDnXGBuaoMvj+RzI2uufNMTtR3ANi2fnkPIdA5ZnH2GDbtLrgb1xe/5g1
	rb6C1wzGC9/Onao9/e6pi6SXbJVDdJAZnBVvoj5+aDu93TaIiRS8OECDESSCHGPD
	tAbMl0T0+EAXbYyDlXFfSvBqUHDcIfD+M160CorlW/bT4Ba6b8M6ZMJYTEGLmJ88
	XDNRUN8aePIzYiGDPBULQ2l0ux6WlNWw1f4WazUse3YppJ0iV1XmNPp5PLwytrHo
	zDL20Wu9bjy5wgC//tt3yd+ALd16pHpM2NQ5wSYwhy9RuXLkHM+ERFywg==
X-ME-Sender: <xms:2RXKZN3zwdeDAK4K0LGKZ9h04EeA3lWvdGDAYP95NeFrjdJp_1WwMw>
    <xme:2RXKZEF_X9yHmx2wmAKmRazR5NKCSoFYqpzI1n4YVEUBMutzyCXqSLPuLX0wfpXuP
    n4jWsCkqfap5G4>
X-ME-Received: <xmr:2RXKZN7sSUZ2Hv1bKu5UC4MerMzet6hFlvAWxQo4Vqb6ka6evTFkCa3GsZIt4gnfWmRVZeoyJnHlmL3WMpEYvhENvOT2lw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrjeekgddtiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefkughoucfu
    tghhihhmmhgvlhcuoehiughoshgthhesihguohhstghhrdhorhhgqeenucggtffrrghtth
    gvrhhnpedvudefveekheeugeeftddvveefgfduieefudeifefgleekheegleegjeejgeeg
    hfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehiug
    hoshgthhesihguohhstghhrdhorhhg
X-ME-Proxy: <xmx:2RXKZK261H08VVWO9WnJFtWyJpOx1UfgcRgfUWXkNCRniZyIqkmRhQ>
    <xmx:2RXKZAGuCg13vUHvWOp9leXgOjsGZUEBtkqaFAgpMm7PLkpR95hXbQ>
    <xmx:2RXKZL-Ys-0uKjmvCTXp5pI7K7cB7g9R08KRwe4JO2wYSfrvLkAQ0g>
    <xmx:2RXKZL1bG69U_7nZWxYxuHmfrq-36S3ZerMVDyh3F6agbeOnmokY5w>
Feedback-ID: i494840e7:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Aug 2023 04:37:44 -0400 (EDT)
Date: Wed, 2 Aug 2023 11:37:40 +0300
From: Ido Schimmel <idosch@idosch.org>
To: Davide Caratti <dcaratti@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
	edumazet@google.com, petrm@nvidia.com, razor@blackwall.org,
	mirsad.todorovac@alu.unizg.hr
Subject: Re: [PATCH net 13/17] selftests: forwarding: tc_tunnel_key: Make
 filters more specific
Message-ID: <ZMoV1M7Jm51TPtBZ@shredder>
References: <20230802075118.409395-1-idosch@nvidia.com>
 <20230802075118.409395-14-idosch@nvidia.com>
 <ZMoUPP53JWP7l2pG@dcaratti.users.ipa.redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMoUPP53JWP7l2pG@dcaratti.users.ipa.redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Aug 02, 2023 at 10:30:52AM +0200, Davide Caratti wrote:
> On Wed, Aug 02, 2023 at 10:51:14AM +0300, Ido Schimmel wrote:
> > The test installs filters that match on various IP fragments (e.g., no
> > fragment, first fragment) and expects a certain amount of packets to hit
> > each filter. This is problematic as the filters are not specific enough
> > and can match IP packets (e.g., IGMP) generated by the stack, resulting
> > in failures [1].
> 
> [...]
> 
> > --- a/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
> > +++ b/tools/testing/selftests/net/forwarding/tc_tunnel_key.sh
> > @@ -104,11 +104,14 @@ tunnel_key_nofrag_test()
> >  	local i
> >  
> >  	tc filter add dev $swp1 ingress protocol ip pref 100 handle 100 \
> > -		flower ip_flags nofrag action drop
> > +		flower src_ip 192.0.2.1 dst_ip 192.0.2.2 ip_proto udp \
> > +		ip_flags nofrag action drop
> >  	tc filter add dev $swp1 ingress protocol ip pref 101 handle 101 \
> > -		flower ip_flags firstfrag action drop
> > +		flower src_ip 192.0.2.1 dst_ip 192.0.2.2 ip_proto udp \
> > +		ip_flags firstfrag action drop
> >  	tc filter add dev $swp1 ingress protocol ip pref 102 handle 102 \
> > -		flower ip_flags nofirstfrag action drop
> > +		flower src_ip 192.0.2.1 dst_ip 192.0.2.2 ip_proto udp \
> > +		ip_flags nofirstfrag action drop
> 
> 
> hello Ido, my 2 cents:
> 
> is it safe to match on the UDP protocol without changing the mausezahn
> command line? I see that it's generating generic IP packets at the
> moment (i.e. it does '-t ip'). Maybe it's more robust to change
> the test to generate ICMP and then match on the ICMP protocol?

My understanding of the test is that it's transmitting IP packets on the
VXLAN device and what $swp1 sees are the encapsulated packets (UDP).

